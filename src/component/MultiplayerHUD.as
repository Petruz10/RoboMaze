package component
{	
	//------------------------------------------------------------------------
	// 	Flash
	//------------------------------------------------------------------------
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	//------------------------------------------------------------------------
	//
	//	MULTIPLAYER HUD - SUB CLASS
	// 	
	//------------------------------------------------------------------------
	public class MultiplayerHUD extends HUD
	{
		private var _battery2:Battery_mc;
		private var _battery2Lvl:int;
		private var _bomb:int; 	// 1 or 2
		private var _wrong:int; // 1 or 2
		/*
		*	ICONS
		*/
		private var _bombIcon1:BombIcon_mc;
		private var _bombIcon2:BombIcon_mc;
		
		private var _wrongIcon1:WrongIcon_mc;
		private var _wrongIcon2:WrongIcon_mc;
		/*
		* 	flags
		*/
		private var _ownedBomb1:Boolean; 	// player 1
		private var _ownedBomb2:Boolean; 	// player2
		private var _ownedWrong1:Boolean; 	// player 1			
		private var _ownedWrong2:Boolean; 	// player 2
		//------------------------------------------------------------------------
		// 	Constructor
		//------------------------------------------------------------------------
		public function MultiplayerHUD() {

		}
		//------------------------------------------------------------------------
		// 	init
		//------------------------------------------------------------------------
		override public function init():void {
			super.init();
			initBombIcons();
			initWrongIcons();
		}
		//------------------------------------------------------------------------
		// 	update
		//------------------------------------------------------------------------
		override public function update():void {
			super.update();
			super.updateBattery(battery2Lvl, _battery2);
			updateBomb();
			updateWrong();
		}
		//------------------------------------------------------------------------
		// dispose
		//------------------------------------------------------------------------
		override public function dispose():void {
			super.dispose();
			disposeBattery();
			disposeIcons();
		}
		//------------------------------------------------------------------------
		// 	init battery
		//------------------------------------------------------------------------
		override protected function initBattery():void {
			super.initBattery();
			_battery2 = new Battery_mc();
			_battery2.stop();
			_battery2.x = 615;
			_battery2.y = 20;
			_battery2.filters = new Array(_shadow);
			this.addChild(_battery2);
		}
		//------------------------------------------------------------------------
		// 	update hud icon for bomb
		//------------------------------------------------------------------------
		private function updateBomb():void {
			switch (_ownedBomb1) {
				case true:
					activateIcon(_bombIcon1);
				break;
				case false: 
					deactivateIcon(_bombIcon1);
				break;
			}
			switch (_ownedBomb2) {
				case true:
					activateIcon(_bombIcon2);
				break;
				case false: 
					deactivateIcon(_bombIcon2);
				break;
			}
		}
		//------------------------------------------------------------------------
		// 	update hud symbol for wrong controls
		//------------------------------------------------------------------------
		private function updateWrong():void {
			switch (_wrong) {
				case 1:
					activateIcon(_wrongIcon1);
				break;
				case 2:
					activateIcon(_wrongIcon2);
				break;
			}	
			if (_ownedWrong1 == false) { deactivateIcon(_wrongIcon1); }
			if (_ownedWrong2 == false) { deactivateIcon(_wrongIcon2); }
		}
		//------------------------------------------------------------------------
		// 	init all icons used in HUD
		//------------------------------------------------------------------------
		private function initBombIcons():void {
			_bombIcon1 = new BombIcon_mc();
			_bombIcon2 = new BombIcon_mc();
			
			_bombIcon1.gotoAndStop("deactivate");
			_bombIcon1.x = 220;
			_bombIcon1.y = 20;

			_bombIcon2.gotoAndStop("deactivate");
			_bombIcon2.x = 532;
			_bombIcon2.y = 20;

			_bombIcon1.filters = new Array(_shadow);
			_bombIcon2.filters = new Array(_shadow);
			
			this.addChild(_bombIcon1);
			this.addChild(_bombIcon2);
		}
		private function initWrongIcons():void {
			_wrongIcon1 = new WrongIcon_mc();
			_wrongIcon2 = new WrongIcon_mc();
			
			_wrongIcon1.gotoAndStop("deactivate");
			_wrongIcon1.x = 290;
			_wrongIcon1.y = 20;
		
			_wrongIcon2.gotoAndStop("deactivate");
			_wrongIcon2.x = 462;
			_wrongIcon2.y = 20;

			_wrongIcon1.filters = new Array(_shadow);
			_wrongIcon2.filters = new Array(_shadow);

			this.addChild(_wrongIcon1);
			this.addChild(_wrongIcon2);
		}
		//------------------------------------------------------------------------
		// 	activate icon
		//------------------------------------------------------------------------
		private function activateIcon(icon:MovieClip):void {
			icon.gotoAndStop("activate");
		}
		//------------------------------------------------------------------------
		// 	deactivate icon
		//------------------------------------------------------------------------
		private function deactivateIcon(icon:MovieClip):void {
			icon.gotoAndStop("deactivate");
		}
		//------------------------------------------------------------------------
		// 	
		//	GETTERS AND SETTERS
		//
		//------------------------------------------------------------------------
		//------------------------------------------------------------------------
		// 	set time
		//------------------------------------------------------------------------
		public function set time(timePlayed:String):void{
			var time:String = timePlayed;
		}
		//------------------------------------------------------------------------
		// 	set second battery lvl
		//------------------------------------------------------------------------
		public function set battery2Lvl(batteryLvl:int):void {
			this._battery2Lvl = batteryLvl;
		}
		//------------------------------------------------------------------------
		//	get second battery lvl
		//------------------------------------------------------------------------
		public function get battery2Lvl():int {
			return this._battery2Lvl;
		}
		//-----------------------------------------------------------------------------
		// set bomb status
		//-----------------------------------------------------------------------------
		public function bomb(bomb:int, owned:Boolean):void {
			_bomb = bomb;
			if (bomb == 1 && owned == true) 	{ _ownedBomb1 = true; }
			if (bomb == 1 && owned == false) 	{ _ownedBomb1 = false; }
			if (bomb == 2 && owned == true) 	{ _ownedBomb2 = true; }
			if (bomb == 2 && owned == false) 	{ _ownedBomb2 = false; }
		}
		//-----------------------------------------------------------------------------
		// set wrong way sabotage status
		//--------------------------------------
		//---------------------------------------
		public function wrong(wrong:int, owned:Boolean):void {
			_wrong = wrong;
			if (wrong == 1 && owned == true) 	{ _ownedWrong1 = true; }
			if (wrong == 1 && owned == false) 	{ _ownedWrong1 = false; }
			if (wrong == 2 && owned == true) 	{ _ownedWrong2 = true; }
			if (wrong == 2 && owned == false) 	{ _ownedWrong2 = false; }
		}

		//------------------------------------------------------------------------
		// dispose battery 2
		//------------------------------------------------------------------------
		override protected function disposeBattery():void {
			if(_battery2 != null){
				super.disposeBattery();
				this.removeChild(_battery2);
				_battery2 = null;
			}
		}
		//------------------------------------------------------------------------
		// dispose hud icons
		//------------------------------------------------------------------------
		private function disposeIcons():void {
			var child:DisplayObject;
			while (this.numChildren > 0) {
				child = this.getChildAt(0);
				this.removeChildAt(0);
				child = null;
			}
		}
	}
}