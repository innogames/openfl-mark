package;

import openfl.ui.Keyboard;

import starling.core.Starling;

import starling.events.KeyboardEvent;
import openfl.system.Capabilities;

import starling.textures.Texture;
import starling.textures.TextureAtlas;
import starling.utils.AssetManager;
import starling.display.Sprite;

import openfl.Assets;


@:keep class Game extends Sprite {

    
    private static var sAssets:AssetManager;
    
    public function new() {
        super();
        // nothing to do here -- Startup will call "start" immediately.
    }
    
    public function start() {
        sAssets = loadAssets();

        //addEventListener(Event.TRIGGERED, onButtonTriggered);
        stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
    }

    
    private function loadAssets():AssetManager {
        var assets:AssetManager = new AssetManager();

        assets.verbose = Capabilities.isDebugger;

        var atlasTexture:Texture = Texture.fromBitmapData(Assets.getBitmapData("assets/textures/1x/atlas.png"), false);
        var atlasXml:Xml = Xml.parse(Assets.getText("assets/textures/1x/atlas.xml")).firstElement();
/*            var bitmapFont = new BitmapFont(desyrelTexture, desyrelXml);
        TextField.registerCompositor(bitmapFont, bitmapFont.name);*/
        assets.addTexture("atlas", atlasTexture);
        assets.addTextureAtlas("atlas", new TextureAtlas(atlasTexture, atlasXml));

        return assets;
    }

    private function onKey(event:KeyboardEvent) {
        if (event.keyCode == Keyboard.SPACE)
            Starling.current.showStats = !Starling.current.showStats;
        else if (event.keyCode == Keyboard.X)
            Starling.current.context.dispose();
    }
    
    
    public static var assets(get, never):AssetManager;
    @:noCompletion private static function get_assets():AssetManager { return sAssets; }
}