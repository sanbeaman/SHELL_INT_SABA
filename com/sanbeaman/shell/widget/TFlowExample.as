package com.sanbeaman.shell.widget
{
	import flash.display.Sprite;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.FontStyle;
	import flashx.textLayout.compose.StandardFlowComposer;
	import flashx.textLayout.container.ContainerController;
	import flashx.textLayout.edit.SelectionManager;
	import flashx.textLayout.elements.*;
	import flashx.textLayout.formats.TextAlign;
	
	
	public class TFlowExample extends Sprite
	{
		public function TFlowExample()
		{
		var textFlow:TextFlow = new TextFlow();
		var p:ParagraphElement = new ParagraphElement();
		var span:SpanElement = new SpanElement();
		span.text = "Shall I compare thee to a summer's day?\n\
			Thou art more lovely and more temperate.\n\
			Rough winds do shake the darling buds of May,\n\
			And summer's lease hath all too short a date.\n\
			Sometime too hot the eye of heaven shines,\n\
			And often is his gold complexion dimmed;\n\
			And every fair from fair sometime declines,\n\
			By chance, or nature's changing course, untrimmed;\n\
			But thy eternal summer shall not fade,\n\
			Nor lose possession of that fair thou ow'st,\n\
			Nor shall death brag thou wand'rest in his shade,\n\
			When in eternal lines to Time thou grow'st.\n\
			So long as men can breathe, or eyes can see,\n\
			So long lives this, and this gives life to thee.\n\
			\u2014William Shakespeare";
		p.addChild(span);
		textFlow.addChild(p);
		
		//create an IFlowComposer
		var composer:StandardFlowComposer = new StandardFlowComposer();
		//assign it to the story
		textFlow.flowComposer = composer;
		
		var COUNT:int = 14;
		var RADIUS:Number = stage.stageWidth * 0.7;
		var ORIGIN:Point = new Point(stage.stageWidth/2, stage.stageHeight - 20);
		for (var theta:Number = 0; theta <= Math.PI; theta += Math.PI/COUNT) {
			//create a sprite for each container
			var sprite:Sprite = new Sprite();
			sprite.x = -RADIUS * Math.cos(theta) + ORIGIN.x;
			sprite.y = -RADIUS * Math.sin(theta) + ORIGIN.y;
			sprite.rotation = theta / Math.PI * 180;
			addChild(sprite);
			//create a controller for each container, and add it to the composer
			composer.addController(new ContainerController(sprite, RADIUS-50, 20));
		}
		
		textFlow.textAlign = TextAlign.END;
		textFlow.fontFamily = "Garamond, _serif";
		textFlow.fontStyle = FontStyle.ITALIC;
		textFlow.fontSize = 14;
		textFlow.color = 0xd09000;
		
		
		
		textFlow.interactionManager = new SelectionManager();
		//instruct the composer to flow the text into its containers
		textFlow.flowComposer.updateAllControllers();
	}
}
}