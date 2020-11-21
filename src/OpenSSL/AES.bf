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
	sealed abstract class AES
	{
		public const int ENCRYPT = 1;
		public const int DECRYPT = 0;

		/*
		 * Because array size can't be a const in C, the following two are macros.
		 * Both sizes are in bytes.
		 */
		public const int MAXNR      = 14;
		public const int BLOCK_SIZE = 16;

		/* This should be a hidden type, but EVP requires that the size be known */
		[CRepr]
		public struct key_st
		{
#if AES_LONG
			public uint[4 * (MAXNR + 1)] rd_key;
#else
			public uint32[4 * (MAXNR + 1)] rd_key;
#endif
			public int rounds;
		}
		public typealias KEY = key_st;

		[Import(OPENSSL_LIB_CRYPTO), LinkName("AES_options")]
		public extern static char8* options();

		[Import(OPENSSL_LIB_CRYPTO), LinkName("AES_set_encrypt_key")]
		public extern static int set_encrypt_key(uint8* userKey, int bits, KEY* key);
		[Import(OPENSSL_LIB_CRYPTO), LinkName("AES_set_decrypt_key")]
		public extern static int set_decrypt_key(uint8* userKey, int bits, KEY* key);

		[Import(OPENSSL_LIB_CRYPTO), LinkName("AES_encrypt")]
		public extern static void encrypt(uint8* inData, uint8* outData, KEY* key);
		[Import(OPENSSL_LIB_CRYPTO), LinkName("AES_decrypt")]
		public extern static void decrypt(uint8* inData, uint8* outData, KEY* key);

		[Import(OPENSSL_LIB_CRYPTO), LinkName("AES_ecb_encrypt")]
		public extern static void ecb_encrypt(uint8* inData, uint8* outData, KEY* key, int enc);
		[Import(OPENSSL_LIB_CRYPTO), LinkName("AES_cbc_encrypt")]
		public extern static void cbc_encrypt(uint8* inData, uint8* outData, uint length, KEY* key, uint8* ivec, int enc);
		[Import(OPENSSL_LIB_CRYPTO), LinkName("AES_cfb128_encrypt")]
		public extern static void cfb128_encrypt(uint8* inData, uint8* outData, uint length, KEY* key, uint8* ivec, int* num, int enc);
		[Import(OPENSSL_LIB_CRYPTO), LinkName("AES_cfb1_encrypt")]
		public extern static void cfb1_encrypt(uint8* inData, uint8* outData, uint length, KEY* key, uint8* ivec, int* num, int enc);
		[Import(OPENSSL_LIB_CRYPTO), LinkName("AES_cfb8_encrypt")]
		public extern static void cfb8_encrypt(uint8* inData, uint8* outData, uint length, KEY* key, uint8* ivec, int* num, int enc);
		[Import(OPENSSL_LIB_CRYPTO), LinkName("AES_ofb128_encrypt")]
		public extern static void ofb128_encrypt(uint8* inData, uint8* outData, uint length, KEY* key, uint8* ivec, int* num);
		/* NB: the IV is _two_ blocks long */
		[Import(OPENSSL_LIB_CRYPTO), LinkName("AES_ige_encrypt")]
		public extern static void ige_encrypt(uint8* inData, uint8* outData, uint length, KEY* key, uint8* ivec, int enc);
		/* NB: the IV is _four_ blocks long */
		[Import(OPENSSL_LIB_CRYPTO), LinkName("AES_bi_ige_encrypt")]
		public extern static void bi_ige_encrypt(uint8* inData, uint8* outData, uint length, KEY* key, KEY* key2, uint8* ivec, int enc);

		[Import(OPENSSL_LIB_CRYPTO), LinkName("AES_wrap_key")]
		public extern static int wrap_key(KEY* key, uint8* iv, uint8* outData, uint8* inData, uint inLen);
		[Import(OPENSSL_LIB_CRYPTO), LinkName("AES_unwrap_key")]
		public extern static int unwrap_key(KEY* key, uint8* iv, uint8* outData, uint8* inData, uint inLen);
	}
}
