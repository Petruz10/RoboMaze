package state
{
	import component.HUD;
	import component.SingleplayerHUD;
	
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
		* 	background layer
		*/
		private var _bgImg:BgImgTest;
		/*
		*	back btn 
		*/
		private var _btn:BackButton;
		/*
		*	controls
		*/
		private var _controls:EvertronControls = new EvertronControls;
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
			_bgImg = new BgImgTest();

			_layerBackground = layers.add("MENU_BG");
			_layerBackground.x = 0;
			_layerBackground.y = 0;
			
			_layerBackground.addChild(_bgImg);
		}
		//------------------------------------------------------------------------
		// init "menu" --> back btn
		//------------------------------------------------------------------------
		private function initOverlay():void {
			_btn = new BackButton();
			_layerOverlay = layers.add("BACK_BTN");
			_layerOverlay.x = 0;
			_layerOverlay.y = 0;
			_btn.x = 0;
			_btn.y = 540;
			
			var hud:SingleplayerHUD = new SingleplayerHUD();
			_layerOverlay.addChild(hud);
			_layerOverlay.addChild(_btn);
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
			_bgImg = null;
			_layerBackground = null;
		}
		//------------------------------------------------------------------------
		// dispose overlay
		//------------------------------------------------------------------------
		private function disposeOverlay():void {
			_btn = null;
			_layerOverlay = null;
		}
	}
}