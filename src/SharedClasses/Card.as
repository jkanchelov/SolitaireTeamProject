package SharedClasses
{
	import flash.events.*;
	import flash.display.*;
	import flash.geom.*;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Jordan
	 */
	public class Card extends Sprite
	{
		private var cardUrl:URLRequest;
		
		public function Card(cardUrl:String,cardValue:int,cardSkin:String = "Skin1/") 
		{
			this.cardUrl = new URLRequest("Data/images/Cards/" + cardSkin + cardUrl + ".png");
			this.name =	cardValue.toString();
			
			loadCard();
		}
		
		private function loadCard():void {
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderCompleate);
			loader.load(cardUrl);
			
			var card:Bitmap;
			function loaderCompleate():void
			{
				var bmp:Bitmap = loader.content as Bitmap;
				card = new Bitmap(bmp.bitmapData);
				card.height = 100;
				card.width = 65;
				addChild(card);
			}
		}
	}

}