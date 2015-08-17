package
{
	import com.greensock.events.LoaderEvent;
	import Games.Prison.PrisonSolitaire;
	import Games.TopsyTurvyQueens.TopsyTurvyQueens;
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
		private const MAIN_MENU_BUTTONS:Vector.<String> = new <String>["prison.png", "eightOff.png", "grandFather.png", "alternations.png", "topsyTurvyQueens.png"]
		
		private const STAGE_WIDTH:int = 800;
		private const STAGE_HEIGHT:int = 600;
		private const BUTTON_WIDTH:int = 200;
		private const BUTTON_HEIGHT:int = 60;
		private const BUTTON_SPACING:int = 5;
		
		private var backgroundPath:String = "background1.jpg";
		private var cash:int = 1000;
		
		private var backgroundContainer:Sprite = new Sprite();
		private var musicButtonContainer:Sprite = new Sprite();
		
		private var menuContainer:Sprite = new Sprite();
		
		public function MainMenu()
		{
			loadBackground();
			loadMenuButtons();
			loadMusic();
		}
		
		private function loadMenuButtons():void
		{
			addChild(menuContainer);
			
			var buttonCounter:int = 0;
			
			for (var i:int = 0; i < MAIN_MENU_BUTTONS.length; i++)
			{
				var button:MenuButton = new MenuButton(MAIN_MENU_BUTTONS[i]);
				button.x = STAGE_WIDTH / 2 - BUTTON_WIDTH / 2;
				button.y = STAGE_HEIGHT / 5 + BUTTON_HEIGHT * buttonCounter + BUTTON_SPACING * buttonCounter;
				button.buttonMode = true;
				menuContainer.addChild(button);
				
				//add event listener
				var functionName:String = MAIN_MENU_BUTTONS[i].substring(0, MAIN_MENU_BUTTONS[i].length - 4);
				var buttonFunction:Function = this[functionName];
				button.addEventListener(MouseEvent.CLICK, buttonFunction);
				
				buttonCounter++;
			}
		}
		
		private function prison(e:Event):void
		{
			startGame(PrisonSolitaire);
		}
		
		private function eightOff(e:Event):void
		{
			//TODO:
			trace("eightOff");
		}
		
		private function grandFather(e:Event):void
		{
			//startGame(grandFather)
		}
		
		private function alternations(e:Event):void
		{
			//TODO:
			//startGame(alternations)
		}
		
		private function topsyTurvyQueens(e:Event):void
		{
			
			startGame(TopsyTurvyQueens);
			
		}
		
		private function startGame(game:Object):void
		{
			clearMainMenu();
			
			addChild(new game());
		}
		
		private function loadMusic():void
		{
			addChild(musicButtonContainer);
			
			var music:Music = new Music();
			music.showButton();
			
			musicButtonContainer.addChild(music);
		}
		
		private function showMainMenu():void
		{
			addChild(menuContainer);
		}
		
		private function clearMainMenu():void
		{
			removeChild(menuContainer);
		}
		
		private function loadBackground():void
		{
			addChild(backgroundContainer);
			
			var backgroundUrl:URLRequest = new URLRequest("Data/images/Background/" + backgroundPath);
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