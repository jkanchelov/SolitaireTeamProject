package
{
	import flash.display.Sprite;
	import MainMenu;
	import SharedClasses.Card;
	
	/**
	 * ...
	 * @author Slobodan
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