package state
{
	//------------------------------------------------------------------------
	// 	Evertron SDK
	//------------------------------------------------------------------------
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.input.EvertronControls;
	//------------------------------------------------------------------------
	// 	entity
	//------------------------------------------------------------------------
	import entity.BackButton;
	//------------------------------------------------------------------------
	// 	Highscore State
	//------------------------------------------------------------------------
	public class Highscore extends DisplayState {
		/*
		*	background img.
		*/
		private var _layerBackground:DisplayStateLayer;
		/*
		* 	layer for higscore display
		*/
		private var _layerHighscoreTable:DisplayStateLayer;
		/*
		* 	back btn
		*/
		private var _btn:BackButton;
		/*
		* 	test animation
		*/
		private var _circuitBoard:CircuitBoard_mc;
		/*
		* 	test animation
		*/
		private var _battery:BatteryRefill_mc;
		/*
		* 	background image
		*/
		private var _bgImg:BgImgTest;
		/*
		* 	Evertron Controls
		*/
		private var _controls:EvertronControls = new EvertronControls;
			
		//------------------------------------------------------------------------
		// constructor
		//------------------------------------------------------------------------
		public function Highscore(){
			trace("HIGHSCORE");
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
			disposeHighscoreTable();
		}
		//------------------------------------------------------------------------
		// constructor
		//------------------------------------------------------------------------
		private function initLayers():void {
			initBackground();
			initHighscoreTable();
		}
		//------------------------------------------------------------------------
		// init background
		//------------------------------------------------------------------------
		private function initBackground():void {
			_bgImg = new BgImgTest();
			_layerBackground = layers.add("HIGHSCORE_BG");
			_layerBackground.x = 0;
			_layerBackground.y = 0;
			_layerBackground.addChild(_bgImg);
		}
		//------------------------------------------------------------------------
		// init background
		//------------------------------------------------------------------------
		private function initHighscoreTable():void {
			_btn = new BackButton();
			_circuitBoard = new CircuitBoard_mc;
			_battery = new BatteryRefill_mc();

			_layerHighscoreTable = layers.add("HIGHSCORE_TABLE");
			_layerHighscoreTable.x = 0;
			_layerHighscoreTable.y = 0;

			_btn.x = 0;
			_btn.y = 540;
			_battery.x = 200;
			_battery.y = 540;
			_circuitBoard.x = 100;
			_circuitBoard.y = 540;
			_layerHighscoreTable.addChild(_battery);
			_layerHighscoreTable.addChild(_circuitBoard);
			_layerHighscoreTable.addChild(_btn);
		}
		//------------------------------------------------------------------------
		// making sure that the player can return to menu
		//------------------------------------------------------------------------
		private function changeState():void {
			if(Input.keyboard.justPressed(_controls.PLAYER_BUTTON_1) == true){
				Session.application.displayState = new Menu; 
			}
		}
		//------------------------------------------------------------------------
		// dispose highscore table
		//------------------------------------------------------------------------
		private function disposeHighscoreTable():void {
			
		/*	var numCh:int = _layerHighscoreTable.numChildren;
			while (numCh > 0) { _layerHighscoreTable.removeChildAt(0); trace("removing"); }
			_btn = null;
			_layerHighscoreTable = null; */
			
			trace("dispose highscore table");
		}
		//------------------------------------------------------------------------
		// dispose background
		//------------------------------------------------------------------------
		private function disposeBackground():void {
		 	/*	
			var numCh:int = _layerBackground.numChildren;
			while (numCh > 0) { _layerBackground.removeChildAt(0); }

			_bgImg = null;
			_layerBackground = null; */		

			trace("dispose highscore background");
		}
	}
}