// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Whl/Fx/All"
{
	Properties
	{
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("CullMode", Float) = 0
		[Enum(UnityEngine.Rendering.BlendMode)]_Dst("Dst", Float) = 10
		[Enum(On,1,Off,0)]_ZWriteMode("ZWriteMode", Float) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)]_ZTestMode("ZTestMode", Float) = 8
		[HDR][Header(Main)]_MainColor("MainColor", Color) = (0,0,0,0)
		[Toggle(_UV2_WTCONTROLOFFSET_ON)] _UV2_WTControlOffset("UV2_WTControlOffset", Float) = 0
		_MainTex("MainTex", 2D) = "white" {}
		_UVSlant("UVSlant", Vector) = (0,0,0,0)
		_Mask_Tex("Mask_Tex", 2D) = "white" {}
		[Toggle]_OwnUV("OwnUV", Float) = 0
		_MaskTexPanner("MaskTexPanner", Vector) = (0,0,1,0)
		[Toggle(_RGBA_ON)] _RGBA("RGBA", Float) = 0
		_Rotater("Rotater", Range( 0 , 360)) = 0
		_MainTexPanner("MainTexPanner", Vector) = (0,0,1,0)
		[Header(Fade)]_FadeTex("FadeTex", 2D) = "white" {}
		_FadeTexPanner("FadeTexPanner", Vector) = (0,0,1,0)
		[Toggle(_DISTURBFADETEX_ON)] _DisturbFadeTex("DisturbFadeTex", Float) = 0
		_RampTex("RampTex", 2D) = "white" {}
		[Toggle(_DISTURBRAMP_ON)] _DisturbRamp("DisturbRamp", Float) = 0
		_RampDisStr("RampDisStr", Float) = 0
		[Header(Dissolution)]_DissolutionTex("DissolutionTex", 2D) = "white" {}
		[Toggle(_DISSOLUTIONON_ON)] _DissolutionOn("DissolutionOn", Float) = 0
		[Toggle(_UV1_TCONTORLDIS_ON)] _UV1_TContorlDis("UV1_TContorlDis", Float) = 0
		_Dissolution("Dissolution", Range( 0 , 1)) = 0.15
		_DissolutionSoft("DissolutionSoft", Range( 0.51 , 1)) = 0.3935294
		_DissolutionTexPanner("DissolutionTexPanner", Vector) = (0,0,1,0)
		[Header(Disturb)]_DisturbTex("DisturbTex", 2D) = "white" {}
		[Toggle(_DISTURBON_ON)] _DisturbOn("DisturbOn", Float) = 0
		[Toggle(_UV3_XCONTORLDISTURB_ON)] _UV3_XContorlDisturb("UV3_XContorlDisturb", Float) = 0
		_DisturbPanner("DisturbPanner", Vector) = (0,0,1,0)
		_DisturbDir("DisturbDir", Vector) = (1,1,0,0)
		_DisturbStr("DisturbStr", Float) = 0
		[Header(VertexOffset)]_VertexOffsetTex("VertexOffsetTex", 2D) = "white" {}
		[Toggle(_VERTEXOFFSETON_ON)] _VertexOffsetOn("VertexOffsetOn", Float) = 0
		[Toggle(_UV1_WCONTORLVERTEXOFFSET_ON)] _UV1_WContorlVertexOffset("UV1_WContorlVertexOffset", Float) = 0
		_VertexOffsetMask("VertexOffsetMask", 2D) = "white" {}
		_VertexOffsetTexPanner("VertexOffsetTexPanner", Vector) = (0,0,1,0)
		_OffsetDir("OffsetDir", Vector) = (1,1,1,0)
		_VertexOffsetStr("VertexOffsetStr", Float) = 1
		[Header(SoftParticle)]_FadeRange("FadeRange", Float) = 1
		[Toggle(_SOFTPARTICLE_ON)] _SoftParticle("SoftParticle", Float) = 0
		_FreOn("FreOn", Range( 0 , 1)) = 0
		_FreInvers("FreInvers", Range( 0 , 1)) = 0
		_FreScale("FreScale", Float) = 1
		_FrePower("FrePower", Float) = 5
		[HDR][Header(BackFaceColor)]_BackFaceColor("BackFaceColor", Color) = (0,0,0,0)
		[Toggle(_BACKFACEON_ON)] _BackFaceOn("BackFaceOn", Float) = 0
		_BackFaceIntensity("BackFaceIntensity", Float) = 1
		[HideInInspector] _texcoord3( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" }
		Cull [_CullMode]
		ZWrite Off
		ZTest [_ZTestMode]
		Blend SrcAlpha [_Dst]
		
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#pragma target 4.5
		#pragma shader_feature_local _VERTEXOFFSETON_ON
		#pragma shader_feature_local _UV1_WCONTORLVERTEXOFFSET_ON
		#pragma shader_feature_local _DISSOLUTIONON_ON
		#pragma shader_feature_local _RGBA_ON
		#pragma shader_feature_local _UV2_WTCONTROLOFFSET_ON
		#pragma shader_feature_local _DISTURBON_ON
		#pragma shader_feature_local _UV3_XCONTORLDISTURB_ON
		#pragma shader_feature_local _UV1_TCONTORLDIS_ON
		#pragma shader_feature_local _SOFTPARTICLE_ON
		#pragma shader_feature_local _DISTURBFADETEX_ON
		#pragma shader_feature_local _BACKFACEON_ON
		#pragma shader_feature_local _DISTURBRAMP_ON
		#pragma surface surf StandardCustomLighting keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 uv_texcoord;
			float4 uv2_texcoord2;
			float2 uv3_texcoord3;
			float4 screenPos;
			float4 vertexColor : COLOR;
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
		uniform float _ZTestMode;
		uniform float _ZWriteMode;
		uniform float _Dst;
		uniform sampler2D _VertexOffsetTex;
		uniform float3 _VertexOffsetTexPanner;
		uniform float4 _VertexOffsetTex_ST;
		uniform float3 _OffsetDir;
		uniform sampler2D _VertexOffsetMask;
		uniform float4 _VertexOffsetMask_ST;
		uniform float _VertexOffsetStr;
		uniform sampler2D _MainTex;
		uniform float3 _MainTexPanner;
		uniform float4 _MainTex_ST;
		uniform float2 _UVSlant;
		uniform float _Rotater;
		uniform sampler2D _DisturbTex;
		uniform float3 _DisturbPanner;
		uniform float4 _DisturbTex_ST;
		uniform float _DisturbStr;
		uniform float2 _DisturbDir;
		uniform float _DissolutionSoft;
		uniform sampler2D _DissolutionTex;
		uniform float3 _DissolutionTexPanner;
		uniform float4 _DissolutionTex_ST;
		uniform float _Dissolution;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _FadeRange;
		uniform sampler2D _FadeTex;
		uniform float3 _FadeTexPanner;
		uniform float4 _FadeTex_ST;
		uniform sampler2D _Mask_Tex;
		uniform float3 _MaskTexPanner;
		uniform float4 _Mask_Tex_ST;
		uniform float _OwnUV;
		uniform float _FreScale;
		uniform float _FrePower;
		uniform float _FreInvers;
		uniform float _FreOn;
		uniform float4 _MainColor;
		uniform sampler2D _RampTex;
		uniform float4 _RampTex_ST;
		uniform float _RampDisStr;
		uniform float4 _BackFaceColor;
		uniform float _BackFaceIntensity;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 temp_cast_0 = (0.0).xxx;
			float mulTime130 = _Time.y * _VertexOffsetTexPanner.z;
			float2 appendResult128 = (float2(_VertexOffsetTexPanner.x , _VertexOffsetTexPanner.y));
			float4 uvs_VertexOffsetTex = v.texcoord;
			uvs_VertexOffsetTex.xy = v.texcoord.xy * _VertexOffsetTex_ST.xy + _VertexOffsetTex_ST.zw;
			float2 panner131 = ( mulTime130 * appendResult128 + uvs_VertexOffsetTex.xy);
			float temp_output_267_0 = (-1.0 + (tex2Dlod( _VertexOffsetTex, float4( panner131, 0, 0.0) ).r - 0.0) * (1.0 - -1.0) / (1.0 - 0.0));
			float3 appendResult272 = (float3(( temp_output_267_0 * _OffsetDir.x ) , ( temp_output_267_0 * _OffsetDir.y ) , ( temp_output_267_0 * _OffsetDir.z )));
			#ifdef _UV1_WCONTORLVERTEXOFFSET_ON
				float staticSwitch21 = v.texcoord.z;
			#else
				float staticSwitch21 = 1.0;
			#endif
			float UV1_W82 = staticSwitch21;
			float4 uvs_VertexOffsetMask = v.texcoord;
			uvs_VertexOffsetMask.xy = v.texcoord.xy * _VertexOffsetMask_ST.xy + _VertexOffsetMask_ST.zw;
			float3 ase_vertexNormal = v.normal.xyz;
			#ifdef _VERTEXOFFSETON_ON
				float3 staticSwitch191 = ( appendResult272 * ( UV1_W82 * tex2Dlod( _VertexOffsetMask, float4( uvs_VertexOffsetMask.xy, 0, 0.0) ).r * ( 0.1 * _VertexOffsetStr ) ) * ase_vertexNormal );
			#else
				float3 staticSwitch191 = temp_cast_0;
			#endif
			float3 VertexOffset137 = staticSwitch191;
			v.vertex.xyz += VertexOffset137;
			v.vertex.w = 1;
		}

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float mulTime31 = _Time.y * _MainTexPanner.z;
			float2 appendResult30 = (float2(_MainTexPanner.x , _MainTexPanner.y));
			float4 uvs_MainTex = i.uv_texcoord;
			uvs_MainTex.xy = i.uv_texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
			float2 appendResult291 = (float2(i.uv_texcoord.xy.y , i.uv_texcoord.xy.x));
			float2 UVSlant297 = ( appendResult291 * _UVSlant );
			float2 panner27 = ( mulTime31 * appendResult30 + ( uvs_MainTex.xy + UVSlant297 ));
			float UV2_W152 = i.uv2_texcoord2.z;
			float UV2_T160 = i.uv2_texcoord2.w;
			float2 appendResult157 = (float2(UV2_W152 , UV2_T160));
			#ifdef _UV2_WTCONTROLOFFSET_ON
				float2 staticSwitch154 = ( ( uvs_MainTex.xy + appendResult157 ) + UVSlant297 );
			#else
				float2 staticSwitch154 = panner27;
			#endif
			float2 temp_cast_0 = (0.5).xx;
			float cos193 = cos( ( (0.0 + (_Rotater - 0.0) * (2.0 - 0.0) / (360.0 - 0.0)) * UNITY_PI ) );
			float sin193 = sin( ( (0.0 + (_Rotater - 0.0) * (2.0 - 0.0) / (360.0 - 0.0)) * UNITY_PI ) );
			float2 rotator193 = mul( staticSwitch154 - temp_cast_0 , float2x2( cos193 , -sin193 , sin193 , cos193 )) + temp_cast_0;
			float2 temp_cast_1 = (0.0).xx;
			float mulTime173 = _Time.y * _DisturbPanner.z;
			float2 appendResult174 = (float2(_DisturbPanner.x , _DisturbPanner.y));
			float4 uvs_DisturbTex = i.uv_texcoord;
			uvs_DisturbTex.xy = i.uv_texcoord.xy * _DisturbTex_ST.xy + _DisturbTex_ST.zw;
			float2 panner175 = ( mulTime173 * appendResult174 + ( uvs_DisturbTex.xy + UVSlant297 ));
			#ifdef _UV3_XCONTORLDISTURB_ON
				float staticSwitch205 = i.uv3_texcoord3.x;
			#else
				float staticSwitch205 = 1.0;
			#endif
			float UV3_X200 = staticSwitch205;
			#ifdef _DISTURBON_ON
				float2 staticSwitch179 = ( ( tex2D( _DisturbTex, panner175 ).r * _DisturbStr * UV3_X200 ) * _DisturbDir );
			#else
				float2 staticSwitch179 = temp_cast_1;
			#endif
			float2 DisturbColor167 = staticSwitch179;
			float2 temp_output_170_0 = ( rotator193 + DisturbColor167 );
			float4 tex2DNode1 = tex2D( _MainTex, temp_output_170_0 );
			#ifdef _RGBA_ON
				float staticSwitch210 = (tex2DNode1).a;
			#else
				float staticSwitch210 = ( tex2DNode1.r * tex2DNode1.a );
			#endif
			float MainTexAlpha68 = staticSwitch210;
			float mulTime122 = _Time.y * _DissolutionTexPanner.z;
			float2 appendResult121 = (float2(_DissolutionTexPanner.x , _DissolutionTexPanner.y));
			float4 uvs_DissolutionTex = i.uv_texcoord;
			uvs_DissolutionTex.xy = i.uv_texcoord.xy * _DissolutionTex_ST.xy + _DissolutionTex_ST.zw;
			float2 panner124 = ( mulTime122 * appendResult121 + ( uvs_DissolutionTex.xy + UVSlant297 ));
			#ifdef _UV1_TCONTORLDIS_ON
				float staticSwitch23 = i.uv_texcoord.w;
			#else
				float staticSwitch23 = _Dissolution;
			#endif
			float UV1_T83 = staticSwitch23;
			float smoothstepResult9 = smoothstep( ( 1.0 - _DissolutionSoft ) , _DissolutionSoft , ( tex2D( _DissolutionTex, ( DisturbColor167 + panner124 ) ).r + 1.0 + ( UV1_T83 * -2.0 ) ));
			float lerpResult112 = lerp( 0.0 , MainTexAlpha68 , smoothstepResult9);
			#ifdef _DISSOLUTIONON_ON
				float staticSwitch162 = lerpResult112;
			#else
				float staticSwitch162 = MainTexAlpha68;
			#endif
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth187 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth187 = abs( ( screenDepth187 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _FadeRange ) );
			#ifdef _SOFTPARTICLE_ON
				float staticSwitch51 = distanceDepth187;
			#else
				float staticSwitch51 = 1.0;
			#endif
			float SoftParticle189 = saturate( staticSwitch51 );
			float VertexColorA77 = i.vertexColor.a;
			float mulTime261 = _Time.y * _FadeTexPanner.z;
			float2 appendResult262 = (float2(_FadeTexPanner.x , _FadeTexPanner.y));
			float4 uvs_FadeTex = i.uv_texcoord;
			uvs_FadeTex.xy = i.uv_texcoord.xy * _FadeTex_ST.xy + _FadeTex_ST.zw;
			float2 panner264 = ( mulTime261 * appendResult262 + uvs_FadeTex.xy);
			float2 temp_cast_2 = (0.0).xx;
			#ifdef _DISTURBFADETEX_ON
				float2 staticSwitch238 = DisturbColor167;
			#else
				float2 staticSwitch238 = temp_cast_2;
			#endif
			float FadeTexR142 = tex2D( _FadeTex, ( panner264 + staticSwitch238 ) ).r;
			float2 MainTexUV227 = temp_output_170_0;
			float mulTime280 = _Time.y * _MaskTexPanner.z;
			float2 appendResult281 = (float2(_MaskTexPanner.x , _MaskTexPanner.y));
			float4 uvs_Mask_Tex = i.uv_texcoord;
			uvs_Mask_Tex.xy = i.uv_texcoord.xy * _Mask_Tex_ST.xy + _Mask_Tex_ST.zw;
			float2 panner283 = ( mulTime280 * appendResult281 + uvs_Mask_Tex.xy);
			float2 lerpResult284 = lerp( MainTexUV227 , panner283 , _OwnUV);
			float Mask_TexR225 = tex2D( _Mask_Tex, lerpResult284 ).r;
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
			float FreOP247 = clampResult246;
			float lerpResult252 = lerp( 1.0 , FreOP247 , _FreOn);
			float FinalOpacity95 = saturate( ( staticSwitch162 * SoftParticle189 * VertexColorA77 * FadeTexR142 * Mask_TexR225 * lerpResult252 ) );
			float4 VertexColorRGB75 = i.vertexColor;
			float3 MainTexColor214 = (tex2DNode1).rgb;
			float4 uvs_RampTex = i.uv_texcoord;
			uvs_RampTex.xy = i.uv_texcoord.xy * _RampTex_ST.xy + _RampTex_ST.zw;
			#ifdef _DISTURBRAMP_ON
				float2 staticSwitch230 = ( uvs_RampTex.xy + ( DisturbColor167 * _RampDisStr ) );
			#else
				float2 staticSwitch230 = uvs_RampTex.xy;
			#endif
			float4 MainColor91 = ( float4( MainTexColor214 , 0.0 ) * tex2D( _RampTex, staticSwitch230 ) );
			float4 temp_output_15_0 = ( _MainColor * VertexColorRGB75 * MainColor91 );
			float4 switchResult215 = (((i.ASEVFace>0)?(( MainColor91 * _BackFaceColor * _BackFaceIntensity * VertexColorRGB75 )):(temp_output_15_0)));
			#ifdef _BACKFACEON_ON
				float4 staticSwitch218 = switchResult215;
			#else
				float4 staticSwitch218 = temp_output_15_0;
			#endif
			c.rgb = staticSwitch218.rgb;
			c.a = saturate( FinalOpacity95 );
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
379;612;1632;1061;3112.769;2286.104;1.672115;True;True
Node;AmplifyShaderEditor.CommentaryNode;309;-4248.633,-2675.56;Inherit;False;939.9705;446.2205;UVSlant;5;291;294;297;296;289;UVSlant;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;289;-4198.633,-2623.56;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;296;-3962.462,-2393.339;Inherit;False;Property;_UVSlant;UVSlant;8;0;Create;True;0;0;0;False;0;False;0,0;0,-0.44;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.DynamicAppendNode;291;-3964.633,-2625.56;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;294;-3706.462,-2425.339;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;297;-3537.142,-2426.427;Inherit;False;UVSlant;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;203;-4300.268,-596.118;Inherit;False;1124.562;519.4683;Comment;4;200;202;205;206;UV3;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;169;-5399.755,338.6339;Inherit;False;1883.194;986.6012;DisturbColor;16;178;167;179;177;201;180;166;175;172;174;173;171;222;223;308;307;DisturbColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;151;-4265.086,-1204.726;Inherit;False;1143.907;365.912;Comment;3;160;152;38;UV2;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;202;-4233.75,-420.7909;Inherit;False;2;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;307;-5274.099,533.4467;Inherit;False;297;UVSlant;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;206;-4195.803,-535.8123;Inherit;False;Constant;_Float12;Float 12;28;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;171;-5295.531,641.9674;Inherit;False;Property;_DisturbPanner;DisturbPanner;30;0;Create;True;0;0;0;False;0;False;0,0,1;-1.5,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TextureCoordinatesNode;172;-5322.348,388.7243;Inherit;False;0;166;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;174;-5044.532,594.9674;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;205;-3933.803,-506.8123;Inherit;False;Property;_UV3_XContorlDisturb;UV3_XContorlDisturb;29;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;173;-5047.532,748.9674;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;308;-5064.099,458.4467;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;38;-4236.057,-1140.805;Inherit;False;1;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;152;-3767.549,-1122.443;Inherit;False;UV2_W;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;175;-4862.851,563.1054;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;200;-3614.63,-483.447;Inherit;False;UV3_X;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;80;-2611.824,-2316.12;Inherit;False;2913.269;1093.961;MainTex;29;214;68;211;210;227;213;212;1;170;181;193;196;154;194;27;159;207;157;158;28;31;30;195;153;29;161;299;300;310;MainTex;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;160;-3769.013,-1027.752;Inherit;False;UV2_T;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;153;-2614.599,-1545.998;Inherit;False;152;UV2_W;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;161;-2611.869,-1451.349;Inherit;False;160;UV2_T;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;166;-4623.716,551.2592;Inherit;True;Property;_DisturbTex;DisturbTex;27;1;[Header];Create;True;1;Disturb;0;0;False;0;False;-1;None;5c14698a5e39b5b45ba08574bbfaacff;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;253;1062.243,1214.427;Inherit;False;1088.13;274.4167;WorldNormal;5;258;257;256;255;254;WorldNormal;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;201;-4543.583,880.6341;Inherit;False;200;UV3_X;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;178;-4533.492,756.9457;Inherit;False;Property;_DisturbStr;DisturbStr;32;0;Create;True;0;0;0;False;0;False;0;0.025;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;300;-2542.864,-2115.043;Inherit;False;297;UVSlant;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector3Node;29;-2554.017,-1953.633;Inherit;False;Property;_MainTexPanner;MainTexPanner;14;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector2Node;222;-4318.484,917.6635;Inherit;False;Property;_DisturbDir;DisturbDir;31;0;Create;True;0;0;0;False;0;False;1,1;0,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.WorldNormalVector;254;1112.243,1264.427;Inherit;False;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;177;-4291.119,733.5117;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;28;-2576.641,-2273.12;Inherit;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;157;-2380.326,-1524.431;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;158;-2470.831,-1682.765;Inherit;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;159;-2195.875,-1654.072;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;30;-2303.018,-2000.633;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;180;-4246.521,500.2343;Inherit;False;Constant;_0;0;32;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;255;1314.969,1377.844;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;31;-2306.018,-1846.633;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;223;-4133.066,737.6071;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;299;-2305.255,-2171.134;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;195;-1905.568,-1780.961;Inherit;False;Property;_Rotater;Rotater;13;0;Create;True;0;0;0;False;0;False;0;0;0;360;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;310;-2052.498,-1813.415;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;27;-2121.338,-2032.497;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;179;-3983.063,591.5712;Inherit;False;Property;_DisturbOn;DisturbOn;28;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;207;-1658.797,-1729.24;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;360;False;3;FLOAT;0;False;4;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;256;1471.969,1320.844;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;194;-1624.532,-1830.257;Inherit;False;Constant;_Float11;Float 11;26;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;93;-4269.48,-1871.357;Inherit;False;1252.226;378.732;Comment;7;23;83;5;82;21;22;20;UV1;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;94;-3074.397,353.8098;Inherit;False;4022.833;1852.103;Comment;38;145;125;147;95;6;89;97;150;162;112;163;146;73;9;111;144;13;106;102;105;107;124;84;122;123;121;120;182;183;188;190;226;250;249;252;244;302;301;FinalOpacity;1,1,1,1;0;0
Node;AmplifyShaderEditor.PiNode;196;-1482.506,-1729.246;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;154;-1861.943,-1917.116;Inherit;False;Property;_UV2_WTControlOffset;UV2_WTControlOffset;6;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;167;-3740.388,598.4182;Inherit;False;DisturbColor;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SwitchByFaceNode;257;1708.969,1269.844;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;123;-3015.217,501.0507;Inherit;False;0;102;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;5;-4008.917,-1577.569;Inherit;False;Property;_Dissolution;Dissolution;24;0;Create;True;0;0;0;False;0;False;0.15;0.15;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;258;1926.373,1265.698;Inherit;False;WorldNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;181;-1583.315,-1608.945;Inherit;False;167;DisturbColor;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;251;1078.086,473.507;Inherit;False;1485.673;682.3762;FreOP;9;243;247;246;242;241;259;274;275;276;FreOP;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector3Node;120;-3005.399,762.2938;Inherit;False;Property;_DissolutionTexPanner;DissolutionTexPanner;26;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TextureCoordinatesNode;20;-4219.48,-1794.625;Inherit;True;0;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;301;-2985.814,649.826;Inherit;False;297;UVSlant;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RotatorNode;193;-1376.57,-1886.637;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;165;-211.8256,2535.596;Inherit;False;1826.183;1688.764;FadeTex;25;142;225;224;119;228;240;238;264;237;236;262;263;261;260;279;280;281;282;283;284;287;303;304;305;306;FadeTex;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;170;-1145.381,-1876.389;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;274;1162.439,795.9553;Inherit;False;Property;_FrePower;FrePower;45;0;Create;True;0;0;0;False;0;False;5;-10.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;122;-2711.4,877.2938;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;302;-2755.814,549.826;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;23;-3672.892,-1649.722;Inherit;False;Property;_UV1_TContorlDis;UV1_TContorlDis;23;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;243;1132.086,705.9406;Inherit;False;Property;_FreScale;FreScale;44;0;Create;True;0;0;0;False;0;False;1;369.39;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;259;1109.155,607.3345;Inherit;False;258;WorldNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;121;-2708.4,723.2938;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;124;-2535.821,629.0317;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;182;-2610.309,476.8312;Inherit;False;167;DisturbColor;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1;-975.8948,-2060.755;Inherit;True;Property;_MainTex;MainTex;7;0;Create;True;0;0;0;False;0;False;-1;None;99da3dd68a9b363488ccb35bb8bdbc1d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;90;-2498.941,-647.7783;Inherit;False;2227.146;782.8557;MainColor;10;148;91;71;149;184;229;230;231;232;233;MainColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;188;-1266.532,1789.912;Inherit;False;1080.439;324.1655;SoftParticle;6;189;51;187;52;43;209;SoftParticle;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector3Node;279;-184.1597,3841.789;Inherit;False;Property;_MaskTexPanner;MaskTexPanner;11;0;Create;True;0;0;0;False;0;False;0,0,1;0,0.25,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;164;-3165.122,2397.463;Inherit;False;2578.479;1252.42;VertexOffset;24;137;192;191;127;128;130;129;131;126;266;267;265;132;234;139;235;268;269;270;271;272;134;136;133;VertexOffset;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;83;-3296.65,-1652.933;Inherit;False;UV1_T;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;241;1351.4,632.8207;Inherit;True;Standard;WorldNormal;ViewDir;False;True;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;260;-164.417,2876.641;Inherit;False;Property;_FadeTexPanner;FadeTexPanner;16;0;Create;True;0;0;0;False;0;False;0,0,1;0,0.15,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.OneMinusNode;242;1663.395,700.6831;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-1205.193,1977.891;Inherit;False;Property;_FadeRange;FadeRange;40;1;[Header];Create;True;1;SoftParticle;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;233;-2396.687,7.478149;Inherit;False;Property;_RampDisStr;RampDisStr;20;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;229;-2384.309,-93.66939;Inherit;False;167;DisturbColor;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;282;-176.3656,3484.425;Inherit;False;0;224;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;183;-2303.309,571.8313;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;281;56.04132,3818.586;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;262;86.58203,2829.641;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ComponentMaskNode;213;-537.5737,-1981.953;Inherit;False;False;False;False;True;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;107;-2100.951,1065.146;Inherit;False;Constant;_Float4;Float 4;20;0;Create;True;0;0;0;False;0;False;-2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;237;-30.5251,3081.17;Inherit;False;Constant;_Float13;Float 13;30;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;84;-2127.166,961.2836;Inherit;False;83;UV1_T;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;127;-3111.071,2637.153;Inherit;False;Property;_VertexOffsetTexPanner;VertexOffsetTexPanner;37;0;Create;True;0;0;0;False;0;False;0,0,1;-1,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleTimeNode;280;58.93164,3957.813;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;212;-498.295,-2093.511;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;261;63.58203,2983.641;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;263;-176.1293,2583.574;Inherit;False;0;119;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;276;1550.23,964.3643;Inherit;False;Property;_FreInvers;FreInvers;43;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;227;-1021.888,-2168.068;Inherit;False;MainTexUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;236;-74.52514,3165.953;Inherit;False;167;DisturbColor;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;238;228.2696,3084.085;Inherit;False;Property;_DisturbFadeTex;DisturbFadeTex;17;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;102;-1789.632,619.4308;Inherit;True;Property;_DissolutionTex;DissolutionTex;21;1;[Header];Create;True;1;Dissolution;0;0;False;0;False;-1;None;110cc9d9b0c2e794db2fcd9a4dc9b47d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;228;271.8781,3695.547;Inherit;False;227;MainTexUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-1660.729,1010.589;Inherit;False;Property;_DissolutionSoft;DissolutionSoft;25;0;Create;True;0;0;0;False;0;False;0.3935294;0.786;0.51;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;264;267.2619,2759.777;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;210;-260.8716,-2100.742;Inherit;False;Property;_RGBA;RGBA;12;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;287;307.5923,4021.088;Inherit;False;Property;_OwnUV;OwnUV;10;1;[Toggle];Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;105;-1716.654,817.05;Inherit;False;Constant;_Float3;Float 3;20;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;275;1844.23,630.3643;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;184;-2419.658,-367.5649;Inherit;False;0;148;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;52;-996.5808,1862.594;Inherit;False;Constant;_Float1;Float 1;14;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;187;-1025.668,1958.078;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;232;-2093.588,-103.9218;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;128;-2757.176,2639.769;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;283;268.8158,3831.178;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;106;-1822.432,960.8217;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;130;-2791.177,2733.769;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;129;-3101.982,2453.671;Inherit;False;0;126;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;284;559.5923,3804.809;Inherit;True;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;231;-1928.822,-194.1953;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;144;-1356.732,904.5836;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;68;-30.40601,-2099.116;Inherit;False;MainTexAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;240;542.1273,2984.734;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;131;-2563.43,2552.747;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ClampOpNode;246;2094.735,630.0856;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;81;378.5724,-1825.137;Inherit;False;498.0005;281.3341;VertexColor;3;75;77;24;VertexColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;111;-1342.864,767.7439;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;211;-551.2866,-1775.902;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;51;-761.9343,1869.839;Inherit;False;Property;_SoftParticle;SoftParticle;41;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-3955.963,-1821.357;Inherit;False;Constant;_Float0;Float 0;7;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;9;-978.6118,1018.496;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;73;-733.9011,904.9993;Inherit;False;68;MainTexAlpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;119;669.4441,2918.637;Inherit;True;Property;_FadeTex;FadeTex;15;1;[Header];Create;True;1;Fade;0;0;False;0;False;-1;None;45c9ce5f99e8d7f42889370feed22ea3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;146;-707.3525,822.25;Inherit;False;Constant;_Float9;Float 9;27;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;230;-1784.309,-328.7694;Inherit;False;Property;_DisturbRamp;DisturbRamp;19;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;21;-3660.654,-1813.568;Inherit;False;Property;_UV1_WContorlVertexOffset;UV1_WContorlVertexOffset;35;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;209;-529.9797,1891.661;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;247;2248.94,624.5996;Inherit;False;FreOP;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;224;835.8957,3780.255;Inherit;True;Property;_Mask_Tex;Mask_Tex;9;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;126;-2307.647,2516.605;Inherit;True;Property;_VertexOffsetTex;VertexOffsetTex;33;1;[Header];Create;True;1;VertexOffset;0;0;False;0;False;-1;None;d5ae13cce4f088e4d9f1cb804bdcb758;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;24;428.5724,-1775.137;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;214;-141,-1779.253;Inherit;False;MainTexColor;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;249;-366.1613,1377.948;Inherit;False;Constant;_Float15;Float 15;39;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;82;-3293.107,-1811.221;Inherit;False;UV1_W;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;163;-459.2473,774.392;Inherit;False;68;MainTexAlpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;71;-1479.458,-571.7523;Inherit;True;214;MainTexColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;136;-2446.787,3563.595;Inherit;False;Property;_VertexOffsetStr;VertexOffsetStr;39;0;Create;True;0;0;0;False;0;False;1;2.16;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;267;-1997.899,2545.64;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-1;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;225;1181.716,3802.261;Inherit;False;Mask_TexR;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;189;-399.1999,1874.448;Inherit;False;SoftParticle;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;77;647.2477,-1659.803;Inherit;False;VertexColorA;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;235;-2635.677,3271.839;Inherit;False;0;234;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;142;985.5274,2942.172;Inherit;False;FadeTexR;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;148;-1537.998,-334.5495;Inherit;True;Property;_RampTex;RampTex;18;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;244;-447.6511,1587.84;Inherit;False;Property;_FreOn;FreOn;42;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;112;-451.4745,942.5397;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;271;-2056.116,2781.749;Inherit;True;Property;_OffsetDir;OffsetDir;38;0;Create;True;0;0;0;False;0;False;1,1,1;1,1,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;250;-397.424,1477.343;Inherit;False;247;FreOP;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;134;-2418.486,3470.896;Inherit;False;Constant;_Float7;Float 7;25;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;269;-1767.458,2876.508;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;252;-127.5132,1409.838;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;139;-2283.299,3142.081;Inherit;False;82;UV1_W;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;133;-2190.577,3535.02;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;162;-192.7189,890.7932;Inherit;False;Property;_DissolutionOn;DissolutionOn;22;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;268;-1763.573,2723.739;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;149;-1111.11,-393.847;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;97;-171.7939,1082.859;Inherit;False;77;VertexColorA;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;150;-149.9113,1178.57;Inherit;False;142;FadeTexR;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;226;-156.2209,1275.179;Inherit;False;225;Mask_TexR;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;190;-162.4249,988.0435;Inherit;False;189;SoftParticle;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;270;-1758.826,2576.562;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;234;-2347.262,3250.174;Inherit;True;Property;_VertexOffsetMask;VertexOffsetMask;36;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;91;-810.5136,-398.6811;Inherit;True;MainColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;75;645.5729,-1766.231;Inherit;False;VertexColorRGB;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;89;125.6423,950.1467;Inherit;True;6;6;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;272;-1557.867,2659.356;Inherit;True;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;265;-1843.906,3153.109;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;132;-1856.466,3309.953;Inherit;True;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;266;-1288.646,2855.91;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;92;-209.4033,-420.5108;Inherit;False;91;MainColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;192;-1311.756,2717.426;Inherit;False;Constant;_Float2;Float 2;27;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;217;-118.6549,-76.52956;Inherit;False;Property;_BackFaceIntensity;BackFaceIntensity;48;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;6;412.6723,944.6537;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;16;-212.954,-815.0086;Inherit;False;Property;_MainColor;MainColor;5;2;[HDR];[Header];Create;True;1;Main;0;0;False;0;False;0,0,0,0;383.498,383.498,383.498,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;78;-238.4297,-590.9456;Inherit;False;75;VertexColorRGB;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;219;-168.7295,-293.0279;Inherit;False;Property;_BackFaceColor;BackFaceColor;46;2;[HDR];[Header];Create;True;1;BackFaceColor;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;232.438,-623.3128;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;220;275.0029,-330.1549;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;95;612.243,927.0663;Inherit;False;FinalOpacity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;191;-1110.422,2788.638;Inherit;False;Property;_VertexOffsetOn;VertexOffsetOn;34;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;96;457.2399,-864.7418;Inherit;True;95;FinalOpacity;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;46;-5320.064,-1868.688;Inherit;False;490.0942;445.175;Comment;4;278;37;36;273;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SwitchByFaceNode;215;632.3391,-478.4238;Inherit;False;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;137;-821.9575,2854.143;Inherit;False;VertexOffset;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;304;63.5642,2743.642;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;37;-5270.064,-1720.936;Inherit;False;Property;_ZTestMode;ZTestMode;4;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CompareFunction;True;0;False;8;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-5266.584,-1818.689;Inherit;False;Property;_CullMode;CullMode;1;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;303;-142.4358,2742.642;Inherit;False;297;UVSlant;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;145;-2086.654,1178.292;Inherit;False;Constant;_Float8;Float 8;27;0;Create;True;0;0;0;False;0;False;0.57;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;138;828.8001,-329.0221;Inherit;False;137;VertexOffset;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;125;-1916.538,825.0782;Inherit;False;Constant;_Float6;Float 6;23;0;Create;True;0;0;0;False;0;False;0.58;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;208;750.324,-858.8317;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;273;-5269.095,-1628.827;Inherit;False;Property;_ZWriteMode;ZWriteMode;3;1;[Enum];Create;True;0;2;On;1;Off;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;278;-5266.156,-1522.379;Inherit;False;Property;_Dst;Dst;2;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;0;False;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;305;-143.5602,3659.01;Inherit;False;297;UVSlant;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;218;938.9389,-613.0234;Inherit;False;Property;_BackFaceOn;BackFaceOn;47;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;306;20.8907,3696.917;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;147;-2088.103,851.6298;Inherit;False;Constant;_Float10;Float 10;27;0;Create;True;0;0;0;False;0;False;0.61;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1210.138,-839.6459;Float;False;True;-1;5;ASEMaterialInspector;0;0;CustomLighting;Whl/Fx/All;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;2;False;273;0;True;37;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;True;278;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;True;36;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;291;0;289;2
WireConnection;291;1;289;1
WireConnection;294;0;291;0
WireConnection;294;1;296;0
WireConnection;297;0;294;0
WireConnection;174;0;171;1
WireConnection;174;1;171;2
WireConnection;205;1;206;0
WireConnection;205;0;202;1
WireConnection;173;0;171;3
WireConnection;308;0;172;0
WireConnection;308;1;307;0
WireConnection;152;0;38;3
WireConnection;175;0;308;0
WireConnection;175;2;174;0
WireConnection;175;1;173;0
WireConnection;200;0;205;0
WireConnection;160;0;38;4
WireConnection;166;1;175;0
WireConnection;177;0;166;1
WireConnection;177;1;178;0
WireConnection;177;2;201;0
WireConnection;157;0;153;0
WireConnection;157;1;161;0
WireConnection;159;0;158;0
WireConnection;159;1;157;0
WireConnection;30;0;29;1
WireConnection;30;1;29;2
WireConnection;255;0;254;3
WireConnection;31;0;29;3
WireConnection;223;0;177;0
WireConnection;223;1;222;0
WireConnection;299;0;28;0
WireConnection;299;1;300;0
WireConnection;310;0;159;0
WireConnection;310;1;300;0
WireConnection;27;0;299;0
WireConnection;27;2;30;0
WireConnection;27;1;31;0
WireConnection;179;1;180;0
WireConnection;179;0;223;0
WireConnection;207;0;195;0
WireConnection;256;0;254;1
WireConnection;256;1;254;2
WireConnection;256;2;255;0
WireConnection;196;0;207;0
WireConnection;154;1;27;0
WireConnection;154;0;310;0
WireConnection;167;0;179;0
WireConnection;257;0;254;0
WireConnection;257;1;256;0
WireConnection;258;0;257;0
WireConnection;193;0;154;0
WireConnection;193;1;194;0
WireConnection;193;2;196;0
WireConnection;170;0;193;0
WireConnection;170;1;181;0
WireConnection;122;0;120;3
WireConnection;302;0;123;0
WireConnection;302;1;301;0
WireConnection;23;1;5;0
WireConnection;23;0;20;4
WireConnection;121;0;120;1
WireConnection;121;1;120;2
WireConnection;124;0;302;0
WireConnection;124;2;121;0
WireConnection;124;1;122;0
WireConnection;1;1;170;0
WireConnection;83;0;23;0
WireConnection;241;0;259;0
WireConnection;241;2;243;0
WireConnection;241;3;274;0
WireConnection;242;0;241;0
WireConnection;183;0;182;0
WireConnection;183;1;124;0
WireConnection;281;0;279;1
WireConnection;281;1;279;2
WireConnection;262;0;260;1
WireConnection;262;1;260;2
WireConnection;213;0;1;0
WireConnection;280;0;279;3
WireConnection;212;0;1;1
WireConnection;212;1;1;4
WireConnection;261;0;260;3
WireConnection;227;0;170;0
WireConnection;238;1;237;0
WireConnection;238;0;236;0
WireConnection;102;1;183;0
WireConnection;264;0;263;0
WireConnection;264;2;262;0
WireConnection;264;1;261;0
WireConnection;210;1;212;0
WireConnection;210;0;213;0
WireConnection;275;0;242;0
WireConnection;275;1;241;0
WireConnection;275;2;276;0
WireConnection;187;0;43;0
WireConnection;232;0;229;0
WireConnection;232;1;233;0
WireConnection;128;0;127;1
WireConnection;128;1;127;2
WireConnection;283;0;282;0
WireConnection;283;2;281;0
WireConnection;283;1;280;0
WireConnection;106;0;84;0
WireConnection;106;1;107;0
WireConnection;130;0;127;3
WireConnection;284;0;228;0
WireConnection;284;1;283;0
WireConnection;284;2;287;0
WireConnection;231;0;184;0
WireConnection;231;1;232;0
WireConnection;144;0;13;0
WireConnection;68;0;210;0
WireConnection;240;0;264;0
WireConnection;240;1;238;0
WireConnection;131;0;129;0
WireConnection;131;2;128;0
WireConnection;131;1;130;0
WireConnection;246;0;275;0
WireConnection;111;0;102;1
WireConnection;111;1;105;0
WireConnection;111;2;106;0
WireConnection;211;0;1;0
WireConnection;51;1;52;0
WireConnection;51;0;187;0
WireConnection;9;0;111;0
WireConnection;9;1;144;0
WireConnection;9;2;13;0
WireConnection;119;1;240;0
WireConnection;230;1;184;0
WireConnection;230;0;231;0
WireConnection;21;1;22;0
WireConnection;21;0;20;3
WireConnection;209;0;51;0
WireConnection;247;0;246;0
WireConnection;224;1;284;0
WireConnection;126;1;131;0
WireConnection;214;0;211;0
WireConnection;82;0;21;0
WireConnection;267;0;126;1
WireConnection;225;0;224;1
WireConnection;189;0;209;0
WireConnection;77;0;24;4
WireConnection;142;0;119;1
WireConnection;148;1;230;0
WireConnection;112;0;146;0
WireConnection;112;1;73;0
WireConnection;112;2;9;0
WireConnection;269;0;267;0
WireConnection;269;1;271;3
WireConnection;252;0;249;0
WireConnection;252;1;250;0
WireConnection;252;2;244;0
WireConnection;133;0;134;0
WireConnection;133;1;136;0
WireConnection;162;1;163;0
WireConnection;162;0;112;0
WireConnection;268;0;267;0
WireConnection;268;1;271;2
WireConnection;149;0;71;0
WireConnection;149;1;148;0
WireConnection;270;0;267;0
WireConnection;270;1;271;1
WireConnection;234;1;235;0
WireConnection;91;0;149;0
WireConnection;75;0;24;0
WireConnection;89;0;162;0
WireConnection;89;1;190;0
WireConnection;89;2;97;0
WireConnection;89;3;150;0
WireConnection;89;4;226;0
WireConnection;89;5;252;0
WireConnection;272;0;270;0
WireConnection;272;1;268;0
WireConnection;272;2;269;0
WireConnection;265;0;139;0
WireConnection;265;1;234;1
WireConnection;265;2;133;0
WireConnection;266;0;272;0
WireConnection;266;1;265;0
WireConnection;266;2;132;0
WireConnection;6;0;89;0
WireConnection;15;0;16;0
WireConnection;15;1;78;0
WireConnection;15;2;92;0
WireConnection;220;0;92;0
WireConnection;220;1;219;0
WireConnection;220;2;217;0
WireConnection;220;3;78;0
WireConnection;95;0;6;0
WireConnection;191;1;192;0
WireConnection;191;0;266;0
WireConnection;215;0;220;0
WireConnection;215;1;15;0
WireConnection;137;0;191;0
WireConnection;304;1;303;0
WireConnection;208;0;96;0
WireConnection;218;1;15;0
WireConnection;218;0;215;0
WireConnection;306;1;305;0
WireConnection;0;9;208;0
WireConnection;0;13;218;0
WireConnection;0;11;138;0
ASEEND*/
//CHKSM=B0736F2074279AC90BC5B12660CE5506AEB1F773