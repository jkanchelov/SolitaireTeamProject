package Games.GrandFather
{
	import flash.display.Sprite;
	import SharedClasses.Assistant;
	import SharedClasses.Card;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.*;
	import flash.net.*;
	import SharedClasses.Deck;
	
	/**
	 * ...
	 * @author
	 */
	public class DeckGrandfather extends Deck
	{
		private var cardsCount:int;
		private var reloadTimesLeft:int = 1;
		
		public function DeckGrandfather(cardSkinPar:String)
		{
			super(cardSkinPar);
			loadDeck();
			loadDeck();
		}
		
		public function ReloadDeck(deckPileCards:Array):void
		{
			var deckPileTopCard:Card;
			while (deckPileCards.length > 0)
			{
				deckPileTopCard = deckPileCards.pop();
				deck.push(deckPileTopCard);
			}
			this.reloadTimesLeft--;
		}
		
		public function get CardsCount():int
		{
			return this.deck.length;
		}
		
		public function get ReloadedTimesLeft():int
		{
			return this.reloadTimesLeft;
		}
	}

}