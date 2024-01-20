// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASE/Char_Hair"
{
	Properties
	{
		_BaseMap("BaseMap", 2D) = "white" {}
		[HDR]_BaseColor("BaseColor", Color) = (1,1,1,1)
		_NormalMap("NormalMap", 2D) = "bump" {}
		_RoughnessAdjust("RoughnessAdjust", Range( -1 , 1)) = 0
		_AnisoMap("AnisoMap", 2D) = "gray" {}
		_AnisoMapPower("AnisoMapPower", Float) = 2.55
		_SpecColor1("SpecColor1", Color) = (1,1,1,1)
		_SpecShininess1("SpecShininess1", Range( 0 , 1)) = 0.1
		_SpecNoise1("SpecNoise1", Float) = 1
		_SpecOffset1("SpecOffset1", Float) = 0
		_SpecColor2("SpecColor2", Color) = (1,1,1,1)
		_SpecShininess2("SpecShininess2", Range( 0 , 1)) = 0.1
		_SpecNoise2("SpecNoise2", Float) = 1
		_SpecOffset2("SpecOffset2", Float) = 0
		_EnvMap("EnvMap", CUBE) = "white" {}
		_Expose("Expose", Float) = 1
		[Header(EdgeColor)]_NormalOffset("NormalOffset", Range( 0 , 1)) = 0.01
		_MaxDistance("MaxDistance", Range( 0 , 1)) = 0.3
		[HDR]_EdgeFresnelColor("EdgeFresnelColor", Color) = (1,1,1,1)
		_FresnelBias("FresnelBias", Range( 0 , 1)) = 0
		_FresnelScale("FresnelScale", Range( 0 , 10)) = 1
		_FresnelPower("FresnelPower", Range( 0 , 10)) = 5
		_MatCap("MatCap", 2D) = "black" {}
		_MatCapIntensity("MatCapIntensity", Range( 0 , 1)) = 0.2
		_MTex("MTex", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Off
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
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
			half ASEVFace : VFACE;
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

		uniform sampler2D _BaseMap;
		uniform float4 _BaseMap_ST;
		uniform float4 _BaseColor;
		uniform float4 _SpecColor1;
		uniform sampler2D _NormalMap;
		uniform float4 _NormalMap_ST;
		uniform float _SpecNoise1;
		uniform sampler2D _AnisoMap;
		uniform float4 _AnisoMap_ST;
		uniform float _SpecOffset1;
		uniform float _SpecShininess1;
		uniform float4 _SpecColor2;
		uniform float _SpecNoise2;
		uniform float _SpecOffset2;
		uniform float _SpecShininess2;
		uniform samplerCUBE _EnvMap;
		uniform float _RoughnessAdjust;
		uniform float _Expose;
		uniform float _AnisoMapPower;
		uniform sampler2D _MTex;
		uniform float4 _MTex_ST;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _NormalOffset;
		uniform float _MaxDistance;
		uniform float4 _EdgeFresnelColor;
		uniform float _FresnelBias;
		uniform float _FresnelScale;
		uniform float _FresnelPower;
		uniform sampler2D _MatCap;
		uniform float _MatCapIntensity;

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
			float2 uv_BaseMap = i.uv_texcoord * _BaseMap_ST.xy + _BaseMap_ST.zw;
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float3 temp_output_187_0 = ( ase_lightAtten * ase_lightColor.rgb );
			float3 temp_cast_0 = (1.0).xxx;
			#ifdef UNITY_PASS_FORWARDBASE
				float3 staticSwitch192 = temp_cast_0;
			#else
				float3 staticSwitch192 = temp_output_187_0;
			#endif
			float3 LightColor193 = staticSwitch192;
			float4 base_color6 = ( tex2D( _BaseMap, uv_BaseMap ) * _BaseColor * float4( LightColor193 , 0.0 ) );
			float3 ase_worldPos = i.worldPos;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			float3 newWorldNormal12 = normalize( (WorldNormalVector( i , UnpackNormal( tex2D( _NormalMap, uv_NormalMap ) ) )) );
			float3 appendResult208 = (float3(newWorldNormal12.x , newWorldNormal12.y , -newWorldNormal12.z));
			float3 switchResult206 = (((i.ASEVFace>0)?(newWorldNormal12):(appendResult208)));
			float3 NormalDir15 = switchResult206;
			float dotResult18 = dot( ase_worldlightDir , NormalDir15 );
			float3 break188 = temp_output_187_0;
			float LightAtten194 = max( max( break188.x , break188.y ) , break188.z );
			float HalfLambert24 = ( ( ( max( dotResult18 , 0.0 ) + 1.0 ) * 0.5 ) * LightAtten194 );
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float dotResult32 = dot( NormalDir15 , ase_worldViewDir );
			float NdotV45 = max( dotResult32 , 0.0 );
			float clampResult64 = clamp( sqrt( max( ( HalfLambert24 / NdotV45 ) , 0.0 ) ) , 0.0 , 1.0 );
			float aniso_atten68 = ( clampResult64 * ase_lightAtten );
			float3 normalizeResult159 = normalize( ( ase_worldlightDir + ase_worldViewDir ) );
			float3 HalfDir40 = normalizeResult159;
			float2 uv_AnisoMap = i.uv_texcoord * _AnisoMap_ST.xy + _AnisoMap_ST.zw;
			float Aniso_noise28 = ( tex2D( _AnisoMap, uv_AnisoMap ).r - 0.5 );
			float3 ase_worldBitangent = WorldNormalVector( i, float3( 0, 1, 0 ) );
			float3 normalizeResult80 = normalize( ( ( ( ( _SpecNoise1 * Aniso_noise28 ) + _SpecOffset1 ) * NormalDir15 ) + ase_worldBitangent ) );
			float dotResult81 = dot( HalfDir40 , normalizeResult80 );
			float BdotH186 = ( dotResult81 / _SpecShininess1 );
			float3 ase_worldTangent = WorldNormalVector( i, float3( 1, 0, 0 ) );
			float dotResult48 = dot( ase_worldTangent , HalfDir40 );
			float TdotH50 = dotResult48;
			float dotResult38 = dot( NormalDir15 , HalfDir40 );
			float NdotH42 = dotResult38;
			float spec_term199 = exp( ( -( ( BdotH186 * BdotH186 ) + ( TdotH50 * TdotH50 ) ) / ( NdotH42 + 1.0 ) ) );
			float4 final_spec1102 = ( ( ( _SpecColor1 + base_color6 ) * ase_lightColor * aniso_atten68 ) * spec_term199 );
			float3 normalizeResult119 = normalize( ( ( ( ( _SpecNoise2 * Aniso_noise28 ) + _SpecOffset2 ) * NormalDir15 ) + ase_worldBitangent ) );
			float dotResult121 = dot( HalfDir40 , normalizeResult119 );
			float BdotH2124 = ( dotResult121 / _SpecShininess2 );
			float spec_term2135 = exp( ( -( ( BdotH2124 * BdotH2124 ) + ( TdotH50 * TdotH50 ) ) / ( NdotH42 + 1.0 ) ) );
			float4 final_spec2145 = ( ( ( _SpecColor2 + base_color6 ) * ase_lightColor * aniso_atten68 ) * spec_term2135 );
			float clampResult9 = clamp( _RoughnessAdjust , 0.0 , 1.0 );
			float roughness10 = clampResult9;
			float4 env_specular179 = ( texCUBElod( _EnvMap, float4( reflect( -ase_worldViewDir , NormalDir15 ), ( ( ( 1.7 - ( 0.7 * roughness10 ) ) * roughness10 ) * 6.0 )) ) * _Expose * HalfLambert24 * Aniso_noise28 );
			float2 uv_MTex = i.uv_texcoord * _MTex_ST.xy + _MTex_ST.zw;
			float Metallicity275 = tex2D( _MTex, uv_MTex ).b;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_vertexNormal = mul( unity_WorldToObject, float4( ase_worldNormal, 0 ) );
			ase_vertexNormal = normalize( ase_vertexNormal );
			float3 objToViewDir214 = mul( UNITY_MATRIX_IT_MV, float4( ase_vertexNormal, 0 ) ).xyz;
			float2 appendResult216 = (float2(objToViewDir214.xy));
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float3 objToView217 = mul( UNITY_MATRIX_MV, float4( ase_vertex3Pos, 1 ) ).xyz;
			float2 appendResult218 = (float2(objToView217.xy));
			float3 appendResult221 = (float3(( ( _NormalOffset * appendResult216 ) + appendResult218 ) , objToView217.z));
			float4 appendResult223 = (float4(appendResult221 , 1.0));
			float4 computeScreenPos225 = ComputeScreenPos( mul( UNITY_MATRIX_P, appendResult223 ) );
			computeScreenPos225 = computeScreenPos225 / computeScreenPos225.w;
			computeScreenPos225.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? computeScreenPos225.z : computeScreenPos225.z* 0.5 + 0.5;
			float eyeDepth228 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, computeScreenPos225.xy ));
			float MaxDistance229 = _MaxDistance;
			float clampResult242 = clamp( (0.0 + (min( ( eyeDepth228 - i.eyeDepth ) , MaxDistance229 ) - 0.0) * (1.0 - 0.0) / (MaxDistance229 - 0.0)) , 0.0 , 1.0 );
			float3 appendResult240 = (float3(_EdgeFresnelColor.rgb));
			float fresnelNdotV235 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode235 = ( _FresnelBias + _FresnelScale * pow( 1.0 - fresnelNdotV235, _FresnelPower ) );
			float clampResult238 = clamp( fresnelNode235 , 0.0 , 1.0 );
			float4 EdgeColor253 = ( clampResult242 * ( float4( appendResult240 , 0.0 ) * clampResult238 * base_color6 ) );
			float2 MatCapUV263 = ( ( (mul( UNITY_MATRIX_V, float4( ase_worldNormal , 0.0 ) ).xyz).xy + 1.0 ) * 0.5 );
			float4 MatCapColor266 = ( tex2D( _MatCap, MatCapUV263 ) * _MatCapIntensity );
			c.rgb = ( base_color6 + ( ( final_spec1102 + final_spec2145 + ( env_specular179 * pow( ( 1.0 - distance( i.uv_texcoord.y , 0.5 ) ) , _AnisoMapPower ) ) ) * Metallicity275 ) + EdgeColor253 + MatCapColor266 ).rgb;
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
				float3 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
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
				o.customPack1.z = customInputData.eyeDepth;
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
				surfIN.eyeDepth = IN.customPack1.z;
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
-1114;413;1372;877;-848.371;-1919.233;1.3;True;False
Node;AmplifyShaderEditor.CommentaryNode;13;-1960.289,475.1573;Inherit;False;1618.564;360.3766;NormalDir;6;15;206;208;12;11;210;NormalDir;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;11;-1911.289,536.6353;Inherit;True;Property;_NormalMap;NormalMap;3;0;Create;True;0;0;0;False;0;False;-1;None;082daf67ef422b740bd872538706a5db;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;29;-1964.516,1520.593;Inherit;False;1689.199;455.7207;Aniso_Noise;4;28;27;25;26;Aniso_Noise;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldNormalVector;12;-1578.88,539.1574;Inherit;False;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TextureCoordinatesNode;26;-1914.516,1570.593;Inherit;False;0;25;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NegateNode;210;-1312.252,655.2122;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;25;-1510.483,1563.919;Inherit;True;Property;_AnisoMap;AnisoMap;5;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;gray;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;184;310.827,2771.82;Inherit;False;1513.141;690.5745;LightAtten;10;194;193;192;191;190;189;188;187;186;185;LightAtten;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;208;-1055.516,599.7779;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;27;-1199.807,1617.259;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;85;-2014.515,4073.458;Inherit;False;2526.623;752.9102;BdotH1;15;86;84;83;81;82;80;79;78;77;76;75;74;73;71;70;BdotH1 第一道各向异性高光的BdotH;1,1,1,1;0;0
Node;AmplifyShaderEditor.LightAttenuation;185;360.827,3062.615;Inherit;True;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;28;-591.3017,1634.653;Inherit;False;Aniso_noise;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;186;377.1151,3267.474;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SwitchByFaceNode;206;-821.1639,531.2959;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;109;834.6407,4118.229;Inherit;False;2526.623;752.9102;BdotH2;15;124;123;122;121;120;119;118;117;116;115;114;113;112;111;110;BdotH2 第二道各向异性高光的BdotH;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;187;630.5703,3133.159;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;73;-1977.248,4292.897;Inherit;False;28;Aniso_noise;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;23;-1934.854,854.7748;Inherit;False;1601.003;612.0859;HalfLambert;9;24;22;20;19;16;18;17;195;197;HalfLambert;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;112;884.6405,4403.879;Inherit;False;28;Aniso_noise;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;70;-1927.036,4123.457;Inherit;False;Property;_SpecNoise1;SpecNoise1;9;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;15;-569.4819,530.382;Inherit;False;NormalDir;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;110;922.1194,4168.228;Inherit;False;Property;_SpecNoise2;SpecNoise2;13;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;39;-1960.376,1984.949;Inherit;False;898.1077;543.3555;HalfDir;5;40;36;35;34;159;HalfDir;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;17;-1864.854,904.7748;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;36;-1882.624,2304.304;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;111;1176.64,4233.879;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;75;-1650.515,4434.002;Inherit;False;Property;_SpecOffset1;SpecOffset1;10;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;16;-1884.854,1168.774;Inherit;False;15;NormalDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;188;944.1711,3152.12;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;34;-1910.376,2034.949;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;71;-1672.515,4189.108;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;114;1198.64,4511.879;Inherit;False;Property;_SpecOffset2;SpecOffset2;14;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;35;-1636.268,2170.323;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;74;-1396.515,4286.108;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;189;1184.074,3131.012;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;18;-1580.854,953.7748;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;113;1452.64,4330.879;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;116;1479.64,4557.879;Inherit;False;15;NormalDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;77;-1369.515,4513.108;Inherit;False;15;NormalDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;190;1339.023,3163.329;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;76;-1102.515,4346.108;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;46;-80.16443,1994.76;Inherit;False;1033.475;483;NdotV;5;31;32;33;44;45;NdotV;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;19;-1350.854,1068.774;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;115;1746.64,4390.879;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;159;-1499.4,2167.235;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.VertexBinormalNode;118;1753.64,4653.879;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.VertexBinormalNode;79;-1101.882,4610.381;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;78;-846.515,4448.108;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;194;1599.964,3165.095;Inherit;False;LightAtten;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;40;-1336.113,2166.113;Inherit;False;HalfDir;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;33;-22.16443,2247.76;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;212;-1962.583,8037.421;Inherit;False;3596.143;1815.724;Comment;41;253;252;251;250;249;248;247;246;245;244;243;242;241;240;239;238;237;236;235;234;233;232;231;230;229;228;227;226;225;224;223;222;221;220;219;218;217;216;215;214;213;EdgeColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;20;-1135.855,1127.774;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;31;-30.16443,2044.76;Inherit;False;15;NormalDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;117;2002.64,4492.879;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;120;2238.64,4268.879;Inherit;False;40;HalfDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;82;-610.515,4224.108;Inherit;False;40;HalfDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalVertexDataNode;213;-1835.558,8391.616;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalizeNode;119;2243.64,4508.879;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DotProductOpNode;32;230.8362,2116.76;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;80;-609.335,4452.648;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;51;-1978.043,2605.929;Inherit;False;978.0585;541.9307;TdotH;4;47;48;49;50;TdotH;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;195;-1027.023,1312.579;Inherit;False;194;LightAtten;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-925.8551,1149.774;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;44;486.6779,2158.936;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexTangentNode;47;-1928.043,2655.929;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DotProductOpNode;81;-265.515,4316.108;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;123;2648.64,4596.879;Inherit;False;Property;_SpecShininess2;SpecShininess2;12;0;Create;True;0;0;0;False;0;False;0.1;0.032;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;49;-1873.156,2917.86;Inherit;False;40;HalfDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;14;-1917.734,78.78988;Inherit;False;904.2605;345.4482;Roughness;3;8;9;10;Roughness;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;84;-270.5463,4552.108;Inherit;False;Property;_SpecShininess1;SpecShininess1;8;0;Create;True;0;0;0;False;0;False;0.1;0.137;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;121;2583.64,4360.879;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;197;-755.6846,1175.711;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TransformDirectionNode;214;-1616.358,8385.816;Inherit;False;Object;View;False;Fast;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.PosVertexDataNode;215;-1868.583,8611.753;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;67;-1985.635,3247.82;Inherit;False;1895.565;668.6631;Aniso_Atten;9;68;66;65;64;63;62;61;60;59;Aniso_Atten;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;216;-1382.21,8388.857;Inherit;False;FLOAT2;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;45;710.3105,2150.901;Inherit;False;NdotV;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;83;32.48497,4373.108;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;43;-1017.417,1991.34;Inherit;False;816.1;513.6016;NdotH;4;37;38;41;42;NdotH;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;24;-597.3606,1189.284;Inherit;False;HalfLambert;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;48;-1492.034,2764.405;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-1866.731,128.7899;Inherit;False;Property;_RoughnessAdjust;RoughnessAdjust;4;0;Create;True;0;0;0;False;0;False;0;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TransformPositionNode;217;-1648.646,8609.194;Inherit;False;Object;View;False;Fast;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;252;-1505.93,8253.597;Inherit;False;Property;_NormalOffset;NormalOffset;17;1;[Header];Create;True;1;EdgeColor;0;0;False;0;False;0.01;0.004;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;122;2881.64,4417.879;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;37;-951.868,2078.229;Inherit;False;15;NormalDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;191;791.1763,2897.062;Inherit;False;Constant;_Float4;Float 4;1;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;9;-1563.473,154.2382;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;108;850.1037,4982.206;Inherit;False;2066.942;725.4688;spec_term1;11;135;134;133;132;131;130;129;128;127;126;125;spec_term1 第一道各向异性高光关键项;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;124;3157.419,4417.853;Inherit;False;BdotH2;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;219;-1168.355,8317.727;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;50;-1242.985,2770.694;Inherit;False;TdotH;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;41;-945.9974,2217.823;Inherit;False;40;HalfDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;180;-1997.596,6805.281;Inherit;False;2448.403;742.6626;env_specular;7;173;174;176;177;178;175;179;env_specular;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;61;-1908.109,3508.484;Inherit;False;45;NdotV;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;218;-1368.539,8551.183;Inherit;False;FLOAT2;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;86;308.2639,4373.082;Inherit;False;BdotH1;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;59;-1936.635,3297.82;Inherit;False;24;HalfLambert;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;98;-1999.052,4937.435;Inherit;False;2066.942;725.4688;spec_term1;11;99;97;93;96;95;92;89;91;90;88;87;spec_term1 第一道各向异性高光关键项;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;220;-1079.597,8468.331;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;125;900.1035,5041.413;Inherit;False;124;BdotH2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;60;-1621.109,3363.484;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;87;-1949.052,4996.642;Inherit;False;86;BdotH1;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;173;-1947.596,6855.281;Inherit;False;1314.218;689.7529;Comment;11;161;164;162;169;165;166;171;170;167;168;163;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;10;-1256.473,166.2382;Inherit;False;roughness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;192;1032.756,2878.507;Inherit;True;Property;_Keyword0;Keyword 0;1;0;Create;True;0;0;0;False;0;False;0;0;0;False;UNITY_PASS_FORWARDBASE;Toggle;2;Key0;Key1;Fetch;True;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DotProductOpNode;38;-660.7104,2111.536;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;90;-1883.534,5243.435;Inherit;False;50;TdotH;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;127;965.6213,5288.206;Inherit;False;50;TdotH;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;126;1165.621,5032.206;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;221;-952.057,8567.841;Inherit;False;FLOAT3;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;7;-1984.279,-834.6899;Inherit;False;1369.847;780.4193;BaseColor;5;6;2;196;4;1;BaseColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;165;-1897.596,7356.034;Inherit;False;10;roughness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;62;-1357.109,3380.484;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;91;-1651.534,5234.435;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;193;1387.773,2875.388;Inherit;False;LightColor;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;128;1197.621,5279.206;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;88;-1683.534,4987.435;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;268;-1896.946,10122.92;Inherit;False;2263.96;803.0342;MatCapColor;16;266;265;264;263;262;261;260;258;259;257;256;255;269;270;272;275;MatCapColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;42;-444.3167,2114.361;Inherit;False;NdotH;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;129;1465.621,5110.206;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;223;-794.275,8459.414;Inherit;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;196;-1261.241,-402.6902;Inherit;False;193;LightColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;89;-1383.534,5065.435;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ProjectionMatrixNode;222;-803.4861,8335.503;Inherit;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.SqrtOpNode;63;-1101.109,3394.484;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;4;-1656.631,-543.9917;Inherit;False;Property;_BaseColor;BaseColor;2;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;0.6792453,0.6792453,0.6792453,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;167;-1760.665,7093.568;Inherit;False;Constant;_Float2;Float 2;13;0;Create;True;0;0;0;False;0;False;1.7;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-1710.979,-754.19;Inherit;True;Property;_BaseMap;BaseMap;1;0;Create;True;0;0;0;False;0;False;-1;None;469c9532937a78d4699c51abb1ae44c8;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;95;-1307.534,5400.435;Inherit;False;42;NdotH;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;131;1541.621,5445.206;Inherit;False;42;NdotH;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;169;-1667.596,7255.034;Inherit;False;2;2;0;FLOAT;0.7;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewMatrixNode;256;-1764.192,10172.92;Inherit;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.WorldNormalVector;255;-1846.946,10303.53;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NegateNode;130;1721.621,5152.206;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;96;-1083.534,5400.435;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;224;-634.9467,8337.745;Inherit;False;2;2;0;FLOAT4x4;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.NegateNode;92;-1127.534,5107.435;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;163;-1483.241,6905.281;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ClampOpNode;64;-902.1089,3401.484;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;66;-923.4629,3623.899;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;132;1765.621,5445.206;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2;-1030.024,-601.6027;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;168;-1491.665,7139.568;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;257;-1573.192,10235.92;Inherit;False;2;2;0;FLOAT4x4;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;65;-626.1089,3482.484;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComputeScreenPosHlpNode;225;-409.1664,8471.575;Inherit;False;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;226;-197.0995,8105.345;Inherit;False;Property;_MaxDistance;MaxDistance;18;0;Create;True;0;0;0;False;0;False;0.3;0.095;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;103;-1999.125,5810.454;Inherit;False;1632.981;819.6211;final_spec1;9;53;55;54;69;57;56;100;101;102;final_spec1 第一道各向异性高光完成;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;161;-1314.378,7024.883;Inherit;False;15;NormalDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;107;850.0307,5855.225;Inherit;False;1632.981;819.6211;final_spec1;9;145;144;143;142;141;140;139;137;136;final_spec1 第一道各向异性高光完成;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;171;-1203.596,7430.034;Inherit;False;Constant;_Float3;Float 3;13;0;Create;True;0;0;0;False;0;False;6;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;164;-1201.378,6912.883;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;133;2055.621,5233.206;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;93;-793.534,5188.435;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;6;-832.0481,-593.3579;Inherit;False;base_color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SwizzleNode;259;-1392.235,10223.83;Inherit;False;FLOAT2;0;1;2;3;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;258;-1354.164,10345.13;Inherit;False;Constant;_Float5;Float 5;1;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;166;-1261.596,7325.034;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenDepthNode;228;-141.9406,8470.009;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SurfaceDepthNode;227;-143.2116,8239.627;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;229;123.5114,8109.245;Inherit;False;MaxDistance;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;55;-1917.095,6068.11;Inherit;False;6;base_color;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;53;-1949.125,5860.454;Inherit;False;Property;_SpecColor1;SpecColor1;7;0;Create;True;0;0;0;False;0;False;1,1,1,1;0.3584906,0.3584906,0.3584906,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;136;900.0305,5905.225;Inherit;False;Property;_SpecColor2;SpecColor2;11;0;Create;True;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;170;-1028.597,7356.034;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ReflectOpNode;162;-1021.378,6956.883;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;68;-415.4342,3493.581;Inherit;False;aniso_atten;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ExpOpNode;134;2316.621,5248.206;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ExpOpNode;97;-586.2291,5186.771;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;260;-1228.164,10418.13;Inherit;False;Constant;_Float6;Float 6;1;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;261;-1179.164,10225.13;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;137;934.5354,6080.711;Inherit;False;6;base_color;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;176;-327.1932,7215.943;Inherit;False;Property;_Expose;Expose;16;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;234;204.0815,8466.344;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;230;-198.2885,9458.345;Inherit;False;Property;_FresnelPower;FresnelPower;22;0;Create;True;0;0;0;False;0;False;5;5;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;231;-159.0514,9289.507;Inherit;False;Property;_FresnelBias;FresnelBias;20;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;69;-1556.352,6361.075;Inherit;False;68;aniso_atten;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;232;-181.6425,9370.359;Inherit;False;Property;_FresnelScale;FresnelScale;21;0;Create;True;0;0;0;False;0;False;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;54;-1567.299,5963.375;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;205;575.691,1764.408;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;174;-498.1932,7000.943;Inherit;True;Property;_EnvMap;EnvMap;15;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;LockedToCube;False;Object;-1;MipLevel;Cube;8;0;SAMPLERCUBE;;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;233;130.6943,8659.146;Inherit;False;229;MaxDistance;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;57;-1589.62,6175.94;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;262;-1038.164,10229.13;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;177;-353.1932,7313.943;Inherit;False;24;HalfLambert;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;140;1355.803,6444.846;Inherit;False;68;aniso_atten;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;99;-382.2164,5177.355;Inherit;False;spec_term1;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;135;2543.081,5250.929;Inherit;False;spec_term2;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;178;-381.1932,7410.943;Inherit;False;28;Aniso_noise;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;141;1259.535,6220.711;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;139;1159.358,5945.039;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;263;-873.5001,10227.62;Inherit;False;MatCapUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DistanceOpNode;200;845.8204,1771.107;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;101;-1067.145,6196.009;Inherit;False;99;spec_term1;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;-1202.62,6031.94;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;144;1784.01,6321.78;Inherit;False;135;spec_term2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;175;57.8069,7165.943;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;237;43.17149,8786.27;Inherit;False;Property;_EdgeFresnelColor;EdgeFresnelColor;19;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;0.7490566,0.7664032,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FresnelNode;235;166.7375,9304.268;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;142;1646.535,6076.711;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMinOpNode;236;361.0345,8605.911;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;238;465.4855,9292.942;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;239;233.6135,9014.347;Inherit;False;6;base_color;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;143;2017.835,6099.495;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;240;284.4255,8789.997;Inherit;False;FLOAT3;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TFHCRemapNode;241;520.3145,8614.386;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;100;-831.3195,6054.724;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;179;207.8069,7160.943;Inherit;False;env_specular;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;201;988.9974,1774.058;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;203;912.0772,1877.137;Inherit;False;Property;_AnisoMapPower;AnisoMapPower;6;0;Create;True;0;0;0;False;0;False;2.55;2.55;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;264;-858.5002,10343.62;Inherit;False;263;MatCapUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ClampOpNode;242;747.0903,8642.087;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;243;665.0974,8835.88;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;272;-623.4613,10667.61;Inherit;True;Property;_MTex;MTex;25;0;Create;True;0;0;0;False;0;False;-1;None;e4cf5d055d224cd41ad202a3d4332bfa;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;145;2240.01,6121.78;Inherit;False;final_spec2;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;181;1093.137,2273.822;Inherit;False;179;env_specular;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;202;1166.539,1760.583;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;270;-618.8782,10535.56;Inherit;False;Property;_MatCapIntensity;MatCapIntensity;24;0;Create;True;0;0;0;False;0;False;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;265;-625.6833,10319.68;Inherit;True;Property;_MatCap;MatCap;23;0;Create;True;0;0;0;False;0;False;-1;None;9085dd08ccaf0bc4cb4aa562858588ca;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;102;-609.1449,6077.009;Inherit;False;final_spec1;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;269;-246.0983,10322.49;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;244;922.5004,8703.353;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;104;1335.795,2091.987;Inherit;False;102;final_spec1;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;204;1340.675,2271.419;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;147;1334.723,2179.583;Inherit;False;145;final_spec2;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;275;-271.5642,10727.7;Inherit;False;Metallicity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;266;90.92249,10311.08;Inherit;False;MatCapColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;253;1157.047,8703.065;Inherit;False;EdgeColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;105;1534.195,2149.989;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;276;1501.39,2306.774;Inherit;False;275;Metallicity;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;274;1695.323,2186.785;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;254;1644.56,2369.554;Inherit;False;253;EdgeColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;267;1656.62,2480.894;Inherit;False;266;MatCapColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;148;1335.539,1996.139;Inherit;False;6;base_color;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;251;805.4475,8454.864;Inherit;False;250;DebugEyeDepth;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PosVertexDataNode;246;-456.4222,8087.421;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GammaToLinearNode;248;275.2515,8208.943;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;250;766.4365,8262.351;Inherit;False;DebugEyeDepth;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GammaToLinearNode;249;266.7454,8347.067;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TransformPositionNode;245;-647.9413,8677.62;Inherit;False;View;Object;False;Fast;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;271;-2083.957,10303.39;Inherit;False;15;NormalDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;247;495.0455,8267.013;Inherit;False;Property;_DebugEyeDepth;DebugEyeDepth;0;0;Create;True;0;0;0;False;0;False;0;0;0;True;;KeywordEnum;2;Surf;DepthTexture;Create;True;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PowerNode;151;2324.317,2188.528;Inherit;False;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.4545;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;154;2009.589,2252.443;Inherit;False;Constant;_Float0;Float 0;13;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;156;2020.589,2361.443;Inherit;False;Constant;_Float1;Float 1;13;0;Create;True;0;0;0;False;0;False;2.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;273;1908.755,2158.946;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;155;2162.588,2287.443;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;149;2046.347,2037.491;Inherit;False;float a = 2.51f@$float b = 0.03f@$float c = 2.43f@$float d = 0.59f@$float e = 0.14f@$return saturate((x*(a*x + b)) / (x*(c*x + d) + e))@;3;Create;1;True;x;FLOAT3;0,0,0;In;;Inherit;False;ACESTonemapping;True;False;0;;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2611.946,1862.282;Float;False;True;-1;2;ASEMaterialInspector;0;0;CustomLighting;ASE/Char_Hair;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;12;0;11;0
WireConnection;210;0;12;3
WireConnection;25;1;26;0
WireConnection;208;0;12;1
WireConnection;208;1;12;2
WireConnection;208;2;210;0
WireConnection;27;0;25;1
WireConnection;28;0;27;0
WireConnection;206;0;12;0
WireConnection;206;1;208;0
WireConnection;187;0;185;0
WireConnection;187;1;186;1
WireConnection;15;0;206;0
WireConnection;111;0;110;0
WireConnection;111;1;112;0
WireConnection;188;0;187;0
WireConnection;71;0;70;0
WireConnection;71;1;73;0
WireConnection;35;0;34;0
WireConnection;35;1;36;0
WireConnection;74;0;71;0
WireConnection;74;1;75;0
WireConnection;189;0;188;0
WireConnection;189;1;188;1
WireConnection;18;0;17;0
WireConnection;18;1;16;0
WireConnection;113;0;111;0
WireConnection;113;1;114;0
WireConnection;190;0;189;0
WireConnection;190;1;188;2
WireConnection;76;0;74;0
WireConnection;76;1;77;0
WireConnection;19;0;18;0
WireConnection;115;0;113;0
WireConnection;115;1;116;0
WireConnection;159;0;35;0
WireConnection;78;0;76;0
WireConnection;78;1;79;0
WireConnection;194;0;190;0
WireConnection;40;0;159;0
WireConnection;20;0;19;0
WireConnection;117;0;115;0
WireConnection;117;1;118;0
WireConnection;119;0;117;0
WireConnection;32;0;31;0
WireConnection;32;1;33;0
WireConnection;80;0;78;0
WireConnection;22;0;20;0
WireConnection;44;0;32;0
WireConnection;81;0;82;0
WireConnection;81;1;80;0
WireConnection;121;0;120;0
WireConnection;121;1;119;0
WireConnection;197;0;22;0
WireConnection;197;1;195;0
WireConnection;214;0;213;0
WireConnection;216;0;214;0
WireConnection;45;0;44;0
WireConnection;83;0;81;0
WireConnection;83;1;84;0
WireConnection;24;0;197;0
WireConnection;48;0;47;0
WireConnection;48;1;49;0
WireConnection;217;0;215;0
WireConnection;122;0;121;0
WireConnection;122;1;123;0
WireConnection;9;0;8;0
WireConnection;124;0;122;0
WireConnection;219;0;252;0
WireConnection;219;1;216;0
WireConnection;50;0;48;0
WireConnection;218;0;217;0
WireConnection;86;0;83;0
WireConnection;220;0;219;0
WireConnection;220;1;218;0
WireConnection;60;0;59;0
WireConnection;60;1;61;0
WireConnection;10;0;9;0
WireConnection;192;1;187;0
WireConnection;192;0;191;0
WireConnection;38;0;37;0
WireConnection;38;1;41;0
WireConnection;126;0;125;0
WireConnection;126;1;125;0
WireConnection;221;0;220;0
WireConnection;221;2;217;3
WireConnection;62;0;60;0
WireConnection;91;0;90;0
WireConnection;91;1;90;0
WireConnection;193;0;192;0
WireConnection;128;0;127;0
WireConnection;128;1;127;0
WireConnection;88;0;87;0
WireConnection;88;1;87;0
WireConnection;42;0;38;0
WireConnection;129;0;126;0
WireConnection;129;1;128;0
WireConnection;223;0;221;0
WireConnection;89;0;88;0
WireConnection;89;1;91;0
WireConnection;63;0;62;0
WireConnection;169;1;165;0
WireConnection;130;0;129;0
WireConnection;96;0;95;0
WireConnection;224;0;222;0
WireConnection;224;1;223;0
WireConnection;92;0;89;0
WireConnection;64;0;63;0
WireConnection;132;0;131;0
WireConnection;2;0;1;0
WireConnection;2;1;4;0
WireConnection;2;2;196;0
WireConnection;168;0;167;0
WireConnection;168;1;169;0
WireConnection;257;0;256;0
WireConnection;257;1;255;0
WireConnection;65;0;64;0
WireConnection;65;1;66;0
WireConnection;225;0;224;0
WireConnection;164;0;163;0
WireConnection;133;0;130;0
WireConnection;133;1;132;0
WireConnection;93;0;92;0
WireConnection;93;1;96;0
WireConnection;6;0;2;0
WireConnection;259;0;257;0
WireConnection;166;0;168;0
WireConnection;166;1;165;0
WireConnection;228;0;225;0
WireConnection;229;0;226;0
WireConnection;170;0;166;0
WireConnection;170;1;171;0
WireConnection;162;0;164;0
WireConnection;162;1;161;0
WireConnection;68;0;65;0
WireConnection;134;0;133;0
WireConnection;97;0;93;0
WireConnection;261;0;259;0
WireConnection;261;1;258;0
WireConnection;234;0;228;0
WireConnection;234;1;227;0
WireConnection;54;0;53;0
WireConnection;54;1;55;0
WireConnection;174;1;162;0
WireConnection;174;2;170;0
WireConnection;262;0;261;0
WireConnection;262;1;260;0
WireConnection;99;0;97;0
WireConnection;135;0;134;0
WireConnection;139;0;136;0
WireConnection;139;1;137;0
WireConnection;263;0;262;0
WireConnection;200;0;205;2
WireConnection;56;0;54;0
WireConnection;56;1;57;0
WireConnection;56;2;69;0
WireConnection;175;0;174;0
WireConnection;175;1;176;0
WireConnection;175;2;177;0
WireConnection;175;3;178;0
WireConnection;235;1;231;0
WireConnection;235;2;232;0
WireConnection;235;3;230;0
WireConnection;142;0;139;0
WireConnection;142;1;141;0
WireConnection;142;2;140;0
WireConnection;236;0;234;0
WireConnection;236;1;233;0
WireConnection;238;0;235;0
WireConnection;143;0;142;0
WireConnection;143;1;144;0
WireConnection;240;0;237;0
WireConnection;241;0;236;0
WireConnection;241;2;233;0
WireConnection;100;0;56;0
WireConnection;100;1;101;0
WireConnection;179;0;175;0
WireConnection;201;0;200;0
WireConnection;242;0;241;0
WireConnection;243;0;240;0
WireConnection;243;1;238;0
WireConnection;243;2;239;0
WireConnection;145;0;143;0
WireConnection;202;0;201;0
WireConnection;202;1;203;0
WireConnection;265;1;264;0
WireConnection;102;0;100;0
WireConnection;269;0;265;0
WireConnection;269;1;270;0
WireConnection;244;0;242;0
WireConnection;244;1;243;0
WireConnection;204;0;181;0
WireConnection;204;1;202;0
WireConnection;275;0;272;3
WireConnection;266;0;269;0
WireConnection;253;0;244;0
WireConnection;105;0;104;0
WireConnection;105;1;147;0
WireConnection;105;2;204;0
WireConnection;274;0;105;0
WireConnection;274;1;276;0
WireConnection;248;0;227;0
WireConnection;249;0;228;0
WireConnection;245;0;221;0
WireConnection;247;1;248;0
WireConnection;247;0;249;0
WireConnection;151;1;155;0
WireConnection;273;0;148;0
WireConnection;273;1;274;0
WireConnection;273;2;254;0
WireConnection;273;3;267;0
WireConnection;155;0;154;0
WireConnection;155;1;156;0
WireConnection;0;13;273;0
ASEEND*/
//CHKSM=BD10300768DFB9214068421F492C482D0C680934