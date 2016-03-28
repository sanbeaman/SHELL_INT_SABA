package com.sfc.nav {
	//
	// FAICC Class for interface to Ford RE&T Javascript AICC (SCORM 1.2 equivalent) interface
	//
	// AICC Version
	//
	// SF Consulting, 2007-2012
	//
	import flash.external.ExternalInterface;

	public class FAICC {
		// empty class constructor (static class)
		public function FAICC() {}
		// javascript ExternalInterface call method
		public static function Call(method:String,var1:*=undefined,var2:*=undefined) {
			var r=false;
			if (flash.external.ExternalInterface.available) {
				if (var1===undefined) {
					r=flash.external.ExternalInterface.call(method);
				} else if (var2===undefined) {
					r=flash.external.ExternalInterface.call(method,var1);
				} else {
					r=flash.external.ExternalInterface.call(method,var1,var2);
				}
				if (r=="true") r=true; else if (r=="false") r=false;
			}
			return r;
		}
		// incomplete, completed, passed, failed
		public static function get_status() {return FAICC.Call("get_status");}
		public static function set_status(s) {return FAICC.Call("set_status",s);}
		// suspend_data get/set
		public static function get_suspend_data() {return FAICC.Call("get_suspend_data");}
		public static function set_suspend_data(s) {return FAICC.Call("set_suspend_data",s);}
		// score get/set - integer 0-100
		public static function get_score() {return FAICC.Call("get_score");}
		public static function set_score(s) {return FAICC.Call("set_score",s);}
		// suspend the course with the current status
		public static function suspend_course() {return FAICC.Call("suspend_course");}
		// exit the course with specified completion status (end attempt - continue normally)
		public static function exit_course(s) {return FAICC.Call("exit_course",s);}
	}
}
