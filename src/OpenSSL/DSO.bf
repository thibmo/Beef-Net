/*
* Generated by util/mkerr.pl DO NOT EDIT
* Copyright 1995-2019 The OpenSSL Project Authors. All Rights Reserved.
*
* Licensed under the OpenSSL license (the "License").  You may not use
* this file except in compliance with the License.  You can obtain a copy
* in the file LICENSE in the source distribution or at
* https://www.openssl.org/source/license.html
*/
using System;

namespace Beef_Net.OpenSSL
{
	[AlwaysInclude]
	sealed abstract class DSO
	{
		/* These values are used as commands to DSO_ctrl() */
		public const int CTRL_GET_FLAGS = 1;
		public const int CTRL_SET_FLAGS = 2;
		public const int CTRL_OR_FLAGS  = 3;

		/*
		 * By default, load() will translate the provided filename into a form typical for the platform using the dso_name_converter function of the method. Eg. win32 will transform "blah" into "blah.dll", and dlfcn will
		 * transform it into "libblah.so". This callback could even utilise the METHOD's converter too if it only wants to override behaviour for one or two possible DSO methods. However, the following flag can be
		 * set in a DSO to prevent *any* native name-translation at all - eg. if the caller has prompted the user for a path to a driver library so the filename should be interpreted as-is.
		 */
		public const int FLAG_NO_NAME_TRANSLATION       = 0x01;
		/*
		 * An extra flag to give if only the extension should be added as translation.  This is obviously only of importance on Unix and other operating systems where the translation also may prefix the name with
		 * something, like 'lib', and ignored everywhere else. This flag is also ignored if FLAG_NO_NAME_TRANSLATION is used at the same time.
		 */
		public const int FLAG_NAME_TRANSLATION_EXT_ONLY = 0x02;
		
		/* Don't unload the DSO when we call free() */
		public const int FLAG_NO_UNLOAD_ON_FREE         = 0x04;
		
		/* This flag loads the library with public symbols. Meaning: The exported symbols of this library are public to all libraries loaded after this library. At the moment only implemented in unix. */
		public const int FLAG_GLOBAL_SYMBOLS            = 0x20;

		public function void FUNC_TYPE();

		/*
		 * The function prototype used for method functions (or caller-provided callbacks) that transform filenames. They are passed a DSO structure pointer (or NULL if they are to be used independently of a DSO object) and
		 * a filename to transform. They should either return NULL (if there is an error condition) or a newly allocated string containing the transformed form that the caller will need to free with OPENSSL_free() when done.
		 */
		public function char8* NAME_CONVERTER_FUNC(dso_st* dso, char8* n);
		/*
		 * The function prototype used for method functions (or caller-provided callbacks) that merge two file specifications. They are passed a DSO structure pointer (or NULL if they are to be used independently of a DSO
		 * object) and two file specifications to merge. They should either return NULL (if there is an error condition) or a newly allocated string containing the result of merging that the caller will need to free with
		 * OpenSSL.free() when done. Here, merging means that bits and pieces are taken from each of the file specifications and added together in whatever fashion that is sensible for the DSO method in question.  The only rule
		 * that really applies is that if the two specification contain pieces of the same type, the copy from the first string takes priority.
		 * One could see it as the first specification is the one given by the user and the second being a bunch of defaults to add on if they're missing in the first.
		 */
		public function char8* MERGER_FUNC(dso_st* dso, char8* a, char8* b);
		
		[Import(OPENSSL_LIB_CRYPTO), LinkName("DSO_new")]
		public extern static dso_st* new_();
		[Import(OPENSSL_LIB_CRYPTO), LinkName("DSO_free")]
		public extern static int free(dso_st* dso);
		[Import(OPENSSL_LIB_CRYPTO), LinkName("DSO_flags")]
		public extern static int flags(dso_st* dso);
		[Import(OPENSSL_LIB_CRYPTO), LinkName("DSO_up_ref")]
		public extern static int up_ref(dso_st* dso);
		[Import(OPENSSL_LIB_CRYPTO), LinkName("DSO_ctrl")]
		public extern static int ctrl(dso_st* dso, int cmd, int larg, void* parg);
		
