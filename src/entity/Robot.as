package entity
{
	//------------------------------------------------------------------------
	// imports
	//------------------------------------------------------------------------
	import flash.display.Sprite;
	
	import se.lnu.stickossdk.fx.Flicker;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.system.Session;
	
	import state.GameOver;

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
		//------------------------------------------------------------------------
		// private properties 
		//------------------------------------------------------------------------
		private var m_controls:EvertronControls = new EvertronControls();
		
		public var speed:int = 3;
		
		
		private var hitSide:String;		
		private var m_player:int;
		
		private var flickr:Flicker;
		
		private var square:Sprite = new Sprite();
		
		
		public var obstacle:Sprite;
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
		//	if(obstacle) checkhitObstacle();
		}
		
		override public function dispose():void
		{
			disposeSkin();
			disposeGameOver();
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
			hitSide = "up";
			if(battery.HP != 0) 
			{
				_skin.y -= speed; 
				_skin.gotoAndStop("back");
			}
			return;
		}
		
		private function moveDown():void
		{	
			hitSide = "down";
			if(battery.HP != 0)
			{
				_skin.y += speed; 
				_skin.gotoAndStop("front");
			}
			return;
		}
		
		private function moveLeft():void
		{
			hitSide = "left";
			if(battery.HP != 0) 
			{
				_skin.x -= speed; 
				//_skin.scaleX *=- 1;
				_skin.gotoAndStop("side");
			}
			return;
		}
		
		private function moveRight():void
		{
			
			hitSide = "right";
			if(battery.HP != 0) 
			{
				_skin.x += speed; 
			//	_skin.scaleX *= 1;
				_skin.gotoAndStop("side");
			}
			return;

		}
		
		private function addObstacle():void
		{
			powerUp --;
			obstacle = new Sprite();
			
			obstacle.graphics.beginFill(0xCCFF00);
			if(m_player == 0)obstacle.graphics.drawRect(_skin.x+400, _skin.y, 30, 30);
			else if(m_player == 1)obstacle.graphics.drawRect(_skin.x-400, _skin.y, 30, 30);
			
			this.addChild(obstacle);
			trace("add obs funktion");
			trace("x grejs", obstacle.x);
			return;
		}
		
		
		/*private function drawSquare(a:int,b:int,c:int,d:int):void
		{
			square.graphics.beginFill(0xCCFF00);
			square.graphics.drawRect(a,b,c,d)
			_skin.hitArea = square;
			area = _skin.hitArea;
		}
		*/
		private function hitt():void
		{
			if(hitSide == "up") _skin.y += speed; 
			else if(hitSide == "down") _skin.y -= speed; 
			else if(hitSide == "left") _skin.x += speed; 
			else if(hitSide == "right") _skin.x -= speed;
			
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
			}
			
			if(battery.HP == 0)
			{
				initGameOver();
			}
		}
		
		private function initGameOver():void
		{			
			flickr = new Flicker(_skin, 1000, 20); //obj, tid (hur länge), intervall
			Session.effects.add(flickr);
		}

		private function initSkin():void
		{
			if(m_player == 0)_skin = new Robot1_mc();
			else if(m_player == 1) _skin = new Robot2_mc();
			
			//_skin.width = 35;
			//_skin.height = 35;
			_skin.gotoAndStop("front");
			
			
			//square.graphics.beginFill(0xCCFF00);
			square.graphics.drawRect(7, 11, 20, 20);
			_skin.hitArea = square;
			area = _skin.hitArea;

			battery = new Battery();
			
			this.addChild(_skin);
			_skin.addChild(_skin.hitArea);
		}
		
		private function disposeSkin():void
		{
			m_controls = null;
			square = null;
			_skin.hitArea = null;
			_skin = null;
			battery = null;
			
			trace("dispose Robot");
		}
		
		private function disposeGameOver():void
		{
			flickr = null;
			trace("dispose gameOver, flickr effekt");
		}

	}
}