package Games.Prison
{
	import flash.display.Sprite;
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
		private const CONTAINER_SPACING:int = 10;
		
		private var isGameRunning:Boolean = true;
		
		private var cards:Vector.<Card> = new Vector.<Card>();
		
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
		
			//loadDeck();
		}
		
		private function addCardContainers():void
		{
			addFoundationContainer();
			addReserveContainer();
			addTaubleContaier();
			
			function addTaubleContaier():void {
				taublePilesContainer = new Sprite();
				taublePilesContainer.x = TAUBLE_CONTAINER_X
				taublePilesContainer.y = TAUBLE_CONTAINER_Y
				
				for (var i:int = 0; i < 10; i++) 
				{
					var containerX = CardsContainer.ContainerWidth * i + i * 10;
					taublePilesContainer.addChild(addCardContainer(containerX));
				}
				
				addChild(taublePilesContainer);
			}
			
			function addReserveContainer():void {
				reservesContainer = new Sprite();
				reservesContainer.x = RESERVE_CONTAINER_X; 
				reservesContainer.y = RESERVE_CONTAINER_Y;
				
				for (var i:int = 0; i < 8; i++) 
				{
					var containerX = CardsContainer.ContainerWidth * i + i * 10;
					reservesContainer.addChild(addCardContainer(containerX));
				}
				
				addChild(reservesContainer);
			}
			
			function addFoundationContainer():void {
				foundationContainer = new Sprite();
				foundationContainer.x = FOUNDATION_CONTAINER_X; 
				foundationContainer.y = FOUNDATION_CONTAINER_Y;
				
				for (var i:int = 0; i < 4; i++) 
				{
					var containerX = CardsContainer.ContainerWidth * i + i * 10;
					foundationContainer.addChild(addCardContainer(containerX));
				}
				
				addChild(foundationContainer);
			}
			
			function addCardContainer(x:int):Sprite
			{
				var container:CardsContainer = new CardsContainer();
				container.x = x;
				
				return container
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