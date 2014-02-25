/*
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at 
 *
 *        http://www.mozilla.org/MPL/ 
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the License. 
 *
 * The Original Code is myLib.
 *
 * The Initial Developer of the Original Code is
 * Samuel EMINET (aka SamYStudiO) contact@samystudio.net.
 * Portions created by the Initial Developer are Copyright (C) 2008-2011
 * the Initial Developer. All Rights Reserved.
 *
 */
package myLib.displayUtils 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;	
	/**
	 * DepthManager is useful to move DisplayObject z order in display list.
	 * 
	 * @author SamYStudiO
	 */
	public final class DepthManager 
	{
		/**
		 * @private
		 */
		public function DepthManager()
		{
			throw new Error( this + " cannot be instantiated" );
		}
		
		/**
		 * Get the highest depth available within specified container.
		 * @param object The DisplayObjectContainer where get highest depth.
		 * @return The highest index available within the specified container.
		 * @throws A Error if object is null.
		 */
		public static function getHighestDepth( object : DisplayObjectContainer ) : uint
		{
			if( object == null ) throw new Error( DepthManager + " container object cannot be null" );
			
			return Math.max( 0 , object.numChildren - 1 );
		}
		
		/**
		 * Bring specified DisplayObject at the highest available depth with its parent container.
		 * @param object The DisplayObject to bring front.
		 * @return The depth index where DisplayObject is moved.
		 * @throws A Error if DisplayObject or its parent is null.
		 */
		public static function bringFront( object : DisplayObject ) : uint
		{
			if( object == null || object.parent == null ) throw new Error( DepthManager + " object cannot be null and its parent must be defined" );
			
			var index : uint = getHighestDepth( object.parent );
			
			object.parent.setChildIndex( object , index );
			
			return index;
		}
		
		/**
		 * Bring specified DisplayObject at the lowest depth with its parent container.
		 * @param object The DisplayObject to bring back.
		 * @return The depth index where DisplayObject is moved.
		 * @throws A Error if DisplayObject or its parent is null.
		 */
		public static function bringBack( object : DisplayObject) : uint
		{
			if( object == null || object.parent == null ) throw new Error( DepthManager + " object cannot be null and its parent must be defined" );
			
			object.parent.setChildIndex( object , 0 );
			
			return 0;
		}
		
		/**
		 * Move specified DisplayObject by incrementing its depth.
		 * @param object The DisplayObject to move front.
		 * @param loop A Boolean that indicates if DisplayObject is bring back if it is at the highest depth.
		 * @return The depth index where DisplayObject is moved.
		 * @throws A Error if DisplayObject or its parent is null.
		 */
		public static function moveFront( object : DisplayObject , loop : Boolean = false ) : uint
		{
			if( object == null || object.parent == null ) throw new Error( DepthManager + " object cannot be null and its parent must be defined" );
			
			var topIndex : uint = getHighestDepth( object.parent );
			var objectIndex : uint = object.parent.getChildIndex( object );
			var nextIndex : uint = objectIndex + 1;
			
			if( nextIndex > topIndex && loop ) nextIndex = 0;
			else nextIndex = nextIndex > topIndex ? topIndex : nextIndex;
			
			object.parent.setChildIndex( object , nextIndex );
			
			return nextIndex;
		}
			
		/**
		 * Move specified DisplayObject by decrementing its depth.
		 * @param object The DisplayObject to move back.
		 * @param loop A Boolean that indicates if DisplayObject is bring front if it is at the lowest depth.
		 * @return The depth index where DisplayObject is moved.
		 * @throws A Error if DisplayObject or its parent is null.
		 */
		public static function moveBack( object : DisplayObject , loop : Boolean = false ) : uint
		{
			if( object == null || object.parent == null ) throw new Error( DepthManager + " object cannot be null and its parent must be defined" );
			
			var topIndex : uint = getHighestDepth( object.parent );
			var objectIndex : uint = object.parent.getChildIndex( object );
			var previousIndex : int = objectIndex - 1;
			
			if( previousIndex < 0 && loop ) previousIndex = topIndex;
			else previousIndex = previousIndex < 0 ? 0 : previousIndex;
			
			object.parent.setChildIndex( object , previousIndex );
			
			return previousIndex;
		}
		
		/**
		 * Move specified DisplayObject front the specified DisplayObject.
		 * @param object The DisplayObject to move.
		 * @param target The displayObject target.
		 * @return The depth index where DisplayObject is moved.
		 * @throws A Error if DisplayObject or its parent is null or target DisplayObject is null or target DisplayObject parent is not the same as the source object.
		 */
		public static function bringFrontTarget( object : DisplayObject , target : DisplayObject ) : uint
		{
			if( object == null || target == null || object.parent == null || target.parent == null || object.parent != target.parent )
				throw new Error( DepthManager + " object and target cannot be null and their parent must be the same" );
			
			var index : uint = target.parent.getChildIndex( target );
			index = object.parent.getChildIndex( object ) > object.parent.getChildIndex( target ) ? index + 1 : index;
			
			object.parent.setChildIndex( object , index );
			
			return index;
		}
		
		/**
		 * Move specified DisplayObject behind the specified DisplayObject.
		 * @param object The DisplayObject to move.
		 * @param target The displayObject target.
		 * @return The depth index where DisplayObject is moved.
		 * @throws A Error if DisplayObject or its parent is null or target DisplayObject is null or target DisplayObject parent is not the same as the source object.
		 */
		public static function bringBackTarget( object : DisplayObject , target : DisplayObject ) : uint
		{
			if( object == null || target == null || object.parent == null || target.parent == null || object.parent != target.parent )
				throw new Error( DepthManager + " object and target cannot be null and their parent must be the same" );
			
			var index : uint = target.parent.getChildIndex( target );
			index = object.parent.getChildIndex( object ) < object.parent.getChildIndex( target ) ? index - 1 : index;
			
			object.parent.setChildIndex( object , index  );
			
			return index;
		}
	}
}
