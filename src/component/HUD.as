package component
{	
	import flash.display.MovieClip;
	import entity.Battery;
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	/*
	*
	* game HUD	
	* super class
	* 
	*/ 
	public class HUD extends DisplayStateLayerSprite {
		//------------------------------------------------------------------------
		// 	PROTECTED
		//------------------------------------------------------------------------
		/*
		*	public batteryLvl
		*/
		protected var _battery1Lvl:int;
		/*
		*	BackgroundImg
		*/
		protected var _backgroundImg:HUD_BG_mc;
		/*
		* 	Battery representation
		*/
		protected var _battery1:Battery_mc;
		//------------------------------------------------------------------------
		// 	Constructor
		//------------------------------------------------------------------------
		public function HUD() {
		}
		//------------------------------------------------------------------------
		// 	init
		//------------------------------------------------------------------------
		override public function init():void {
			initBackground();
			initBattery();
		}
		//------------------------------------------------------------------------
		// 	on update
		//------------------------------------------------------------------------
		override public function update():void {
			updateBattery(battery1Lvl, _battery1);
		}
		//------------------------------------------------------------------------
		// 	dispose
		//------------------------------------------------------------------------
		override public function dispose():void {
			disposeBackground();
			disposeBattery();
		}
		//------------------------------------------------------------------------
		//	 background
		//------------------------------------------------------------------------
		protected function initBackground():void {
			_backgroundImg = new HUD_BG_mc();
			_backgroundImg.x = 0;
			_backgroundImg.y = 0;
			this.addChild(_backgroundImg);
		}
		//------------------------------------------------------------------------
		// 	init battery graphics
		//------------------------------------------------------------------------
		protected function initBattery():void {
			_battery1 = new Battery_mc();
			_battery1.stop();
			_battery1.x = 20;
			_battery1.y = 20;
			this.addChild(_battery1);
		}

		//-----------------------------------------------------------------------------
		// 
		// 	SETTERS & GETTERS
		//
		//-----------------------------------------------------------------------------
		//-----------------------------------------------------------------------------
		// set battery lvl
		//-----------------------------------------------------------------------------
		public function set battery1Lvl(batteryLvl:int):void {
			this._battery1Lvl = batteryLvl;
		}
		//-----------------------------------------------------------------------------
		// get battery lvl
		//-----------------------------------------------------------------------------
		public function get battery1Lvl():int {
			return this._battery1Lvl;
		}
		//------------------------------------------------------------------------
		//
		//	UPDATE METHODS
		// 	
		//------------------------------------------------------------------------
		//------------------------------------------------------------------------
		//
		// 	update battery graphics
		//
		// @param	a	int			battery lvl
		// @param 	b  	MovieClip	the graphics that will change
		//
		//------------------------------------------------------------------------
		protected function updateBattery(a:int, b:MovieClip):void {
			switch (a) {
				case 100:
					b.gotoAndStop(1);
					break;
				case 90:
					b.gotoAndStop(2);
					break;
				case 80:
					b.gotoAndStop(3);
					break;
				case 70:
					b.gotoAndStop(4);
					break;
				case 60:
					b.gotoAndStop(5);
					break;
				case 50:
					b.gotoAndStop(6);
					break;
				case 40:
					b.gotoAndStop(7);
					break;
				case 30:
					b.gotoAndStop(8);
					break;
				case 20:
					b.gotoAndStop(9);
					break;
				case 10:
					b.gotoAndStop(10);
					break;
				case 0:
					b.gotoAndStop(11);
					break;
				default: b.gotoAndStop(1);
			}
		}
		//------------------------------------------------------------------------
		// 	dispose background
		//------------------------------------------------------------------------
		protected function disposeBackground():void {
			this.removeChild(_backgroundImg);
			_backgroundImg = null;
		}
		//------------------------------------------------------------------------
		// 	dispose battery
		//------------------------------------------------------------------------
		protected function disposeBattery():void {
			if (_battery1 != null) {
				this.removeChild(_battery1);
				_battery1 = null;
			}
		}
	}
}