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
	sealed abstract class Camellia
	{
		public const int ENCRYPT = 1;
		public const int DECRYPT = 0;

		/*
		 * Because array size can't be a const in C, the following two are macros.
		 * Both sizes are in bytes.
		 */

		/* This should be a hidden type, but EVP requires that the size be known */

		public const int BLOCK_SIZE     = 16;
		public const int TABLE_BYTE_LEN = 272;
		public const int TABLE_WORD_LEN = TABLE_BYTE_LEN / 4;

		public typealias KEY_TABLE_TYPE = uint[272 / 4/*TABLE_WORD_LEN*/]; /* to match with WORD */

		[CRepr]
		public struct key_st {
		    public u_struct u;
		    public int grand_rounds;

			[CRepr, Union]
			public struct u_struct
			{
				public double d; /* ensures 64-bit align */
				public KEY_TABLE_TYPE rd_key;
			}
		}
		public typealias KEY = key_st;

		[Import(OPENSSL_LIB_CRYPTO), LinkName("Camellia_set_key")]
		public extern static int set_key(uint8* userKey, int bits, KEY* key);

		[Import(OPENSSL_LIB_CRYPTO), LinkName("Camellia_encrypt")]
		public extern static void encrypt(uint8* inVal, uint8* outVal, KEY* key);
		[Import(OPENSSL_LIB_CRYPTO), LinkName("Camellia_decrypt")]
		public extern static void decrypt(uint8* inVal, uint8* outVal, KEY* key);

		[Import(OPENSSL_LIB_CRYPTO), LinkName("Camellia_ecb_encrypt")]
		public extern static void ecb_encrypt(uint8* inVal, uint8* outVal, KEY* key, int enc);
		[Import(OPENSSL_LIB_CRYPTO), LinkName("Camellia_cbc_encrypt")]
		public extern static void cbc_encrypt(uint8* inVal, uint8* outVal, uint length, KEY* key, uint8* ivec, int enc);
		[Import(OPENSSL_LIB_CRYPTO), LinkName("Camellia_cfb128_encrypt")]
		public extern static void cfb128_encrypt(uint8* inVal, uint8* outVal, uint length, KEY* key, uint8* ivec, int* num, int enc);
		[Import(OPENSSL_LIB_CRYPTO), LinkName("Camellia_cfb1_encrypt")]
		public extern static void cfb1_encrypt(uint8* inVal, uint8* outVal, uint length, KEY* key, uint8* ivec, int* num, int enc);
		[Import(OPENSSL_LIB_CRYPTO), LinkName("Camellia_cfb8_encrypt")]
		public extern static void cfb8_encrypt(uint8* inVal, uint8* outVal, uint length, KEY* key, uint8* ivec, int* num, int enc);
		[Import(OPENSSL_LIB_CRYPTO), LinkName("Camellia_ofb128_encrypt")]
		public extern static void ofb128_encrypt(uint8* inVal, uint8* outVal, uint length, KEY* key, uint8* ivec, int* num);
		[Import(OPENSSL_LIB_CRYPTO), LinkName("Camellia_ctr128_encrypt")]
		public extern static void ctr128_encrypt(uint8* inVal, uint8* outVal, uint length, KEY* key, uint8[BLOCK_SIZE] ivec, uint8[BLOCK_SIZE] ecount_buf, uint* num);
	}
}
