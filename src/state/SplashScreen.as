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
		* 	how long the splashscreen will show
		*/
		private const TIMER:int = 300; // 5 sec
		/*
		* 	background layer
		*/
		private const LAYER_BACKGROUND:String = "background_layer"
		/*
		* 	background layer
		*/
		private const LAYER_OVERLAY:String = "overlay_layer"
		/*
		* 	counts the updates. 60fps
		*/
		private var _counter:int = 0; // counter
		/*
		*	overlay
		*/ 
		private var _layerOverlay:DisplayStateLayer;
		/*
		* 	Michaela
		*/
		private var _michaela:MichaelaBot_mc;
		/*	
		*	Petra
		*/
		private var _petra:PetraBot_mc;
		/*
		*	Background Sound
		*/
		private var _names:SplashNames_mc;
		/*
		*
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
			_layerOverlay.removeChild(_michaela);
			_layerOverlay.removeChild(_petra);

			_michaela = null;
			_petra = null;

			_layerOverlay = null;
		}
		//------------------------------------------------------------------------
		// update counter
		//------------------------------------------------------------------------
		private function updateCounter():void {
			_counter++
			if (_counter == TIMER) { Session.application.displayState = new Menu, 4000 }
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
			//initBackground();
			initOverlay();

		}
		private function initOverlay():void {
			_michaela = new MichaelaBot_mc;
			_petra = new PetraBot_mc;
			_names = new SplashNames_mc;

			_michaela.x = 78;
			_michaela.y = 43;

			_petra.x = 423;
			_petra.y = 73;

			_names.x = 400 - (_names.width / 2);
			_names.y = 410;
			
			_layerOverlay = layers.add(LAYER_OVERLAY);
			_layerOverlay.x = 0;
			_layerOverlay.y = 0;

			_layerOverlay.addChild(_michaela);
			_layerOverlay.addChild(_petra);
			_layerOverlay.addChild(_names);
		}
		//------------------------------------------------------------------------
		// init sound
		//------------------------------------------------------------------------
		private function initSound():void {
			Session.sound.musicChannel.sources.add("splashscreen", Background_Splashscreen_mp3);
			_backgroundMusic = Session.sound.musicChannel.get("splashscreen");
			_backgroundMusic.volume = 0.4;
			_backgroundMusic.play();
		}
	}
}