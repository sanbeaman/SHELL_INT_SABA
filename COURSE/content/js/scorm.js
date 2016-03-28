/********************************************************************************************************
 scorm.js
 High-level SCORM interface functions.
 Gary Weinfurther, 9/27/2007
 10/11/2007 - GW: If the SCORM API is not found, uses the cookie API instead.
 02/08/2011 - SCF: added LMSGetObjectiveStatus and commented out some window.status settings
 03/20/2013 - dB: Added isSABA & AlreadyUnloaded variables and LMSUnloadHandler
 08/20/2013 - SCF: Removed isSABA and made use of suspendAll standard - can't hurt on forced exit
 09/11/2013 - SCF: Added debug feedback - assumes scormcookies.js is loaded - deb is defined there
                   Added additional status checking/reload for completion/passed status from objectives
*********************************************************************************************************/
var SCORM_ALERTS = false; // Set this to false to turn user alerts off
var SCORM_TRACE  = false; // Set this to false to turn trace messages off
// Define exception/error codes
var SCORM_ERR_NO_ERROR						 = 0;
var SCORM_ERR_GENERAL_ERROR 			 = 101;
var SCORM_ERR_INITIALIZATION_ERROR = 102;
var SCORM_ERR_ALREADY_INITIALIZED  = 103;
var ScormApi = null;	// The scorm interface object
var usingScormCookies = false; // using cookies mode flag
var ScormIsInitialized = false; // Has SCORM been initialized?
var AlreadyUnloaded = false; // To make sure unload handler doesn't terminate twice
var _numberOfObjectives=-1;
var _objectiveIds=[];
var _pox=-1;
var _cs,_ps,_ocs,_ops;
/*---------------------------------------------------------------
 Initializes communication with LMS by locating the API object
 and calling the API's Initialize method. If the API object is
 not found, the cookie API is used instead.
 Returns true if successful, otherwise false.
----------------------------------------------------------------*/
function LMSInitialize() {
  var success=true;
	if (!(ScormIsInitialized == true && ScormApi != null)) {
  	ScormApi = LMSFindApi();
  	if (ScormApi == null) {
  		ScormApi = new ScormCookies();
      usingScormCookies = true;
  		//alert("SCORM API not found.\nYour progress will saved on your computer, not on the LMS.");
  	}
  	var result = ScormApi.Initialize("");
  	var success = LMSDetermineSuccess(result);
  	if (success)
  		ScormIsInitialized = true;
  	else
  		LMSShowError("Initialize");
  }
  deb("LMSInitialize()="+success);
	return success;
}
/*---------------------------------------------------------------
 Returns true if initialization was successful.
----------------------------------------------------------------*/
function LMSDetermineSuccess(ScormResult) {
	if (ScormResult == "true") return true;
	var lastError = LMSGetLastError();
	if (lastError == SCORM_ERR_ALREADY_INITIALIZED)
		return true;
	return false;
}
/*---------------------------------------------------------------
 Closes communication with LMS.
 Returns true if successful, false if failed.
----------------------------------------------------------------*/
function LMSTerminate() {
	var success = false;
	if (ScormIsInitialized) {
		var result = ScormApi.Terminate("");
		success = (value == "true");
		if (success)
			ScormIsInitialized = false;
		else {
      deb("LMSTerminate()="+success);
			LMSShowError("Terminate");
      return success;
    }
	}
  deb("LMSTerminate()="+success);
	return success;
}
/*---------------------------------------------------------------
 Retrieves a named data element from the LMS.
----------------------------------------------------------------*/
function LMSGetValue(name) {
	var result = "";
	var value = ScormApi.GetValue(name);
	var errorCode = LMSGetLastError();
	if (errorCode == "0")
		result = value;
	else {
  	deb("LMSGetValue("+name+")='"+result+"' - value="+value+" Error:"+errorCode);
		LMSShowError("GetValue(" + name + ") value=[" + value + "]\n");
  }
	deb("LMSGetValue("+name+")='"+result+"'");
	return result;
}
/*---------------------------------------------------------------
 Stores a new value for a named LMS data element.
 Returns true if successful, false if failed.
----------------------------------------------------------------*/
function LMSSetValue(name, value) {
  value=""+value;
	if (value == "null") value = "";
	if (value == "undefined") value = "";
  // adl navigation requests either preface or cause termination
  if (name == "adl.nav.request") {
    // tell the unload handler that we are already terminating
    AlreadyUnloaded = true;
  }
	var result = ScormApi.SetValue(name, value);
	var success = result == "true";
  deb("LMSSetValue("+name+","+value+")="+success);
	if (!success) {
		LMSShowError("SetValue(" + name + "," + value + ")");
  }
	return success;
}
/*---------------------------------------------------------------
 Commits all SCORM values.
 Returns true if successful, false if failed
----------------------------------------------------------------*/
function LMSCommit() {
	var result	= ScormApi.Commit("");
	var success = result == "true";
  deb("LMSCommit()="+success);
	if (!success) {
		LMSShowError("Commit");
  }
	return success;
}
/*---------------------------------------------------------------
 Returns the error code that was set by the last LMS function call.
----------------------------------------------------------------*/
function LMSGetLastError() {
	return ScormApi.GetLastError();
}
/*---------------------------------------------------------------
 Returns the textual description that corresponds to the given
 error code.
----------------------------------------------------------------*/
function LMSGetErrorString(errorCode) {
	return ScormApi.GetErrorString(errorCode).toString();
}
/*---------------------------------------------------------------
 Returns the LMS-specific detailed description that corresponds
 to the input error code.
----------------------------------------------------------------*/
function LMSGetDiagnostic(errorCode) {
	return ScormApi.GetDiagnostic(errorCode).toString();
}
/*-------------------------------------------------------------
 Function LMSShowError()
 Inputs:	None
 Return:	The current value of the LMS Error Code
 Description:
 Determines if an error was encountered by the previous ScormApi
 call and if so, displays a message to the user.	If the error
 code has associated text it is also displayed.
---------------------------------------------------------------*/
function LMSShowError(prefix) {
  var errorCode = LMSGetLastError();
	if (errorCode != "0") {
    var ers=LMSGetErrorString(errorCode);
    var eds=LMSGetDiagnostic(errorCode);
    deb("LMSShowError("+prefix+")='"+ers+"','"+eds+"'");
  	if (SCORM_ALERTS == true) {
			// an error was encountered so display the error description
			var description = "SCORM error " + errorCode + "\n" + ers + "\n" + eds;
			LMSAlert(prefix + ": " + description);
		}
	}
}
/*----------------------------------------------------------------
 Function FindScormApi()
 Inputs:	none
 Return:	If a SCORM API object is found, it is returned,
					otherwise null is returned
 Description:
 Locates the SCORM API object within the browser window hierarchy.
------------------------------------------------------------------*/
function LMSFindApi() {
	var tries  = 100;
	var win = window;
  var api=null;
	while (win != null && --tries > 0) {
		if (win.API_1484_11 != null) {
      api = win.API_1484_11;
      break;
    }
		if (win.parent == null || win.parent == win)
			win = win.opener;
		else win = win.parent;
	}
  deb("LMSFindApi()="+api);
	return api;
}
/*----------------------------------------------------------------
 Function LMSAlert()
 Inputs:	msg : A text message to display
 Return:	nothing
 Description:
 Displays an alert message, but only if SCORM_ALERTS is true.
------------------------------------------------------------------*/
function LMSAlert(msg) {
	if (SCORM_ALERTS)
		alert(msg);
}
/*----------------------------------------------------------------
 Function LMSTrace()
 Inputs:	msg : A text message to display
 Return:	nothing
 Description:
 Displays an alert message, but only if SCORM_TRACE is true.
------------------------------------------------------------------*/
function LMSTrace(msg) {
	window.top.status = msg;
}
// get the number of objectives, cache the objective ids, and determine the primary objective id
function LMSNumberOfObjectives() {
  if (_numberOfObjectives<0) {
    var n=Number(LMSGetValue("cmi.objectives._count"));
    _numberOfObjectives=n?Math.floor(n):0;
    n=_numberOfObjectives; for (var i=0; i<n; i++) {
      var id=LMSGetValue("cmi.objectives."+i+".id");
      _objectiveIds.push(id);
      if (id===""||id==="primary") _pox=i;
    }
  }
  return _numberOfObjectives;
}
// get named objective value by objective index
function LMSGetObjective(ix,name) {
  if (ix<0) return false;
  var n = LMSNumberOfObjectives(); if (n>ix) {
    return LMSGetValue("cmi.objectives."+ix+"."+name);
  }
  return "";
}
// set named objective value by objective index
function LMSSetObjective(ix,name,value) {
  if (ix<0) return false;
  var n = LMSNumberOfObjectives(); if (n>ix) {
    return LMSSetValue("cmi.objectives."+ix+"."+name,value);
  }
  return false;
}
// get and sync sco status, number of objectives, id array, primary objectives references and status
function LMSGetStatus() {
  // get the number of objectives, and initialize the id array, primary objectives references
  var n = LMSNumberOfObjectives();
  // get the sco and primary objectives status
  _cs=LMSGetValue("cmi.completion_status");
  _ps=LMSGetValue("cmi.success_status");
  if (_pox>=0) {
    _ocs=LMSGetObjective(_pox,"completion_status");
    _ops=LMSGetObjective(_pox,"success_status");
  } else {
    _ocs=_cs;
    _ops=_ps;
  }
  // sync the completed/passed local status with the (prior) objective status
  if (_ocs=="completed"||_ops=="passed") {
    if (_cs!="completed") {
      LMSSetValue("cmi.completion_status","completed");
      _cs="completed";
    }
    if (_ps!="passed") {
      LMSSetValue("cmi.success_status","passed");
      _ps="passed";
    }
    if (_ocs!="completed") {
      LMSSetObjective(_pox,"completion_status","completed");
      _ocs="completed";
    }
    if (_ops!="passed") {
      LMSSetObjective(_pox,"success_status","passed");
      _ops="passed";
    }
  }
}
/*---------------------------------------------------------------
 Suspend, Commit, and terminate on browser close
 Closes communication with LMS.
----------------------------------------------------------------*/
function LMSUnloadHandler() {
  deb("LMSUnloadHandler() AlreadyUnloaded="+AlreadyUnloaded+" ScormIsInitialized="+ScormIsInitialized);
	if (!AlreadyUnloaded && ScormIsInitialized) {
    // get/sync the current sco status prior to navigating away
    LMSGetStatus();
    // set the exit mode to normal if the sco has been completed and passed...
		LMSSetValue("cmi.exit", (_cs=="completed"&&_ps=="passed")?"normal":"suspend");
    // if this sco is forcefully exited, either by the menu or by exiting manually, suspend it and perform a suspendAll navigation event
    LMSSetValue("adl.nav.request", "suspendAll");
		AlreadyUnloaded = true;
    LMSTerminate();
	}
}
//
// System Checker test
//
// check to see if the system checker has been run, and try to go to it if not (suspendAll/resumeAll on a different browser)...
if (scorm_GetCookie(systemchecker)!="Y") {
  deb("scorm:System Checker cookie not set");
  // if cookie not found, first check if cookies are supported/enabled before doing this
  if (navigator&&navigator.cookieEnabled) {
    // initialize the LMS (multiple times is ok too)
    if (LMSInitialize()) {
      // check to see if there is a systemchecker to branch to (if using cookies, this will return "")
      if (LMSGetValue("adl.nav.request_valid.choice.{target="+systemchecker+"}")=="true") {
        // get/sync the current sco status prior to navigating away
        LMSGetStatus();
        // set the exit mode to normal if the sco has been completed and passed...
    		LMSSetValue("cmi.exit", (_cs=="completed"&&_ps=="passed")?"normal":"suspend");
        deb("scorm:Navigating to System Checker target="+systemchecker);
        LMSSetValue("adl.nav.request","{target="+systemchecker+"}choice");
        LMSTerminate();
      } else {
        deb("scorm:System Checker target '"+systemchecker+"' does not exist!");
      }
    }
  } else {
    deb("scorm:Cookies are not enabled in the browser");
  }
}
