package state
{
	//------------------------------------------------------------------------
	// 	Evertron SDK
	//------------------------------------------------------------------------
	import flash.display.MovieClip;
	import flash.net.SharedObject;
	
	import entity.BackButton;
	import entity.Button;
	import entity.RetryButton;
	
	import game.Multiplayer;
	import game.Singleplayer;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;


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
		* 	Evertron Controls
		*/
		private var _controls:EvertronControls = new EvertronControls;
		/*
		*	current menu choice
		*/
		private var _menuIndex:int;
		/*
		*
		*/
		private var _menuBtn:BackButton;
		/*
		*
		*/
		private var _retryBtn:RetryButton;
		/*
		*
		*/
		private var _menuIndexIndexArray:Array;
		/*
		* 1 = oneplayer game, 2 = twoplayer game
		*/
		private var _game:int;
		/*
		*
		*/
		private var _gameOverImg:GameOver_mc; // if singleplayer
		/*
		*
		*/
		private var _winnerHeader:GameOver_winner_header_mc; // if multiplayer // winner banner
		/*
		*
		*/
		private var _winner:GameOver_winner_mc;
		/*
		*
		*/
		private var _backgroundMusic:SoundObject;
		/*
		*
		*/
		private var _victoryInfo:SharedObject;
		/*
		*
		*/
		private var _won:int; // winning player
		/*
		*
		*/
		private var _robot:MovieClip; 
			/*
		*
		*/
		private var _trophy:Trophy_mc; 
		//------------------------------------------------------------------------
		// constructor
		//------------------------------------------------------------------------
		public function GameOver(){
		}
		//------------------------------------------------------------------------
		// init
		//------------------------------------------------------------------------
		override public function init():void {
		
			_victoryInfo = SharedObject.getLocal("playerwon");
			_won = _victoryInfo.data.won; 
	
			initLayers();
			//initSound();
			initSharedObj();
		}
		//------------------------------------------------------------------------
		// update
		//------------------------------------------------------------------------
		override public function update():void {
			updateMenu();
			changeState();
		}
		//------------------------------------------------------------------------
		// dispose
		//------------------------------------------------------------------------
		override public function dispose():void {
			disposeBackground();
            disposeOverlay();
		}
		private function initSound():void {
			if (_won == 0) {
				Session.sound.musicChannel.sources.add("gameover_bgmusic", BackgroundGameOver_mp3);
				_backgroundMusic = Session.sound.musicChannel.get("gameover_bgmusic");
			}
			else {
				Session.sound.musicChannel.sources.add("menu_bgmusic", BackgroundMenu_mp3);
				_backgroundMusic = Session.sound.musicChannel.get("menu_bgmusic");
			}
			_backgroundMusic.volume = 0.5;
			_backgroundMusic.play();
			
		}
		//------------------------------------------------------------------------
		// init layers
		//------------------------------------------------------------------------
		private function initLayers():void {
			initBackground();
			initOverlay();
		}
		//------------------------------------------------------------------------
		//
		//------------------------------------------------------------------------
		private function initSharedObj():void
		{
			var players:SharedObject = SharedObject.getLocal("players");
			_game = players.data.players;
		}
		//------------------------------------------------------------------------
		//
		//------------------------------------------------------------------------
		private function initBackground():void {
			_layerBackground = layers.add("GAME_OVER_BG");
			_layerBackground.x = 0;
			_layerBackground.y = 0;

			if (_won != 0) {
				_winnerHeader = new GameOver_winner_header_mc();
				_winner = new GameOver_winner_mc();

				_winnerHeader.y = 50;
				_winnerHeader.x = 400 - (_winnerHeader.width / 2);

				_winner.scaleY = 0.8;
				_winner.scaleX = 0.8;
				_winner.x = 400 - (_winner.width / 2);
				_winner.y = 180;
				_winner.stop();

				switch (_won) {
					case 1:
						_robot = new Robot1_mc();
					break;
					case 2:
						_robot = new Robot2_mc();
					break;
				}

				_robot.scaleY = 5.1;
				_robot.scaleX = 5.1;
				_robot.x = 400;
				_robot.y = 280;

				_trophy = new Trophy_mc();

				_trophy.x = 200;
				_trophy.y = 290;
				
				_robot.gotoAndStop("front");
				_layerBackground.addChild(_robot);
				_layerBackground.addChild(_trophy);
				_layerBackground.addChild(_winnerHeader);
				_layerBackground.addChild(_winner);
			}

			switch (_won) {
				case 0:
					_gameOverImg = new GameOver_mc();
					_gameOverImg.y = 100;
					_gameOverImg.x = 400 - ( _gameOverImg.width / 2 );
					_layerBackground.addChild(_gameOverImg);
				break;
				case 1:
					_winner.gotoAndStop("player1");
				break;
				case 2:
					_winner.gotoAndStop("player2");
			}
		}
		//------------------------------------------------------------------------
		// init "menu" --> back btn
		//------------------------------------------------------------------------
		private function initOverlay():void {
			_layerOverlay = layers.add("OVERLAY");
			_layerOverlay.x = 0;
			_layerOverlay.y = 0;
			
			_retryBtn = new RetryButton();
			_menuBtn = new BackButton();
			
			_menuIndexIndexArray = [0, 1] // 0 = retry, 1 = menu
			_menuIndex = _menuIndexIndexArray[0];
			toggleActivation();
			
			_menuBtn.y = 540;
			_menuBtn.x = 390 - (_menuBtn.width/2);
			_retryBtn.y = 490;
			_retryBtn.x = 400 - (_retryBtn.width/2);
			
			_layerOverlay.addChild(_retryBtn);
			_layerOverlay.addChild(_menuBtn);
		}
		//------------------------------------------------------------------------
		// 	updates menu. default choice = 0 <--- singleplayer
		//------------------------------------------------------------------------
		private function updateMenu():void {
			if(Input.keyboard.justPressed(_controls.PLAYER_DOWN)) { 
				if(_menuIndex < 1) { _menuIndex++ ;}
				toggleActivation();
			}
			if(Input.keyboard.justPressed(_controls.PLAYER_UP)) { 
				if (_menuIndex > 0) { _menuIndex--; }
				toggleActivation();
			}
		}
		//------------------------------------------------------------------------
		// 	activate // deactivate links
		//------------------------------------------------------------------------
		private function toggleActivation():void {
				if(_menuIndex == 1) {
					_menuBtn.activate();
					_retryBtn.deactivate();
				} else {
					_menuBtn.deactivate();
					_retryBtn.activate();
				}
		}
		//------------------------------------------------------------------------
		// change state -- > back to menu
		//------------------------------------------------------------------------
		private function changeState():void {
			if(Input.keyboard.justPressed(_controls.PLAYER_BUTTON_1) == true){
				if(_menuIndex == 1) {
					Session.application.displayState = new Menu;
				} 
				else if ((_menuIndex == 0) && (_game == 1)) {
					Session.application.displayState = new Singleplayer;
				}
				else if ((_menuIndex == 0) && (_game == 2)) {
					Session.application.displayState = new Multiplayer;
				}
			}
		}
		//------------------------------------------------------------------------
		// dispose background
		//------------------------------------------------------------------------
		private function disposeBackground():void {
			if (_won == 0) {
				_layerBackground.removeChild(_gameOverImg);
				_layerBackground = null;
				_gameOverImg = null;
			}
			else if (_won != 0) {
				_layerBackground.removeChild(_winnerHeader);
				_layerBackground.removeChild(_winner);
				_layerBackground.removeChild(_robot);
				_layerBackground.removeChild(_trophy);
				_winnerHeader = null;
				_winner = null;
				_robot = null;
				_trophy = null;
			}
		}
		//------------------------------------------------------------------------
		// dispose overlay
		//------------------------------------------------------------------------
		private function disposeOverlay():void {
			_layerOverlay.removeChild(_retryBtn);
			_layerOverlay.removeChild(_menuBtn);
			_retryBtn = null;
			_menuBtn = null;
			_layerOverlay = null;
		}
	}
}