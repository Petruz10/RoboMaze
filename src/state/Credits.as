package state
{
	import entity.BackButton;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.system.Session;

	
	public class Credits extends DisplayState {
		/*
		* 	background layer
		*/
		private var _layerBackground:DisplayStateLayer;
		/*
		* 	overlay // text // back btn etc.
		*/
		private var _layerOverlay:DisplayStateLayer;
		/*
		*	back btn 
		*/
		private var _menuBtn:BackButton;
		/*
		*	controls
		*/
		private var _controls:EvertronControls = new EvertronControls;
		/*
		*
		*/
		private var _header:ScreenTop_mc;
		//------------------------------------------------------------------------
		// constructor
		//------------------------------------------------------------------------
		public function Credits(){
			super();
		}
		//------------------------------------------------------------------------
		// init
		//------------------------------------------------------------------------
		override public function init():void {
			initLayers();
			Session.application.displayState = new GameOver;
		}
		//------------------------------------------------------------------------
		// update
		//------------------------------------------------------------------------
		override public function update():void {
			changeState();
		}
		//------------------------------------------------------------------------
		// dispose
		//------------------------------------------------------------------------
		override public function dispose():void {
			_controls = null;
			disposeBackground();
			disposeOverlay();
		}
		//------------------------------------------------------------------------
		// init layers
		//------------------------------------------------------------------------
		private function initLayers():void {
			initBackground();
			initOverlay();
		}
		private function initBackground():void {
			_header = new ScreenTop_mc();
			_layerBackground = layers.add("CREDITS_BG");
			_layerBackground.x = 0;
			_layerBackground.y = 0;
			
			_header.x = 0;
			_header.y = 0;
			_header.gotoAndStop("credits");
			
			_layerBackground.addChild(_header);
		}
		//------------------------------------------------------------------------
		// init "menu" --> back btn
		//------------------------------------------------------------------------
		private function initOverlay():void {
			_menuBtn = new BackButton();
			_layerOverlay = layers.add("BACK_BTN");
			_layerOverlay.x = 0;
			_layerOverlay.y = 0;
			_menuBtn.x = 400 - (_menuBtn.width/2);
			_menuBtn.y = 540;
			_menuBtn.pulse();
			
			_layerOverlay.addChild(_menuBtn);
		}
		//------------------------------------------------------------------------
		// change state
		//------------------------------------------------------------------------
		private function changeState():void {
			if(Input.keyboard.justPressed(_controls.PLAYER_BUTTON_1) == true){
				Session.application.displayState = new Menu; 
			}
		}
		//-------------------------------------eed-----------------------------------
		// dispose background
		//------------------------------------------------------------------------
		private function disposeBackground():void {
			_layerBackground.removeChild(_header);
			_header = null;
			_layerBackground = null;
		}
		//------------------------------------------------------------------------
		// dispose overlay
		//------------------------------------------------------------------------
		private function disposeOverlay():void {
			_menuBtn = null;
			_layerOverlay = null;
		}
	}
}