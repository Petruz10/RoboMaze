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
	import game.Singleplayer;
	import game.Multiplayer;
	import se.lnu.stickossdk.input.EvertronControls;
	import flash.media.Sound;
	import se.lnu.stickossdk.media.SoundObject;

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
		/*
		* 	current button 
		*/
		private var choosenBtn:MenuButton;
		/*
		* Evertron controls
		*/
		private var _controls:EvertronControls = new EvertronControls();
		/*
		* 	music
		*/ 
		[Embed(source="asset/sound/music_WFMU_Gumbel_8-bit_Love_Machine_Gumbel_-_01_-_8-bit_Love_Machine.mp3")] 
		private var sound:Class;
		private var sound_mp3:SoundObject;
		//------------------------------------------------------------------------
		// constructor
		//------------------------------------------------------------------------
		public function Menu(){
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
		override public function update():void {
			updateMenu();
			changeState();
		}
		//------------------------------------------------------------------------
		// test method. places a maze.
		//------------------------------------------------------------------------
		override public function dispose():void {
			_controls = null;
			disposeButtons();
			disposeSound();
			disposeBackground();
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
			var bgImg:BgImgTest = new BgImgTest();
			
			_layerBackground = layers.add("MENU_BG");
			_layerBackground.x = 0;
			_layerBackground.y = 0;
			
			_layerBackground.addChild(bgImg);
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
			Session.sound.musicChannel.sources.add("hej", sound);
			
			sound_mp3 = Session.sound.musicChannel.get("hej");
			sound_mp3.volume = 0.5;
			sound_mp3.play();
		}
		//------------------------------------------------------------------------
		// updates menu. default choice = 0 <--- singleplayer
		//------------------------------------------------------------------------
		private function updateMenu():void {
			/*
			* menu btn tracker
			*/
			var choosenBtn:MenuButton;
			if(Input.keyboard.justPressed(_controls.PLAYER_DOWN)) { 
				if (_menuBtn < 3) { 
					this.menuBtn++; 
				}
			}
			if(Input.keyboard.justPressed(_controls.PLAYER_UP)) { 
				if (menuBtn != 0) { 
					this.menuBtn--;
				}
			}
			choosenBtn = _btnArray[_menuBtn];
			//------------------------------------------------------------------------
			// activation // deactivation
			// TAR FÖR MYCKET MINNE // FIXA!!!!
			//------------------------------------------------------------------------
			for (var i:int = 0; i < _btnArray.length; i++) { 
				_btnArray[i].deactivate(); 
			}
			if (choosenBtn.id == _menuBtn ) { 
				choosenBtn.activate(); 
			} 
		}
		//------------------------------------------------------------------------
		// update controls
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
		// remove background
		//------------------------------------------------------------------------
		private function disposeBackground():void {

		}
		//------------------------------------------------------------------------
		// remove menu buttons
		//------------------------------------------------------------------------
		private function disposeButtons():void {

		}
		//------------------------------------------------------------------------
		// remove sound
		//------------------------------------------------------------------------
		private function disposeSound():void {

		}
}
}