package Games.GrandFather
{
	/**
	 * ...
	 * @author Kolarov
	 */
	import flash.display.Sprite;
	import flash.events.*;
	import SharedClasses.Assistant;
	import SharedClasses.Card;
	import com.greensock.*; 
	import com.greensock.easing.*;
	import flash.utils.*;
	
	public class Engine
	{
		private var deck:DeckGrandfather;
		private var deckPile:DeckPile;
		private var fieldPiles:Array;
		private var sidePiles:Array;
		private var generalContainer:Grandfather;
		
		private var takenCard:Card;
		private var pressedFieldPile:FieldPile;
		private var pressedDeckPile:DeckPile;
		
		private var isThereEmpties:Boolean;//is field var for use object as reference
		
		private var cardDropping:CardDroppingGrandfather;
		
		public function Engine(deckPar:DeckGrandfather, deckPilePar:DeckPile, fieldPilesPar:Array, sidePilesPar:Array, generalContainerPar:Grandfather)
		{
			initFields(deckPar, deckPilePar, fieldPilesPar, sidePilesPar, generalContainerPar);
			dealing();
			autoFillEmptiesOnDealing();
			makeInteraction();
		}
		
		// DRAG CARD FROM DECK PILE //KOLAROV
		private function dragTopCardFromDeckPile(e:MouseEvent):void
		{
			this.pressedDeckPile = e.currentTarget as DeckPile;
			if(this.pressedDeckPile.TopCard!=null){
				this.takenCard = this.pressedDeckPile.giveTopCard();
				this.generalContainer.addChild(this.takenCard as Card);
				this.takenCard.x = this.pressedDeckPile.x;
				this.takenCard.y = this.pressedDeckPile.y;
				this.takenCard.startDrag();
				Assistant.addEventListenerTo(takenCard, MouseEvent.MOUSE_UP, dropTakenCardFromDeckPile);
			}
		}
		
		// DROP TAKEN CARD FROM DECK PILE //KOLAROV
		private function dropTakenCardFromDeckPile(e:MouseEvent):void
		{
			this.takenCard.stopDrag();
			
			this.cardDropping.tryCardOnSidePile(this.takenCard);
			
			if (!cardDropping.IsDropped) {
				this.cardDropping.tryCardOnFieldPile(this.takenCard);
			}
			
			if (!cardDropping.IsDropped)
			{
				returnTakenCardToDeckPile();
			}
			
			Assistant.removeEventListenerTo(takenCard, MouseEvent.MOUSE_UP, dropTakenCardFromDeckPile);
			this.takenCard = null;
		}
		
		// PUT CARD ON DECK PILE WHILE DECK IS PRESSED //KOLAROV
		private function putCardOnDeckPile(e:MouseEvent):void
		{
			if(deck.CardsCount!=0){
				var deckTopCard:Card = deck.giveTopCard();
				this.generalContainer.addChild(deckTopCard);
				deckTopCard.x = this.deck.x;
				deckTopCard.y = this.deck.y;
				
				if (deckTopCard != null)
				{
					motionToDeckPile(deckTopCard);
					//autoFillEmptyFieldPiles();
				}
			}
			if (deck.CardsCount == 0)
			{
				if (deck.ReloadedTimesLeft == 0)
				{
					Assistant.removeEventListenerTo(this.deck, MouseEvent.CLICK, putCardOnDeckPile);
					this.generalContainer.removeChild(this.deck);
				}
				if (deck.ReloadedTimesLeft == 1)
				{
					this.deck.ReloadDeck(this.deckPile.Cards);
				}
			}
		}
		
		// MOTION  CARD TO DECK PILE //KOLAROV
		private function motionToDeckPile(deckTopCard:Card):void {
			TweenMax.to(deckTopCard, 0.5, { x:this.deckPile.x, y:this.deckPile.y, onComplete:function():void{performPushingCardInDeckPile(deckTopCard)}} ) ;
		}
		
		// PERFORMING PUSHING CARD IN DECK PILE //KOLAROV
		private function performPushingCardInDeckPile(deckTopCard:Card):void {
			deckTopCard.parent.removeChild(deckTopCard);
			this.deckPile.pushCard(deckTopCard);
		}
		
		// DRAG CARD FROM FIELD PILES //KOLAROV
		private function dragTopCardFromFieldPile(e:MouseEvent):void
		{
			this.pressedFieldPile = e.currentTarget as FieldPile;
			if(this.pressedFieldPile.TopCard!=null){
				this.takenCard = pressedFieldPile.giveTopCard();
				this.generalContainer.addChild(this.takenCard as Card);
				this.takenCard.x = this.pressedFieldPile.x;
				this.takenCard.y = this.pressedFieldPile.y;
				this.takenCard.startDrag();
				Assistant.addEventListenerTo(takenCard, MouseEvent.MOUSE_UP, dropTakenCardFromFieldPile);
			}
		}
		
		//DROP CARD TAKEN CARD FROM FIELD PILES //KOLAROV
		private function dropTakenCardFromFieldPile(e:MouseEvent):void
		{
			takenCard.stopDrag();
			
			this.cardDropping.tryCardOnSidePile(this.takenCard);
			
			Assistant.removeEventListenerTo(this.takenCard, MouseEvent.MOUSE_UP, dropTakenCardFromFieldPile);
			
			if (!cardDropping.IsDropped)
			{
				returnTakenCardToFieldPile();
			}else
			{
				//autoFillEmptyFieldPiles();
			}
			
			if (Assistant.isThereWin(this.sidePiles))
			{
				this.generalContainer.IsGameRunning = false;
				this.generalContainer.IsWin = true;
			}
			
			this.takenCard = null;
		}
		
		// MAKE INTERACTION //KOLAROV
		private function makeInteraction():void
		{
			makeDeckInteractive();
			makeDeckPileInteractive();
			makeInteractiveFieldPiles();
		}
		
		//// ON DECK PILE 
		private function makeDeckPileInteractive():void
		{
			Assistant.addEventListenerTo(this.deckPile, MouseEvent.MOUSE_DOWN, dragTopCardFromDeckPile);
		}
		
		//// ON DECK 
		private function makeDeckInteractive():void
		{
			Assistant.addEventListenerTo(this.deck, MouseEvent.CLICK, putCardOnDeckPile);
		}
		
		//// ON FIELD PILES 
		private function makeInteractiveFieldPiles():void
		{
			for (var fieldPileIndex:int = 0; fieldPileIndex < fieldPiles.length; fieldPileIndex++)
			{
				var currentFieldPile:FieldPile = fieldPiles[fieldPileIndex];
				if (currentFieldPile.TopCard != null)
				{
					Assistant.addEventListenerTo(currentFieldPile, MouseEvent.MOUSE_DOWN, dragTopCardFromFieldPile);
				}
			}
		}
		
		// MAKE DEALING //KOLAROV
		private function dealing():void
		{
			Assistant.dealing(this.deck, this.fieldPiles);
		}
		
		// AUTO FILL EMPTIES //DENISLAV
		//// FILL EMPTIES AFTER DEALING
		private function autoFillEmptiesOnDealing():void
		{
			while (isThereEmpties)
			{
				this.isThereEmpties = false;
				autoFillSidePilesCorrectOnDealing();
				autoFillEmptyFieldPilesOnDealing();
			}
		}
		
		////// FILL EMPTIES ON FIELD PILES AFTER DEALING
		private function autoFillEmptyFieldPilesOnDealing():void
		{
			for (var fieldPileIndex:int = 0; fieldPileIndex < fieldPiles.length; fieldPileIndex++)
			{
				var currentFieldPile:FieldPile = fieldPiles[fieldPileIndex];
				if (currentFieldPile.TopCard == null)
				{
					this.takenCard = deck.giveTopCard();
					currentFieldPile.pushCard(this.takenCard);
					this.isThereEmpties = true;
					break;
				}
			}
		}
		
		////// FILL EMPTIES ON SIDE PILES AFTER DEALING
		private function autoFillSidePilesCorrectOnDealing():void
		{
			for (var fieldPileIndex:int = 0; fieldPileIndex < fieldPiles.length; fieldPileIndex++)
			{
				var currentFieldPile:FieldPile = fieldPiles[fieldPileIndex];
				if (currentFieldPile.TopCard.CardValue == 1 || currentFieldPile.TopCard.CardValue == 13)
				{
					this.takenCard = currentFieldPile.giveTopCard();
					for (var sidePileIndex:int = 0; sidePileIndex < sidePiles.length; sidePileIndex++)
					{
						var currentSidePile:SidePile = sidePiles[sidePileIndex];
						if (currentSidePile.Sign == this.takenCard.CardSign && currentSidePile.StartValue == this.takenCard.CardValue)
						{
							//todo: motion from field pile to currentSidePile
							currentSidePile.pushCard(this.takenCard);
							this.isThereEmpties = true;
							break;
						}
					}
				}
			}
		}
		
		//// FILL EMPTIES ON FIELD PILES DURING THE GAME
		private function autoFillEmptyFieldPiles():void
		{
			for (var fieldPileIndex:int = 0; fieldPileIndex < fieldPiles.length; fieldPileIndex++)
			{
				var currentFieldPile:FieldPile = fieldPiles[fieldPileIndex];
				if (currentFieldPile.TopCard == null)
				{
					if (this.deckPile.TopCard == null&&this.deck.CardsCount != 0)
					{
						this.takenCard = deck.giveTopCard();
					}
					else if(this.deckPile.TopCard!=null)
					{
						this.takenCard = deckPile.giveTopCard();
					}
					currentFieldPile.pushCard(this.takenCard);
					break;
				}
			}
		}
		
		// CARD RETURNING IF CANT BE DROPPED //KOLAROV
		//// RETURN TO FIELD PILES
		private function returnTakenCardToFieldPile():void
		{
			if (this.takenCard != null)
			{
				this.takenCard.parent.removeChild(this.takenCard);
				this.pressedFieldPile.pushCard(this.takenCard);
			}
		}
			
		//// RETURN TO DECK PILE //KOLAROV
		private function returnTakenCardToDeckPile():void
		{
			if (this.takenCard != null)
			{
				this.takenCard.parent.removeChild(this.takenCard);
				this.deckPile.pushCard(this.takenCard);
			}
		}
		
		// INIT FIELDS 
		private function initFields(deckPar:DeckGrandfather, deckPilePar:DeckPile, fieldPilesPar:Array, sidePilesPar:Array, generalContainerPar:Grandfather):void
		{
			this.deck = deckPar;
			this.deckPile = deckPilePar;
			this.fieldPiles = fieldPilesPar;
			this.sidePiles = sidePilesPar;
			this.generalContainer = generalContainerPar;
			this.isThereEmpties = true;
			this.cardDropping = new CardDroppingGrandfather(this.generalContainer, this.fieldPiles, this.sidePiles);
		}
	}

}