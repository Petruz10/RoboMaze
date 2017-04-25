package component
{	
	import flash.display.MovieClip;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import entity.Battery;
	
	import font.GameFont;
	
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
		/*
		* 	time 
		*/
		protected var _time:int; 
		/*
		* 	Visual representation of time
		*/
		protected var _gameFont:GameFont;
		protected var _timeT:TextField;
		protected var _timeF:TextFormat;
		//------------------------------------------------------------------------
		// 	PRIVATE
		//------------------------------------------------------------------------
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
			initTime();
			initHighscore();
			initFont();
		}
		//------------------------------------------------------------------------
		// 	on update
		//------------------------------------------------------------------------
		override public function update():void {
			updateBattery(1, battery1Lvl, _battery1);
			//updateTime();
		}
		//------------------------------------------------------------------------
		// 	dispose
		//------------------------------------------------------------------------
		override public function dispose():void {
			disposeBackground();
			disposeBattery();
			disposeTime();
			disposeHighscore();
		}
		public function set battery1Lvl(batteryLvl:int):void {
			this._battery1Lvl = batteryLvl;
		}
		public function get battery1Lvl():int {
			return this._battery1Lvl;
		}
		protected function initFont():void {
			_gameFont = new GameFont();
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
		//------------------------------------------------------------------------
		//	 init time graphics
		//------------------------------------------------------------------------
		protected function initTime():void {
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
		protected function initHighscore():void {
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
		//-----------------------------------------------------------------------------
		// set time-string
		//-----------------------------------------------------------------------------
		public function set time(time:String):void {
			trace(time);
			this._time = time;
		}
		//-----------------------------------------------------------------------------
		// get time string
		//-----------------------------------------------------------------------------
		public function get time():String {
			return this._time;
		} 
		//------------------------------------------------------------------------
		// 	update time graphics
		//------------------------------------------------------------------------
		protected function updateTime(t:uint):void {
			if (_timeT != null) {
				_timeT.text = this._time;
			}
		}
		//------------------------------------------------------------------------
		//
		// 	update battery graphics
		//
		// @param	i	int 		battery 1 or battery 2
		// @param	a	int			battery lvl
		// @param 	b  	MovieClip	the graphics that will change
		//
		//------------------------------------------------------------------------
		protected function updateBattery(i:int, a:int, b:MovieClip):void {
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
			this.removeChild(_battery1);
			_battery1 = null;
		}
		//------------------------------------------------------------------------
		// 	dispose time
		//------------------------------------------------------------------------
		protected function disposeTime():void {
			this.removeChild(_timeT);
			_timeT = null;
		}
		//------------------------------------------------------------------------
		//	dispose highscore
		//------------------------------------------------------------------------
		protected function disposeHighscore():void {
			trace("dispose HUD highscore");
		}

	}
}