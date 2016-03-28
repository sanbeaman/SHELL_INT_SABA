var cfg = {
    Language : { Initial : "en"},
	Mandatory: {
		OperatingSystems: [
			{
				Name: "Windows",
				WebBrowsers: [
					{ Name:"IE", Version:"8" },
					{ Name:"Firefox", Version:"11" },
					{ Name:"Chrome", Version:"17" }
				]
			},
			{
				Name: "Macintosh",
				WebBrowsers: [
					{ Name:"Safari", Version:"5" },
					{ Name:"Firefox", Version:"11" },
					{ Name:"Chrome", Version:"17" }
				]
			}
		],
		Cookies: true,
		Resolution: "1024x768",
		Flash: "11,1,0,0",
		AdobePDFReader: "9,5",
		GenericPDFReaderCheck: true
    }
}
