package state
{
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.input.Input;
	import entity.BackButton;
	
	public class Highscore extends DisplayState {
		/*
		* background img.
		*/
		private var _layerBackground:DisplayStateLayer;
		/*
		* layer for higscore display
		*/
		private var _layerHighscoreTable:DisplayStateLayer;
		/*
		*	btn layer -> back-btn leading to main menu
		*/
		private var _layerBtn:DisplayStateLayer;
		//------------------------------------------------------------------------
		// constructor
		//------------------------------------------------------------------------
		public function Highscore(){
			trace("HIGHSCORE");
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
			trace("dispose");
		}
		//------------------------------------------------------------------------
		// constructor
		//------------------------------------------------------------------------
		private function initLayers():void {
			initBackground();
			initHighscoreTable();
			initButton();
		}
		//------------------------------------------------------------------------
		// init background
		//------------------------------------------------------------------------
		private function initBackground():void {
			var bgImg:BgImgTest = new BgImgTest();
			_layerBackground = layers.add("HIGHSCORE_BG");
			_layerBackground.x = 0;
			_layerBackground.y = 0;
			_layerBackground.addChild(bgImg);
		}
		private function initHighscoreTable():void {
			_layerHighscoreTable = layers.add("HIGHSCORE_TABLE");
			_layerHighscoreTable.x = 0;
			_layerHighscoreTable.y = 0;
		}
		//------------------------------------------------------------------------
		// init "menu" --> back btn
		//------------------------------------------------------------------------
		private function initButton():void {
			var btn:BackButton = new BackButton();
			var battery:BatteryRefill_mc = new BatteryRefill_mc();
			_layerBtn = layers.add("BACK_BTN");
			_layerBtn.x = 0;
			_layerBtn.y = 0;
			btn.x = 0;
			btn.y = 540;
			battery.x = 200;
			battery.y = 540;
			_layerBtn.addChild(battery);
			_layerBtn.addChild(btn);

		}
		private function changeState():void {
			if(Input.keyboard.justPressed("SPACE") == true){
				Session.application.displayState = new Menu; 
			}
		}
	}
}