package entity
{
	//------------------------------------------------------------------------
	// imports
	//------------------------------------------------------------------------
	import flash.display.Sprite;
	
	import se.lnu.stickossdk.fx.Flicker;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;


	//------------------------------------------------------------------------
	// Public class Robot
	//------------------------------------------------------------------------
	public class Robot extends Entity
	{
		//------------------------------------------------------------------------
		// public properties 
		//------------------------------------------------------------------------
		public var hit:Boolean = false;
		public var hitBattery:Boolean = false;
		
		public var area:Sprite;
		public var battery:Battery;
		
		public var powerUp:int = 0;
		
		public var obstacle:Obstacle;
		
		public var speed:int = 3;
		//------------------------------------------------------------------------
		// private properties 
		//------------------------------------------------------------------------
		private var m_controls:EvertronControls = new EvertronControls();
		
		private var m_hitSide:String;		
		private var m_player:int;
		
		private var m_flickr:Flicker;
		
		private var m_square:Sprite = new Sprite();
		private var m_refillSound:SoundObject;
		
		public var test:int;
		
		public var wrongSide:Boolean = false;
		//------------------------------------------------------------------------
		// Constructor methods
		//------------------------------------------------------------------------		
		public function Robot(controls:int=0)
		{
			super();
			m_controls.player = controls;
			m_player = controls;
		}
		//------------------------------------------------------------------------
		// public methods
		//------------------------------------------------------------------------
		override public function init():void
		{
			initSkin();
			trace("init Robot");
		}
		
		override public function update():void
		{
			if(!hit)updateControls();
			else if(hit) hitt();
			checkHit();
		}
		
		override public function dispose():void
		{
			disposeSkin();
			disposeGameOver();
			disposeObstacle();
		}
		
		//------------------------------------------------------------------------
		// private methods
		//------------------------------------------------------------------------
		private function updateControls():void
		{	
			if(Input.keyboard.pressed(m_controls.PLAYER_LEFT)) this.moveLeft(); 
			else if(Input.keyboard.pressed(m_controls.PLAYER_RIGHT)) this.moveRight();
			else if(Input.keyboard.pressed(m_controls.PLAYER_DOWN)) this.moveDown(); 
			else if(Input.keyboard.pressed(m_controls.PLAYER_UP)) this.moveUp(); 
			
			if(Input.keyboard.justPressed(m_controls.PLAYER_BUTTON_1) && powerUp > 0) this.addObstacle()
		}
		
		private function moveUp():void
		{	
			
			
			if(battery.HP != 0) 
			{
				_skin.gotoAndStop("back");
				if(!wrongSide)
				{
					m_hitSide = "up";
					_skin.y -= speed; 
				}
				else 
				{
					_skin.y += speed;
					m_hitSide = "down";
				}
			}
			return;
			
		}
		
		private function moveDown():void
		{	
			if(battery.HP != 0)
			{
				_skin.gotoAndStop("front");
				if(!wrongSide)
				{
					m_hitSide = "down";
					_skin.y += speed; 
				}
				else
				{
					m_hitSide = "up";
					_skin.y -= speed;
				}
			}
			return;
		}
		
		private function moveLeft():void
		{
			if(battery.HP != 0)
			{
				_skin.gotoAndStop("side");
			
				if(!wrongSide)
				{
					m_hitSide = "left";
					_skin.x -= speed; 
				}
				else 
				{
					m_hitSide = "right";
					_skin.x += speed;
				}
				//_skin.scaleX *=- 1;
			}
			return;
		}
		
		private function moveRight():void
		{
			
			if(battery.HP != 0) 
			{
				
			//	_skin.scaleX *= 1;
				_skin.gotoAndStop("side");
			
				if(!wrongSide)
				{
					m_hitSide = "right";
					_skin.x += speed;
				}
				else 
				{
					m_hitSide = "left";
					_skin.x -= speed;
				}
			}
			return;
		}
		
		private function addObstacle():void
		{
			powerUp --;

			obstacle = new Obstacle(test);
			
			obstacle.y = _skin.y;
			if(m_player == 0)obstacle.x = _skin.x +400;
			else if(m_player == 1)obstacle.x = _skin.x -400;
			
			this.addChild(obstacle);
			return;
		}
		
		private function hitt():void
		{
			if(m_hitSide == "up") _skin.y += speed; 
			else if(m_hitSide == "down") _skin.y -= speed; 
			else if(m_hitSide == "left") _skin.x += speed; 
			else if(m_hitSide == "right") _skin.x -= speed;
			
			hit = false;
			
			return;
		}
		
		private function checkHit():void
		{
			if(hitBattery)
			{
				battery.HP += 30; 
				hitBattery = false;
				if(battery.HP > 100) battery.HP = 100;
				initRefillSound();
			}
			
			if(battery.HP == 0)
			{
				initGameOver();
			}
		}
		
		private function initRefillSound():void
		{
			Session.sound.musicChannel.sources.add("game_refillSound", RobotRefill_mp3);
			m_refillSound = Session.sound.musicChannel.get("game_refillSound");
			m_refillSound.volume = 0.65;
			m_refillSound.play();
		}
		
		private function initGameOver():void
		{			
			m_flickr = new Flicker(_skin, 1000, 20); //obj, tid (hur länge), intervall
			Session.effects.add(m_flickr);
		}

		private function initSkin():void
		{
			if(m_player == 0)_skin = new Robot1_mc();
			else if(m_player == 1) _skin = new Robot2_mc();
			
			_skin.gotoAndStop("front");
			
			//square.graphics.beginFill(0xCCFF00);
			m_square.graphics.drawRect(7, 11, 20, 20);
			_skin.hitArea = m_square;
			area = _skin.hitArea;

			battery = new Battery();
			
			this.addChild(_skin);
			_skin.addChild(_skin.hitArea);
		}
		
		//------------------------------------------------------------------------
		// dispose methods
		//------------------------------------------------------------------------
		private function disposeSkin():void
		{
			m_controls = null;
			m_square = null;
			_skin.hitArea = null;
			_skin = null;
			battery = null;
			
			trace("dispose Robot");
		}
		
		private function disposeObstacle():void
		{
			obstacle = null;
		}
		
		private function disposeGameOver():void
		{
			m_flickr = null;
			trace("dispose gameOver, flickr effekt");
		}

	}
}