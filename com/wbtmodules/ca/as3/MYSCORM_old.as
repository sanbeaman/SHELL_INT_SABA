package com.wbtmodules.ca.as3
{
	import flash.external.ExternalInterface;
	

	public dynamic class MYSCORM
	{
		internal static var isInit:Boolean=false;
		public static var isComplete:Boolean=false;

		
		public function MYSCORM()
		{
		}

		public static function InitLMS(param1:Boolean=true):Boolean
		{
			if (isInit == false && flash.external.ExternalInterface.available)
			{
				isInit = Boolean(flash.external.ExternalInterface.call("LMSInitialize"));
			}
			if (isInit)
			{
				//MYSCORM.SetValue("cmi.exit", "");
				if (param1)
				{
    			var loc1:*=null;
    			loc1 = MYSCORM.completionStatus;
    			if (loc1 == "not attempted" || loc1 == "unknown")
    			{
    				MYSCORM.completionStatus = "incomplete";
					isComplete = false;
            MYSCORM.Commit();
    			} else {
					isComplete = true;
				}
				}
				//MYSCORM.Commit();
			}
			return isInit;
		}

		
		public static function isFirstTimeEntry():Boolean
		{
			var loc1:*=null;
			loc1 = MYSCORM.GetValue("cmi.entry");
			var result:Boolean = (loc1 == 'ab-initio')?true:false;
			
			return result;
			
		}
		
		public static function setExitStatus(exittype:String):void
		{
			var exitType:String = exittype;
			if (exitType == 'suspend'){
				MYSCORM.SetValue('cmi.exit','suspend',true);
			}
		}
		public static function Call(arg1:String, arg2:String=null, arg3:String=null, arg4:String=null):Boolean
		{
			var method:String;
			var param1:String=null;
			var param2:String=null;
			var param3:String=null;
			var result:Boolean;
			var loc1:*;
			result = false;
			method = arg1;
			param1 = arg2;
			param2 = arg3;
			param3 = arg4;
			result = false;
			try
			{
				if (isInit && flash.external.ExternalInterface.available)
				{
					result = Boolean(flash.external.ExternalInterface.call(method, param1, param2, param3));
				}
			}
			catch (e:Error)
			{
				Trace("Call: " + e.message);
			}
			return result;
		}

		public static function GetObjectiveStatusByID(objectID:String):String
		{
			var objID:String = objectID;
			var objIndx:Number = FindObjectiveIndexByID(objID);
			var objStatus:String;
			if (objIndx != -1){
				objStatus = MYSCORM.GetValue("cmi.objectives."+objIndx+".completion_status");
			} else {
				objStatus = "unknown";
			}
			
			return objStatus;
			
		}
		
		public static  function FindObjectiveIndexByID(objID:String):Number
		{
			var nobj:Number=Number(MYSCORM.GetValue("cmi.objectives._count"));
			for (var i:Number = 0; i < nobj; i++)
			{
				if (objID == MYSCORM.GetValue("cmi.objectives." + i + ".id")){
					
					return i;
				}
				
			}
			
			return -1;
		}
		
		
		public static function CheckGlobalObjectiveSuccessStatus():Boolean
		{
			var allss:Boolean = false;
			var ssobj:Number = Number(MYSCORM.GetValue("cmi.objectives._count"));
			for (var ss:Number = 0; ss < ssobj; ss++){
				var ssString:String = MYSCORM.GetValue("cmi.objectives."+ss+".success_status");
				if (ssString == 'passed'){
					allss = true;
				} else {
					allss = false;
					break;
				}
			}
			
			return allss;
			
		}
		public static function CheckGlobalObjectiveCompletionStatus():Boolean
		{
			var allGlobalsComplete:Boolean = false;
			//(“completed”, “incomplete”, “not attempted”, “unknown”).
			var gobj:Number = Number(MYSCORM.GetValue("cmi.objectives._count"));
				for (var gg:Number = 0; gg < gobj; gg++){
					var gObjComStat:String = MYSCORM.GetValue("cmi.objectives."+gg+".completion_status");
					if (gObjComStat == 'completed'){
						allGlobalsComplete = true;
					} else {
						allGlobalsComplete = false;
						break;
					}
				}
			return allGlobalsComplete;
		}
		public static function SetObjectiveScore(arg1:String, arg2:Number, arg3:Number):Boolean
		{
			var loc1:*=null;
			var loc2:*=null;
			loc1 = arg2.toString();
			loc2 = arg3.toString();
			return MYSCORM.Call("LMSSetObjectiveScore", arg1, loc1, loc2);
		}

		public static function set scaledScore(arg1:Number):void
		{
			MYSCORM.SetValue("cmi.score.scaled", arg1);
		}

		public static function get location():String
		{
			return MYSCORM.GetValue("cmi.location");
		}

		public static function GetValue(arg1:String):String
		{
      if (isInit) {
  			var loc1:*=null;
  			loc1 = "";
  			if (isInit && flash.external.ExternalInterface.available)
  			{
  				loc1 = String(flash.external.ExternalInterface.call("LMSGetValue", arg1));
  			}
  			if (loc1 == "null")
  			{
  				loc1 = "";
  			}
  			return loc1;
      }
      return "";
		}

		public static function set location(arg1:String):void
		{
			MYSCORM.SetValue("cmi.location", arg1);
		}

		public static function get completionStatus():String
		{
			var loc1:*=null;
			loc1 = MYSCORM.GetValue("cmi.completion_status");
			return loc1 != "" ? loc1 : "unknown";
		}

		public static function SetObjectiveSuccess(arg1:String, arg2:String):Boolean
		{
			return MYSCORM.Call("LMSSetObjectiveSuccess", arg1, arg2);
		}

		public static function set completionStatus(arg1:String):void
		{
			MYSCORM.SetValue("cmi.completion_status", arg1);
		}

		public static function set successStatus(arg1:String):void
		{
			MYSCORM.SetValue("cmi.success_status", arg1);
		}

		public static function Trace(arg1:String):void
		{
			flash.external.ExternalInterface.call("LMSTrace", arg1);
		}

		public static function GoTo(arg1:String):void
		{
      if (isInit) {
  			MYSCORM.SetValue("adl.nav.request", "{target=" + arg1 + "}choice");
  			MYSCORM.Terminate();
      }
		}

		public static function get successStatus():String
		{
			var loc1:*=null;
			loc1 = MYSCORM.GetValue("cmi.success_status");
			return loc1 != "" ? loc1 : "unknown";
		}

		public static function set rawScore(arg1:Number):void
		{
			MYSCORM.SetValue("cmi.score.raw", arg1);
		}

		public static function get scaledScore():Number
		{
			var loc1:*=NaN;
			var loc2:*=null;
			loc1 = 0;
			loc2 = MYSCORM.GetValue("cmi.score.scaled");
			if (loc2 != "")
			{
				loc1 = Number(loc2);
			}
			return loc1;
		}

		public static function Commit():Boolean
		{
			return MYSCORM.Call("LMSCommit");
		}

		public static function MarkComplete():Boolean
		{
			return MYSCORM.MarkAllComplete();
		}

		public static function CopyScoreToObjectives():Boolean
		{
			return MYSCORM.Call("LMSCopyScoreToObjectives");
		}

		public static function SetValue(arg1:String, arg2:*, arg3:Boolean=false):Boolean
		{
      if (isInit) {
  			var loc1:*=false;
  			var loc2:*=null;
  			loc1 = false;
  			if (isInit && flash.external.ExternalInterface.available)
  			{
  				loc2 = arg2.toString();
  				loc1 = Boolean(flash.external.ExternalInterface.call("LMSSetValue", arg1, loc2));
  			}
  			if (loc1 && arg3 == true)
  			{
  				MYSCORM.Commit();
  			}
  			return loc1;
      }
      return false;
		}

		public static function MarkAllComplete():Boolean
		{
			var loc1:*=false;
			loc1 = MYSCORM.Call("LMSMarkAllComplete");
			return loc1;
		}
		public static function MarkAllCompleteAndCommit():Boolean
		{
			var loc1:*=false;
			loc1 = MYSCORM.Call("LMSMarkAllComplete");
			
			if (loc1){
				MYSCORM.Commit();
				return true;
			} else {
				return false;
			}
		}

		public static function set suspendData(arg1:String):void
		{
			MYSCORM.SetValue("cmi.suspend_data", arg1, true);
		}

		public static function MarkScoComplete():Boolean
		{
			return MYSCORM.Call("LMSMarkScoComplete");
		}

		public static function get rawScore():Number
		{
			var loc1:*=NaN;
			var loc2:*=null;
			loc1 = 0;
			loc2 = MYSCORM.GetValue("cmi.score.raw");
			if (loc2 != "")
			{
				loc1 = Number(loc2);
			}
			return loc1;
		}

		public static function Continue():void
		{
      if (isInit) {
  			MYSCORM.SetValue("adl.nav.request", "continue");
  			MYSCORM.Terminate();
      }
		}

		public static function get suspendData():String
		{
			return MYSCORM.GetValue("cmi.suspend_data");
		}

		public static function Terminate():Boolean
		{
      if (isInit) {
  			MYSCORM.Commit(); // not really necessary, but shouldn't hurt
  			var rval:*=MYSCORM.Call("LMSTerminate");
        isInit=false;
        return rval;
      }
      return false;
		}

		public static function MarkObjectivesComplete():Boolean
		{
			return MYSCORM.Call("LMSMarkObjectivesComplete");
		}

    public static function setCompletionStatus():void
    {
      if (isInit) {
        // set the sco completion mode
  			MYSCORM.completionStatus = "completed";
  			MYSCORM.successStatus = "passed";
        // if there are any objectives, set status
        var nobj:Number=Number(MYSCORM.GetValue("cmi.objectives._count"));
        if (nobj) {
          for (var i:Number=0; i<nobj; i++) {
            SetValue("cmi.objectives."+i+".success_status","passed");
          }
        }
        // set the "normal" exit mode and commit data
        MYSCORM.SetValue("cmi.exit", "suspend");
        MYSCORM.Commit();
      }
    }
	
	public static function getTheCourseInfo():String
	{
		var msg:String;
		var introStat:String = "GetTheCourseINFO";
		
		var ccStatus:String = "ccStatus= " + MYSCORM.completionStatus ;
		var ssStatus:String = "ssStatus= " + MYSCORM.successStatus;
		var scaledScore:String = "scaleScore= "+ MYSCORM.scaledScore;
		
		
		msg = "\n"+ introStat + "\n"+ ccStatus +"\n"+ ssStatus +"\n"+ scaledScore + "\n";
		
		return msg;
		
		
		
	}
	public static function getTheObjectiveInfo():String
	{
		
		var msg:String;
		
		if (isInit) {
			var nobj:Number = Number(MYSCORM.GetValue("cmi.objectives._count"));
			var line0:String = "GET OBJECTIVE INFO" + "\n";
			var line1:String;
				if(nobj){
					line0 += "Number of Objectives= " + nobj + "\n";
						for (var gg:Number = 0; gg < nobj; gg++){
							line1 += "success_status of objective number -> " + gg + "is " + MYSCORM.GetValue("cmi.objectives."+gg+".success_status") + "\n";
						}
				} else {
						line0 += "no objectives";
						line1 += "error1"; 
				}
				msg = "\n" +line0 + "\n" + line1;
				
		} else {
				msg = "no init";
				
				
		}
	return msg;
	}
	
	public static function setCompletionStatusExitAll():void
	{
		if (isInit) {
			// set the sco completion mode
			/*
			MYSCORM.completionStatus = "completed";
			MYSCORM.successStatus = "passed";
			// if there are any objectives, set status
			var nobj:Number=Number(MYSCORM.GetValue("cmi.objectives._count"));
			if (nobj) {
				for (var i:Number=0; i<nobj; i++) {
					SetValue("cmi.objectives."+i+".success_status","passed");
					SetValue("cmi.objectives."+i+".completion_status","completed");
				}
			}
			*/
			MYSCORM.SetValue("cmi.exit", "normal");
			MYSCORM.Commit();
			
			
			/*
			//commeted out and added "CONTINUE" to see if "postConditionRule" and <imsss:ruleAction action="exitAll" />  will complete the course
			var rval:* = MYSCORM.Call("LMSCompleteAndExit");
			
			*/
			
			MYSCORM.SetValue("adl.nav.request","continue");
			MYSCORM.Terminate();
			
			/*
			// set the "normal" exit mode and commit data
			MYSCORM.SetValue("cmi.exit", "normal");
			MYSCORM.Commit();
			MYSCORM.SetValue("adl.nav.request","exitAll");
			MYSCORM.Terminate();
			*/
			
		}
	}
	}
}

