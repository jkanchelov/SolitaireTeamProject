package Game
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
	
	/**
	 * ...
	 * @author SS
	 */
	public class MainMenu extends Sprite
	{
		private const _stageWidth:int = 800;
		private const _stageHeight:int = 600;
		
		private var backgroundContainer:Sprite = new Sprite();
		private var buttonsContainer:Sprite = new Sprite();
		
		public function MainMenu()
		{
			loadBackground();
			loadMenuButtons();
		}
		
		private function loadMenuButtons():void
		{
			addChild(buttonsContainer);
			var eightOffButton:MainMenuButton = new MainMenuButton(140, 50, "EIGHT OFF", true, 0);
			eightOffButton.x = _stageWidth/2 - 140 /2;
			eightOffButton.y = 200;
			buttonsContainer.addChild(eightOffButton);
			
			var grandfatherButton:MainMenuButton = new MainMenuButton(200, 50, "GRANDFATHER", true, 0);
			grandfatherButton.x = _stageWidth/2 - 200 /2;
			grandfatherButton.y = 260;
			buttonsContainer.addChild(grandfatherButton);
			
			var prisonButton:MainMenuButton = new MainMenuButton(107, 50, "PRISON", true, 0);
			prisonButton.x = _stageWidth/2 - 107/2;
			prisonButton.y = 320;
			buttonsContainer.addChild(prisonButton);
			
			var alterationsButton:MainMenuButton = new MainMenuButton(185, 50, "ALETRATIONS", true, 0);
			alterationsButton.x =  _stageWidth/2 - 185 /2;
			alterationsButton.y = 380;
			buttonsContainer.addChild(alterationsButton);
			
			var topsyButton:MainMenuButton = new MainMenuButton(270, 50, "TOPSY-TURVY QEENS", true, 0);
			topsyButton.x =_stageWidth/2 - 270/2;
			topsyButton.y = 440;
			buttonsContainer.addChild(topsyButton);
		
		}
		
		private function eightOff():void
		{
			//TODO:
		}
		
		private function grandFather():void
		{
			//TODO:
		}
		
		private function prison():void
		{
			//TODO:
		}
		
		private function alternations():void
		{
			//TODO:
		}
		
		private function topsyTurvyQeens():void
		{
			//TODO:
		}
		
		private function loadBackground():void
		{
			addChild(backgroundContainer);
			
			var backgroundUrl:URLRequest = new URLRequest("Data/images/backgroundMainMenu2.jpg");
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderCompleate);
			loader.load(backgroundUrl);
			var background:Bitmap;
			function loaderCompleate():void
			{
				var bmp:Bitmap = loader.content as Bitmap;
				background = new Bitmap(bmp.bitmapData);
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loaderCompleate);
				backgroundContainer.addChild(background);
			}
		}
	}

}