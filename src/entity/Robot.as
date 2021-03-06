package entity
{
	//------------------------------------------------------------------------
	// imports
	//------------------------------------------------------------------------
	import flash.display.MovieClip;
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
		public var obstacleType:int;
		
		public var speed:int = 3;
		
		public var startGame:Boolean = false;
		public var wrongSide:Boolean = false;
		public var activateWrongSide:Boolean = false;
		
		public var bomb:Boolean = false;
		
		public var skin:MovieClip;
		public var bombs:Vector.<Obstacle> = new Vector.<Obstacle>();
		
		public var die:Boolean = false;

		//------------------------------------------------------------------------
		// private properties 
		//------------------------------------------------------------------------
		private var m_controls:EvertronControls = new EvertronControls();
		
		private var m_hitSide:String;		
		private var m_player:int;
		private var m_numberPlayers:int;
		
		private var m_flickr:Flicker;
		
		private var m_square:Sprite = new Sprite();
		private var m_refillSound:SoundObject;
	
		//------------------------------------------------------------------------
		// Constructor methods
		//------------------------------------------------------------------------		
		public function Robot(controls:int=0, players:int=1)
		{
			super();
			m_controls.player = controls;
			m_player = controls;
			m_numberPlayers = players;
		}
		//------------------------------------------------------------------------
		// public methods
		//------------------------------------------------------------------------
		override public function init():void
		{
			initSkin();
		}
		
		/*
		* function that goes every frame
		*/
		override public function update():void
		{
			if(!hit)updateControls();
			if(!battery) return;
			if(hit) hitt();
			checkHit();
		}
		
		override public function dispose():void
		{
			disposeSkin();
			disposeGameOver();
			disposeObstacle();
			disposeSound();
		}
		
		//------------------------------------------------------------------------
		// private methods
		//------------------------------------------------------------------------
		/*
		* function to check the inputs
		*/
		private function updateControls():void
		{	
			if(!startGame) 
			{
				if(Input.keyboard.anyPressed()) startGame = true; 
			}

			if(!battery || die) return;
				if(Input.keyboard.pressed(m_controls.PLAYER_LEFT)) this.moveLeft(); 
				else if(Input.keyboard.pressed(m_controls.PLAYER_RIGHT)) this.moveRight();
				else if(Input.keyboard.pressed(m_controls.PLAYER_DOWN)) this.moveDown(); 
				else if(Input.keyboard.pressed(m_controls.PLAYER_UP)) this.moveUp(); 
				
				if(Input.keyboard.justPressed(m_controls.PLAYER_BUTTON_1) && powerUp > 0) this.addObstacle()
		}
		
		/*
		* function to move the avatar up,
		* unless he have "wrongside" then he goes down
		*/
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
		
		/*
		* function to move the avatar down,
		* unless he have "wrongside" then he goes up
		*/
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
		
		/*
		* function to move the avatar left,
		* unless he have "wrongside" then he goes right
		*/
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
		
		/*
		* function to move the avatar right,
		* unless he have "wrongside" then he goes left
		*/
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
		
		/*
		* function to add a obstacle at the other players maze
		*/
		private function addObstacle():void
		{
			powerUp --;			
			switch(obstacleType)
			{
				case 0:
					obstacle = new Obstacle(0);
					
					obstacle.y = _skin.y;
					if(m_player == 0)obstacle.x = _skin.x + 400;
					else if(m_player == 1)obstacle.x = _skin.x - 400;
					
					bombs.push(obstacle);
					
					this.addChild(obstacle);
					bomb = false;
					break;
		
				case 1:
					activateWrongSide = true;
					break;
			}			
		}
		
		/*
		* function to check which side of the robot hit the wall
		*/
		private function hitt():void
		{
			if(m_hitSide == "up") _skin.y += speed; 
			else if(m_hitSide == "down") _skin.y -= speed; 
			else if(m_hitSide == "left") _skin.x += speed; 
			else if(m_hitSide == "right") _skin.x -= speed;
			
			hit = false;
			
			return;
		}
		
		/*
		* function to check if the robot got any more battery
		*/
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
		
		/*
		* function to init the refill sound at the robot
		*/
		private function initRefillSound():void
		{
			Session.sound.musicChannel.sources.add("game_refillSound", RobotRefill_mp3);
			m_refillSound = Session.sound.musicChannel.get("game_refillSound");
			m_refillSound.play();
			m_refillSound.volume = 0.5;
		}
		
		/*
		* function to give the avatar a flicker effect when he/she dies
		*/
		private function initGameOver():void
		{			
			m_flickr = new Flicker(_skin, 1000); //obj, tid (hur länge), intervall
			Session.effects.add(m_flickr);
		}

		/*
		* function to give the avatar some skin and hit area
		*/
		private function initSkin():void
		{
			if(m_player == 0) _skin = new Robot1_mc();
			else if(m_player == 1) _skin = new Robot2_mc();
			
			_skin.gotoAndStop("front");
			
		//	m_square.graphics.beginFill(0xCCFF00);
			m_square.graphics.drawRect(8.25, 15.7, 18.55, 17.5);
			_skin.hitArea = m_square;
			area = _skin.hitArea;
			
			skin = _skin;
			
			this.addChild(_skin);
			_skin.addChild(_skin.hitArea);
		}
		//------------------------------------------------------------------------
		// public methods
		//------------------------------------------------------------------------
		/*
		* function to init the functionality at the battery
		*/
		public function initBattery():void
		{
			battery = new Battery(m_numberPlayers);
		}
		
		//------------------------------------------------------------------------
		// dispose methods
		//------------------------------------------------------------------------
		private function disposeSound():void
		{
			m_refillSound = null;
		}
		
		private function disposeSkin():void
		{
			m_controls = null;
			m_square = null;
			_skin.hitArea = null;
			_skin = null;
			skin = null;
			battery = null;
			area = null;
			
			trace("dispose Robot");
		}
		
		private function disposeObstacle():void
		{
			for(var i:uint = 0; i<bombs.length; i++)
			{
				bombs[i] = null;
			}
			bombs = null;
			obstacle = null;
		}
		
		private function disposeGameOver():void
		{
			m_flickr = null;
		}

	}
}