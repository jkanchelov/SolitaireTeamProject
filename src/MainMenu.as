package
{
	import com.greensock.events.LoaderEvent;
	import SharedClasses.*;
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	
	/**
	 * ...
	 * @author SolitaireTeam
	 */
		
	public class MainMenu extends Sprite
	{
		private const MAIN_MENU_BUTTONS:Vector.<String> = new < String > ["prison.png",
		"eightOff.png","grandFather.png","alternations.png","topsyTurvyQueens.png"]

		private const STAGE_WIDTH:int = 800;
		private const STAGE_HEIGHT:int = 600;
		private const BUTTON_WIDTH:int = 200;
		private const BUTTON_HEIGHT:int = 80; 
		private const BUTTON_SPACING:int = 10;
		
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
			
			var buttonCounter:int = 0;
			
			for (var i:int = 0; i < MainMenuButtons.length; i++) 
			{
				var button:MenuButton = new MenuButton(MainMenuButtons[i]);
				button.x = STAGE_WIDTH / 2 - BUTTON_WIDTH / 2;
				button.y = STAGE_HEIGHT / 5 + BUTTON_HEIGHT * buttonCounter + BUTTON_SPACING;
				button.buttonMode = true;
				buttonsContainer.addChild(button);
				
				//add event listener
				var functionName:String = MainMenuButtons[i].substring(0, MainMenuButtons[i].length - 4);
				var buttonFunction:Function = this[functionName];
				button.addEventListener(MouseEvent.CLICK, buttonFunction);
				
				buttonCounter++;
			}
		}
		
		private function eightOff(e:Event):void
		{
			//TODO:
			trace("eightOff");
		}
		
		private function grandFather(e:Event):void
		{
			//TODO:
			trace("grandFather");
		}
		
		private function prison(e:Event):void
		{
			//TODO:
			trace("prison");
		}
		
		private function alternations(e:Event):void
		{
			//TODO:
			trace("alternations");
		}
		
		private function topsyTurvyQueens(e:Event):void
		{
			//TODO:
			trace("topsyTurvyQueens");
		}
		
		private function loadBackground():void
		{
			addChild(backgroundContainer);
			
			var backgroundUrl:URLRequest = new URLRequest("Data/images/Background/background2.jpg");
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