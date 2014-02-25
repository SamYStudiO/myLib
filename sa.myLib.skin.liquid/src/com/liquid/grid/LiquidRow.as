/**
*
*
*	LiquidRow
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
	import com.liquid.grid.LiquidRowType;	

	/**
	* @private
	*/
	public class LiquidRow extends EventDispatcher{
		
		// ------------------------------------------------
		//
		// ---o private propreties
		//
		// ------------------------------------------------

		[ArrayElementType("com.liquid.grid.LiquidRowType")]
		private var __cells:Array;
		
		[ArrayElementType("com.liquid.grid.LiquidRowType")]
		private var fixedCells:Array;
		
		[ArrayElementType("com.liquid.grid.LiquidRowType")]
		private var ratioCells:Array;
		
		private var __size:Number=0;
		private var __fixedSize:Number=0;
		private var __ratioSize:Number=0;
		private var __ratioScale:Number=0;
		private var __minSize:Number=0;

		
		public var forced:Boolean=false;
		
		
		
		// ------------------------------------------------
		//
		// ---o constructor
		//
		// ------------------------------------------------
		
		public function LiquidRow(lrt:LiquidRowType=null,... rest){
			var c:Array=[];
			if (lrt!=null){
				c.push(lrt);
			}
			if (rest!=null){
				c=c.concat(rest);
			}
			if (c.length>0)setRows(c);
		}	

		// ------------------------------------------------
		//
		// ---o public methods
		//
		// ------------------------------------------------
		
		/**
		* clone
		*/
		public function clone():LiquidRow{
			var cloneCells:Array=[];
			for (var i:int=0;i<__cells.length;i++){
				cloneCells.push(__cells[i].clone());
			}
			var value:LiquidRow=new LiquidRow();
			value.setRows(cloneCells);
			return value;
		}
		
		/**
		* set rows
		*/
		public function setRows(rw:Array):void{
			
			__cells=rw;
			ratioCells=[];
			fixedCells=[];
			
			for (var i:int=0;i<__cells.length;i++){
				__cells[i].row=this;
				if (__cells[i].sizeMode==LiquidRowType.SIZE_FIXED){
					fixedCells.push(__cells[i]);
				}else{
					ratioCells.push(__cells[i]);					
				}
				cells[i].addEventListener(LiquidCellEvent.ROWTYPE_RATIO_CHANGE,ratioChangeHandler);
				cells[i].addEventListener(LiquidCellEvent.ROWTYPE_FIXED_CHANGE,fixedChangeHandler);
			}
			
			updateFixedCells();	
			updateRatioCells();
			updatePos();
		}
		
		/**
		* toString
		*/
		override public function toString():String{
			var str:String="LiquidRow [";
			for (var i:int=0;i<__cells.length;i++){
				str+=cells[i]+"\n";
			}
			str+="]";
			return str;
		}
		
		/**
		* set the size
		*/
		public function set size(value:Number):void{
			__size=clamp(value,__minSize,Number.POSITIVE_INFINITY);
			updateFixedCells();
			updateRatioCells();
			updatePos();
			dispatchEvent(new LiquidCellEvent(LiquidCellEvent.ROW_RESIZE));
		}
		
		/**
		* get the size
		*/
		public function get size():Number{
			return __size;
		}
		
		/**
		* get the cells
		*/
		public function get cells():Array{
			return __cells;
		}
		
		/**
		* get fixed size
		*/
		public function get fixedSize():Number{
			return __fixedSize;
		}
		
		/**
		* get ratio size
		*/
		public function get ratioSize():Number{
			return __ratioSize;
		}
		
		/**
		* get min fixed size
		*/
		public function get ratioScale():Number{
			return __ratioScale;
		}
		
		/**
		* get the ratioCells
		*/
		public function getRatioCells():Array{
			return ratioCells;
		}

		/**
		* get length
		*/
		public function get length():int{
			return __cells.length;
		}
		
		/**
		 * get minSize
		 */
		public function get minSize():Number {
			return __minSize;
		}
		
		
		// ------------------------------------------------
		//
		// ---o private methods
		//
		// ------------------------------------------------
		
		/**
		* update fixed size
		*/
		private function updateFixedCells():void{
			
			var i:int=fixedCells.length;
			
			__fixedSize=0;
			__minSize=0;
			__ratioSize=__size;
			
			while (--i>=0){
				__fixedSize+=fixedCells[i].size;
				__minSize+=fixedCells[i].minSize;
				__ratioSize-=fixedCells[i].minSize;
				fixedCells[i].updateSize();
			}	
		}
		
		/**
		* update cells pos
		*/
		private function updatePos():void{
			var pos:Number=0;
			for (var i:int=0;i<cells.length;i++){
				cells[i].pos=pos;
				pos+=cells[i].size;
			}
		}
		
		/**
		* ratio changed handler
		*/
		private function ratioChangeHandler(e:LiquidCellEvent):void{
			
			if (ratioCells.length==1)throw (new Error("RATIO CHANGE IMPOSSIBLE ON 1 ROWTYPE"));
			
			var tot:Number=1-e.target.ratio;
			var oratio:Number=1-(e.target.ratio+e.ratio);
			var last:LiquidRowType;
			var raf:Number;
			var lastRatio:Number;
		
	
					
			for (var i:int=0;i<ratioCells.length;i++){
				if (ratioCells[i]!=e.target){
					raf=e.ratio*(ratioCells[i].ratio/oratio);
					ratioCells[i].ratio+=raf;
					last=ratioCells[i];
					lastRatio=ratioCells[i].ratio;
					tot-=lastRatio;
				}
			}
			
			if (tot<=0){
				last.ratio=lastRatio+.0000001;
			}
			
			updateFixedCells();
			updateRatioCells();
			updatePos();
			dispatchEvent(new LiquidCellEvent(LiquidCellEvent.ROW_RESIZE));
		}
		
		/**
		* fixed changed handler
		*/
		private function fixedChangeHandler(e:LiquidCellEvent):void{
			updateFixedCells();
			updateRatioCells();
			updatePos();
			__size=Math.max(__size,__minSize);
			dispatchEvent(new LiquidCellEvent(LiquidCellEvent.ROW_RESIZE));
		}
		
		/**
		* update the size
		*/
		private function updateRatioCells():void{
			
			var i:int=ratioCells.length;
			forced=false;
		
			__ratioScale=1;
					
			while (--i>=0){
			
				__minSize+=ratioCells[i].minSize;
				
				ratioCells[i].updateSize();
				
				if (ratioCells[i].minSize==ratioCells[i].size){
					forced=true;
					__ratioScale-=ratioCells[i].ratio;
					__ratioSize-=ratioCells[i].minSize;
				}else if (ratioCells[i].maxSize==ratioCells[i].size){
					forced=true;
					__ratioScale-=ratioCells[i].ratio;
					__ratioSize-=ratioCells[i].maxSize;
				}
			}
			
			if (forced){
				i=ratioCells.length;
				while (--i>=0){
					ratioCells[i].updateSize();						
				}
			}
			
			
		}
		
		
		/**
		* clamp a value
		*/
		private function clamp(value:Number,minValue:Number,maxValue:Number):Number{
			if (value<minValue)return minValue;
			if (value>maxValue)return maxValue;
			return value;
		}
		
		
		
	}
	
}

