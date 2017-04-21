package state
{
	//------------------------------------------------------------------------
	// 	Evertron SDK
	//------------------------------------------------------------------------
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.input.EvertronControls;
	//------------------------------------------------------------------------
	// 	entity
	//------------------------------------------------------------------------
	import entity.BackButton;
	import flash.net.SharedObject;

	//------------------------------------------------------------------------
	// 	Game Over State
	//------------------------------------------------------------------------
	public class GameOver extends DisplayState {
		/*
		*	background layer
		*/
		private var _layerBackground:DisplayStateLayer;
		/*
		*	overlay containing text and graphics
		*/
		private var _layerOverlay:DisplayStateLayer;
		/*
		*	back btn
		*/
		private var _btn:BackButton;
		/*
		*	background image
		*/
		private var _bgImg:BgImgTest;
		/*
		* 	Evertron Controls
		*/
		private var _controls:EvertronControls = new EvertronControls;
		//------------------------------------------------------------------------
		// constructor
		//------------------------------------------------------------------------
		public function GameOver(){
		}
		//------------------------------------------------------------------------
		// init
		//------------------------------------------------------------------------
		override public function init():void {
            trace("GAME OVER");
			initLayers();
			initSharedObj();
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
		
		private function initSharedObj():void
		{
			var players:SharedObject = SharedObject.getLocal("players");
			var game:int = players.data.players;
			trace(game);
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
			_layerOverlay.addChild(_btn);
		}
		//------------------------------------------------------------------------
		// change state -- > back to menu
		//------------------------------------------------------------------------
		private function changeState():void {
			if(Input.keyboard.justPressed(_controls.PLAYER_BUTTON_1) == true){
				Session.application.displayState = new Menu; 
			}
		}
		//------------------------------------------------------------------------
		// dispose background
		//------------------------------------------------------------------------
		private function disposeBackground():void {
			trace("dispose game over background");
		}
		//------------------------------------------------------------------------
		// dispose overlay
		//------------------------------------------------------------------------
		private function disposeOverlay():void {
			trace("dispose game over overlay");
		}
	}
}