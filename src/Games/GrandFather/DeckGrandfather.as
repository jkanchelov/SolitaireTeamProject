package Games.GrandFather
{
	import flash.display.Sprite;
	import SharedClasses.Assistant;
	import SharedClasses.Card;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.*;
	import flash.net.*;
	import SharedClasses.GrandFatherEightOff.Deck;
	
	/**
	 * ...
	 * @author Denislav
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

		//ONLY 1 TIME ACCEPT CARDS FROM DECK PILE TO REALOAD DECK AGAIN
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
	
		//RETURNS COUNT OF CARDS THAT DECK CONTAINS 
		public function get CardsCount():int
		{
			return this.deck.length;
		}
		
		//RETURNS THE NUMBER OF LEFT LOADED TIMES
		public function get ReloadedTimesLeft():int
		{
			return this.reloadTimesLeft;
		}
	}

}