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
	sealed abstract class SRTP
	{
		public const int AES128_CM_SHA1_80 = 0x0001;
		public const int AES128_CM_SHA1_32 = 0x0002;
		public const int AES128_F8_SHA1_80 = 0x0003;
		public const int AES128_F8_SHA1_32 = 0x0004;
		public const int NULL_SHA1_80      = 0x0005;
		public const int NULL_SHA1_32      = 0x0006;
		
		/* AEAD SRTP protection profiles from RFC 7714 */
		public const int AEAD_AES_128_GCM  = 0x0007;
		public const int AEAD_AES_256_GCM  = 0x0008;

#if !OpenSSL.NO_SRTP
		[CRepr]
		public struct protection_profile_st
		{
		    public char8* name;
		    public uint id;
		}
		public typealias PROTECTION_PROFILE = protection_profile_st;
		public struct stack_st_SRTP_PROTECTION_PROFILE {}

		/* Not porting these due to issues described within
		public function int sk_SRTP_PROTECTION_PROFILE_compfunc(PROTECTION_PROFILE** a, PROTECTION_PROFILE** b);
		public function void sk_SRTP_PROTECTION_PROFILE_freefunc(PROTECTION_PROFILE* a);
		public function PROTECTION_PROFILE* sk_SRTP_PROTECTION_PROFILE_copyfunc(PROTECTION_PROFILE* a);
		[Inline]
		public static int sk_SRTP_PROTECTION_PROFILE_num(stack_st_SRTP_PROTECTION_PROFILE* sk) => OpenSSL.sk_num((Stack.OPENSSL_STACK*)sk);
		[Inline]
		public static PROTECTION_PROFILE* sk_SRTP_PROTECTION_PROFILE_value(stack_st_SRTP_PROTECTION_PROFILE* sk, int idx) => (PROTECTION_PROFILE*)OpenSSL.sk_value((Stack.OPENSSL_STACK*)sk, idx);
		[Inline]
		public static stack_st_SRTP_PROTECTION_PROFILE* sk_SRTP_PROTECTION_PROFILE_new(sk_SRTP_PROTECTION_PROFILE_compfunc compare)
		{
			// ERROR: Non-static method 'Beef_Net.OpenSSL.SRTP.sk_SRTP_PROTECTION_PROFILE_new.internalF(void* a, void* b)' cannot match 'Beef_Net.OpenSSL.OpenSSL.sk_compfunc' because it contains captured variables, consider using a delegate or removing captures
			int internalF(void* a, void* b) => compare((PROTECTION_PROFILE**)a, (PROTECTION_PROFILE**)b);
			return (stack_st_SRTP_PROTECTION_PROFILE*)OpenSSL.sk_new(=> internalF);
		}
		[Inline]
		public static stack_st_SRTP_PROTECTION_PROFILE* sk_SRTP_PROTECTION_PROFILE_new_null() => (stack_st_SRTP_PROTECTION_PROFILE*)OpenSSL.sk_new_null();
		[Inline]
		public static stack_st_SRTP_PROTECTION_PROFILE* sk_SRTP_PROTECTION_PROFILE_new_reserve(sk_SRTP_PROTECTION_PROFILE_compfunc compare, int n)
		{
			// ERROR: Non-static method 'Beef_Net.OpenSSL.SRTP.sk_SRTP_PROTECTION_PROFILE_new_reserve.internalF(void* a, void* b)' cannot match 'Beef_Net.OpenSSL.OpenSSL.sk_compfunc' because it contains captured variables, consider using a delegate or removing captures
			int internalF(void* a, void* b) => compare((PROTECTION_PROFILE**)a, (PROTECTION_PROFILE**)b);
			return (stack_st_SRTP_PROTECTION_PROFILE*)OpenSSL.sk_new_reserve(=> internalF, n);
		}
		[Inline]
		public static int sk_SRTP_PROTECTION_PROFILE_reserve(stack_st_SRTP_PROTECTION_PROFILE* sk, int n) => OpenSSL.sk_reserve((Stack.OPENSSL_STACK *)sk, n);
		[Inline]
		public static void sk_SRTP_PROTECTION_PROFILE_free(stack_st_SRTP_PROTECTION_PROFILE* sk) => OpenSSL.sk_free((Stack.OPENSSL_STACK *)sk);
		[Inline]
		public static void sk_SRTP_PROTECTION_PROFILE_zero(stack_st_SRTP_PROTECTION_PROFILE* sk) => OpenSSL.sk_zero((Stack.OPENSSL_STACK *)sk);
		[Inline]
		public static PROTECTION_PROFILE* sk_SRTP_PROTECTION_PROFILE_delete(stack_st_SRTP_PROTECTION_PROFILE* sk, int i) => (PROTECTION_PROFILE *)OpenSSL.sk_delete((Stack.OPENSSL_STACK*)sk, i);
		[Inline]
		public static PROTECTION_PROFILE* sk_SRTP_PROTECTION_PROFILE_delete_ptr(stack_st_SRTP_PROTECTION_PROFILE* sk, PROTECTION_PROFILE* ptr) => (PROTECTION_PROFILE *)OpenSSL.sk_delete_ptr((Stack.OPENSSL_STACK*)sk, (void*)ptr);
		[Inline]
		public static int sk_SRTP_PROTECTION_PROFILE_push(stack_st_SRTP_PROTECTION_PROFILE* sk, PROTECTION_PROFILE* ptr) => OpenSSL.sk_push((Stack.OPENSSL_STACK *)sk, (void*)ptr);
		[Inline]
		public static int sk_SRTP_PROTECTION_PROFILE_unshift(stack_st_SRTP_PROTECTION_PROFILE* sk, PROTECTION_PROFILE* ptr) => OpenSSL.sk_unshift((Stack.OPENSSL_STACK *)sk, (void*)ptr);
		[Inline]
		public static PROTECTION_PROFILE* sk_SRTP_PROTECTION_PROFILE_pop(stack_st_SRTP_PROTECTION_PROFILE* sk) => (PROTECTION_PROFILE *)OpenSSL.sk_pop((Stack.OPENSSL_STACK*)sk);
		[Inline]
		public static PROTECTION_PROFILE* sk_SRTP_PROTECTION_PROFILE_shift(stack_st_SRTP_PROTECTION_PROFILE* sk) => (PROTECTION_PROFILE*)OpenSSL.sk_shift((Stack.OPENSSL_STACK*)sk);
		[Inline]
		public static void sk_SRTP_PROTECTION_PROFILE_pop_free(stack_st_SRTP_PROTECTION_PROFILE* sk, sk_SRTP_PROTECTION_PROFILE_freefunc freefunc)
		{
			// ERROR: Non-static method 'Beef_Net.OpenSSL.SRTP.sk_SRTP_PROTECTION_PROFILE_pop_free.internalF(void* a)' cannot match 'function void(void*)' because it contains captured variables, consider using a delegate or removing captures
			void internalF(void* a) => freefunc((PROTECTION_PROFILE*)a);
			OpenSSL.sk_pop_free((Stack.OPENSSL_STACK*)sk, => internalF);
		}
		[Inline]
		public static int sk_SRTP_PROTECTION_PROFILE_insert(stack_st_SRTP_PROTECTION_PROFILE* sk, PROTECTION_PROFILE* ptr, int idx) => OpenSSL.sk_insert((Stack.OPENSSL_STACK*)sk, (void*)ptr, idx);
		[Inline]
		public static PROTECTION_PROFILE* sk_SRTP_PROTECTION_PROFILE_set(stack_st_SRTP_PROTECTION_PROFILE* sk, int idx, PROTECTION_PROFILE* ptr) => (PROTECTION_PROFILE*)OpenSSL.sk_set((Stack.OPENSSL_STACK*)sk, idx, (void*)ptr);
		[Inline]
		public static int sk_SRTP_PROTECTION_PROFILE_find(stack_st_SRTP_PROTECTION_PROFILE* sk, PROTECTION_PROFILE* ptr) => OpenSSL.sk_find((Stack.OPENSSL_STACK*)sk, (void*)ptr);
		[Inline]
		public static int sk_SRTP_PROTECTION_PROFILE_find_ex(stack_st_SRTP_PROTECTION_PROFILE* sk, PROTECTION_PROFILE* ptr) => OpenSSL.sk_find_ex((Stack.OPENSSL_STACK*)sk, (void*)ptr);
		[Inline]
		public static void sk_SRTP_PROTECTION_PROFILE_sort(stack_st_SRTP_PROTECTION_PROFILE* sk) => OpenSSL.sk_sort((Stack.OPENSSL_STACK*)sk);
		[Inline]
		public static int sk_SRTP_PROTECTION_PROFILE_is_sorted(stack_st_SRTP_PROTECTION_PROFILE* sk) => OpenSSL.sk_is_sorted((Stack.OPENSSL_STACK*)sk);
		[Inline]
		public static stack_st_SRTP_PROTECTION_PROFILE* sk_SRTP_PROTECTION_PROFILE_dup(stack_st_SRTP_PROTECTION_PROFILE* sk) => (stack_st_SRTP_PROTECTION_PROFILE* )OpenSSL.sk_dup((Stack.OPENSSL_STACK*)sk);
		[Inline]
		public static stack_st_SRTP_PROTECTION_PROFILE* sk_SRTP_PROTECTION_PROFILE_deep_copy(stack_st_SRTP_PROTECTION_PROFILE* sk, sk_SRTP_PROTECTION_PROFILE_copyfunc copyfunc, sk_SRTP_PROTECTION_PROFILE_freefunc freefunc)
		{
			// ERROR: Non-static method 'Beef_Net.OpenSSL.SRTP.sk_SRTP_PROTECTION_PROFILE_deep_copy.internalF1(void* a)' cannot match 'Beef_Net.OpenSSL.OpenSSL.sk_copyfunc' because it contains captured variables, consider using a delegate or removing captures
			void* internalF1 (void* a) => (void*)copyfunc((PROTECTION_PROFILE*)a);
			// ERROR: Non-static method 'Beef_Net.OpenSSL.SRTP.sk_SRTP_PROTECTION_PROFILE_deep_copy.internalF2(void* a)' cannot match 'Beef_Net.OpenSSL.OpenSSL.sk_freefunc' because it contains captured variables, consider using a delegate or removing captures
			void internalF2(void* a) => freefunc((PROTECTION_PROFILE*)a);
			return (stack_st_SRTP_PROTECTION_PROFILE*)OpenSSL.sk_deep_copy((Stack.OPENSSL_STACK*)sk, => internalF1, => internalF2);
		}
		[Inline]
		public static sk_SRTP_PROTECTION_PROFILE_compfunc sk_SRTP_PROTECTION_PROFILE_set_cmp_func(stack_st_SRTP_PROTECTION_PROFILE* sk, sk_SRTP_PROTECTION_PROFILE_compfunc compare)
		{
			// ERROR: Non-static method 'Beef_Net.OpenSSL.SRTP.sk_SRTP_PROTECTION_PROFILE_set_cmp_func.internalF(void* a, void* b)' cannot match 'Beef_Net.OpenSSL.OpenSSL.sk_compfunc' because it contains captured variables, consider using a delegate or removing captures
			int internalF(void* a, void* b) => compare((PROTECTION_PROFILE**)a, (PROTECTION_PROFILE**)b);
			return (sk_SRTP_PROTECTION_PROFILE_compfunc)OpenSSL.sk_set_cmp_func((Stack.OPENSSL_STACK*)sk, => internalF);
		}
		*/
#endif
	}
}
