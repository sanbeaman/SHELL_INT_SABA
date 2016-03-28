package com.sanbeaman.shell.ui
{
	import flash.display.Sprite;
	
	public class ShellBlock extends Sprite
	{
		
		private var _blockType:String;
		private var _blockBack:Sprite;
		private var _blockWidth:Number;
		private var _blockHeight:Number;
		
		public function ShellBlock(blocktype:String)
		{
			super();
			_blockType = blocktype;
			_blockBack = new Sprite();
			var fillColor:uint;
			
			
			switch (_blockType) {
				case 'shellheader':
					fillColor = SHELL_COLORS.CLR_HEADER;
					_blockWidth = SHELL_VARS.HEADER_WIDTH;
					_blockHeight = SHELL_VARS.HEADER_HEIGHT;
					break;
				case 'shellfooter':
					fillColor = SHELL_COLORS.CLR_FOOTER;
					_blockWidth = SHELL_VARS.FOOTER_WIDTH;
					_blockHeight = SHELL_VARS.FOOTER_HEIGHT;
					break;
				default:
					trace('error of _blockType =' + _blockType);
					
			}
			_blockBack.graphics.beginFill(fillColor);
			_blockBack.graphics.drawRect(0,0,_blockWidth,_blockHeight);
			_blockBack.graphics.endFill();
			
			this.addChild(_blockBack);
		}
		
		public function changeBlock(fillColor:uint,fillAlpha:Number,frameSize:Number, frameColor:uint, frameAlpha:Number):void
		{
			_blockBack.graphics.clear();
			if (frameSize > 1) {
				_blockBack.graphics.lineStyle(frameSize,frameColor,frameAlpha);
			}
			_blockBack.graphics.beginFill(fillColor,fillAlpha);
			_blockBack.graphics.drawRect(0,0,_blockWidth,_blockHeight);
			_blockBack.graphics.endFill();
		}
	}
}