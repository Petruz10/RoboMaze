package component
{	
	//------------------------------------------------------------------------
	// 	Flash
	//------------------------------------------------------------------------
	import flash.display.MovieClip;
	import flash.filters.DropShadowFilter;
	import flash.display.Shape;
	//------------------------------------------------------------------------
	// 	Evertron SDK
	//------------------------------------------------------------------------
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	//------------------------------------------------------------------------
	// 	
	//	GAME HUD - SUPER CLASS
	//
	//------------------------------------------------------------------------
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
		protected var _background:Shape;
		/*
		* 	Battery representation
		*/
		protected var _battery1:Battery_mc;
		/*
		* 	shadow filter
		*/
		protected var _shadow:DropShadowFilter;
		//------------------------------------------------------------------------
		// 	Constructor
		//------------------------------------------------------------------------
		public function HUD() {
		}
		//------------------------------------------------------------------------
		// 	init
		//------------------------------------------------------------------------
		override public function init():void {
			initShadowfilter();
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
			disposeShadowfilter();
			disposeBackground();
			disposeBattery();
		}
		//------------------------------------------------------------------------
		//	 background
		//------------------------------------------------------------------------
		protected function initBackground():void {
            _background = new Shape();
            _background.graphics.beginFill(0x444444);
            _background.graphics.drawRect(0, 0, 800, 80);
            _background.graphics.endFill();
            _background.x = 0;
            _background.y = 0;
            this.addChild(_background);    
		}
		//------------------------------------------------------------------------
		// 	init battery graphics
		//------------------------------------------------------------------------
		protected function initBattery():void {
			_battery1 = new Battery_mc();
			_battery1.stop();
			_battery1.x = 20;
			_battery1.y = 20;
			_battery1.filters = new Array(_shadow);
			this.addChild(_battery1);
		}
		//------------------------------------------------------------------------
		// 	shadow graphics
		//------------------------------------------------------------------------
		protected function initShadowfilter():void {
			_shadow = new DropShadowFilter();
			_shadow.distance = 2;
			_shadow.angle = 90;
			_shadow.color = 0x111111;
			_shadow.alpha = 1;
			_shadow.blurX = 3;
			_shadow.blurY = 3;
			_shadow.strength = 1;
			_shadow.quality = 15;
			_shadow.inner = false;
			_shadow.knockout = false;
			_shadow.hideObject = false;
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
		// 	dispose shadowfilter
		//------------------------------------------------------------------------
		protected function disposeShadowfilter():void {
			_shadow = null;
		}
		//------------------------------------------------------------------------
		// 	dispose background
		//------------------------------------------------------------------------
		protected function disposeBackground():void {
			this.removeChild(_background);
			_background = null;
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