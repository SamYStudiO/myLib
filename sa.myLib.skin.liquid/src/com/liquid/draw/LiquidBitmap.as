/**
*
*
*	LiquidBitmap
*	
* 	This class is distributed under Creative Commons License.
* 	http://creativecommons.org/licenses/by/2.0/fr/
*	
*	@author		Didier Brun
*	@version	1.1
* 	@link		http://www.bytearray.org
*
*/

package com.liquid.draw
{
	import com.liquid.grid.*;

	import flash.display.*;
	import flash.geom.*;
	
	
	/**
	* @private
	*/
	public class LiquidBitmap {
	
		// ------------------------------------------------
		//
		// ---o private properties
		//
		// ------------------------------------------------
		
		private var texture:BitmapData;
		private var bitmaps:Object;
		private var defaultGrid:LiquidGrid;
		private var nbLayers:int;
		
		private var _width:Number;
		private var _height:Number;
			
		// ------------------------------------------------
		//
		// ---o constructor
		//
		// ------------------------------------------------
		
		public function LiquidBitmap(g:LiquidGrid,bmp:BitmapData,nbl:int=1):void{
			defaultGrid = g.clone();
			
			_width = g.width;
			_height = g.height;
			
			texture=bmp;
			bitmaps={};
			nbLayers=nbl;
			buildMap(defaultGrid);
		}

		// ------------------------------------------------
		//
		// ---o public methods
		//
		// ------------------------------------------------
		
		/**
		* getBitmap
		*/
		public function getBitmapCell(id:String):Object{
			return bitmaps[id];
		}
		
		/**
		* change bitmap
		*/
		public function changeBitmap(bmp:BitmapData):void{
			for each (var e:Object in bitmaps){
				for each (var b:BitmapData in e.bitmap){
					b.dispose();
				}
				
			}
			texture=bmp;
			bitmaps={};
			buildMap(defaultGrid);
		}
		
		/**
		*	nb layers
		*/
		public function getNbLayers():int{
			return nbLayers;
		}
		
		/**
		 * get width
		 */
		public function get width():Number { return _width; };
		
		/**
		 * get height
		 */
		public function get height():Number { return _height; };

		// ------------------------------------------------
		//
		// ---o private methods
		//
		// ------------------------------------------------
			
		/**
		*  buildmap
		*/
		private function buildMap(g:LiquidGrid,addx:Number=0,addy:Number=0,ads:String=""):void{
			
			var dw:Number;
			var dh:Number;
			
			var cols:LiquidRow=g.getCols();
			var rows:LiquidRow=g.getRows();
			var cells:Array=g.getCells();
			var rect:Rectangle=new Rectangle();
			var bmp:BitmapData;
			var lab:String;
						
			for (var dx:int=0;dx<cols.cells.length;dx++){
				for (var dy:int=0;dy<rows.cells.length;dy++){
					
					dw=cols.cells[dx].size;
					dh=rows.cells[dy].size;
					
					lab="bmp_"+dx+"_"+dy+"_"+ads;
					
	
					if (cells[dx][dy].grid!=null){
						buildMap(cells[dx][dy].grid,g.x+addx,g.y+addy,lab);
					}else{
						if (dw>0 && dh>0){
							
							if (cells[dx][dy].rectBmp==null){
								rect.x=Math.floor(cols.cells[dx].pos+g.x+addx);
								rect.y=Math.floor(rows.cells[dy].pos+g.y+addy);
								rect.width=Math.floor(dw);
								rect.height=Math.floor(dh);
							}else{
								rect.x=cells[dx][dy].rectBmp.x;
								rect.y=cells[dx][dy].rectBmp.y;
								rect.width=cells[dx][dy].rectBmp.width;
								rect.height=cells[dx][dy].rectBmp.height;
							}
							
							bitmaps[lab]={bitmap:[],cell:cells[dx][dy]};
							
							for (var i:int=0;i<nbLayers;i++){
								bmp=new BitmapData(dw,dh,true,0xFFFFFFFF);
								bmp.copyPixels(texture,rect,new Point(0,0));
								bitmaps[lab].bitmap.push(bmp);
								rect.y+=g.height;
							}
						}
					}	
				}
			}
		}
	}
}

