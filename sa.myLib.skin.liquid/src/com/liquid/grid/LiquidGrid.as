/**
*
*
*	LiquidGrid
*	
* 	This class is distributed under Creative Commons License.
* 	http://creativecommons.org/licenses/by/2.0/fr/
* 
* 	Special Thanks to Alexandre Legout (www.applicationdomain.net)
*	
*	@author		Didier Brun
*	@version	1.1
* 	@link		http://www.bytearray.org
*
*/

package com.liquid.grid {
	import flash.display.Graphics;
	import flash.events.EventDispatcher;
	
	import com.liquid.events.LiquidCellEvent;
	import com.liquid.grid.*;	

	/**
	* @private
	*/
	public class LiquidGrid extends EventDispatcher{
		
		// ------------------------------------------------
		//
		// ---o properties
		//
		// ------------------------------------------------
		
		protected var rows:LiquidRow;
		protected var cols:LiquidRow;
		
		
		protected var __width:Number=1;
		protected var __height:Number=1;
		protected var __x:Number=0;
		protected var __y:Number = 0;
		
		protected var __parentGrid:LiquidGrid=null;
		
		[ArrayElementType("com.liquid.grid.LiquidCell")]
		protected var cells:Array;
		
		[ArrayElementType("com.liquid.grid.LiquidCell")]
		protected var listenableCells:Array;
		
		// ------------------------------------------------
		//
		// ---o constructor
		//
		// ------------------------------------------------
		
		public function LiquidGrid(pcols:LiquidRow,prows:LiquidRow){
			
			listenableCells=[];
			
			cols=pcols;
			rows=prows;
			
			cols.addEventListener(LiquidCellEvent.ROW_RESIZE,colsResizeHandler);
			rows.addEventListener(LiquidCellEvent.ROW_RESIZE,rowsResizeHandler);

			cols.size=__width;
			rows.size=__height;

			buildCells();
						
		}	

		// ------------------------------------------------
		//
		// ---o public methods
		//
		// ------------------------------------------------
		
		/**
		* clone
		*/
		public function clone():LiquidGrid{
			var cloneCols:LiquidRow=cols.clone();
			var cloneRows:LiquidRow=rows.clone();
			
			var value:LiquidGrid=new LiquidGrid(cloneCols,cloneRows);
			
			for (var x:int=0;x<cloneCols.length;x++){
				for (var y:int=0;y<cloneRows.length;y++){
					if (cells[x][y].grid!=null){
						value.getCell(x,y).setGrid(cells[x][y].grid.clone());
						value.getCell(x,y).changeParentGrid(value);
					}
					value.getCell(x,y).drawModeX=cells[x][y].drawModeX;
					value.getCell(x,y).drawModeY=cells[x][y].drawModeY;
				}
			}
			value.width=__width;
			value.height=__height;
			return value;
		}
		
		/**
		* get a cell
		*/
		public function getCell(x:int,y:int):LiquidCell{
			return cells[x][y];
		}
		
		/**
		* get a col by no
		*/
		public function getColAt(value:int):LiquidRowType{
			return cols.cells[value];
		}
		
		/**
		* get a row by no
		*/
		public function getRowAt(value:int):LiquidRowType{
			return rows.cells[value];
		}
		
		/**
		* toString
		*/
		override public function toString():String{
			return "LiquidGrid[]";
		}
		
		/**
		* set width
		*/
		public function set width(value:Number):void{
			cols.size=value;
			__width=cols.size;	
			updateListenableCells();
			dispatchEvent(new LiquidCellEvent(LiquidCellEvent.GRID_SIZE));
		}
		
		/**
		* set height
		*/
		public function set height(value:Number):void{
			rows.size=value;
			__height=rows.size;
			updateListenableCells();
			dispatchEvent(new LiquidCellEvent(LiquidCellEvent.GRID_SIZE));
		}
		
		/**
		* set x
		*/
		public function set x(value:Number):void{
			__x=value;
			updateListenableCells();
			dispatchEvent(new LiquidCellEvent(LiquidCellEvent.GRID_MOVE));
		}
		
		/**
		* set y
		*/
		public function set y(value:Number):void{
			__y=value;
			updateListenableCells();
			dispatchEvent(new LiquidCellEvent(LiquidCellEvent.GRID_MOVE));
		}
		
		/**
		* get x
		*/
		public function get x():Number{
			return __x;
		}
		
		/**
		* get x
		*/
		public function get y():Number{
			return __y;
		}
		
		/**
		* get width
		*/
		public function get width():Number{
			return __width;
		}
		
		/**
		* get height
		*/
		public function get height():Number{
			return __height;
		}
		
		/**
		* get cols
		*/
		public function getCols():LiquidRow{
			return cols;
		}
		
		/**
		* get rows
		*/
		public function getRows():LiquidRow{
			return rows;
		}
		
		/**
		* get cells
		*/
		public function getCells():Array{
			return cells;
		}
		
		/**
		 * get min width
		 */
		public function get minWidth():Number {
			return cols.minSize;
		}
		
		/**
		 * get min height
		 */
		public function get minHeight():Number {
			return rows.minSize;
		}
		
		/**
		* debug drawing
		*/
		public function debugDraw(g:Graphics,addx:Number=0,addy:Number=0):void{
	
			var dw:Number;
			var dh:Number;
			
			for (var dx:int=0;dx<cols.cells.length;dx++){
				for (var dy:int=0;dy<rows.cells.length;dy++){
					
					dw=cols.cells[dx].size;
					dh=rows.cells[dy].size;
					
							
								
					if (cells[dx][dy].grid!=null){
						cells[dx][dy].grid.debugDraw(g,__x+addx,__y+addy);
					}else{
						if (dw>=0 && dh>=0){
							
							g.lineStyle(0,0x666666);
							g.beginFill(0xEEEEEE);
							g.drawRect(cols.cells[dx].pos+__x+addx,
													rows.cells[dy].pos+__y+addy,
													dw,
													dh);
						}
					}
					
				}
			}
			
			g.lineStyle();
			g.beginFill(0x415B91);
			g.drawRect(__x+addx+2,
						__y+addy+2,
						3,
						3);
			
		}
		
		/**
		* add listenable cell
		*/
		public function addListenableCell(value:LiquidCell):void{
			listenableCells.push(value);
		}
		
		/**
		* set the parent grid
		*/
		public function set parentGrid(value:LiquidGrid):void{
			__parentGrid=value;
		}
		
		/**
		* get the parent grid
		*/
		public function get parentGrid():LiquidGrid{
			return __parentGrid;
		}
		
		/**
		* set size
		*/
		public function setSize(pw:Number,ph:Number):void{
			
			cols.size=pw;
			__width=cols.size;	
			
			rows.size=ph;
			__height=rows.size;
			
			updateListenableCells();
			dispatchEvent(new LiquidCellEvent(LiquidCellEvent.GRID_SIZE));
		}
	
		// ------------------------------------------------
		//
		// ---o private methods
		//
		// ------------------------------------------------
		
		/**
		* build cells
		*/
		private function buildCells():void{
			cells=new Array();
			listenableCells=new Array();
			
			for (var x:int=0;x<cols.length;x++){
				cells.push(new Array());
				for (var y:int=0;y<rows.length;y++){
					cells[x].push(new LiquidCell(cols.cells[x],rows.cells[y],this));
				}
			}
		}
		
		/**
		* cols resize handler
		*/
		private function colsResizeHandler(e:LiquidCellEvent):void{
			__width=cols.size;
			updateListenableCells();
			dispatchEvent(new LiquidCellEvent(LiquidCellEvent.GRID_SIZE));
		}
		
		/**
		* rows resize handler
		*/
		private function rowsResizeHandler(e:LiquidCellEvent):void{
			__height=rows.size;
			updateListenableCells();
			dispatchEvent(new LiquidCellEvent(LiquidCellEvent.GRID_SIZE));
		}
	
		/**
		* update the listenalbe cells
		*/
		private function updateListenableCells():void{
			var i:int=listenableCells.length;
			while (--i>=0)listenableCells[i].updateRect();
		}
		
		// ------------------------------------------------
		//
		// ---o static methods
		//
		// ------------------------------------------------
		
		/**
		* scale 9 grid
		*/
		public static function scale9Grid(	hleft:Number,
											hright:Number,
											vtop:Number,
											vbottom:Number,
											dwidth:Number,
											dheight:Number):LiquidGrid {
												
											
			var cols:LiquidRow=new LiquidRow(new LiquidRowType(hleft),
											new LiquidRowType(1,LiquidRowType.SIZE_RATIO),
											new LiquidRowType(hright));
			var rows:LiquidRow=new LiquidRow(new LiquidRowType(vtop),
											new LiquidRowType(1,LiquidRowType.SIZE_RATIO),
											new LiquidRowType(vbottom));
											
			var grid:LiquidGrid=new LiquidGrid(cols,rows);
			
			grid.setSize(dwidth,dheight);
			
			return grid;
		}
		
	}
	
}

