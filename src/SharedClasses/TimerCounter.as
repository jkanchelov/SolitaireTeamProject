package SharedClasses
{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.text.*;
	
	/**
	 * ...
	 * @author Slobodan
	 */
	public class TimerCounter extends Sprite
	{
		private var tHours:String;
		private var tMinutes:String;
		private var tSeconds:String;
		private var seconds:uint;
		private var minutes:uint;
		private var hours:uint;
		private var tField:TextField;
		private var _timerTxtColor:uint;
		private var textSize:int;
		private var oneSecond:uint = 1000;
		
		public function TimerCounter(timerTxtColor:uint = 0, textSize:int = 15)
		{
			_timerTxtColor = timerTxtColor;
			this.textSize = textSize;
			loadTimer();
		}
		//Initializing the clock with text format   //Slobodan
		private function loadTimer():void
		{
			
			hours = 0;
			minutes = 0;
			seconds = 0;
			
			var timer:Timer = new Timer(oneSecond);
			
			tField = new TextField();
			
			var txtFormat:TextFormat = new TextFormat('Comic Sans MS', this.textSize, _timerTxtColor, true);
			txtFormat.align = "center";
			tField.defaultTextFormat = txtFormat;
			tField.mouseEnabled = false;
			addChild(tField);
			
			timer.addEventListener(TimerEvent.TIMER, drawClock);
			timer.start();
		}
		
		public function get GetTime():String
		{
			return tField.text;
		}
		//Drawing seconds,minutes and hours  //Slobodan
		private function drawClock(evt:TimerEvent):void
		{
			tHours = (hours < 10) ? "0" + hours.toString() : hours.toString();
			tMinutes = (minutes < 10) ? "0" + minutes.toString() : minutes.toString();
			tSeconds = (seconds < 10) ? "0" + seconds.toString() : seconds.toString();
			
			seconds += 1;
			
			if (seconds > 59)
			{
				minutes += 1;
			seconds = 0;
			}
			tField.text = String(tHours + ":" + tMinutes + ":" + tSeconds);
		}
	}
}