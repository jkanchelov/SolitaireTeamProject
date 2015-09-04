package Games.EightOff 
{
	/**
	 * ...
	 * @author Kolarov
	 */
	import SharedClasses.Card
	import SharedClasses.Deck;
	
	public class DeckEightoff extends Deck
	{	
		public function DeckEightoff(cardSkinPar:String)
		{
			super(cardSkinPar);
			loadDeck();
		}
		
	}
}