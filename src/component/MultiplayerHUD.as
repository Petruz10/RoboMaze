package component
{
	public class MultiplayerHUD extends HUD
	{
		private var _battery2:Battery_mc;
		private var _battery2Lvl:int;

		public function MultiplayerHUD()
		{
			trace("multiplayer");
			super();
		}
		override public function update():void {
			super.update();
			super.updateBattery(2, battery2Lvl, _battery2);
		}
		override public function dispose():void {
			super.dispose();
			disposeBattery();
		}
		override protected function initBackground():void {
			super.initBackground();
			trace("add bg");
		}
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
		// 
		//------------------------------------------------------------------------
		override protected function initHighscore():void{
			trace("highscore på multiplayer?");
		}
		//------------------------------------------------------------------------
		// 
		//------------------------------------------------------------------------
		override protected function disposeBattery():void {
			trace("dispose battery 2");
		}
	}
}