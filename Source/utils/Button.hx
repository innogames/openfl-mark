package utils;

import openfl.display.Sprite;
import openfl.display.Shape;
import openfl.display.SimpleButton;

import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;


class Button extends SimpleButton {
	private var _sprite:Sprite;

	public function new(width:Int, height:Int, text:String) {
		super();

		var format = new TextFormat("Verdana", 14, 0x000000, true);
		format.align = TextFormatAlign.CENTER;

		var textField = new TextField();
		textField.width = width;
		textField.height = height;
		textField.text = text;
		textField.defaultTextFormat = format;
		//textField.mouseEnabled = false;

		var rectangleShape:Shape = new Shape();
		rectangleShape.graphics.beginFill(0xCCCCCC);
		rectangleShape.graphics.drawRect(0, 0, width, height);
		rectangleShape.graphics.endFill();

		var buttonSprite:Sprite = new Sprite();
		buttonSprite.addChild(rectangleShape);
		buttonSprite.addChild(textField);

		upState = buttonSprite;
		overState = buttonSprite;
		downState = buttonSprite;
		hitTestState = buttonSprite;
	}
}