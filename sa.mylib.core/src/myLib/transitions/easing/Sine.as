﻿// Copyright © 2007. Adobe Systems Incorporated. All Rights Reserved.
package myLib.transitions.easing
{

/**
 *  @private
 *  The Sine class defines three easing functions to implement 
 *  motion with ActionScript animation. The acceleration of motion for a Sine
 *  easing equation is less than that for a Quadratic equation. 
 */  
public class Sine
{


	//--------------------------------------------------------------------------
	//
	//  Class methods
	//
	//--------------------------------------------------------------------------

    /**
     *  The <code>easeIn()</code> method starts motion from zero velocity 
     *  and then accelerates motion as it executes. 
     *
     *  @param t Specifies the current time, between 0 and duration inclusive.
	 *
     *  @param b Specifies the initial value of the animation property.
	 *
     *  @param c Specifies the total change in the animation property.
	 *
     *  @param d Specifies the duration of the motion.
     *
     *  @return The value of the interpolated property at the specified time.        
     */  
	public static function easeIn(t:Number, b:Number,
								  c:Number, d:Number):Number
	{
		return -c * Math.cos(t / d * (Math.PI / 2)) + c + b;
	}

    /**
     *  The <code>easeOut()</code> method starts motion fast 
     *  and then decelerates motion to a zero velocity as it executes. 
     *
     *  @param t Specifies the current time, between 0 and duration inclusive.
	 *
     *  @param b Specifies the initial value of the animation property.
	 *
     *  @param c Specifies the total change in the animation property.
	 *
     *  @param d Specifies the duration of the motion.
     *
     *  @return The value of the interpolated property at the specified time.        
     */  
	public static function easeOut(t:Number, b:Number,
								   c:Number, d:Number):Number
	{
		return c * Math.sin(t / d * (Math.PI / 2)) + b;
	}

    /**
     *  The <code>easeInOut()</code> method combines the motion
     *  of the <code>easeIn()</code> and <code>easeOut()</code> methods
	 *  to start the motion from a zero velocity, accelerate motion, 
	 *  then decelerate to a zero velocity. 
     *
     *  @param t Specifies the current time, between 0 and duration inclusive.
	 *
     *  @param b Specifies the initial value of the animation property.
	 *
     *  @param c Specifies the total change in the animation property.
	 *
     *  @param d Specifies the duration of the motion.
     *
     *  @return The value of the interpolated property at the specified time.     
     */  
	public static function easeInOut(t:Number, b:Number,
									 c:Number, d:Number):Number
	{
		return -c / 2 * (Math.cos(Math.PI * t / d) - 1) + b;
	}
}

}
