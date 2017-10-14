package utils;

import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

class Text extends TextField {
	function new(width:Int, height:Int, text:String) {
		super();

		defaultTextFormat = new TextFormat("Verdana", 12, 0x000000, false);
		defaultTextFormat.align = TextFormatAlign.LEFT;

		this.width = width;
		this.height = height;
		this.text = text;
	}
	
}
