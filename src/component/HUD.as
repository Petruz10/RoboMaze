package component
{	
	import flash.display.MovieClip;
	import flash.media.Sound;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import entity.Battery;
	
	import font.GameFont;
	
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;

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
		*
		*/
		protected var _backgroundMusic:SoundObject;
		protected var _warning:SoundObject;
		protected var _shutdown:SoundObject;
		protected var _activate:SoundObject;
		/*
		* 	Battery representation
		*/
		protected var _battery1:Battery_mc;
		/*
		* 	time 
		*/
		protected var _time:String; 
		/*
		* 	Visual representation of time
		*/
		protected var _gameFont:GameFont;
		protected var _timeT:TextField;
		protected var _timeF:TextFormat;
	
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
			initFont();
			initSound();
		}
		//------------------------------------------------------------------------
		// 	on update
		//------------------------------------------------------------------------
		override public function update():void {
			updateBattery(battery1Lvl, _battery1);
			updateTime();
			updateSound(battery1Lvl);
		}
		//------------------------------------------------------------------------
		// 	dispose
		//------------------------------------------------------------------------
		override public function dispose():void {
			disposeBackground();
			disposeBattery();
			disposeTime();
		}
		protected function initSound():void {
			Session.sound.musicChannel.sources.add("activate", Robot_Activate_mp3);
			_activate = Session.sound.musicChannel.get("activate");
			_activate.volume = 0.6;
			_activate.play();
			
			Session.sound.musicChannel.sources.add("warning", Robot_Warning_mp3);
			_warning = Session.sound.musicChannel.get("warning");
			_warning.volume = 0.5;

			Session.sound.musicChannel.sources.add("shutdown", Robot_Shutdown_mp3);
			_shutdown = Session.sound.musicChannel.get("shutdown");
			_shutdown.volume = 0.5;

			Session.sound.musicChannel.sources.add("game_bgmusic", GameBackgroundMusic);
			_backgroundMusic = Session.sound.musicChannel.get("game_bgmusic");
			_backgroundMusic.volume = 0.5;
			_backgroundMusic.play();
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
		//-----------------------------------------------------------------------------
		// set time-string
		//-----------------------------------------------------------------------------
		public function set time(time:String):void {
			this._time = time;
		}
		//-----------------------------------------------------------------------------
		// get time string
		//-----------------------------------------------------------------------------
		public function get time():String {
			return this._time;
		}
		//------------------------------------------------------------------------
		//
		//	UPDATE METHODS
		// 	
		//------------------------------------------------------------------------
		//-----------------------------------------------------------------------------
		// @param	i		int		battery lvl
		//-----------------------------------------------------------------------------
		public function updateSound(i:int):void {
			switch (i) {
				case 50:
					_warning.play();
				break;
				case 30:
					_warning.play();
				break;
				case 10:
					_shutdown.play();
				break;
			}

		}
		//-----------------------------------------------------------------------------
		// update time textfield
		//-----------------------------------------------------------------------------
		protected function updateTime():void {
			if (_time != null) {
				_timeT.text = this._time;
				_timeT.setTextFormat(_timeF);
			} else {
				_timeT.text = "00:00:00";
				_timeT.setTextFormat(_timeF);
			}
		}
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
		//------------------------------------------------------------------------
		// 	dispose time
		//------------------------------------------------------------------------
		protected function disposeTime():void {
			if(_timeT != null){
				this.removeChild(_timeT);
				_timeT = null;
			}
		}
	}
}