package component
{
	public class MultiplayerHUD extends HUD
	{
		private var _battery2:Battery_mc;
		private var _battery2Lvl:int;
		private var _bomb:int; // 1 or 2
		/*
		*	ICONS
		*/
		private var _bombIcon1:BombIcon_mc;
		private var _bombIcon2:BombIcon_mc;
		//------------------------------------------------------------------------
		// 	Constructor
		//------------------------------------------------------------------------
		public function MultiplayerHUD() {

		}
		override public function init():void {
			super.init();
			initIcons();
		}
		//------------------------------------------------------------------------
		// 	update
		//------------------------------------------------------------------------
		override public function update():void {
			super.update();
			super.updateBattery(battery2Lvl, _battery2);
			updateBomb();
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
		private function updateBomb():void {
			if (this._bomb == 1) {
				activateBombIcon(1);
			}
			else if (this._bomb == 2) {
				activateBombIcon(2);
			}
		}
		//------------------------------------------------------------------------
		// 	init all icons used in HUD
		//------------------------------------------------------------------------
		private function initIcons():void {
			_bombIcon1 = new BombIcon_mc();
			_bombIcon2 = new BombIcon_mc();
			_bombIcon1.gotoAndStop("deactivate");
			_bombIcon1.x = 200;
			_bombIcon1.y = 28;

			_bombIcon2.gotoAndStop("deactivate");
			_bombIcon2.x = 572;
			_bombIcon2.y = 28;
			
			this.addChild(_bombIcon1);
			this.addChild(_bombIcon2);
		}
		//------------------------------------------------------------------------
		// 	activate bomb icon
		//------------------------------------------------------------------------
		private function activateBombIcon(player:int):void {
			if ( player == 1 ) { _bombIcon1.gotoAndStop("activate"); }
			if ( player == 2 ) { _bombIcon2.gotoAndStop("activate"); }
		}
		//------------------------------------------------------------------------
		// 	
		//	GETTERS AND SETTERS
		//
		//------------------------------------------------------------------------
		//------------------------------------------------------------------------
		// 	set second battery lvl
		//------------------------------------------------------------------------
		public function set time(time:String):void{
			var time:String = time;
		}
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
		public function set bomb(bomb:int):void {
			trace("set bomb");
			this._bomb = bomb;
		}
		//-----------------------------------------------------------------------------
		// get bomb status
		//-----------------------------------------------------------------------------
		public function get bomb():int {
			trace("get bomb");
			return this._bomb;
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