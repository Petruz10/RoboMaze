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
		
		public var hit:Boolean;
		public var hitRight:Boolean;
				
		public function Robot()
		{
			//super.init();
			
		}
		
		override public function init():void
		{
			initSkin();
			trace("HHHHH");
		}
		
		override public function update():void
		{
			updateControls()
		}
		
		private function updateControls():void
		{
			if(Input.keyboard.justPressed(m_controls.PLAYER_LEFT)) this.moveLeft();
			else if(Input.keyboard.justPressed(m_controls.PLAYER_RIGHT)) this.moveRight();
			else if(Input.keyboard.justPressed(m_controls.PLAYER_DOWN)) this.moveDown();
			else if(Input.keyboard.justPressed(m_controls.PLAYER_UP)) this.moveUp();
			trace(hit);
		}
		
		private function moveUp():void
		{	
			if(hit)this.y = this.y + speed;
			
			if(!hit) this.y -= speed;
			else
			{
				hit = false;
			}
			
			
			//this.y -= speed;
		}
		
		private function moveDown():void
		{
			if(hit) this.y = this.y - speed;
			
			if(!hit) this.y += speed;
			else
			{
				hit = false;
				//
			}
			
			//this.y += speed;
			//else this.y -= speed; return;
		}
		
		private function moveLeft():void
		{
			if(!hit) this.x -= speed;
			else
			{
				hit = false;
				this.x = this.x + speed;
			}
			//else this.x += speed; return;
			//this.x -= speed;
		}
		
		private function moveRight():void
		{
			if(!hit) this.x += speed;
			else
			{
				hit = false;
				this.x = this.x - speed;
			}
			//else this.x -= speed; return;
			//this.x += speed;
		}
		
		private function hitt(x):void
		{
			if(x == "up") trace("träff uppe");
		}
		
		private function initSkin():void
		{
			m_skin = new Avatar();
			
			//this.x = 100;w
			//this.y = 100;
			
			this.addChild(m_skin);
		}

	}
}