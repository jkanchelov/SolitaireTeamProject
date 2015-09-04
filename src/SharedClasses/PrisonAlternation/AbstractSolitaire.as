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