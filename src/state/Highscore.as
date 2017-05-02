package state
{
	//------------------------------------------------------------------------
	// 	Evertron SDK
	//------------------------------------------------------------------------
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import entity.BackButton;
	
	import font.GameFont;
	
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
		private var _header:ScreenTop_mc;
		/*
		* 	back btn
		*/
		private var _btn:BackButton;
		/*
		* 	Evertron Controls
		*/
		private var _controls:EvertronControls = new EvertronControls();
		/*
		* 	highscore data
		*/
		private var _highscoreData:HighscoreData;
		/*
		* 	score - time
		*/
		private	var _score:Vector.<String>;
		/*
		* 	names
		*/
		private	var _name:Vector.<String>;
		/*
		* 	font
		*/
		private var _gameFont:GameFont
		private var _nameT:TextField;
		private var _scoreT:TextField;
		private var _highscoreF:TextFormat;
		//------------------------------------------------------------------------
		// constructor
		//------------------------------------------------------------------------
		public function Highscore(){
		}
		//------------------------------------------------------------------------
		// init
		//------------------------------------------------------------------------
		override public function init():void {
			initHighscore();
			initLayers();
			initFont();
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
		private function initFont():void {
			_gameFont = new GameFont();
		}
		//------------------------------------------------------------------------
		// init layers
		//------------------------------------------------------------------------
		private function initLayers():void {
			initBackground();
			initHighscore();
			initHighscoreTable();
			initLists();
			initOverlay();
		}
		private function initHighscore():void {
			_highscoreData = new HighscoreData();
			_score = _highscoreData.score;
			_name = _highscoreData.name;
			if (_score.length == 0) {
				_score.push("00:00:00", "00:00:00", "00:00:00", "00:00:00", "00:00:00", "00:00:00", "00:00:00", "00:00:00", "00:00:00", "00:00:00");
			}
			if (_name.length == 0) {
				_name.push("michaelajättelångtnamn","michaelajättelångtnamn","michaela3","michaela4","michaela5","michaela6","michaela7","michaela8","michaela9","michaela10");
			}
		}
		//------------------------------------------------------------------------
		// init background
		//------------------------------------------------------------------------
		private function initBackground():void {
			_header = new ScreenTop_mc();
			_layerBackground = layers.add("HIGHSCORE_BG");
			_layerBackground.x = 0;
			_layerBackground.y = 0;
			
			_header.x = 0;
			_header.y = 0;
			_header.gotoAndStop("highscore");
			
			_layerBackground.addChild(_header);
			
		}
		//------------------------------------------------------------------------
		// init name and highscore list
		//------------------------------------------------------------------------
		private function initLists():void {
			var str:String; // name
			_highscoreF = new TextFormat;

			_highscoreF.font = "Arcade";
			_highscoreF.align = "center";

			for (var i:int = 0; i < _score.length; i++) {
				if(_name[i].length > 10) { str = _name[i].substring(0,10) + "..."; } 
				else { str = _name[i]}

				_nameT = new TextField;
				_scoreT = new TextField;
				_nameT.embedFonts = true; 
				_nameT.selectable = false;
				_nameT.textColor = 0xffffff;      
				_nameT.text = "00:00:00"; // PLACEHOLDER 
				_nameT.width = 350;
				_nameT.x = 100;
				
				_scoreT.embedFonts = true; 
				_scoreT.selectable = false;
				_scoreT.textColor = 0xffffff;      
				_scoreT.text = "00:00:00"; // PLACEHOLDER 
				_scoreT.width = 350;
				_scoreT.x = 410;
				
				if (i == 0) { 
					_highscoreF.size = 30; 
					_scoreT.y = 150;
					_nameT.y = 150;
				}
				else {
					_scoreT.y = 160 + (i * 35) ;
					_nameT.y = 160 + (i * 35);
					_highscoreF.size = 20;
				}

				_nameT.text = str;
				_nameT.setTextFormat(_highscoreF);
				_scoreT.text = _score[i];
				_scoreT.setTextFormat(_highscoreF);

				_layerHighscoreTable.addChild(_scoreT);
				_layerHighscoreTable.addChild(_nameT);
			}
	
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
			_layerBackground.removeChild(_header);
			_layerBackground = null;
			_header = null;
		}
		private function disposeOverlay():void {
			trace("dispose overlay");
		}
	}
}1