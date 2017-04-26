package state
{	
	//------------------------------------------------------------------------
	// 	Evertron SDK
	//------------------------------------------------------------------------
	import entity.MenuButton;
	
	import game.Multiplayer;
	import game.Singleplayer;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;
	
	import state.Credits;
	import state.Highscore;
	import state.Multiplayer;
	import state.Singleplayer;
	//------------------------------------------------------------------------
	//	Menu state
	//------------------------------------------------------------------------
	public class Menu extends DisplayState {			
		/*
		* 	background layer
		*/
		private var _layerBackground:DisplayStateLayer;
		/*
		* 	button layer
		*/
		private var _layerOverlay:DisplayStateLayer;
		/*
		*
		*/
		private var _logo:MenuLogo_mc;
		/*
		* 	array representing links ( indexes )
		*/
		private var _menuBtnIndexArray:Array;
		/*
		* 	array representing links ( btns )
		*/
		private var _btnArray:Array = new Array; 
		/*
		* 	current menu choice
		*/
		private var _menuBtn:int; // index representation
		/*
		* 	current menu choice
		*/
		private var _btn:MenuButton;
		/*
		* 	current button 
		*/	
		private var choosenBtn:MenuButton;
		/*
		* 	robot animation
		*/
		private var _robot:Menu_Robot_mc;
		/*
		* 	Evertron controls
		*/
		private var _controls:EvertronControls = new EvertronControls();
		/*
		* 	music
		*/ 
		private var _backgroundMusic:SoundObject;
		//------------------------------------------------------------------------
		// 	constructor
		//------------------------------------------------------------------------
		public function Menu(){

		}
		//------------------------------------------------------------------------
		// 	init
		//------------------------------------------------------------------------
		override public function init():void {
			initMenu();
			initLayers();
			initSound();
		}
		override public function update():void {
			updateMenu();
			changeState();
		}
		//------------------------------------------------------------------------
		// 	test method. places a maze.
		//------------------------------------------------------------------------
		override public function dispose():void {
			_controls = null;
			disposeOverlay();
			disposeSound();
			disposeBackground();
		}
		//------------------------------------------------------------------------
		// 	init menu array
		//------------------------------------------------------------------------
		private function initMenu():void {
			_menuBtnIndexArray = [0, 1, 2 ,3 ] // 0 = oneplayer, 1 = twoplayer, 2 = highscore, 3 = credits
			_menuBtn = _menuBtnIndexArray[0];
		}
		//------------------------------------------------------------------------
		// 	init state-layeres
		//------------------------------------------------------------------------
		private function initLayers():void {
			initBackground();
			initOverlay();
			initRobot();
		}
		//------------------------------------------------------------------------
		// 	init background
		//------------------------------------------------------------------------
		private function initBackground():void {
			var bgImg:BgImgTest = new BgImgTest();
			
			_layerBackground = layers.add("MENU_BG");
			_layerBackground.x = 0;
			_layerBackground.y = 0;
			
			_layerBackground.addChild(bgImg);
		}
		//------------------------------------------------------------------------
		// 	init Buttons
		//------------------------------------------------------------------------
		private function initOverlay():void {
			var posY:int = 100;
			_layerOverlay = layers.add("BUTTONS");
			_layerOverlay.x = 0;
			_layerOverlay.y = 0;
			//------------------------------------------------------------------------
			//	logo
			//------------------------------------------------------------------------
			_logo = new MenuLogo_mc();
			_logo.x = 0;
			_logo.y = 0;

			_layerOverlay.addChild(_logo);
			//------------------------------------------------------------------------
			//	buttons
			//------------------------------------------------------------------------
			for (var i:int = 0; i < _menuBtnIndexArray.length; i++) {
				_btn = new MenuButton(i);
				_btn.x = 50;
				switch (i) {
					case 0:
						_btn.y = 230;
					break;
					case 1:
						_btn.y = 330;
					break;
					case 2:
						_btn.y = 430;
					break;
					case 3:
						_btn.y = 500;
					break;
				}
				
				_btnArray.push(_btn);
				_layerOverlay.addChild(_btn);
				toggleActivation();
			}
		}
		private function initRobot():void {
			_robot = new Menu_Robot_mc();
			_robot.y = 350;
			_robot.x = 530;
			_robot.scaleY = 2.3;
			_robot.scaleX = 2.3;
			_layerOverlay.addChild(_robot);
		}
		//------------------------------------------------------------------------
		// 	init state-sound
		//------------------------------------------------------------------------
		private function initSound():void {
			Session.sound.musicChannel.sources.add("menu_bgmusic", MenuBackgroundMusic);
			_backgroundMusic = Session.sound.musicChannel.get("menu_bgmusic");
			_backgroundMusic.volume = 0.5;
			_backgroundMusic.play();
		}
		//------------------------------------------------------------------------
		// 	updates menu. default choice = 0 <--- singleplayer
		//------------------------------------------------------------------------
		private function updateMenu():void {
			if(Input.keyboard.justPressed(_controls.PLAYER_DOWN)) { 
				if(_menuBtn < 3) { _menuBtn++ ;}
				toggleActivation();
			}
			if(Input.keyboard.justPressed(_controls.PLAYER_UP)) { 
				if (_menuBtn > 0) { _menuBtn--; }
				toggleActivation();
			}
		}
		//------------------------------------------------------------------------
		// 	activate // deactivate links
		//------------------------------------------------------------------------
		private function toggleActivation():void {
				var choosenBtn:MenuButton;
				choosenBtn = _btnArray[_menuBtn];
				for (var i:int = 0; i < _btnArray.length; i++) { _btnArray[i].deactivate(); }
				if (choosenBtn.id == _menuBtn ) { choosenBtn.activate(); } 
		}
		//------------------------------------------------------------------------
		// 	update controls
		//------------------------------------------------------------------------
		private function changeState():void {
			if(Input.keyboard.justPressed(_controls.PLAYER_BUTTON_1) == true){
				switch (_menuBtn) {
					case 0:
						Session.application.displayState = new Singleplayer;
					break;
					case 1:
						Session.application.displayState = new Multiplayer;
					break;
					case 2: 
						Session.application.displayState = new Highscore;
					break;
					case 3: 
						Session.application.displayState = new Credits;
					break; 
				}
			}
		}
		//------------------------------------------------------------------------
		// 	remove background
		//------------------------------------------------------------------------
		private function disposeBackground():void {

		}
		//------------------------------------------------------------------------
		// 	remove menu buttons
		//------------------------------------------------------------------------
		private function disposeOverlay():void {

		}
		//------------------------------------------------------------------------
		// 	remove robot
		//------------------------------------------------------------------------
		private function disposeRobot():void {
			_robot = null;
			_layerOverlay.removeChild(_robot);
		}
		//------------------------------------------------------------------------
		// 	remove sound
		//------------------------------------------------------------------------
		private function disposeSound():void {

		}
}
}