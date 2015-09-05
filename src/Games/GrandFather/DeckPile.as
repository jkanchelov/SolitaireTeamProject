package Games.GrandFather
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import SharedClasses.Card;
	import SharedClasses.GrandFatherEightOff.Deck;
	import SharedClasses.GrandFatherEightOff.Pile;
	
	/**
	 * ...
	 * @author Denislav
	 */
	public class DeckPile extends Pile
	{
		private var cardsInDeckPile:Array = [];
		private var topCard:Card;
		
		public function DeckPile()
		{
			super();
		}
		
		public function pushCard(card:Card):void
		{
			this.cardsInDeckPile.push(card);
			this.addChild(card);
			card.x = 0;
			card.y = 0;
			this.topCard = card;
		}
		
		public function giveTopCard():Card
		{
			var currentTopCard:Card = this.topCard;
			this.removeChild(this.topCard);
			this.cardsInDeckPile.pop();
			if (this.cardsInDeckPile.length != 0)
			{
				this.topCard = this.cardsInDeckPile[cardsInDeckPile.length - 1];
			}
			else //if (this.cardsInDeckPile.length == 0)
			{
				this.topCard = null;
			}
			return currentTopCard;
		}
		
		public function get Cards():Array
		{
			this.topCard = null;
			return this.cardsInDeckPile;
		}
		
		public function get TopCard():Card
		{
			return this.topCard;
		}
	}

}