package SharedClasses.PrisonAlternation
{
	import com.greensock.motionPaths.RectanglePath2D;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import SharedClasses.Card;
	
	/**
	 * ...
	 * @author Jordan
	 */
	public class AbstractSolitaire extends Sprite
	{
		protected function dealRandomCard(dealAt:Sprite, cards:Vector.<Card>, counterPlacedCards:int, y:int = 0, cardsNumber = 51):void
		{
			var rndCardNumber:int = randomRange(0, cardsNumber - counterPlacedCards);
			dealAt.addChild(cards[rndCardNumber]).y = y;
			cards.splice(rndCardNumber, 1);
		}
		
		protected function fillDeck(cardsDeck:Vector.<Card>, cardsSkin:String):Vector.<Card>
		{
			
			var resultDeck:Vector.<Card> = cardsDeck;
			
			var cardUrl:String;
			var cardNumbers:int = 14;
			var cardColors:int = 4
			
			for (var cardValue:int = 1; cardValue < cardNumbers; cardValue++)
			{
				for (var cardSign:int = 0; cardSign < cardColors; cardSign++)
				{
					var cardColor:String;
					switch (cardSign)
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
					
					cardUrl = cardValue + cardColor;
					
					var card:Card = new Card(cardUrl, cardValue, cardsSkin);
					card.addEventListener(MouseEvent.MOUSE_DOWN, startDraging, false, 0, true);
					card.addEventListener(MouseEvent.MOUSE_UP, stopDraging, false, 0, true);
					card.buttonMode = true;
					resultDeck.push(card);
				}
			}
			
			return resultDeck;
		}
		
		protected function isLastCardOfPile(givenCard:Card, spriteContainer:Sprite = null):Boolean
		{
			throw new Error("AbstractExample must not be directly instantiated");
		}
		
		protected function startGame(e:MouseEvent):void
		{
			throw new Error("AbstractExample must not be directly instantiated");
		}
		
		protected function showMenu():void
		{
			throw new Error("AbstractExample must not be directly instantiated");
		}
		
		protected function showSurrenderAndTimer():void
		{
			throw new Error("AbstractExample must not be directly instantiated");
		}
		
		protected function dealSolitaire():void
		{
			throw new Error("AbstractExample must not be directly instantiated");
		}
		
		protected function addCardContainers():void
		{
			throw new Error("AbstractExample must not be directly instantiated");
		}
		
		protected function loadDeck():void
		{
			throw new Error("AbstractExample must not be directly instantiated");
		}
		
		protected function loadTaublePilesCards():void
		{
			throw new Error("AbstractExample must not be directly instantiated");
		}
		
		protected function startDraging(e:MouseEvent):void
		{
			throw new Error("AbstractExample must not be directly instantiated");
		}
		
		protected function stopDraging(e:MouseEvent):void
		{
			throw new Error("AbstractExample must not be directly instantiated");
		}
		
		protected function resetMovCardVariables():void
		{
			throw new Error("AbstractExample must not be directly instantiated");
		}
		
		protected function canBeMoved(givenCard:Card):Boolean
		{
			throw new Error("AbstractExample must not be directly instantiated");
		}
		
		protected function checkWin():void
		{
			throw new Error("AbstractExample must not be directly instantiated");
		}
		
		protected function surrender(e:MouseEvent):void
		{
			throw new Error("AbstractExample must not be directly instantiated");
		}
		
		protected function gameOver():void
		{
			throw new Error("AbstractExample must not be directly instantiated");
		}
		
		protected function randomRange(minNum:Number, maxNum:Number):int
		{
			return (int(Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum));
		}
	}
}