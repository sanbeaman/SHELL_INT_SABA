package
{
	public class SHELL_COLORS
	{
		/////////////////////////////////////////////
		//  CONSTANTS
		/////////////////////////////////////////////
		static public const CLR_HEADER:uint = 0x000000;
		static public const CLR_FOOTER:uint = 0xDCDED9;
		
		static public const CLR_MAINFONT:uint = 0x666666;
		static public const CLR_TICK:uint = 0x666666;
		
		static public const CLR_SABAMENU:uint = 0x484848;
		
		static public const CLR_GRADBLUE1:uint = 0x99ccff;
		static public const CLR_GRADBLUE2:uint = 0x6699cc;
		
		
		static public const CLR_BLUEBTN:uint = 0x0067b1;
		static public const CLR_BLUE:uint = 0x15A5C9; //0x003366
		
		//Greys
		static public const CLR_GREYCC:uint = 0xcccccc; //scrubBar
		static public const CLR_GREYDD:uint = 0xdddddd;
		static public const CLR_GREY85:uint = 0x858585;
		static public const CLR_GREY33:uint = 0x333333; //scrubTrack
		static public const CLR_GREY48:uint = 0x484848;
		static public const CLR_GREY66:uint = 0x666666;
		
		
		static public const CLR_DKGREY:uint = 0x666666;
		
		static public const CLR_LTGREY:uint = 0xdcded9;
		

		
		
	
		static public const CLR_WHITE:uint = 0xFFFFFF;
		
		//dragBtns0x00B5D7
		static public const CLR_LTBLUE:uint = 0x00B5D7;
		static public const CLR_DKBLUE:uint = 0x376AB3;
		
		static public const CLR_PALEBLUE:uint = 0xD1E6F2;
		static public const CLR_BLACK:uint = 0x000000;
		static public const CLR_SALMON:uint = 0xe05e5b;
		static public const CLR_GREEN:uint = 0x9db351;
		//static public const CLR_BLUE:uint = 0x34a1b5;
		//static public const CLR_DKGREY:uint = 0x808285;
		static public const CLR_LTBEIGE:uint = 0xf4f6e1;
		static public const CLR_DKBEIGE:uint = 0xeee5ca;
		
		static public const CLR_ORANGEGRAD1:uint = 0xcc6633;
		static public const CLR_ORANGEGRAD2:uint = 0xff9933;
		
		
		static public const CLR_LTORANGE:uint = 0xffcc33;
		static public const CLR_ORANGE:uint = 0xfe9003;
		static public const CLR_DKORANGE:uint = 0xcc9900;
		
		static public const CLR_PURPLE:uint = 0x5441B7;
		static public const CLR_TURQUOISE:uint = 0x129587;
		static public const CLR_DKRED:uint = 0x9f1f1f;

		static public const CLR_DEFAULT:uint = 0x666666;

		public function SHELL_COLORS()
		{
		}
		public static function lookUpColor(colorword:String):uint
		{
			var clrUint:uint;
			var colorwordLC:String;
			var cwordStartWith:String = colorword.charAt(0);
			//trace('cwordStartWith= ' + cwordStartWith);
			
			if (cwordStartWith == '#'){
				var r:RegExp=new RegExp(/#/g);	
				clrUint = uint(String(colorword).replace(r,"0x"));
				
			} else if (cwordStartWith == '0'){
				clrUint = uint(colorword);
				
			} else {
				//trace('now look up color');
				clrUint =  _colorWordLookUp(colorword.toLowerCase());
			}
			
			return clrUint;
		}
		
		private static function _colorWordLookUp(colorword:String):uint
		{
			var sc:uint;
			
			switch (colorword){
				case 'white':
					sc = CLR_WHITE;
					break;
				case 'black':
					sc = CLR_BLACK;
					break;
				case 'dkgrey':
					sc = CLR_GREY66;
					break;
				case 'grey66':
					sc = CLR_GREY66;
					break;
				case 'grey85':
					sc = CLR_GREY85;
					break;
				case 'grey48':
					sc = CLR_GREY48;
					break;
				case 'grey33':
					sc = CLR_GREY33;
					break;
				case 'greycc':
					sc = CLR_GREYCC;
					break;
				case 'greydd':
					sc = CLR_GREYDD;
					break;
				case 'ltgrey':
					sc = CLR_LTGREY;
					break;
				case 'salmon':
					sc = CLR_SALMON;
					break;
				case 'green':
					sc = CLR_GREEN;
					break;
				case 'blue':
					sc = CLR_BLUE;
					break;
				case 'dkred':
					sc = CLR_DKRED;
					break;
				case 'ltbeige':
					sc = CLR_LTBEIGE;
					break;
				case 'turquoise':
					sc = CLR_TURQUOISE;
					break;
				case 'turq':
					sc = CLR_TURQUOISE;
					break;
				case 'ltorange':
					sc = CLR_LTORANGE;
					break;
				case 'orange':
					sc = CLR_ORANGE;
					break;
				case 'dkorange':
					sc = CLR_DKORANGE;
					break;
				case 'orangegrad1':
					sc = CLR_ORANGEGRAD1
					break;
				case 'orangegrad2':
					sc = CLR_ORANGEGRAD2;
					break;
				case 'purple':
					sc = CLR_PURPLE;
					break;
				case 'dkbeige':
					sc = CLR_DKBEIGE;
					break;
				
				case 'paleblue':
					sc = CLR_PALEBLUE;
					break;
				case 'ltblue':
					sc = CLR_LTBLUE;
					break;
				case 'bluebtn':
					sc = CLR_BLUEBTN;
					break;
				case 'dkblue':
					sc = CLR_DKBLUE;
					break;
				case 'gradblue1':
					sc = CLR_GRADBLUE1;
					break;
				case 'gradblue2':
					sc = CLR_GRADBLUE2;
					break;
				default:
					sc = CLR_DEFAULT;
					break;
			}
			return sc;
		}
	}
}

