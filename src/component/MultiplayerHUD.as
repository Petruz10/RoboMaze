package component
{
	import flash.display.MovieClip;

	public class MultiplayerHUD extends HUD
	{
		private var _battery2:Battery_mc;
		private var _battery2Lvl:int;
		private var _bomb:int; // 1 or 2
		private var _wrong:int; // 1 or 2
		/*
		*	ICONS
		*/
		private var _bombIcon1:BombIcon_mc;
		private var _bombIcon2:BombIcon_mc;
		
		private var _wrongIcon1:WrongIcon_mc;
		private var _wrongIcon2:WrongIcon_mc;
		//------------------------------------------------------------------------
		// 	Constructor
		//------------------------------------------------------------------------
		public function MultiplayerHUD() {

		}
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
		}
		//------------------------------------------------------------------------
		// 	init battery
		//------------------------------------------------------------------------
		override protected function initBattery():void {
			super.initBattery();
			_battery2 = new Battery_mc();
			_battery2.stop();
			_battery2.x = 620;
			_battery2.y = 20;
			this.addChild(_battery2);
		}
		//------------------------------------------------------------------------
		// 	update hud icon for bomb
		//------------------------------------------------------------------------
		private function updateBomb():void {
			switch (this.bomb) {
				case 0:
					deactivateIcon(_bombIcon1, _bombIcon2);
				break;
				case 1:
					activateIcon(_bombIcon1);
				break;
				case 2: 
					activateIcon(_bombIcon2);
				break;
				default: deactivateIcon(_bombIcon1, _bombIcon2);
			}
		}
		//------------------------------------------------------------------------
		// 	update hud symbol for wrong controls
		//------------------------------------------------------------------------
		private function updateWrong():void {
			switch (this.wrong) {
				case 0: 
					deactivateIcon(_wrongIcon1, _wrongIcon2);
				break;
				case 1:
					activateIcon(_wrongIcon1);
				break;
				case 2:
					activateIcon(_wrongIcon2);
				break;
				default: deactivateIcon(_wrongIcon1, _wrongIcon2);
			}	
		}
		//------------------------------------------------------------------------
		// 	init icons used in HUD
		//------------------------------------------------------------------------
		private function initBombIcons():void {
			_bombIcon1 = new BombIcon_mc();
			_bombIcon2 = new BombIcon_mc();
			
			_bombIcon1.x = 400 - 110;
			_bombIcon1.y = 30;

			_bombIcon2.x = 400 + 80;
			_bombIcon2.y = 30;
			
			this.addChild(_bombIcon1);
			this.addChild(_bombIcon2);
		}
		//------------------------------------------------------------------------
		// 	init icons used in HUD
		//------------------------------------------------------------------------
		private function initWrongIcons():void {
			_wrongIcon1 = new WrongIcon_mc();
			_wrongIcon2 = new WrongIcon_mc();

			_wrongIcon1.x = 400 - 150;
			_wrongIcon1.y = 30;

			_wrongIcon2.x = 400 + 120;
			_wrongIcon2.y = 30;
			
			this.addChild(_bombIcon1);
			this.addChild(_bombIcon2);
			
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
		private function deactivateIcon(icon1:MovieClip, icon2:MovieClip = null):void {
			icon1.gotoAndStop("deactivate");
			if (icon2) { icon2.gotoAndStop("deactivate"); }
		}
		//------------------------------------------------------------------------
		// 	
		//	GETTERS AND SETTERS
		//
		//------------------------------------------------------------------------
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
		//--------------------------------------
		//---------------------------------------
		public function set bomb(bomb:int):void {
			_bomb = bomb;
		}
		//-----------------------------------------------------------------------------
		// get bomb status
		//-----------------------------------------------------------------------------
		public function get bomb():int {
			return _bomb;
		}
		//-----------------------------------------------------------------------------
		// set wrong way sabotage status
		//--------------------------------------
		//---------------------------------------
		public function set wrong(bomb:int):void {
			_wrong = wrong;
		}
		//-----------------------------------------------------------------------------
		// get wrong way sabotage status
		//-----------------------------------------------------------------------------
		public function get wrong():int {
			return _wrong;
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
	}
}