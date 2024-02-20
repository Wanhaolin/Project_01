// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "All_3"
{
	Properties
	{
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("CullMode", Float) = 0
		[Enum(UnityEngine.Rendering.BlendMode)]_Dst("Dst", Float) = 10
		[Enum(On,1,Off,0)]_ZWriteMode("ZWriteMode", Float) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)]_ZTestMode("ZTestMode", Float) = 8
		_ColorScale("ColorScale", Float) = 1
		_AlphaScale("AlphaScale", Float) = 1
		[HDR][Header(Main)]_MainColor("MainColor", Color) = (0,0,0,0)
		_MainTex("MainTex", 2D) = "white" {}
		[KeywordEnum(R,G,B,A,white)] _MainTexChannel("MainTexChannel", Float) = 0
		[KeywordEnum(R,G,B,A,white)] _AlphaChannel("AlphaChannel", Float) = 0
		_Rotater("Rotater", Range( 0 , 360)) = 0
		[Toggle(_UV2_WTCONTROLOFFSET_ON)] _UV2_WTControlOffset("UV2_WTControlOffset", Float) = 0
		_MainTexPanner("MainTexPanner", Vector) = (0,0,1,0)
		[Header(Fade)][Toggle]_DisturbFadeTex("DisturbFadeTex", Float) = 0
		_FadeTex("FadeTex", 2D) = "white" {}
		_FadeTexPanner("FadeTexPanner", Vector) = (0,0,1,0)
		[Header(Ramp)]_RampTex("RampTex", 2D) = "white" {}
		[Enum(Default,0,Screen,1)]_UVType("UVType", Float) = 1
		_ScreenTilingOffset("ScreenTilingOffset", Vector) = (1,1,0,0)
		_RampDisStr("RampDisStr", Float) = 0
		[Header(Dissolution)][Toggle]_Dissolution_ON("Dissolution_ON", Float) = 0
		_DissolutionTex("DissolutionTex", 2D) = "white" {}
		_DissolutionTexPanner("DissolutionTexPanner", Vector) = (0,0,1,0)
		[Toggle(_UV1_TCONTORLDIS_ON)] _UV1_TContorlDis("UV1_TContorlDis", Float) = 0
		_Dissolution("Dissolution", Range( 0 , 1)) = 0.5236031
		_Float10("DissSoft", Range( 0 , 2)) = 0
		_Invers("Invers", Range( 0 , 1)) = 0
		[HDR]_DissEdgeColor("DissEdgeColor", Color) = (0,0,0,0)
		_Float14("DissEdgeWidth", Range( 0 , 0.5)) = 0.1
		[Header(Disturb)][Toggle]_Disturb_ON("Disturb_ON", Float) = 0
		_DisturbTex("DisturbTex", 2D) = "white" {}
		[Enum(typeA,0,typeB,1)]_DisturType("DisturType", Float) = 1
		[Toggle(_UV3_XCONTORLDISTURB_ON)] _UV3_XContorlDisturb("UV3_XContorlDisturb", Float) = 0
		_DisturbPanner("DisturbPanner", Vector) = (0,0,1,0)
		_DisturbDir("DisturbDir", Vector) = (1,1,0,0)
		_DisturbStr("DisturbStr", Float) = 0
		[Header(VertexOffset)][Toggle]_VertexOffset_ON("VertexOffset_ON", Float) = 0
		_VertexOffsetTex("VertexOffsetTex", 2D) = "white" {}
		[Toggle]_UV2_WTControlSpeed("UV2_WTControlSpeed", Float) = 0
		_VertexOffsetTexPanner("VertexOffsetTexPanner", Vector) = (0,0,1,0)
		_OffsetDir("OffsetDir", Vector) = (1,1,1,0)
		_OffsetScale("OffsetScale", Float) = 1
		_VertexOffsetMask("VertexOffsetMask", 2D) = "white" {}
		[Header(SoftParticle)][Toggle]_SoftParticle_ON("SoftParticle_ON", Float) = 0
		_FadeRange("FadeRange", Range( 0 , 10)) = 1
		_FadeSoft("FadeSoft", Range( 0.5 , 1.5)) = 0.5
		[Header(Fresnel)][Toggle]_Fre_ON("Fre_ON", Float) = 0
		_FreInvers("FreInvers", Range( 0 , 1)) = 0
		_FreScale("FreScale", Float) = 1
		_FrePower("FrePower", Float) = 5
		[HDR][Header(BackFaceColor)]_BackFaceColor("BackFaceColor", Color) = (0,0,0,0)
		[Toggle(_BACKFACE_ON_ON)] _BackFace_ON("BackFace_ON", Float) = 0
		_Float6("BackFaceIntensity", Float) = 1
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord3( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" }
		Cull [_CullMode]
		ZWrite [_ZWriteMode]
		ZTest [_ZTestMode]
		Blend SrcAlpha [_Dst]
		
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#pragma target 5.0
		#pragma shader_feature_local _UV1_TCONTORLDIS_ON
		#pragma shader_feature_local _UV3_XCONTORLDISTURB_ON
		#pragma shader_feature_local _ALPHACHANNEL_R _ALPHACHANNEL_G _ALPHACHANNEL_B _ALPHACHANNEL_A _ALPHACHANNEL_WHITE
		#pragma shader_feature_local _UV2_WTCONTROLOFFSET_ON
		#pragma shader_feature_local _BACKFACE_ON_ON
		#pragma shader_feature_local _MAINTEXCHANNEL_R _MAINTEXCHANNEL_G _MAINTEXCHANNEL_B _MAINTEXCHANNEL_A _MAINTEXCHANNEL_WHITE
		#pragma surface surf StandardCustomLighting keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 uv2_texcoord2;
			float2 uv_texcoord;
			float4 uv3_texcoord3;
			float4 vertexColor : COLOR;
			float4 screenPosition187;
			float3 worldPos;
			float3 worldNormal;
			half ASEVFace : VFACE;
			INTERNAL_DATA
			float4 screenPos;
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

		uniform float _CullMode;
		uniform float _ZWriteMode;
		uniform float _Dst;
		uniform float _ZTestMode;
		uniform sampler2D _VertexOffsetTex;
		uniform float3 _VertexOffsetTexPanner;
		uniform float4 _VertexOffsetTex_ST;
		uniform float _Rotater;
		uniform sampler2D _VertexOffsetMask;
		uniform float4 _VertexOffsetMask_ST;
		uniform float _UV2_WTControlSpeed;
		uniform float _OffsetScale;
		uniform float3 _OffsetDir;
		uniform float _VertexOffset_ON;
		uniform float _Dissolution;
		uniform float _Float10;
		uniform sampler2D _DissolutionTex;
		uniform sampler2D _DisturbTex;
		uniform float3 _DisturbPanner;
		uniform float4 _DisturbTex_ST;
		uniform float _DisturbStr;
		uniform float2 _DisturbDir;
		uniform float _DisturType;
		uniform float _Disturb_ON;
		uniform float3 _DissolutionTexPanner;
		uniform float4 _DissolutionTex_ST;
		uniform float _Invers;
		uniform float _Dissolution_ON;
		uniform sampler2D _MainTex;
		uniform float3 _MainTexPanner;
		uniform float4 _MainTex_ST;
		uniform sampler2D _FadeTex;
		uniform float3 _FadeTexPanner;
		uniform float4 _FadeTex_ST;
		uniform float _DisturbFadeTex;
		uniform float _AlphaScale;
		uniform float _FadeSoft;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _FadeRange;
		uniform float _SoftParticle_ON;
		uniform float _FreScale;
		uniform float _FrePower;
		uniform float _FreInvers;
		uniform float _Fre_ON;
		uniform float _ColorScale;
		uniform sampler2D _RampTex;
		uniform float4 _RampTex_ST;
		uniform float4 _ScreenTilingOffset;
		uniform float _UVType;
		uniform float _RampDisStr;
		uniform float4 _MainColor;
		uniform float _Float14;
		uniform float4 _DissEdgeColor;
		uniform float4 _BackFaceColor;
		uniform float _Float6;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float mulTime130 = _Time.y * _VertexOffsetTexPanner.z;
			float2 appendResult128 = (float2(_VertexOffsetTexPanner.x , _VertexOffsetTexPanner.y));
			float2 uv_VertexOffsetTex = v.texcoord.xy * _VertexOffsetTex_ST.xy + _VertexOffsetTex_ST.zw;
			float2 temp_cast_0 = (0.5).xx;
			float Rotater397 = ( (0.0 + (_Rotater - 0.0) * (2.0 - 0.0) / (360.0 - 0.0)) * UNITY_PI );
			float cos400 = cos( Rotater397 );
			float sin400 = sin( Rotater397 );
			float2 rotator400 = mul( uv_VertexOffsetTex - temp_cast_0 , float2x2( cos400 , -sin400 , sin400 , cos400 )) + temp_cast_0;
			float2 panner131 = ( mulTime130 * appendResult128 + rotator400);
			float2 uv_VertexOffsetMask = v.texcoord.xy * _VertexOffsetMask_ST.xy + _VertexOffsetMask_ST.zw;
			float2 temp_cast_1 = (0.5).xx;
			float cos403 = cos( Rotater397 );
			float sin403 = sin( Rotater397 );
			float2 rotator403 = mul( uv_VertexOffsetMask - temp_cast_1 , float2x2( cos403 , -sin403 , sin403 , cos403 )) + temp_cast_1;
			float2 appendResult359 = (float2(v.texcoord1.z , v.texcoord1.w));
			float2 UV2_WT152 = appendResult359;
			float UV1_U82 = v.texcoord1.x;
			float temp_output_267_0 = (-1.0 + (( tex2Dlod( _VertexOffsetTex, float4( panner131, 0, 0.0) ).r * tex2Dlod( _VertexOffsetMask, float4( ( rotator403 + ( UV2_WT152 * _UV2_WTControlSpeed ) ), 0, 0.0) ).r * ( 0.1 * _OffsetScale * UV1_U82 ) ) - 0.0) * (1.0 - -1.0) / (1.0 - 0.0));
			float3 appendResult272 = (float3(( temp_output_267_0 * _OffsetDir.x ) , ( temp_output_267_0 * _OffsetDir.y ) , ( temp_output_267_0 * _OffsetDir.z )));
			float3 ase_vertexNormal = v.normal.xyz;
			float3 VertexOffset137 = ( appendResult272 * ase_vertexNormal * _VertexOffset_ON );
			v.vertex.xyz += VertexOffset137;
			v.vertex.w = 1;
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 vertexPos187 = ase_vertex3Pos;
			float4 ase_screenPos187 = ComputeScreenPos( UnityObjectToClipPos( vertexPos187 ) );
			o.screenPosition187 = ase_screenPos187;
		}

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float UV2_Y83 = i.uv2_texcoord2.y;
			#ifdef _UV1_TCONTORLDIS_ON
				float staticSwitch23 = UV2_Y83;
			#else
				float staticSwitch23 = _Dissolution;
			#endif
			float temp_output_295_0 = ( 1.0 - staticSwitch23 );
			float mulTime173 = _Time.y * _DisturbPanner.z;
			float2 appendResult174 = (float2(_DisturbPanner.x , _DisturbPanner.y));
			float2 uv_DisturbTex = i.uv_texcoord * _DisturbTex_ST.xy + _DisturbTex_ST.zw;
			float2 panner175 = ( mulTime173 * appendResult174 + uv_DisturbTex);
			#ifdef _UV3_XCONTORLDISTURB_ON
				float staticSwitch205 = i.uv3_texcoord3.x;
			#else
				float staticSwitch205 = 1.0;
			#endif
			float UV3_X200 = staticSwitch205;
			float2 temp_output_223_0 = ( ( tex2D( _DisturbTex, panner175 ).r * _DisturbStr * UV3_X200 ) * _DisturbDir );
			float2 temp_cast_0 = (0.5).xx;
			float2 lerpResult323 = lerp( temp_output_223_0 , ( ( i.uv_texcoord - temp_cast_0 ) * temp_output_223_0 ) , _DisturType);
			float2 DisturbColor167 = ( lerpResult323 * _Disturb_ON );
			float mulTime122 = _Time.y * _DissolutionTexPanner.z;
			float2 appendResult121 = (float2(_DissolutionTexPanner.x , _DissolutionTexPanner.y));
			float2 uv_DissolutionTex = i.uv_texcoord * _DissolutionTex_ST.xy + _DissolutionTex_ST.zw;
			float2 panner124 = ( mulTime122 * appendResult121 + uv_DissolutionTex);
			float4 tex2DNode102 = tex2D( _DissolutionTex, ( DisturbColor167 + panner124 ) );
			float lerpResult310 = lerp( tex2DNode102.r , ( 1.0 - tex2DNode102.r ) , _Invers);
			float smoothstepResult291 = smoothstep( temp_output_295_0 , ( temp_output_295_0 + _Float10 ) , lerpResult310);
			float lerpResult389 = lerp( 1.0 , smoothstepResult291 , _Dissolution_ON);
			float mulTime31 = _Time.y * _MainTexPanner.z;
			float2 appendResult30 = (float2(_MainTexPanner.x , _MainTexPanner.y));
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float2 temp_cast_1 = (0.5).xx;
			float Rotater397 = ( (0.0 + (_Rotater - 0.0) * (2.0 - 0.0) / (360.0 - 0.0)) * UNITY_PI );
			float cos193 = cos( Rotater397 );
			float sin193 = sin( Rotater397 );
			float2 rotator193 = mul( uv_MainTex - temp_cast_1 , float2x2( cos193 , -sin193 , sin193 , cos193 )) + temp_cast_1;
			float2 temp_output_170_0 = ( rotator193 + DisturbColor167 );
			float2 panner27 = ( mulTime31 * appendResult30 + temp_output_170_0);
			float2 appendResult359 = (float2(i.uv2_texcoord2.z , i.uv2_texcoord2.w));
			float2 UV2_WT152 = appendResult359;
			#ifdef _UV2_WTCONTROLOFFSET_ON
				float2 staticSwitch154 = ( temp_output_170_0 + UV2_WT152 );
			#else
				float2 staticSwitch154 = panner27;
			#endif
			float4 tex2DNode1 = tex2D( _MainTex, staticSwitch154 );
			#if defined(_ALPHACHANNEL_R)
				float staticSwitch410 = tex2DNode1.r;
			#elif defined(_ALPHACHANNEL_G)
				float staticSwitch410 = tex2DNode1.g;
			#elif defined(_ALPHACHANNEL_B)
				float staticSwitch410 = tex2DNode1.b;
			#elif defined(_ALPHACHANNEL_A)
				float staticSwitch410 = tex2DNode1.a;
			#elif defined(_ALPHACHANNEL_WHITE)
				float staticSwitch410 = 1.0;
			#else
				float staticSwitch410 = tex2DNode1.r;
			#endif
			float mulTime261 = _Time.y * _FadeTexPanner.z;
			float2 appendResult262 = (float2(_FadeTexPanner.x , _FadeTexPanner.y));
			float2 uv_FadeTex = i.uv_texcoord * _FadeTex_ST.xy + _FadeTex_ST.zw;
			float2 panner264 = ( mulTime261 * appendResult262 + ( uv_FadeTex + ( DisturbColor167 * _DisturbFadeTex ) ));
			float FadeTexColor142 = tex2D( _FadeTex, panner264 ).r;
			float MainTexAlpha413 = ( saturate( ( staticSwitch410 - ( 1.0 - FadeTexColor142 ) ) ) * _AlphaScale );
			float VertexColor_A414 = i.vertexColor.a;
			float4 ase_screenPos187 = i.screenPosition187;
			float4 ase_screenPosNorm187 = ase_screenPos187 / ase_screenPos187.w;
			ase_screenPosNorm187.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm187.z : ase_screenPosNorm187.z * 0.5 + 0.5;
			float screenDepth187 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm187.xy ));
			float distanceDepth187 = abs( ( screenDepth187 - LinearEyeDepth( ase_screenPosNorm187.z ) ) / ( _FadeRange ) );
			float smoothstepResult344 = smoothstep( ( 1.0 - _FadeSoft ) , _FadeSoft , distanceDepth187);
			float lerpResult358 = lerp( 1.0 , smoothstepResult344 , _SoftParticle_ON);
			float SoftParticleColor189 = saturate( lerpResult358 );
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float3 ase_normWorldNormal = normalize( ase_worldNormal );
			float3 appendResult256 = (float3(ase_normWorldNormal.x , ase_normWorldNormal.y , -ase_normWorldNormal.z));
			float3 switchResult257 = (((i.ASEVFace>0)?(ase_normWorldNormal):(appendResult256)));
			float3 WorldNormal258 = switchResult257;
			float fresnelNdotV241 = dot( WorldNormal258, ase_worldViewDir );
			float fresnelNode241 = ( 0.0 + _FreScale * pow( max( 1.0 - fresnelNdotV241 , 0.0001 ), _FrePower ) );
			float lerpResult275 = lerp( ( 1.0 - fresnelNode241 ) , fresnelNode241 , _FreInvers);
			float clampResult246 = clamp( lerpResult275 , 0.0 , 1.0 );
			float lerpResult393 = lerp( 0.0 , clampResult246 , _Fre_ON);
			float Fre247 = lerpResult393;
			float OP387 = saturate( ( ( lerpResult389 * MainTexAlpha413 * VertexColor_A414 * SoftParticleColor189 ) - Fre247 ) );
			#if defined(_MAINTEXCHANNEL_R)
				float staticSwitch333 = tex2DNode1.r;
			#elif defined(_MAINTEXCHANNEL_G)
				float staticSwitch333 = tex2DNode1.g;
			#elif defined(_MAINTEXCHANNEL_B)
				float staticSwitch333 = tex2DNode1.b;
			#elif defined(_MAINTEXCHANNEL_A)
				float staticSwitch333 = tex2DNode1.a;
			#elif defined(_MAINTEXCHANNEL_WHITE)
				float staticSwitch333 = 1.0;
			#else
				float staticSwitch333 = tex2DNode1.r;
			#endif
			float MainTexColor68 = ( staticSwitch333 * _ColorScale );
			float2 uv_RampTex = i.uv_texcoord * _RampTex_ST.xy + _RampTex_ST.zw;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float2 appendResult328 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
			float2 appendResult331 = (float2(_ScreenTilingOffset.x , _ScreenTilingOffset.y));
			float2 appendResult332 = (float2(_ScreenTilingOffset.z , _ScreenTilingOffset.w));
			float2 lerpResult325 = lerp( uv_RampTex , (appendResult328*appendResult331 + appendResult332) , _UVType);
			float4 VertexColor75 = i.vertexColor;
			float temp_output_294_0 = ( temp_output_295_0 + _Float14 );
			float smoothstepResult297 = smoothstep( temp_output_294_0 , ( temp_output_294_0 + _Float10 ) , lerpResult310);
			float4 EmissEdgeColor305 = ( ( smoothstepResult291 - smoothstepResult297 ) * _DissEdgeColor );
			float4 BaseColor91 = ( ( MainTexColor68 * tex2D( _RampTex, ( lerpResult325 + ( DisturbColor167 * _RampDisStr ) ) ) * _MainColor * VertexColor75 ) + EmissEdgeColor305 );
			float4 switchResult215 = (((i.ASEVFace>0)?(BaseColor91):(( BaseColor91 + _BackFaceColor ))));
			float4 lerpResult317 = lerp( BaseColor91 , switchResult215 , _Float6);
			#ifdef _BACKFACE_ON_ON
				float4 staticSwitch218 = lerpResult317;
			#else
				float4 staticSwitch218 = BaseColor91;
			#endif
			c.rgb = staticSwitch218.rgb;
			c.a = OP387;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
