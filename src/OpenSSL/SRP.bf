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
	sealed abstract class SRP
	{
#if !OPENSSL_NO_SRP
		[CRepr]
		public struct gN_cache_st {
		    char8* b64_bn;
		    BN.BIGNUM* bn;
		}
		public typealias gN_cache = gN_cache_st;

		[CRepr]
		public struct user_pwd_st
		{
		    /* Owned by us. */
		    char8* id;
		    BN.BIGNUM* s;
		    BN.BIGNUM* v;
		    /* Not owned by us. */
		    BN.BIGNUM* g;
		    BN.BIGNUM* N;
		    /* Owned by us. */
		    char8* info;
		}
		public typealias user_pwd = user_pwd_st;

		[Import(OPENSSL_LIB_CRYPTO), LinkName("SRP_user_pwd_free")]
		public extern static void user_pwd_free(user_pwd* user_pwd);

		[CRepr]
		public struct VBASE_st {
		    user_pwd* users_pwd;
		    gN_cache* gN_cache;
			/* to simulate a user */
		    public char8* seed_key;
		    public BN.BIGNUM* default_g;
		    public BN.BIGNUM* default_N;
		}
		public typealias VBASE = VBASE_st;

		/*
		 * Internal structure storing N and g pair
		 */
		[CRepr]
		public struct gN_st {
		    char8* id;
		    BN.BIGNUM* g;
		    BN.BIGNUM* N;
		}
		public typealias gN = gN_st;

		[Import(OPENSSL_LIB_CRYPTO), LinkName("SRP_VBASE_new")]
		public extern static VBASE* VBASE_new(char8* seed_key);
		[Import(OPENSSL_LIB_CRYPTO), LinkName("SRP_VBASE_free")]
		public extern static void VBASE_free(VBASE* vb);
		[Import(OPENSSL_LIB_CRYPTO), LinkName("SRP_VBASE_init")]
		public extern static int VBASE_init(VBASE* vb, char8* verifier_file);

		/* This method ignores the configured seed and fails for an unknown user. */
		//DEPRECATEDIN_1_1_0(SRP_user_pwd *SRP_VBASE_get_by_user(SRP_VBASE *vb, char *username))
		/* NOTE: unlike in SRP_VBASE_get_by_user, caller owns the returned pointer.*/
		[Import(OPENSSL_LIB_CRYPTO), LinkName("SRP_VBASE_get1_by_user")]
		public extern static user_pwd* VBASE_get1_by_user(VBASE* vb, char8* username);

		[Import(OPENSSL_LIB_CRYPTO), LinkName("SRP_create_verifier")]
		public extern static char8* create_verifier(char8* user, char8* pass, char8** salt, char8** verifier, char8* N, char8* g);
		[Import(OPENSSL_LIB_CRYPTO), LinkName("SRP_create_verifier_BN")]
		public extern static int create_verifier_BN(char8* user, char8* pass, BN.BIGNUM** salt, BN.BIGNUM** verifier, BN.BIGNUM* N, BN.BIGNUM* g);

		public const int NO_ERROR                  = 0;
		public const int ERR_VBASE_INCOMPLETE_FILE = 1;
		public const int ERR_VBASE_BN_LIB          = 2;
		public const int ERR_OPEN_FILE             = 3;
		public const int ERR_MEMORY                = 4;

		public const int DB_srptype     = 0;
		public const int DB_srpverifier = 1;
		public const int DB_srpsalt     = 2;
		public const int DB_srpid       = 3;
		public const int DB_srpgN       = 4;
		public const int DB_srpinfo     = 5;
		public const int DB_NUMBER      = 6;

		public const char8 DB_SRP_INDEX   = 'I';
		public const char8 DB_SRP_VALID   = 'V';
		public const char8 DB_SRP_REVOKED = 'R';
		public const char8 DB_SRP_MODIF   = 'v';

		/* see srp.c */
		[Import(OPENSSL_LIB_CRYPTO), LinkName("SRP_check_known_gN_param")]
		public extern static char8* check_known_gN_param(BN.BIGNUM* g, BN.BIGNUM* N);
		[Import(OPENSSL_LIB_CRYPTO), LinkName("SRP_get_default_gN")]
		public extern static gN* get_default_gN(char8* id);

		/* server side .... */
		[Import(OPENSSL_LIB_CRYPTO), LinkName("SRP_Calc_server_key")]
		public extern static BN.BIGNUM* Calc_server_key(BN.BIGNUM* A, BN.BIGNUM* v, BN.BIGNUM* u, BN.BIGNUM* b, BN.BIGNUM* N);
		[Import(OPENSSL_LIB_CRYPTO), LinkName("SRP_Calc_B")]
		public extern static BN.BIGNUM* Calc_B(BN.BIGNUM* b, BN.BIGNUM* N, BN.BIGNUM* g, BN.BIGNUM* v);
		[Import(OPENSSL_LIB_CRYPTO), LinkName("SRP_Verify_A_mod_N")]
		public extern static int Verify_A_mod_N(BN.BIGNUM* A, BN.BIGNUM* N);
		[Import(OPENSSL_LIB_CRYPTO), LinkName("SRP_Calc_u")]
		public extern static BN.BIGNUM* Calc_u(BN.BIGNUM* A, BN.BIGNUM* B, BN.BIGNUM* N);

		/* client side .... */
		[Import(OPENSSL_LIB_CRYPTO), LinkName("SRP_Calc_x")]
		public extern static BN.BIGNUM* Calc_x(BN.BIGNUM* s, char8* user, char8* pass);
		[Import(OPENSSL_LIB_CRYPTO), LinkName("SRP_Calc_A")]
		public extern static BN.BIGNUM* Calc_A(BN.BIGNUM* a, BN.BIGNUM* N, BN.BIGNUM* g);
		[Import(OPENSSL_LIB_CRYPTO), LinkName("SRP_Calc_client_key")]
		public extern static BN.BIGNUM* Calc_client_key(BN.BIGNUM* N, BN.BIGNUM* B, BN.BIGNUM* g, BN.BIGNUM* x, BN.BIGNUM* a, BN.BIGNUM* u);
		[Import(OPENSSL_LIB_CRYPTO), LinkName("SRP_Verify_B_mod_N")]
		public extern static int Verify_B_mod_N(BN.BIGNUM* B, BN.BIGNUM* N);

		public const int MINIMAL_N = 1024;
#endif
		
		/*
		** MOVED for convenience
		** libssl-1_1.dll
		**	  26   19 00001474 SRP_Calc_A_param
		**    58   39 00002072 SSL_CTX_SRP_CTX_free
		**    59   3A 0000254A SSL_CTX_SRP_CTX_init
		**   172   AB 00001019 SSL_CTX_set_srp_cb_arg
		**   173   AC 000019A6 SSL_CTX_set_srp_client_pwd_callback
		**   174   AD 000012F3 SSL_CTX_set_srp_password
		**   175   AE 0000164A SSL_CTX_set_srp_strength
		**   176   AF 00001A19 SSL_CTX_set_srp_username
		**   177   B0 00001316 SSL_CTX_set_srp_username_callback
		**   178   B1 0000248C SSL_CTX_set_srp_verify_param_callback
		**   243   F2 000018BB SSL_SRP_CTX_free
		**   244   F3 00001BC2 SSL_SRP_CTX_init
		**   357  164 00002013 SSL_get_srp_N
		**   358  165 00002126 SSL_get_srp_g
		**   359  166 00001267 SSL_get_srp_userinfo
		**   360  167 0000247D SSL_get_srp_username
		**   446  1BD 00001D84 SSL_set_srp_server_param
		**   447  1BE 000016EF SSL_set_srp_server_param_pw
		**   458  1C9 000018FC SSL_srp_server_param_with_username
		*/
		[Import(OPENSSL_LIB_SSL), CLink]
		public extern static int SSL_SRP_CTX_init(SSL.ssl_st* s);
		[Import(OPENSSL_LIB_SSL), CLink]
		public extern static int SSL_SRP_CTX_free(SSL.ssl_st* ctx);

		[Import(OPENSSL_LIB_SSL), CLink]
		public extern static int SSL_srp_server_param_with_username(SSL.ssl_st* s, int* ad);
		[Import(OPENSSL_LIB_SSL), CLink]
		public extern static int SRP_Calc_A_param(SSL.ssl_st* s);
#if !OPENSSL_NO_SRP
		[Import(OPENSSL_LIB_SSL), CLink]
		public extern static int SSL_set_srp_server_param(SSL.ssl_st* s, BN.BIGNUM* N, BN.BIGNUM* g, BN.BIGNUM* sa, BN.BIGNUM* v, char8* info);
		[Import(OPENSSL_LIB_SSL), CLink]
		public extern static int SSL_set_srp_server_param_pw(SSL.ssl_st* s, char8* user, char8* pass, char8* grp);
		[Import(OPENSSL_LIB_SSL), CLink]
		public extern static BN.BIGNUM* SSL_get_srp_g(SSL.ssl_st* s);
		[Import(OPENSSL_LIB_SSL), CLink]
		public extern static BN.BIGNUM* SSL_get_srp_N(SSL.ssl_st* s);
		[Import(OPENSSL_LIB_SSL), CLink]
		public extern static char8* SSL_get_srp_username(SSL.ssl_st* s);
		[Import(OPENSSL_LIB_SSL), CLink]
		public extern static char8* SSL_get_srp_userinfo(SSL.ssl_st* s);
# endif

		[Import(OPENSSL_LIB_SSL), CLink]
		public extern static int SSL_CTX_SRP_CTX_init(SSL.SSL_CTX* ctx);
		[Import(OPENSSL_LIB_SSL), CLink]
		public extern static int SSL_CTX_SRP_CTX_free(SSL.SSL_CTX* ctx);

#if !OPENSSL_NO_SRP
		[Import(OPENSSL_LIB_SSL), CLink]
		public extern static int SSL_CTX_set_srp_username(SSL.SSL_CTX* ctx, char8* name);
		[Import(OPENSSL_LIB_SSL), CLink]
		public extern static int SSL_CTX_set_srp_password(SSL.SSL_CTX* ctx, char8* password);
		[Import(OPENSSL_LIB_SSL), CLink]
		public extern static int SSL_CTX_set_srp_strength(SSL.SSL_CTX* ctx, int strength);
		[Import(OPENSSL_LIB_SSL), CLink]
		public extern static int SSL_CTX_set_srp_client_pwd_callback(SSL.SSL_CTX* ctx, function char8*(SSL.ssl_st*, void*) cb);
		[Import(OPENSSL_LIB_SSL), CLink]
		public extern static int SSL_CTX_set_srp_verify_param_callback(SSL.SSL_CTX* ctx, function int(SSL.ssl_st*, void*) cb);
		[Import(OPENSSL_LIB_SSL), CLink]
		public extern static int SSL_CTX_set_srp_username_callback(SSL.SSL_CTX* ctx, function int(SSL.ssl_st*, int*, void*) cb);
		[Import(OPENSSL_LIB_SSL), CLink]
		public extern static int SSL_CTX_set_srp_cb_arg(SSL.SSL_CTX* ctx, void* arg);
# endif
	}
}
