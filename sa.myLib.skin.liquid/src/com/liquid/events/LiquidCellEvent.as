/**
*
*
*	LiquidCellEvent
*
* 	This class is distributed under Creative Commons License.
* 	http://creativecommons.org/licenses/by/2.0/fr/
*	
*	@author		Didier Brun
*	@version	1.1
* 	@link		http://www.bytearray.org
*
*/

package com.liquid.events{
	
	import flash.events.Event;

	/**
	* @private
	*/
	public class LiquidCellEvent extends Event{
		
		// ------------------------------------------------
		//
		// ---o events 
		//
		// ------------------------------------------------
		
		public static const ROWTYPE_RATIO_CHANGE:String="rowtypeRatioChange";
		public static const ROWTYPE_FIXED_CHANGE:String="rowtypeFixedChange";
		
		public static const ROWTYPE_RESIZE:String="rowtypeResize";
		public static const ROWTYPE_MOVE:String="rowtypeMove";
		
		public static const ROW_RESIZE:String="rowResize";
		
		public static const CELL_MOVE:String="cellMove";
		public static const CELL_SIZE:String="cellSize";
		
		public static const GRID_MOVE:String="gridMove";
		public static const GRID_SIZE:String="gridSize";
		
		// ------------------------------------------------
		//
		// ---o properties 
		//
		// ------------------------------------------------
		
		public var ratio:Number;
		
		// ------------------------------------------------
		//
		// ---o constructor 
		//
		// ------------------------------------------------
		
		public function LiquidCellEvent(type:String,
										bubbles:Boolean = false,
										cancelable:Boolean = false,
										pRatio:Number=0){
								   
			ratio=pRatio;
			super(type, bubbles, cancelable);
		}
		
		// ------------------------------------------------
		//
		// ---o methods 
		//
		// ------------------------------------------------
		
		override public function clone():Event{
			return new LiquidCellEvent(type, bubbles,cancelable,ratio);
		}
		
	}
}