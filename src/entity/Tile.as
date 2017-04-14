package entity
{
	import flash.geom.Rectangle;
	import flash.geom.Matrix;

	public class Tile extends Entity {
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
					_skin = new Wall; 		// vertical wall
				break;
				case 2:
					_skin = new Wall; 		// horizontal wall
					setRotation(90);
				break;
				case 3:
					_skin = new Turn; 		// turn right up
				break;
				case 4:
					_skin = new Turn;
					setRotation(90);// turn left up
				break;
				case 5:
					_skin = new Turn;
					setRotation(270); // turn right down
				break;
				case 6:
					_skin = new Turn;
					setRotation(180); // turn left down
				break;
				case 7:
					_skin = new End; 		// end right
				break;
				case 8:
					_skin = new End;
					setRotation(180); // end left
				break;
				case 9:
					_skin = new End;
					setRotation(-90); // end up
				break;
				case 10:
					_skin = new End;
					setRotation(90); // end down
				break;
				case 11:
					_skin = new T_Intersection; 	// T-section right
				break;
				case 12:
					_skin = new T_Intersection;
					setRotation(180); // T-section left
				break;
				case 13:
					_skin = new T_Intersection;
					setRotation(-90); // T-section up
					break;
				case 14:
					_skin = new T_Intersection;
					setRotation(90); // T-section down	
					break;
				case 15:
					_skin = new Fourway_Intersection;
				break;
				case 20:
					_skin = new Avatar;
				break;
			}
			if(_skin)addChild(_skin);
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
	}
}