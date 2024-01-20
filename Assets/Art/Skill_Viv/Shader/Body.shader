// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Whl/Viv/Body"
{
	Properties
	{
		_MainTex("MainTex", 2D) = "white" {}
		_NormalTex("NormalTex", 2D) = "bump" {}
		_BaseColor("BaseColor", Color) = (1,1,1,1)
		_ShaowColor("ShaowColor", Color) = (0,0,0,0)
		_Power("Power", Float) = 7
		_Mul("Mul", Float) = 20
		_ShdowIntensity("ShdowIntensity", Range( 0 , 1)) = 1
		_EmissionTex("EmissionTex", 2D) = "white" {}
		_ScanTex("ScanTex", 2D) = "black" {}
		_ScanTexPanner("ScanTexPanner", Vector) = (0,0,0,0)
		_ScanColor("ScanColor", Color) = (0.990566,0.990566,0.990566,1)
		_ScanIntensity("ScanIntensity", Range( 0 , 1)) = 1
		_BodyBaseEmiss("BodyBaseEmiss", Float) = 1
		_AnimaBodyEmissionIntensity("AnimaBodyEmissionIntensity", Range( 0 , 1)) = 1
		[Toggle(_FREONEMINUS_ON)] _FreOneMinus("FreOneMinus", Float) = 0
		[HDR]_EmissionColor("EmissionColor", Color) = (1,1,1,1)
		_Fre("Fre", Vector) = (0,1.1,1.1,0)
		_FreIntensity("FreIntensity", Float) = 1
		_MatCapTex("MatCapTex", 2D) = "black" {}
		_MatCapIntensity("MatCapIntensity", Range( 0 , 1)) = 1
		_SmoothTex("SmoothTex", 2D) = "white" {}
		_SmoothnessMaxMin("SmoothnessMaxMin", Vector) = (0.95,0.01,0,0)
		_Smoothness("Smoothness", Range( 0 , 1)) = 1
		_ReflectIntensity("ReflectIntensity", Range( 0 , 1)) = 0.5
		[Header(EdgeColor)]_NormalOffset("NormalOffset", Range( 0 , 1)) = 0.01
		_MaxDistance("MaxDistance", Range( 0 , 1)) = 0.3
		[HDR]_EdgeFresnelColor("EdgeFresnelColor", Color) = (1,1,1,1)
		_FresnelBias("FresnelBias", Range( 0 , 1)) = 0
		_FresnelScale("FresnelScale", Range( 0 , 10)) = 1
		_FresnelPower("FresnelPower", Range( 0 , 10)) = 5
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _FREONEMINUS_ON
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
			float2 uv2_texcoord2;
			float eyeDepth;
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform sampler2D _EmissionTex;
		uniform float4 _EmissionTex_ST;
		uniform float3 _Fre;
		uniform float _FreIntensity;
		uniform float4 _EmissionColor;
		uniform sampler2D _ScanTex;
		uniform float3 _ScanTexPanner;
		uniform float4 _ScanTex_ST;
		uniform float4 _ScanColor;
		uniform float _ScanIntensity;
		uniform float _AnimaBodyEmissionIntensity;
		uniform float _BodyBaseEmiss;
		uniform float4 _ShaowColor;
		uniform float4 _BaseColor;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform sampler2D _NormalTex;
		uniform float4 _NormalTex_ST;
		uniform float _Power;
		uniform float _Mul;
		uniform float _ShdowIntensity;
		uniform float2 _SmoothnessMaxMin;
		uniform sampler2D _SmoothTex;
		uniform float4 _SmoothTex_ST;
		uniform float _Smoothness;
		uniform sampler2D _MatCapTex;
		uniform float _MatCapIntensity;
		uniform float _ReflectIntensity;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _NormalOffset;
		uniform float _MaxDistance;
		uniform float4 _EdgeFresnelColor;
		uniform float _FresnelBias;
		uniform float _FresnelScale;
		uniform float _FresnelPower;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			o.eyeDepth = -UnityObjectToViewPos( v.vertex.xyz ).z;
		}

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			#ifdef UNITY_PASS_FORWARDBASE
			float ase_lightAtten = data.atten;
			if( _LightColor0.a == 0)
			ase_lightAtten = 0;
			#else
			float3 ase_lightAttenRGB = gi.light.color / ( ( _LightColor0.rgb ) + 0.000001 );
			float ase_lightAtten = max( max( ase_lightAttenRGB.r, ase_lightAttenRGB.g ), ase_lightAttenRGB.b );
			#endif
			#if defined(HANDLE_SHADOWS_BLENDING_IN_GI)
			half bakedAtten = UnitySampleBakedOcclusion(data.lightmapUV.xy, data.worldPos);
			float zDist = dot(_WorldSpaceCameraPos - data.worldPos, UNITY_MATRIX_V[2].xyz);
			float fadeDist = UnityComputeShadowFadeDistance(data.worldPos, zDist);
			ase_lightAtten = UnityMixRealtimeAndBakedShadows(data.atten, bakedAtten, UnityComputeShadowFade(fadeDist));
			#endif
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 BaseColor53 = ( _BaseColor * tex2D( _MainTex, uv_MainTex ) );
			float4 ShaowColor58 = ( _ShaowColor * BaseColor53 );
			float4 blendOpSrc68 = ShaowColor58;
			float4 blendOpDest68 = BaseColor53;
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float3 temp_output_91_0 = ( ase_lightAtten * ase_lightColor.rgb );
			float3 break92 = temp_output_91_0;
			float LightAtten95 = max( max( break92.x , break92.y ) , break92.z );
			float2 uv_NormalTex = i.uv_texcoord * _NormalTex_ST.xy + _NormalTex_ST.zw;
			float3 WorldNormal101 = normalize( (WorldNormalVector( i , UnpackNormal( tex2D( _NormalTex, uv_NormalTex ) ) )) );
			float3 ase_worldPos = i.worldPos;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float dotResult5_g1 = dot( WorldNormal101 , ase_worldlightDir );
			float4 lerpBlendMode68 = lerp(blendOpDest68,( blendOpSrc68 * blendOpDest68 ),( ( 1.0 - saturate( ( LightAtten95 * ( pow( (dotResult5_g1*0.5 + 0.5) , _Power ) * _Mul ) ) ) ) * _ShdowIntensity ));
			float2 uv_EmissionTex = i.uv_texcoord * _EmissionTex_ST.xy + _EmissionTex_ST.zw;
			float4 tex2DNode5 = tex2D( _EmissionTex, uv_EmissionTex );
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float fresnelNdotV15 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode15 = ( _Fre.x + _Fre.y * pow( 1.0 - fresnelNdotV15, _Fre.z ) );
			float temp_output_108_0 = saturate( fresnelNode15 );
			#ifdef _FREONEMINUS_ON
				float staticSwitch123 = ( 1.0 - temp_output_108_0 );
			#else
				float staticSwitch123 = temp_output_108_0;
			#endif
			float mulTime116 = _Time.y * _ScanTexPanner.z;
			float2 appendResult114 = (float2(_ScanTexPanner.x , _ScanTexPanner.y));
			float2 uv2_ScanTex = i.uv2_texcoord2 * _ScanTex_ST.xy + _ScanTex_ST.zw;
			float2 panner39 = ( mulTime116 * appendResult114 + uv2_ScanTex);
			float4 ScanColor105 = saturate( ( tex2D( _ScanTex, panner39 ).r * _ScanColor * _ScanIntensity * tex2DNode5.r ) );
			float4 EmissionColor117 = ( ( ( ( tex2DNode5 * ( saturate( staticSwitch123 ) * _FreIntensity ) ) * _EmissionColor ) + ScanColor105 ) * _AnimaBodyEmissionIntensity * _BodyBaseEmiss );
			float3 indirectNormal128 = WorldNormal101;
			float2 uv_SmoothTex = i.uv_texcoord * _SmoothTex_ST.xy + _SmoothTex_ST.zw;
			float Smoothness170 = ( tex2D( _SmoothTex, uv_SmoothTex ).r * _Smoothness );
			float lerpResult144 = lerp( _SmoothnessMaxMin.y , _SmoothnessMaxMin.x , Smoothness170);
			Unity_GlossyEnvironmentData g128 = UnityGlossyEnvironmentSetup( lerpResult144, data.worldViewDir, indirectNormal128, float3(0,0,0));
			float3 indirectSpecular128 = UnityGI_IndirectSpecular( data, 1.0, indirectNormal128, g128 );
			UnityGI gi139 = gi;
			float3 diffNorm139 = WorldNormal101;
			gi139 = UnityGI_Base( data, 1, diffNorm139 );
			float3 indirectDiffuse139 = gi139.indirect.diffuse + diffNorm139 * 0.0001;
			float2 MatCapUV197 = ( ( (mul( UNITY_MATRIX_V, float4( ase_worldNormal , 0.0 ) ).xyz).xy + 1.0 ) * 0.5 );
			float4 _Vector3 = float4(0.5,0.5,0.5,1);
			float2 appendResult210 = (float2(_Vector3.x , _Vector3.y));
			float2 appendResult209 = (float2(_Vector3.z , _Vector3.w));
			float4 _Vector2 = float4(0.5,0.5,0,1);
			float2 appendResult203 = (float2(_Vector2.x , _Vector2.y));
			float2 appendResult202 = (float2(_Vector2.z , _Vector2.w));
			float4 lerpResult217 = lerp( tex2D( _MatCapTex, ( ( MatCapUV197 * appendResult210 ) + appendResult209 ) ) , tex2D( _MatCapTex, ( ( MatCapUV197 * appendResult203 ) + appendResult202 ) ) , Smoothness170);
			float4 _Vector1 = float4(0.5,0.5,0.5,0.5);
			float2 appendResult189 = (float2(_Vector1.x , _Vector1.y));
			float2 appendResult188 = (float2(_Vector1.z , _Vector1.w));
			float4 lerpResult216 = lerp( lerpResult217 , tex2D( _MatCapTex, ( ( MatCapUV197 * appendResult189 ) + appendResult188 ) ) , Smoothness170);
			float4 _Vector0 = float4(0.5,0.5,0,0.5);
			float2 appendResult182 = (float2(_Vector0.x , _Vector0.y));
			float2 appendResult183 = (float2(_Vector0.z , _Vector0.w));
			float4 lerpResult218 = lerp( lerpResult216 , tex2D( _MatCapTex, ( ( MatCapUV197 * appendResult182 ) + appendResult183 ) ) , Smoothness170);
			float4 MatCap32 = lerpResult218;
			float4 ReflectColor130 = ( ( float4( ( indirectSpecular128 * indirectDiffuse139 ) , 0.0 ) + ( MatCap32 * _MatCapIntensity ) ) * _ReflectIntensity );
			float3 ase_vertexNormal = mul( unity_WorldToObject, float4( ase_worldNormal, 0 ) );
			ase_vertexNormal = normalize( ase_vertexNormal );
			float3 objToViewDir255 = mul( UNITY_MATRIX_IT_MV, float4( ase_vertexNormal, 0 ) ).xyz;
			float2 appendResult265 = (float2(objToViewDir255.xy));
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float3 objToView257 = mul( UNITY_MATRIX_MV, float4( ase_vertex3Pos, 1 ) ).xyz;
			float2 appendResult246 = (float2(objToView257.xy));
			float3 appendResult259 = (float3(( ( _NormalOffset * appendResult265 ) + appendResult246 ) , objToView257.z));
			float4 appendResult232 = (float4(appendResult259 , 1.0));
			float4 computeScreenPos243 = ComputeScreenPos( mul( UNITY_MATRIX_P, appendResult232 ) );
			computeScreenPos243 = computeScreenPos243 / computeScreenPos243.w;
			computeScreenPos243.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? computeScreenPos243.z : computeScreenPos243.z* 0.5 + 0.5;
			float eyeDepth234 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, computeScreenPos243.xy ));
			float MaxDistance251 = _MaxDistance;
			float clampResult271 = clamp( (0.0 + (min( ( eyeDepth234 - i.eyeDepth ) , MaxDistance251 ) - 0.0) * (1.0 - 0.0) / (MaxDistance251 - 0.0)) , 0.0 , 1.0 );
			float3 appendResult261 = (float3(_EdgeFresnelColor.rgb));
			float fresnelNdotV235 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode235 = ( _FresnelBias + _FresnelScale * pow( 1.0 - fresnelNdotV235, _FresnelPower ) );
			float clampResult270 = clamp( fresnelNode235 , 0.0 , 1.0 );
			float4 EdgeColor268 = ( clampResult271 * ( float4( appendResult261 , 0.0 ) * clampResult270 * BaseColor53 ) );
			float3 temp_cast_8 = (1.0).xxx;
			#ifdef UNITY_PASS_FORWARDBASE
				float3 staticSwitch97 = temp_cast_8;
			#else
				float3 staticSwitch97 = temp_output_91_0;
			#endif
			float3 LightColor98 = staticSwitch97;
			float4 FinalBaseColor83 = ( saturate( ( ( saturate( lerpBlendMode68 )) + EmissionColor117 + ReflectColor130 + EdgeColor268 ) ) * float4( LightColor98 , 0.0 ) );
			c.rgb = saturate( FinalBaseColor83 ).rgb;
			c.a = 1;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
			o.Normal = float3(0,0,1);
			float2 uv_EmissionTex = i.uv_texcoord * _EmissionTex_ST.xy + _EmissionTex_ST.zw;
			float4 tex2DNode5 = tex2D( _EmissionTex, uv_EmissionTex );
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float fresnelNdotV15 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode15 = ( _Fre.x + _Fre.y * pow( 1.0 - fresnelNdotV15, _Fre.z ) );
			float temp_output_108_0 = saturate( fresnelNode15 );
			#ifdef _FREONEMINUS_ON
				float staticSwitch123 = ( 1.0 - temp_output_108_0 );
			#else
				float staticSwitch123 = temp_output_108_0;
			#endif
			float mulTime116 = _Time.y * _ScanTexPanner.z;
			float2 appendResult114 = (float2(_ScanTexPanner.x , _ScanTexPanner.y));
			float2 uv2_ScanTex = i.uv2_texcoord2 * _ScanTex_ST.xy + _ScanTex_ST.zw;
			float2 panner39 = ( mulTime116 * appendResult114 + uv2_ScanTex);
			float4 ScanColor105 = saturate( ( tex2D( _ScanTex, panner39 ).r * _ScanColor * _ScanIntensity * tex2DNode5.r ) );
			float4 EmissionColor117 = ( ( ( ( tex2DNode5 * ( saturate( staticSwitch123 ) * _FreIntensity ) ) * _EmissionColor ) + ScanColor105 ) * _AnimaBodyEmissionIntensity * _BodyBaseEmiss );
			o.Emission = EmissionColor117.rgb;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float4 customPack1 : TEXCOORD1;
				float1 customPack2 : TEXCOORD2;
				float4 tSpace0 : TEXCOORD3;
				float4 tSpace1 : TEXCOORD4;
				float4 tSpace2 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.customPack1.zw = customInputData.uv2_texcoord2;
				o.customPack1.zw = v.texcoord1;
				o.customPack2.x = customInputData.eyeDepth;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				surfIN.uv2_texcoord2 = IN.customPack1.zw;
				surfIN.eyeDepth = IN.customPack2.x;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
