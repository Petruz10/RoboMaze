package state
{
	//------------------------------------------------------------------------
	// 	Evertron SDK
	//------------------------------------------------------------------------
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.media.SoundObject;
	//------------------------------------------------------------------------
	// 	Project Imports
	//------------------------------------------------------------------------
	import entity.BackButton;
	//------------------------------------------------------------------------
	// 	
	//	CREDITS STATE
	//
	//------------------------------------------------------------------------
	public class Credits extends DisplayState {
		/*
		* 	background layer
		*/
		private var _layerBackground:DisplayStateLayer;
		/*
		* 	overlay // text // back btn etc.
		*/
		private var _background:Menu_Background_mc;
		/*
		*	back btn 
		*/
		private var _layerOverlay:DisplayStateLayer;
		/*
		*	back btn 
		*/
		private var _menuBtn:BackButton;
		/*
		*	controls
		*/
		private var _controls:EvertronControls;
		/*
		*	header
		*/
		private var _header:Credits_mc;
		/*
		*	music
		*/
		private var _backgroundMusic:SoundObject;
		//------------------------------------------------------------------------
		// 	constructor
		//------------------------------------------------------------------------
		public function Credits(){
			super();
		}
		//------------------------------------------------------------------------
		// 	init
		//------------------------------------------------------------------------
		override public function init():void {
			initControls();
			initSound();
			initLayers();
		}
		//------------------------------------------------------------------------
		// 	update
		//------------------------------------------------------------------------
		override public function update():void {
			changeState();
		}
		//------------------------------------------------------------------------
		// 	dispose
		//------------------------------------------------------------------------
		override public function dispose():void {
			_controls = null;
			disposeBackground();
			disposeOverlay();
		}
		//------------------------------------------------------------------------
		// 	init controls
		//------------------------------------------------------------------------
		private function initControls():void {
			_controls = new EvertronControls();
		}
		//------------------------------------------------------------------------
		// 	init sound
		//------------------------------------------------------------------------
		private function initSound():void {
			Session.sound.musicChannel.sources.add("highscore_credits", BackgroundCredits_mp3);
			_backgroundMusic = Session.sound.musicChannel.get("highscore_credits");
			_backgroundMusic.volume = 0.4;
			_backgroundMusic.play(10);
		}
		//------------------------------------------------------------------------
		// 	init layers
		//------------------------------------------------------------------------
		private function initLayers():void {
			initBackground();
			initOverlay();
		}
		private function initBackground():void {
			_background = new Menu_Background_mc();
			_background.x = 0;
			_background.y = 0;

			_layerBackground = layers.add("CREDITS_BG");
			_layerBackground.x = 0;
			_layerBackground.y = 0;
			
			_header = new Credits_mc();
			_header.x = 115;
			_header.y = 10;
			
			_layerBackground.addChild(_background);
			_layerBackground.addChild(_header);
		}
		//------------------------------------------------------------------------
		// 	init "menu" --> back btn
		//------------------------------------------------------------------------
		private function initOverlay():void {
			var _creditsAnimation:CreditsRobot_mc = new CreditsRobot_mc();
			_menuBtn = new BackButton();
			_layerOverlay = layers.add("BACK_BTN");
			_layerOverlay.x = 0;
			_layerOverlay.y = 0;
			
			_creditsAnimation.x = 400 - (_creditsAnimation.width / 2);
			_creditsAnimation.y = 110;
			
			_menuBtn.x = 400 - (_menuBtn.width/2);
			_menuBtn.y = 550;
			_menuBtn.pulse();
			
			_layerOverlay.addChild(_creditsAnimation);
			_layerOverlay.addChild(_menuBtn);
		}
		//------------------------------------------------------------------------
		// 	change state
		//------------------------------------------------------------------------
		private function changeState():void {
			if(Input.keyboard.justPressed(_controls.PLAYER_BUTTON_1) == true){
				Session.application.displayState = new Menu; 
			}
		}
		//------------------------------------------------------------------------
		// 
		//	DISPOSE METHODS
		//
		//------------------------------------------------------------------------
		//------------------------------------------------------------------------
		// 	dispose controls
		//------------------------------------------------------------------------
		private function disposeControls():void {
			_controls = null;
		}
		//------------------------------------------------------------------------
		// 	dispose background
		//------------------------------------------------------------------------
		private function disposeBackground():void {
			_layerBackground.removeChild(_background);
			_layerBackground.removeChild(_header);
			_background = null;
			_header = null;
			_layerBackground = null;
		}
		//------------------------------------------------------------------------
		// 	dispose overlay
		//------------------------------------------------------------------------
		private function disposeOverlay():void {
			_menuBtn = null;
			_layerOverlay = null;
		}
	}
}