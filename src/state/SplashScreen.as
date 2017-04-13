package state
{
	import flash.display.MovieClip;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.system.Session;
	
	import state.Menu;
	
	public class SplashScreen extends DisplayState {
		/*
		* how long the splashscreen will show
		*/
		private const TIMER:int = 60; // 5 sec
		/*
		* background layer
		*/
		private const LAYER_BACKGROUND:String = "background_layer"
		/*
		* counts the updates. 60fps
		*/
		private var _counter:int = 0; // counter
		/*
		* background layer
		*/
		private var _layerBackground:DisplayStateLayer;
		/*
		* background img
		*/
		private var _backgroundImg:Splashscreen_test;
		//------------------------------------------------------------------------
		// constructor
		//------------------------------------------------------------------------
		public function SplashScreen(){
			super();
		}
		//------------------------------------------------------------------------
		// init
		//------------------------------------------------------------------------
		override public function init():void {
			trace("splashscreen splashscreen");
			initLayers();
		}
		//------------------------------------------------------------------------
		// update
		//------------------------------------------------------------------------
		override public function update():void {
			_counter++
			if (_counter == TIMER) { Session.application.displayState = new Menu; }
		}
		//------------------------------------------------------------------------
		// dispose
		//------------------------------------------------------------------------
		override public function dispose():void {
			trace("dispose");
		}
		private function initLayers():void {
			_backgroundImg = new Splashscreen_test;
			_layerBackground = layers.add(LAYER_BACKGROUND);
			
			_layerBackground.x = 0;
			_layerBackground.y = 0;
			
			_layerBackground.addChild(_backgroundImg);
		}
	}
}