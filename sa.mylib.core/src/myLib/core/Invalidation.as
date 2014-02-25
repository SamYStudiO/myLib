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
	/**
	 * Invalidation contains invalidation types that need to be update when a component is invalidate.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public final class Invalidation 
	{
		/**
		 * @private
		 */
		protected var _types : uint = 0;
			
		/**
		 * Get the invalidation types active with this Invalidation object.
		 * @see InvalidationType
		 */
		public function get types(  ) : uint
		{
			return _types;
		}
		
		/**
		 * Build a new Invalidation instance.
		 * 
		 * @param types The invalidation types to add using InvalidationType constants separate with "|".
		 * @see InvalidationType
		 */
		public function Invalidation( types : uint = 0 )
		{
			_types = types || _types;
		}
		
		/**
		 * Check if the specified invalidation type is currently active within this Invalidation object.
		 * @param type The invalidation type to check using InvalidationType constants.
		 * @see InvalidationType
		 */
		public function contains( type : uint ) : Boolean
		{
			return ( _types | type ) == _types;
		}
		
		/**
		 * Add the specified invalidation types.
		 * 
		 * @param types The invalidation types to add using InvalidationType constants separate with "|".
		 */
		public function addTypes( types : uint ) : void
		{
			_types = ( _types | types );
		}
		
		/**
		 * remove the specified invalidation types.
		 * 
		 * @param types The invalidation types to remove using InvalidationType constants separate with "|".
		 */
		public function removeTypes( types : uint ) : void
		{
			_types = ( _types ^ types );
		}
		
		/**
		 * Add all invalidation types.
		 */
		public function addAllTypes(  ) : void
		{
			_types = InvalidationType.ALL;
		}

		/**
		 * Remove all invalidation types.
		 */
		public function removeAllTypes(  ) : void
		{
			_types = InvalidationType.NONE;
		}
		
		/**
		 * Check if at least one invalidation type is currently active.
		 * 
		 * @return A Boolean that indicate if invalidation is active.
		 */
		public function isActive(  ) : Boolean
		{
			return _types != InvalidationType.NONE;
		}
	}
}
