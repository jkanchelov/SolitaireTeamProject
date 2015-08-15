package
{
	import com.greensock.events.LoaderEvent;
	import SharedClasses.*;
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	
	/**
	 * ...
	 * @author SS
	 */
	public class MainMenu extends Sprite
	{
		private const StageWidth:int = 800;
		private const StageHeight:int = 600;
		private const ButtonWidth:int = 200;
		private const ButtonHeight:int = 80; 
		private const ButtonSpacing:int = 10;
		
		private var mainMenuButtons:Vector.<String> = new <String>["prison.png","eightOff.png","grandFather.png","alternations.png","topsyTurvyQueens.png"]
		
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
			
			for (var i:int = 0; i < mainMenuButtons.length; i++) 
			{
				var button:MenuButton = new MenuButton(mainMenuButtons[i]);
				button.x = StageWidth / 2 - ButtonWidth / 2;
				button.y = StageHeight / 5 + ButtonHeight * buttonCounter + ButtonSpacing;
				button.buttonMode = true;
				buttonsContainer.addChild(button);
				
				//add event listener
				var functionName:String = mainMenuButtons[i].substring(0, mainMenuButtons[i].length - 4);
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