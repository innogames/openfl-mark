package;

import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.system.System;
import openfl.display.StageScaleMode;

import utils.Button;


import openfl.events.Event;


class Main extends Sprite {
    private var _mainMenu:MenuScreen;
    private var _benchmark:Benchmark;
    private var _background:Bitmap;
    private var _resultsScreen:ResultsScreen;

    public function new() {
        super();
        if (stage != null) start();
        else addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }

    private function onAddedToStage(event:Dynamic) {
        removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		
		stage.scaleMode = StageScaleMode.NO_SCALE;
		
        start();
    }

    private function start() {

        initElements();

        _benchmark = new Benchmark(this);
        showMainMenu();
    }



    private function initElements() {
        // Add background image.

        //_background = new Bitmap(Assets.getBitmapData("assets/textures/1x/background.jpg"));
        //_background.smoothing = true;
        //addChild(_background);

    }
    
    
    public function onButtonTriggered(event:Event) {
        var button:Button = cast(event.target, Button);
        
        hideMainMenu();

        showBenchmark();
        _benchmark.showScene(button.name);
    }

    public function onBenchmarkStop() {
        hideBenchmark();
        showMainMenu();
    }
    
    public function onBenchmarkComplete(r:Result) {
        hideBenchmark();
        showResultsScreen([r]);
    }

    public function onResultsClose(event:Event) {
        hideResultsScreen();
        showMainMenu();
    }

    private function showMainMenu() {
        // now would be a good time for a clean-up
        System.gc();
        
        if (_mainMenu == null)
            _mainMenu = new MenuScreen(this);
        
        addChild(_mainMenu);
    }

    private function hideMainMenu() {
        removeChild(_mainMenu);
        _mainMenu = null;
    }

    private function showBenchmark() {
        addChild(_benchmark);
    }

    private function hideBenchmark() {
        removeChild(_benchmark);
        //_benchmark = null;
    }

    private function showResultsScreen(r:Array<Result>) {
        _resultsScreen = new ResultsScreen(this, r);
        addChild(_resultsScreen);
    }

    private function hideResultsScreen() {
        removeChild(_resultsScreen);
        _resultsScreen = null;
    }
}