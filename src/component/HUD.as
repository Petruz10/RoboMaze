package component
{	
	import entity.Battery;
	import font.GameFont;
	
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;

	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.Font;
	/*
	*
	* game HUD	
	* super class
	* 
	*/ 
	public class HUD extends DisplayStateLayerSprite {
		/*
		*	public batteryLvl
		*/
		public var batteryLvl:int;
		/*
		*	BackgroundImg
		*/
		private var _backgroundImg:HUD_BG_mc;
		/*
		* 	Battery representation
		*/
		private var _battery:Battery_mc;
		/*
		* 	current higscore #1
		*/
		private var _highscore:int;
		/*
		* 	Visual representation of highscore
		*/
		private var _aboveHighscoreT:TextField;
		private var _aboveHighscoreF:TextFormat;
		private var _highscoreT:TextField;
		private var _highscoreF:TextFormat;
		/*
		* 	time 
		*/
		private var _time:int; 
		/*
		* 	Visual representation of time
		*/
		private var _timeT:TextField;
		private var _timeF:TextFormat;
		/*
		* 	hp
		*/
		private var _hp:int;
		//------------------------------------------------------------------------
		// 	Constructor
		//------------------------------------------------------------------------
		public function HUD() {
			init();
		}
		//------------------------------------------------------------------------
		// 	init
		//------------------------------------------------------------------------
		override public function init():void {
			var font:GameFont = new GameFont();
			initBackground();
			initBattery();
			initTime();
			initHighscore();
		}
		//------------------------------------------------------------------------
		// 	on update
		//------------------------------------------------------------------------
		override public function update():void {
			updateBattery();
			updateTime();
		}
		//------------------------------------------------------------------------
		// 	dispose
		//------------------------------------------------------------------------
		override public function dispose():void {
			trace("dispose HUD");
			disposeBackground();
			disposeBattery();
			disposeTime();
			disposeHighscore();
		}
		//------------------------------------------------------------------------
		//	 background
		//------------------------------------------------------------------------
		private function initBackground():void {
			_backgroundImg = new HUD_BG_mc();
			_backgroundImg.x = 0;
			_backgroundImg.y = 0;
			this.addChild(_backgroundImg);
		}
		//------------------------------------------------------------------------
		// 	init battery graphics
		//------------------------------------------------------------------------
		private function initBattery():void {
			_battery = new Battery_mc();
			_battery.stop();
			_battery.x = 20;
			_battery.y = 20;
			this.addChild(_battery);
		}
		//------------------------------------------------------------------------
		//	 init time graphics
		//------------------------------------------------------------------------
		private function initTime():void {
			trace("add time");
            //-----------------------------------------------------------------------------
            // Time Text Format
            //-----------------------------------------------------------------------------
            _timeF = new TextFormat;
            _timeF.font = "Digitalix"; 
			_timeF.size = 40;
            _timeF.align = "left";
            //-----------------------------------------------------------------------------
            // Time Text Field
            //-----------------------------------------------------------------------------
            _timeT = new TextField;
			_timeT.embedFonts = true; 
            _timeT.selectable = false;
            _timeT.textColor = 0xffffff;      
			_timeT.text = "00:00:00"; // PLACEHOLDER 
			_timeT.width = 500;
			_timeT.y = 20;
            _timeT.x = 270;
            _timeT.setTextFormat(_timeF); 
			this.addChild(_timeT);
			
		}
		//------------------------------------------------------------------------
		// 	init highscore graphics
		//------------------------------------------------------------------------
		private function initHighscore():void {
			//-----------------------------------------------------------------------------
			// Time Text Format
			//-----------------------------------------------------------------------------
			_highscoreF = new TextFormat;
			_highscoreF.font = "Digitalix"; 
			_highscoreF.size = 20;
			_highscoreF.align = "left";
			//-----------------------------------------------------------------------------
			// Time Text Field
			//-----------------------------------------------------------------------------
			_highscoreT = new TextField;
			_highscoreT.embedFonts = true; 
			_highscoreT.selectable = false;
			_highscoreT.textColor = 0xffffff;      
			_highscoreT.text = "60:60:60"; // PLACEHOLDER 
			_highscoreT.width = 500;
			_highscoreT.y = 40;
			_highscoreT.x = 630;
			_highscoreT.setTextFormat(_highscoreF); 
			this.addChild(_highscoreT);
			//-----------------------------------------------------------------------------
			// Time Text Format
			//-----------------------------------------------------------------------------
			_aboveHighscoreF = new TextFormat;
			_aboveHighscoreF.font = "Digitalix"; 
			_aboveHighscoreF.size = 16;
			_aboveHighscoreF.align = "left";
			//-----------------------------------------------------------------------------
			// Time Text Field
			//-----------------------------------------------------------------------------
			_aboveHighscoreT = new TextField;
			_aboveHighscoreT.embedFonts = true; 
			_aboveHighscoreT.selectable = false;
			_aboveHighscoreT.textColor = 0xffffff;      
			_aboveHighscoreT.text = "HIGHSCORE"; // PLACEHOLDER 
			_aboveHighscoreT.width = 500;
			_aboveHighscoreT.y = 20;
			_aboveHighscoreT.x = 630;
			_aboveHighscoreT.setTextFormat(_aboveHighscoreF); 
			this.addChild(_aboveHighscoreT);
		}
		//------------------------------------------------------------------------
		// 	update time graphics
		//------------------------------------------------------------------------
		private function updateTime():void {

		}
		//------------------------------------------------------------------------
		// 	update battery graphics
		//------------------------------------------------------------------------
		private function updateBattery():void {
			switch (batteryLvl) {
				case 100:
					_battery.gotoAndStop("100");
				break;
				case 90:
					_battery.gotoAndStop("90");
				break;
				case 80:
					_battery.gotoAndStop("80");
				break;
				case 70:
					_battery.gotoAndStop("70");
				break;
				case 60:
					_battery.gotoAndStop("60");
				break;
				case 50:
					_battery.gotoAndStop("50");
				break;
				case 40:
					_battery.gotoAndStop("40");
				break;
				case 30:
					_battery.gotoAndStop("30");
				break;
				case 20:
					_battery.gotoAndStop("20");
				break;
				case 10:
					_battery.gotoAndStop("10");
				break;
				case 0:
					_battery.gotoAndStop("0");
				break;
			}
		}
		//------------------------------------------------------------------------
		// 	dispose background
		//------------------------------------------------------------------------
		private function disposeBackground():void {
			trace("dispose HUD background");
			//this.removeChild(_backgroundImg);
			_backgroundImg = null;
		}
		//------------------------------------------------------------------------
		// 	dispose battery
		//------------------------------------------------------------------------
		private function disposeBattery():void {
			trace("dispose HUD battery");
			//this.removeChild(_battery);
			_battery = null;
		}
		//------------------------------------------------------------------------
		// 	dispose time
		//------------------------------------------------------------------------
		private function disposeTime():void {
			trace("dispose HUD time");
			this.removeChild(_timeT);
			_timeT = null;
		}
		//------------------------------------------------------------------------
		//	dispose highscore
		//------------------------------------------------------------------------
		private function disposeHighscore():void {
			trace("dispose HUD highscore");
		}
	}
}