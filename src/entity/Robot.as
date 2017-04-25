package entity
{
	//------------------------------------------------------------------------
	// imports
	//------------------------------------------------------------------------
	import flash.display.Sprite;
	
	import se.lnu.stickossdk.fx.Flash;
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
		public var hit:Boolean;
		public var hitBattery:Boolean = false;
		
		public var area:Sprite;
		//------------------------------------------------------------------------
		// private properties 
		//------------------------------------------------------------------------
		private var m_controls:EvertronControls = new EvertronControls();
		
		private var speed:int = 3;
		private var hitSide:String;
	
		private var hitUp:Boolean;
		private var hitDown:Boolean;
		private var hitLeft:Boolean;
		private var hitRight:Boolean;
		
		private var m_player:int;
		
		
		public var battery:Battery;
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
			updateControls();
			if(hit) hitt();
			checkHit();
		}
		
		override public function dispose():void
		{
			disposeSkin();
		}
		
		//------------------------------------------------------------------------
		// private methods
		//------------------------------------------------------------------------
		private function updateControls():void
		{
			if(Input.keyboard.pressed(m_controls.PLAYER_LEFT)) 
			{
				this.moveLeft(); 
				return;
			}
			else if(Input.keyboard.pressed(m_controls.PLAYER_RIGHT)) 
			{
				this.moveRight(); return;
			}
			else if(Input.keyboard.pressed(m_controls.PLAYER_DOWN)) 
			{
				this.moveDown(); return;
			}
			else if(Input.keyboard.pressed(m_controls.PLAYER_UP)) 
			{
				this.moveUp(); return;
			}
		}
		
		private function moveUp():void
		{	
			hitSide = "up";
			if(!hitUp && battery.HP != 0) 
			{
				_skin.y -= speed; 
				_skin.gotoAndStop("back");
				return;
			}
		}
		
		private function moveDown():void
		{
			hitSide = "down";
			if(!hitDown && battery.HP != 0)
			{
				_skin.y += speed; 
				_skin.gotoAndStop("front");
				return;
			}
		}
		
		private function moveLeft():void
		{
			hitSide = "left";
			if(!hitLeft && battery.HP != 0) 
			{
				_skin.x -= speed; 
				//_skin.scaleX *=- 1;
				_skin.gotoAndStop("side");
				return;	
			}
		}
		
		private function moveRight():void
		{
			hitSide = "right";
			if(!hitRight && battery.HP != 0) 
			{
				_skin.x += speed; 
			//	_skin.scaleX *= 1;
				_skin.gotoAndStop("side");
				return;
			}
			
		}
		
		private function hitt():void
		{
			if(hitSide == "up") _skin.y += speed;
			if(hitSide == "down") _skin.y -= speed;
			if(hitSide == "left") _skin.x += speed;
			if(hitSide == "right") _skin.x -= speed;
			
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
			if(battery.HP == 0) Session.timer.create(1000, gameOver);
		}
		
		private function gameOver():void
		{
			Session.application.displayState = new GameOver;
		}

		private function initSkin():void
		{
			if(m_player == 0)_skin = new Robot1_mc();
			else if(m_player == 1) _skin = new Robot2_mc();
			
			_skin.width = 35;
			_skin.height = 35;
			_skin.gotoAndStop("front");
			
			var square:Sprite = new Sprite();
			//square.graphics.beginFill(0xCCFF00);
			square.graphics.drawRect(100, 130, 230, 250);
			
			_skin.hitArea = square;
			area = _skin.hitArea;
			
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

	}
}