		/* These functions can be used to get/set the platform-independent filename used for a DSO. NB: set will fail if the DSO is already loaded. */
		[Import(OPENSSL_LIB_CRYPTO), LinkName("DSO_get_filename")]
		public extern static char8* get_filename(dso_st* dso);
		[Import(OPENSSL_LIB_CRYPTO), LinkName("DSO_set_filename")]
		public extern static int set_filename(dso_st* dso, char8* filename);
		/*
		 * This function will invoke the DSO's name_converter callback to translate a filename, or if the callback isn't set it will instead use the METHOD's converter. If "filename" is NULL, the "filename" in the DSO itself will be
		 * used. If the FLAG_NO_NAME_TRANSLATION flag is set, then the filename is simply duplicated. NB: This function is usually called from within a METHOD during the processing of a load() call, and is exposed so
		 * that caller-created METHODs can do the same thing. A non-NULL return value will need to be OpenSSL.free()'d.
		 */
		[Import(OPENSSL_LIB_CRYPTO), LinkName("DSO_convert_filename")]
		public extern static char8* convert_filename(dso_st* dso, char8* filename);
		/* This function will invoke the DSO's merger callback to merge two file specifications, or if the callback isn't set it will instead use the METHOD's merger.  A non-NULL return value will need to be OpenSSL.free()'d. */
		[Import(OPENSSL_LIB_CRYPTO), LinkName("DSO_merge")]
		public extern static char8* merge(dso_st* dso, char8* filespec1, char8* filespec2);
		
		/*
		 * The all-singing all-dancing load function, you normally pass NULL for the first and third parameters. Use up_ref and DSO_free for subsequent reference count handling. Any flags passed in will be set in the
		 * constructed DSO after its init() function but before the load operation. If 'dso' is non-NULL, 'flags' is ignored.
		 */
		[Import(OPENSSL_LIB_CRYPTO), LinkName("DSO_load")]
		public extern static dso_st* load(dso_st* dso, char8* filename, METHOD* meth, int flags);
		
		/* This function binds to a function inside a shared library. */
		[Import(OPENSSL_LIB_CRYPTO), LinkName("DSO_bind_func")]
		public extern static FUNC_TYPE bind_func(dso_st* dso, char8* symname);
		
		/* This method is the default, but will beg, borrow, or steal whatever method should be the default on any particular platform (including METH_null() if necessary). */
		[Import(OPENSSL_LIB_CRYPTO), LinkName("DSO_METHOD_openssl")]
		public extern static METHOD* METHOD_openssl();
		
		/*
		 * This function writes null-terminated pathname of DSO module containing 'addr' into 'sz' large caller-provided 'path' and returns the number of characters [including trailing zero] written to it. If 'sz' is 0 or
		 * negative, 'path' is ignored and required amount of characters [including trailing zero] to accommodate pathname is returned. If 'addr' is NULL, then pathname of cryptolib itself is returned.
		 * Negative or zero return value denotes error.
		 */
		[Import(OPENSSL_LIB_CRYPTO), LinkName("DSO_pathbyaddr")]
		public extern static int pathbyaddr(void* addr, char8* path, int sz);
		
		/* Like pathbyaddr() but instead returns a handle to the DSO for the symbol or NULL on error. */
		[Import(OPENSSL_LIB_CRYPTO), LinkName("DSO_dsobyaddr")]
		public extern static dso_st* dsobyaddr(void* addr, int flags);
		
		/*
		 * This function should be used with caution! It looks up symbols in *all* loaded modules and if module gets unloaded by somebody else attempt to dereference the pointer is doomed to have fatal consequences. Primary
		 * usage for this function is to probe *core* system functionality, e.g. check if getnameinfo(3) is available at run-time without bothering about OS-specific details such as libc.so.versioning or where does it actually
		 * reside: in libc itself or libsocket.
		 */
		[Import(OPENSSL_LIB_CRYPTO), LinkName("DSO_global_lookup")]
		public extern static void* global_lookup(char8* name);
		
