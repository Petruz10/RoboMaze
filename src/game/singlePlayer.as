package game
{
	import state.Game;

	public class SinglePlayer extends Game
	{
		public function SinglePlayer()
		{
			super.addMaze(1);
		}
	}
}