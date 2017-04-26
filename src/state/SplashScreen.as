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
		private const TIMER:int = 180; // 3 sec
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
		private var _backgroundImg:SplashScreenLogo_mc;
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
			if (_counter == TIMER) { Session.application.displayState = new Menu, 1000 }
			if (_counter == 120) {
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
			_backgroundImg = new SplashScreenLogo_mc;
			_backgroundImg.x = 350;
			_backgroundImg.y = 270;
			_backgroundImg.play();
			
			_layerBackground = layers.add(LAYER_BACKGROUND);
			_layerBackground.x = 0;
			_layerBackground.y = 0;
			_layerBackground.addChild(_backgroundImg);
		}
		//------------------------------------------------------------------------
		// init sound
		//------------------------------------------------------------------------
		private function initSound():void {
			Session.sound.musicChannel.sources.add("splashscreen", SplashSound_mp3);
			_backgroundMusic = Session.sound.musicChannel.get("splashscreen");
			_backgroundMusic.volume = 0.4;
			_backgroundMusic.play();
		}
	}
}