var SystemChecker = function() {};

SystemChecker.prototype = function() {
	var sysTest = {},
		sysParams = {},
		allClear = [],

		startChecker = function () {
			sysTest.passOS = false;
			sysTest.passBrowser = false;
			sysTest.passCookies = false;
			sysTest.passResolution = false;
			sysTest.passFlash = false;
			sysTest.passPDFReader = false;
			
			sysParams.OS = "";
			sysParams.browserName = "";
			sysParams.browserVersion = -999;
			sysParams.zoom = 0;
			sysParams.sW = 0;
			sysParams.sH = 0;
			sysParams.flVer = -999;
			sysParams.flStatus = -999;
			sysParams.arVer = -999;
			sysParams.arStatus = -999;

			allClear = [];

			if (cfg.Mandatory.OperatingSystems)
			{
			    sysTest.passOS = checkOS();
				allClear.push(sysTest.passOS);
			}

			if (sysTest.passOS)
			{
				sysTest.passBrowser = checkBrowser(sysParams.OS);
				allClear.push(sysTest.passBrowser);
			}

			if (cfg.Mandatory.Cookies && cfg.Mandatory.Cookies == true)
			{
				sysTest.passCookies = checkCookies();
				allClear.push(sysTest.passCookies);
			}

			if (cfg.Mandatory.Resolution && cfg.Mandatory.Resolution != "")
			{
				sysTest.passResolution = checkResolution();
				allClear.push(sysTest.passResolution);
			}
			
			if (cfg.Mandatory.Flash && cfg.Mandatory.Flash != "")
			{
				sysTest.passFlash = checkFlash();
				allClear.push(sysTest.passFlash);
			}

			if (cfg.Mandatory.AdobePDFReader && cfg.Mandatory.AdobePDFReader != "")
			{
				sysTest.passPDFReader = checkAdobeReader();
			}

			if (sysTest.passPDFReader)
			{
				allClear.push(sysTest.passPDFReader);
				checkingFinished();
			}
			else if (cfg.Mandatory.GenericPDFReaderCheck && (sysParams.arVer == null || sysParams.arStatus == -0.2))
			{
				if (BrowserDetect.browser == "Explorer" && BrowserDetect.version <= 10) // there's no Generic PDF reader installed in IE up to version 10, so skip the check. 
				{
					allClear.push(sysTest.passPDFReader);
					checkingFinished();
				}
				else
				{
					document.getElementById("pleaseWait").style.display = "block";
					PluginDetect.onDetectionDone("PDFReader", checkGenericPDFReader, "assets/Empty.pdf");
				}
			}
			else
			{
				allClear.push(sysTest.passPDFReader);
				checkingFinished();
			}
		},

		checkOS = function() {
			var chkOS = false;

			var os = PluginDetect.OS;

		    if (os == 1) sysParams.OS = "Windows";
		    if (os == 2) sysParams.OS = "Macintosh";
		    if (os == 3) sysParams.OS = "Linux";

		    if (os == 21.1) sysParams.OS = "iPhone";
		    if (os == 21.2) sysParams.OS = "iPod";
		    if (os == 21.3) sysParams.OS = "iPad";

		    if (!sysParams.OS) sysParams.OS = "Other";

			for (var i = 0; i < cfg.Mandatory.OperatingSystems.length; i++)
			{
				if (cfg.Mandatory.OperatingSystems[i].Name == sysParams.OS) chkOS = true;
			}

			return chkOS;
		},

		checkBrowser = function() {
			var chkBrowser = false;
			
			sysParams.browserName = BrowserDetect.browser;
			if (sysParams.browserName == "Explorer") sysParams.browserName = "IE";
			sysParams.browserVersion = BrowserDetect.version;

			for (var i = 0; i < cfg.Mandatory.OperatingSystems.length; i++)
			{
				if (cfg.Mandatory.OperatingSystems[i].Name == sysParams.OS)
				{
					for (var j = 0; j < cfg.Mandatory.OperatingSystems[i].WebBrowsers.length; j++)
					{
						if (cfg.Mandatory.OperatingSystems[i].WebBrowsers[j].Name == sysParams.browserName &&
							cfg.Mandatory.OperatingSystems[i].WebBrowsers[j].Version <= sysParams.browserVersion) chkBrowser = true;
					}
				}
			}
			
			return chkBrowser;
		},

		checkCookies = function() {
			var chkCookies = false;
			
			var rnd = Math.random();
			document.cookie = "testing=cookies_enabled" + rnd + "; path=/";
			if(document.cookie.indexOf("testing=cookies_enabled" + rnd) != -1)
			{
				chkCookies = true;
				document.cookie = "testing=; path=/"; // cookies are enabled, so delete this test cookie
			}

			return chkCookies;
		},

		checkResolution = function() {
			var chkResolution = false;

			sysParams.zoom = detectZoom.zoom();
			
			if (sysParams.zoom == 0) sysParams.zoom = 1;
			if (sysParams.browserName == "Firefox" && sysParams.OS == "Macintosh" && window.devicePixelRatio > 1) sysParams.zoom = 1; // Firefox (last tested with version 20.0) on MacBook Pro Retina always reports wrong zoom value of 2. This gets around the problem by ignoring the zoom test under those conditions.

			cfgW = cfg.Mandatory.Resolution.split("x")[0];
			cfgH = cfg.Mandatory.Resolution.split("x")[1];

			sysParams.sW = window.screen.width;
			sysParams.sH = window.screen.height;

			if (cfgW <= sysParams.sW && cfgH <= sysParams.sH && sysParams.zoom == 1) chkResolution = true;
			
			return chkResolution;
		},

		checkFlash = function() {
			var chkFlash = false;
			
			sysParams.flVer = PluginDetect.getVersion("Flash");
			sysParams.flStatus = PluginDetect.isMinVersion("Flash", cfg.Mandatory.Flash);

			if (sysParams.flStatus == 1) chkFlash = true;

			return chkFlash;
		},

		checkAdobeReader = function() {
			var chkAdobeReader = false;

			sysParams.arVer = PluginDetect.getVersion("AdobeReader");
			sysParams.arStatus = PluginDetect.isMinVersion("AdobeReader", cfg.Mandatory.AdobePDFReader);

			if (sysParams.arStatus == 1) chkAdobeReader = true;

			return chkAdobeReader;
		},

		checkGenericPDFReader = function() {
			document.getElementById("pleaseWait").style.display = "none";

			sysParams.arVer = -999;
			sysParams.arStatus = PluginDetect.isMinVersion("PDFReader", "0");

			if (sysParams.arStatus == 0) sysTest.passPDFReader = true;

			allClear.push(sysTest.passPDFReader);
			checkingFinished();
		},

		checkingFinished = function() {
			ui.hideMoreInfo();
			ui.printOutput();
		},

		checkAllClear = function() {
			var systemCompliant = true;

			for (var i = 0; i < allClear.length; i++)
			{
				if (allClear[i] == false) systemCompliant = false;
			}

			return systemCompliant;
		},

		checkComplete = function() {
			//alert("Check Complete");
      deb("Check Complete");
			cu.setCurrentPassed(true);
      if (scorm_SetCookie&&systemchecker) scorm_SetCookie(systemchecker,'Y'); //SCF Added - set System Checker passed cookie
			cu.goNext();
		},

		reTest = function() {
			var el = document.getElementById("mainContainer");

			if (el.classList)
			{
				el.classList.remove('anim-fade-in-longer-full');
				el.classList.remove('anim-fade-out-full');
				el.classList.add('anim-fade-out-full');
			}
			else
			{
				el.style.visibility = "hidden";
			}

			setTimeout(startChecker, 300);
		},

		checkOverride = function() {
			ui.showDisclaimer();
		}

	return {
		getSysTest: function() { return sysTest; },
		getSysParams: function() { return sysParams; },

		startChecker: startChecker,
		reTest: reTest,
		checkComplete: checkComplete,
		checkOverride: checkOverride,
		checkAllClear: checkAllClear
	};
} ();

var sc = new SystemChecker();


