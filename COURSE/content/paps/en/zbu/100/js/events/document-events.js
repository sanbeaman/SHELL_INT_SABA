var DocumentEvents = function() {};

DocumentEvents.prototype = function() {
	var	initEvents = function() {
		initializeCommunication(); // this is in utils/APIWrapper.js

		document.getElementById("moreInfoBg").onclick = function(e) {
			ui.hideMoreInfo(e);
		};

		document.getElementById("btnClose").onclick = function(e) {
			ui.hideMoreInfo(e);
		};

		document.getElementById("btnContinue").onclick = function() {
			sc.checkComplete();
		};

		document.getElementById("btnReTest").onclick = function() {
			sc.reTest();
		};

		document.getElementById("btnOverride").onclick = function() {
			sc.checkOverride();
		};
	
		document.getElementById("btnYes").onclick = function() {
			sc.checkComplete();
		};

		document.getElementById("btnNo").onclick = function() {
			ui.hideDisclaimer();
		};

		sc.startChecker();
	}

	return {
		initEvents: initEvents
	};
} ();

var de = new DocumentEvents();
