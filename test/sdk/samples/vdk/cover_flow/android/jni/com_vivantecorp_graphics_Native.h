/****************************************************************************
*
*    Copyright 2012 - 2017 Vivante Corporation, Santa Clara, California.
*    All Rights Reserved.
*
*    Permission is hereby granted, free of charge, to any person obtaining
*    a copy of this software and associated documentation files (the
*    'Software'), to deal in the Software without restriction, including
*    without limitation the rights to use, copy, modify, merge, publish,
*    distribute, sub license, and/or sell copies of the Software, and to
*    permit persons to whom the Software is furnished to do so, subject
*    to the following conditions:
*
*    The above copyright notice and this permission notice (including the
*    next paragraph) shall be included in all copies or substantial
*    portions of the Software.
*
*    THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
*    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
*    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT.
*    IN NO EVENT SHALL VIVANTE AND/OR ITS SUPPLIERS BE LIABLE FOR ANY
*    CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
*    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
*    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*
*****************************************************************************/


/* DO NOT EDIT THIS FILE - it is machine generated */
/* Header for class com_vivantecorp_graphics_Native */

#ifndef _Included_com_vivantecorp_graphics_Native
#define _Included_com_vivantecorp_graphics_Native
#ifdef __cplusplus
extern "C" {
#endif
/*
 * Class:     com_vivantecorp_graphics_Native
 * Method:    init
 * Signature: (III)Z
 */
JNIEXPORT jboolean JNICALL Java_com_vivantecorp_graphics_Native_init
  (JNIEnv *, jobject, jint, jint, jint);

/*
 * Class:     com_vivantecorp_graphics_Native
 * Method:    fini
 * Signature: ()V
 */
JNIEXPORT void JNICALL Java_com_vivantecorp_graphics_Native_fini
  (JNIEnv *, jobject);

/*
 * Class:     com_vivantecorp_graphics_Native
 * Method:    repaint
 * Signature: ()Z
 */
JNIEXPORT jboolean JNICALL Java_com_vivantecorp_graphics_Native_repaint
  (JNIEnv *, jobject);

/*
 * Class:     com_vivantecorp_graphics_Native
 * Method:    key
 * Signature: (IZ)V
 */
JNIEXPORT void JNICALL Java_com_vivantecorp_graphics_Native_key
  (JNIEnv *, jobject, jint, jboolean);

/*
 * Class:     com_vivantecorp_graphics_Native
 * Method:    touch
 * Signature: (IIZ)V
 */
JNIEXPORT void JNICALL Java_com_vivantecorp_graphics_Native_touch
  (JNIEnv *, jobject, jint, jint, jboolean);

#ifdef __cplusplus
}
#endif
#endif
