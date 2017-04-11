package component
{
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public class Maze extends Sprite {
		/*
		* maze design
		*/
		private var _mazeArray:Array;
		/*
		* 
		*/
		private const MAZE_HEIGHT:int = 600; 	// total height 
		private const MAZE_WIDTH:int = 800; 	// total width
		private const TILE_HEIGHT:int = 100; // tile height
		private const TILE_WIDTH:int = 100; // tile width
		
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
			trace("initMaze");
			/*_mazeVector = new Vector.<int>([
				[3,2,14,2,2,2,2,4],
				[1,0,1,0,0,0,0,1],
				[1,0,10,0,3,2,2,12],
				[1,0,0,0,10,0,0,1],
				[1,0,0,0,0,0,0,1],
				[5,0,0,0,0,0,0,6]
			]);*/
		} 
		//------------------------------------------------------------------------
		// fill object with tiles based on mazeVector
		// each tile is 100x100px
		//------------------------------------------------------------------------
		// https://gamedevelopment.tutsplus.com/tutorials/an-introduction-to-creating-a-tile-map-engine--gamedev-10900
		private function initTiles():void {
			var tile:MovieClip;
			trace("initTiles()");
		/*	_mazeArray = [
				[3,3,3,3,3,3,3,3],
				[2,2,2,2,2,2,2,2],
				[2,2,2,2,2,2,2,2],
				[2,2,2,2,2,2,2,2],
				[2,2,2,2,2,2,2,2],
				[2,2,2,2,2,2,2,2]
			]; */
			_mazeArray = [
				[1,1,1,1,1,1,1,1],
				[1,0,1,0,0,0,0,1],
				[1,0,1,0,1,1,1,1],
				[1,0,0,0,1,0,0,1],
				[1,0,0,0,0,0,0,1],
				[1,1,1,1,1,1,1,20]
			]; 
			for (var i:int = 0; i <_mazeArray.length; i++ ){
				for (var j:int = 0; j < _mazeArray[i].length; j++) {
					tile = rotateTile(_mazeArray[i][j]);
					tile.y = i * 100;
					tile.x = j * 100;
					tile.width = 100;
					tile.height = 100;
					this.addChild(tile);
				}
			}
		}
		//------------------------------------------------------------------------
		// using the tile object to retrieve tiles
		//------------------------------------------------------------------------
		private function rotateTile(index:int):MovieClip {
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
					tile.rotation = 90;
				break;
				case 3:
					tile = new Turn; 		// turn right up
				break;
				case 4:
					tile = new Turn;
					tile.rotation = -180; 	// turn left up 
				break;
				case 5:
					tile = new Turn;
					tile.rotation = 270; 	// turn right udown
				break;
				case 6:
					tile = new Turn;
					tile.rotation = 180		// turn left down
				break;
				case 7:
					tile = new End; 		// end right
				break;
				case 8:
					tile = new End;
					tile.rotation = 180; 	// end left
				break;
				case 9:
					tile = new End;
					tile.rotation = -90; 	// end up
				break;
				case 10:
					tile = new End;
					tile.rotation = 90; 	// end down
				break;
				case 11:
					tile = new T_Intersection; 	// T-section right
				break;
				case 12:
					tile = new T_Intersection;
					tile.rotation = 180; 		// T-section left
				break;
				case 13:
					tile = new T_Intersection;
					tile.rotation = -90; 		// T-section up
					break;
				case 14:
					tile = new T_Intersection;
					tile.rotation = 90; 		// T-section down
					break;
				case 15:
					tile = new FourwayIntersection;
				break;
				case 20:
					tile = new Avatar;
					break;
			}
			return tile;
		}
	}
}