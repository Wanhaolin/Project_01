// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Whl/Fx/Crystal"
{
	Properties
	{
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("CullMode", Float) = 0
		[Enum(UnityEngine.Rendering.BlendMode)]_Dst("Dst", Float) = 10
		[Enum(On,1,Off,0)]_ZWriteMode("ZWriteMode", Float) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)]_ZTestMode("ZTestMode", Float) = 8
		[HDR][Header(Main)]_MainColor("MainColor", Color) = (0,0,0,0)
		[Toggle(_UV2_WTCONTROLOFFSET_ON)] _UV2_WTControlOffset("UV2_WTControlOffset", Float) = 0
		[Enum(UV1,0,UV2,1)]_ClampUVSet("ClampUV Set", Float) = 0
		_MainTex("MainTex", 2D) = "white" {}
		[Toggle]_DisturbMain("DisturbMain", Float) = 0
		[Toggle(_ALPHACHANNEL_ON)] _AlphaChannel("AlphaChannel", Float) = 0
		_Rotater("Rotater", Range( 0 , 360)) = 0
		_MainTexPanner("MainTexPanner", Vector) = (0,0,1,0)
		_Mask_Tex("Mask_Tex", 2D) = "white" {}
		[Toggle]_OwnUV("OwnUV", Float) = 0
		_MaskTexPanner("MaskTexPanner", Vector) = (0,0,1,0)
		[Header(Fade)]_FadeTex("FadeTex", 2D) = "white" {}
		_FadeTexPanner("FadeTexPanner", Vector) = (0,0,1,0)
		[Toggle(_DISTURBFADETEX_ON)] _DisturbFadeTex("DisturbFadeTex", Float) = 0
		_RampTex("RampTex", 2D) = "white" {}
		[Enum(Default,0,Screen,1)]_UVType("UVType", Float) = 1
		_ScreenTilingOffset("ScreenTilingOffset", Vector) = (1,1,0,0)
		[Toggle(_DISTURBRAMP_ON)] _DisturbRamp("DisturbRamp", Float) = 0
		_RampDisStr("RampDisStr", Float) = 0
		[Header(Dissolution)]_DissolutionTex("DissolutionTex", 2D) = "white" {}
		[Toggle(_UV1_TCONTORLDIS_ON)] _UV1_TContorlDis("UV1_TContorlDis", Float) = 0
		_Dissolution("Dissolution", Range( 0 , 1)) = 0.15
		_DissolutionSoft("DissolutionSoft", Range( 0 , 0.99999)) = 0.3935294
		_DissolutionTexPanner("DissolutionTexPanner", Vector) = (0,0,1,0)
		[Toggle(_UV3_XCONTORLDISTURB_ON)] _UV3_XContorlDisturb("UV3_XContorlDisturb", Float) = 0
		[Toggle(_UV1_WCONTORLVERTEXOFFSET_ON)] _UV1_WContorlVertexOffset("UV1_WContorlVertexOffset", Float) = 0
		[Header(VertexOffset)]_VertexOffsetTex("VertexOffsetTex", 2D) = "white" {}
		[Toggle(_VERTEXOFFSETON_ON)] _VertexOffsetOn("VertexOffsetOn", Float) = 0
		_VertexOffsetMask("VertexOffsetMask", 2D) = "white" {}
		_VertexOffsetTexPanner("VertexOffsetTexPanner", Vector) = (0,0,1,0)
		_OffsetDir("OffsetDir", Vector) = (1,1,1,0)
		_VertexOffsetStr("VertexOffsetStr", Float) = 1
		[Header(Disturb)]_DisturbTex("DisturbTex", 2D) = "white" {}
		[Toggle(_DISTURBON_ON)] _DisturbOn("DisturbOn", Float) = 0
		_DisturbPanner("DisturbPanner", Vector) = (0,0,1,0)
		_DisturbDir("DisturbDir", Vector) = (1,1,0,0)
		_DisturbStr("DisturbStr", Float) = 0
		[Header(SoftParticle)]_FadeRange("FadeRange", Float) = 1
		[Toggle(_SOFTPARTICLE_ON)] _SoftParticle("SoftParticle", Float) = 0
		_FreOn("FreOn", Range( 0 , 1)) = 0
		_FreInvers("FreInvers", Range( 0 , 1)) = 0
		_FreScale("FreScale", Float) = 1
		_FrePower("FrePower", Float) = 5
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord3( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
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
		#pragma target 4.5
		#pragma shader_feature_local _VERTEXOFFSETON_ON
		#pragma shader_feature_local _UV1_WCONTORLVERTEXOFFSET_ON
		#pragma shader_feature_local _DISTURBON_ON
		#pragma shader_feature_local _UV3_XCONTORLDISTURB_ON
		#pragma shader_feature_local _UV1_TCONTORLDIS_ON
		#pragma shader_feature_local _SOFTPARTICLE_ON
		#pragma shader_feature_local _DISTURBFADETEX_ON
		#pragma shader_feature_local _UV2_WTCONTROLOFFSET_ON
		#pragma shader_feature_local _ALPHACHANNEL_ON
		#pragma shader_feature_local _DISTURBRAMP_ON
		#pragma surface surf StandardCustomLighting keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 uv_texcoord;
			float2 uv3_texcoord3;
			float4 screenPos;
			float4 vertexColor : COLOR;
			float4 uv2_texcoord2;
			float3 worldPos;
			float3 worldNormal;
			half ASEVFace : VFACE;
			INTERNAL_DATA
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
		uniform float3 _OffsetDir;
		uniform sampler2D _VertexOffsetMask;
		uniform float4 _VertexOffsetMask_ST;
		uniform float _VertexOffsetStr;
		uniform sampler2D _DissolutionTex;
		uniform sampler2D _DisturbTex;
		uniform float3 _DisturbPanner;
		uniform float4 _DisturbTex_ST;
		uniform float _DisturbStr;
		uniform float2 _DisturbDir;
		uniform float3 _DissolutionTexPanner;
		uniform float4 _DissolutionTex_ST;
		uniform float _Dissolution;
		uniform float _DissolutionSoft;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _FadeRange;
		uniform sampler2D _FadeTex;
		uniform float3 _FadeTexPanner;
		uniform float4 _FadeTex_ST;
		uniform sampler2D _Mask_Tex;
		uniform float3 _MainTexPanner;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float _ClampUVSet;
		uniform float _Rotater;
		uniform float3 _MaskTexPanner;
		uniform float4 _Mask_Tex_ST;
		uniform float _OwnUV;
		uniform float _DisturbMain;
		uniform float _FreScale;
		uniform float _FrePower;
		uniform float _FreInvers;
		uniform float _FreOn;
		uniform sampler2D _RampTex;
		uniform float4 _RampTex_ST;
		uniform float4 _ScreenTilingOffset;
		uniform float _UVType;
		uniform float _RampDisStr;
		uniform float4 _MainColor;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 temp_cast_0 = (0.0).xxx;
			float mulTime56 = _Time.y * _VertexOffsetTexPanner.z;
			float2 appendResult55 = (float2(_VertexOffsetTexPanner.x , _VertexOffsetTexPanner.y));
			float4 uv2s_VertexOffsetTex = v.texcoord1;
			uv2s_VertexOffsetTex.xy = v.texcoord1.xy * _VertexOffsetTex_ST.xy + _VertexOffsetTex_ST.zw;
			float2 panner57 = ( mulTime56 * appendResult55 + uv2s_VertexOffsetTex.xy);
			float4 tex2DNode58 = tex2Dlod( _VertexOffsetTex, float4( panner57, 0, 0.0) );
			float3 appendResult71 = (float3(( tex2DNode58.r * _OffsetDir.x ) , ( tex2DNode58.r * _OffsetDir.y ) , ( tex2DNode58.r * _OffsetDir.z )));
			#ifdef _UV1_WCONTORLVERTEXOFFSET_ON
				float staticSwitch16 = v.texcoord.z;
			#else
				float staticSwitch16 = 1.0;
			#endif
			float UV1_W17 = staticSwitch16;
			float4 uv2s_VertexOffsetMask = v.texcoord1;
			uv2s_VertexOffsetMask.xy = v.texcoord1.xy * _VertexOffsetMask_ST.xy + _VertexOffsetMask_ST.zw;
			float3 ase_vertexNormal = v.normal.xyz;
			#ifdef _VERTEXOFFSETON_ON
				float3 staticSwitch75 = ( appendResult71 * ( UV1_W17 * tex2Dlod( _VertexOffsetMask, float4( uv2s_VertexOffsetMask.xy, 0, 0.0) ).r * ( 0.1 * _VertexOffsetStr ) ) * ase_vertexNormal );
			#else
				float3 staticSwitch75 = temp_cast_0;
			#endif
			float3 VertexOffset76 = staticSwitch75;
			v.vertex.xyz += VertexOffset76;
			v.vertex.w = 1;
		}

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float2 temp_cast_0 = (0.0).xx;
			float mulTime100 = _Time.y * _DisturbPanner.z;
			float2 appendResult99 = (float2(_DisturbPanner.x , _DisturbPanner.y));
			float4 uvs_DisturbTex = i.uv_texcoord;
			uvs_DisturbTex.xy = i.uv_texcoord.xy * _DisturbTex_ST.xy + _DisturbTex_ST.zw;
			float2 panner101 = ( mulTime100 * appendResult99 + uvs_DisturbTex.xy);
			#ifdef _UV3_XCONTORLDISTURB_ON
				float staticSwitch5 = i.uv3_texcoord3.x;
			#else
				float staticSwitch5 = 1.0;
			#endif
			float UV3_X6 = staticSwitch5;
			#ifdef _DISTURBON_ON
				float2 staticSwitch109 = ( ( tex2D( _DisturbTex, panner101 ).r * _DisturbStr * UV3_X6 ) * _DisturbDir );
			#else
				float2 staticSwitch109 = temp_cast_0;
			#endif
			float2 DisturbColor110 = staticSwitch109;
			float mulTime137 = _Time.y * _DissolutionTexPanner.z;
			float2 appendResult136 = (float2(_DissolutionTexPanner.x , _DissolutionTexPanner.y));
			float4 uvs_DissolutionTex = i.uv_texcoord;
			uvs_DissolutionTex.xy = i.uv_texcoord.xy * _DissolutionTex_ST.xy + _DissolutionTex_ST.zw;
			float2 panner139 = ( mulTime137 * appendResult136 + uvs_DissolutionTex.xy);
			float temp_output_3_0_g30 = tex2D( _DissolutionTex, ( DisturbColor110 + panner139 ) ).r;
			float lerpResult5_g30 = lerp( temp_output_3_0_g30 , ( 1.0 - temp_output_3_0_g30 ) , 0.0);
			#ifdef _UV1_TCONTORLDIS_ON
				float staticSwitch13 = i.uv_texcoord.w;
			#else
				float staticSwitch13 = _Dissolution;
			#endif
			float UV1_T14 = staticSwitch13;
			float temp_output_8_0_g30 = _DissolutionSoft;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth149 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth149 = abs( ( screenDepth149 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _FadeRange ) );
			#ifdef _SOFTPARTICLE_ON
				float staticSwitch153 = distanceDepth149;
			#else
				float staticSwitch153 = 1.0;
			#endif
			float SoftParticle163 = saturate( staticSwitch153 );
			float VertexColorA82 = i.vertexColor.a;
			float mulTime119 = _Time.y * _FadeTexPanner.z;
			float2 appendResult115 = (float2(_FadeTexPanner.x , _FadeTexPanner.y));
			float4 uv2s_FadeTex = i.uv2_texcoord2;
			uv2s_FadeTex.xy = i.uv2_texcoord2.xy * _FadeTex_ST.xy + _FadeTex_ST.zw;
			float2 panner124 = ( mulTime119 * appendResult115 + uv2s_FadeTex.xy);
			float2 temp_cast_1 = (0.0).xx;
			#ifdef _DISTURBFADETEX_ON
				float2 staticSwitch126 = DisturbColor110;
			#else
				float2 staticSwitch126 = temp_cast_1;
			#endif
			float FadeTexR132 = tex2D( _FadeTex, ( panner124 + staticSwitch126 ) ).r;
			float mulTime32 = _Time.y * _MainTexPanner.z;
			float2 appendResult33 = (float2(_MainTexPanner.x , _MainTexPanner.y));
			float4 uvs_MainTex = i.uv_texcoord;
			uvs_MainTex.xy = i.uv_texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
			float2 panner35 = ( mulTime32 * appendResult33 + uvs_MainTex.xy);
			float4 uv2s_MainTex = i.uv2_texcoord2;
			uv2s_MainTex.xy = i.uv2_texcoord2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
			float2 lerpResult236 = lerp( uvs_MainTex.xy , uv2s_MainTex.xy , _ClampUVSet);
			float UV2_W8 = i.uv2_texcoord2.z;
			float UV2_T9 = i.uv2_texcoord2.w;
			float2 appendResult31 = (float2(UV2_W8 , UV2_T9));
			#ifdef _UV2_WTCONTROLOFFSET_ON
				float2 staticSwitch39 = ( lerpResult236 + appendResult31 );
			#else
				float2 staticSwitch39 = panner35;
			#endif
			float2 temp_cast_2 = (0.5).xx;
			float cos40 = cos( ( (0.0 + (_Rotater - 0.0) * (2.0 - 0.0) / (360.0 - 0.0)) * UNITY_PI ) );
			float sin40 = sin( ( (0.0 + (_Rotater - 0.0) * (2.0 - 0.0) / (360.0 - 0.0)) * UNITY_PI ) );
			float2 rotator40 = mul( staticSwitch39 - temp_cast_2 , float2x2( cos40 , -sin40 , sin40 , cos40 )) + temp_cast_2;
			float2 MainTexUV45 = rotator40;
			float mulTime121 = _Time.y * _MaskTexPanner.z;
			float2 appendResult118 = (float2(_MaskTexPanner.x , _MaskTexPanner.y));
			float4 uv2s_Mask_Tex = i.uv2_texcoord2;
			uv2s_Mask_Tex.xy = i.uv2_texcoord2.xy * _Mask_Tex_ST.xy + _Mask_Tex_ST.zw;
			float2 panner123 = ( mulTime121 * appendResult118 + uv2s_Mask_Tex.xy);
			float2 lerpResult128 = lerp( MainTexUV45 , panner123 , _OwnUV);
			float Mask_TexR131 = tex2D( _Mask_Tex, lerpResult128 ).r;
			float2 lerpResult233 = lerp( float2( 0,0 ) , DisturbColor110 , _DisturbMain);
			float4 tex2DNode43 = tex2D( _MainTex, ( rotator40 + lerpResult233 ) );
			#ifdef _ALPHACHANNEL_ON
				float staticSwitch47 = tex2DNode43.a;
			#else
				float staticSwitch47 = tex2DNode43.r;
			#endif
			float MainTexAlpha48 = staticSwitch47;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float3 ase_normWorldNormal = normalize( ase_worldNormal );
			float3 appendResult194 = (float3(ase_normWorldNormal.x , ase_normWorldNormal.y , -ase_normWorldNormal.z));
			float3 switchResult195 = (((i.ASEVFace>0)?(ase_normWorldNormal):(appendResult194)));
			float3 WorldNormal197 = switchResult195;
			float fresnelNdotV201 = dot( WorldNormal197, ase_worldViewDir );
			float fresnelNode201 = ( 0.0 + _FreScale * pow( max( 1.0 - fresnelNdotV201 , 0.0001 ), _FrePower ) );
			float lerpResult204 = lerp( ( 1.0 - fresnelNode201 ) , fresnelNode201 , _FreInvers);
			float clampResult205 = clamp( lerpResult204 , 0.0 , 1.0 );
			float FreOP206 = clampResult205;
			float lerpResult167 = lerp( 1.0 , FreOP206 , _FreOn);
			float FinalOpacity172 = saturate( ( saturate( ( ( ( ( lerpResult5_g30 + 1.0 ) - ( ( 1.0 - (-0.5 + (UV1_T14 - 0.0) * (1.0 - -0.5) / (1.0 - 0.0)) ) * ( ( 1.0 - temp_output_8_0_g30 ) + 1.0 ) ) ) - temp_output_8_0_g30 ) / ( temp_output_8_0_g30 - 1.0 ) ) ) * SoftParticle163 * VertexColorA82 * FadeTexR132 * Mask_TexR131 * MainTexAlpha48 * lerpResult167 ) );
			float3 MainTexColor50 = (tex2DNode43).rgb;
			float4 uvs_RampTex = i.uv_texcoord;
			uvs_RampTex.xy = i.uv_texcoord.xy * _RampTex_ST.xy + _RampTex_ST.zw;
			float2 appendResult240 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
			float2 appendResult241 = (float2(_ScreenTilingOffset.x , _ScreenTilingOffset.y));
			float2 appendResult242 = (float2(_ScreenTilingOffset.z , _ScreenTilingOffset.w));
			float2 lerpResult245 = lerp( uvs_RampTex.xy , (appendResult240*appendResult241 + appendResult242) , _UVType);
			#ifdef _DISTURBRAMP_ON
				float2 staticSwitch91 = ( lerpResult245 + ( DisturbColor110 * _RampDisStr ) );
			#else
				float2 staticSwitch91 = lerpResult245;
			#endif
			float4 VertexColorRGB83 = i.vertexColor;
			float4 MainColor95 = ( float4( MainTexColor50 , 0.0 ) * tex2D( _RampTex, staticSwitch91 ) * _MainColor * VertexColorRGB83 );
			c.rgb = MainColor95.rgb;
			c.a = FinalOpacity172;
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
-1343;706;1143;749;1600.218;-1020.938;1.99902;True;False
Node;AmplifyShaderEditor.CommentaryNode;1;-1842.311,641.3597;Inherit;False;1124.562;519.4683;Comment;4;6;5;3;2;UV3;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;96;-4478.587,1543.175;Inherit;False;1883.194;986.6012;DisturbColor;14;110;109;108;107;106;105;104;103;102;101;100;99;98;97;DisturbColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-1775.793,816.6868;Inherit;False;2;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;97;-4374.363,1846.509;Inherit;False;Property;_DisturbPanner;DisturbPanner;39;0;Create;True;0;0;0;False;0;False;0,0,1;0,-0.4,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;2;-1737.846,701.6654;Inherit;False;Constant;_Float12;Float 12;28;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;191;2384.62,3904.313;Inherit;False;1088.13;274.4167;WorldNormal;5;197;195;194;193;192;WorldNormal;1,1,1,1;0;0
Node;AmplifyShaderEditor.StaticSwitch;5;-1475.846,730.6655;Inherit;False;Property;_UV3_XContorlDisturb;UV3_XContorlDisturb;29;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;4;-1807.129,32.75175;Inherit;False;1143.907;365.912;Comment;3;9;8;7;UV2;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;99;-4123.364,1799.509;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;100;-4126.364,1953.509;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;98;-4321.18,1686.266;Inherit;False;0;102;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;7;-1778.1,96.67266;Inherit;False;1;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldNormalVector;192;2434.62,3954.313;Inherit;False;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;6;-1156.673,754.0307;Inherit;False;UV3_X;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;101;-3941.683,1767.647;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;24;-425.981,-9.324951;Inherit;False;2832.174;1028.443;MainTex;29;28;29;50;49;48;47;43;42;233;45;234;41;40;37;38;39;36;35;34;33;31;30;32;27;26;25;235;236;237;MainTex;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;9;-1311.056,209.7258;Inherit;False;UV2_T;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;102;-3702.548,1755.801;Inherit;True;Property;_DisturbTex;DisturbTex;37;1;[Header];Create;True;1;Disturb;0;0;False;0;False;-1;None;b111d5f279d12c64c844b5cc4f357c2a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;103;-3612.324,1961.487;Inherit;False;Property;_DisturbStr;DisturbStr;41;0;Create;True;0;0;0;False;0;False;0;-0.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;104;-3622.415,2085.175;Inherit;False;6;UV3_X;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;193;2637.346,4067.731;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;8;-1309.592,115.0347;Inherit;False;UV2_W;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;106;-3397.316,2122.205;Inherit;False;Property;_DisturbDir;DisturbDir;40;0;Create;True;0;0;0;False;0;False;1,1;1,0.5;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;105;-3369.95,1938.053;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;26;-375.981,200.9192;Inherit;False;Property;_MainTexPanner;MainTexPanner;12;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;25;-325.7104,835.1791;Inherit;False;9;UV2_T;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;237;-323.0288,643.8226;Inherit;False;Property;_ClampUVSet;ClampUV Set;7;1;[Enum];Create;True;0;2;UV1;0;UV2;1;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;27;-328.4404,740.531;Inherit;False;8;UV2_W;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;28;-376.3748,361.1963;Inherit;False;0;43;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;235;-377.4108,494.5212;Inherit;False;1;43;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;194;2794.346,4010.73;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;30;246.468,419.5912;Inherit;False;Property;_Rotater;Rotater;11;0;Create;True;0;0;0;False;0;False;0;0;0;360;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;31;-94.16705,762.0971;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;236;-96.59406,452.6121;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;29;-322.7981,40.67505;Inherit;False;0;43;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;32;-127.9819,307.9192;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;107;-3325.352,1704.776;Inherit;False;Constant;_0;0;32;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;33;-124.9819,153.9192;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;108;-3211.897,1942.148;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SwitchByFaceNode;195;3031.346,3959.73;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;109;-3061.894,1796.113;Inherit;False;Property;_DisturbOn;DisturbOn;38;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;196;2380.299,2997.039;Inherit;False;1485.673;682.3762;FreOP;9;206;205;204;203;202;201;200;199;198;FreOP;1,1,1,1;0;0
Node;AmplifyShaderEditor.PannerNode;35;56.698,122.0562;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;36;519.239,425.3131;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;360;False;3;FLOAT;0;False;4;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;197;3248.75,3955.584;Inherit;False;WorldNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;34;87.08105,441.8892;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;200;2434.299,3229.472;Inherit;False;Property;_FreScale;FreScale;46;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;38;553.504,324.2952;Inherit;False;Constant;_Float11;Float 11;26;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;198;2411.368,3130.866;Inherit;False;197;WorldNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;111;-451.3299,5366.445;Inherit;False;1826.183;1688.764;FadeTex;21;132;131;130;129;128;127;126;125;124;123;122;121;120;119;118;117;116;115;114;113;112;FadeTex;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;110;-2819.219,1802.959;Inherit;False;DisturbColor;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;133;-5137.355,2975.876;Inherit;False;4022.833;1852.103;Comment;25;174;172;171;170;169;167;166;165;164;162;160;158;156;148;147;144;141;140;139;138;137;136;135;134;232;FinalOpacity;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;199;2464.652,3319.487;Inherit;False;Property;_FrePower;FrePower;47;0;Create;True;0;0;0;False;0;False;5;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;39;316.093,237.4363;Inherit;False;Property;_UV2_WTControlOffset;UV2_WTControlOffset;6;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PiNode;37;695.53,425.3062;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;112;-403.9213,5707.49;Inherit;False;Property;_FadeTexPanner;FadeTexPanner;17;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;234;749.6494,669.9853;Inherit;False;Property;_DisturbMain;DisturbMain;9;1;[Toggle];Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;113;-423.664,6672.639;Inherit;False;Property;_MaskTexPanner;MaskTexPanner;15;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RotatorNode;40;801.4661,267.9152;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;41;676.7211,574.6072;Inherit;False;110;DisturbColor;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;138;-3329.49,4411.978;Inherit;False;1080.439;324.1655;SoftParticle;6;163;155;153;150;149;142;SoftParticle;1,1,1,1;0;0
Node;AmplifyShaderEditor.FresnelNode;201;2653.613,3156.353;Inherit;True;Standard;WorldNormal;ViewDir;False;True;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;52;-477.0093,2995.487;Inherit;False;2578.479;1252.42;VertexOffset;24;76;75;74;73;72;71;70;69;68;67;66;65;64;63;62;61;60;59;58;57;56;55;54;53;VertexOffset;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;142;-3268.151,4599.957;Inherit;False;Property;_FadeRange;FadeRange;42;1;[Header];Create;True;1;SoftParticle;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;116;-270.0294,5912.02;Inherit;False;Constant;_Float13;Float 13;30;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;239;-953.5964,1714.087;Inherit;False;Property;_ScreenTilingOffset;ScreenTilingOffset;21;0;Create;True;0;0;0;False;0;False;1,1,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;115;-152.9222,5660.49;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;202;2965.608,3224.215;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;238;-868.0776,1522.253;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;45;1163.955,138.7271;Inherit;False;MainTexUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;118;-183.463,6649.436;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;119;-175.9222,5814.49;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;233;967.6494,582.9853;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;121;-180.5726,6788.662;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;10;-1811.523,-633.8793;Inherit;False;1252.226;378.732;Comment;7;17;16;15;14;13;12;11;UV1;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;203;2852.443,3487.896;Inherit;False;Property;_FreInvers;FreInvers;45;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;114;-311.6336,5524.423;Inherit;False;1;129;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;117;-304.4821,6453.396;Inherit;False;1;130;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;53;-422.9581,3235.177;Inherit;False;Property;_VertexOffsetTexPanner;VertexOffsetTexPanner;34;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;134;-4793.914,3443.101;Inherit;False;Property;_DissolutionTexPanner;DissolutionTexPanner;28;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;120;-314.0294,5996.802;Inherit;False;110;DisturbColor;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;122;68.08802,6851.938;Inherit;False;Property;_OwnUV;OwnUV;14;1;[Toggle];Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;136;-4526.915,3451.101;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;85;-382.5702,1303.637;Inherit;False;2307.636;1024.326;MainColor;12;79;78;92;94;95;93;91;90;89;86;87;245;MainColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;242;-718.6455,1799.524;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;241;-717.6284,1690.694;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;42;1035.845,303.8541;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;125;32.37385,6526.396;Inherit;False;45;MainTexUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;55;-69.06326,3237.793;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;135;-4702.733,3302.858;Inherit;False;0;147;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;126;-11.23467,5914.935;Inherit;False;Property;_DisturbFadeTex;DisturbFadeTex;18;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;240;-671.0776,1551.253;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;54;-371.3203,3057.639;Inherit;False;1;58;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;123;29.31153,6662.027;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;137;-4528.915,3558.101;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;150;-3014.539,4491.659;Inherit;False;Constant;_Float1;Float 1;14;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-1550.96,-340.0912;Inherit;False;Property;_Dissolution;Dissolution;26;0;Create;True;0;0;0;False;0;False;0.15;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;124;27.75764,5590.626;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;11;-1761.523,-557.1473;Inherit;True;0;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;56;-103.0643,3331.793;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;149;-3088.626,4580.144;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-1498.006,-583.8793;Inherit;False;Constant;_Float0;Float 0;7;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;204;3146.443,3153.896;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;127;302.623,5815.583;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;88;-822.8348,1327.902;Inherit;False;0;93;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;86;-247.9384,1866.746;Inherit;False;110;DisturbColor;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;243;-395.6594,1770.998;Inherit;False;Property;_UVType;UVType;20;1;[Enum];Create;True;0;2;Default;0;Screen;1;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;13;-1214.935,-412.2443;Inherit;False;Property;_UV1_TContorlDis;UV1_TContorlDis;25;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;205;3396.948,3153.617;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;16;-1202.697,-576.0903;Inherit;False;Property;_UV1_WContorlVertexOffset;UV1_WContorlVertexOffset;30;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;57;124.6828,3150.771;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;128;320.088,6635.658;Inherit;True;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;80;-159.9101,-577.5741;Inherit;False;498.0005;281.3341;VertexColor;3;83;82;81;VertexColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;87;-212.8428,1953.859;Inherit;False;Property;_RampDisStr;RampDisStr;23;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;43;1180.888,235.9812;Inherit;True;Property;_MainTex;MainTex;8;0;Create;True;0;0;0;False;0;False;-1;None;2eda5bbd0a3045f48b244533790ad997;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;139;-4324.336,3309.839;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;244;-504.0356,1651.027;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;153;-2824.893,4491.904;Inherit;False;Property;_SoftParticle;SoftParticle;43;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;140;-4370.825,3214.638;Inherit;False;110;DisturbColor;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.VertexColorNode;81;-109.9101,-527.5741;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;60;631.9968,3379.773;Inherit;True;Property;_OffsetDir;OffsetDir;35;0;Create;True;0;0;0;False;0;False;1,1,1;1,1,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;17;-835.15,-573.7432;Inherit;False;UV1_W;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;89;22.78276,1847.494;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;245;-163.4793,1531.15;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;59;52.4358,3869.864;Inherit;False;1;68;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;144;-4091.825,3252.638;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;58;380.4658,3114.629;Inherit;True;Property;_VertexOffsetTex;VertexOffsetTex;31;1;[Header];Create;True;1;VertexOffset;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;206;3551.153,3148.132;Inherit;False;FreOP;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;129;429.9398,5749.486;Inherit;True;Property;_FadeTex;FadeTex;16;1;[Header];Create;True;1;Fade;0;0;False;0;False;-1;None;a210020055f1f4d43b47c8697abe0702;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;130;596.3913,6611.104;Inherit;True;Property;_Mask_Tex;Mask_Tex;13;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;47;1720.089,197.9355;Inherit;False;Property;_AlphaChannel;AlphaChannel;10;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;155;-2603.938,4497.727;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;62;269.6267,4068.92;Inherit;False;Constant;_Float7;Float 7;25;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;63;241.3257,4161.619;Inherit;False;Property;_VertexOffsetStr;VertexOffsetStr;36;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;14;-838.693,-415.4552;Inherit;False;UV1_T;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;69;924.5399,3321.763;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;141;-3570.125,3434.35;Inherit;False;14;UV1_T;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;131;942.2116,6633.11;Inherit;False;Mask_TexR;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;162;-2756.633,3865.826;Inherit;False;206;FreOP;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;158;-2806.859,3976.322;Inherit;False;Property;_FreOn;FreOn;44;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;65;920.6549,3474.532;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;174;-3614.911,3342.94;Inherit;False;Constant;_Invers;Invers;27;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;160;-2725.369,3766.431;Inherit;False;Constant;_Float15;Float 15;39;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;67;929.2869,3174.586;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;148;-3621.687,3529.655;Inherit;False;Property;_DissolutionSoft;DissolutionSoft;27;0;Create;True;0;0;0;False;0;False;0.3935294;0.99999;0;0.99999;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;497.5359,4133.044;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;48;2010.437,186.6792;Inherit;False;MainTexAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;132;746.023,5773.021;Inherit;False;FadeTexR;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;68;340.8508,3848.198;Inherit;True;Property;_VertexOffsetMask;VertexOffsetMask;33;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;90;187.5486,1757.22;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;163;-2472.158,4491.514;Inherit;False;SoftParticle;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;82;108.7652,-412.2401;Inherit;False;VertexColorA;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;64;404.8137,3740.105;Inherit;False;17;UV1_W;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;147;-3910.041,3225.093;Inherit;True;Property;_DissolutionTex;DissolutionTex;24;1;[Header];Create;True;1;Dissolution;0;0;False;0;False;-1;None;a843b36626824c749ab85b2033b5abf3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;49;1722.85,381.4721;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;91;332.0618,1622.646;Inherit;False;Property;_DisturbRamp;DisturbRamp;22;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;165;-2509.119,3567.053;Inherit;False;132;FadeTexR;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;166;-2515.429,3663.662;Inherit;False;131;Mask_TexR;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;70;831.647,3907.977;Inherit;True;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;169;-2521.634,3376.527;Inherit;False;163;SoftParticle;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;232;-3171.099,3250.812;Inherit;False;Dissolution;-1;;30;8ed0a8fdbfe80554382ce257577aff19;0;4;3;FLOAT;0;False;7;FLOAT;0;False;4;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;72;844.2069,3751.133;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;71;1130.246,3257.38;Inherit;True;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;83;107.0904,-518.6681;Inherit;False;VertexColorRGB;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;164;-2531.002,3471.342;Inherit;False;82;VertexColorA;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;50;2013.826,385.7239;Inherit;False;MainTexColor;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;167;-2488.021,3855.522;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;156;-2521.108,3745.882;Inherit;False;48;MainTexAlpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;93;588.3725,1623.866;Inherit;True;Property;_RampTex;RampTex;19;0;Create;True;0;0;0;False;0;False;-1;None;45296aaf6a239694189d194d6fd5f45e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;78;663.1981,1834.66;Inherit;False;Property;_MainColor;MainColor;5;2;[HDR];[Header];Create;True;1;Main;0;0;False;0;False;0,0,0,0;2.996078,2.996078,2.996078,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;92;658.6784,1404.831;Inherit;True;50;MainTexColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;79;676.722,2035.723;Inherit;False;83;VertexColorRGB;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;73;1399.467,3453.934;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;74;1376.357,3315.45;Inherit;False;Constant;_Float2;Float 2;27;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;170;-2207.379,3324.663;Inherit;True;7;7;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;171;-1987.439,3335.071;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;75;1577.691,3386.662;Inherit;False;Property;_VertexOffsetOn;VertexOffsetOn;32;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;94;1092.344,1559.641;Inherit;False;4;4;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;95;1305.857,1552.734;Inherit;True;MainColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;18;-2306.771,-625.7122;Inherit;False;490.0942;445.175;Comment;4;22;21;20;19;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;172;-1790.164,3330.098;Inherit;False;FinalOpacity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;76;1864.155,3387.167;Inherit;False;VertexOffset;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-2259.863,-490.4032;Inherit;False;Property;_Dst;Dst;2;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;0;False;10;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-2265.771,-308.9602;Inherit;False;Property;_ZTestMode;ZTestMode;4;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CompareFunction;True;0;False;8;8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;51;3119.581,1273.813;Inherit;False;95;MainColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;61;350.9332,3429.797;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-1;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;176;3250.307,1419.025;Inherit;False;172;FinalOpacity;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-2253.291,-575.7133;Inherit;False;Property;_CullMode;CullMode;1;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;77;3305.627,1575.558;Inherit;False;76;VertexOffset;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-2260.802,-397.8512;Inherit;False;Property;_ZWriteMode;ZWriteMode;3;1;[Enum];Create;True;0;2;On;1;Off;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;3588.733,1134.664;Float;False;True;-1;5;ASEMaterialInspector;0;0;CustomLighting;Whl/Fx/Crystal;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;0;True;21;0;True;20;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;True;19;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;True;22;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;5;1;2;0
WireConnection;5;0;3;1
WireConnection;99;0;97;1
WireConnection;99;1;97;2
WireConnection;100;0;97;3
WireConnection;6;0;5;0
WireConnection;101;0;98;0
WireConnection;101;2;99;0
WireConnection;101;1;100;0
WireConnection;9;0;7;4
WireConnection;102;1;101;0
WireConnection;193;0;192;3
WireConnection;8;0;7;3
WireConnection;105;0;102;1
WireConnection;105;1;103;0
WireConnection;105;2;104;0
WireConnection;194;0;192;1
WireConnection;194;1;192;2
WireConnection;194;2;193;0
WireConnection;31;0;27;0
WireConnection;31;1;25;0
WireConnection;236;0;28;0
WireConnection;236;1;235;0
WireConnection;236;2;237;0
WireConnection;32;0;26;3
WireConnection;33;0;26;1
WireConnection;33;1;26;2
WireConnection;108;0;105;0
WireConnection;108;1;106;0
WireConnection;195;0;192;0
WireConnection;195;1;194;0
WireConnection;109;1;107;0
WireConnection;109;0;108;0
WireConnection;35;0;29;0
WireConnection;35;2;33;0
WireConnection;35;1;32;0
WireConnection;36;0;30;0
WireConnection;197;0;195;0
WireConnection;34;0;236;0
WireConnection;34;1;31;0
WireConnection;110;0;109;0
WireConnection;39;1;35;0
WireConnection;39;0;34;0
WireConnection;37;0;36;0
WireConnection;40;0;39;0
WireConnection;40;1;38;0
WireConnection;40;2;37;0
WireConnection;201;0;198;0
WireConnection;201;2;200;0
WireConnection;201;3;199;0
WireConnection;115;0;112;1
WireConnection;115;1;112;2
WireConnection;202;0;201;0
WireConnection;45;0;40;0
WireConnection;118;0;113;1
WireConnection;118;1;113;2
WireConnection;119;0;112;3
WireConnection;233;1;41;0
WireConnection;233;2;234;0
WireConnection;121;0;113;3
WireConnection;136;0;134;1
WireConnection;136;1;134;2
WireConnection;242;0;239;3
WireConnection;242;1;239;4
WireConnection;241;0;239;1
WireConnection;241;1;239;2
WireConnection;42;0;40;0
WireConnection;42;1;233;0
WireConnection;55;0;53;1
WireConnection;55;1;53;2
WireConnection;126;1;116;0
WireConnection;126;0;120;0
WireConnection;240;0;238;1
WireConnection;240;1;238;2
WireConnection;123;0;117;0
WireConnection;123;2;118;0
WireConnection;123;1;121;0
WireConnection;137;0;134;3
WireConnection;124;0;114;0
WireConnection;124;2;115;0
WireConnection;124;1;119;0
WireConnection;56;0;53;3
WireConnection;149;0;142;0
WireConnection;204;0;202;0
WireConnection;204;1;201;0
WireConnection;204;2;203;0
WireConnection;127;0;124;0
WireConnection;127;1;126;0
WireConnection;13;1;12;0
WireConnection;13;0;11;4
WireConnection;205;0;204;0
WireConnection;16;1;15;0
WireConnection;16;0;11;3
WireConnection;57;0;54;0
WireConnection;57;2;55;0
WireConnection;57;1;56;0
WireConnection;128;0;125;0
WireConnection;128;1;123;0
WireConnection;128;2;122;0
WireConnection;43;1;42;0
WireConnection;139;0;135;0
WireConnection;139;2;136;0
WireConnection;139;1;137;0
WireConnection;244;0;240;0
WireConnection;244;1;241;0
WireConnection;244;2;242;0
WireConnection;153;1;150;0
WireConnection;153;0;149;0
WireConnection;17;0;16;0
WireConnection;89;0;86;0
WireConnection;89;1;87;0
WireConnection;245;0;88;0
WireConnection;245;1;244;0
WireConnection;245;2;243;0
WireConnection;144;0;140;0
WireConnection;144;1;139;0
WireConnection;58;1;57;0
WireConnection;206;0;205;0
WireConnection;129;1;127;0
WireConnection;130;1;128;0
WireConnection;47;1;43;1
WireConnection;47;0;43;4
WireConnection;155;0;153;0
WireConnection;14;0;13;0
WireConnection;69;0;58;1
WireConnection;69;1;60;2
WireConnection;131;0;130;1
WireConnection;65;0;58;1
WireConnection;65;1;60;3
WireConnection;67;0;58;1
WireConnection;67;1;60;1
WireConnection;66;0;62;0
WireConnection;66;1;63;0
WireConnection;48;0;47;0
WireConnection;132;0;129;1
WireConnection;68;1;59;0
WireConnection;90;0;245;0
WireConnection;90;1;89;0
WireConnection;163;0;155;0
WireConnection;82;0;81;4
WireConnection;147;1;144;0
WireConnection;49;0;43;0
WireConnection;91;1;245;0
WireConnection;91;0;90;0
WireConnection;232;3;147;1
WireConnection;232;7;174;0
WireConnection;232;4;141;0
WireConnection;232;8;148;0
WireConnection;72;0;64;0
WireConnection;72;1;68;1
WireConnection;72;2;66;0
WireConnection;71;0;67;0
WireConnection;71;1;69;0
WireConnection;71;2;65;0
WireConnection;83;0;81;0
WireConnection;50;0;49;0
WireConnection;167;0;160;0
WireConnection;167;1;162;0
WireConnection;167;2;158;0
WireConnection;93;1;91;0
WireConnection;73;0;71;0
WireConnection;73;1;72;0
WireConnection;73;2;70;0
WireConnection;170;0;232;0
WireConnection;170;1;169;0
WireConnection;170;2;164;0
WireConnection;170;3;165;0
WireConnection;170;4;166;0
WireConnection;170;5;156;0
WireConnection;170;6;167;0
WireConnection;171;0;170;0
WireConnection;75;1;74;0
WireConnection;75;0;73;0
WireConnection;94;0;92;0
WireConnection;94;1;93;0
WireConnection;94;2;78;0
WireConnection;94;3;79;0
WireConnection;95;0;94;0
WireConnection;172;0;171;0
WireConnection;76;0;75;0
WireConnection;0;9;176;0
WireConnection;0;13;51;0
WireConnection;0;11;77;0
ASEEND*/
//CHKSM=348F50158AD07A395105952456B0475A11F3BADE