package Games.EightOff
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import SharedClasses.Card;
	import SharedClasses.GrandFatherEightOff.CardDropping;
	import SharedClasses.GrandFatherEightOff.Pile;
	
	/**
	 * ...
	 * @author Kolarov
	 */
	public class CardDroppingEightoff extends CardDropping
	{
		private var extraPiles:Array;
		
		private var tempPile:TempCardsPile;
		
		public function CardDroppingEightoff(extraPilesPar:Array, fieldPilesPar:Array, sidePilesPar:Array, tempPilePar:TempCardsPile, generalPar:Sprite)
		{
			this.extraPiles = extraPilesPar;
			this.tempPile = tempPilePar;
			super(generalPar, fieldPilesPar, sidePilesPar);
		}
		
		
		public function tryCardOnExtraPile(cardForMoving:Card):void
		{
			this.isDropped = false;
			
			for (var extraPileIndex:int = 0; extraPileIndex < extraPiles.length; extraPileIndex++)
			{
				var extraPile:ExtraPile = this.extraPiles[extraPileIndex];
				if (extraPile.hitTestPoint(this.general.mouseX, this.general.mouseY))
				{
					if (extraPile.isEmpty)
					{
						makeDropping(cardForMoving);
						extraPile.pushCard(cardForMoving);
					}
				}
			}
		
		}
		
		public function tryCardOnFieldPile(cardForMoving:Card):void
		{
			this.isDropped = false;
			for (var fieldPileIndex:int = 0; fieldPileIndex < fieldPiles.length; fieldPileIndex++)
			{
				var fieldPile:FieldPile = this.fieldPiles[fieldPileIndex];
				if (fieldPile.hitTestPoint(this.general.mouseX, this.general.mouseY))
				{
					if (fieldPile.CardsCount != 0 && fieldPile.TopCard.CardValue - 1 == this.tempPile.FirstCard.CardValue && fieldPile.TopCard.CardSign == this.tempPile.FirstCard.CardSign || fieldPile.CardsCount == 0 && tempPile.FirstCard.CardValue == 13)
					{
						makeDropping(cardForMoving);
						fieldPile.pushCard(cardForMoving);
					}
				}
			}
		}
		
		public function tryCardOnSidePile(cardForMoving:Card):void
		{
			this.isDropped = false;
			for (var sidePileIndex:int = 0; sidePileIndex < sidePiles.length; sidePileIndex++)
			{
				var sidePile:SidePile = this.sidePiles[sidePileIndex];
				if (sidePile.hitTestPoint(this.general.mouseX, this.general.mouseY))
				{
					if ((sidePile.CardsCount == 0 && this.tempPile.FirstCard.CardValue == 1 && sidePile.Suit == this.tempPile.FirstCard.CardSign) || (sidePile.CardsCount != 0 && sidePile.TopCard.CardValue == this.tempPile.FirstCard.CardValue - 1 && sidePile.Suit == tempPile.FirstCard.CardSign))
					{
						makeDropping(cardForMoving);
						sidePile.pushCard(cardForMoving);
					}
				}
			}
		}
		
		public function tryCardsOnFieldPile(cardsForMoving:Array):void
		{
			this.isDropped = false;
			for (var fieldPileIndex:int = 0; fieldPileIndex < this.fieldPiles.length; fieldPileIndex++)
			{
				var fieldPile:FieldPile = this.fieldPiles[fieldPileIndex];
				if (fieldPile.hitTestPoint(this.general.mouseX, this.general.mouseY))
				{
					if (((fieldPile.CardsCount > 0) && (fieldPile.TopCard.CardValue == this.tempPile.FirstCard.CardValue + 1) && (fieldPile.TopCard.CardSign == this.tempPile.FirstCard.CardSign)) || (fieldPile.CardsCount == 0 && this.tempPile.FirstCard.CardValue == 13))
					{
						cardsForMoving = this.tempPile.giveCards();
						fieldPile.pushCards(cardsForMoving);
						this.isDropped = true;
						this.tempPile.stopDrag();
					}
				}
			}
		}
		
		private function makeDropping(cardForMoving:Card):void {
			cardForMoving = this.tempPile.giveCard();
			this.isDropped = true;
			this.tempPile.stopDrag();
		}
	}

}