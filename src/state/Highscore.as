package state
{
	//------------------------------------------------------------------------
	// 	Evertron SDK
	//------------------------------------------------------------------------
	import entity.BackButton;
	
	import highscore.HighscoreData;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.system.Session;

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
		* 	background image
		*/
		private var _bgImg:BgImgTest;
		/*
		* 	Evertron Controls
		*/
		private var _controls:EvertronControls = new EvertronControls();
		private var _highscoreData:HighscoreData;
		private	var _score:Vector;
		private	var _name:Vector;
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
			initHighscore();
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
			disposeOverlay();
		}
		//------------------------------------------------------------------------
		// init layers
		//------------------------------------------------------------------------
		private function initLayers():void {
			initBackground();
			initHighscoreTable();
			initOverlay();
		}
		private function initHighscore():void {
			_highscoreData = new HighscoreData();
			_score = _highscoreData.score.<String>;
			_name = _highscoreData.name.<String>;
			if (_score.length == 0) {
				_score.push("00:00:00", "00:00:00", "00:00:00", "00:00:00", "00:00:00", "00:00:00", "00:00:00", "00:00:00", "00:00:00", "00:00:00");
			}
			if (_name.length == 0) {
				_name.push("michaela","michaela","michaela","michaela","michaela","michaela","michaela","michaela","michaela","michaela");
			}
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
			_layerHighscoreTable = layers.add("HIGHSCORE_TABLE");
			_layerHighscoreTable.x = 0;
			_layerHighscoreTable.y = 0;
			
			_btn.x = 400 - (_btn.width/2);
			_btn.y = 540;
			_btn.pulse();

			_layerHighscoreTable.addChild(_btn);
		}
		private function initOverlay():void {
			
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
			_layerHighscoreTable.removeChild(_btn); 
			_layerHighscoreTable = null;
			_btn = null;
			trace("dispose highscore table");
		}
		//------------------------------------------------------------------------
		// dispose background
		//------------------------------------------------------------------------
		private function disposeBackground():void {
			_layerBackground.removeChild(_bgImg);
			_layerBackground = null;
			_bgImg = null;	
		}
		private function disposeOverlay():void {
			trace("dispose overlay");
		}
	}
}1