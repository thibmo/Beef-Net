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
	sealed abstract class BN
	{
		[CRepr]
		public struct bignum_st
		{
		    public ULONG* d; /* Pointer to an array of 'BN_BITS2' bit chunks. */
		    public int top;  /* Index of last used d +1. */
		    /* The next are internal book keeping for bn_expand. */
		    public int dmax; /* Size of the d array. */
		    public int neg;  /* one if the number is negative */
		    public int flags;
		}
		public typealias BIGNUM = bignum_st;
		
		[CRepr]
		public struct gencb_st
		{
		    uint ver;           /* To handle binary (in)compatibility */
		    void* arg;                  /* callback-specific data */
			cb_struct cb;

			[Union, CRepr]
			public struct cb_struct
			{
		        /* if (ver==1) - handles old style callbacks */
		        function void(int, int, void*) cb_1;
		        /* if (ver==2) - new callback style */
		        function int(int, int, GENCB*) cb_2;
		    }
		}
		public typealias GENCB = gencb_st;

		/*
		 * 64-bit processor with LP64 ABI
		 */
#if SIXTY_FOUR_BIT_LONG
		public typealias ULONG = uint64;
		public const int BYTES = 8;
#endif

		/*
		 * 64-bit processor other than LP64 ABI
		 */
#if SIXTY_FOUR_BIT
		public typealias ULONG = uint64;
		public const int BYTES = 8;
#endif
		
		/*
		 * 32-bit processor
		 */
#if THIRTY_TWO_BIT
		public typealias ULONG = uint32;
		public const int BYTES = 4;
#endif

		public const ULONG BITS2 = (BYTES * 8);
		public const ULONG BITS  = (BITS2 * 2);
		public const ULONG TBIT  = ((ULONG)1 << (BITS2 - 1));

		public const int FLG_MALLOCED    = 0x01;
		public const int FLG_STATIC_DATA = 0x02;

		/*
		 * avoid leaking exponent information through timing,
		 * BN_mod_exp_mont() will call BN_mod_exp_mont_consttime,
		 * BN_div() will call BN_div_no_branch,
		 * BN_mod_inverse() will call bn_mod_inverse_no_branch.
		 */
		public const int FLG_CONSTTIME = 0x04;
		public const int FLG_SECURE    = 0x08;

		/* deprecated name for the flag */
		public const int FLG_EXP_CONSTTIME = FLG_CONSTTIME;
		public const int FLG_FREE          = 0x8000; /* used for debugging */
		
		[Import(OPENSSL_LIB_CRYPTO), LinkName("BN_set_flags")]
		public extern static void set_flags(BIGNUM* b, int n);
		[Import(OPENSSL_LIB_CRYPTO), LinkName("BN_get_flags")]
		public extern static int get_flags(BIGNUM* b, int n);

		/* Values for |top| in BN_rand() */
		public const int RAND_TOP_ANY = -1;
		public const int RAND_TOP_ONE = 0;
		public const int RAND_TOP_TWO = 1;

		/* Values for |bottom| in BN_rand() */
		public const int RAND_BOTTOM_ANY = 0;
		public const int RAND_BOTTOM_ODD = 1;
		
		/*
		 * get a clone of a BIGNUM with changed flags, for *temporary* use only (the
		 * two BIGNUMs cannot be used in parallel!). Also only for *read only* use. The
		 * value |dest| should be a newly allocated BIGNUM obtained via BN_new() that
		 * has not been otherwise initialised or used.
		 */
		[Import(OPENSSL_LIB_CRYPTO), LinkName("BN_with_flags")]
		public extern static void with_flags(BIGNUM* dest, BIGNUM* b, int flags);

		/* Wrapper function to make using BN_GENCB easier */
		[Import(OPENSSL_LIB_CRYPTO), LinkName("BN_get_flags")]
		public extern static int BN_GENCB_call(GENCB* cb, int a, int b);

		[Import(OPENSSL_LIB_CRYPTO), LinkName("BN_GENCB_new")]
		public extern static GENCB* GENCB_new();
		[Import(OPENSSL_LIB_CRYPTO), LinkName("BN_GENCB_free")]
		public extern static void GENCB_free(GENCB* cb);

		/* Populate a BN_GENCB structure with an "old"-style callback */
		[Import(OPENSSL_LIB_CRYPTO), LinkName("BN_GENCB_set_old")]
		public extern static void GENCB_set_old(GENCB* gencb, function void(int, int, void*) callback, void* cb_arg);

		/* Populate a BN_GENCB structure with a "new"-style callback */
		[Import(OPENSSL_LIB_CRYPTO), LinkName("BN_GENCB_set")]
		public extern static void GENCB_set(GENCB* gencb, function int(int, int, GENCB*) callback, void* cb_arg);

		[Import(OPENSSL_LIB_CRYPTO), LinkName("BN_GENCB_get_arg")]
		public extern static void* GENCB_get_arg(GENCB* cb);

		public const int prime_checks = 0; /* default: select number of iterations based on the size of the number */
	}
}
