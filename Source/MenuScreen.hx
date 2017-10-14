package;

import scenes.BunnyScene;
import scenes.StarlingImagesScene;


import openfl.display.Sprite;

import openfl.text.TextField;

import utils.Button;
import utils.Text;
import openfl.events.MouseEvent;


class MenuScreen extends Sprite {
	public function new(main:Main) {
		super();
		init(main);
	}
	
	private function init(main:Main) {
		//var logo:Image = new Image(Game.assets.getTexture("logo"));
		//addChild(logo);
		
		var scenesToCreate:Array<Array<Dynamic>> = [
			["Bunny", BunnyScene],
			["Starling Images", StarlingImagesScene],
		];

		var count:Int = 0;
		
		for (sceneToCreate in scenesToCreate) {
			var sceneTitle:String = sceneToCreate[0];
			var sceneClass:Class<Dynamic>  = sceneToCreate[1];
			
			var button:Button = new Button(150, 22, sceneTitle);
			button.x = count % 2 == 0 ? 30 : 190;
			button.y = 155 + Std.int(count / 2) * 46;
			button.name = Type.getClassName(sceneClass);
			button.addEventListener(MouseEvent.CLICK, main.onButtonTriggered);
			addChild(button);
			
			if (scenesToCreate.length % 2 != 0 && count % 2 == 1)
				button.y += 24;
			
			count++;
		}
		
		// show information about rendering method (hardware/software)
		
		var driverInfo:String = "Driver: ";//Starling.current.context.driverInfo;
		var infoText:TextField = new Text(600, 64, driverInfo);
		infoText.x = 5;
		infoText.y = 475;
		addChild(infoText);

		var copyright = new Text(400, 20, "Copyright 2017, InnoGames GmbH");
		copyright.x = 5;
		copyright.y = 500;
		addChild(copyright);
	}
}