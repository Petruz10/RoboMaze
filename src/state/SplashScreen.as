package state
{
	import flash.display.MovieClip;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.system.Session;
	
	import state.Menu;
	import se.lnu.stickossdk.media.SoundObject;
	
	public class SplashScreen extends DisplayState {
		/*
		* how long the splashscreen will show
		*/
		private const TIMER:int = 300; // 5 sec
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
		/*
		* background img
		*/
		private var _backgroundMusic:SoundObject;
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
			initLayers();
			initSound();
		}
		//------------------------------------------------------------------------
		// update
		//------------------------------------------------------------------------
		override public function update():void {
			updateCounter();
		}
		//------------------------------------------------------------------------
		// dispose
		//------------------------------------------------------------------------
		override public function dispose():void {
			_layerBackground.removeChild(_backgroundImg);
			_backgroundImg = null;
			_layerBackground = null;
		}
		//------------------------------------------------------------------------
		// update counter
		//------------------------------------------------------------------------
		private function updateCounter():void {
			_counter++
			if (_counter == TIMER) { Session.application.displayState = new Menu; }
			if (_counter == 240) {
				updateSound();
			}
		}
		//------------------------------------------------------------------------
		// update sound
		//------------------------------------------------------------------------
		private function updateSound():void {
			_backgroundMusic.fade(0.0, 1000);
		}
		//------------------------------------------------------------------------
		// init layers
		//------------------------------------------------------------------------
		private function initLayers():void {
			_backgroundImg = new Splashscreen_test;
			_layerBackground = layers.add(LAYER_BACKGROUND);
			
			_layerBackground.x = 0;
			_layerBackground.y = 0;
			
			_layerBackground.addChild(_backgroundImg);
		}
		//------------------------------------------------------------------------
		// init sound
		//------------------------------------------------------------------------
		private function initSound():void {
			Session.sound.musicChannel.sources.add("splashscreen", SplashScreenSound);
			_backgroundMusic = Session.sound.musicChannel.get("splashscreen");
			_backgroundMusic.volume = 0.4;
			_backgroundMusic.play();
		}
	}
}