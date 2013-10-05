/*

Copyright(c) Gerbrand Kamphuis 2013

Boost Software License - Version 1.0 - August 17th, 2003

Permission is hereby granted, free of charge, to any person or organization
obtaining a copy of the software and accompanying documentation covered by
this license ( the "Software" ) to use, reproduce, display, distribute,
execute, and transmit the Software, and to prepare derivative works of the
Software, and to permit third-parties to whom the Software is furnished to
do so, all subject to the following:

The copyright notices in the Software and this entire statement, including
the above license grant, this restriction and the following disclaimer,
must be included in all copies of the Software, in whole or in part, and
all derivative works of the Software, unless such copies or derivative
works are solely in the form of machine-executable object code generated by
a source language processor.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.

*/
module derelict.opencl.cl_egl;

import derelict.opencl.loader;
import derelict.opencl.types;

extern (System)
{
    // OpenCL 1.0
    alias nothrow cl_mem function(cl_context, CLeglDisplayKHR, CLeglImageKHR, cl_mem_flags, const(cl_egl_image_properties_khr), cl_int*) da_clCreateFromEGLImageKHR;
    alias nothrow cl_mem function(cl_command_queue, cl_uint, const(cl_mem*), cl_uint, const(cl_event*), cl_event*) da_clEnqueueAcquireEGLObjectsKHR;
    alias nothrow cl_int function(cl_command_queue, cl_uint, const(cl_mem*), cl_uint, const(cl_event*), cl_event*) da_clEnqueueReleaseEGLObjectsKHR;
    alias nothrow cl_event function(cl_context, void*, void*, cl_int*) da_clCreateEventFromEGLSyncKHR;
}

__gshared
{
    // OpenCL 1.0
    da_clCreateFromEGLImageKHR clCreateFromEGLImageKHR;
    da_clEnqueueAcquireEGLObjectsKHR clEnqueueAcquireEGLObjectsKHR;
    da_clEnqueueReleaseEGLObjectsKHR clEnqueueReleaseEGLObjectsKHR;
    da_clCreateEventFromEGLSyncKHR clCreateEventFromEGLSyncKHR;
}

package
{
    void loadSymbols(void delegate(void**, string, bool doThrow) bindFunc)
    {

    }

    CLVersion reload(void delegate(void**, string, bool doThrow) bindFunc, CLVersion clVer)
    {
        return clVer;
    }

    private __gshared bool _EXT_cl_khr_egl_image;
    public bool EXT_cl_khr_egl_image() @property { return _EXT_cl_khr_egl_image; }
    private void load_cl_khr_egl_image()
    {
        try
        {
            loadExtensionFunction(cast(void**)&clCreateFromEGLImageKHR, "clCreateFromEGLImageKHR");
            loadExtensionFunction(cast(void**)&clEnqueueAcquireEGLObjectsKHR, "clEnqueueAcquireEGLObjectsKHR");
            loadExtensionFunction(cast(void**)&clEnqueueReleaseEGLObjectsKHR, "clEnqueueReleaseEGLObjectsKHR");

            _EXT_cl_khr_egl_image = clCreateFromEGLImageKHR !is null &&
                                    clEnqueueAcquireEGLObjectsKHR !is null &&
                                    clEnqueueReleaseEGLObjectsKHR !is null;
        }
        catch(Exception e)
        {
            _EXT_cl_khr_egl_image = false;
        }
    }

    private __gshared bool _EXT_cl_khr_egl_event;
    public bool EXT_cl_khr_egl_event() @property { return _EXT_cl_khr_egl_event; }
    private void load_cl_khr_egl_event()
    {
        try
        {
            loadExtensionFunction(cast(void**)&clCreateEventFromEGLSyncKHR, "clCreateEventFromEGLSyncKHR");

            _EXT_cl_khr_egl_event = clCreateEventFromEGLSyncKHR !is null;
        }
        catch(Exception e)
        {
            _EXT_cl_khr_egl_event = false;
        }
    }

    void loadEXT(CLVersion clVer)
    {
        if(clVer >= CLVersion.CL10)
        {
            // OpenCL 1.0
            load_cl_khr_egl_image();
            load_cl_khr_egl_event();
        }
    }
}
