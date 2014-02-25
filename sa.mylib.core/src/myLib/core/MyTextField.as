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
package myLib.core 
{
	import myLib.styles.StyleManager;
	import myLib.styles.TextStyle;
	
	import flash.text.TextField;	
	/**
	 * @private
	 * 
	 * @author SamYStudiO
	 */
	public final class MyTextField 
	{
		/**
		 *
		 */
		public function MyTextField()
		{
			throw new Error( this + " cannot be instantiated" );
		}
		
		/**
		 *
		 */
		public static function build( width : Number = 100 , height : Number = 22 , style  : TextStyle = null , mergePropFromTextField : TextField = null ) : TextField
		{
			var tf : TextField = new TextField( );
			tf.width = width;
			tf.height = height;
			
			if( style != null ) StyleManager.setTextStyle( tf , style );
			else
			{
				tf.selectable = false;
				tf.defaultTextFormat = TextStyle.DEFAULT_TEXT_FORMAT;
			}
			
			if( mergePropFromTextField != null )
			{
				var has3DTransform : Boolean = tf.transform.matrix3D != null;
				
				// merge only properties editable from authoring tool
				tf.antiAliasType = mergePropFromTextField.antiAliasType;
				tf.background = mergePropFromTextField.background;
				tf.border = mergePropFromTextField.border;
				tf.defaultTextFormat = mergePropFromTextField.defaultTextFormat;
				tf.embedFonts = mergePropFromTextField.embedFonts;
				tf.filters = mergePropFromTextField.filters;
				tf.multiline = mergePropFromTextField.multiline;
				tf.rotation = mergePropFromTextField.rotation;
				if( has3DTransform ) tf.rotationX = mergePropFromTextField.rotationX;
				if( has3DTransform ) tf.rotationY = mergePropFromTextField.rotationY;
				if( has3DTransform ) tf.rotationZ = mergePropFromTextField.rotationZ;
				tf.scaleX = mergePropFromTextField.scaleX;
				tf.scaleY = mergePropFromTextField.scaleY;
				if( has3DTransform )tf.scaleZ = mergePropFromTextField.scaleZ;
				tf.selectable = mergePropFromTextField.selectable;
				tf.sharpness = mergePropFromTextField.sharpness;
				tf.textColor = mergePropFromTextField.textColor;
				tf.thickness = mergePropFromTextField.thickness;
				tf.type = mergePropFromTextField.type;
				tf.wordWrap = mergePropFromTextField.wordWrap;
				tf.x = mergePropFromTextField.x;
				tf.y = mergePropFromTextField.y;
				if( has3DTransform ) tf.z = mergePropFromTextField.z;
			}
			
			return tf;
		}
	}
}
