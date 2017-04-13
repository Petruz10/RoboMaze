package component
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.geom.Point;

	public class Maze extends Sprite {
		/*
		* maze design
		*/
		private var _mazeArray:Array;
		/*
		* 
		*/
		private const MAZE_HEIGHT:int = 600; 	// total height 
		/*
		* 
		*/
		private const MAZE_WIDTH:int = 800; 	// total width
		/*
		* 
		*/
		private const TILE_HEIGHT:int = 50; // tile height
		/*
		* 
		*/
		private const TILE_WIDTH:int = 50; // tile width
		
		//------------------------------------------------------------------------
		// Constructor
		//------------------------------------------------------------------------
		public function Maze(){
			trace("Maze constructor");
			initMaze();
			initTiles();
		}
		//------------------------------------------------------------------------
		// create Vector
		//------------------------------------------------------------------------
		private function initMaze():void {
			_mazeArray = [
				[3,2,2,2,2,2,14,2,2,2,2,2,2,2,2,4],
				[1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1],
				[1,0,3,2,7,0,11,2,14,2,4,0,3,7,0,1],
				[1,0,1,0,0,0,1,0,1,0,1,0,1,0,0,1],
				[1,0,1,0,8,2,12,0,1,0,5,2,6,0,0,1],
				[1,0,1,0,0,0,10,0,1,0,0,0,0,0,0,1],
				[11,2,13,2,7,0,0,0,10,0,8,14,2,7,0,1],
				[1,0,0,0,0,0,9,0,0,0,0,1,0,0,0,1],
				[1,0,0,0,3,2,6,0,3,2,2,15,2,4,0,1],
				[1,0,8,2,6,0,0,0,1,0,0,10,0,10,0,1],
				[1,0,0,0,0,0,9,0,1,0,0,0,0,0,0,1],
				[5,2,2,2,2,2,13,2,13,2,2,2,2,2,2,6]
			];
			/*_mazeArray = [
				[3,2,14,2,2,2,2,4],
				[1,0,1,0,0,0,0,1],
				[1,0,10,0,3,2,2,12],
				[1,0,0,0,10,0,0,1],
				[1,0,0,0,0,0,0,1],
				[5,2,2,2,2,2,2,6]
			]; */ 
		} 
		//------------------------------------------------------------------------
		// fill object with tiles based on mazeVector
		// each tile is 100x100px
		//------------------------------------------------------------------------
		// https://gamedevelopment.tutsplus.com/tutorials/an-introduction-to-creating-a-tile-map-engine--gamedev-10900
		private function initTiles():void {
			/*
			* the tile to add 
			*/
			var tile:MovieClip;

			for (var i:int = 0; i <_mazeArray.length; i++ ){
				for (var j:int = 0; j < _mazeArray[i].length; j++) {
					tile = createTileFromIndex(_mazeArray[i][j]);
					tile.y = i * TILE_WIDTH;
					tile.x = j * TILE_HEIGHT;
					tile.scaleX = 0.5;
					tile.scaleY = 0.5;
					this.addChild(tile);
				}
			}
		}
		//------------------------------------------------------------------------
		// using the tile object to retrieve tiles
		//------------------------------------------------------------------------
		private function createTileFromIndex(index:int):MovieClip {
			/*
			* transformed tile to return 
			*/
			var tile:MovieClip;
			
			switch(index) {
				case 0:
					tile = new Path; 		// path
				break;
				case 1:
					tile = new Wall; 		// vertical wall
				break;
				case 2:
					tile = new Wall; 		// horizontal wall
					tile = rotateTileAroundCenter(tile, 90);
				break;
				case 3:
					tile = new Turn; 		// turn right up
				break;
				case 4:
					tile = new Turn;
					tile = rotateTileAroundCenter(tile, 90);// turn left up
				break;
				case 5:
					tile = new Turn;
					tile = rotateTileAroundCenter(tile, 270); // turn right down
				break;
				case 6:
					tile = new Turn;
					tile = rotateTileAroundCenter(tile, 180); // turn left down
				break;
				case 7:
					tile = new End; 		// end right
				break;
				case 8:
					tile = new End;
					tile = rotateTileAroundCenter(tile, 180); // end left
				break;
				case 9:
					tile = new End;
					tile = rotateTileAroundCenter(tile, -90); // end up
				break;
				case 10:
					tile = new End;
					tile = rotateTileAroundCenter(tile, 90); // end down
				break;
				case 11:
					tile = new T_Intersection; 	// T-section right
				break;
				case 12:
					tile = new T_Intersection;
					tile = rotateTileAroundCenter(tile, 180); // T-section left
				break;
				case 13:
					tile = new T_Intersection;
					tile = rotateTileAroundCenter(tile, -90); // T-section up
					break;
				case 14:
					tile = new T_Intersection;
					tile = rotateTileAroundCenter(tile, 90); // T-section down	
					break;
				case 15:
					tile = new Fourway_Intersection;
				break;
				case 20:
					tile = new Avatar;
					break;
			}
			return tile;
		}
		// http://stackoverflow.com/questions/15789168/as3-rotate-an-object-around-its-center-point
		private function rotateTileAroundCenter(tile:MovieClip, degrees:int):MovieClip {
			trace("rotate");
			//tile.rotation = Math.round(tile.rotation);
			var matrix:Matrix = tile.transform.matrix;
			var rect:Rectangle = tile.getBounds(tile.parent);

			matrix.translate(- (rect.left + (rect.width/2)), - (rect.top + (rect.height/2)));
			matrix.rotate((degrees/180)*Math.PI);
			matrix.translate(rect.left + (rect.width / 2), rect.top + (rect.height / 2));
			tile.transform.matrix = matrix;

			return tile;	
		}

	}
}