		[Import(OPENSSL_LIB_CRYPTO), CLink]
		public extern static int ERR_load_DSO_strings();

		/**********************************************************************/
		/* The low-level handle type used to refer to a loaded shared library */
		public struct stack_st_void {}
		
		[CRepr]
		public struct dso_st
		{
		    public METHOD* meth;
		    /*
		     * Standard dlopen uses a (void*). Win32 uses a HANDLE. VMS doesn't use anything but will need to cache the filename for use in the dso_bind handler. All in all, let each method control its own destiny.
		     * "Handles" and such go in a STACK.
		     */
		    public stack_st_void* meth_data;
		    public Crypto.REF_COUNT references;
		    public int flags;
		    /* For use by applications etc ... use this for your bits'n'pieces, don't touch meth_data! */
		    public Crypto.EX_DATA ex_data;
		    /* If this callback function pointer is set to non-NULL, then it will be used in load() in place of meth->dso_name_converter. NB: This should normally set using set_name_converter(). */
		    public NAME_CONVERTER_FUNC name_converter;
		    /*
		     * If this callback function pointer is set to non-NULL, then it will be
		     * used in DSO_load() in place of meth->dso_merger. NB: This should
		     * normally set using DSO_set_merger().
		     */
		    public MERGER_FUNC merger;
		    /* This is populated with (a copy of) the platform-independent filename used for this DSO. */
		    public char8* filename;
		    /*
		     * This is populated with (a copy of) the translated filename by which the DSO was actually loaded. It is NULL iff the DSO is not currently loaded. NB: This is here because the filename translation process may
		     * involve a callback being invoked more than once not only to convert to a platform-specific form, but also to try different filenames in the process of trying to perform a load. As such, this variable can be
		     * used to indicate (a) whether this DSO structure corresponds to a loaded library or not, and (b) the filename with which it was actually loaded.
		     */
		    public char8* loaded_filename;
		    public Crypto.RWLOCK* lock;
		}
		public typealias DSO = dso_st;

		[CRepr]
		public struct meth_st
		{
		    public char8* name;
		    /* Loads a shared library, NB: new METHODs must ensure that a successful load populates the loaded_filename field, and likewise a successful unload OpenSSL.frees and NULLs it out. */
		    public function int(dso_st* dso) dso_load;
		    /* Unloads a shared library */
		    public function int(dso_st* dso) dso_unload;
		    /*
		     * Binds a function - assumes a return type of FUNC_TYPE. This should be cast to the real function prototype by the caller. Platforms that don't have compatible representations for different prototypes (this
		     * is possible within ANSI C) are highly unlikely to have shared libraries at all, let alone a METHOD implemented for them.
		     */
		    public function FUNC_TYPE(dso_st* dso, char8* symname) dso_bind_func;
		    /* The generic (yuck) "ctrl()" function. NB: Negative return values (rather than zero) indicate errors. */
		    public function int(dso_st* dso, int cmd, int larg, void* parg) dso_ctrl;
		    /* The default METHOD-specific function for converting filenames to a canonical native form. */
		    public NAME_CONVERTER_FUNC dso_name_converter;
		    /* The default METHOD-specific function for converting filenames to a canonical native form. */
		    public MERGER_FUNC dso_merger;
		    /* [De]Initialisation handlers. */
		    public function int(dso_st* dso) init;
		    public function int(dso_st* dso) finish;
		    /* Return pathname of the module containing location */
		    public function int(void* addr, char8* path, int sz) pathbyaddr;
		    /* Perform global symbol lookup, i.e. among *all* modules */
		    public function void*(char8* symname) globallookup;
		}
		public typealias METHOD = meth_st;
	}
}
