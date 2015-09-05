package Games.GrandFather
{
	import SharedClasses.Card;
	import SharedClasses.GrandFatherEightOff.Pile;
	
	/**
	 * ...
	 * @author Mitko
	 */
	public class FieldPile extends Pile
	{
		private var cardsInFieldPile:Array = [];
		private var topCard:Card;
		
		
		public function FieldPile(fieldPileIndexPar:int)
		{
			super();
		}
		
		public function pushCard(card:Card):void
		{
			this.topCard = card;
			this.addChild(card);
			
			if (this.cardsInFieldPile.length == 0)
			{
				card.x = 0;
				card.y = 0;
			}
			
			else if (this.cardsInFieldPile.length == 1)
			{
				card.x = 10;
				card.y = 0;
			}
			this.cardsInFieldPile.push(card);
		}
		
		public function giveTopCard():Card
		{
			var currentTopCard:Card = this.topCard;
			this.removeChild(this.topCard);
			this.cardsInFieldPile.pop();
			if (this.cardsInFieldPile.length == 1)
			{
				var lastIndex:int = cardsInFieldPile.length - 1;
				this.topCard = this.cardsInFieldPile[lastIndex];
			}
			if (this.cardsInFieldPile.length == 0)
			{
				this.topCard = null;
			}
			return currentTopCard;
		}
		
		public function get TopCard():Card
		{ 				
			
			return this.topCard;
		}
		
		public function get CardsCount():int
		{ 		
			var cardsInThisFieldPile:int = this.cardsInFieldPile.length;
			return cardsInThisFieldPile;
		}
	
	}

}