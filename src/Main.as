package
{
	import com.greensock.events.LoaderEvent;
	import flash.display.*;
	import flash.media.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.text.*;
	import flash.net.*;
	import flash.geom.*;
	import com.greensock.*;
	import com.greensock.easing.*
	import flash.ui.Keyboard;
	import flash.geom.ColorTransform;
	import flash.net.*;
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