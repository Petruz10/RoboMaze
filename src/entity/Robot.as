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
		//------------------------------------------------------------------------
		// private properties 
		//------------------------------------------------------------------------
		private var m_controls:EvertronControls = new EvertronControls();
		
		private var speed:int = 3;
		private var hitSide:String;		
		private var m_player:int;
		
		private var flickr:Flicker;
		
		private var up:Boolean = false;
		private var down:Boolean = false;
		private var right:Boolean = false;
		private var left:Boolean = false;
		
		private var square:Sprite = new Sprite();
		
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
		}
		
		//------------------------------------------------------------------------
		// private methods
		//------------------------------------------------------------------------
		private function updateControls():void
		{	
			if(Input.keyboard.pressed(m_controls.PLAYER_LEFT)) 
			{
				//if(!down && !up && !right) left = true;
				this.moveLeft(); 
				
				return;
			}
			else if(Input.keyboard.pressed(m_controls.PLAYER_RIGHT)) 
			{
			//	if(!down && !up && !left) right = true;
				this.moveRight(); return;
				
			}
			else if(Input.keyboard.pressed(m_controls.PLAYER_DOWN)) 
			{
			//	if(!right && !up && !left) down = true;
				this.moveDown(); return;
				
			}
			else if(Input.keyboard.pressed(m_controls.PLAYER_UP)) 
			{
				//if(!down && !right && !left)up = true;
				this.moveUp(); return;
			}
		}
		
		private function moveUp():void
		{	
			
			
			hitSide = "up";
			if(battery.HP != 0) 
			{
				_skin.y -= speed; 
				_skin.gotoAndStop("back");
			//	square.width = 30;
			//	square.graphics.beginFill(0xFF2200);
			//	drawSquare(2, 11, 27, 25);
			}
			return;
		}
		
		private function moveDown():void
		{
		/*	up = false;
			down = true;
			left = false;
			right = false;*/
			
			hitSide = "down";
			if(battery.HP != 0)
			{
				_skin.y += speed; 
				_skin.gotoAndStop("front");
			//	square.width = 30;
			//	square.graphics.beginFill(0xFF2200);
			//	square.graphics.drawRect(2, 11, 27, 25);
				//drawSquare(2,11, 27, 25);
			}
			return;
		}
		
		private function moveLeft():void
		{
			/*up = false;
			down = false;
			left = true;
			right = false;
			*/
			
			hitSide = "left";
			if(battery.HP != 0) 
			{
				_skin.x -= speed; 
				//_skin.scaleX *=- 1;
				_skin.gotoAndStop("side");
			//	square.width = 16;
			//	square.graphics.beginFill(0xCCFF00);
			//	drawSquare(2, 11, 7, 25);
			}
			return;
		}
		
		private function moveRight():void
		{/*
			up = false;
			down = false;
			left = false;
			right = true;*/
			
			hitSide = "right";
			if(battery.HP != 0) 
			{
				_skin.x += speed; 
			//	_skin.scaleX *= 1;
				_skin.gotoAndStop("side");
			//	square.width = 16;
			//	square.graphics.beginFill(0xCCFF00);
			//	drawSquare(2, 11, 7, 25);
			}
			return;

		}
		
		private function drawSquare(a:int,b:int,c:int,d:int):void
		{
			square.graphics.beginFill(0xCCFF00);
			square.graphics.drawRect(a,b,c,d)
			_skin.hitArea = square;
			area = _skin.hitArea;
		}
		
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
			
			
			square.graphics.beginFill(0xCCFF00);
			square.graphics.drawRect(2, 11, 20, 25);
			/*if(_skin.currentFrame == 3) 
			{
				square.graphics.drawRect(2, 11, 23, 25);
				trace("side??");
			}
			else 
			{
				square.graphics.drawRect(2, 11, 27, 25);
				trace("front, back")
			}*/
			
			_skin.hitArea = square;
			area = _skin.hitArea;
		//	drawSquare(1,1,1,1);
			battery = new Battery();
			
			this.addChild(_skin);
			_skin.addChild(_skin.hitArea);
		}
		
		private function disposeSkin():void
		{
			m_controls = null;
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