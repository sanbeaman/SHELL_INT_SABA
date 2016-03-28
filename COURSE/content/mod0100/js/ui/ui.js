var UI = function() {};

UI.prototype = function() {

	if (typeof(JSON) != "undefined")
	{
		if(cu.parseQuery().lang != undefined)
		{
			var jsonParse = JSON.parse(cu.loadJSON("translations/"+cu.parseQuery().lang+"_data.json"));
			
		}
		else
		{
			var jsonParse = JSON.parse(cu.loadJSON("translations/"+cfg.Language.Initial+"_data.json"));
		}
	}
	else
	{
		if(cu.parseQuery().lang != undefined)
		{
			var jsonParse = eval('(' + cu.loadJSON("translations/"+cu.parseQuery().lang+"_data.json") + ')');
		}
		else
		{
			var jsonParse = eval('(' + cu.loadJSON("translations/"+cfg.Language.Initial+"_data.json") + ')');
		}
	}


	var	printOutput = function() {
		var outElem;

			outElem = document.getElementById("header");
			outElem.innerHTML = "<span class='checker-title'>"+jsonParse.Headers.PageTitle+"</span> <img src='"+jsonParse.Headers.CAImage+"' class='logo'>"

			outElem = document.getElementById("mandatoryChart");
			outElem.innerHTML = getMandatory();
			
			var moreInfoLinks;
			if (!document.getElementsByClassName) // For IE
			{
				getElementsByClassName = function (node, classname) {
					var a = [];
					var re = new RegExp('(^| )'+classname+'( |$)');
					var els = node.getElementsByTagName("*");
					for(var i=0,j=els.length; i<j; i++)
						if(re.test(els[i].className))a.push(els[i]);
					return a;
				}

				moreInfoLinks = getElementsByClassName(document.body, "more-info-link");
			}
			else
			{
				moreInfoLinks = document.getElementsByClassName("more-info-link");
			}

			for (var k = 0; k < moreInfoLinks.length; k++)
			{
				moreInfoLinks[k].onclick = function(e) {
					if (!e) var e = window.event; // For IE
					ui.showMoreInfo(e);
				}
			}

			outElem = document.getElementById("additionalChart");
			outElem.innerHTML = getAdditional();

			outElem = document.getElementById("courseName");
			outElem.innerHTML = getCourseName();

			outElem = document.getElementById("userName");
			outElem.innerHTML = getUserName();

			var systemCompliant = sc.checkAllClear();
			
			outElem = document.getElementById("statusText");

			var btnReTest = document.getElementById("btnReTest");
			var btnContinue = document.getElementById("btnContinue");
			var btnOverride = document.getElementById("btnOverride");

			var out;
			if (systemCompliant)
			{
				out = "<span class='checker-status-text-ok'>"+jsonParse.Headers.CurrentPass+"</span><br>" + jsonParse.UIText.InstructionalTextCorrect;
				btnContinue.style.display = "inline";
				btnReTest.style.display = "none";
				btnOverride.style.display = "none";
			}
			else
			{
				out = "<span class='checker-status-text-failed'>"+jsonParse.Headers.SysChecFail+"</span><br>" + jsonParse.UIText.InstructionalTextFailed;
				btnContinue.style.display = "none";
				btnReTest.style.display = "inline";
				btnOverride.style.display = "inline";
			}
			outElem.innerHTML = out;

			outElem = document.getElementById("disclaimerText");
			out = jsonParse.UIText.InstructionalTextOverridePopup;
			outElem.innerHTML = out;
			

			var el = document.getElementById("mainContainer");

			if (el.classList)
			{
				el.classList.remove('anim-fade-in-longer-full');
				el.classList.remove('anim-fade-out-full');
				el.classList.add('anim-fade-in-longer-full');
			}
			else
			{
				el.style.visibility = "visible";
				el.style.opacity = 1;
			}

			outElem = document.getElementById("btnContinue");
			outElem.innerHTML = jsonParse.General.Continue;
			
			outElem = document.getElementById("btnReTest")
			outElem.innerHTML = jsonParse.General.ReTest;
			
			outElem = document.getElementById("btnOverride")
			outElem.innerHTML = jsonParse.General.Override;
			
			outElem = document.getElementById("btnYes")
			outElem.innerHTML = jsonParse.General.Yes;
			
			outElem = document.getElementById("btnNo")
			outElem.innerHTML = jsonParse.General.No;
			
			outElem = document.getElementById("pleaseWait")
			outElem.innerHTML = jsonParse.General.Wait;

		},

		getMandatory = function() {
			var out = "<table class='table-chart' width='100%' border='0' cellspacing='0'>";
			out += "<tr>";
			out += "<th scope='col' width='5%' align='center'>"+jsonParse.Headers.Status+"</th>";
			out += "<th scope='col' align='left'>"+jsonParse.Headers.SysComp+"</th>";
			out += "<th scope='col' align='left'>"+jsonParse.Headers.MinReq+"</th>";
			out += "<th scope='col' align='left'>"+jsonParse.Headers.YourSys+"</th>";
			out += "<th scope='col' width='12%' align='center'>"+jsonParse.Headers.Info+"</th>";
			out += "</tr>";
			
			var rowCol = "row-color-1";
			var symb = "";
			var symbCorrect = "<img src='assets/icon_check.gif'>";
			var symbIncorrect = "<img src='assets/icon_ex.gif'>";
			var minOut = "";
			var sysOut = "";

			if (cfg.Mandatory.OperatingSystems)
			{
				symb = sc.getSysTest().passOS ? symbCorrect : symbIncorrect;
				sysOut = sc.getSysTest().passOS ? sc.getSysParams().OS : "<span class='red-text'>" + sc.getSysParams().OS + "</span>";
				out += "<tr class='"+rowCol+"'><td align='center'>" + symb + "</td><td>"+jsonParse.Mandatory.OpSys+"</td><td>" + getCfgOSNames() + "</td><td class='orange-text'>" + sysOut + "</td><td align='center'><a href='javascript:void(0)' class='more-info-link' data-info='OperatingSystems'>"+jsonParse.Mandatory.MoreInfo+"</a></td></tr>";
				rowCol = switchRowColor(rowCol);
			}

			if (sc.getSysTest().passOS)
			{
				symb = sc.getSysTest().passBrowser ? symbCorrect : symbIncorrect;
				sysOut = (!sc.getSysTest().passBrowser) ? "<span class='red-text'>" + sc.getSysParams().browserName + " " + sc.getSysParams().browserVersion + "</span>" : sc.getSysParams().browserName + " " + sc.getSysParams().browserVersion;
				out += "<tr class='"+rowCol+"'><td align='center'>" + symb + "</td><td>"+jsonParse.Mandatory.WebBrowser+"</td><td>" + getCfgBrowserNames() + "</td><td class='orange-text'>" + sysOut + "</td><td align='center'><a href='javascript:void(0)' class='more-info-link' data-info='Browser'>"+jsonParse.Mandatory.MoreInfo+"</a></td></tr>";
				rowCol = switchRowColor(rowCol);
			}

			//if (jsonParse.Mandatory.JavaScript && jsonParse.Mandatory.JavaScript == true)
			//{
				symb = symbCorrect;
				out += "<tr class='"+rowCol+"'><td align='center'>" + symb + "</td><td>"+jsonParse.Mandatory.JS+"</td><td>"+jsonParse.General.Enabled+"</td><td class='orange-text'>"+jsonParse.General.Enabled+"</td><td align='center'><a href='javascript:void(0)' class='more-info-link' data-info='JavaScript'>"+jsonParse.Mandatory.MoreInfo+"</a></td></tr>";
				rowCol = switchRowColor(rowCol);
			//}

			if (cfg.Mandatory.Cookies && cfg.Mandatory.Cookies == true)
			{
				symb = sc.getSysTest().passCookies ? symbCorrect : symbIncorrect;
				sysOut = sc.getSysTest().passCookies ? jsonParse.General.Enabled : "<span class='red-text'>"+jsonParse.General.Disabled+"</span>";
				out += "<tr class='"+rowCol+"'><td align='center'>" + symb + "</td><td>"+jsonParse.Mandatory.Cookies+"</td><td>"+jsonParse.General.Enabled+"</td><td class='orange-text'>" + sysOut + "</td><td align='center'><a href='javascript:void(0)' class='more-info-link' data-info='Cookies'>"+jsonParse.Mandatory.MoreInfo+"</a></td></tr>";
				rowCol = switchRowColor(rowCol);
			}

			if (cfg.Mandatory.Resolution && cfg.Mandatory.Resolution != "")
			{
				symb = sc.getSysTest().passResolution ? symbCorrect : symbIncorrect;
				if (sc.getSysTest().passResolution)
				{
					sysOut = sc.getSysParams().sW + "x" + sc.getSysParams().sH;
				}
				else
				{
					if (sc.getSysParams().zoom == 1)
					{
						sysOut = "<span class='red-text'>" + sc.getSysParams().sW + "x" + sc.getSysParams().sH + "</span>"
					}
					else
					{
						sysOut = "<span class='red-text'>" + sc.getSysParams().sW + "x" + sc.getSysParams().sH + " ("+jsonParse.General.PrePercent+" " + Math.ceil(sc.getSysParams().zoom * 100)  +""+jsonParse.General.PostPercent+")</span>"
					}
				}

				out += "<tr class='"+rowCol+"'><td align='center'>" + symb + "</td><td>"+jsonParse.Mandatory.MSR+"</td><td>" + cfg.Mandatory.Resolution + " ("+jsonParse.General.PrePercent+" 100"+jsonParse.General.PostPercent+")</td><td class='orange-text'>" + sysOut + "</td><td align='center'><a href='javascript:void(0)' class='more-info-link' data-info='Resolution'>"+jsonParse.Mandatory.MoreInfo+"</a></td></tr>";
				rowCol = switchRowColor(rowCol);
			}

			if (cfg.Mandatory.Flash && cfg.Mandatory.Flash != "")
			{
				symb = sc.getSysTest().passFlash ? symbCorrect : symbIncorrect;

				if (sc.getSysParams().flVer == null)
				{
					sysOut = "<span class='red-text'>" + getPluginStatus(sc.getSysParams().flStatus) + "</span>";
				}
				else if (sc.getSysParams().flStatus == -0.1) // lower than required version
				{
					sysOut = "<span class='red-text'>" + sc.getSysParams().flVer.replace(/,/g, ".") + "</span>";
				}
				else
				{
					sysOut = sc.getSysParams().flVer.replace(/,/g, ".");
				}
				out += "<tr class='"+rowCol+"'><td align='center'>" + symb + "</td><td>"+jsonParse.Mandatory.FlashVersion+"</td><td>" + cfg.Mandatory.Flash.replace(/,/g, ".") + "</td><td class='orange-text'>" + sysOut + "</td><td align='center'><a href='javascript:void(0)' class='more-info-link' data-info='Flash'>"+jsonParse.Mandatory.MoreInfo+"</a></td></tr>";
				rowCol = switchRowColor(rowCol);
			}

			if (cfg.Mandatory.AdobePDFReader && cfg.Mandatory.AdobePDFReader != "")
			{
				symb = sc.getSysTest().passPDFReader ? symbCorrect : symbIncorrect;
				minOut = cfg.Mandatory.AdobePDFReader.replace(/,/g, ".");

				if (sc.getSysParams().arVer == null)
				{
					sysOut = "<span class='red-text'>" + getPluginStatus(sc.getSysParams().arStatus) + "</span>";
				}
				else if (sc.getSysParams().arStatus == -0.1) // lower than required version
				{
					sysOut = "<span class='red-text'>" + sc.getSysParams().arVer.replace(/,/g, ".") + "</span>";
				}
				else if (sc.getSysParams().arVer == -999) // generic PDF detection used
				{
					minOut = "PDF Capable"
					sysOut = sc.getSysParams().arStatus == 0 ? "PDF Capable" : "<span class='red-text'>" + getPluginStatus(sc.getSysParams().arStatus) + "</span>";
				}
				else
				{
					sysOut = sc.getSysParams().arVer.replace(/,/g, ".");
				}
				out += "<tr class='"+rowCol+"'><td align='center'>" + symb + "</td><td>"+jsonParse.Mandatory.PDF+"</td><td>" + minOut + "</td><td class='orange-text'>" + sysOut + "</td><td align='center'><a href='javascript:void(0)' class='more-info-link' data-info='AdobeReader'>"+jsonParse.Mandatory.MoreInfo+"</a></td></tr>";
				rowCol = switchRowColor(rowCol);
			}

			out += "</table>";
			
			return out;
		},

		getAdditional = function() {
			var rowCol = "row-color-1";
			var out = "<table class='table-chart' width='100%' border='1' cellspacing='0'>";
			out += "<tr>";
			//out += "<th colspan='2' scope='col' align='left'>Additional Requirements (Not Checked)</th>";
			out += "<th colspan='2' scope='col' align='left'>"+ jsonParse.AdditionalRequirements.Name+"</th>";
			out += "</tr>";

			//console.log('PPPPPPPPPPPPPP', cu.loadJSON.AdditionalRequirements.Name)

			for (var i = 0; i < jsonParse.Additional.length; i++)
			{
				out += "<tr class='"+rowCol+"'><td>" + jsonParse.Additional[i].Name + "</td><td class='orange-text'>" + jsonParse.Additional[i].Value + "</td></tr>"
				rowCol = switchRowColor(rowCol);
			}
			
			out += "</table>";
			
			return out;
		},

		getCourseName = function() {
			//return jsonParse.UIText.CourseName;
			return cu.getCourseTitle();
		},

		getUserName = function() {
			var userName = cu.getLearnerName();
			return userName;
		},

		getCfgOSNames = function() {
			var cfgOSs = "";
			for (var i = 0; i < cfg.Mandatory.OperatingSystems.length; i++)
			{
				cfgOSs += cfg.Mandatory.OperatingSystems[i].Name;
				if (i < cfg.Mandatory.OperatingSystems.length - 1) cfgOSs += " " + jsonParse.General.Or + " ";
			}

			return cfgOSs;
		},

		getCfgBrowserNames = function()	{
			var cfgBrowsers = "";
			for (var i = 0; i < cfg.Mandatory.OperatingSystems.length; i++)
			{
				if (cfg.Mandatory.OperatingSystems[i].Name == sc.getSysParams().OS)
				{
					for (var j = 0; j < cfg.Mandatory.OperatingSystems[i].WebBrowsers.length; j++)
					{
						cfgBrowsers += cfg.Mandatory.OperatingSystems[i].WebBrowsers[j].Name + " " + cfg.Mandatory.OperatingSystems[i].WebBrowsers[j].Version;
						if (j < cfg.Mandatory.OperatingSystems[i].WebBrowsers.length - 1) cfgBrowsers += ", ";
					}
				}
			}

			return cfgBrowsers;
		},

		getPluginStatus = function(status) {
			if (status==1) return "Correct Version" // "installed & enabled, version is >= " + obj.minVersion;
			if (status==0) return "Version Unknown" // "installed & enabled, version is unknown";
			if (status==-0.1) return "Lower Version" // "installed & enabled, version is < " + obj.minVersion;
			if (status==-0.2) return "Not Enabled"; // "installed but not enabled";
			if (status==-1) return "Not Installed"; //"not installed or not enabled";
			if (status==-1.5) return "Unable to Detect"; //"in IE, when Adobe Reader is not installed.";
			if (status==-2) return "ActiveX Disabled" //"please enable ActiveX in Internet Explorer so that we can detect your plugins";
			if (status==-3) return "Detection Error" //"error...bad input argument to PluginDetect method";
			return "Status Unknown";
		},

		switchRowColor = function(rowCol) {
			rowCol = (rowCol == "row-color-1") ? "row-color-2" : "row-color-1";
			return rowCol;
		},

		showMoreInfo = function(e) {
			var el = document.getElementById("moreInfo");
			var elTitle = document.getElementById("moreInfoTitle");
			var elText = document.getElementById("moreInfoText");
			var target = (e.currentTarget) ? e.currentTarget : e.srcElement;
			var infoID = target.getAttribute('data-info');

			var elBg = document.getElementById("moreInfoBg");
			elBg.style.visibility = "visible";
			elBg.style.zIndex = 100;

			infoTitle = jsonParse.MoreInfo[infoID].Title;
			infoText = jsonParse.MoreInfo[infoID].Content;

			elTitle.innerHTML = infoTitle;
			elText.innerHTML = infoText;

			var wHeight = el.offsetHeight;

			el.style.visibility = "visible";
			el.style.left = findAbsPos(target)[0] - 460 + "px";
			el.style.top = findAbsPos(target)[1] - (wHeight / 2 - 12) + "px";

			if (el.classList)
			{
				el.classList.remove('anim-fade-in-full');
				el.classList.add('anim-fade-in-full');
			}
			else
			{
				el.style.opacity = 1;
			}
			
			elText.scrollTop = 0
		},

		hideMoreInfo = function(e) {
			var el = document.getElementById("moreInfo");
			el.style.visibility = "hidden";

			var elBg = document.getElementById("moreInfoBg");
			elBg.style.visibility = "hidden";

			if (el.classList)
			{
				el.classList.remove("anim-fade-in-full");
			}
		},

		toggleMoreInfo = function(e) {
			el.style.visibility = (el.style.visibility == "visible") ? "hidden" : "visible";
		},

		showDisclaimer = function() {
			var el = document.getElementById("disclaimer");
			el.style.visibility = "visible";

			el = document.getElementById("disclaimerBg");
			el.style.visibility = "visible";

			if (el.classList)
			{
				document.getElementById('disclaimerBg').classList.toggle('anim-fade-in-third');
				document.getElementById('disclaimerMessage').classList.toggle('anim-fade-in-full');
			}
			else
			{
				el.style.visibility = "hidden";

				el = document.getElementById("disclaimer");
				el.style.opacity = 1;

				el = document.getElementById('disclaimerMessage');
				el.style.opacity = 1;
			}
		},

		hideDisclaimer = function() {
			var el = document.getElementById("disclaimer");
			el.style.visibility = "hidden";

			el = document.getElementById("disclaimerBg");
			el.style.visibility = "hidden";

			if (el.classList)
			{
				document.getElementById('disclaimerBg').classList.toggle('anim-fade-in-third');
				document.getElementById('disclaimerMessage').classList.toggle('anim-fade-in-full');
			}

			//removeClass("disclaimerBg", "anim-fade-in-third");
			//removeClass("disclaimerMessage", "anim-fade-in-full");
		},

		findAbsPos = function(obj) {
			var curleft = 0;
			var curtop = 0;
			if(obj.offsetLeft) curleft += parseInt(obj.offsetLeft);
			if(obj.offsetTop) curtop += parseInt(obj.offsetTop);
			if(obj.scrollTop && obj.scrollTop > 0) curtop -= parseInt(obj.scrollTop);
			if(obj.offsetParent)
			{
				var pos = findAbsPos(obj.offsetParent);
				curleft += pos[0];
				curtop += pos[1];
			}
			else if(obj.ownerDocument)
			{
				var thewindow = obj.ownerDocument.defaultView;
				if(!thewindow && obj.ownerDocument.parentWindow)
					thewindow = obj.ownerDocument.parentWindow;
				if(thewindow)
				{
					var frmElement;
					try {
						frmElement = thewindow.frameElement;
					} catch(e) {}

					if(frmElement) {
						var pos = findAbsPos(frmElement);
						curleft += pos[0];
						curtop += pos[1];
					}
				}
			}
			return [curleft,curtop];
		},

		addClass = function(elID, className) {
			document.getElementById(elID).className += " " + className;
		},

		removeClass = function(elID, className) {
			document.getElementById(elID).className = document.getElementById(elID).className.replace( /(?:^|\s)className(?!\S)/g , '' );
		}

	return {
		printOutput: printOutput,
		showMoreInfo: showMoreInfo,
		hideMoreInfo: hideMoreInfo,
		showDisclaimer: showDisclaimer,
		hideDisclaimer: hideDisclaimer
	};
} ();

var ui = new UI();
