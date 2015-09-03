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
		protected function dealRandomCard(dealAt:Sprite,cards:Vector.<Card>,counterPlacedCards:int,y:int = 0):void
		{
			var rndCardNumber:int = randomRange(0, 103 - counterPlacedCards);
			dealAt.addChild(cards[rndCardNumber]).y = y;
			cards.splice(rndCardNumber, 1);
		}
		
		
		protected function dealSolitaire():void
		{
				throw new Error("AbstractExample must not be directly instantiated");
		}
		
		protected function addCardContainers():void
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
		
		
		private function randomRange(minNum:Number, maxNum:Number):int
		{
			return (int(Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum));
		}
	}
}