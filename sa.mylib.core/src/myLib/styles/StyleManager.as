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
package myLib.styles
{
	import myLib.core.IComponent;
	import myLib.my_internal;
	import myLib.utils.ObjectUtils;

	import flash.text.TextField;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	/**
	 * StyleManager lets you associated styles to DisplayObject or TextField. 
	 * DisplayObject styles use simple Object with pair key/value and TextField styles use TextStyle object.
	 * StyleManager also allow to store styles by associating them with a component Class and then apply this style as soon a component Class instance is build.
	 * 
	 * When a style object is applied to a component or TextField all properties within object that match a component or TextField property are applied.
	 * For example this is useful to avoid repetitive action when all TextField have same font or when all components of a kind must have a property with same value. 
	 * 
	 * @see mylib.styles.TextStyle
	 * @author SamYStudiO
	 */
	public final class StyleManager
	{
		/**
		 *
		 */
		private static var __instance : StyleManager;
		
		/**
		 *
		 */
		private static var __allowInstance : Boolean;
		
		/**
		 * 
		 */
		private var _globalStyles : Object;
		
		/**
		 * 
		 */
		private var _classStyle : Dictionary = new Dictionary( true );
		
		/**
		 * 
		 */
		private var _classInstances : Dictionary = new Dictionary( true );

		/**
		 * @private
		 */
		public function StyleManager()
		{
			if( !__allowInstance ) throw new Error( this + " Singleton instance can only be accessed through getInstance method" );
		}
		
		/**
		 * Style manager is a singleton, to get unique instance and used all StyleManager properties and methods call getInstance first.
		 * 
		 * @return The unique StyleManager singleton instance.
		 */
		public static function getInstance() : StyleManager
		{
			if ( __instance == null )
			{
				__allowInstance = true;
				__instance = new StyleManager();
				__allowInstance = false;
			}
			
			return __instance;
		}
		
		/**
		 * @private
		 */
		my_internal function registerInstance( instance : IComponent ) : void
		{
			try
			{
				var Clazz : Class  = getDefinitionByName( getQualifiedClassName( instance ) ) as Class;
				
				if( _classInstances[ Clazz ] == undefined ) _classInstances[ Clazz ] = new Dictionary( true );
				
				_classInstances[ Clazz ][ instance ] = true;
			}
			catch ( e : Error )
			{
				
			}
		}
		
		/**
		 * Get the global style Object that will be applied to all component instances registered with StyleManager.
		 * 
		 * @return The style Object with pair key/value that will be applied to component instances.
		 */
		public function getGlobalStyle( ) : Object
		{
			return _globalStyles;
		}
		
		/**
		 * Set the global style Object that will be applied to all component instances registered with StyleManager.
		 * 
		 * @param style The style Object with pair key/value that will be applied to component instances.
		 */
		public function setGlobalStyle( style : Object ) : void
		{
			_globalStyles = style;
			
			for each( var d : Dictionary in _classInstances ) 
			{
				for ( var instance : * in d ) 
				{
					instance.my_internal::setClassStyle( style );
				}
			}
		}
		
		/**
		 * Get the syle Object that will be applied with specified Class type.
		 * 
		 * @param c The Class type from which get associated style Object.
		 * 
		 * @return The style Object ssociated with the specified Class type.
		 */
		public function getClassStyle( c : Object ) : Object
		{
			if( c is Class ) return _classStyle[ c ];
			else
			{
				c = getDefinitionByName( getQualifiedClassName( c ) ) as Class;
			
				return _classStyle[ c ];
			}
		}
		
		/**
		 * Set the syle Object that will be applied with specified Class type.
		 * 
		 * @param c The Class type you want to associate a style Object.
		 * @param style The style Object to associate with the specified Class type.
		 */
		public function setClassStyle( c : Class , style : Object ) : void
		{
			_classStyle[ c ] = style;
			
			for ( var instance : * in _classInstances[ c ] ) 
			{
				instance.my_internal::setClassStyle( style );
			}
		}
		
		/**
		 * Apply a style Object to the specified instance.
		 * 
		 * @param instance The instance you want to apply a style Object.
		 * @param style The style Object to apply with the specified instance.
		 */
		public static function setInstanceStyle( instance : * , style : Object ) : void
		{
			if( style == null ) return;
			
			if( instance is IComponent ) ( instance as IComponent ).setStyle( style );
			else ObjectUtils.merge( style , instance );
		}
		
		/**
		 * Apply a TextStyle object to the specified TextField instance.
		 * 
		 * @param tf The TextField instance you want to apply a TextStyle object.
		 * @param style The TextStyle object to apply with the specified TextField instance.
		 * 
		 * @see myLib.styles.TextStyle
		 */
		public static function setTextStyle( tf : TextField , style : TextStyle ) : void
		{
			if( tf == null || style == null ) return;
			
			tf.embedFonts = style.embedFonts;
			tf.defaultTextFormat = style.textFormat;
			
			ObjectUtils.merge( style , tf );
			
			tf.setTextFormat( style.textFormat );
		}
	}
}

