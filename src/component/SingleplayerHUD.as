package component
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.Font;
	import font.GameFont;
	import highscore.HighscoreData;

	public class SingleplayerHUD extends HUD {
        //------------------------------------------------------------------------
		// 	PRIVATE
		//------------------------------------------------------------------------
		/*
		* 	current higscore #1
		*/
		private var _highscore:String;
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
		protected var _time:String; 
		/*
		* 	Visual representation of time
		*/
		protected var _gameFont:GameFont;
		/*
		*
		*/
		protected var _timeT:TextField;
		/*
		*
		*/
		protected var _timeF:TextFormat;
        //------------------------------------------------------------------------
		// 	Constructor
		//------------------------------------------------------------------------
        public function SingleplayerHUD() {

        }
        //------------------------------------------------------------------------
		// 	Init
		//------------------------------------------------------------------------
        override public function init():void {
            super.init();
			initFont();
            initHighscore();
			initTime();
        }
        //------------------------------------------------------------------------
		// 	Update
		//------------------------------------------------------------------------
        override public function update():void {
            super.update();
            updateHighscore();
			updateTime();
        }
        //------------------------------------------------------------------------
		// 	Dispose
		//------------------------------------------------------------------------
        override public function dispose():void {
            super.dispose();
            disposeHighscore();
			disposeTime();
        }
		protected function initFont():void {
			_gameFont = new GameFont();
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
		// 	init highscore graphics // only one player
		//------------------------------------------------------------------------
		protected function initHighscore():void {
			var highscoreData:HighscoreData = new HighscoreData();
			var score:Vector.<String> = highscoreData.score;
			if (score.length == 0) {
				score.push("50:01:23","40:01:23","30:01:23","20:01:23","10:01:23","00:09:23","00:08:23","00:06:23","00:05:23","00:02:23");
			}
			this._highscore = score[0];
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
		// 
		// 	GETTERS AND SETTERS
		//
		//-----------------------------------------------------------------------------
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
        //-----------------------------------------------------------------------------
		// set highsore
		//-----------------------------------------------------------------------------
		public function set highscore(highscore:String):void {
			this._highscore = highscore;
		} 
		//-----------------------------------------------------------------------------
		// get highscore
		//-----------------------------------------------------------------------------
		public function get highscore():String {
			return this._highscore;
		}
		//-----------------------------------------------------------------------------
		// 
		// 	UPDATE METHODS
		//
		//-----------------------------------------------------------------------------
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
        //-----------------------------------------------------------------------------
		// update highscore
		//-----------------------------------------------------------------------------
		private function updateHighscore():void {
			if (_highscore != null) {
				_highscoreT.text = this._highscore;
				_highscoreT.setTextFormat(_highscoreF);
			} else {
				_highscoreT.text = "00:00:00";
				_highscoreT.setTextFormat(_highscoreF);
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
        //------------------------------------------------------------------------
		//	dispose highscore
		//------------------------------------------------------------------------
		private function disposeHighscore():void {
			if(_highscoreT != null) {
				this.removeChild(_highscoreT);
				_highscoreT = null;
			}
		}
    }
}