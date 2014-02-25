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
	import flash.display.FrameLabel;
	import flash.display.MovieClip;	
	/**
	 * FrameLabelUtils is a manager to get informations through FrameLabel class.
	 * 
	 * @author SamYStudiO
	 */
	public final class FrameLabelUtils 
	{
		/**
		 * @private
		 */
		public function FrameLabelUtils()
		{
			throw new Error( this + " cannot be instantiated" );
		}
		
		/**
		 * Get the FrameLabel in the specified MovieClip and index.
		 * @param mc The MovieClip from which retrieve FrameLabel.
		 * @param index The indexed FrameLabel to get.
		 * @return The FrameLabel object or null if arguments does not match any FrameLabel.
		 */
		public static function getFrameLabelFromIndex( mc : MovieClip , index : uint ) : FrameLabel
		{
			return index > mc.currentLabels.length - 1 ? null : mc.currentLabels[ index ] as FrameLabel;
		}
		
		/**
		 * Get label index using label name.
		 * @param mc The MovieClip from which retrieve label index.
		 * @param label The label name to search.
		 * @return The label index or -1 if searched label does not exist.
		 */
		public static function getLabelIndex( mc : MovieClip , label : String ) : int
		{
			var a : Array = mc.currentLabels;
			var l : uint = a.length;
			
			for( var i : uint = 0; i < l; i++ ) 
			{
				if( ( a[ i ] as FrameLabel ).name == label ) return i;
			}
			
			return -1;
		}
		
		/**
		 * Get FrameLabel using label name.
		 * @param mc The MovieClip from which retrieve FrameLabel.
		 * @param name The label name to search.
		 * @return The FrameLabel object or null if label name is not found.
		 */
		public static function getFrameLabelFromName( mc : MovieClip , name : String ) : FrameLabel
		{
			var a : Array = mc.currentLabels;
			
			for each( var label : FrameLabel in a ) 
			{
				if( label.name == name ) return label;
			}
			
			return null;
		}
		
		/**
		 * Get FrameLabel at the specified MovieClip frame.
		 * @param mc The MovieClip from which retrieve FrameLabel.
		 * @param frame The MovieClip frame where retrive FrameLabel.
		 * @return The FrameLabel object or null if no FrameLabel is found at the specified frame.
		 */
		public static function getFrameLabelAtFrame( mc : MovieClip , frame : uint ) : FrameLabel
		{
			var a : Array = mc.currentLabels;
			var old : FrameLabel;
			
			for each( var label : FrameLabel in a ) 
			{
				if( label.frame >= frame ) return old;
				
				old = label;
			}
			
			return null;
		}
		
		/**
		 * Get the last frame number of the specified label name.
		 * @param mc The MovieClip from which retrieve last label frame.
		 * @param label The label name from which retrieve last label frame.
		 * @return The last frame number of the specified label.
		 */
		public static function getLabelEndFrame( mc : MovieClip , label : String ) : int
		{
			var frameLabel : FrameLabel = getFrameLabelFromName( mc , label );
			
			if( frameLabel == null ) return -1;
			
			var nextFrameLabel : FrameLabel = getFrameLabelFromIndex( mc , getLabelIndex( mc , frameLabel.name ) + 1 );
			
			return nextFrameLabel == null ? mc.totalFrames : nextFrameLabel.frame - 1;
		}
	}
}
