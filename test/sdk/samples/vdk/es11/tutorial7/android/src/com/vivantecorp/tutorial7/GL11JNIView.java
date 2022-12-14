/*
 * Copyright (C) 2009 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.vivantecorp.graphics.gl11tutorial7;
/*
 * Copyright (C) 2008 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


import android.content.Context;
import android.opengl.GLSurfaceView;
import android.util.AttributeSet;
import android.util.Log;
import android.view.KeyEvent;
import android.view.MotionEvent;

import javax.microedition.khronos.egl.EGL10;
import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;
/**
 * An implementation of SurfaceView that uses the dedicated surface for
 * displaying an OpenGL animation.  This allows the animation to run in a
 * separate thread, without requiring that it be driven by the update mechanism
 * of the view hierarchy.
 *
 * The application-specific rendering code is delegated to a GLView.Renderer
 * instance.
 */
class GL11JNIView extends GLSurfaceView {
    GL11JNIView(Context context) {
        super(context);
        init();
    }

    public GL11JNIView(Context context, AttributeSet attrs) {
        super(context, attrs);
        init();
    }

    private void init() {
        setRenderer(new Renderer());
    }

    private class Renderer implements GLSurfaceView.Renderer {
        private static final String TAG = "Renderer";
        public void onDrawFrame(GL10 gl) {
//			Log.i("GL11_Tutorial1",String.format("Render ..."));
           if(!GL11JNILib.repaint())
				//((Activity) context).finish();
				android.os.Process.killProcess(android.os.Process.myPid());
        }

        public void onSurfaceChanged(GL10 gl, int width, int height) {
            GL11JNILib.init(width, height);
        }

        public void onSurfaceCreated(GL10 gl, EGLConfig config) {
            // Do nothing.
        }
    }

    @Override
    public boolean onKeyDown(int key, KeyEvent event) {
        GL11JNILib.changeBackground();
     	if( key==4 )
        {
            android.os.Process.killProcess(android.os.Process.myPid());
            return true;
        }
       return GL11JNILib.key(key,event.getAction() == KeyEvent.ACTION_DOWN);
    }
}

