package com.sanbeaman.shell.ui
{
		import flash.display.Sprite;
		import flash.display.DisplayObject;
		import flash.geom.Rectangle;
		import flash.text.engine.TextLine;
		
		import flashx.textLayout.elements.ParagraphElement;
		import flashx.textLayout.elements.SpanElement;
		import flashx.textLayout.elements.TextFlow;
		import flashx.textLayout.factory.TextFlowTextLineFactory;
		import flashx.textLayout.formats.TextLayoutFormat;
		
		public class TextFlowTextLineFactory_example extends Sprite
		{
			public function TextFlowTextLineFactory_example()
			{
				var factory:TextFlowTextLineFactory = new TextFlowTextLineFactory();
				factory.compositionBounds = new Rectangle( 100, 100, 200, 130 );
				
				var flow:TextFlow = new TextFlow();
				
				var format:TextLayoutFormat = new TextLayoutFormat();
				format.fontFamily = "LilyUPC, Verdana, _sans";
				format.fontSize = 32;
				format.color = 0x000000;
				format.textAlpha = .5;
				
				var span:SpanElement = new SpanElement();
				span.text = "The quick brown fox jumped over the lazy dog.";            
				span.format = format;
				
				var para:ParagraphElement = new ParagraphElement();
				para.addChild( span );
				
				flow.addChild( para );
				
				factory.createTextLines( useTextLines, flow );
				
				factory.compositionBounds = new Rectangle( 99, 99, 200, 130 );
				format.color = 0x990000;
				format.textAlpha = 1;
				span.format = format;
				factory.createTextLines( useTextLines, flow );
				
				graphics.beginFill(0x555555,.5);
				graphics.drawRect( 99, 99, 201, 131 );
				graphics.endFill();
				
			}
			
			private function useTextLines( lineOrShape:DisplayObject ):void
			{
				this.addChild( lineOrShape );
			}
			
		}
	}
