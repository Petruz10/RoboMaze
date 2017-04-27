package component
{
	public class MultiplayerHUD extends HUD
	{
		private var _battery2:Battery_mc;
		private var _battery2Lvl:int;
		//------------------------------------------------------------------------
		// 	Constructor
		//------------------------------------------------------------------------
		public function MultiplayerHUD() {

		}
		override public function init():void {
			super.init();
		}
		//------------------------------------------------------------------------
		// 	update
		//------------------------------------------------------------------------
		override public function update():void {
			super.update();
			super.updateBattery(battery2Lvl, _battery2);
			super.updateSound(battery2Lvl);
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
			trace("add battery 2");
			_battery2 = new Battery_mc();
			_battery2.stop();
			_battery2.x = 620;
			_battery2.y = 20;
			this.addChild(_battery2);
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