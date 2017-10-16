package;

import scenes.BunnyScene;
import scenes.StarlingImagesScene;
import scenes.DisplayListUIScene;
import scenes.StarlingUIScene;
import scenes.FilterScene;
import openfl.display.Sprite;

import openfl.text.TextField;

import utils.Button;
import utils.Text;
import openfl.events.MouseEvent;
import openfl.events.Event;

/**
	The Menu screen displays the main menu.
**/
class MenuScreen extends Sprite {
	private var _main:Main;
	private var _scenesToCreate:Array<Array<Dynamic>> = [
		["Bunny", BunnyScene],
		["Filter", FilterScene],
		["DisplayList UI", DisplayListUIScene],
		["Starling UI", StarlingUIScene],
		["Starling Images", StarlingImagesScene],
	];
	private var _scenesClassNames = ["scenes.BunnyScene", "scenes.FilterScene", "scenes.DisplayListUIScene", "scenes.StarlingUIScene", "scenes.StarlingImagesScene"];

	public function new(main:Main) {
		super();
		init(main);
	}
	
	private function init(main:Main) {
		//var logo:Image = new Image(Game.assets.getTexture("logo"));
		//addChild(logo);
		_main = main;
		


		var count:Int = 0;
		
		for (sceneToCreate in _scenesToCreate) {
			var sceneTitle:String = sceneToCreate[0];
			var sceneClass:Class<Dynamic>  = sceneToCreate[1];
			
			var button:Button = new Button(150, 22, sceneTitle);
/*			button.x = count % 2 == 0 ? 30 : 190;
			button.y = 155 + Std.int(count / 2) * 46;*/
			button.x = 30;
			button.y = 155 + count * 30;
			button.name = Type.getClassName(sceneClass);
			button.addEventListener(MouseEvent.CLICK, onButtonTriggered);
			addChild(button);
			
			count++;
		}

		var button:Button = new Button(150, 22, "Run all");
		button.x = 30;
		button.y = 400;
		button.name = "all";
		button.addEventListener(MouseEvent.CLICK, onButtonTriggered);
		addChild(button);

		var button:Button = new Button(150, 22, "Run all");
		button.x = 30;
		button.y = 400;
		button.name = "all";
		button.addEventListener(MouseEvent.CLICK, onButtonTriggered);
		addChild(button);

		
		// show information about rendering method (hardware/software) 
		// fails on some openfl versions

		//main.stage.stage3Ds[0].addEventListener( Event.CONTEXT3D_CREATE, onInitStage3D );
		//main.stage.stage3Ds[0].requestContext3D();	
		
		/*var driverInfo:String = "Driver: ";//Starling.current.context.driverInfo;
		var infoText:TextField = new Text(600, 64, driverInfo);
		infoText.x = 5;
		infoText.y = 475;
		addChild(infoText);

		var copyright = new Text(400, 20, "Copyright 2017, InnoGames GmbH");
		copyright.x = 5;
		copyright.y = 500;
		addChild(copyright);*/
	}

	private function onButtonTriggered(event: Event) {
		var button:Button = cast(event.target, Button);
		var runList:Array<String>;
		if(button.name == "all") {
			runList = _scenesClassNames;
		}
		else {
			runList = [button.name];
		}

		_main.onMenuButton(runList);
	}

	/*private function onInitStage3D(e: Event) {
		trace(stage.stage3Ds[0].context3D.driverInfo);
	}*/
}