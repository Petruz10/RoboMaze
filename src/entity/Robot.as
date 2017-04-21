package entity
{
	//------------------------------------------------------------------------
	// imports
	//------------------------------------------------------------------------
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;

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
		
		//------------------------------------------------------------------------
		// private properties 
		//------------------------------------------------------------------------
		private var m_controls:EvertronControls = new EvertronControls();
	//	private var m_skin:Robot1_mc;
		private var speed:int = 3;
		private var hitSide:String;
	
		private var hitUp:Boolean;
		private var hitDown:Boolean;
		private var hitLeft:Boolean;
		private var hitRight:Boolean;
		
		private var m_battery:Battery;
				
		public function Robot(controls:int=0)
		{
			super();
			trace("konstruktor Robot");
			m_controls.player = controls;
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
			//disposeControls();
			disposeSkin();
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
		}
		
		private function moveUp():void
		{	
			hitSide = "up";
			if(!hitUp && m_battery.HP != 0) _skin.y -= speed; _skin.gotoAndStop("back");
		}
		
		private function moveDown():void
		{
			hitSide = "down";
			if(!hitDown && m_battery.HP != 0) _skin.y += speed; _skin.gotoAndStop("front");
		}
		
		private function moveLeft():void
		{
			hitSide = "left";
			if(!hitLeft && m_battery.HP != 0) 
			{
				_skin.x -= speed; 
				//_skin.gotoAndStop("side");
			}
		}
		
		private function moveRight():void
		{
			hitSide = "right";
			if(!hitRight && m_battery.HP != 0) 
			{
				_skin.x += speed; 
				//_skin.gotoAndStop("side");
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
				m_battery.HP += 25; 
				if(m_battery.HP > 100) m_battery.HP = 100;
				hitBattery=false;
			}
		}

		private function initSkin():void
		{
			_skin = new Robot1_mc();
			_skin.width = 35;
			_skin.height = 35;
			_skin.gotoAndStop("front");

			m_battery = new Battery();
			
			this.addChild(_skin);
		}
		
		private function disposeSkin():void
		{
			m_controls = null;
			_skin = null;
			m_battery = null;
		}

	}
}