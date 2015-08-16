package Games.Prison
{
	import flash.events.*;
	import flash.display.*;
	import flash.geom.*;
	import flash.net.URLRequest;
	import SharedClasses.*
	
	/**
	 * ...
	 * @author Jordan
	 */
	public class PrisonSolitaire extends Sprite
	{
		private const FOUNDATION_CONTAINER_X:int = 250;
		private const FOUNDATION_CONTAINER_Y:int = 70;
		private const RESERVE_CONTAINER_X:int = 100;
		private const RESERVE_CONTAINER_Y:int = 195;
		private const TAUBLE_CONTAINER_X:int = 25;
		private const TAUBLE_CONTAINER_Y:int = 320;
		private const CONTAINER_WIDTH:int = 65;
		private const CONTAINER_HEIGHT:int = 100;
		private const CONTAINER_WIDTH_SPACING:int = 10;
		
		private var cards:Vector.<Card> = new Vector.<Card>();
		private var isGameRunning:Boolean = true;
		private var counterPlacedCards:int = 0;
		
		private var foundationContainer:Sprite;
		private var reservesContainer:Sprite;
		private var taublePilesContainer:Sprite;
		
		public function PrisonSolitaire()
		{
			DealSolitaire();
		}
		
		public function get IsGameRunning():Boolean
		{
			return this.isGameRunning;
		}
		
		private function DealSolitaire():void
		{
			addCardContainers();
			
			loadDeck();
			loadCardsFoundation();
			loadReservedCards();
		
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
							cards.splice(card - counterAddedCards, 1);
							counterAddedCards++;
						}
					}
					counter++;
				}
			}
		}
		
		private function loadReservedCards():void
		{
		
		}
		
		private function drawRandomCard(drawAt:Sprite):void
		{
			var rndCardNumber:int = randomRange(0, 52 - counterPlacedCards);
			drawAt.addChild(cards[rndCardNumber]);
			cards.splice(rndCardNumber, 1);
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
		
		private function addCard():void
		{
		
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