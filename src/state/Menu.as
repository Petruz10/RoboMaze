package state
{	
	import component.Maze;
	
	import entity.Button;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.system.Session;
	import entity.MenuButton;
	import state.*;
	//------------------------------------------------------------------------
	// MAIN MENU
	//------------------------------------------------------------------------
	public class Menu extends DisplayState {			
		/*
		* background layer
		*/
		private var _layerBackground:DisplayStateLayer;
		/*
		* button layer
		*/
		private var _layerButtons:DisplayStateLayer;
		/*
		* array representing links ( indexes )
		*/
		private var _menuBtnIndexArray:Array;
		/*
		* array representing links ( btns )
		*/
		private var _btnArray:Array = new Array; 
		/*
		* current menu choice
		*/
		private var _menuBtn:int; // index representation
		/*
		* current menu choice
		*/
		private var _btn:Button;
		//------------------------------------------------------------------------
		// constructor
		//------------------------------------------------------------------------
		public function Menu(){
			//super();
			trace("MENU");
		}
		//------------------------------------------------------------------------
		// init
		//------------------------------------------------------------------------
		override public function init():void {
			initMenu();
			initLayers();
			initSound();
		}
		//------------------------------------------------------------------------
		// init menu array
		//------------------------------------------------------------------------
		private function initMenu():void {
			_menuBtnIndexArray = [0, 1, 2 ,3 ] // 0 = oneplayer, 1 = twoplayer, 2 = highscore, 3 = credits
			this.menuBtn = _menuBtnIndexArray[0];
		}
		private function set menuBtn(btn:int):void {
			_menuBtn = btn;
		} 
		private function get menuBtn():int {
			return _menuBtn;
		}
		//------------------------------------------------------------------------
		// init state-layeres
		//------------------------------------------------------------------------
		private function initLayers():void {
			initBackground();
			initButtons();
		}
		//------------------------------------------------------------------------
		// init background
		//------------------------------------------------------------------------
		private function initBackground():void {
			_layerBackground = layers.add("MENU_BG");
			_layerBackground.x = 0;
			_layerBackground.y = 0;
		}
		//------------------------------------------------------------------------
		// init Byttons
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
		// inti state-sound
		//------------------------------------------------------------------------
		private function initSound():void {
			
		}
		override public function update():void {
			updateMenu();
			changeState();
		}
		//------------------------------------------------------------------------
		// test method. places a maze.
		//------------------------------------------------------------------------
		override public function dispose():void {
			trace("dispose menu");
		}
		//------------------------------------------------------------------------
		// updates menu. default choice = 0 <--- singleplayer
		//------------------------------------------------------------------------
		private function updateMenu():void {
			/*
			* menu btn tracker
			*/
			var choosenBtn:MenuButton;
			if(Input.keyboard.justPressed("S")) {
				if (_menuBtn < 3) {
					this.menuBtn++;
					trace(menuBtn);
				}
			}
			if(Input.keyboard.justPressed("W")) {
				if (menuBtn != 0) {
					this.menuBtn--;
					trace(menuBtn);
				} 
			}
			choosenBtn = _btnArray[_menuBtn];
			//------------------------------------------------------------------------
			// activation // deactivation
			//------------------------------------------------------------------------
			for (var i:int = 0; i < _btnArray.length; i++) { _btnArray[i].deactivate(); }
			if (choosenBtn.id == _menuBtn ) { choosenBtn.activate(); }
		}
		//------------------------------------------------------------------------
		// update controls
		//------------------------------------------------------------------------
		private function changeState():void {

			if(Input.keyboard.justPressed("SPACE") == true){
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
	}
}