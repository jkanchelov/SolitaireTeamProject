package Games.GrandFather
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import SharedClasses.Card;
	import SharedClasses.GrandFatherEightOff.Deck;
	import SharedClasses.GrandFatherEightOff.Pile;
	
	/**
	 * ...
	 * @author DENISLAV
	 */
	public class DeckPile extends Pile
	{
		private var cardsInDeckPile:Array = [];
		private var topCard:Card;
		
		public function DeckPile()
		{
			super();
		}
		
		//PUSH CARD IN DECK PILE:PUSH CARD IN ARRAY AND ADD IT IN DISPLAY LIST
		public function pushCard(card:Card):void
		{
			this.cardsInDeckPile.push(card);
			this.addChild(card);
			card.x = 0;
			card.y = 0;
			this.topCard = card;
		}
		
		//RETURNS TOP CARD OF DECK PILE. THE CARD IS POPED FROM ARRAY AND REMOVED FROM DISPLAY LIST
		public function giveTopCard():Card
		{
			var currentTopCard:Card = this.topCard;
			this.removeChild(this.topCard);
			this.cardsInDeckPile.pop();
			if (this.cardsInDeckPile.length != 0)
			{
				this.topCard = this.cardsInDeckPile[cardsInDeckPile.length - 1];
			}
			if (this.cardsInDeckPile.length == 0)
			{
				this.topCard = null;
			}
			return currentTopCard;
		}
		
		//RETURNS CARDS THAT DECK PILE CONTAINS
		public function get Cards():Array
		{
			this.topCard = null;
			return this.cardsInDeckPile;
		}
		
		//RETURNS TOP CARD OF DECK PILE
		public function get TopCard():Card
		{
			return this.topCard;
		}
	}

}