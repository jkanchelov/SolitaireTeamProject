package Games.TopsyTurvyQueens
{
	import com.greensock.*;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Desislava
	 */
	
	public class TopsyQueensPlay extends Sprite
	{
		
		private var container:Sprite = new Sprite();
		private var stockContainer:Sprite = new Sprite();
		private var talonContainer:Sprite = new Sprite();
		private var foundationContainer:Sprite = new Sprite();
		private var tableauContainer:Sprite = new Sprite();
		
		private var stockCard:Cards = new Cards(16, "backgroundSprite");
		private var faceDownCardStock:Cards = new Cards(15, "back2");
		
		private var arrCardsDeck:Array = new Array();
		
		private var countTalon:int = 0;
		private var arrTalon:Array = new Array();
		private var currCardTalonDrag:Cards;
		
		private var arrFaceUpFoundation:Array = new Array();
		private var arrFoundationContainers:Array = new Array();
		private var arrFaceDownFoundation:Array = new Array();
		
		private var arrTableauContainers:Array = new Array();
		private var arrTableau1:Array = new Array();
		private var arrTableau2:Array = new Array();
		private var arrTableau3:Array = new Array();
		private var arrTableau4:Array = new Array();
		private var arrTableau5:Array = new Array();
		private var arrTableau6:Array = new Array();
		private var arrTableau7:Array = new Array();
		private var arrTableau8:Array = new Array();
		private var arrEmptyRectangles:Array = new Array();
		private var checkCollisionArr:Array = new Array();
		private var numOfArr:int;
		private var kingsIndexArrCheckColl:Array = new Array();
		private var currIndexTableau:int;
		private var isMovingTalonCard:Boolean = false;
		private var isForReturnTableauCard:Boolean = true;
		private var tempContainer:Sprite;
		private var tempArr:Array = new Array();
		private var eventCardTableau:Cards;
		private var eventArr:Array = new Array();
		private var eventsContainer:Sprite;
		private var arrEmptyPosition:Array = new Array();
		private var currIndexDameFoundation:int;
		private var indexCurrImprisonedCard:int;
		private var currCoordImprisonedCard:Point;
		private var isCollideFoundationCard:Boolean;
		private var currImprisonedCard:Cards;
		private var paddingX:int = 20;
		private var paddingY:int = 10;
		
		public function TopsyQueensPlay()
		{
			addChild(container);
			container.addChild(stockCard);
			stockCard.x = 42;
			stockCard.y = 54;
			container.addChild(stockContainer);
			container.addChild(tableauContainer);
			container.addChild(foundationContainer);
			container.addChild(talonContainer);
			
			initFoundationContainers();
			initTableauContainers();
			initCardsDeck();
			dealStock();
			dealFoundations();
			dealTableaus();
		}
		
		private function initFoundationContainers():void
		{
			for (var i:int = 0; i < 8; i++)
			{
				var currFoundationContainer:Sprite = new Sprite();
				arrFoundationContainers.push(currFoundationContainer);
				foundationContainer.addChild(currFoundationContainer);
			}
		}
		
		private function initTableauContainers():void
		{
			for (var i:int = 0; i < 8; i++)
			{
				var currTableauContainer:Sprite = new Sprite();
				arrTableauContainers.push(currTableauContainer);
				tableauContainer.addChild(currTableauContainer);
			}
		
		}
		//push all cards in an array
		private function initCardsDeck():void
		{
			const arrSuits:Array = ["C", "H", "S", "D"];
			
			for (var i:int = 0; i < 13; i++)
			{
				for (var k:int = 0; k < 2; k++)
				{
					for (var j:int = 0; j < 4; j++)
					{
						var currCardFaceUp:Cards = new Cards(i, arrSuits[j]);
						arrCardsDeck.push(currCardFaceUp);
					}
				}
			}
		}
		
		private function dealStock():void
		{
			stockContainer.addChild(faceDownCardStock);
			faceDownCardStock.x = 42;
			faceDownCardStock.y = 54;
			if (!isMovingTalonCard)
			{
				faceDownCardStock.addEventListener(MouseEvent.CLICK, firstTalonDeal, false, 0, true);
			}
		}
		
		private function firstTalonDeal(evt:MouseEvent):void
		{
			var currIndexRandom:int = getRandomNumber();
			var cardTalon:Cards = arrCardsDeck[currIndexRandom];
			var currFreeIndex:int = arrFaceUpFoundation.length;
			paddingX = 20;
			//check for kings
			if (cardTalon.cardValue == 0)
			{
				countTalon++;
				talonContainer.addChild(cardTalon);
				cardTalon.x = 42 + paddingX + cardTalon.width;
				cardTalon.y = 54;
				kingsFromTalon(cardTalon, currFreeIndex);
			}
			else
			{
				pushCardsInTalon(cardTalon, currFreeIndex);
			}
			arrCardsDeck.splice(currIndexRandom, 1);
		
		}
		private function pushCardsInTalon(currCardTalon:Cards, freeIndexArrFaceUpFoundation:int):void
		{
			if (countTalon == 64)
			{
				faceDownCardStock.removeEventListener(MouseEvent.CLICK, firstTalonDeal);
				faceDownCardStock.parent.removeChild(faceDownCardStock);
				stockCard.addEventListener(MouseEvent.CLICK, clickStock);
			}
			countTalon++;
			arrTalon.push(currCardTalon);
			talonContainer.addChild(currCardTalon);
			currCardTalon.x = 42 + paddingX + currCardTalon.width;
			currCardTalon.y = 54;
			currCardTalon.addEventListener(MouseEvent.MOUSE_DOWN, clickDownTalonCard);
			currCardTalon.addEventListener(MouseEvent.MOUSE_UP, clickUpTalonCard);
		}
		//move kings from talon to foundation
		private function kingsFromTalon(currCard:Cards, freeIndexArrFaceUpFoundation:int):void
		{
			currCard.parent.removeChild(currCard);
			container.addChild(currCard);
			if (freeIndexArrFaceUpFoundation == 7)
			{
				isMovingTalonCard = true;
				TweenMax.to(currCard, 0.2, { x: 42 + currCard.cardWidth * 7 + 140, y: 64 + currCard.cardHeight, onComplete: setKingFromTalonInFoundation,
				onCompleteParams: [currCard, freeIndexArrFaceUpFoundation]});
			}
			else
			{
				isMovingTalonCard = true;
				TweenMax.to(currCard, 0.2, { x: arrFaceDownFoundation[freeIndexArrFaceUpFoundation].x, y: arrFaceDownFoundation[freeIndexArrFaceUpFoundation].y,
				onComplete: setKingFromTalonInFoundation, onCompleteParams: [currCard, freeIndexArrFaceUpFoundation]});
			}
		}
		
		private function setKingFromTalonInFoundation(currCard:Cards, freeIndexArrFoundation:int):void
		{
			while (arrFoundationContainers[freeIndexArrFoundation].numChildren > 0)
			{
				arrFoundationContainers[freeIndexArrFoundation].removeChildAt(0);
			}
			currCard.parent.removeChild(currCard);
			arrFoundationContainers[freeIndexArrFoundation].addChild(currCard);
			arrFaceUpFoundation.push(currCard);
			isMovingTalonCard = false;
		
		}
		private function clickDownTalonCard(evt:MouseEvent):void
		{
			currCardTalonDrag = evt.currentTarget as Cards;
			currCardTalonDrag.startDrag();
			currCardTalonDrag.parent.removeChild(currCardTalonDrag);
			container.addChild(currCardTalonDrag);
		}
		
		private function clickUpTalonCard(evt:MouseEvent):void
		{
			evt.currentTarget.stopDrag();
			checkCollisionTalon();
		}
		
		private function checkCollisionTalon():void
		{
			paddingX = 20;
			var indexArrTalon:int = arrTalon.indexOf(currCardTalonDrag); // get index dragging card from talon array 
			var isCollDetectedOnFondation:Boolean = checkCollisionFromTalonToFoundation(indexArrTalon);//collision on foundation
			if (!isCollDetectedOnFondation)
			{
				var isCollDetectedOnTableau:Boolean = checkCollisionFromTalonToTableau(indexArrTalon); //collision on tableau
				if (!isCollDetectedOnTableau)
				{
					TweenMax.to(currCardTalonDrag, 0.2, {x: 42 + paddingX + currCardTalonDrag.cardWidth, y: 54, onComplete: removeCurrCardTalon});
				}
			}
		}
		
		private function removeCurrCardTalon():void
		{
			currCardTalonDrag.parent.removeChild(currCardTalonDrag);
			talonContainer.addChild(currCardTalonDrag);
		}
		
		private function checkCollisionFromTalonToFoundation(currIndex:int):Boolean
		{
			
			for (var i:int = 0; i < arrFaceUpFoundation.length; i++)
			{
				if ((arrFaceUpFoundation[i] != undefined) && (arrFaceUpFoundation[i].hitTestPoint(mouseX, mouseY)) && (arrFaceUpFoundation[i].cardValue == currCardTalonDrag.cardValue - 1) && (arrFaceUpFoundation[i].cardSuit == currCardTalonDrag.cardSuit))
				{
					
					while (arrFoundationContainers[i].numChildren > 0)
					{
						arrFoundationContainers[i].removeChildAt(0);
					}
					currCardTalonDrag.parent.removeChild(currCardTalonDrag);
					arrFoundationContainers[i].addChild(currCardTalonDrag);
					currCardTalonDrag.x = arrFaceUpFoundation[i].x;
					currCardTalonDrag.y = arrFaceUpFoundation[i].y;
					arrFaceUpFoundation[i] = currCardTalonDrag;
					arrTalon.splice(currIndex, 1);
					currCardTalonDrag.removeEventListener(MouseEvent.MOUSE_DOWN, clickDownTalonCard);
					currCardTalonDrag.removeEventListener(MouseEvent.MOUSE_UP, clickUpTalonCard);
					if ((currCardTalonDrag.cardValue == 12) && (i < 7))
					{
						currIndexDameFoundation = i;
						imprisonedCard();
					}
					return true;
				}
				
			}
			return false;
		}
		private function checkCollisionFromTalonToTableau(currIndex:int):Boolean
		{
			for (var i:int = 0; i < checkCollisionArr.length; i++)
			{
				var currCollisionArrTableau:Array = getArr(i);
				var currCollisionContainer:Sprite = arrTableauContainers[i];
				
				if (currCollisionArrTableau != null)
				{
					if ((checkCollisionArr[i] != undefined) && (checkCollisionArr[i].hitTestPoint(mouseX, mouseY)) && (checkCollisionArr[i].cardValue == currCardTalonDrag.cardValue + 1) && (checkCollisionArr[i].cardSuit == currCardTalonDrag.cardSuit))
					{
						arrTalon.splice(currIndex, 1);
						currCardTalonDrag.parent.removeChild(currCardTalonDrag);
						currCollisionContainer.addChild(currCardTalonDrag);
						currCardTalonDrag.x = currCollisionArrTableau[0].x;
						currCardTalonDrag.y = currCollisionArrTableau[currCollisionArrTableau.length - 1].y + 20;
						currCardTalonDrag.whichArr = i;
						currCardTalonDrag.removeEventListener(MouseEvent.MOUSE_DOWN, clickDownTalonCard);
						currCardTalonDrag.removeEventListener(MouseEvent.MOUSE_UP, clickUpTalonCard);
						currCardTalonDrag.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownTableau, false, 0, true);
						currCardTalonDrag.addEventListener(MouseEvent.MOUSE_UP, mouseUpTableau, false, 0, true);
						currCollisionArrTableau.push(currCardTalonDrag);
						checkCollisionArr[i] = currCardTalonDrag;
						return true;
					}
				}
			}
			return false;
		}
		
		private function imprisonedCard():void
		{
			if (arrCardsDeck[0].cardValue == 0)
			{
				checkKingFoundation();
			}
			arrFoundationContainers[currIndexDameFoundation].addChild(arrCardsDeck[0]);
			arrCardsDeck[0].x = arrFaceUpFoundation[currIndexDameFoundation].x;
			arrCardsDeck[0].y = arrFaceUpFoundation[currIndexDameFoundation].y;
			arrCardsDeck[0].whichArr = 13;
			arrFaceUpFoundation[currIndexDameFoundation] = arrCardsDeck[0];
			arrFaceUpFoundation[currIndexDameFoundation].addEventListener(MouseEvent.MOUSE_DOWN, mouseDownFoundation, false, 0, true);
			arrFaceUpFoundation[currIndexDameFoundation].addEventListener(MouseEvent.MOUSE_UP, mouseUpFoundation, false, 0, true);
			arrCardsDeck.splice(0, 1);
		
		}
		private function checkKingFoundation():void
		{
			var currFreeIndex:int = arrFaceUpFoundation.length;
			while (arrFoundationContainers[currFreeIndex].numChildren > 0)
			{
				arrFoundationContainers[currFreeIndex].removeChildAt(0);
			}
			arrFoundationContainers[currFreeIndex].addChild(arrCardsDeck[0]);
			arrCardsDeck[0].x = arrFaceDownFoundation[currFreeIndex].x
			arrCardsDeck[0].y = arrFaceDownFoundation[currFreeIndex].y;
			arrFaceUpFoundation.push(arrCardsDeck[0]);
			arrCardsDeck.splice(arrCardsDeck[0], 1);
						
		}
		private function mouseDownFoundation(evt:MouseEvent):void
		{
			isCollideFoundationCard = false;
			currImprisonedCard = evt.currentTarget as Cards;
			indexCurrImprisonedCard = arrFaceUpFoundation.indexOf(evt.currentTarget);
			currCoordImprisonedCard = new Point(arrFaceUpFoundation[indexCurrImprisonedCard].x, arrFaceUpFoundation[indexCurrImprisonedCard].y);
			currImprisonedCard.parent.removeChild(currImprisonedCard);
			container.addChild(currImprisonedCard);
			currImprisonedCard.startDrag();
		
		}
		
		private function mouseUpFoundation(evt:MouseEvent):void
		{
			evt.currentTarget.stopDrag();
			checkCollisionFoundation();
		}
		
		private function checkCollisionFoundation():void
		{
			for (var i:int = 0; i < arrFaceUpFoundation.length; i++)
			{
				if ((arrFaceUpFoundation[i] != undefined) && (arrFaceUpFoundation[i].hitTestPoint(mouseX, mouseY)) && (arrFaceUpFoundation[i].cardValue == currImprisonedCard.cardValue - 1) && (arrFaceUpFoundation[i].cardSuit == currImprisonedCard.cardSuit))
				{
					isCollideFoundationCard = true;
					while (arrFoundationContainers[i].numChildren > 0)
					{
						arrFoundationContainers[i].removeChildAt(0);
					}
					currImprisonedCard.parent.removeChild(currImprisonedCard);
					arrFoundationContainers[i].addChild(currImprisonedCard);
					currImprisonedCard.x = arrFaceUpFoundation[i].x;
					currImprisonedCard.y = arrFaceUpFoundation[i].y;
					currImprisonedCard.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownFoundation);
					currImprisonedCard.removeEventListener(MouseEvent.MOUSE_UP, mouseUpFoundation);
					arrFaceUpFoundation[i] = currImprisonedCard;
					delete(arrFaceUpFoundation[currIndexDameFoundation]);
					
				}
			}
			if (!isCollideFoundationCard)
			{
				var X:int = currCoordImprisonedCard.x;
				trace(X);
				trace(Y);
				var Y:int = currCoordImprisonedCard.y;
				TweenMax.to(currImprisonedCard, 0.2, {x: X, y: Y, onComplete: removeImprisonedCard});
			}
		
		}
		private function removeImprisonedCard():void
		{
			currImprisonedCard.parent.removeChild(currImprisonedCard);
			arrFoundationContainers[indexCurrImprisonedCard].addChild(currImprisonedCard);
		}
		private function mouseDownTableau(evt:MouseEvent):void
		{
			isForReturnTableauCard = true;
			var canBeMove:Boolean = true;
			if (evt.currentTarget != null)
			{
				tempContainer = new Sprite();
				container.addChild(tempContainer);
				tempContainer.mouseEnabled = false;
				eventCardTableau = evt.currentTarget as Cards;
				numOfArr = eventCardTableau.whichArr;//from which array is current card
				eventArr = getArr(numOfArr);
				eventsContainer = arrTableauContainers[numOfArr];
				if (eventArr != null)
				{
					currIndexTableau = eventArr.indexOf(eventCardTableau);
					for (var i:int = currIndexTableau; i < eventArr.length; i++)
					{
						eventArr[i].parent.removeChild(eventArr[i]);
						tempArr.push(eventArr[i]);
					}
					for (i = 0; i < tempArr.length; i++)
					{
						tempContainer.addChild(tempArr[i]);
					}
					
				}
				if (tempArr.length > 1)
				{
					canBeMove = canMoveCardsInTableau();
				}
				if (canBeMove)
				{
					tempContainer.startDrag();
				}
			}
		
		}
		private function canMoveCardsInTableau():Boolean
		{
			var counter:int = 0;
			var firstCardInTempArr:Cards = tempArr[0];
			for (var i:int = 1; i < tempArr.length; i++)
			{
				if ((firstCardInTempArr.cardValue-1 == tempArr[i].cardValue) && (firstCardInTempArr.cardSuit == tempArr[i].cardSuit))
				{
					firstCardInTempArr = tempArr[i];
					counter++;
				}
			}
			if (counter == tempArr.length - 1)
			{
				return true;
			}
			return false;
		}
		private function mouseUpTableau(evt:MouseEvent):void
		{
			if ((evt.currentTarget != null) && (eventArr != null) && (tempContainer != null))
			{
				tempContainer.stopDrag();
				checkCollisionTableau()
			}
		
		}
		
		private function checkCollisionTableau():void
		{
			var isForRun:Boolean = true;
			
			if (arrEmptyPosition.length > 0)
			{
				isForRun = detectCollisionOnEmptyRectangles();
			}
			if (isForRun)
			{
				isForRun = detectCollisionOnFondation();
			}
			
			if (isForRun)
			{
				detectCollisionOnTableau();
			}
			
			if ((isForReturnTableauCard)&&(tempContainer.x!=0)&&(tempContainer.y!=0))
			{
				TweenMax.to(tempContainer, 0.3, {x: 0, y: 0, onComplete: removeTempContainer});
			}
			else
			{
				removeTempContainer();
			}
		}
		
		private function removeTempContainer():void
		{
		
			while (tempContainer.numChildren > 0)
			{
				tempContainer.removeChildAt(0);
			}
			tempContainer.parent.removeChild(tempContainer);
			tempContainer = null;
			for (var i:int = 0; i < tempArr.length; i++)
			{
				eventsContainer.addChild(tempArr[i]);
			}
			tempArr.splice(0, tempArr.length);
		}
		
		private function detectCollisionOnTableau():void
		{
			for (var i:int = 0; i < checkCollisionArr.length; i++)
			{
				if (numOfArr == i)
				{
					continue;
				}
				else
				{
					var currCollisionArrTableau:Array = getArr(i);
					var currCollisionContainerTableau:Sprite = arrTableauContainers[i];
					if (currCollisionArrTableau != null)
					{
						if ((checkCollisionArr[i] != undefined) && (checkCollisionArr[i].hitTestPoint(mouseX, mouseY)) && (checkCollisionArr[i].cardValue == tempArr[0].cardValue + 1) && (checkCollisionArr[i].cardSuit == tempArr[0].cardSuit))
						{
							isForReturnTableauCard = false;
							while (tempContainer.numChildren > 0)
							{
								tempContainer.removeChildAt(0);
							}
							tempContainer.parent.removeChild(tempContainer);
							tempContainer = null;
							for (var n:int = 0; n < tempArr.length; n++)
							{
								currCollisionContainerTableau.addChild(tempArr[n]);
							}
							
							for (var k:int = 0; k < tempArr.length; k++)
							{
								tempArr[k].x = currCollisionArrTableau[0].x;
								tempArr[k].y = currCollisionArrTableau[currCollisionArrTableau.length - 1].y + 20;
								tempArr[k].whichArr = i;
								currCollisionArrTableau.push(tempArr[k]);
							}
							tempArr.splice(0, tempArr.length);
							var spliceElemEvArr:int = eventArr.length - currIndexTableau;
							eventArr.splice(currIndexTableau, spliceElemEvArr);
							checkCollisionArr[i] = currCollisionArrTableau[currCollisionArrTableau.length - 1];
							checkForEmptyPositionTableaus(eventArr, numOfArr);
							checkForKingsInTableaus();
							return;
						}
						
					}
					
				}
			}
		
		}
		
		private function detectCollisionOnFondation():Boolean
		{
			for (var i:int = 0; i < arrFaceUpFoundation.length; i++)
			{
				if ((arrFaceUpFoundation[i] != undefined) && (arrFaceUpFoundation[i].hitTestPoint(mouseX, mouseY)) && (arrFaceUpFoundation[i].cardValue == tempArr[0].cardValue - 1) && (arrFaceUpFoundation[i].cardSuit == tempArr[0].cardSuit))
				{
					isForReturnTableauCard = false;
					while (arrFoundationContainers[i].numChildren > 0)
					{
						arrFoundationContainers[i].removeChildAt(0);
					}
					
					tempArr[0].parent.removeChild(tempArr[0]);
					tempContainer.parent.removeChild(tempContainer);
					tempContainer = null;
					arrFoundationContainers[i].addChild(tempArr[0]);
					tempArr[0].x = arrFaceUpFoundation[i].x;
					tempArr[0].y = arrFaceUpFoundation[i].y;
					arrFaceUpFoundation[i] = tempArr[0];
					tempArr[0].removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownTableau);
					tempArr[0].removeEventListener(MouseEvent.MOUSE_UP, mouseUpTableau);
					tempArr.splice(0, tempArr.length);
					eventArr.splice(eventArr.length - 1, 1);
					checkForEmptyPositionTableaus(eventArr, numOfArr);
					checkForKingsInTableaus();
					if ((arrFaceUpFoundation[i].cardValue == 12)&&(i<7))
					{
						currIndexDameFoundation = i;
						imprisonedCard();
					}
					return false;
					
				}
			}
			return true;
		}
		//push cards on empty rectangles
		private function detectCollisionOnEmptyRectangles():Boolean
		{
			for (var b:int = 0; b < arrEmptyPosition.length; b++)
			{
				var currCardsTableauRect:Rectangle = arrEmptyRectangles[arrEmptyPosition[b]];
				var currArray:Array = getArr(arrEmptyPosition[b]);
				var currContainer:Sprite = arrTableauContainers[arrEmptyPosition[b]];
				if (currArray != null)
				{
					if (currCardsTableauRect.hitTestPoint(mouseX, mouseY))
					{
						isForReturnTableauCard = false;
						while (tempContainer.numChildren > 0)
						{
							tempContainer.removeChildAt(0);
						}
						tempContainer.parent.removeChild(tempContainer);
						tempContainer = null;
						for (var j:int = 0; j < tempArr.length; j++)
						{
							currContainer.addChild(tempArr[j]);
						}
						for (j = 0; j < tempArr.length; j++)
						{
							tempArr[j].x = currCardsTableauRect.x;
							tempArr[j].y = currCardsTableauRect.y + j * 20;
							tempArr[j].whichArr = arrEmptyPosition[b];
							currArray.push(tempArr[j]);
							
						}
						
						var spliceElemEvArr:int = eventArr.length - currIndexTableau;
						eventArr.splice(currIndexTableau, spliceElemEvArr);
						checkForEmptyPositionTableaus(eventArr, numOfArr);
						checkCollisionArr[arrEmptyPosition[b]] = tempArr[tempArr.length - 1];
						tempArr.splice(0, tempArr.length);
						arrEmptyPosition.splice(b, 1);
						checkForKingsInTableaus();
						return false;
						
					}
				}
			}
			return true;
		}
		
		private function clickStock(evt:MouseEvent):void
		{
			countTalon = 0;
			while (talonContainer.numChildren > 0)
			{
				talonContainer.removeChildAt(0);
			}
			stockContainer.addChild(faceDownCardStock);
			faceDownCardStock.addEventListener(MouseEvent.CLICK, talonDeal);
		}
		
		private function talonDeal(evt:MouseEvent):void
		{
			if (countTalon == arrTalon.length - 1)
			{
				faceDownCardStock.parent.removeChild(faceDownCardStock);
			}
			if (arrTalon[countTalon]!=undefined)
			{
				trace(arrTalon[countTalon]);
				talonContainer.addChild(arrTalon[countTalon]);
				countTalon++;
			}
			else
			{
				faceDownCardStock.parent.removeChild(faceDownCardStock);
				//stockCard.removeEventListener(MouseEvent.CLICK, clickStock);
			}
		}
		
		private function dealFoundations():void
		{
			for (var i:int = 0; i < 7; i++)
			{
				var faceDownCardFoundation:Cards = new Cards(15, "back2");
				arrFoundationContainers[i].addChild(faceDownCardFoundation);
				faceDownCardFoundation.x = 42 + (faceDownCardFoundation.cardWidth * i) + paddingX * i;
				faceDownCardFoundation.y = 54 + faceDownCardFoundation.cardHeight + paddingY;
				arrFaceDownFoundation.push(faceDownCardFoundation);
			}
		}
		
		private function dealTableaus():void
		{
			paddingY += 10;
			for (var i:int = 0; i < 8; i++)
			{
				dealTableau(i);
			}
			checkForKingsInTableaus();
		
		}
		
		private function dealTableau(index:int):void
		{
			var emptyRectTableau:Rectangle = new Rectangle(72, 96);
			arrTableauContainers[index].addChild(emptyRectTableau);
			emptyRectTableau.x = 42 + emptyRectTableau.Width * index + paddingX * index;
			emptyRectTableau.y = 54 + emptyRectTableau.Height * 2 + paddingY;
			arrEmptyRectangles.push(emptyRectTableau);
			var paddingYTableau:int = 20;
			var currArrayTableau:Array = getArr(index);
			if (currArrayTableau != null)
			{
				for (var i:int = 0; i < 4; i++)
				{
					var indexRandom:int = getRandomNumber();
					var cardTableau:Cards = arrCardsDeck[indexRandom];
					arrTableauContainers[index].addChild(cardTableau);
					cardTableau.whichArr = index;
					cardTableau.x = 42 + emptyRectTableau.Width * index + paddingX * index;
					cardTableau.y = 54 + (emptyRectTableau.Height * 2) + (paddingYTableau * i) + paddingY;
					arrCardsDeck.splice(indexRandom, 1);
					currArrayTableau[i] = cardTableau;
					cardTableau.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownTableau, false, 0, true);
					cardTableau.addEventListener(MouseEvent.MOUSE_UP, mouseUpTableau, false, 0, true);
				}
				checkCollisionArr.push(currArrayTableau[currArrayTableau.length - 1]);
			}
		}
		
		private function checkForKingsInTableaus():void
		{
			for (var i:int = 0; i < checkCollisionArr.length; i++)
			{
				if ((checkCollisionArr[i] != undefined) && (checkCollisionArr[i].cardValue == 0))
				{
					kingsIndexArrCheckColl.push(i);
				}
			}
			if (kingsIndexArrCheckColl.length > 0)
			{
				moveKingsFromTableauInFoundation();
			}
		}
		
		private function moveKingsFromTableauInFoundation():void
		{
			
			paddingX = 20;
			for (var i:int = 0; i < kingsIndexArrCheckColl.length; i++)
			{
				var freeIndexArrFaceUpFoundation:int = arrFaceUpFoundation.length;
				arrFaceUpFoundation.push(checkCollisionArr[kingsIndexArrCheckColl[i]]);
				checkCollisionArr[kingsIndexArrCheckColl[i]].removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownTableau);
				checkCollisionArr[kingsIndexArrCheckColl[i]].removeEventListener(MouseEvent.MOUSE_UP, mouseUpTableau);
				if (freeIndexArrFaceUpFoundation == 7)
				{
					checkCollisionArr[kingsIndexArrCheckColl[i]].parent.removeChild(checkCollisionArr[kingsIndexArrCheckColl[i]]);
					container.addChild(checkCollisionArr[kingsIndexArrCheckColl[i]]);
					TweenMax.to(checkCollisionArr[kingsIndexArrCheckColl[i]], 0.5, {x: 42 + checkCollisionArr[kingsIndexArrCheckColl[i]].cardWidth * 7 + 140, y: 64 + checkCollisionArr[kingsIndexArrCheckColl[i]].cardHeight, delay: 1, onComplete: setKingFromTableauInFoundation, onCompleteParams: [kingsIndexArrCheckColl[i], freeIndexArrFaceUpFoundation, i]});
				}
				else
				{
					
					checkCollisionArr[kingsIndexArrCheckColl[i]].parent.removeChild(checkCollisionArr[kingsIndexArrCheckColl[i]]);
					container.addChild(checkCollisionArr[kingsIndexArrCheckColl[i]]);
					TweenMax.to(checkCollisionArr[kingsIndexArrCheckColl[i]], 0.5, {x: arrFaceDownFoundation[freeIndexArrFaceUpFoundation].x, y: arrFaceDownFoundation[freeIndexArrFaceUpFoundation].y, delay: 1, onComplete: setKingFromTableauInFoundation, onCompleteParams: [kingsIndexArrCheckColl[i], freeIndexArrFaceUpFoundation, i]});
				}
				
			}
		
		}
		
		private function setKingFromTableauInFoundation(indexCheckCollArr:int, freeIndexFaceUpFoundation:int, index:int):void
		{
			var currArrTableau:Array = getArr(indexCheckCollArr);
			if ((currArrTableau != null) && (currArrTableau.length > 0))
			{
				checkCollisionArr[indexCheckCollArr].parent.removeChild(checkCollisionArr[indexCheckCollArr]);
				while (arrFoundationContainers[freeIndexFaceUpFoundation].numChildren > 0)
				{
					arrFoundationContainers[freeIndexFaceUpFoundation].removeChildAt(0);
				}
				arrFoundationContainers[freeIndexFaceUpFoundation].addChild(checkCollisionArr[indexCheckCollArr]);
				currArrTableau.splice(currArrTableau.length - 1, 1);
				checkForEmptyPositionTableaus(currArrTableau, indexCheckCollArr);
				
			}
			if (index == kingsIndexArrCheckColl.length - 1)
			{
				kingsIndexArrCheckColl.splice(0, kingsIndexArrCheckColl.length);
				checkForKingsInTableaus();
			}
		
		}
		
		private function checkForEmptyPositionTableaus(arrTableau:Array, indexCollisionArray:int):void
		{
			
			if (arrTableau.length > 0)
			{
				checkCollisionArr[indexCollisionArray] = arrTableau[arrTableau.length - 1];
			}
			else
			{
				var emptyPos:int = indexCollisionArray;
				arrEmptyPosition.push(emptyPos);
				delete(checkCollisionArr[indexCollisionArray]);
			}
		}
		
		private function getRandomNumber():int
		{
			var randomNum:int = Math.floor(Math.random() * arrCardsDeck.length);
			return randomNum;
		}
		
		private function getArr(index:int):Array
		{
			var currArray:Array;
			
			switch (index)
			{
			case 0: 
				currArray = arrTableau1;
				break;
			case 1: 
				currArray = arrTableau2;
				break;
			case 2: 
				currArray = arrTableau3;
				break;
			case 3: 
				currArray = arrTableau4;
				break;
			case 4: 
				currArray = arrTableau5;
				break;
			case 5: 
				currArray = arrTableau6;
				break;
			case 6: 
				currArray = arrTableau7;
				break;
			case 7: 
				currArray = arrTableau8;
				break;
			default: 
				currArray = null;
			}
			return currArray;
		}
	
	}

}