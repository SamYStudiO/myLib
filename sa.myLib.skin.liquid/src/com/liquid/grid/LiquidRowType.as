/**
*
*
*	LiquidSlice
*	
* 	This class is distributed under Creative Commons License.
* 	http://creativecommons.org/licenses/by/2.0/fr/
*	
*	@author		Didier Brun
*	@version	1.1
* 	@link		http://www.bytearray.org
*
*/

package com.liquid.grid {
	import flash.events.EventDispatcher;
	
	import com.liquid.events.LiquidCellEvent;
	import com.liquid.grid.*;	

	/**
	* @private
	*/
	public class LiquidRowType extends EventDispatcher{
		
		// ------------------------------------------------
		//
		// ---o static
		//
		// ------------------------------------------------
		
		public static const SIZE_FIXED:int=0;
		public static const SIZE_RATIO:int=1;
		
		// ------------------------------------------------
		//
		// ---o properties
		//
		// ------------------------------------------------

		private var __sizeMode:int;		// sizing mode
		
		private var __ratio:Number;		// ratio (btw.0 & 1) 
		private var __size:Number;		// size (pixels);
		private var __minSize:Number;	// min size
		private var __maxSize:Number;	// max size
		private var __pos:Number;		// position relative
			
		private var __row:LiquidRow;		// Taille parent

		// ------------------------------------------------
		//
		// ---o constructor
		//
		// ------------------------------------------------
		
		public function LiquidRowType(	s:Number,
										sm:int=SIZE_FIXED,
										ms:Number=0,
										xs:Number=Number.POSITIVE_INFINITY){
			
			__sizeMode=sm;
			__minSize=ms;
			__maxSize=xs;
			
			if (__sizeMode==SIZE_RATIO){
				__ratio=s;
				__size=0;
			}else{
				__size=__minSize=s;
				
			}
			
		}	

		// ------------------------------------------------
		//
		// ---o public methods
		//
		// ------------------------------------------------
		
		/**
		* clone
		*/
		public function clone():LiquidRowType{
			var first:Number=__sizeMode==SIZE_FIXED ? __size : __ratio;
			var value:LiquidRowType=new LiquidRowType(first,__sizeMode,__minSize,__maxSize);
			return value;
		}
		
		/**
		* toString
		*/
		override public function toString():String{
			var str:String="LiquidSlice [";
			str+=__sizeMode==SIZE_FIXED ? "FIXED" : "RATIO";
			str+="]";
			return str;
		}
		
		/**
		* set the row
		*/
		public function set row(value:LiquidRow):void{
			__row=value;
		}
		
		/**
		* update size
		*/
		public function updateSize():void{
			if (__sizeMode==SIZE_RATIO){
				if (__row.ratioScale!=0){
					__size=Math.min(Math.max(__minSize,__row.ratioSize*__ratio/__row.ratioScale),
									__maxSize);
				}else{
					__size=__minSize;
				}
			}
			dispatchEvent(new LiquidCellEvent(LiquidCellEvent.ROWTYPE_RESIZE));
		}
		
		/**
		* Modifier la taille
		*/
		public function setSize(value:Number):void{
			if (__sizeMode!=SIZE_FIXED)throw (new Error("CHANGE SIZE OF NON FIXED ROW"));
			__size=__minSize=value;
			dispatchEvent(new LiquidCellEvent(LiquidCellEvent.ROWTYPE_FIXED_CHANGE));
			dispatchEvent(new LiquidCellEvent(LiquidCellEvent.ROWTYPE_RESIZE));
		}
		
		/**
		* get prefered size
		*/
		public function getPreferedSize():Number{
			return __ratio*__row.ratioSize;
		}
		
		/**
		* get the size
		*/
		public function get size():Number{
			return __size;
		}
		
		/**
		* get the ratio
		*/
		public function get ratio():Number{
			return __ratio;
		}
		
		/**
		* get the size mode
		*/
		public function get sizeMode():int{
			return __sizeMode;
		}
		
		/**
		* set ratio
		*/
		public function set ratio(value:Number):void{
			__ratio=value;
		}
		
		/**
		* get the min size
		*/
		public function get minSize():Number{
			return __minSize;
		}
		
		/**
		* get the max size
		*/
		public function get maxSize():Number{
			return __maxSize;
		}
		
		/**
		* get pos
		*/
		public function get pos():Number{
			return __pos;
		}
		
		/**
		* set pos
		*/
		public function set pos(value:Number):void{
			var oldpos:Number=__pos;
			__pos=value;
			if (oldpos!=__pos)dispatchEvent(new LiquidCellEvent(LiquidCellEvent.ROWTYPE_MOVE));
		}
		
		/**
		* change the ratio
		*/
		public function changeRatio(value:Number):void{
	
			if (__sizeMode==SIZE_FIXED){
				throw (new Error("CHANGE RATIO OF FIXED SIZE"));
			}
			var or:Number=__ratio-value;
			__ratio=value;
			dispatchEvent(new LiquidCellEvent(LiquidCellEvent.ROWTYPE_RATIO_CHANGE,false,false,or));
		}
		
	
		
	}
	
}

