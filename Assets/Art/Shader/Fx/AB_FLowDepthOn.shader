// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Whl/Fx/AB_FLowDepthOn"
{
	Properties
	{
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("CullMode", Float) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)]_ZTestMode("ZTestMode", Float) = 8
		[Toggle(_UV2CONTROLOFFSET_ON)] _UV2ControlOffset("UV2ControlOffset", Float) = 0
		[HDR][Header(Main)]_MainColor("MainColor", Color) = (0,0,0,0)
		_MainTex("MainTex", 2D) = "white" {}
		_Mask_Tex("Mask_Tex", 2D) = "white" {}
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
		_VertexOffsetStr("VertexOffsetStr", Float) = 1
		[Header(SoftParticle)]_FadeRange("FadeRange", Float) = 1
		[Toggle(_SOFTPARTICLE_ON)] _SoftParticle("SoftParticle", Float) = 0
		_FreOn("FreOn", Range( 0 , 1)) = 0
		_FreScale("FreScale", Float) = 1
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
		ZWrite On
		ZTest [_ZTestMode]
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _VERTEXOFFSETON_ON
		#pragma shader_feature_local _UV1_WCONTORLVERTEXOFFSET_ON
		#pragma shader_feature_local _DISSOLUTIONON_ON
		#pragma shader_feature_local _RGBA_ON
		#pragma shader_feature_local _UV2CONTROLOFFSET_ON
		#pragma shader_feature_local _DISTURBON_ON
		#pragma shader_feature_local _UV3_XCONTORLDISTURB_ON
		#pragma shader_feature_local _UV1_TCONTORLDIS_ON
		#pragma shader_feature_local _SOFTPARTICLE_ON
		#pragma shader_feature_local _DISTURBFADETEX_ON
		#pragma shader_feature_local _BACKFACEON_ON
		#pragma shader_feature_local _DISTURBRAMP_ON
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
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
		uniform sampler2D _VertexOffsetTex;
		uniform float3 _VertexOffsetTexPanner;
		uniform float4 _VertexOffsetTex_ST;
		uniform float _VertexOffsetStr;
		uniform sampler2D _VertexOffsetMask;
		uniform float4 _VertexOffsetMask_ST;
		uniform sampler2D _MainTex;
		uniform float3 _MainTexPanner;
		uniform float4 _MainTex_ST;
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
		uniform float _FreScale;
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
			float3 ase_vertexNormal = v.normal.xyz;
			#ifdef _UV1_WCONTORLVERTEXOFFSET_ON
				float staticSwitch21 = v.texcoord.z;
			#else
				float staticSwitch21 = 1.0;
			#endif
			float UV1_W82 = staticSwitch21;
			float4 uvs_VertexOffsetMask = v.texcoord;
			uvs_VertexOffsetMask.xy = v.texcoord.xy * _VertexOffsetMask_ST.xy + _VertexOffsetMask_ST.zw;
			#ifdef _VERTEXOFFSETON_ON
				float3 staticSwitch191 = ( tex2Dlod( _VertexOffsetTex, float4( panner131, 0, 0.0) ).r * ase_vertexNormal * 0.1 * _VertexOffsetStr * UV1_W82 * tex2Dlod( _VertexOffsetMask, float4( uvs_VertexOffsetMask.xy, 0, 0.0) ).r );
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
			float2 panner27 = ( mulTime31 * appendResult30 + uvs_MainTex.xy);
			float UV2_W152 = i.uv2_texcoord2.z;
			float UV2_T160 = i.uv2_texcoord2.w;
			float2 appendResult157 = (float2(UV2_W152 , UV2_T160));
			#ifdef _UV2CONTROLOFFSET_ON
				float2 staticSwitch154 = ( uvs_MainTex.xy + appendResult157 );
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
			float2 panner175 = ( mulTime173 * appendResult174 + uvs_DisturbTex.xy);
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
			float2 panner124 = ( mulTime122 * appendResult121 + uvs_DissolutionTex.xy);
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
			float Mask_TexR225 = tex2D( _Mask_Tex, MainTexUV227 ).r;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float3 ase_normWorldNormal = normalize( ase_worldNormal );
			float3 appendResult256 = (float3(ase_normWorldNormal.x , ase_normWorldNormal.y , -ase_normWorldNormal.z));
			float3 switchResult257 = (((i.ASEVFace>0)?(ase_normWorldNormal):(appendResult256)));
			float3 WorldNormal258 = switchResult257;
			float fresnelNdotV241 = dot( WorldNormal258, ase_worldViewDir );
			float fresnelNode241 = ( 0.0 + _FreScale * pow( max( 1.0 - fresnelNdotV241 , 0.0001 ), 5.0 ) );
			float clampResult246 = clamp( ( 1.0 - fresnelNode241 ) , 0.0 , 1.0 );
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
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 

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
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float4 customPack1 : TEXCOORD1;
				float4 customPack2 : TEXCOORD2;
				float2 customPack3 : TEXCOORD3;
				float4 screenPos : TEXCOORD4;
				float4 tSpace0 : TEXCOORD5;
				float4 tSpace1 : TEXCOORD6;
				float4 tSpace2 : TEXCOORD7;
				half4 color : COLOR0;
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
				o.customPack1.xyzw = customInputData.uv_texcoord;
				o.customPack1.xyzw = v.texcoord;
				o.customPack2.xyzw = customInputData.uv2_texcoord2;
				o.customPack2.xyzw = v.texcoord1;
				o.customPack3.xy = customInputData.uv3_texcoord3;
				o.customPack3.xy = v.texcoord2;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				o.screenPos = ComputeScreenPos( o.pos );
				o.color = v.color;
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
				surfIN.uv_texcoord = IN.customPack1.xyzw;
				surfIN.uv2_texcoord2 = IN.customPack2.xyzw;
				surfIN.uv3_texcoord3 = IN.customPack3.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				surfIN.screenPos = IN.screenPos;
				surfIN.vertexColor = IN.color;
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
				surf( surfIN, o );
				UnityGI gi;
				UNITY_INITIALIZE_OUTPUT( UnityGI, gi );
				o.Alpha = LightingStandardCustomLighting( o, worldViewDir, gi ).a;
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
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
-1450;90;1450;845;5830.679;2295.64;6.528962;True;True
Node;AmplifyShaderEditor.CommentaryNode;169;-5061.914,455.8446;Inherit;False;1883.194;986.6012;DisturbColor;14;178;167;179;177;201;180;166;175;172;174;173;171;222;223;DisturbColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;203;-4060.576,-533.9757;Inherit;False;1124.562;519.4683;Comment;4;200;202;205;206;UV3;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector3Node;171;-4957.69,759.1779;Inherit;False;Property;_DisturbPanner;DisturbPanner;25;0;Create;True;0;0;0;False;0;False;0,0,1;0,-0.2,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TextureCoordinatesNode;202;-3994.059,-358.6486;Inherit;False;2;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;206;-3956.111,-473.67;Inherit;False;Constant;_Float12;Float 12;28;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;173;-4709.691,866.1779;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;172;-4904.507,598.9349;Inherit;False;0;166;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;174;-4706.691,712.1779;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;205;-3694.111,-444.67;Inherit;False;Property;_UV3_XContorlDisturb;UV3_XContorlDisturb;24;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;151;-4025.395,-1142.584;Inherit;False;1143.907;365.912;Comment;3;160;152;38;UV2;1,1,1,1;0;0
Node;AmplifyShaderEditor.PannerNode;175;-4525.01,680.3159;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;200;-3374.938,-421.3047;Inherit;False;UV3_X;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;38;-3996.365,-1078.663;Inherit;False;1;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;166;-4285.875,668.4697;Inherit;True;Property;_DisturbTex;DisturbTex;22;1;[Header];Create;True;1;Disturb;0;0;False;0;False;-1;None;b28aa3592a6c7744ca21b7b4567228d9;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;152;-3527.857,-1060.301;Inherit;False;UV2_W;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;178;-4195.651,874.1562;Inherit;False;Property;_DisturbStr;DisturbStr;27;0;Create;True;0;0;0;False;0;False;0;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;201;-4205.741,997.8446;Inherit;False;200;UV3_X;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;80;-2611.824,-2316.12;Inherit;False;2819.581;793.3801;MainTex;26;210;68;213;211;212;1;170;193;181;154;196;194;207;27;159;31;30;195;157;158;28;29;153;161;214;227;MainTex;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;160;-3529.321,-965.6096;Inherit;False;UV2_T;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;222;-3980.643,1034.874;Inherit;False;Property;_DisturbDir;DisturbDir;26;0;Create;True;0;0;0;False;0;False;1,1;1,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;161;-2514.756,-1662.183;Inherit;False;160;UV2_T;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;177;-3953.277,850.7222;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;253;1062.243,1214.427;Inherit;False;1088.13;274.4167;WorldNormal;5;258;257;256;255;254;WorldNormal;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;153;-2517.486,-1756.831;Inherit;False;152;UV2_W;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;29;-2561.824,-2105.876;Inherit;False;Property;_MainTexPanner;MainTexPanner;9;0;Create;True;0;0;0;False;0;False;0,0,1;1.5,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;157;-2283.213,-1735.265;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;223;-3795.224,854.8176;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;28;-2508.641,-2266.12;Inherit;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;158;-2373.718,-1893.599;Inherit;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldNormalVector;254;1112.243,1264.427;Inherit;False;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;30;-2310.825,-2152.876;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;180;-3908.679,617.4449;Inherit;False;Constant;_0;0;32;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;195;-1939.375,-1887.204;Inherit;False;Property;_Rotater;Rotater;8;0;Create;True;0;0;0;False;0;False;0;0;0;360;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;31;-2313.825,-1998.876;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;255;1314.969,1377.844;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;207;-1666.604,-1881.482;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;360;False;3;FLOAT;0;False;4;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;179;-3645.221,708.7817;Inherit;False;Property;_DisturbOn;DisturbOn;23;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;159;-2098.762,-1864.906;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;27;-2129.145,-2184.739;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;154;-1869.75,-2069.359;Inherit;False;Property;_UV2ControlOffset;UV2ControlOffset;3;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PiNode;196;-1490.313,-1881.489;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;256;1471.969,1320.844;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;93;-4029.789,-1809.215;Inherit;False;1252.226;378.732;Comment;7;23;83;5;82;21;22;20;UV1;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;94;-3150.239,422.7572;Inherit;False;4022.833;1852.103;Comment;36;145;125;147;95;6;89;97;150;162;112;163;146;73;9;111;144;13;106;102;105;107;124;84;122;123;121;120;182;183;188;190;226;250;249;252;244;FinalOpacity;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;194;-1632.339,-1982.5;Inherit;False;Constant;_Float11;Float 11;26;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;167;-3402.546,715.6287;Inherit;False;DisturbColor;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SwitchByFaceNode;257;1708.969,1269.844;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RotatorNode;193;-1384.377,-2038.88;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector3Node;120;-3081.241,831.2411;Inherit;False;Property;_DissolutionTexPanner;DissolutionTexPanner;21;0;Create;True;0;0;0;False;0;False;0,0,1;0,-1,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TextureCoordinatesNode;20;-3979.789,-1732.483;Inherit;True;0;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;181;-1591.122,-1761.188;Inherit;False;167;DisturbColor;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-3769.224,-1515.427;Inherit;False;Property;_Dissolution;Dissolution;19;0;Create;True;0;0;0;False;0;False;0.15;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;165;-211.8256,2535.596;Inherit;False;1569.977;1259.165;FadeTex;14;225;142;224;119;240;238;228;236;237;260;261;262;263;264;FadeTex;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;170;-1194.381,-2029.389;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;123;-2983.059,679.998;Inherit;False;0;102;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;258;1926.373,1265.698;Inherit;False;WorldNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;23;-3433.2,-1587.579;Inherit;False;Property;_UV1_TContorlDis;UV1_TContorlDis;18;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;122;-2787.242,946.2411;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;251;1078.086,473.507;Inherit;False;1459.488;425.4343;FreOP;6;241;242;246;247;243;259;FreOP;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;121;-2784.242,792.2411;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;188;-1342.374,1858.86;Inherit;False;1080.439;324.1655;SoftParticle;6;189;51;187;52;43;209;SoftParticle;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;83;-3056.958,-1590.79;Inherit;False;UV1_T;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-975.8948,-2060.755;Inherit;True;Property;_MainTex;MainTex;5;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;243;1102.086,730.9406;Inherit;False;Property;_FreScale;FreScale;37;0;Create;True;0;0;0;False;0;False;1;5.6;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;182;-2686.151,545.7786;Inherit;False;167;DisturbColor;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;124;-2611.663,697.979;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector3Node;260;-164.417,2876.641;Inherit;False;Property;_FadeTexPanner;FadeTexPanner;11;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;259;1109.155,607.3345;Inherit;False;258;WorldNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;90;-2498.941,-647.7783;Inherit;False;2227.146;782.8557;MainColor;10;148;91;71;149;184;229;230;231;232;233;MainColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;233;-2396.687,7.478149;Inherit;False;Property;_RampDisStr;RampDisStr;15;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;213;-537.5737,-1981.953;Inherit;False;False;False;False;True;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;261;63.58203,2983.641;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;262;86.58203,2829.641;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;236;-74.52514,3165.953;Inherit;False;167;DisturbColor;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;263;-72.12929,2693.574;Inherit;False;0;119;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;229;-2364.309,-84.66939;Inherit;False;167;DisturbColor;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;107;-2176.793,1134.093;Inherit;False;Constant;_Float4;Float 4;20;0;Create;True;0;0;0;False;0;False;-2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;241;1439.325,644.5438;Inherit;True;Standard;WorldNormal;ViewDir;False;True;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;237;-30.5251,3081.17;Inherit;False;Constant;_Float13;Float 13;30;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;183;-2379.151,640.7786;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;84;-2203.008,1030.231;Inherit;False;83;UV1_T;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-1281.035,2046.839;Inherit;False;Property;_FadeRange;FadeRange;34;1;[Header];Create;True;1;SoftParticle;0;0;False;0;False;1;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;212;-498.295,-2093.511;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;106;-1898.274,1029.769;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;238;228.2696,3084.085;Inherit;False;Property;_DisturbFadeTex;DisturbFadeTex;12;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;232;-2093.588,-103.9218;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;264;267.2619,2759.777;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;210;-260.8716,-2100.742;Inherit;False;Property;_RGBA;RGBA;7;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;187;-1101.51,2027.025;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;184;-2419.658,-367.5649;Inherit;False;0;148;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;242;1759.653,644.7582;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;52;-1072.423,1931.541;Inherit;False;Constant;_Float1;Float 1;14;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;105;-1792.496,885.9973;Inherit;False;Constant;_Float3;Float 3;20;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;227;-1021.888,-2168.068;Inherit;False;MainTexUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-1736.571,1079.536;Inherit;False;Property;_DissolutionSoft;DissolutionSoft;20;0;Create;True;0;0;0;False;0;False;0.3935294;0.661;0.51;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;102;-1865.474,688.3781;Inherit;True;Property;_DissolutionTex;DissolutionTex;16;1;[Header];Create;True;1;Dissolution;0;0;False;0;False;-1;None;8b11858a6b89d594593faf2c070f13d3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;231;-1928.822,-194.1953;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;228;150.2976,3509.296;Inherit;False;227;MainTexUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ComponentMaskNode;211;-551.2866,-1775.902;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ClampOpNode;246;1943.741,645.2052;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;81;378.5724,-1825.137;Inherit;False;498.0005;281.3341;VertexColor;3;75;77;24;VertexColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;164;-2593.921,2466.331;Inherit;False;2157.99;1246.194;VertexOffset;16;139;137;191;133;192;132;126;136;134;131;128;130;129;127;234;235;VertexOffset;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;68;-30.40601,-2099.116;Inherit;False;MainTexAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;240;542.1273,2984.734;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;51;-837.7764,1938.786;Inherit;False;Property;_SoftParticle;SoftParticle;35;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;111;-1418.706,836.6912;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;144;-1432.574,973.5309;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;127;-2543.921,2681.715;Inherit;False;Property;_VertexOffsetTexPanner;VertexOffsetTexPanner;32;0;Create;True;0;0;0;False;0;False;0,0,1;2,0.5,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.StaticSwitch;230;-1784.309,-312.0064;Inherit;False;Property;_DisturbRamp;DisturbRamp;14;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-3716.271,-1759.215;Inherit;False;Constant;_Float0;Float 0;7;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;119;669.4441,2918.637;Inherit;True;Property;_FadeTex;FadeTex;10;1;[Header];Create;True;1;Fade;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;73;-809.7432,973.9466;Inherit;False;68;MainTexAlpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;9;-1054.454,1087.443;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;224;373.3791,3488.301;Inherit;True;Property;_Mask_Tex;Mask_Tex;6;0;Create;True;0;0;0;False;0;False;-1;None;cbe3db36b66e37a4e817e8db61ec70a8;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;209;-605.8218,1960.608;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;214;-141,-1779.253;Inherit;False;MainTexColor;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;247;2146.223,578.3796;Inherit;False;FreOP;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;146;-783.1946,891.1973;Inherit;False;Constant;_Float9;Float 9;27;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;24;428.5724,-1775.137;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;21;-3420.962,-1751.425;Inherit;False;Property;_UV1_WContorlVertexOffset;UV1_WContorlVertexOffset;30;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;71;-1479.458,-571.7523;Inherit;True;214;MainTexColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;148;-1537.998,-334.5495;Inherit;True;Property;_RampTex;RampTex;13;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;77;647.2477,-1659.803;Inherit;False;VertexColorA;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;128;-2190.026,2684.331;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;142;985.5274,2942.172;Inherit;False;FadeTexR;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;163;-535.0894,843.3393;Inherit;False;68;MainTexAlpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;249;-442.0035,1446.896;Inherit;False;Constant;_Float15;Float 15;39;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;244;-523.4933,1656.788;Inherit;False;Property;_FreOn;FreOn;36;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;112;-527.3167,1011.487;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;189;-475.0421,1943.396;Inherit;False;SoftParticle;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;250;-473.2662,1546.29;Inherit;False;247;FreOP;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;130;-2224.027,2778.331;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;129;-2360.028,2516.331;Inherit;False;0;126;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;225;817.4979,3510.307;Inherit;False;Mask_TexR;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;149;-1111.11,-393.847;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;235;-1900.399,3390.898;Inherit;False;0;234;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;226;-232.0631,1344.127;Inherit;False;225;Mask_TexR;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;82;-3053.415,-1749.079;Inherit;False;UV1_W;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;150;-225.7535,1247.518;Inherit;False;142;FadeTexR;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;252;-203.3554,1478.785;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;131;-1976.025,2678.331;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;162;-268.5611,959.7405;Inherit;False;Property;_DissolutionOn;DissolutionOn;17;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;190;-238.2671,1056.991;Inherit;False;189;SoftParticle;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;97;-247.6361,1151.806;Inherit;False;77;VertexColorA;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;75;645.5729,-1766.231;Inherit;False;VertexColorRGB;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;234;-1611.985,3369.233;Inherit;True;Property;_VertexOffsetMask;VertexOffsetMask;31;0;Create;True;0;0;0;False;0;False;-1;None;a8f586d0bcfc4564b8136683f458ae26;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;136;-1574.728,3157.568;Inherit;False;Property;_VertexOffsetStr;VertexOffsetStr;33;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;134;-1560.728,3050.568;Inherit;False;Constant;_Float7;Float 7;25;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;89;49.80009,1019.094;Inherit;True;6;6;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;139;-1548.021,3261.14;Inherit;False;82;UV1_W;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;132;-1602.728,2883.568;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;91;-810.5136,-398.6811;Inherit;True;MainColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;126;-1720.243,2642.189;Inherit;True;Property;_VertexOffsetTex;VertexOffsetTex;28;1;[Header];Create;True;1;VertexOffset;0;0;False;0;False;-1;None;7ed3ff3a17b4be14cbfb32b4f0bd32a6;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;16;-212.954,-815.0086;Inherit;False;Property;_MainColor;MainColor;4;2;[HDR];[Header];Create;True;1;Main;0;0;False;0;False;0,0,0,0;2.996078,2.996078,2.996078,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;133;-1287.728,2805.568;Inherit;False;6;6;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;78;-238.4297,-590.9456;Inherit;False;75;VertexColorRGB;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;192;-1244.281,2659.539;Inherit;False;Constant;_Float2;Float 2;27;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;6;336.8301,1013.601;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;92;-209.4033,-420.5108;Inherit;False;91;MainColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;219;-168.7295,-293.0279;Inherit;False;Property;_BackFaceColor;BackFaceColor;38;2;[HDR];[Header];Create;True;1;BackFaceColor;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;217;-118.6549,-76.52956;Inherit;False;Property;_BackFaceIntensity;BackFaceIntensity;40;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;232.438,-623.3128;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;220;275.0029,-330.1549;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;95;536.4009,996.0136;Inherit;False;FinalOpacity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;191;-1091.71,2724.582;Inherit;False;Property;_VertexOffsetOn;VertexOffsetOn;29;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;96;457.2399,-864.7418;Inherit;True;95;FinalOpacity;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;137;-752.0217,2733.224;Inherit;False;VertexOffset;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;46;-4525.035,-1801.048;Inherit;False;448;277.753;Comment;2;36;37;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SwitchByFaceNode;215;632.3391,-478.4238;Inherit;False;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-4471.555,-1751.049;Inherit;False;Property;_CullMode;CullMode;0;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;145;-2162.496,1247.239;Inherit;False;Constant;_Float8;Float 8;27;0;Create;True;0;0;0;False;0;False;0.57;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;218;938.9389,-613.0234;Inherit;False;Property;_BackFaceOn;BackFaceOn;39;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;208;750.324,-858.8317;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;138;828.8001,-329.0221;Inherit;False;137;VertexOffset;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;147;-2163.945,920.5771;Inherit;False;Constant;_Float10;Float 10;27;0;Create;True;0;0;0;False;0;False;0.61;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;37;-4475.035,-1653.295;Inherit;False;Property;_ZTestMode;ZTestMode;1;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CompareFunction;True;0;False;8;8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;125;-1992.38,894.0255;Inherit;False;Constant;_Float6;Float 6;23;0;Create;True;0;0;0;False;0;False;0.58;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1210.138,-839.6459;Float;False;True;-1;2;ASEMaterialInspector;0;0;CustomLighting;Whl/Fx/AB_FLowDepthOn;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;1;False;141;0;True;37;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Custom;;Transparent;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;2;-1;-1;-1;0;False;0;0;True;36;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;173;0;171;3
WireConnection;174;0;171;1
WireConnection;174;1;171;2
WireConnection;205;1;206;0
WireConnection;205;0;202;1
WireConnection;175;0;172;0
WireConnection;175;2;174;0
WireConnection;175;1;173;0
WireConnection;200;0;205;0
WireConnection;166;1;175;0
WireConnection;152;0;38;3
WireConnection;160;0;38;4
WireConnection;177;0;166;1
WireConnection;177;1;178;0
WireConnection;177;2;201;0
WireConnection;157;0;153;0
WireConnection;157;1;161;0
WireConnection;223;0;177;0
WireConnection;223;1;222;0
WireConnection;30;0;29;1
WireConnection;30;1;29;2
WireConnection;31;0;29;3
WireConnection;255;0;254;3
WireConnection;207;0;195;0
WireConnection;179;1;180;0
WireConnection;179;0;223;0
WireConnection;159;0;158;0
WireConnection;159;1;157;0
WireConnection;27;0;28;0
WireConnection;27;2;30;0
WireConnection;27;1;31;0
WireConnection;154;1;27;0
WireConnection;154;0;159;0
WireConnection;196;0;207;0
WireConnection;256;0;254;1
WireConnection;256;1;254;2
WireConnection;256;2;255;0
WireConnection;167;0;179;0
WireConnection;257;0;254;0
WireConnection;257;1;256;0
WireConnection;193;0;154;0
WireConnection;193;1;194;0
WireConnection;193;2;196;0
WireConnection;170;0;193;0
WireConnection;170;1;181;0
WireConnection;258;0;257;0
WireConnection;23;1;5;0
WireConnection;23;0;20;4
WireConnection;122;0;120;3
WireConnection;121;0;120;1
WireConnection;121;1;120;2
WireConnection;83;0;23;0
WireConnection;1;1;170;0
WireConnection;124;0;123;0
WireConnection;124;2;121;0
WireConnection;124;1;122;0
WireConnection;213;0;1;0
WireConnection;261;0;260;3
WireConnection;262;0;260;1
WireConnection;262;1;260;2
WireConnection;241;0;259;0
WireConnection;241;2;243;0
WireConnection;183;0;182;0
WireConnection;183;1;124;0
WireConnection;212;0;1;1
WireConnection;212;1;1;4
WireConnection;106;0;84;0
WireConnection;106;1;107;0
WireConnection;238;1;237;0
WireConnection;238;0;236;0
WireConnection;232;0;229;0
WireConnection;232;1;233;0
WireConnection;264;0;263;0
WireConnection;264;2;262;0
WireConnection;264;1;261;0
WireConnection;210;1;212;0
WireConnection;210;0;213;0
WireConnection;187;0;43;0
WireConnection;242;0;241;0
WireConnection;227;0;170;0
WireConnection;102;1;183;0
WireConnection;231;0;184;0
WireConnection;231;1;232;0
WireConnection;211;0;1;0
WireConnection;246;0;242;0
WireConnection;68;0;210;0
WireConnection;240;0;264;0
WireConnection;240;1;238;0
WireConnection;51;1;52;0
WireConnection;51;0;187;0
WireConnection;111;0;102;1
WireConnection;111;1;105;0
WireConnection;111;2;106;0
WireConnection;144;0;13;0
WireConnection;230;1;184;0
WireConnection;230;0;231;0
WireConnection;119;1;240;0
WireConnection;9;0;111;0
WireConnection;9;1;144;0
WireConnection;9;2;13;0
WireConnection;224;1;228;0
WireConnection;209;0;51;0
WireConnection;214;0;211;0
WireConnection;247;0;246;0
WireConnection;21;1;22;0
WireConnection;21;0;20;3
WireConnection;148;1;230;0
WireConnection;77;0;24;4
WireConnection;128;0;127;1
WireConnection;128;1;127;2
WireConnection;142;0;119;1
WireConnection;112;0;146;0
WireConnection;112;1;73;0
WireConnection;112;2;9;0
WireConnection;189;0;209;0
WireConnection;130;0;127;3
WireConnection;225;0;224;1
WireConnection;149;0;71;0
WireConnection;149;1;148;0
WireConnection;82;0;21;0
WireConnection;252;0;249;0
WireConnection;252;1;250;0
WireConnection;252;2;244;0
WireConnection;131;0;129;0
WireConnection;131;2;128;0
WireConnection;131;1;130;0
WireConnection;162;1;163;0
WireConnection;162;0;112;0
WireConnection;75;0;24;0
WireConnection;234;1;235;0
WireConnection;89;0;162;0
WireConnection;89;1;190;0
WireConnection;89;2;97;0
WireConnection;89;3;150;0
WireConnection;89;4;226;0
WireConnection;89;5;252;0
WireConnection;91;0;149;0
WireConnection;126;1;131;0
WireConnection;133;0;126;1
WireConnection;133;1;132;0
WireConnection;133;2;134;0
WireConnection;133;3;136;0
WireConnection;133;4;139;0
WireConnection;133;5;234;1
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
WireConnection;191;0;133;0
WireConnection;137;0;191;0
WireConnection;215;0;220;0
WireConnection;215;1;15;0
WireConnection;218;1;15;0
WireConnection;218;0;215;0
WireConnection;208;0;96;0
WireConnection;0;9;208;0
WireConnection;0;13;218;0
WireConnection;0;11;138;0
ASEEND*/
//CHKSM=2D0BB4D8ED171113CF39AFF7D9EFFFCA4DF1951C