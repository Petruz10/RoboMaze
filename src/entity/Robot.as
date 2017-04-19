package entity
{
	import flash.display.MovieClip;
	
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;

	public class Robot extends Entity
	{
		private var m_controls:EvertronControls = new EvertronControls();
		private var m_skin:Avatar;
		private var speed:int = 5;
		private var hitSide:String;
		
		public var hit:Boolean;
		
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
		
		override public function init():void
		{
			initSkin();
			trace("init Robot");
		}
		
		override public function update():void
		{
			updateControls();
			if(hit) hitt();
		}
		
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
			if(!hitUp && m_battery.HP != 0) m_skin.y -= speed;
		}
		
		private function moveDown():void
		{
			hitSide = "down";
			if(!hitDown && m_battery.HP != 0) m_skin.y += speed;
		}
		
		private function moveLeft():void
		{
			hitSide = "left";
			if(!hitLeft && m_battery.HP != 0) m_skin.x -= speed;
		}
		
		private function moveRight():void
		{
			hitSide = "right";
			if(!hitRight && m_battery.HP != 0) m_skin.x += speed;
		}
		
		private function hitt():void
		{
			if(hitSide == "up") m_skin.y += speed;
			if(hitSide == "down") m_skin.y -= speed;
			if(hitSide == "left") m_skin.x += speed;
			if(hitSide == "right") m_skin.x -= speed;
			
			hit = false;
			
			return;
		}

		private function initSkin():void
		{
			m_skin = new Avatar();
			m_battery = new Battery();
			
			this.addChild(m_skin);
		}

	}
}