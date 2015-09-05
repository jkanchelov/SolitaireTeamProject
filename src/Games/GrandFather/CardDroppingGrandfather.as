package Games.GrandFather 
{
	import flash.display.Sprite;
	import SharedClasses.Card;
	import SharedClasses.GrandFatherEightOff.CardDropping;
	/**
	 * ...
	 * @author Kolarov
	 */
	public class CardDroppingGrandfather extends CardDropping
	{	
		public function CardDroppingGrandfather(generalPar:Sprite,fieldPilesPar:Array,sidePilesPar:Array,isDroppedPar:Boolean) 
		{
			super(generalPar, fieldPilesPar, sidePilesPar);
		}
		
		//TRY DO DROP CARD ON FIELD PILE
		public function tryCardOnFieldPile(takenCard:Card):void
		{
			this.isDropped = false;
			for (var fieldPileIndex:int = 0; fieldPileIndex < this.fieldPiles.length; fieldPileIndex++)
			{
				var currentFieldPile:FieldPile = fieldPiles[fieldPileIndex];
				//if (this.takenCard.hitTestObject(currentFieldPile)) {// this.takenCard goes to first field pile that hit
				if (currentFieldPile.hitTestPoint(this.general.mouseX, this.general.mouseY))
				{
					if (currentFieldPile.CardsCount >= 0 && currentFieldPile.CardsCount < 2)
					{
						this.isDropped = true;
						this.general.removeChild(takenCard);
						currentFieldPile.pushCard(takenCard);
						break;
					}
				}
			}
		}
		
		//TRY TO DROP CARD ON SIDE PILE
		public function tryCardOnSidePile(takenCard:Card):void
		{
			this.isDropped = false;
			for (var sidePileIndex:int = 0; sidePileIndex < this.sidePiles.length; sidePileIndex++)
			{
				var currentSidePile:SidePile = sidePiles[sidePileIndex];
				if (currentSidePile.hitTestPoint(this.general.mouseX, this.general.mouseY) &&  takenCard.CardSign == currentSidePile.Sign)
				{
					// if no cards in side pile
					if (currentSidePile.TopCard == null)
					{
						if (takenCard.CardValue == 1 && currentSidePile.StartValue == 1)
						{
							makeDroppingOnSidePile(currentSidePile,takenCard);
							break;
						}
						if (takenCard.CardValue == 13 && currentSidePile.StartValue == 13)
						{
							makeDroppingOnSidePile(currentSidePile,takenCard);
							break;
						}
					}
					// if there are cards in side pile
					if (currentSidePile.TopCard != null)
					{
						if (currentSidePile.StartValue == 1 &&  takenCard.CardValue == (currentSidePile.TopCard.CardValue + 1))
						{
							makeDroppingOnSidePile(currentSidePile,takenCard);
							break;
						}
						if (currentSidePile.StartValue == 13 && takenCard.CardValue == (currentSidePile.TopCard.CardValue - 1))
						{
							makeDroppingOnSidePile(currentSidePile,takenCard);
							break;
						}
					}
				}
			}
		}
		
		private function makeDroppingOnSidePile(currentSidePile:SidePile,takenCard:Card):void {
			this.isDropped = true;
			this.general.removeChild(takenCard);
			currentSidePile.pushCard(takenCard);
		}
	}

}