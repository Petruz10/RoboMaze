package entity
{
	import flash.display.MovieClip;
	
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;

	public class Robot extends DisplayStateLayerSprite
	{
		private var m_controls:EvertronControls = new EvertronControls();
		private var m_skin:Avatar;
		private var speed:int = 5;
		private var hitSide:String;
		
		public var hit:Boolean;
				
		public function Robot()
		{
			//super.init();
			
		}
		
		override public function init():void
		{
			initSkin();
		}
		
		override public function update():void
		{
			updateControls()
			if(hit) hitt();
		}
		
		private function updateControls():void
		{
			if(Input.keyboard.justPressed(m_controls.PLAYER_LEFT)) this.moveLeft();
			else if(Input.keyboard.justPressed(m_controls.PLAYER_RIGHT)) this.moveRight();
			else if(Input.keyboard.justPressed(m_controls.PLAYER_DOWN)) this.moveDown();
			else if(Input.keyboard.justPressed(m_controls.PLAYER_UP)) this.moveUp();
		}
		
		private function moveUp():void
		{	
			hitSide = "up";
			if(!hit) this.y -= speed;
		}
		
		private function moveDown():void
		{
			hitSide = "down";
			if(!hit) this.y += speed;
		}
		
		private function moveLeft():void
		{
			hitSide = "left";
			if(!hit) this.x -= speed;
		}
		
		private function moveRight():void
		{
			hitSide = "right";
			if(!hit) this.x += speed;
		}
		
		private function hitt():void
		{
			if(hitSide == "up") this.y = this.y + speed;
			if(hitSide == "down") this.y = this.y - speed;
			if(hitSide == "left") this.x = this.x + speed; 
			if(hitSide == "right") this.x = this.x - speed;
			
			hit = false;
			
			return;
		}
		
		private function initSkin():void
		{
			m_skin = new Avatar();
			
			this.addChild(m_skin);
		}

	}
}