/**
*
*
*	LiquidCell
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
	import flash.geom.Rectangle;
	
	import com.liquid.events.LiquidCellEvent;
	import com.liquid.grid.*;	

	/**
	* @private
	*/
	public class LiquidCell extends EventDispatcher{

		// ------------------------------------------------
		//
		// ---o static propreties
		//
		// ------------------------------------------------
	
		public static const DRAW_REPEAT:int=0;
		public static const DRAW_STRETCH:int=1;

		// ------------------------------------------------
		//
		// ---o public propreties
		//
		// ------------------------------------------------
		
		public var drawModeX:int=DRAW_REPEAT;
		public var drawModeY:int=DRAW_REPEAT;
		public var rectBmp:Rectangle=null;
		public var rect:Rectangle;

		// ------------------------------------------------
		//
		// ---o private propreties
		//
		// ------------------------------------------------
		
		private var __grid:LiquidGrid=null;			// Grille
		private var __parentGrid:LiquidGrid=null;	// Grille parente
		private var __row:LiquidRowType;
		private var __col:LiquidRowType;
		private var __listenable:Boolean=false;
		
		// ------------------------------------------------
		//
		// ---o constructor
		//
		// ------------------------------------------------
		
		public function LiquidCell(crt:LiquidRowType,rrt:LiquidRowType,pg:LiquidGrid=null){
			__row=rrt;
			__col=crt;
			__parentGrid=pg;
			rect=new Rectangle();
		}	

		// ------------------------------------------------
		//
		// ---o public methods
		//
		// ------------------------------------------------
		
		/**
		* set listenable
		*/
		public function set listenable(value:Boolean):void{
			__listenable=value;
			if (__listenable){
				__row.addEventListener(LiquidCellEvent.ROWTYPE_RESIZE,resizeRowHandler);
				__col.addEventListener(LiquidCellEvent.ROWTYPE_RESIZE,resizeColHandler);
				__row.addEventListener(LiquidCellEvent.ROWTYPE_MOVE,moveRowHandler);
				__col.addEventListener(LiquidCellEvent.ROWTYPE_MOVE,moveColHandler);
				
				__parentGrid.addListenableCell(this);
			}
		}
		
		/**
		* 	get litenable
		*/
		public function get listenable():Boolean{
			return __listenable;
		}
		
		/**
		* set a grid 
		*/
		public function setGrid(value:LiquidGrid):void{
			__grid=value;
			__grid.width=__col.size;
			__grid.height=__row.size;
						
			__grid.x=__col.pos;
			__grid.y=__row.pos;
			__grid.parentGrid=__parentGrid;
			
			listenable=true;
						
		}
		
		/**
		* get a grid
		*/
		public function get grid():LiquidGrid{
			return __grid;
		}
		
		/**
		* update pos
		*/
		public function updateRect():void{
			rect.x=__col.pos;
			rect.y=__row.pos;
			rect.width=__col.size;
			rect.height=__row.size;
		}
		
		/**
		* get parentGrid
		*/
		public function get parentGrid():LiquidGrid{
			return __parentGrid;
		}
		
		/**
		* change parent grid
		*/
		public function changeParentGrid(lg:LiquidGrid):void{
			__parentGrid=lg;
		}
		
		/**
		* global X
		*/
		public function get globalX():Number{
			return getParentGridX(rect.x,__parentGrid); 
		}
		
		/**
		* global Y
		*/
		public function get globalY():Number{
			return getParentGridY(rect.y,__parentGrid); 
		}
		
		// ------------------------------------------------
		//
		// ---o private methods
		//
		// ------------------------------------------------
		
		/**
		* get parentGrid x
		*/
		private function getParentGridX(value:Number,pg:LiquidGrid):Number{
			if (pg==null){
				return value;
			}else{
				return getParentGridX(value+pg.x,pg.parentGrid);
			}
		}
		
		/**
		* get parentGrid y
		*/
		private function getParentGridY(value:Number,pg:LiquidGrid):Number{
			if (pg==null){
				return value;
			}else{
				return getParentGridY(value+pg.y,pg.parentGrid);
			}
		}
		
		/**
		* move col handler
		*/
		private function moveColHandler(e:LiquidCellEvent):void{
			if (__grid!=null){
				__grid.x=__col.pos;
			}
			if (__listenable){
				rect.x=__col.pos;
				rect.y=__row.pos;
				dispatchEvent(new LiquidCellEvent(LiquidCellEvent.CELL_MOVE));
			}
		}
		
		/**
		* move row handler
		*/
		private function moveRowHandler(e:LiquidCellEvent):void{
			if (__grid!=null){
				__grid.y=__row.pos;
			}
			if (__listenable){
				rect.x=__col.pos;
				rect.y=__row.pos;
				dispatchEvent(new LiquidCellEvent(LiquidCellEvent.CELL_MOVE));
			}
		}
		
		/**
		* resize col
		*/
		private function resizeColHandler(e:LiquidCellEvent):void{
			if (__grid!=null){
				__grid.width=__col.size;
			}
			if (__listenable){
				rect.width=__col.size;
				rect.height=__row.size;
				dispatchEvent(new LiquidCellEvent(LiquidCellEvent.CELL_SIZE));
			}
		}
		
		/**
		* resize row
		*/
		private function resizeRowHandler(e:LiquidCellEvent):void{
			if (__grid!=null){
				__grid.height=__row.size;
			}
			if (__listenable){
				rect.width=__col.size;
				rect.height=__row.size;
				dispatchEvent(new LiquidCellEvent(LiquidCellEvent.CELL_SIZE));
			}
		}
	}
	
}

