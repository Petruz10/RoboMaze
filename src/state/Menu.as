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
	import se.lnu.stickossdk.media.SoundObject;
	//------------------------------------------------------------------------
	// 	game states
	//------------------------------------------------------------------------
	import game.Singleplayer;
	import game.Multiplayer;
	//------------------------------------------------------------------------
	// 	menu states
	//------------------------------------------------------------------------
	import state.Singleplayer;
	import state.Multiplayer;
	import state.Highscore;
	import state.Credits;		
	//------------------------------------------------------------------------
	// 	enity
	//------------------------------------------------------------------------
	import entity.MenuButton;
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
		private var _layerButtons:DisplayStateLayer;
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
		* 	Evertron controls
		*/
		private var _controls:EvertronControls = new EvertronControls();
		/*
		* 	music
		*/ 
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
			disposeButtons();
			disposeSound();
			disposeBackground();
		}
		//------------------------------------------------------------------------
		// 	init menu array
		//------------------------------------------------------------------------
		private function initMenu():void {
			trace("init menu");
			_menuBtnIndexArray = [0, 1, 2 ,3 ] // 0 = oneplayer, 1 = twoplayer, 2 = highscore, 3 = credits
			_menuBtn = _menuBtnIndexArray[0];
			trace("_menuBtn = " + _menuBtn);
		}
		//------------------------------------------------------------------------
		// 	init state-layeres
		//------------------------------------------------------------------------
		private function initLayers():void {
			initBackground();
			initButtons();
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
		// 	init Byttons
		//------------------------------------------------------------------------
		private function initButtons():void {
			var posY:int = 100;
			_layerButtons = layers.add("BUTTONS");
			_layerButtons.x = 0;
			_layerButtons.y = 0;

			for (var i:int = 0; i < _menuBtnIndexArray.length; i++) {
				_btn = new MenuButton(i);
				_btn.x = 100;
				_btn.y = posY + (i * 100);
				_btnArray.push(_btn);
				_layerButtons.addChild(_btn);
			}
		}
		//------------------------------------------------------------------------
		// 	init state-sound
		//------------------------------------------------------------------------
		private function initSound():void {
			trace("init sound");
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
		private function disposeButtons():void {

		}
		//------------------------------------------------------------------------
		// 	remove sound
		//------------------------------------------------------------------------
		private function disposeSound():void {

		}
}
}