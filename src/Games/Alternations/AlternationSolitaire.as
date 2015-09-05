package Games.Alternations
{
	import flash.events.*;
	import flash.display.*;
	import flash.geom.*;
	import flash.net.URLRequest;
	import Interfaces.IGame;
	import SharedClasses.*
	import SharedClasses.PrisonAlternation.*
	
	/**
	 * ...
	 * @author Jordan
	 */
	public class AlternationSolitaire extends AbstractSolitaire implements IGame
	{
		private const STAGE_WIDTH:int = 800;
		private const STAGE_HEIGHT:int = 600;
		
		private const DECK_CONTAINER_X:int = 25;
		private const DECK_CONTAINER_Y:int = 50;
		private const FOUNDATION_CONTAINER_X:int = 175;
		private const FOUNDATION_CONTAINER_Y:int = 50;
		private const TAUBLE_CONTAINER_X:int = 250;
		private const TAUBLE_CONTAINER_Y:int = 175;
		
		private const CONTAINER_WIDTH:int = 65;
		private const CONTAINER_HEIGHT:int = 100;
		private const CONTAINER_WIDTH_SPACING:int = 10;
		private const CARDS_Y_SPACING:int = 22;
		private const CARDS_NUMBERS:int = 103;
		
		private var cardsSkin:String;
		private var score:int = 0;
		
		private var cards:Vector.<Card> = new Vector.<Card>();
		private var isWin:Boolean = false;
		private var isGameRunning:Boolean = true;
		private var counterPlacedCards:int = 0;
		
		private var moveMultiple:Boolean = false;
		private var multipleStartIndex:int;
		
		private var movCardCurrentSprite:Sprite;
		private var movCardNewSprite:Sprite;
		private var movingCardObject:Sprite;
		private var movCardToFoundation:Boolean = false;
		private var movingCardX:int;
		private var movingCardY:int;
		private var followingCards:Vector.<Card> = new Vector.<Card>();
		private var isDragging:Boolean = false;
		
		private var menuContainer:Sprite;
		private var buttonsContainer:Sprite;
		private var deckContainer:Sprite;
		private var foundationContainer:Sprite;
		private var taublePilesContainer:Sprite;
		
		public function AlternationSolitaire(cardsSkin:String = "skin1/")
		{
			this.cardsSkin = cardsSkin;
			
			showMenu();
		}
		
		//made by Jordan
		public function get IsGameRunning():Boolean
		{
			return this.isGameRunning;
		}
		
		//made by Jordan
		public function get IsWin():Boolean
		{
			return this.isWin;
		}
		
		//made by Kaloqn
		protected override function showMenu():void
		{
			menuContainer = new Sprite();
			var helpMenuText:String = "All top cards of tableau piles are available to play." + "You can move cards from one tableau pile to another one." + "You may build tableau piles down regardless of suit." + "You can move either a single card or a set of cards." + "When one of the piles becomes empty you can fill the space with any available single card or set of cards." + "If, during play, any of closed becomes the top card of a pile, it is automatically turned over."
			
			var helpMenu:HelpMenu = new HelpMenu(helpMenuText);
			menuContainer.addChild(helpMenu);
			
			var startButton:MenuButton = new MenuButton("start.png");
			startButton.addEventListener(MouseEvent.CLICK, startGame, false, 0, true);
			startButton.x = 150;
			startButton.y = helpMenu.height + 20;
			startButton.buttonMode = true;
			menuContainer.addChild(startButton);
			
			menuContainer.x = STAGE_WIDTH / 2 - menuContainer.width / 2;
			addChild(menuContainer);
		}
		
		//made by Kaloqn
		protected override function startGame(e:MouseEvent):void
		{
			removeChild(menuContainer);
			menuContainer = null;
			
			showSurrenderAndTimer();
			
			dealSolitaire();
		}
		
		//made by Kaloqn
		protected override function showSurrenderAndTimer():void
		{
			buttonsContainer = new Sprite();
			
			var buttonWidth:int = 100;
			
			var surrenderButton:Button = new Button(buttonWidth, "  Surrender", true);
			surrenderButton.x = -125
			surrenderButton.addEventListener(MouseEvent.CLICK, surrender, false, 0, true);
			
			var time:TimerCounter = new TimerCounter(0xffffff);
			time.y = 10;
			
			buttonsContainer.x = STAGE_WIDTH - buttonWidth;
			buttonsContainer.addChild(time);
			buttonsContainer.addChild(surrenderButton);
			
			addChild(buttonsContainer);
		}
		
		//made by Kaloqn
		protected override function dealSolitaire():void
		{
			//adding two decks
			cards = fillDeck(cards, cardsSkin);
			cards = fillDeck(cards, cardsSkin);
			
			addCardContainers();	
			loadCardDeckContainer();
			loadTaublePilesCards();
		}
		
		//made by Kaloqn
		protected override function addCardContainers():void
		{
			fillDeckContainer();
			fillFoundationContainer();
			fillTaubleContainer();
			
			function fillDeckContainer():void
			{
				deckContainer = new Sprite();
				deckContainer.x = DECK_CONTAINER_X
				deckContainer.y = DECK_CONTAINER_Y
				
				for (var pileCount:int = 0; pileCount < 2; pileCount++)
				{
					if (pileCount == 1) // dont place backgroundPile
					{
						var containerX:int = CONTAINER_WIDTH * pileCount + pileCount * CONTAINER_WIDTH_SPACING;
						deckContainer.addChild(addCardContainer(containerX, "deck" + pileCount, true));
						continue;
					}
					var containerX:int = CONTAINER_WIDTH * pileCount + pileCount * CONTAINER_WIDTH_SPACING;
					deckContainer.addChild(addCardContainer(containerX, "deck" + pileCount));
					
				}
				
				addChild(deckContainer);
			}
			
			function fillTaubleContainer():void
			{
				taublePilesContainer = new Sprite();
				taublePilesContainer.x = TAUBLE_CONTAINER_X
				taublePilesContainer.y = TAUBLE_CONTAINER_Y
				
				for (var pileCount:int = 0; pileCount < 7; pileCount++)
				{
					var containerX:int = CONTAINER_WIDTH * pileCount + pileCount * CONTAINER_WIDTH_SPACING;
					taublePilesContainer.addChild(addCardContainer(containerX, "tauble" + pileCount));
				}
				
				addChild(taublePilesContainer);
			}
			
			function fillFoundationContainer():void
			{
				foundationContainer = new Sprite();
				foundationContainer.x = FOUNDATION_CONTAINER_X;
				foundationContainer.y = FOUNDATION_CONTAINER_Y;
				
				for (var pileCount:int = 0; pileCount < 8; pileCount++)
				{
					var containerX:int = CONTAINER_WIDTH * pileCount + pileCount * CONTAINER_WIDTH_SPACING;
					foundationContainer.addChild(addCardContainer(containerX, "foundation" + pileCount));
				}
				
				addChild(foundationContainer);
			}
			
			function addCardContainer(x:int, name:String, noBackground:Boolean = false):Sprite
			{
				var container:Sprite = new Sprite();
				container.x = x;
				container.name = name;
				if (noBackground != true)
				{
					container.addChild(new PileBackground());
				}
				
				return container;
			}
		}
		
		//made by Kaloqn
		protected override function loadTaublePilesCards():void
		{
			var taublePiles:int = 7;
			var taubleCards:int = 7;
			
			for (var pile:int = 0; pile < taublePiles; pile++)
			{
				for (var card:int = 0; card < taubleCards; card++)
				{
					var pileContainer:Sprite = taublePilesContainer.getChildAt(pile) as Sprite;
					var cardY = (pileContainer.numChildren - 1) * CARDS_Y_SPACING;
					if (card % 2 == 0)
					{
						
						dealRandomCard(pileContainer, cards, counterPlacedCards, cardY,CARDS_NUMBERS);
						counterPlacedCards++
					}
					else
					{
						dealBackCard(pileContainer);
					}
					
				}
			}
			
			function dealBackCard(dealAt:Sprite):void
			{
				var cardColor:String = "Back";
				var cardUrl:String = 0 + cardColor;
				
				var card:Card = new Card(cardUrl, 0, cardsSkin);
				card.name = "back";
				card.y = (dealAt.numChildren - 1) * CARDS_Y_SPACING
				
				dealAt.addChild(card);
			}
		}
		
		//made by Kaloqn
		private function loadCardDeckContainer():void
		{
			var deck:Sprite = deckContainer.getChildAt(0) as Sprite;
			deck.buttonMode = true;
			
			var cardColor:String = "Back";
			var cardUrl:String = 0 + cardColor;
			
			for (var i:int = 0; i < 55; i++)
			{
				var card:Card = new Card(cardUrl, i, cardsSkin);
				card.name = "back";
				card.addEventListener(MouseEvent.CLICK, dealDeckCard, false, 0, true);
				
				deck.addChild(card);
			}
		}
		
		//made by Kaloqn
		private function dealDeckCard(e:MouseEvent):void
		{
			var currentCard:Sprite = e.target as Sprite;
			
			var undealedCards:Sprite = deckContainer.getChildAt(0) as Sprite
			undealedCards.removeChild(currentCard);
			
			var dealPile:Sprite = deckContainer.getChildAt(1) as Sprite
			dealRandomCard(dealPile, cards, counterPlacedCards,0,CARDS_NUMBERS);
			counterPlacedCards++;
		}
		
		private function flipCard(card:Card):void
		{
			var backCard:Card = card;
			var parentContainer:Sprite = backCard.parent as Sprite;
			
			if (isLastCardOfPile(backCard, parentContainer))
			{
				var cardY = (parentContainer.numChildren - 2) * CARDS_Y_SPACING
				parentContainer.removeChild(backCard);
				dealRandomCard(parentContainer, cards, counterPlacedCards, cardY, CARDS_NUMBERS);
				counterPlacedCards++;
			}
		}
		
		protected override function isLastCardOfPile(givenCard:Card, spriteContainer:Sprite = null):Boolean
		{
			for (var pile:int = 0; pile < spriteContainer.numChildren; pile++)
			{
				var pileContainer:Sprite = spriteContainer.getChildAt(pile) as Sprite;
				
				var lastCardIndex:int = spriteContainer.numChildren - 1;
				
				var card:Card = spriteContainer.getChildAt(lastCardIndex) as Card;
				
				if (givenCard == card)
				{
					return true;
				}
				
			}
				
			return false;	
		}
		
		//made by Jordan
		protected override function surrender(e:MouseEvent):void
		{
			gameOver();
		}
		
		//made by Jordan
		protected override function gameOver():void
		{
			isGameRunning = false;
		}
		
		//made by Jordan
		private function canBeDragged(cardContainer:Sprite, cardIndex:int):Boolean
		{
			var cardOne:Card;
			var cardTwo:Card
			
			for (var i:int = cardIndex; i < cardContainer.numChildren - 1; i++)
			{
				cardOne = cardContainer.getChildAt(i) as Card;
				cardTwo = cardContainer.getChildAt(i + 1) as Card;
				
				if (cardOne.name == "back" || cardTwo.name == "back")
				{
					multipleStartIndex = null;
					moveMultiple = false;
					return false;
				}
				else if (cardOne.CardValue != cardTwo.CardValue + 1)
				{
					multipleStartIndex = null;
					moveMultiple = false;
					return false;
				}
				
				multipleStartIndex = cardIndex;
				moveMultiple = true;
			}
			
			return true
		}
		
		//made by Jordan
		protected override function startDraging(e:MouseEvent):void
		{
			if (!isDragging)
			{
				isDragging = true;
				
				var cardContainer:Sprite = e.target.parent as Sprite;
				var cardIndex:int = cardContainer.getChildIndex(e.target as Card);
				
				if (canBeDragged(cardContainer, cardIndex))
				{
					movingCardObject = e.target as Sprite;
					movCardCurrentSprite = movingCardObject.parent as Sprite;
					
					if (moveMultiple)
					{
						var cardsNum:int = movCardCurrentSprite.numChildren;
						
						for (var i:int = cardIndex + 1; i < cardsNum; i++)
						{
							var currentCard:Card = movCardCurrentSprite.getChildAt(i) as Card;
							currentCard.addEventListener(Event.ENTER_FRAME, followCard);
							followingCards.push(currentCard);
							
							movCardCurrentSprite.removeChild(currentCard);
							cardsNum--;
							i--;
							
							addChildAt(currentCard, this.numChildren);
						}
					}
					
					movingCardObject.parent.removeChild(movingCardObject);
					addChildAt(movingCardObject, this.numChildren - followingCards.length);
					
					movingCardObject.x = mouseX - movingCardObject.width / 2;
					movingCardObject.y = mouseY - movingCardObject.height / 2;
					
					movingCardX = mouseX;
					movingCardY = mouseY;
					
					e.target.startDrag();
				}
				else
				{
					resetMovCardVariables();
				}
			}
		}
		
		//made by Jordan
		private function followCard(e:Event):void
		{
			var counter:int = 1;
			for (var i:int = 0; i < followingCards.length; i++)
			{
				try
				{
					if (e.target as Card == followingCards[i])
					{
						e.target.x = movingCardObject.x;
						e.target.y = movingCardObject.y + counter * CARDS_Y_SPACING;
					}
					counter++;
				}
				catch (err:Error)
				{
					e.target.removeEventListener(Event.ENTER_FRAME, followCard);
					e.target.x = 0;
				}
			}
		}
		
		//made by Jordan
		protected override function stopDraging(e:MouseEvent):void
		{
			if (movingCardObject != null)
			{
				if (followingCards.length > 0)
				{
					for (var i:int = 0; i < followingCards.length; i++)
					{
						var followingCard:Card = followingCards[i];
						followingCards.splice(i, 1);
						
						removeChild(followingCard);
						movCardCurrentSprite.addChild(followingCard);
						followingCard.x = 0;
						followingCard.y = (movCardCurrentSprite.numChildren - 1) * CARDS_Y_SPACING
						followingCard.removeEventListener(Event.ENTER_FRAME, followCard);
						
						i--;
					}
				}
				
				movingCardObject.stopDrag();
				
				if (canBeMoved(movingCardObject as Card))
				{
					if (moveMultiple)
					{
						movingCardObject.y = (movCardNewSprite.numChildren - 1) * CARDS_Y_SPACING
						movingCardObject.x = 0;
						movCardNewSprite.addChild(movingCardObject);
						
						var numChildren:int = movCardCurrentSprite.numChildren;
						
						for (var startIndex:int = multipleStartIndex; startIndex - 1 < numChildren; startIndex++)
						{
							try
							{
								var card:Card = movCardCurrentSprite.getChildAt(multipleStartIndex) as Card;
								movCardCurrentSprite.removeChild(card);
								card.x = 0;
								card.y = (movCardNewSprite.numChildren - 1) * CARDS_Y_SPACING
								
								movCardNewSprite.addChild(card);
							}
							catch (err:Error)
							{
								
							}
						}
					}
					else
					{
						removeChild(movingCardObject);
						movingCardObject.x = 0;
						
						if (movCardToFoundation)
						{
							movingCardObject.y = 0;
							movingCardObject.buttonMode = false;
							movingCardObject.removeEventListener(MouseEvent.MOUSE_DOWN, startDraging);
							movingCardObject.removeEventListener(MouseEvent.MOUSE_UP, stopDraging);
							
							score += 100;
						}
						else
						{
							movingCardObject.y = (movCardNewSprite.numChildren - 1) * CARDS_Y_SPACING
						}
						
						movCardNewSprite.addChild(movingCardObject);
					}
					
					checkWin();
					
					checkFlipCard(movCardCurrentSprite);
					resetMovCardVariables();
				}
				else // if can't be moved 
				{
					removeChild(movingCardObject);
					
					e.target.x = 0
					
					if (moveMultiple)
					{
						movingCardObject.y = (multipleStartIndex - 1) * CARDS_Y_SPACING
						movingCardObject.x = 0;
						movCardCurrentSprite.addChildAt(movingCardObject, multipleStartIndex);
					}
					else
					{
						if (movCardCurrentSprite == deckContainer.getChildAt(1))
						{
							movingCardObject.y = 0;
						}
						else
						{
							e.target.y = (movCardCurrentSprite.numChildren - 1) * CARDS_Y_SPACING
						}
						movCardCurrentSprite.addChild(movingCardObject);
					}
					
					resetMovCardVariables();
				}
			}
		}
		
		//made by Jordan
		private function checkFlipCard(givenSprite:Sprite):void
		{
			try
			{
				var lastCard:Card = givenSprite.getChildAt(givenSprite.numChildren - 1) as Card;
				
				if (lastCard.name == "back")
				{
					flipCard(lastCard);
				}
			}
			catch (err:Error)
			{
				
			}
		
		}
		
		//made by Jordan
		// check if card can be moved to target possition and if its true sets the sprite field to it 
		protected override function canBeMoved(givenCard:Card):Boolean
		{
			//foundation container
			if (givenCard.hitTestObject(foundationContainer))
			{
				for (var pile:int = 0; pile < foundationContainer.numChildren; pile++)
				{
					var pileContainer:Sprite = foundationContainer.getChildAt(pile) as Sprite;
					var lastCardIndex:int = pileContainer.numChildren - 1;
					var lastCard:Card;
					try
					{
						lastCard = pileContainer.getChildAt(lastCardIndex) as Card;
					}
					catch (err:Error)
					{
						trace("no last card");
					}
					
					if (givenCard.hitTestObject(pileContainer))
					{
						if (pileContainer.numChildren == 1 && givenCard.CardValue == 1)
						{
							movCardNewSprite = pileContainer as Sprite;
							movCardToFoundation = true;
							return true;
						}
						else if (lastCard != null)
						{
							if (givenCard.CardValue == lastCard.CardValue + 1 && givenCard.CardSign == lastCard.CardSign)
							{
								movCardNewSprite = pileContainer as Sprite;
								movCardToFoundation = true;
								return true;
							}
						}
					}
				}
			}
			
			//tauble container
			if (givenCard.hitTestObject(taublePilesContainer))
			{
				for (var pile:int = 0; pile < taublePilesContainer.numChildren; pile++)
				{
					var pileContainer:Sprite = taublePilesContainer.getChildAt(pile) as Sprite;
					var lastCardIndex:int = pileContainer.numChildren - 1;
					var lastCard:Card = pileContainer.getChildAt(lastCardIndex) as Card;
					
					if (givenCard.hitTestObject(pileContainer))
					{
						if (pileContainer.numChildren > 1)
						{
							if (lastCard.CardValue - 1 == givenCard.CardValue)
							{
								movCardNewSprite = pileContainer as Sprite;
								return true;
							}
						}
						else
						{
							movCardNewSprite = pileContainer as Sprite;
							return true;
						}
					}
				}
			}
			
			return false
		}
		
		//made by Jordan
		protected override function resetMovCardVariables():void
		{
			isDragging = false;
			moveMultiple = false;
			multipleStartIndex = null;
			movCardNewSprite = null;
			movCardToFoundation = false;
			movingCardObject = null;
			movCardCurrentSprite = null;
			followingCards = new Vector.<Card>();
		}
		
		//made by Jordan
		protected override function checkWin():void
		{
			isWin = true;
			
			for (var pile:int = 0; pile < foundationContainer.numChildren; pile++)
			{
				var pileContainer:Sprite = foundationContainer.getChildAt(pile) as Sprite;
				
				if (pileContainer.numChildren != 14)
				{
					isWin = false
				}
			}
			
			if (isWin)
			{
				gameOver();
			}
		}
	}
}