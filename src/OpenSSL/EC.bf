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
	sealed abstract class EC
	{
#if !OPENSSL_NO_EC
#endif
	}

	[AlwaysInclude]
	sealed abstract class ECX
	{
#if !OPENSSL_NO_EC
		public const int X25519_KEYLEN = 32;
		public const int X448_KEYLEN   = 56;
		public const int ED448_KEYLEN  = 57;
		public const int MAX_KEYLEN    = ED448_KEYLEN;

		[CRepr]
		public struct key_st
		{
		    public uint8[MAX_KEYLEN] pubkey;
		    public uint8* privkey;
		}
		public typealias KEY = key_st;
#endif
	}
	
	[AlwaysInclude]
	sealed abstract class ECDH
	{
#if !OPENSSL_NO_EC
#endif
	}
	
	[AlwaysInclude]
	sealed abstract class ECDSA
	{
#if !OPENSSL_NO_EC
#endif
	}
}
