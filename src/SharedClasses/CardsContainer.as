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
	public class CardsContainer extends Sprite
	{
		private static const CONTAINER_WIDTH = 65;
		private static const CONTAINER_HEIGHT = 100; 
		
		public function CardsContainer() 
		{
			loadBackground();
		}
			
		public static function get ContainerWidth():int {
			return CONTAINER_WIDTH
		}
		
		public static function get ContainerHeight():int {
			return CONTAINER_HEIGHT;
		}
		
		private function loadBackground():void 
		{
			var backgroundUrl:URLRequest = new URLRequest("Data/images/Background/backgroundSprite.png");
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderCompleate);
			loader.load(backgroundUrl);
			
			var containerBackground:Bitmap;
			function loaderCompleate():void
			{
				var bmp:Bitmap = loader.content as Bitmap;
				containerBackground = new Bitmap(bmp.bitmapData);
				containerBackground.height = CONTAINER_HEIGHT;
				containerBackground.width = CONTAINER_WIDTH;
				addChild(containerBackground);
			}
		}
	}
}