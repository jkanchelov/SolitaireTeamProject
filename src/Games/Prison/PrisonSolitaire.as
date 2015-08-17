package Games.Prison
{
	import flash.events.*;
	import flash.display.*;
	import flash.geom.*;
	import flash.net.URLRequest;
	import Games.Prison.Objects.PrisonHelpMenu;
	import SharedClasses.*
	
	/**
	 * ...
	 * @author Jordan
	 */
	public class PrisonSolitaire extends Sprite
	{
		private const STAGE_WIDTH = 800;
		private const STAGE_HEIGHT = 600;
		
		private const FOUNDATION_CONTAINER_X:int = 250;
		private const FOUNDATION_CONTAINER_Y:int = 70;
		private const RESERVE_CONTAINER_X:int = 100;
		private const RESERVE_CONTAINER_Y:int = 195;
		private const TAUBLE_CONTAINER_X:int = 25;
		private const TAUBLE_CONTAINER_Y:int = 320;
		private const CONTAINER_WIDTH:int = 65;
		private const CONTAINER_HEIGHT:int = 100;
		private const CONTAINER_WIDTH_SPACING:int = 10;
		private const CARDS_Y_SPACING:int = 35;
		
		private var cards:Vector.<Card> = new Vector.<Card>();
		private var isGameRunning:Boolean = true;
		private var counterPlacedCards:int = 0;
		
		private var movingCardSprite:Sprite;
		private var movingCardObject:Sprite;
		private var movingCardX:int;
		private var movingCardY:int;
		
		private var menuContainer:Sprite;
		private var foundationContainer:Sprite;
		private var reservesContainer:Sprite;
		private var taublePilesContainer:Sprite;
		
		public function PrisonSolitaire()
		{
			showMenu()
		
			//DealSolitaire();
		}
		
		public function get IsGameRunning():Boolean
		{
			return this.isGameRunning;
		}
		
		private function showMenu():void
		{
			menuContainer = new Sprite();
			
			var helpMenu:PrisonHelpMenu = new PrisonHelpMenu();
			menuContainer.addChild(helpMenu);
			
			var startButton:MenuButton = new MenuButton("start.png");
			startButton.addEventListener(MouseEvent.CLICK, startGame);
			startButton.x = 150;
			startButton.y = helpMenu.height + 20;
			startButton.buttonMode = true;
			menuContainer.addChild(startButton);
			
			var scoreButton:MenuButton = new MenuButton("score.png");
			scoreButton.addEventListener(MouseEvent.CLICK, showScore);
			scoreButton.x = 150;
			scoreButton.y = helpMenu.height + 90;
			scoreButton.buttonMode = true;
			menuContainer.addChild(scoreButton);
			
			menuContainer.x = STAGE_WIDTH / 2 - menuContainer.width / 2;
			addChild(menuContainer);
		}
		
		private function startGame(e:MouseEvent):void
		{
			removeChild(menuContainer);
			menuContainer = null;
			
			DealSolitaire();
		}
		
		private function showScore(e:MouseEvent):void
		{
			//TODO: 
		}
		
		private function DealSolitaire():void
		{
			addCardContainers();
			
			loadDeck();
			loadCardsFoundation();
			loadReservedCards();
			loadTaublePilesCards();
		}
		
		private function loadCardsFoundation():void
		{
			var rndCardNumber:int = randomRange(0, 52 - counterPlacedCards);
			
			var counter:int = 0;
			var counterAddedCards:int = 0;
			
			var cardNumbers:int = 13;
			var cardColors:int = 4
			
			for (var cardValue:int = 0; cardValue < cardNumbers; cardValue++)
			{
				for (var cardSign:int = 0; cardSign < cardColors; cardSign++)
				{
					if (counter == rndCardNumber)
					{
						for (var card:int = cardValue * cardColors; card < cardValue * cardColors + cardColors; card++)
						{
							var object:Sprite = foundationContainer.getChildAt(counterAddedCards) as Sprite;
							object.addChild(cards[card - counterAddedCards])
							
							//removing buttonMode for the foundation cards
							var currentCard:Card = object.getChildAt(1) as Card;
							currentCard.buttonMode = false;
							currentCard.removeEventListener(MouseEvent.MOUSE_DOWN, startDraging);
							currentCard.removeEventListener(MouseEvent.MOUSE_UP, stopDraging);
							
							cards.splice(card - counterAddedCards, 1);
							counterAddedCards++;
							counterPlacedCards++;
						}
					}
					counter++;
				}
			}
		}
		
		private function loadReservedCards():void
		{
			var reservedPiles:int = 8;
			
			for (var i:int = 0; i < reservedPiles; i++)
			{
				var reservedPile:Sprite = reservesContainer.getChildAt(i) as Sprite;
				drawRandomCard(reservedPile);
			}
		}
		
		private function loadTaublePilesCards():void
		{
			var taublePiles:int = 10;
			var taubleCards:int = 4;
			
			for (var pile:int = 0; pile < taublePiles; pile++)
			{
				for (var card:int = 0; card < taubleCards; card++)
				{
					var pileContainer:Sprite = taublePilesContainer.getChildAt(pile) as Sprite;
					var cardY = (pileContainer.numChildren - 1) * CARDS_Y_SPACING;
					drawRandomCard(pileContainer, cardY);
				}
			}
		
		}
		
		private function drawRandomCard(drawAt:Sprite, y:int = 0):void
		{
			var rndCardNumber:int = randomRange(0, 51 - counterPlacedCards);
			drawAt.addChild(cards[rndCardNumber]).y = y;
			counterPlacedCards++;
			cards.splice(rndCardNumber, 1);
		}
		
		private function startDraging(e:MouseEvent):void
		{
			
			if (isLastCardOfPile(e.target as Card))
			{
				movingCardObject = e.target as Sprite;
				
				movingCardSprite = movingCardObject.parent as Sprite;
				movingCardObject.parent.removeChild(movingCardObject);
				
				addChild(movingCardObject);
				movingCardObject.x = mouseX - movingCardObject.width / 2;
				movingCardObject.y = mouseY - movingCardObject.height / 2;
				
				movingCardX = mouseX;
				movingCardY = mouseY;
				
				e.target.startDrag();
			}
		}
		
		private function stopDraging(e:MouseEvent):void
		{
			movingCardObject.stopDrag();
			removeChild(movingCardObject);
			movingCardSprite.addChild(movingCardObject);
			if (true) // cant move
			{
				e.target.x = 0
				e.target.y = (movingCardSprite.numChildren - 2) * CARDS_Y_SPACING
			}
			else // can be moved
			{
				
			}
		}
		
		private function isLastCardOfPile(card:Card):Boolean
		{
			return true;
		}
		
		private function addCardContainers():void
		{
			fillFoundationContainer();
			fillReserveContainer();
			fillTaubleContainer();
			
			function fillTaubleContainer():void
			{
				taublePilesContainer = new Sprite();
				taublePilesContainer.x = TAUBLE_CONTAINER_X
				taublePilesContainer.y = TAUBLE_CONTAINER_Y
				
				for (var cardCount:int = 0; cardCount < 10; cardCount++)
				{
					var containerX:int = CONTAINER_WIDTH * cardCount + cardCount * CONTAINER_WIDTH_SPACING;
					taublePilesContainer.addChild(addCardContainer(containerX, "tauble" + cardCount));
				}
				
				addChild(taublePilesContainer);
			}
			
			function fillReserveContainer():void
			{
				reservesContainer = new Sprite();
				reservesContainer.x = RESERVE_CONTAINER_X;
				reservesContainer.y = RESERVE_CONTAINER_Y;
				
				for (var cardCount:int = 0; cardCount < 8; cardCount++)
				{
					var containerX = CONTAINER_WIDTH * cardCount + cardCount * CONTAINER_WIDTH_SPACING;
					reservesContainer.addChild(addCardContainer(containerX, "reserve" + cardCount));
				}
				
				addChild(reservesContainer);
			}
			
			function fillFoundationContainer():void
			{
				foundationContainer = new Sprite();
				foundationContainer.x = FOUNDATION_CONTAINER_X;
				foundationContainer.y = FOUNDATION_CONTAINER_Y;
				
				for (var cardCount:int = 0; cardCount < 4; cardCount++)
				{
					var containerX:int = CONTAINER_WIDTH * cardCount + cardCount * CONTAINER_WIDTH_SPACING;
					foundationContainer.addChild(addCardContainer(containerX, "foundation" + cardCount));
				}
				
				addChild(foundationContainer);
			}
			
			function addCardContainer(x:int, name:String):Sprite
			{
				var container:Sprite = new Sprite();
				container.x = x;
				container.name = name;
				container.addChild(new PileBackground());
				
				return container;
			}
		}
		
		private function loadDeck():void
		{
			var cardUrl:String;
			var cardNumbers:int = 14;
			var cardColors:int = 4
			
			for (var i:int = 0; i < cardNumbers; i++)
			{
				if (i == 0)
				{ //pass back card
					continue;
				}
				
				for (var j:int = 0; j < cardColors; j++)
				{
					var cardColor:String;
					
					if (i == 0)
					{
						cardColor = "Back";
						cardUrl = i + cardColor;
						
						var card:Card = new Card(cardUrl, i);
						cards.push(card);
						
						break;
					}
					else
					{
						switch (j)
						{
						case 0: 
							cardColor = "C";
							break;
						case 1: 
							cardColor = "D";
							break;
						case 2: 
							cardColor = "H";
							break;
						case 3: 
							cardColor = "S";
							break;
						}
					}
					
					cardUrl = i + cardColor;
					
					var card:Card = new Card(cardUrl, i);
					card.addEventListener(MouseEvent.MOUSE_DOWN, startDraging);
					card.addEventListener(MouseEvent.MOUSE_UP, stopDraging);
					card.buttonMode = true;
					cards.push(card);
				}
			}
		}
		
		private function randomRange(minNum:Number, maxNum:Number):int
		{
			return (int(Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum));
		}
	}
}