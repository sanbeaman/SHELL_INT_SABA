package com.wbtmodules.ca.as3 {
	import flash.external.*;

	public dynamic class MYSCORM {
		public static var isComplete:Boolean;

		private static var _isInit:Boolean=false;
		private static var _lastExitStatus:String;
		private static var _scoCompleted:Boolean;
		private static var _numberOfObjectives:int=-1;
		private static var _objectiveIds:Array=[];
		private static var _pox=-1; 		// primary objective index (==-1 if none defined)
		private static var _cs; 				// completion status
		private static var _ps; 				// success/passed status
		private static var _ocs;				// primary objective completion status
		private static var _ops;				// primary objective success/passed status
		private static var _cf:Boolean; // commit required flag (data changed)

		public function MYSCORM() {}

		// initialize the LMS - parameter if true or not present checks and initializes passed/completed/incomplete state of SCO
		public static function InitLMS(tcflag:Boolean=true):Boolean {
			if ((!_isInit) && flash.external.ExternalInterface.available) {
				_isInit = Boolean(flash.external.ExternalInterface.call("LMSInitialize"));
			}
			if (_isInit) {
				// get the completion status and objectives count, ids, and primary objective index
				getStatus();
				if (tcflag) {
					if (_ps == "passed") {
						isComplete = true;
						if (_cs != "completed") completionStatus = "completed";
					} else if (_cs == "completed") {
						isComplete = true;
						successStatus = "passed";
					} else if (_ocs=="completed") {
						isComplete = true;
						completionStatus = "completed";
						successStatus = "passed";
					} else if (_ops=="passed") {
						completionStatus = "completed";
						successStatus = "passed";
					} else {
						isComplete = false;
						if (_cs != "incomplete") completionStatus = "incomplete";
					}
					// primary objective and location status should match
					if (_ocs != _cs) ocompletionStatus = _cs;
					if (_ops != _ps) osuccessStatus = _ps;
					// if anything has changed, commit it
					if (_cf) Commit();
				}
			}
			//trace("MYSCORM.InitLMS("+tcflag+")="+_isInit+" isComplete="+isComplete+" cs="+_cs+" ps="+_ps+" ocs="+_ocs+" ops="+_ops);
			return _isInit;
		}

		public static function GetValue(n:String):String {
			var v:String = "";
			if (_isInit && flash.external.ExternalInterface.available) {
				if ((v = String(flash.external.ExternalInterface.call("LMSGetValue", n)))=="null") v = "";
			}
			//trace("MYSCORM.GetValue("+n+")='"+v+"'");
			return v;
		}

		public static function SetValue(n:String, v:*, commit:Boolean=false):Boolean {
			if (_isInit) {
				var rc:Boolean = false;
				if (_isInit && flash.external.ExternalInterface.available) {
					rc = Boolean(flash.external.ExternalInterface.call("LMSSetValue", n, String(v)));
					_cf = true; // must commit
				}
				if (rc && commit) Commit();
				//trace("MYSCORM.SetValue("+n+","+v+","+commit+")="+rc);
				return rc;
			}
			//trace("MYSCORM.SetValue("+n+","+v+","+commit+")=false");
			return false;
		}

		public static function Commit():Boolean {
			if (_cf) {
				var rc=Call("LMSCommit");
				if (rc) {
					_cf = false;
				}
			}
			return rc;
		}

		// call external javascript LMSTerminate function to terminate the SCO, committing first (redundant)
		public static function Terminate():Boolean {
			if (_isInit) {
				var rc:* = Call("LMSTerminate");
				_isInit=false;
				return rc;
			}
			return false;
		}

		private static function Call(arg1:String, arg2:String=null, arg3:String=null, arg4:String=null):Boolean {
			var rc:Boolean = false;
			try {
				if (_isInit && flash.external.ExternalInterface.available) {
					var rcs=flash.external.ExternalInterface.call(arg1, arg2, arg3, arg4);
					if (rcs==="true") rc=true;
					else if (rcs==="") rc=false;
					else if (rcs==="false") rc=false;
					else rc=Boolean(rcs);
					//trace("MYSCORM.Call("+arg1+","+arg2+","+arg3+")="+rcs+" rc="+rc);
				}
			} catch (e:Error) {
				Trace("Call: " + e.message);
			}
			return rc;
		}

		public static function Trace(arg1:String):void {
			flash.external.ExternalInterface.call("LMSTrace", arg1);
		}

		public static function set suspendData(arg1:String):void {
			SetValue("cmi.suspend_data", arg1, true);
		}
		public static function get suspendData():String {
			return GetValue("cmi.suspend_data");
		}

		public static function set location(arg1:String):void {
			SetValue("cmi.location", arg1);
		}
		public static function get location():String {
			return GetValue("cmi.location");
		}

		public static function set completionStatus(arg1:String):void {
			if (_cs !== arg1) {
				SetValue("cmi.completion_status", arg1);
				_cs = arg1;
			}
			if (_pox < 0) _ocs = _cs;
		}
		public static function get completionStatus():String {
			if (!_cs) {
				var s:* = GetValue("cmi.completion_status");
				_cs=(s && (s != "")) ? s : "unknown";
			}
			if (_pox < 0) _ocs = _cs; return _cs;
		}

		public static function set successStatus(arg1:String):void {
			if (_ps !== arg1) {
				SetValue("cmi.success_status", arg1);
				_ps = arg1;
			}
			if (_pox < 0) _ops = _ps;
		}
		public static function get successStatus():String {
			if (!_ps) {
				var s:* = GetValue("cmi.success_status");
				_ps=(s && (s != "")) ? s : "unknown";
			}
			if (_pox < 0) _ops = _ps; return _ps;
		}

		public static function set ocompletionStatus(arg1:String):void {
			if (_pox >= 0 && _ocs !== arg1) {
				SetValue("cmi.objectives."+_pox+".completion_status", arg1);
				_ocs = arg1;
			}
		}
		public static function get ocompletionStatus():String {
			if (_pox >= 0 && (!_ocs)) {
				var s:* = GetValue("cmi.objectives."+_pox+".completion_status");
				_ocs=(s && (s != "")) ? s : "unknown";
			}
			return _ocs;
		}

		public static function set osuccessStatus(arg1:String):void {
			if (_pox >= 0 && _ops !== arg1) {
				SetValue("cmi.objectives."+_pox+".success_status", arg1);
				_ops = arg1;
			}
		}
		public static function get osuccessStatus():String {
			if (_pox >= 0 && (!_ops)) {
				var s:* = GetValue("cmi.objectives."+_pox+".success_status");
				_ops = (s && (s != "")) ? s : "unknown";
			}
			return _ops;
		}

		public static function getStatus():void {
			// get the number of objectives, and initialize the id array, primary objectives references
			var n:int = numberOfObjectives;
			// get the sco and primary objectives status
			_cs=completionStatus;
			_ps=successStatus;
			_ocs=ocompletionStatus;
			_ops=osuccessStatus;
		}

		public static function set scaledScore(arg1:Number):void {
			SetValue("cmi.score.scaled", arg1);
		}
		public static function get scaledScore():Number {
			var rv:Number = 0;
			var sc:* = GetValue("cmi.score.scaled");
			if (sc && (sc != "")) rv = Number(sc);
			return rv;
		}

		public static function set rawScore(arg1:Number):void {
			SetValue("cmi.score.raw", arg1);
		}
		public static function get rawScore():Number {
			var rv:*=0;
			var sc:* = GetValue("cmi.score.raw");
			if (sc && (sc != "")) rv = Number(sc);
			return rv;
		}

		// determine if this is a first time entry to this sco
		public static function get isFirstTimeEntry():Boolean {
			return (GetValue("cmi.entry") == 'ab-initio');
		}

		// set exit status (only allow to suspend)
		public static function set exitStatus(exittype:String):void {
			// if suspend and the sco is completed and passed, force a normal exit mode
			if (exittype=="suspend") {
				if (_cs == "completed" && _ps == "passed") exittype="normal";
			}
			if (_lastExitStatus!=exittype) {
				SetValue('cmi.exit',exittype,true);
				_lastExitStatus=exittype;
			}
		}

		// get the number of objectives, cache the objective ids, and determine the primary objective id
		public static function get numberOfObjectives():int {
			if (_numberOfObjectives<0) {
				var n:int=Number(GetValue("cmi.objectives._count"));
				_numberOfObjectives=n?n:0;
				n=_numberOfObjectives; for (var i:int=0; i<n; i++) {
					var id=GetValue("cmi.objectives."+i+".id");
					_objectiveIds.push(id);
					if (id===""||id==="primary") _pox=i;
				}
			}
			return _numberOfObjectives;
		}

		// find the objective number from a string id
		public static function objectiveId(id:String):int {
			var n:int = numberOfObjectives; for (var i:int = 0; i < n; i++) {
				if (id === _objectiveIds[i]) return i;
			}
			return -1;
		}

		// use an adl nav request to go to a particular navigable sco
		// implicit Commit by Terminate...
		public static function GoTo(arg1:String):void {
			//trace("MYSCORM.Goto("+arg1+")");
			// if the sco is completed and passed, exit the attempt normally, otherwise suspend till done
			exitStatus = ((_cs=="completed")&&(_ps=="passed"))?"normal":"suspend";
			SetValue("adl.nav.request", "{target=" + arg1 + "}choice");
			// note: the course may not get to the terminate request...
			Terminate();
		}

		// use an adl nav request to continue from the current sco
		// implicit Commit by Terminate...
		public static function Continue():void {
			//trace("MYSCORM.Continue");
			// if the sco is completed and passed, exit normally, otherwise suspend till done
			exitStatus = ((_cs=="completed")&&(_ps=="passed"))?"normal":"suspend";
			SetValue("adl.nav.request", "continue");
			// note: the course may not get to the terminate request... on Saba it does not...
			Terminate();
		}

		// exit the course and mark as completed (Saba)
		// implicit Commit by Terminate...
		public static function ExitCourse():void {
			//trace("MYSCORM.ExitCourse");
			// course does not "exit the course" until it is considered complete, at which point all scos should have exited complete normally.
			exitStatus = "normal";
			SetValue("adl.nav.request", "exitAll");
			Terminate();
		}

		// get an objective value by id
		public static function getObjectiveById(id:String,n:String):* {
			var o:int=objectiveId(id); if (o>=0) {
				return GetValue("cmi.objectives."+o+"."+n);
			}
			return false;
		}
		// set an objective value by id
		public static function setObjectiveById(id:String,n:String,v:*):Boolean {
			var o:int=objectiveId(id); if (o>=0) {
				return SetValue("cmi.objectives."+o+"."+n,v);
			}
			return false;
		}

		public static function SetObjectiveStatus(id:String, v:*):Boolean {
			return setObjectiveById(id,"completion_status",v);
		}
		public static function GetObjectiveStatus(id:String):String {
			var v:*=getObjectiveById(id,"completion_status");
			return v?String(v):"unknown";
		}

		public static function SetObjectiveSuccess(id:String, v:*):Boolean {
			return setObjectiveById(id,"success_status",v);
		}
		public static function GetObjectiveSuccess(id:String):String {
			var v:*=getObjectiveById(id,"success_status");
			return v?String(v):"unknown";
		}

		public static function SetObjectiveScore(id:String, rsc:Number, ssc:Number):Boolean {
			var f:*=setObjectiveById(id,"score.raw",rsc);
			return setObjectiveById(id,"score.scaled",ssc)&&f;
		}

		public static function CopyScoreToObjectives():void {
			var n:int=numberOfObjectives; if (n>=0) {
				var rsc:Number=rawScore;
				var ssc:Number=scaledScore;
				for (var i:int=0; i<n; i++) {
					SetValue("cmi.objectives."+n+".score.raw", rsc);
					SetValue("cmi.objectives."+n+".score.scaled", ssc);
				}
			}
		}

		// determine if all the current objectives have been passed 0(default)=all read-only, 1=all writeable, 2=all
		public static function objectivesPassed(f:Number=0):Boolean {
			var n:int = numberOfObjectives,oc:Boolean=true;
			for (var i:int=0; i<n; i++) {
				switch (f) {
					case 0: if (String(_objectiveIds[i]).charAt(0)!="_") continue; break;
					case 1: if (String(_objectiveIds[i]).charAt(0)=="_") continue; break;
					default: break;
				}
				if (GetValue("cmi.objectives."+i+".success_status") != "passed") {
					oc=false; break;
				}
			}
			//trace("objectivesPassed("+f+")="+oc);
			return oc;
		}

		public static function MarkScoComplete():void {
			ocompletionStatus = "completed";  // set sco primary objective completed
			osuccessStatus = "passed";        // set sco primary objective passed
			completionStatus = "completed";   // set sco completed
			successStatus = "passed";         // set sco passed
		}

		public static function MarkObjectivesComplete():void {
			// if there are any (writable) objectives, set them completed/passed
			var n:int = numberOfObjectives,id:String; if (n) {
				for (var i:int = 0; i < n; i++) {
					id = String(_objectiveIds[i]);
					// do not try and write read-only objectives (starting with an underscore)
					if ((id.charAt(0)=="_")||(id=="primary")||(id==="")) continue;
					SetValue("cmi.objectives."+i+".completion_status","completed");
					SetValue("cmi.objectives."+i+".success_status","passed");
				}
			}
		}

		// set the scene completion status
		public static function setScoComplete():void {
			if ((!_scoCompleted)&&_isInit) {
				// set sco and sco primary objective completed/passed
				MarkScoComplete();
				// set other sco writeable objectives completed/passed
				MarkObjectivesComplete();
				// set the sco exit status to normal for a completed sco
				exitStatus = "normal";
				// only do this once...
				_scoCompleted=true;
			}
		}

		public static function getTheCourseInfo():String {
			return "Course:\ncmi.completion_status="+completionStatus+"\ncmi.success_status="+successStatus+"\ncmi.score.scaled="+scaledScore+"\n";
		}

		public static function getTheObjectiveInfo():String {
			var s:String;
			if (_isInit) {
				var n:int = numberOfObjectives;
				s = "Objectives (" + n + ")\n";
				for (var gg:int = 0; gg < n; gg++) {
					s += "cmi.objectives. "+ gg + ".success_status=" + GetValue("cmi.objectives." + gg + ".success_status") + "\n";
				}
			} else {
				s = "Not initialized\n";
			}
			return s;
		}
	}
}

