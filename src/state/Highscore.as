package state
{
	//------------------------------------------------------------------------
	// 	Flash
	//------------------------------------------------------------------------
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	//------------------------------------------------------------------------
	// 	Evertron SDK
	//------------------------------------------------------------------------
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;
	//------------------------------------------------------------------------
	// 	Project Imports
	//------------------------------------------------------------------------
	import entity.BackButton;
	import font.GameFont;	
	import highscore.HighscoreData;
	//------------------------------------------------------------------------
	// 		
	//	HIGHSCORE STATE
	//
	//------------------------------------------------------------------------
	public class Highscore extends DisplayState {
		/*
		*	background img.
		*/
		private var _layerBackground:DisplayStateLayer;
		private var _background:Menu_Background_mc; // background graphics
		/*
		* 	layer for higscore display
		*/
		private var _layerHighscoreTable:DisplayStateLayer;
		private var _header:Highscore_mc;
		/*
		*	overlay // robot
		*/
		private var _layerOverlay:DisplayStateLayer;
		/*
		* 	back btn
		*/
		private var _btn:BackButton;
		/*
		* 	Evertron Controls
		*/
		private var _controls:EvertronControls;
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
		/*
		* 	animation
		*/
		private var _robot:Robot1_mc;
		/*
		*
		*/ 
		private var _robotDirection:Boolean; 
		/*
		* 	highscore list
		*/
		private var _container:Sprite;
		private var _nameT:TextField;
		private var _scoreT:TextField;
		private var _highscoreF:TextFormat;
		private var _shadow:DropShadowFilter;
		/*
		* 	music
		*/
		private var _backgroundMusic:SoundObject;
		//------------------------------------------------------------------------
		// 	constructor
		//------------------------------------------------------------------------
		public function Highscore(){
		}
		//------------------------------------------------------------------------
		// 	init
		//------------------------------------------------------------------------
		override public function init():void {
			initControls();
			initShadowfilter();
			initLayers();
			initFont();
			initSound();
		}
		//------------------------------------------------------------------------
		// 	update
		//------------------------------------------------------------------------
		override public function update():void {
			changeState();
			updateHighscore();
			updateRobot();
		}
		//------------------------------------------------------------------------
		// 	dispose
		//------------------------------------------------------------------------
		override public function dispose():void {
			disposeControls();
			disposeBackground();
			disposeHighscoreTable();
			disposeOverlay();
			disposeShadowfilter();
			disposeText();
			disposeSound();
		}
		//------------------------------------------------------------------------
		//	init controls
		//------------------------------------------------------------------------
		private function initControls():void {
			_controls = new EvertronControls();
		}
		//------------------------------------------------------------------------
		// 	init font
		//------------------------------------------------------------------------
		private function initFont():void {
			_gameFont = new GameFont();
		}
		//------------------------------------------------------------------------
		// 	shadow graphics
		//------------------------------------------------------------------------
		private function initShadowfilter():void {
			_shadow = new DropShadowFilter();
			_shadow.distance = 2;
			_shadow.angle = 90;
			_shadow.color = 0x000000;
			_shadow.alpha = 1;
			_shadow.blurX = 2;
			_shadow.blurY = 2;
			_shadow.strength = 1;
			_shadow.quality = 15;
			_shadow.inner = false;
			_shadow.knockout = false;
			_shadow.hideObject = false;
		}
		//------------------------------------------------------------------------
		// 	init layers
		//------------------------------------------------------------------------
		private function initLayers():void {
			initBackground();
			initHighscore();
			initHighscoreTable();
			initOverlay(); // robot animation
		}
		//------------------------------------------------------------------------
		// 	init sound
		//------------------------------------------------------------------------
		private function initSound():void {
			Session.sound.musicChannel.sources.add("highscore_credits", BackgroundCredits_mp3);
			_backgroundMusic = Session.sound.musicChannel.get("highscore_credits");
			_backgroundMusic.volume = 0.2;
			_backgroundMusic.play(10);
		}
		//------------------------------------------------------------------------
		// 	placeholders
		//------------------------------------------------------------------------
		private function initHighscore():void {
			_highscoreData = new HighscoreData();
			_score = _highscoreData.score;
			_name = _highscoreData.name;

			/*
			if((_score.length == 0) || (_score == null)) {
				_score.push("00:00:00", "00:00:00", "00:00:00", "00:00:00", "00:00:00", "00:00:00", "00:00:00", "00:00:00", "00:00:00", "00:00:00");
				_name.push("michaela1","michaela2","michaela3","michaela4","michaela5","michaela6","michaela7","michaela8","michaela9","michaela10");
			} 
			*/
		} 
		//------------------------------------------------------------------------
		// 	init background
		//------------------------------------------------------------------------
		private function initBackground():void {
			_background = new Menu_Background_mc();
			_background.x = 0;
			_background.y = 0;

			_layerBackground = layers.add("HIGHSCORE_BG");
			_layerBackground.x = 0;
			_layerBackground.y = 0;

			_header = new Highscore_mc();
			_header.x = 20;
			_header.y = 10;
			_header.play();

			_layerBackground.addChild(_background);
			_layerBackground.addChild(_header);
		}
		//------------------------------------------------------------------------
		// 	init name and highscore list
		//------------------------------------------------------------------------
		private function initList():void {
			if(_container == null) {
				_container = new Sprite();
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
					_nameT.x = 70;
					_nameT.filters = new Array(_shadow);
					
					_scoreT.embedFonts = true; 
					_scoreT.selectable = false;
					_scoreT.textColor = 0xffffff;      
					_scoreT.text = "00:00:00"; // PLACEHOLDER 
					_scoreT.width = 350;
					_scoreT.x = 410;
					_scoreT.filters = new Array(_shadow);
					
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

					_container.addChild(_scoreT);
					_container.addChild(_nameT);
			
					_layerHighscoreTable.addChild(_container);
				}
			}
		}
		//------------------------------------------------------------------------
		// 	init background
		//------------------------------------------------------------------------
		private function initHighscoreTable():void {
			_btn = new BackButton();
			_layerHighscoreTable = layers.add("HIGHSCORE_ssssTABLE");
			_layerHighscoreTable.x = 0;
			_layerHighscoreTable.y = 0;
			
			_btn.x = 400 - (_btn.width/2);
			_btn.y = 550;
			_btn.pulse();

			_layerHighscoreTable.addChild(_btn);
		}
		//------------------------------------------------------------------------
		// 	robot
		//------------------------------------------------------------------------
		private function initOverlay():void {
			_robot = new Robot1_mc();
			_robot.scaleY = 4;
			_robot.scaleX = 4;
			_robot.x = -80;
			_robot.y = 440;
			_robot.gotoAndStop("side");

			_layerOverlay = layers.add("HIGHSCORE_OVERLAY");
			_layerOverlay.addChild(_robot);
		}
		//------------------------------------------------------------------------
		// 	updateHighscore
		//------------------------------------------------------------------------
		private function updateHighscore():void {
			if (_score.length != 0) { initList(); } 
		}
		//------------------------------------------------------------------------
		// 	move robot
		//------------------------------------------------------------------------
		private function updateRobot():void {
			if (_robot) {
				if (_robot.x <= -80) { 
					_robotDirection = false; trace("false"); 
				}
				else if (_robot.x >= 880) { 
					_robotDirection = true; trace("true"); 
				}
				
				if (_robotDirection == true) {
					_robot.x--;
					_robot.scaleX = -4;
				}
				else if (_robotDirection == false) {
					_robot.x++;
					_robot.scaleX = 4;
				}
			}	
		}
		//------------------------------------------------------------------------
		// 	making sure that the player can return to menu
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
		// 	dispose shadowfilter
		//------------------------------------------------------------------------
		private function disposeShadowfilter():void {
			_shadow = null;
		}
		//------------------------------------------------------------------------
		// 	dispose highscore table
		//------------------------------------------------------------------------
		private function disposeHighscoreTable():void {
			var textField:DisplayObject;

			_score = null;
			_name = null;

			_highscoreData.dispose();
			_highscoreData = null;

			if (_container) {
				while (_container.numChildren > 0) {
					textField = _container.getChildAt(0);
					_container.removeChildAt(0);
					textField = null;
				}

				if (_container.numChildren == 0) {
					_layerHighscoreTable.removeChild(_container);
				}
			}

			_layerHighscoreTable.removeChild(_btn); 
			_layerHighscoreTable = null;
			_btn = null;	
		}
		//------------------------------------------------------------------------
		// 	dispose background
		//------------------------------------------------------------------------
		private function disposeBackground():void {
			_layerBackground.removeChild(_background);
			_layerBackground.removeChild(_header);
			_layerBackground = null;
			_background = null;
			_header = null;
		}
		//------------------------------------------------------------------------
		// 	dispose coverlay
		//------------------------------------------------------------------------
		private function disposeOverlay():void {
			_layerOverlay.removeChild(_robot);
			_robot = null;
		}
		
		private function disposeText():void
		{
			_gameFont = null;
			_nameT = null;
			_scoreT = null;
			_highscoreF = null;
		}
		
		private function disposeSound():void
		{
			_backgroundMusic = null;
		}
	}
}