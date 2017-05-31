package entity
{
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;

	public class Tile extends DisplayStateLayerSprite {
		/*
		* 
		*/
		public const TILE_HEIGHT:int = 50; // tile height
		/*
		* 
		*/
		public const TILE_WIDTH:int = 50; // tile width
		/*
		* used to check if current tile is a path or not
		*/
		public var path:Boolean;
		/*
		* used to determin rotation
		*/
		private var type:int;
		
		protected var _skin:MovieClip;
		//------------------------------------------------------------------------
		// update controls
		//------------------------------------------------------------------------
		public function Tile(type:int){
			super.init();
			this.type = type;
			initTile();
		}
		//------------------------------------------------------------------------
		// update controls
		//------------------------------------------------------------------------
		private function initTile():void {
			setPath();
			setSkin();
			this.width = TILE_WIDTH;
			this.height = TILE_HEIGHT;
		}  
		//------------------------------------------------------------------------
		// set path
		//------------------------------------------------------------------------
		private function setPath():void {
			if (type == 0) { path = true; }
			else { path = false; }
		}
		//------------------------------------------------------------------------
		// _skin based on type
		//------------------------------------------------------------------------
		private function setSkin():void {	
			switch(type) {
				case 0:
					//_skin = new Path; 		// path
				break;
				case 1:
					_skin = new Tile_Straight_mc; 		// vertical wall
				break;
				case 2:
					_skin = new Tile_Straight_mc; 		// horizontal wall
					setRotation(90);
				break;
				case 3:
					_skin = new Tile_Turn_mc; 		// turn right up
				break;
				case 4:
					_skin = new Tile_Turn_mc;
					setRotation(90);// turn left up
				break;
				case 5:
					_skin = new Tile_Turn_mc;
					setRotation(270); // turn right down
				break;
				case 6:
					_skin = new Tile_Turn_mc;
					setRotation(180); // turn left down
				break;
				case 7:
					_skin = new Tile_End_mc; 		// end right
				break;
				case 8:
					_skin = new Tile_End_mc;
					setRotation(180); // end left
				break;
				case 9:
					_skin = new Tile_End_mc;
					setRotation(-90); // end up
				break;
				case 10:
					_skin = new Tile_End_mc;
					setRotation(90); // end down
				break;
				case 11:
					_skin = new Tile_T_mc; 	// T-section right
				break;
				case 12:
					_skin = new Tile_T_mc;
					setRotation(180); // T-section left
				break;
				case 13:
					_skin = new Tile_T_mc;
					setRotation(-90); // T-section up
					break;
				case 14:
					_skin = new Tile_T_mc;
					setRotation(90); // T-section down	
					break;
				case 15:
					_skin = new Tile_Fourway_mc;
				break;
			}
			if(_skin)this.addChild(_skin);
		}
		//------------------------------------------------------------------------
		// rotate tile (_skin)
		//------------------------------------------------------------------------
		private function setRotation(degrees:int):void {
			var matrix:Matrix = _skin.transform.matrix;
			var rect:Rectangle = _skin.getBounds(_skin.parent);

			matrix.translate(- (rect.left + (rect.width/2)), - (rect.top + (rect.height/2)));
			matrix.rotate((degrees/180)*Math.PI);
			matrix.translate(rect.left + (rect.width / 2), rect.top + (rect.height / 2));
			_skin.transform.matrix = matrix;
		}
		
		//------------------------------------------------------------------------
		// dispose methods
		//------------------------------------------------------------------------
		
		override public function dispose():void
		{
			super.dispose();
			disposeSkin();
		}
		
		private function disposeSkin():void
		{
			_skin = null;
		}
	}
}