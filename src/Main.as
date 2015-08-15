package
{
	import flash.display.Sprite;
	import Game.MainMenu;
	
	/**
	 * ...
	 * @author SS
	 */
	public class Main extends Sprite 
	{	
		public function Main() 
		{
			var game:MainMenu = new MainMenu();
			addChild(game);
		}
	}
}