76;504;1373.6;883.8;4425.327;-5449.758;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;22;-8170.711,1970.056;Inherit;False;3247.732;1985.19;MatCap;42;190;189;188;181;182;183;186;31;185;32;184;24;30;29;28;27;26;25;23;197;198;199;200;201;202;203;204;205;206;207;208;209;210;211;212;213;214;215;216;217;218;221;MatCap;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldNormalVector;24;-8054.542,2175.871;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ViewMatrixNode;23;-7971.788,2045.263;Inherit;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;-7780.788,2108.262;Inherit;False;2;2;0;FLOAT4x4;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-7561.76,2217.476;Inherit;False;Constant;_Float1;Float 1;1;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;267;-5889.524,5005.832;Inherit;False;3596.143;1815.724;Comment;40;270;235;244;240;249;237;260;241;239;247;264;236;268;238;271;248;261;256;231;263;242;233;251;234;245;243;258;250;232;262;259;252;246;266;254;257;265;255;253;230;EdgeColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.SwizzleNode;27;-7599.831,2096.178;Inherit;False;FLOAT2;0;1;2;3;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-7435.76,2290.476;Inherit;False;Constant;_Float2;Float 2;1;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;29;-7386.76,2097.476;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.NormalVertexDataNode;230;-5762.499,5360.027;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-7245.76,2101.476;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TransformDirectionNode;255;-5543.299,5354.227;Inherit;False;Object;View;False;Fast;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.PosVertexDataNode;253;-5795.524,5580.164;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;265;-5309.151,5357.268;Inherit;False;FLOAT2;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TransformPositionNode;257;-5575.587,5577.605;Inherit;False;Object;View;False;Fast;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;197;-7081.096,2099.969;Inherit;False;MatCapUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;254;-5432.871,5222.008;Inherit;False;Property;_NormalOffset;NormalOffset;25;1;[Header];Create;True;1;EdgeColor;0;0;False;0;False;0.01;0.004;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;204;-6980.525,3086.846;Inherit;False;Constant;_Vector2;Vector 2;24;0;Create;True;0;0;0;False;0;False;0.5,0.5,0,1;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;223;-4180.376,3380.967;Inherit;False;892.3916;563.8984;SmoothnessContorl;4;170;146;132;134;SmoothnessContorl;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector4Node;211;-7002.036,3533.27;Inherit;False;Constant;_Vector3;Vector 3;24;0;Create;True;0;0;0;False;0;False;0.5,0.5,0.5,1;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;213;-6762.167,3392.814;Inherit;False;197;MatCapUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;203;-6678.318,3030.154;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;246;-5295.48,5519.593;Inherit;False;FLOAT2;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;134;-4118.686,3430.967;Inherit;True;Property;_SmoothTex;SmoothTex;21;0;Create;True;0;0;0;False;0;False;-1;None;b492a5cedfb95fc44883f3f94fe31819;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;132;-4130.375,3796.862;Inherit;False;Property;_Smoothness;Smoothness;23;0;Create;True;0;0;0;False;0;False;1;0.523;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;206;-6740.657,2946.39;Inherit;False;197;MatCapUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector4Node;190;-6937.814,2657.862;Inherit;False;Constant;_Vector1;Vector 1;24;0;Create;True;0;0;0;False;0;False;0.5,0.5,0.5,0.5;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;210;-6699.829,3476.578;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;266;-5095.296,5286.137;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;212;-6526.199,3397.36;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;205;-6504.689,2950.936;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;146;-3735.04,3685.394;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;189;-6635.607,2601.17;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;104;-6047.013,-165.9748;Inherit;False;2288.386;1880.856;EmissionColor;3;60;40;115;EmissionColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector3Node;14;-5994.04,723.4124;Inherit;False;Property;_Fre;Fre;17;0;Create;True;0;0;0;False;0;False;0,1.1,1.1;0,1.1,1.1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;202;-6678.774,3192.124;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector4Node;181;-6927.632,2232.558;Inherit;False;Constant;_Vector0;Vector 0;24;0;Create;True;0;0;0;False;0;False;0.5,0.5,0,0.5;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;209;-6700.284,3638.548;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;252;-5006.538,5436.742;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;201;-6697.946,2517.406;Inherit;False;197;MatCapUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector3Node;115;-6030.112,51.97414;Inherit;False;Property;_ScanTexPanner;ScanTexPanner;10;0;Create;True;0;0;0;False;0;False;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.LightAttenuation;90;-3039.09,-991.843;Inherit;True;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;199;-6461.978,2521.952;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FresnelNode;15;-5820.342,718.7601;Inherit;True;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;182;-6625.426,2175.866;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;207;-6302.898,2954.237;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;214;-6324.408,3400.661;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;259;-4878.998,5536.252;Inherit;False;FLOAT3;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;198;-6666.096,2087.969;Inherit;False;197;MatCapUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;170;-3521.457,3682.521;Inherit;False;Smoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;89;-3022.802,-786.9834;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.DynamicAppendNode;188;-6636.063,2763.14;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;155;-7430.853,-1250.468;Inherit;True;Property;_NormalTex;NormalTex;2;0;Create;True;0;0;0;False;0;False;-1;None;415c452ee3870d64781d7a5dd1ef6bf1;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ProjectionMatrixNode;262;-4730.427,5303.914;Inherit;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.DynamicAppendNode;114;-5839.112,19.97413;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;116;-5853.112,122.974;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;232;-4721.216,5427.825;Inherit;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;221;-5993.324,3673.291;Inherit;False;170;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;91;-2769.348,-921.298;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;38;-5997.013,-115.9747;Inherit;False;1;40;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;208;-6056.354,2910.665;Inherit;True;Property;_TextureSample1;Texture Sample 1;19;0;Create;True;0;0;0;False;0;False;-1;None;ab0f21a74fec8694fbf6290094566ae5;True;0;False;black;Auto;False;Instance;31;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;215;-6087.007,3360.136;Inherit;True;Property;_TextureSample2;Texture Sample 2;19;0;Create;True;0;0;0;False;0;False;-1;None;ab0f21a74fec8694fbf6290094566ae5;True;0;False;black;Auto;False;Instance;31;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;108;-5485.616,723.7565;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;100;-7093.847,-1247.895;Inherit;False;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;200;-6260.187,2525.253;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;183;-6625.88,2337.836;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;184;-6452.476,2096.363;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;39;-5660.449,-47.78374;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0.1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;101;-6872.088,-1251.272;Inherit;False;WorldNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;92;-2455.746,-902.3379;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.OneMinusNode;122;-5278.315,864.7269;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;186;-6044.121,2472.536;Inherit;True;Property;_TextureSample0;Texture Sample 0;19;0;Create;True;0;0;0;False;0;False;-1;None;ab0f21a74fec8694fbf6290094566ae5;True;0;False;black;Auto;False;Instance;31;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;185;-6249.384,2124.364;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;217;-5604.57,3142.13;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;250;-4561.887,5306.156;Inherit;False;2;2;0;FLOAT4x4;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;43;-5711.99,420.3527;Inherit;False;0;5;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;123;-5159.417,727.0103;Inherit;False;Property;_FreOneMinus;FreOneMinus;15;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;216;-5545.983,2615.652;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;129;-4259.677,1959.992;Inherit;False;2446.695;1310.092;ReflectColor;6;130;222;145;177;225;226;ReflectColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;5;-5414.381,396.1991;Inherit;True;Property;_EmissionTex;EmissionTex;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;80;-3591.907,702.7513;Inherit;False;101;WorldNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;40;-5419.708,-70.59331;Inherit;True;Property;_ScanTex;ScanTex;9;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;31;-5987.836,2072.69;Inherit;True;Property;_MatCapTex;MatCapTex;19;0;Create;True;0;0;0;False;0;False;-1;None;830ea0c925997fc4da6d2e15fdc7cc21;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComputeScreenPosHlpNode;243;-4336.107,5439.986;Inherit;False;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;258;-4124.04,5073.756;Inherit;False;Property;_MaxDistance;MaxDistance;26;0;Create;True;0;0;0;False;0;False;0.3;0.095;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;93;-2215.842,-923.4449;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;142;-5338.242,120.9131;Inherit;False;Property;_ScanColor;ScanColor;11;0;Create;True;0;0;0;False;0;False;0.990566,0.990566,0.990566,1;0.990566,0.990566,0.990566,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;60;-5366.947,294.9044;Inherit;False;Property;_ScanIntensity;ScanIntensity;12;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;158;-4470.683,-970.8218;Inherit;False;0;51;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;218;-5491.533,2163.785;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;127;-5059.109,847.3156;Inherit;False;Property;_FreIntensity;FreIntensity;18;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;50;-4171.95,-1184.171;Inherit;False;Property;_BaseColor;BaseColor;3;0;Create;True;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;141;-4941.449,-36.53507;Inherit;False;4;4;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;145;-4069.396,2185.512;Inherit;False;Property;_SmoothnessMaxMin;SmoothnessMaxMin;22;0;Create;True;0;0;0;False;0;False;0.95,0.01;0.95,0.01;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;224;-3872.764,2354.94;Inherit;False;170;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;112;-4938.333,747.4464;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;78;-3335.907,958.751;Inherit;False;Property;_Power;Power;5;0;Create;True;0;0;0;False;0;False;7;7;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SurfaceDepthNode;245;-4070.152,5208.038;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenDepthNode;234;-4068.881,5438.42;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;51;-4211.578,-1000.09;Inherit;True;Property;_MainTex;MainTex;1;0;Create;True;0;0;0;False;0;False;-1;None;3a94b45a71d3a194489fbeb6a785c1b0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;79;-3351.907,718.7513;Inherit;False;Half Lambert Term;-1;;1;86299dc21373a954aa5772333626c9c1;0;1;3;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;251;-3803.429,5077.656;Inherit;False;MaxDistance;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;94;-2060.894,-891.1288;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;249;-4125.229,6426.756;Inherit;False;Property;_FresnelPower;FresnelPower;30;0;Create;True;0;0;0;False;0;False;5;5;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;240;-4085.992,6257.918;Inherit;False;Property;_FresnelBias;FresnelBias;28;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;244;-4108.583,6338.77;Inherit;False;Property;_FresnelScale;FresnelScale;29;0;Create;True;0;0;0;False;0;False;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;46;-4607.456,-1293.745;Inherit;False;1309.754;677.8403;BaseColor;1;53;BaseColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.SaturateNode;111;-4722.433,-35.74126;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;149;-3488.032,2485.19;Inherit;False;101;WorldNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;144;-3620.763,2215.573;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;107;-3795.53,-1112.702;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;126;-4790.109,733.1475;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;76;-3079.907,734.7513;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;95;-1799.953,-889.3629;Inherit;False;LightAtten;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;32;-5171.013,2061.303;Inherit;True;MatCap;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;242;-3796.246,5627.556;Inherit;False;251;MaxDistance;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;131;-3815.89,2148.534;Inherit;False;101;WorldNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;233;-3722.859,5434.755;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;77;-3063.907,990.751;Inherit;False;Property;_Mul;Mul;6;0;Create;True;0;0;0;False;0;False;20;20;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;53;-3536.936,-1130.236;Inherit;False;BaseColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FresnelNode;235;-3760.203,6272.678;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;19;-4788.163,929.8734;Inherit;False;Property;_EmissionColor;EmissionColor;16;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;0,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;105;-4503.055,-46.75254;Inherit;False;ScanColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;125;-4666.123,696.1354;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMinOpNode;263;-3565.906,5574.322;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.IndirectSpecularLight;128;-3356.083,2152.487;Inherit;True;World;3;0;FLOAT3;0,0,1;False;1;FLOAT;0.5;False;2;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;74;-2837.009,593.8522;Inherit;False;95;LightAtten;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;226;-2884.711,2720.444;Inherit;False;Property;_MatCapIntensity;MatCapIntensity;20;0;Create;True;0;0;0;False;0;False;1;0.1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.IndirectDiffuseLighting;139;-3261.07,2490.502;Inherit;True;World;1;0;FLOAT3;0,0,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;222;-2808.115,2605.318;Inherit;False;32;MatCap;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;75;-2832.214,794.1385;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;231;-3883.769,5754.68;Inherit;False;Property;_EdgeFresnelColor;EdgeFresnelColor;27;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;270;-3461.455,6261.353;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;272;-3693.327,5982.758;Inherit;False;53;BaseColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;56;-5872.912,-1085.533;Inherit;False;53;BaseColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-4407.259,701.0916;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;147;-4628.396,1086.378;Inherit;False;105;ScanColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;179;-2640.018,2190.578;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;261;-3642.515,5758.408;Inherit;False;FLOAT3;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;55;-5901.684,-1260.277;Inherit;False;Property;_ShaowColor;ShaowColor;4;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.7924528,0.4739765,0.4739765,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;73;-2567.906,590.7523;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;256;-3406.626,5582.797;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;225;-2574.711,2611.444;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;166;-2440.038,2189.964;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;271;-3179.85,5610.498;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;163;-4151.191,696.3751;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;42;-4357.877,902.812;Inherit;False;Property;_AnimaBodyEmissionIntensity;AnimaBodyEmissionIntensity;14;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;180;-4286.639,977.4862;Inherit;False;Property;_BodyBaseEmiss;BodyBaseEmiss;13;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;248;-3261.843,5804.291;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;72;-2343.906,542.7523;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;57;-5385.955,-1157.094;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;177;-2515.86,2395.048;Inherit;False;Property;_ReflectIntensity;ReflectIntensity;24;0;Create;True;0;0;0;False;0;False;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;70;-2297.478,779.7144;Inherit;False;Property;_ShdowIntensity;ShdowIntensity;7;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;71;-2151.906,542.7523;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;238;-3004.44,5671.763;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;164;-4014.171,699.9398;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;58;-5080.127,-1165.52;Inherit;False;ShaowColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;176;-2238.11,2181.773;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;130;-2069.837,2162.519;Inherit;True;ReflectColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;62;-2775.326,316.6824;Inherit;True;53;BaseColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;96;-2608.741,-1157.397;Inherit;False;Constant;_Float3;Float 3;1;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;69;-1979.362,538.3563;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;117;-3854.791,693.9714;Inherit;False;EmissionColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;63;-2764.379,-9.981637;Inherit;True;58;ShaowColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;59;-3633.901,-130.2669;Inherit;False;4797.417;1871.557;FinalBaseColor;1;269;FinalBaseColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;268;-2769.893,5671.476;Inherit;False;EdgeColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;133;-1721.577,814.5628;Inherit;True;130;ReflectColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;118;-1722.714,601.3143;Inherit;True;117;EmissionColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;269;-1402.868,906.9586;Inherit;True;268;EdgeColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;97;-2367.162,-1175.952;Inherit;True;Property;_Keyword0;Keyword 0;1;0;Create;True;0;0;0;False;0;False;0;0;0;False;UNITY_PASS_FORWARDBASE;Toggle;2;Key0;Key1;Fetch;True;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BlendOpsNode;68;-1752.812,379.1592;Inherit;True;Multiply;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;98;-2012.144,-1179.071;Inherit;False;LightColor;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;120;-1172.133,410.0091;Inherit;True;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;84;-56.52671,597.2303;Inherit;False;98;LightColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;121;-731.2781,381.995;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;82;151.5724,381.2316;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;83;393.3905,372.3451;Inherit;False;FinalBaseColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;106;1426.356,468.392;Inherit;False;83;FinalBaseColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;124;-4142.784,1132.127;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;102;-7080.18,-1052.774;Inherit;False;World;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TransformPositionNode;236;-4574.882,5646.031;Inherit;False;View;Object;False;Fast;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.PosVertexDataNode;264;-4383.363,5055.832;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;247;-3431.895,5235.424;Inherit;False;Property;_DebugEyeDepth;DebugEyeDepth;0;0;Create;True;0;0;0;False;0;False;0;0;0;True;;KeywordEnum;2;Surf;DepthTexture;Create;True;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;157;1694.652,291.1699;Inherit;False;117;EmissionColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;160;-3826.333,-885.1266;Inherit;False;-1;;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GammaToLinearNode;237;-3651.689,5177.354;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;159;-5092.257,621.7916;Inherit;False;-1;;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.SaturateNode;45;1698.149,473.3283;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GammaToLinearNode;260;-3660.195,5315.478;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;241;-3160.504,5230.761;Inherit;False;DebugEyeDepth;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;239;-3121.493,5423.275;Inherit;False;241;DebugEyeDepth;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;103;-6868.047,-1049.434;Inherit;False;ViewDir;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2112.254,254.9896;Float;False;True;-1;2;ASEMaterialInspector;0;0;CustomLighting;Whl/Viv/Body;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;88;-3089.09,-1282.639;Inherit;False;1525.385;680.1929;LightAtten;0;LightAtten;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;99;-7132.129,-1309.384;Inherit;False;504.303;432.5138;WorldNormal&ViewDir;0;WorldNormal&ViewDir;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;54;-6013.684,-1308.276;Inherit;False;1181.666;633.2292;ShaowColor;0;ShaowColor;1,1,1,1;0;0
WireConnection;25;0;23;0
WireConnection;25;1;24;0
WireConnection;27;0;25;0
WireConnection;29;0;27;0
WireConnection;29;1;26;0
WireConnection;30;0;29;0
WireConnection;30;1;28;0
WireConnection;255;0;230;0
WireConnection;265;0;255;0
WireConnection;257;0;253;0
WireConnection;197;0;30;0
WireConnection;203;0;204;1
WireConnection;203;1;204;2
WireConnection;246;0;257;0
WireConnection;210;0;211;1
WireConnection;210;1;211;2
WireConnection;266;0;254;0
WireConnection;266;1;265;0
WireConnection;212;0;213;0
WireConnection;212;1;210;0
WireConnection;205;0;206;0
WireConnection;205;1;203;0
WireConnection;146;0;134;1
WireConnection;146;1;132;0
WireConnection;189;0;190;1
WireConnection;189;1;190;2
WireConnection;202;0;204;3
WireConnection;202;1;204;4
WireConnection;209;0;211;3
WireConnection;209;1;211;4
WireConnection;252;0;266;0
WireConnection;252;1;246;0
WireConnection;199;0;201;0
WireConnection;199;1;189;0
WireConnection;15;1;14;1
WireConnection;15;2;14;2
WireConnection;15;3;14;3
WireConnection;182;0;181;1
WireConnection;182;1;181;2
WireConnection;207;0;205;0
WireConnection;207;1;202;0
WireConnection;214;0;212;0
WireConnection;214;1;209;0
WireConnection;259;0;252;0
WireConnection;259;2;257;3
WireConnection;170;0;146;0
WireConnection;188;0;190;3
WireConnection;188;1;190;4
WireConnection;114;0;115;1
WireConnection;114;1;115;2
WireConnection;116;0;115;3
WireConnection;232;0;259;0
WireConnection;91;0;90;0
WireConnection;91;1;89;1
WireConnection;208;1;207;0
WireConnection;215;1;214;0
WireConnection;108;0;15;0
WireConnection;100;0;155;0
WireConnection;200;0;199;0
WireConnection;200;1;188;0
WireConnection;183;0;181;3
WireConnection;183;1;181;4
WireConnection;184;0;198;0
WireConnection;184;1;182;0
WireConnection;39;0;38;0
WireConnection;39;2;114;0
WireConnection;39;1;116;0
WireConnection;101;0;100;0
WireConnection;92;0;91;0
WireConnection;122;0;108;0
WireConnection;186;1;200;0
WireConnection;185;0;184;0
WireConnection;185;1;183;0
WireConnection;217;0;215;0
WireConnection;217;1;208;0
WireConnection;217;2;221;0
WireConnection;250;0;262;0
WireConnection;250;1;232;0
WireConnection;123;1;108;0
WireConnection;123;0;122;0
WireConnection;216;0;217;0
WireConnection;216;1;186;0
WireConnection;216;2;221;0
WireConnection;5;1;43;0
WireConnection;40;1;39;0
WireConnection;31;1;185;0
WireConnection;243;0;250;0
WireConnection;93;0;92;0
WireConnection;93;1;92;1
WireConnection;218;0;216;0
WireConnection;218;1;31;0
WireConnection;218;2;221;0
WireConnection;141;0;40;1
WireConnection;141;1;142;0
WireConnection;141;2;60;0
WireConnection;141;3;5;1
WireConnection;112;0;123;0
WireConnection;234;0;243;0
WireConnection;51;1;158;0
WireConnection;79;3;80;0
WireConnection;251;0;258;0
WireConnection;94;0;93;0
WireConnection;94;1;92;2
WireConnection;111;0;141;0
WireConnection;144;0;145;2
WireConnection;144;1;145;1
WireConnection;144;2;224;0
WireConnection;107;0;50;0
WireConnection;107;1;51;0
WireConnection;126;0;112;0
WireConnection;126;1;127;0
WireConnection;76;0;79;0
WireConnection;76;1;78;0
WireConnection;95;0;94;0
WireConnection;32;0;218;0
WireConnection;233;0;234;0
WireConnection;233;1;245;0
WireConnection;53;0;107;0
WireConnection;235;1;240;0
WireConnection;235;2;244;0
WireConnection;235;3;249;0
WireConnection;105;0;111;0
WireConnection;125;0;5;0
WireConnection;125;1;126;0
WireConnection;263;0;233;0
WireConnection;263;1;242;0
WireConnection;128;0;131;0
WireConnection;128;1;144;0
WireConnection;139;0;149;0
WireConnection;75;0;76;0
WireConnection;75;1;77;0
WireConnection;270;0;235;0
WireConnection;21;0;125;0
WireConnection;21;1;19;0
WireConnection;179;0;128;0
WireConnection;179;1;139;0
WireConnection;261;0;231;0
WireConnection;73;0;74;0
WireConnection;73;1;75;0
WireConnection;256;0;263;0
WireConnection;256;2;242;0
WireConnection;225;0;222;0
WireConnection;225;1;226;0
WireConnection;166;0;179;0
WireConnection;166;1;225;0
WireConnection;271;0;256;0
WireConnection;163;0;21;0
WireConnection;163;1;147;0
WireConnection;248;0;261;0
WireConnection;248;1;270;0
WireConnection;248;2;272;0
WireConnection;72;0;73;0
WireConnection;57;0;55;0
WireConnection;57;1;56;0
WireConnection;71;0;72;0
WireConnection;238;0;271;0
WireConnection;238;1;248;0
WireConnection;164;0;163;0
WireConnection;164;1;42;0
WireConnection;164;2;180;0
WireConnection;58;0;57;0
WireConnection;176;0;166;0
WireConnection;176;1;177;0
WireConnection;130;0;176;0
WireConnection;69;0;71;0
WireConnection;69;1;70;0
WireConnection;117;0;164;0
WireConnection;268;0;238;0
WireConnection;97;1;91;0
WireConnection;97;0;96;0
WireConnection;68;0;63;0
WireConnection;68;1;62;0
WireConnection;68;2;69;0
WireConnection;98;0;97;0
WireConnection;120;0;68;0
WireConnection;120;1;118;0
WireConnection;120;2;133;0
WireConnection;120;3;269;0
WireConnection;121;0;120;0
WireConnection;82;0;121;0
WireConnection;82;1;84;0
WireConnection;83;0;82;0
WireConnection;236;0;259;0
WireConnection;247;1;237;0
WireConnection;247;0;260;0
WireConnection;237;0;245;0
WireConnection;45;0;106;0
WireConnection;260;0;234;0
WireConnection;103;0;102;0
WireConnection;0;2;157;0
WireConnection;0;13;45;0
ASEEND*/
//CHKSM=CD5CA72E23B08F4114EFE20657F4372D52BDB303