package state
{	
	//------------------------------------------------------------------------
	// 	Flash
	//------------------------------------------------------------------------
	import flash.display.DisplayObject;
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
	// 	Project imports
	//------------------------------------------------------------------------
	import game.Multiplayer;
	import game.Singleplayer;
	import state.Credits;
	import state.Highscore;
	import entity.MenuButton;
	//------------------------------------------------------------------------
	//	
	//	Menu state
	//
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
		*	background fade
		*/
		private var _background:Menu_Background_mc;
		/*
		*	menu header
		*/
		private var _logo:Menu_Logo_test_mc;
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
		private var _menuIndex:int; // index representation
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
		private var _controls:EvertronControls;
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
			initControls();
			initMenu();
			initLayers();
			initSound();
		}
		override public function update():void {
			updateMenu();
			changeState();
	//		emptyHighscore();

		}
		
		//------------------------------------------------------------------------
		// 	test method - empty highscore
		//------------------------------------------------------------------------
		private function emptyHighscore():void
		{
			if(Input.keyboard.justPressed("SPACE")) 
			{
				trace("space knapp i menu, töm highscore");
				Session.highscore.resetTable(1);
			}
		}
		//------------------------------------------------------------------------
		// 	on dispose
		//------------------------------------------------------------------------
		override public function dispose():void {	
			disposeControls();
			disposeRobot();
			disposeOverlay();
			disposeBackground();
			disposeBtn();
			disposeSound();
		}
		private function initControls():void {
			_controls = new EvertronControls();
		}
		//------------------------------------------------------------------------
		// 	init menu array
		//------------------------------------------------------------------------
		private function initMenu():void {
			_menuBtnIndexArray = [0, 1, 2 ,3 ] // 0 = oneplayer, 1 = twoplayer, 2 = highscore, 3 = credits
			_menuIndex = _menuBtnIndexArray[0];
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
			_background = new Menu_Background_mc();
			_background.x = 0;
			_background.y = 0;
			_layerBackground = layers.add("BACKGROUND");
			_layerBackground.addChild(_background);
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
			_logo = new Menu_Logo_test_mc();
			_logo.x = 20;
			_logo.y = 40;

			_layerOverlay.addChild(_logo);
			//------------------------------------------------------------------------
			//	buttons
			//------------------------------------------------------------------------
			for (var i:int = 0; i < _menuBtnIndexArray.length; i++) {
				_btn = new MenuButton(i);
				_btn.x = 50;
				switch (i) {
					case 0:
						_btn.y = 210;
					break;
					case 1:
						_btn.y = 290;
					break;
					case 2:
						_btn.y = 400;
					break;
					case 3:
						_btn.y = 450;
					break;
				}
				
				_btnArray.push(_btn);
				_layerOverlay.addChild(_btn);
				toggleActivation();
			}
		}
		//------------------------------------------------------------------------
		// 	init animated meny robot
		//------------------------------------------------------------------------
		private function initRobot():void {
			_robot = new Menu_Robot_mc();
			_robot.y = 320;
			_robot.x = 500;
			_robot.scaleY = 2.6;
			_robot.scaleX = 2.6;
			_layerOverlay.addChild(_robot);
		}
		//------------------------------------------------------------------------
		// 	init state-sound
		//------------------------------------------------------------------------
		private function initSound():void {
			Session.sound.musicChannel.sources.add("menu_bgmusic", BackgroundMenu_mp3);
			_backgroundMusic = Session.sound.musicChannel.get("menu_bgmusic");
			_backgroundMusic.volume = 0.4;
			_backgroundMusic.play();
		}
		//------------------------------------------------------------------------
		// 	updates menu. default choice = 0 <--- singleplayer
		//------------------------------------------------------------------------
		private function updateMenu():void {
			if(Input.keyboard.justPressed(_controls.PLAYER_DOWN)) { 
				if(_menuIndex < 3) { _menuIndex++ ;}
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
				var choosenBtn:MenuButton;
				choosenBtn = _btnArray[_menuIndex];
				for (var i:int = 0; i < _btnArray.length; i++) { _btnArray[i].deactivate(); }
				if (choosenBtn.id == _menuIndex ) { choosenBtn.activate(); } 
		}
		//------------------------------------------------------------------------
		// 	update controls
		//------------------------------------------------------------------------
		private function changeState():void {
			if(Input.keyboard.justPressed(_controls.PLAYER_BUTTON_1) == true){
				switch (_menuIndex) {
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
		// 	
		//	DISPOSE METHODS
		// 
		//------------------------------------------------------------------------		
		private function disposeBtn():void
		{
			for(var i:uint = 0; i< _menuBtnIndexArray.length; i++)
			{
				_menuBtnIndexArray[i] = null;
			}
			
			for(var j:uint = 0; j<_btnArray.length; j++)
			{
				_btnArray[j] = null;
			}
			
			_menuBtnIndexArray = null;
			_btnArray = null;
			_btn = null;
			choosenBtn = null;
			_logo = null;
		}

		//------------------------------------------------------------------------
		// 	dispose background
		//------------------------------------------------------------------------
		private function disposeControls():void {
			_controls = null;
		}
		//------------------------------------------------------------------------
		// 	dispose background
		//------------------------------------------------------------------------
		private function disposeBackground():void {
			_layerBackground.removeChild(_background);
			_background = null;
			_layerBackground = null;
		}
		//------------------------------------------------------------------------
		// 	dispose menu buttons
		//------------------------------------------------------------------------
		private function disposeOverlay():void {
			var child:DisplayObject;
			while (_layerOverlay.numChildren > 0) {
				child = _layerOverlay.getChildAt(0);
				_layerOverlay.removeChildAt(0);
				child = null;
			}
			_layerOverlay = null;
		}
		//------------------------------------------------------------------------
		// 	dispose robot
		//------------------------------------------------------------------------
		private function disposeRobot():void {
			if(_layerOverlay)_layerOverlay.removeChild(_robot);
			_robot = null;
		}
		
		private function disposeSound():void
		{
			_backgroundMusic = null;
		}
}
}