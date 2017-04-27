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

	import entity.Button;
	import flash.net.SharedObject;
	import game.Multiplayer;
	import game.Singleplayer;


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
		*	retry the game
		*/
		private var _retryBtn:Button;1
		/*
		*	background image
		*/
		private var _bgImg:BgImgTest;
		/*
		* 	Evertron Controls
		*/
		private var _controls:EvertronControls = new EvertronControls;
		/*
		*	current menu choice
		*/
		private var _menuBtn:int; 
		private var _game:int;
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
			_game = players.data.players;
			trace(_game);
		}
		private function initBackground():void {
			_bgImg = new BgImgTest();
		1
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
				if(_menuBtn == 0) {
					Session.application.displayState = new Menu;
				} 
				else if ((_menuBtn == 0) && (_game == 1)) {
					Session.application.displayState = new Singleplayer;
				}
				else if ((_menuBtn == 1) && (_game == 2)) {
					Session.application.displayState = new Multiplayer;
				}
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