27;714;1632;1002;14693.18;4434.15;11.04801;True;True
Node;AmplifyShaderEditor.CommentaryNode;203;-5428.129,-1071.439;Inherit;False;1124.562;519.4683;Comment;4;200;202;205;206;UV3;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;169;-6422.652,503.9718;Inherit;False;2900.98;1098.901;DisturbColor;20;167;323;324;319;320;223;321;318;177;222;178;166;201;175;173;174;172;171;391;392;DisturbColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;202;-5361.611,-896.1115;Inherit;False;2;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;206;-5282.665,-987.133;Inherit;False;Constant;_Float12;Float 12;28;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;171;-6318.428,807.3054;Inherit;False;Property;_DisturbPanner;DisturbPanner;37;0;Create;True;0;0;0;False;0;False;0,0,1;0.3,0.3,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TextureCoordinatesNode;172;-6265.245,647.0621;Inherit;False;0;166;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;174;-6067.43,760.3054;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;173;-6070.43,914.3054;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;205;-5061.665,-982.1326;Inherit;False;Property;_UV3_XContorlDisturb;UV3_XContorlDisturb;36;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;200;-4755.491,-984.7676;Inherit;False;UV3_X;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;175;-5885.748,728.4434;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;201;-5566.479,1045.972;Inherit;False;200;UV3_X;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;166;-5646.613,716.5972;Inherit;True;Property;_DisturbTex;DisturbTex;34;0;Create;True;1;Disturb;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;178;-5556.39,922.2837;Inherit;False;Property;_DisturbStr;DisturbStr;39;0;Create;True;0;0;0;False;0;False;0;-0.07;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;318;-5448.396,1377.656;Inherit;False;Constant;_Float4;Float 4;27;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;321;-5500.792,1231.35;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;222;-5341.381,1083.002;Inherit;False;Property;_DisturbDir;DisturbDir;38;0;Create;True;0;0;0;False;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;177;-5314.016,898.8497;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;399;-3455.162,-2775.698;Inherit;False;1051.398;262.722;Rotater;4;207;196;195;397;Rotater;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;320;-5217.298,1297.556;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;195;-3409.538,-2712.572;Inherit;False;Property;_Rotater;Rotater;11;0;Create;True;0;0;0;False;0;False;0;0;0;360;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;223;-5178.06,910.745;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;207;-3115.263,-2706.849;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;360;False;3;FLOAT;0;False;4;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;324;-5013.724,1284.434;Inherit;False;Property;_DisturType;DisturType;35;1;[Enum];Create;True;0;2;typeA;0;typeB;1;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;319;-4992.28,1068.109;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;151;-5428.185,-1874.399;Inherit;False;1270.852;616.8545;Comment;7;82;83;152;359;38;376;377;UV2;1,1,1,1;0;0
Node;AmplifyShaderEditor.PiNode;196;-2928.475,-2706.856;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;323;-4770.224,1037.934;Inherit;True;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;391;-4471.549,1124.868;Inherit;False;Property;_Disturb_ON;Disturb_ON;33;2;[Header];[Toggle];Create;True;1;Disturb;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;94;-3337.636,469.6351;Inherit;False;4026.521;2021.714;Comment;39;6;89;190;163;97;226;250;302;305;300;308;299;297;291;310;298;292;311;296;290;294;293;102;295;84;183;124;182;122;121;123;120;387;389;390;5;23;408;425;FinalOpacity;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;80;-3468.899,-2354.587;Inherit;False;3328.151;964.0254;MainTex;28;413;412;424;407;411;415;150;337;1;154;30;31;29;27;170;410;68;335;333;334;159;396;153;193;181;28;194;398;MainTex;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;38;-5406.615,-1776.249;Inherit;False;1;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;397;-2632.14,-2681.367;Inherit;False;Rotater;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;392;-4192.785,1042.223;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;377;-5173.207,-1415.155;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;120;-3307.005,866.91;Inherit;False;Property;_DissolutionTexPanner;DissolutionTexPanner;26;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TextureCoordinatesNode;28;-3457.962,-2250.973;Inherit;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;165;-2065.031,3441.14;Inherit;False;2010.894;1688.764;FadeTex;21;240;381;382;236;142;119;225;224;284;264;287;283;228;261;263;262;281;280;282;279;260;FadeTex;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;398;-3416.561,-2029.941;Inherit;False;397;Rotater;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;376;-5202.207,-1388.155;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;167;-3987.775,1046.069;Inherit;False;DisturbColor;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;194;-3382.037,-2104.298;Inherit;False;Constant;_Float11;Float 11;26;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;122;-3013.006,981.9091;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;121;-3010.006,827.9101;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;123;-3208.824,715.6666;Inherit;False;0;102;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;253;772.874,1317.638;Inherit;False;1088.13;274.4167;WorldNormal;5;258;257;256;255;254;WorldNormal;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;359;-4956.245,-1396.635;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;236;-2043.741,3729.727;Inherit;False;167;DisturbColor;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RotatorNode;193;-3123.773,-2224.99;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;181;-3174.113,-1829.743;Inherit;False;167;DisturbColor;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;83;-5115.898,-1665.241;Inherit;False;UV2_Y;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;382;-2040.056,3837.083;Inherit;False;Property;_DisturbFadeTex;DisturbFadeTex;17;2;[Header];[Toggle];Create;True;1;Fade;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;170;-2878.081,-2201.35;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;152;-4806.149,-1401.805;Inherit;False;UV2_WT;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;263;-2037.314,3569.966;Inherit;False;0;119;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;84;-2951.929,1392.098;Inherit;False;83;UV2_Y;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;381;-1808.972,3730.065;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-3057.114,1301.613;Inherit;False;Property;_Dissolution;Dissolution;28;0;Create;True;0;0;0;False;0;False;0.5236031;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;182;-2911.917,581.447;Inherit;False;167;DisturbColor;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WorldNormalVector;254;822.874,1367.638;Inherit;False;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;29;-2762.053,-2095.529;Inherit;False;Property;_MainTexPanner;MainTexPanner;13;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.PannerNode;124;-2837.428,733.6475;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector3Node;260;-1839.648,3958.415;Inherit;False;Property;_FadeTexPanner;FadeTexPanner;19;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;30;-2478.214,-2104.433;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;183;-2604.916,676.4473;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;31;-2500.917,-1988.528;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;240;-1642.312,3641.588;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;261;-1611.649,4065.414;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;23;-2712.092,1301.142;Inherit;False;Property;_UV1_TContorlDis;UV1_TContorlDis;27;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;153;-2413.953,-1798.047;Inherit;False;152;UV2_WT;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;262;-1588.649,3911.415;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;396;-2569.555,-1930.707;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.NegateNode;255;1025.599,1481.055;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;102;-2469.026,644.4135;Inherit;True;Property;_DissolutionTex;DissolutionTex;25;0;Create;True;1;Dissolution;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;295;-2380.883,1202.6;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;264;-1407.969,3841.551;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;159;-2200.229,-1903.122;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;90;-3017.52,-1297.058;Inherit;False;2733.078;1503.808;MainColor;21;91;149;71;148;231;184;232;233;229;78;16;306;307;325;326;329;330;327;328;331;332;MainColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.PannerNode;27;-2238.734,-2192.783;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;293;-2378.084,1448.731;Inherit;False;Property;_Float14;DissEdgeWidth;32;0;Create;False;0;0;0;False;0;False;0.1;0.1;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;256;1182.599,1424.055;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;327;-2901.569,-1152.478;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;330;-2987.088,-960.6431;Inherit;False;Property;_ScreenTilingOffset;ScreenTilingOffset;22;0;Create;True;0;0;0;False;0;False;1,1,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;154;-2027.517,-2080.152;Inherit;False;Property;_UV2_WTControlOffset;UV2_WTControlOffset;12;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;290;-2457.057,1105.412;Inherit;False;Property;_Invers;Invers;30;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;119;-1185.405,3806.097;Inherit;True;Property;_FadeTex;FadeTex;18;0;Create;True;1;Fade;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;311;-2087.777,755.6964;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;296;-2352.956,1589.636;Inherit;False;Property;_Float10;DissSoft;29;0;Create;False;0;0;0;False;0;False;0;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;294;-1922.281,1436.239;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwitchByFaceNode;257;1419.599,1373.055;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;1;-1691.689,-2107.018;Inherit;True;Property;_MainTex;MainTex;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;258;1637.004,1368.909;Inherit;False;WorldNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;251;771.0861,472.507;Inherit;False;1815.792;697.6492;FreOP;12;242;384;247;246;275;276;241;243;274;259;394;393;FreOP;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;331;-2751.12,-984.0365;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;310;-1825.928,687.2952;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;332;-2752.137,-875.2065;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;298;-1962.442,1298.179;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;188;-6412.272,1873.897;Inherit;False;1737.58;686.4956;SoftParticle;11;348;43;52;189;209;344;349;187;343;357;358;SoftParticle;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;337;-1312.675,-1900.261;Inherit;False;Constant;_Float5;Float 5;58;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;292;-1794.281,1548.239;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;142;-818.5123,3850.086;Inherit;False;FadeTexColor;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;328;-2704.569,-1123.478;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;184;-2484.965,-1212.046;Inherit;False;0;148;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;333;-990.7574,-2136.475;Inherit;False;Property;_MainTexChannel;MainTexChannel;9;0;Create;True;0;0;0;False;0;False;0;0;0;True;;KeywordEnum;5;R;G;B;A;white;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;329;-2570.04,-1019.639;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;326;-2461.664,-899.6679;Inherit;False;Property;_UVType;UVType;21;1;[Enum];Create;True;0;2;Default;0;Screen;1;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-6396.5,2101.52;Inherit;False;Property;_FadeRange;FadeRange;48;0;Create;True;1;;0;0;False;0;False;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;259;802.155,606.3345;Inherit;False;258;WorldNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;274;824.439,900.9553;Inherit;False;Property;_FrePower;FrePower;53;0;Create;True;0;0;0;False;0;False;5;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;291;-1409.204,976.9189;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;243;828.0861,803.9406;Inherit;False;Property;_FreScale;FreScale;52;0;Create;True;0;0;0;False;0;False;1;20;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;297;-1463.815,1339.499;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;343;-6363.092,1930.602;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;233;-2436.141,-672.5178;Inherit;False;Property;_RampDisStr;RampDisStr;23;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;81;378.5724,-1825.137;Inherit;False;498.0005;281.3341;VertexColor;3;75;24;414;VertexColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;229;-2456.263,-765.8656;Inherit;False;167;DisturbColor;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;164;-6968.021,3431.29;Inherit;False;4484.088;1595.142;VertexOffset;33;361;235;374;363;360;395;126;402;401;400;137;266;132;272;365;270;268;269;267;271;234;133;131;134;139;136;130;129;128;127;403;404;405;VertexOffset;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;334;-920.7573,-1930.475;Inherit;False;Property;_ColorScale;ColorScale;5;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;150;-1108.215,-1621.192;Inherit;False;142;FadeTexColor;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;348;-6376.094,2218.667;Inherit;False;Property;_FadeSoft;FadeSoft;49;0;Create;True;0;0;0;False;0;False;0.5;0.5;0.5;1.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;402;-6824.085,3817.633;Inherit;False;397;Rotater;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;241;1044.4,631.8207;Inherit;True;Standard;WorldNormal;ViewDir;False;True;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;127;-6376.193,3645.427;Inherit;False;Property;_VertexOffsetTexPanner;VertexOffsetTexPanner;43;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.StaticSwitch;410;-983.9398,-1820.752;Inherit;False;Property;_AlphaChannel;AlphaChannel;10;0;Create;True;0;0;0;False;0;False;0;0;0;True;;KeywordEnum;5;R;G;B;A;white;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;401;-6811.562,3728.277;Inherit;False;Constant;_Float8;Float 8;26;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;235;-6870.514,4023.786;Inherit;False;0;234;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;308;-1150.263,1622.818;Inherit;False;Property;_DissEdgeColor;DissEdgeColor;31;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;24;428.5724,-1775.137;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;325;-2257.47,-1017.576;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;405;-6741.911,4287.248;Inherit;False;397;Rotater;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;187;-6008.05,2055.318;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;129;-6910.073,3523.01;Inherit;False;0;126;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;360;-6216.746,4239.16;Inherit;False;152;UV2_WT;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;363;-6252.304,4337.218;Inherit;False;Property;_UV2_WTControlSpeed;UV2_WTControlSpeed;42;1;[Toggle];Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;404;-6715.477,4201.25;Inherit;False;Constant;_Float2;Float 2;26;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;232;-2218.343,-750.5179;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;349;-5906.977,2329.553;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;299;-1099.278,1254.799;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;415;-920.2871,-1615.855;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;335;-695.3799,-2085.941;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;52;-5586.322,1947.579;Inherit;False;Constant;_Float1;Float 1;14;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;130;-6083.319,3722.369;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;82;-5117.499,-1758.371;Inherit;False;UV1_U;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;75;646.5729,-1784.231;Inherit;False;VertexColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;231;-1911.475,-959.791;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;68;-498.0897,-2091.35;Inherit;False;MainTexColor;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;128;-6065.285,3616.458;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;276;1291.23,946.3643;Inherit;False;Property;_FreInvers;FreInvers;51;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;403;-6401.525,4046.059;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;407;-769.631,-1815.782;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;344;-5659.547,2087.301;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;400;-6540.878,3528.696;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;300;-908.8073,1602.645;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;357;-5604.254,2326.382;Inherit;False;Property;_SoftParticle_ON;SoftParticle_ON;47;2;[Header];[Toggle];Create;True;1;SoftParticle;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;242;1393.822,709.0223;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;374;-5993.765,4162.886;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;148;-1726.99,-990.0622;Inherit;True;Property;_RampTex;RampTex;20;1;[Header];Create;True;1;Ramp;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;16;-1506.331,-790.009;Inherit;False;Property;_MainColor;MainColor;7;2;[HDR];[Header];Create;True;1;Main;0;0;False;0;False;0,0,0,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;411;-731.6246,-1589.221;Inherit;False;Property;_AlphaScale;AlphaScale;6;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;134;-5505.875,4324.481;Inherit;False;Constant;_Float7;Float 7;25;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;136;-5499.174,4411.18;Inherit;False;Property;_OffsetScale;OffsetScale;45;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;71;-1482.947,-1097.219;Inherit;False;68;MainTexColor;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;275;1675.242,617.6685;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;424;-628.2179,-1812.25;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;358;-5370.75,2053.281;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;305;-704.1804,1596.273;Inherit;False;EmissEdgeColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.PannerNode;131;-5909.733,3561.813;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;361;-5805.273,4095.655;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;139;-5516.465,4501.935;Inherit;False;82;UV1_U;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;78;-1493.86,-590.8951;Inherit;False;75;VertexColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;384;2032.15,755.8856;Inherit;False;Property;_Fre_ON;Fre_ON;50;2;[Header];[Toggle];Create;True;1;Fresnel;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;126;-5550.825,3537.159;Inherit;True;Property;_VertexOffsetTex;VertexOffsetTex;41;0;Create;True;1;VertexOffset;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;133;-5114.964,4331.605;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;412;-497.6471,-1813.687;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;307;-1121.674,-815.7962;Inherit;False;305;EmissEdgeColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;246;1925.747,617.3897;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;394;2053.663,568.3356;Inherit;False;Constant;_Float9;Float 9;52;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;149;-1098.333,-1013.494;Inherit;False;4;4;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;234;-5524.437,4060.478;Inherit;True;Property;_VertexOffsetMask;VertexOffsetMask;46;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;209;-5148.769,1950.407;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;395;-5108.4,3578.752;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;390;-1128.965,780.0615;Inherit;False;Property;_Dissolution_ON;Dissolution_ON;24;2;[Header];[Toggle];Create;True;1;Dissolution;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;393;2218.616,590.449;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;413;-357.5652,-1816.618;Inherit;False;MainTexAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;414;645.9626,-1681.883;Inherit;False;VertexColor_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;302;-1079.444,693.4764;Inherit;False;Constant;_Float3;Float 3;52;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;306;-877.1956,-1006.806;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;189;-4994.038,1949.289;Inherit;False;SoftParticleColor;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;271;-4955.101,3885.143;Inherit;False;Property;_OffsetDir;OffsetDir;44;0;Create;True;0;0;0;False;0;False;1,1,1;1,1,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;247;2387.951,604.9037;Inherit;True;Fre;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;267;-4939.296,3579.588;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-1;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;250;-676.0219,947.505;Inherit;False;414;VertexColor_A;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;389;-796.6895,708.6663;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;163;-679.7682,832.0237;Inherit;False;413;MainTexAlpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;190;-678.9249,1055.473;Inherit;False;189;SoftParticleColor;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;91;-671.3101,-1004.385;Inherit;False;BaseColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;268;-4431.215,3769.687;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;92;-86.0229,-566.7433;Inherit;False;91;BaseColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;97;-239.9241,1049.878;Inherit;False;247;Fre;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;219;-137.4432,-300.5905;Inherit;False;Property;_BackFaceColor;BackFaceColor;54;2;[HDR];[Header];Create;True;1;BackFaceColor;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;270;-4426.468,3622.51;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;269;-4424.102,3891.456;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;89;-283.1122,798.7802;Inherit;True;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;426;180.2374,-339.3866;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;365;-4198.107,4185.035;Inherit;False;Property;_VertexOffset_ON;VertexOffset_ON;40;2;[Header];[Toggle];Create;True;1;VertexOffset;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;272;-4196.509,3649.304;Inherit;True;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;425;4.954834,861.7719;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;132;-4208.142,3912.192;Inherit;True;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;312;402.1699,-231.2404;Inherit;False;Property;_Float6;BackFaceIntensity;56;0;Create;False;0;0;0;False;0;False;1;1.65;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;266;-3613.661,3836.857;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwitchByFaceNode;215;421.5635,-363.412;Inherit;False;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;6;181.339,864.7761;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;137;-3330.328,3827.813;Inherit;False;VertexOffset;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;93;-5416.403,-2451.124;Inherit;False;1252.226;378.732;Comment;1;20;UV1;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;46;-6087.538,-2449.577;Inherit;False;490.0942;445.175;Comment;4;278;37;36;273;;1,1,1,1;0;0
Node;AmplifyShaderEditor.LerpOp;317;655.7153,-465.6074;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;387;387.8058,859.7117;Inherit;False;OP;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;273;-6045.568,-2194.716;Inherit;False;Property;_ZWriteMode;ZWriteMode;3;1;[Enum];Create;True;0;2;On;1;Off;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;280;-1794.274,4863.356;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;279;-2037.365,4747.333;Inherit;False;Property;_MaskTexPanner;MaskTexPanner;16;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;226;-485.0336,1349.988;Inherit;False;225;Mask_TexR;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;281;-1797.164,4724.129;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;218;876.515,-552.3127;Inherit;False;Property;_BackFace_ON;BackFace_ON;55;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;20;-5366.403,-2374.392;Inherit;True;0;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;37;-6038.538,-2100.825;Inherit;False;Property;_ZTestMode;ZTestMode;4;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CompareFunction;True;0;False;8;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;225;-489.3879,4629.167;Inherit;False;Mask_TexR;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;287;-1545.613,4849.852;Inherit;False;Property;_OwnUV;OwnUV;15;1;[Toggle];Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;283;-1584.39,4659.943;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;408;-2074.687,1072.326;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;228;-1581.328,4524.312;Inherit;False;-1;;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;339;1216.745,-452.6599;Inherit;False;137;VertexOffset;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;284;-1293.613,4633.574;Inherit;True;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;282;-1918.183,4528.089;Inherit;False;0;224;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;278;-6025.63,-2301.268;Inherit;False;Property;_Dst;Dst;2;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;0;False;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;386;1239.065,-658.0673;Inherit;False;387;OP;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;224;-1017.31,4609.019;Inherit;True;Property;_Mask_Tex;Mask_Tex;14;0;Create;True;0;0;0;False;0;False;-1;None;e6ad4352d94a9ac4eaddd2ce2b449964;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;36;-6034.058,-2399.578;Inherit;False;Property;_CullMode;CullMode;1;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1579.35,-845.1259;Float;False;True;-1;7;ASEMaterialInspector;0;0;CustomLighting;All_3;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;2;True;273;0;True;37;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;True;278;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;True;36;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;174;0;171;1
WireConnection;174;1;171;2
WireConnection;173;0;171;3
WireConnection;205;1;206;0
WireConnection;205;0;202;1
WireConnection;200;0;205;0
WireConnection;175;0;172;0
WireConnection;175;2;174;0
WireConnection;175;1;173;0
WireConnection;166;1;175;0
WireConnection;177;0;166;1
WireConnection;177;1;178;0
WireConnection;177;2;201;0
WireConnection;320;0;321;0
WireConnection;320;1;318;0
WireConnection;223;0;177;0
WireConnection;223;1;222;0
WireConnection;207;0;195;0
WireConnection;319;0;320;0
WireConnection;319;1;223;0
WireConnection;196;0;207;0
WireConnection;323;0;223;0
WireConnection;323;1;319;0
WireConnection;323;2;324;0
WireConnection;397;0;196;0
WireConnection;392;0;323;0
WireConnection;392;1;391;0
WireConnection;377;0;38;3
WireConnection;376;0;38;4
WireConnection;167;0;392;0
WireConnection;122;0;120;3
WireConnection;121;0;120;1
WireConnection;121;1;120;2
WireConnection;359;0;377;0
WireConnection;359;1;376;0
WireConnection;193;0;28;0
WireConnection;193;1;194;0
WireConnection;193;2;398;0
WireConnection;83;0;38;2
WireConnection;170;0;193;0
WireConnection;170;1;181;0
WireConnection;152;0;359;0
WireConnection;381;0;236;0
WireConnection;381;1;382;0
WireConnection;124;0;123;0
WireConnection;124;2;121;0
WireConnection;124;1;122;0
WireConnection;30;0;29;1
WireConnection;30;1;29;2
WireConnection;183;0;182;0
WireConnection;183;1;124;0
WireConnection;31;0;29;3
WireConnection;240;0;263;0
WireConnection;240;1;381;0
WireConnection;261;0;260;3
WireConnection;23;1;5;0
WireConnection;23;0;84;0
WireConnection;262;0;260;1
WireConnection;262;1;260;2
WireConnection;396;0;170;0
WireConnection;255;0;254;3
WireConnection;102;1;183;0
WireConnection;295;0;23;0
WireConnection;264;0;240;0
WireConnection;264;2;262;0
WireConnection;264;1;261;0
WireConnection;159;0;396;0
WireConnection;159;1;153;0
WireConnection;27;0;170;0
WireConnection;27;2;30;0
WireConnection;27;1;31;0
WireConnection;256;0;254;1
WireConnection;256;1;254;2
WireConnection;256;2;255;0
WireConnection;154;1;27;0
WireConnection;154;0;159;0
WireConnection;119;1;264;0
WireConnection;311;0;102;1
WireConnection;294;0;295;0
WireConnection;294;1;293;0
WireConnection;257;0;254;0
WireConnection;257;1;256;0
WireConnection;1;1;154;0
WireConnection;258;0;257;0
WireConnection;331;0;330;1
WireConnection;331;1;330;2
WireConnection;310;0;102;1
WireConnection;310;1;311;0
WireConnection;310;2;290;0
WireConnection;332;0;330;3
WireConnection;332;1;330;4
WireConnection;298;0;295;0
WireConnection;298;1;296;0
WireConnection;292;0;294;0
WireConnection;292;1;296;0
WireConnection;142;0;119;1
WireConnection;328;0;327;1
WireConnection;328;1;327;2
WireConnection;333;1;1;1
WireConnection;333;0;1;2
WireConnection;333;2;1;3
WireConnection;333;3;1;4
WireConnection;333;4;337;0
WireConnection;329;0;328;0
WireConnection;329;1;331;0
WireConnection;329;2;332;0
WireConnection;291;0;310;0
WireConnection;291;1;295;0
WireConnection;291;2;298;0
WireConnection;297;0;310;0
WireConnection;297;1;294;0
WireConnection;297;2;292;0
WireConnection;241;0;259;0
WireConnection;241;2;243;0
WireConnection;241;3;274;0
WireConnection;410;1;1;1
WireConnection;410;0;1;2
WireConnection;410;2;1;3
WireConnection;410;3;1;4
WireConnection;410;4;337;0
WireConnection;325;0;184;0
WireConnection;325;1;329;0
WireConnection;325;2;326;0
WireConnection;187;1;343;0
WireConnection;187;0;43;0
WireConnection;232;0;229;0
WireConnection;232;1;233;0
WireConnection;349;0;348;0
WireConnection;299;0;291;0
WireConnection;299;1;297;0
WireConnection;415;0;150;0
WireConnection;335;0;333;0
WireConnection;335;1;334;0
WireConnection;130;0;127;3
WireConnection;82;0;38;1
WireConnection;75;0;24;0
WireConnection;231;0;325;0
WireConnection;231;1;232;0
WireConnection;68;0;335;0
WireConnection;128;0;127;1
WireConnection;128;1;127;2
WireConnection;403;0;235;0
WireConnection;403;1;404;0
WireConnection;403;2;405;0
WireConnection;407;0;410;0
WireConnection;407;1;415;0
WireConnection;344;0;187;0
WireConnection;344;1;349;0
WireConnection;344;2;348;0
WireConnection;400;0;129;0
WireConnection;400;1;401;0
WireConnection;400;2;402;0
WireConnection;300;0;299;0
WireConnection;300;1;308;0
WireConnection;242;0;241;0
WireConnection;374;0;360;0
WireConnection;374;1;363;0
WireConnection;148;1;231;0
WireConnection;275;0;242;0
WireConnection;275;1;241;0
WireConnection;275;2;276;0
WireConnection;424;0;407;0
WireConnection;358;0;52;0
WireConnection;358;1;344;0
WireConnection;358;2;357;0
WireConnection;305;0;300;0
WireConnection;131;0;400;0
WireConnection;131;2;128;0
WireConnection;131;1;130;0
WireConnection;361;0;403;0
WireConnection;361;1;374;0
WireConnection;126;1;131;0
WireConnection;133;0;134;0
WireConnection;133;1;136;0
WireConnection;133;2;139;0
WireConnection;412;0;424;0
WireConnection;412;1;411;0
WireConnection;246;0;275;0
WireConnection;149;0;71;0
WireConnection;149;1;148;0
WireConnection;149;2;16;0
WireConnection;149;3;78;0
WireConnection;234;1;361;0
WireConnection;209;0;358;0
WireConnection;395;0;126;1
WireConnection;395;1;234;1
WireConnection;395;2;133;0
WireConnection;393;0;394;0
WireConnection;393;1;246;0
WireConnection;393;2;384;0
WireConnection;413;0;412;0
WireConnection;414;0;24;4
WireConnection;306;0;149;0
WireConnection;306;1;307;0
WireConnection;189;0;209;0
WireConnection;247;0;393;0
WireConnection;267;0;395;0
WireConnection;389;0;302;0
WireConnection;389;1;291;0
WireConnection;389;2;390;0
WireConnection;91;0;306;0
WireConnection;268;0;267;0
WireConnection;268;1;271;2
WireConnection;270;0;267;0
WireConnection;270;1;271;1
WireConnection;269;0;267;0
WireConnection;269;1;271;3
WireConnection;89;0;389;0
WireConnection;89;1;163;0
WireConnection;89;2;250;0
WireConnection;89;3;190;0
WireConnection;426;0;92;0
WireConnection;426;1;219;0
WireConnection;272;0;270;0
WireConnection;272;1;268;0
WireConnection;272;2;269;0
WireConnection;425;0;89;0
WireConnection;425;1;97;0
WireConnection;266;0;272;0
WireConnection;266;1;132;0
WireConnection;266;2;365;0
WireConnection;215;0;92;0
WireConnection;215;1;426;0
WireConnection;6;0;425;0
WireConnection;137;0;266;0
WireConnection;317;0;92;0
WireConnection;317;1;215;0
WireConnection;317;2;312;0
WireConnection;387;0;6;0
WireConnection;280;0;279;3
WireConnection;281;0;279;1
WireConnection;281;1;279;2
WireConnection;218;1;92;0
WireConnection;218;0;317;0
WireConnection;225;0;224;1
WireConnection;283;0;282;0
WireConnection;283;2;281;0
WireConnection;283;1;280;0
WireConnection;284;0;228;0
WireConnection;284;1;283;0
WireConnection;284;2;287;0
WireConnection;224;1;284;0
WireConnection;0;9;386;0
WireConnection;0;13;218;0
WireConnection;0;11;339;0
ASEEND*/
//CHKSM=0226D953DAD79727875ECDC47887E411326C216B