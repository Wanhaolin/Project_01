// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Whl/Fx/ParticleMatCap"
{
	Properties
	{
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("CullMode", Float) = 0
		[Enum(UnityEngine.Rendering.BlendMode)]_Dst("Dst", Float) = 10
		[Enum(On,1,Off,0)]_ZWriteMode("ZWriteMode", Float) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)]_ZTestMode("ZTestMode", Float) = 8
		[HDR][Header(Main)]_MainColor("MainColor", Color) = (0,0,0,0)
		_Matcap("Matcap", 2D) = "white" {}
		_NormalMap("NormalMap", 2D) = "bump" {}
		_Mask_Tex("Mask_Tex", 2D) = "white" {}
		[Toggle(_OWNUV_ON)] _OwnUV("OwnUV", Float) = 0
		[Toggle(_UV3_XCONTORLDISTURB_ON)] _UV3_XContorlDisturb("UV3_XContorlDisturb", Float) = 0
		[Header(VertexOffset)]_VertexOffsetTex("VertexOffsetTex", 2D) = "white" {}
		_MaskTexPanner("MaskTexPanner", Vector) = (0,0,1,0)
		[Toggle(_VERTEXOFFSETON_ON)] _VertexOffsetOn("VertexOffsetOn", Float) = 0
		[Toggle(_UV1_WCONTORLVERTEXOFFSET_ON)] _UV1_WContorlVertexOffset("UV1_WContorlVertexOffset", Float) = 0
		_VertexOffsetMask("VertexOffsetMask", 2D) = "white" {}
		_VertexOffsetTexPanner("VertexOffsetTexPanner", Vector) = (0,0,1,0)
		_VertexOffsetStr("VertexOffsetStr", Float) = 1
		[Header(Fade)]_FadeTex("FadeTex", 2D) = "white" {}
		_RampTex("RampTex", 2D) = "white" {}
		_OffsetDir("OffsetDir", Vector) = (1,1,1,0)
		_FadeTexPanner("FadeTexPanner", Vector) = (0,0,1,0)
		[Header(Dissolution)]_DissolutionTex("DissolutionTex", 2D) = "white" {}
		[Toggle(_DISSOLUTIONON_ON)] _DissolutionOn("DissolutionOn", Float) = 0
		[Toggle(_UV1_TCONTORLDIS_ON)] _UV1_TContorlDis("UV1_TContorlDis", Float) = 0
		_Dissolution("Dissolution", Range( 0 , 1)) = 0.15
		_DissolutionSoft("DissolutionSoft", Range( 0.51 , 1)) = 0.3935294
		_DissolutionTexPanner("DissolutionTexPanner", Vector) = (0,0,1,0)
		[Header(Disturb)]_DisturbTex("DisturbTex", 2D) = "white" {}
		[Toggle(_DISTURBON_ON)] _DisturbOn("DisturbOn", Float) = 0
		_DisturbDir("DisturbDir", Vector) = (1,1,0,0)
		_DisturbPanner("DisturbPanner", Vector) = (0,0,1,0)
		_DisturbStr("DisturbStr", Float) = 0
		[Header(SoftParticle)]_FadeRange("FadeRange", Float) = 1
		[Toggle(_SOFTPARTICLE_ON)] _SoftParticle("SoftParticle", Float) = 0
		_FreOn("FreOn", Range( 0 , 1)) = 0
		_FreInvers("FreInvers", Range( 0 , 1)) = 0
		_FreScale("FreScale", Float) = 1
		_FrePower("FrePower", Float) = 5
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
		#pragma target 5.0
		#pragma shader_feature_local _VERTEXOFFSETON_ON
		#pragma shader_feature_local _UV1_WCONTORLVERTEXOFFSET_ON
		#pragma shader_feature_local _DISSOLUTIONON_ON
		#pragma shader_feature_local _DISTURBON_ON
		#pragma shader_feature_local _UV3_XCONTORLDISTURB_ON
		#pragma shader_feature_local _UV1_TCONTORLDIS_ON
		#pragma shader_feature_local _SOFTPARTICLE_ON
		#pragma shader_feature_local _OWNUV_ON
		#pragma surface surf StandardCustomLighting keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float3 worldNormal;
			INTERNAL_DATA
			float4 uv_texcoord;
			float2 uv3_texcoord3;
			float4 screenPos;
			float4 vertexColor : COLOR;
			float3 worldPos;
			half ASEVFace : VFACE;
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
		uniform float _Dst;
		uniform float _ZWriteMode;
		uniform sampler2D _VertexOffsetTex;
		uniform float3 _VertexOffsetTexPanner;
		uniform float4 _VertexOffsetTex_ST;
		uniform float3 _OffsetDir;
		uniform sampler2D _VertexOffsetMask;
		uniform float4 _VertexOffsetMask_ST;
		uniform float _VertexOffsetStr;
		uniform sampler2D _Matcap;
		uniform sampler2D _NormalMap;
		uniform float4 _NormalMap_ST;
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
		uniform float _FreScale;
		uniform float _FrePower;
		uniform float _FreInvers;
		uniform float _FreOn;
		uniform sampler2D _RampTex;
		uniform float4 _RampTex_ST;
		uniform float4 _MainColor;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 temp_cast_0 = (0.0).xxx;
			float mulTime37 = _Time.y * _VertexOffsetTexPanner.z;
			float2 appendResult36 = (float2(_VertexOffsetTexPanner.x , _VertexOffsetTexPanner.y));
			float4 uvs_VertexOffsetTex = v.texcoord;
			uvs_VertexOffsetTex.xy = v.texcoord.xy * _VertexOffsetTex_ST.xy + _VertexOffsetTex_ST.zw;
			float2 panner38 = ( mulTime37 * appendResult36 + uvs_VertexOffsetTex.xy);
			float temp_output_41_0 = (-1.0 + (tex2Dlod( _VertexOffsetTex, float4( panner38, 0, 0.0) ).r - 0.0) * (1.0 - -1.0) / (1.0 - 0.0));
			float3 appendResult53 = (float3(( temp_output_41_0 * _OffsetDir.x ) , ( temp_output_41_0 * _OffsetDir.y ) , ( temp_output_41_0 * _OffsetDir.z )));
			#ifdef _UV1_WCONTORLVERTEXOFFSET_ON
				float staticSwitch26 = v.texcoord.z;
			#else
				float staticSwitch26 = 1.0;
			#endif
			float UV1_W27 = staticSwitch26;
			float4 uvs_VertexOffsetMask = v.texcoord;
			uvs_VertexOffsetMask.xy = v.texcoord.xy * _VertexOffsetMask_ST.xy + _VertexOffsetMask_ST.zw;
			float3 ase_vertexNormal = v.normal.xyz;
			#ifdef _VERTEXOFFSETON_ON
				float3 staticSwitch56 = ( appendResult53 * ( UV1_W27 * tex2Dlod( _VertexOffsetMask, float4( uvs_VertexOffsetMask.xy, 0, 0.0) ).r * ( 0.1 * _VertexOffsetStr ) ) * ase_vertexNormal );
			#else
				float3 staticSwitch56 = temp_cast_0;
			#endif
			float3 VertexOffset57 = staticSwitch56;
			v.vertex.xyz += VertexOffset57;
			v.vertex.w = 1;
		}

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			float2 temp_cast_2 = (0.0).xx;
			float mulTime169 = _Time.y * _DisturbPanner.z;
			float2 appendResult168 = (float2(_DisturbPanner.x , _DisturbPanner.y));
			float4 uvs_DisturbTex = i.uv_texcoord;
			uvs_DisturbTex.xy = i.uv_texcoord.xy * _DisturbTex_ST.xy + _DisturbTex_ST.zw;
			float2 panner170 = ( mulTime169 * appendResult168 + uvs_DisturbTex.xy);
			#ifdef _UV3_XCONTORLDISTURB_ON
				float staticSwitch14 = i.uv3_texcoord3.x;
			#else
				float staticSwitch14 = 1.0;
			#endif
			float UV3_X17 = staticSwitch14;
			#ifdef _DISTURBON_ON
				float2 staticSwitch178 = ( ( tex2D( _DisturbTex, panner170 ).r * _DisturbStr * UV3_X17 ) * _DisturbDir );
			#else
				float2 staticSwitch178 = temp_cast_2;
			#endif
			float2 DisturbColor179 = staticSwitch178;
			float2 temp_output_8_0 = ( ( (mul( UNITY_MATRIX_V, float4( (WorldNormalVector( i , UnpackNormal( tex2D( _NormalMap, uv_NormalMap ) ) )) , 0.0 ) ).xyz).xy + 1.0 + DisturbColor179 ) * 0.5 );
			float4 tex2DNode10 = tex2D( _Matcap, temp_output_8_0 );
			float MainTexAlpha149 = tex2DNode10.r;
			float mulTime109 = _Time.y * _DissolutionTexPanner.z;
			float2 appendResult108 = (float2(_DissolutionTexPanner.x , _DissolutionTexPanner.y));
			float4 uvs_DissolutionTex = i.uv_texcoord;
			uvs_DissolutionTex.xy = i.uv_texcoord.xy * _DissolutionTex_ST.xy + _DissolutionTex_ST.zw;
			float2 panner110 = ( mulTime109 * appendResult108 + uvs_DissolutionTex.xy);
			#ifdef _UV1_TCONTORLDIS_ON
				float staticSwitch23 = i.uv_texcoord.w;
			#else
				float staticSwitch23 = _Dissolution;
			#endif
			float UV1_T24 = staticSwitch23;
			float smoothstepResult125 = smoothstep( ( 1.0 - _DissolutionSoft ) , _DissolutionSoft , ( tex2D( _DissolutionTex, panner110 ).r + 1.0 + ( UV1_T24 * -2.0 ) ));
			float lerpResult131 = lerp( 0.0 , MainTexAlpha149 , smoothstepResult125);
			#ifdef _DISSOLUTIONON_ON
				float staticSwitch135 = lerpResult131;
			#else
				float staticSwitch135 = MainTexAlpha149;
			#endif
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth121 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth121 = abs( ( screenDepth121 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _FadeRange ) );
			#ifdef _SOFTPARTICLE_ON
				float staticSwitch124 = distanceDepth121;
			#else
				float staticSwitch124 = 1.0;
			#endif
			float SoftParticle130 = saturate( staticSwitch124 );
			float VertexColorA102 = i.vertexColor.a;
			float mulTime73 = _Time.y * _FadeTexPanner.z;
			float2 appendResult70 = (float2(_FadeTexPanner.x , _FadeTexPanner.y));
			float4 uvs_FadeTex = i.uv_texcoord;
			uvs_FadeTex.xy = i.uv_texcoord.xy * _FadeTex_ST.xy + _FadeTex_ST.zw;
			float2 panner78 = ( mulTime73 * appendResult70 + uvs_FadeTex.xy);
			float FadeTexR85 = tex2D( _FadeTex, panner78 ).r;
			float2 MatCapUV184 = temp_output_8_0;
			float mulTime69 = _Time.y * _MaskTexPanner.z;
			float2 appendResult68 = (float2(_MaskTexPanner.x , _MaskTexPanner.y));
			float4 uvs_Mask_Tex = i.uv_texcoord;
			uvs_Mask_Tex.xy = i.uv_texcoord.xy * _Mask_Tex_ST.xy + _Mask_Tex_ST.zw;
			float2 panner76 = ( mulTime69 * appendResult68 + uvs_Mask_Tex.xy);
			#ifdef _OWNUV_ON
				float2 staticSwitch185 = panner76;
			#else
				float2 staticSwitch185 = MatCapUV184;
			#endif
			float Mask_TexR84 = tex2D( _Mask_Tex, staticSwitch185 ).r;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_normWorldNormal = normalize( ase_worldNormal );
			float3 appendResult88 = (float3(ase_normWorldNormal.x , ase_normWorldNormal.y , -ase_normWorldNormal.z));
			float3 switchResult89 = (((i.ASEVFace>0)?(ase_normWorldNormal):(appendResult88)));
			float3 WorldNormal90 = switchResult89;
			float fresnelNdotV94 = dot( WorldNormal90, ase_worldViewDir );
			float fresnelNode94 = ( 0.0 + _FreScale * pow( max( 1.0 - fresnelNdotV94 , 0.0001 ), _FrePower ) );
			float lerpResult97 = lerp( ( 1.0 - fresnelNode94 ) , fresnelNode94 , _FreInvers);
			float clampResult98 = clamp( lerpResult97 , 0.0 , 1.0 );
			float FreOP99 = clampResult98;
			float lerpResult139 = lerp( 1.0 , FreOP99 , _FreOn);
			float FinalOpacity143 = saturate( ( staticSwitch135 * SoftParticle130 * VertexColorA102 * FadeTexR85 * Mask_TexR84 * lerpResult139 ) );
			float4 MatCapColor162 = tex2DNode10;
			float4 uvs_RampTex = i.uv_texcoord;
			uvs_RampTex.xy = i.uv_texcoord.xy * _RampTex_ST.xy + _RampTex_ST.zw;
			float4 MainColor154 = ( MatCapColor162 * tex2D( _RampTex, uvs_RampTex.xy ) );
			float4 VertexColorRGB103 = i.vertexColor;
			c.rgb = ( MainColor154 * _MainColor * VertexColorRGB103 ).rgb;
			c.a = saturate( FinalOpacity143 );
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
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
436;148.8;1367.2;756.6;477.9988;-2893.946;2.053149;True;False
Node;AmplifyShaderEditor.CommentaryNode;11;-4157.02,308.1985;Inherit;False;1124.562;519.4683;Comment;4;17;14;13;12;UV3;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;165;-6826.6,1405.062;Inherit;False;1883.194;986.6012;DisturbColor;14;179;178;177;176;175;174;173;172;171;170;169;168;167;166;DisturbColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;12;-4111.243,639.491;Inherit;False;2;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;166;-6722.375,1708.396;Inherit;False;Property;_DisturbPanner;DisturbPanner;32;0;Create;True;0;0;0;False;0;False;0,0,1;0,2,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;13;-4086.933,505.624;Inherit;False;Constant;_Float12;Float 12;28;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;14;-3787.199,526.6904;Inherit;False;Property;_UV3_XContorlDisturb;UV3_XContorlDisturb;10;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;168;-6471.376,1661.396;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;169;-6474.376,1815.396;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;167;-6669.192,1548.153;Inherit;False;0;171;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;17;-3445.331,535.001;Inherit;False;UV3_X;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;170;-6289.696,1629.534;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;172;-5960.336,1823.374;Inherit;False;Property;_DisturbStr;DisturbStr;33;0;Create;True;0;0;0;False;0;False;0;-0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;62;811.1442,813.6417;Inherit;False;1088.13;274.4167;WorldNormal;5;90;89;88;87;86;WorldNormal;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;173;-5970.426,1947.062;Inherit;False;17;UV3_X;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;151;-2689.268,-2296.171;Inherit;False;3337.304;1969.577;MainColor;6;161;157;154;153;152;163;MainColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;171;-6050.561,1617.688;Inherit;True;Property;_DisturbTex;DisturbTex;29;1;[Header];Create;True;1;Disturb;0;0;False;0;False;-1;None;b111d5f279d12c64c844b5cc4f357c2a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;163;-2516.496,-839.5711;Inherit;False;2856.676;458.1624;MatCapColor;14;10;162;149;8;7;6;180;4;5;3;2;1;9;184;MatCapColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;174;-5717.962,1799.94;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;175;-5745.329,1984.092;Inherit;False;Property;_DisturbDir;DisturbDir;31;0;Create;True;0;0;0;False;0;False;1,1;1,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.WorldNormalVector;86;861.1442,863.6417;Inherit;False;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NegateNode;87;1063.87,977.0588;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;176;-5673.366,1566.663;Inherit;False;Constant;_0;0;32;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;9;-2466.496,-672.5638;Inherit;True;Property;_NormalMap;NormalMap;7;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;177;-5559.912,1804.035;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;88;1220.87,920.0587;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldNormalVector;1;-2118.457,-668.563;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.StaticSwitch;178;-5409.909,1657.999;Inherit;False;Property;_DisturbOn;DisturbOn;30;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ViewMatrixNode;2;-2059.703,-768.1712;Inherit;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.SwitchByFaceNode;89;1457.87,869.0587;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;20;-4125.02,-971.8018;Inherit;False;1252.226;378.732;Comment;7;27;26;25;24;23;22;21;UV1;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;179;-5167.233,1664.846;Inherit;False;DisturbColor;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-1874.161,-751.4476;Inherit;False;2;2;0;FLOAT4x4;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;180;-1778.384,-560.176;Inherit;False;179;DisturbColor;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SwizzleNode;4;-1663.744,-748.2552;Inherit;False;FLOAT2;0;1;2;3;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-3865.724,-715.1202;Inherit;False;Property;_Dissolution;Dissolution;26;0;Create;True;0;0;0;False;0;False;0.15;0.498;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-1882.13,-653.0843;Inherit;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;104;-4167.426,2922.293;Inherit;False;4022.833;1852.103;Comment;34;146;144;143;142;141;140;139;138;137;136;135;134;133;132;131;129;128;127;125;123;122;120;119;118;117;114;113;111;110;109;108;107;106;105;FinalOpacity;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;22;-4107.02,-916.8018;Inherit;True;0;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;63;826.9872,-121.7661;Inherit;False;1485.673;682.3762;FreOP;9;99;98;97;96;95;94;93;92;91;FreOP;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;90;1675.274,864.9127;Inherit;False;WorldNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;106;-3814.583,3384.881;Inherit;False;Property;_DissolutionTexPanner;DissolutionTexPanner;28;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;93;911.3402,200.6822;Inherit;False;Property;_FrePower;FrePower;39;0;Create;True;0;0;0;False;0;False;5;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;92;880.9872,110.6676;Inherit;False;Property;_FreScale;FreScale;38;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;23;-3444.009,-757.692;Inherit;False;Property;_UV1_TContorlDis;UV1_TContorlDis;25;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;91;858.0562,12.06136;Inherit;False;90;WorldNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;6;-1483.675,-751.9568;Inherit;False;3;3;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;64;787.3582,1986.631;Inherit;False;1826.183;1688.764;FadeTex;16;85;84;83;82;78;76;73;72;70;69;68;67;66;65;183;185;FadeTex;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1518.827,-574.3323;Inherit;False;Constant;_Float1;Float 1;1;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-1293.675,-753.9568;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;108;-3526.584,3336.881;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;105;-2359.427,4362.292;Inherit;False;1080.439;324.1655;SoftParticle;6;130;126;124;121;116;115;SoftParticle;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector3Node;65;915.4732,3296.28;Inherit;False;Property;_MaskTexPanner;MaskTexPanner;12;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TextureCoordinatesNode;107;-3718.583,3224.881;Inherit;False;0;119;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;24;-3149.021,-763.8018;Inherit;False;UV1_T;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;33;-4157.43,1298.523;Inherit;False;2578.479;1252.42;VertexOffset;24;57;56;55;54;53;52;51;50;49;48;47;46;45;44;43;42;41;40;39;38;37;36;35;34;VertexOffset;1,1,1,1;0;0
Node;AmplifyShaderEditor.FresnelNode;94;1100.301,37.54768;Inherit;True;Standard;WorldNormal;ViewDir;False;True;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;109;-3526.584,3496.881;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;67;1034.654,3077.036;Inherit;False;0;82;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;68;1155.674,3273.077;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;184;-1071.609,-773.7656;Inherit;False;MatCapUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector3Node;66;834.7661,2327.677;Inherit;False;Property;_FadeTexPanner;FadeTexPanner;21;0;Create;True;0;0;0;False;0;False;0,0,1;0.5,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleTimeNode;69;1158.564,3412.303;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;115;-2311.427,4554.292;Inherit;False;Property;_FadeRange;FadeRange;34;1;[Header];Create;True;1;SoftParticle;0;0;False;0;False;1;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;96;1412.296,105.41;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;34;-4103.378,1538.214;Inherit;False;Property;_VertexOffsetTexPanner;VertexOffsetTexPanner;16;0;Create;True;0;0;0;False;0;False;0,0,1;0,1,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;113;-3223.427,3530.293;Inherit;False;24;UV1_T;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;110;-3350.584,3240.881;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;95;1299.131,369.0912;Inherit;False;Property;_FreInvers;FreInvers;37;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;114;-3207.427,3642.292;Inherit;False;Constant;_Float5;Float 4;20;0;Create;True;0;0;0;False;0;False;-2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;76;1368.448,3285.668;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;10;-759.8341,-688.8619;Inherit;True;Property;_Matcap;Matcap;6;0;Create;True;0;0;0;False;0;False;-1;None;b6f8225d51157464eb16a6ce401e9969;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;183;1371.581,3145.3;Inherit;False;184;MatCapUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;73;1062.765,2434.677;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;119;-2887.427,3194.293;Inherit;True;Property;_DissolutionTex;DissolutionTex;23;1;[Header];Create;True;1;Dissolution;0;0;False;0;False;-1;None;b111d5f279d12c64c844b5cc4f357c2a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;35;-3939.74,1360.675;Inherit;False;0;39;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;72;925.5688,2144.609;Inherit;False;0;83;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;70;1085.765,2280.676;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;117;-2919.427,3530.293;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;36;-3755.259,1519.173;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DepthFade;121;-2119.427,4522.292;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;97;1593.131,35.09114;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;37;-3783.484,1634.829;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;118;-2823.427,3386.293;Inherit;False;Constant;_Float8;Float 3;20;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;116;-2103.427,4426.292;Inherit;False;Constant;_Float6;Float 1;14;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;120;-2761.435,3656.618;Inherit;False;Property;_DissolutionSoft;DissolutionSoft;27;0;Create;True;0;0;0;False;0;False;0.3935294;1;0.51;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;149;-382.8725,-571.188;Inherit;False;MainTexAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-3727.548,-925.4501;Inherit;False;Constant;_Float2;Float 0;7;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;185;1568.312,3242.19;Inherit;False;Property;_OwnUV;OwnUV;9;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;100;-4094.582,-1625.931;Inherit;False;498.0005;281.3341;VertexColor;3;103;102;101;VertexColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.ClampOpNode;98;1843.636,34.81258;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;122;-2439.427,3338.293;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;78;1266.445,2210.813;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;38;-3555.737,1453.807;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;124;-1863.426,4442.292;Inherit;False;Property;_SoftParticle;SoftParticle;35;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;123;-2455.427,3482.293;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;82;1836.509,3259.816;Inherit;True;Property;_Mask_Tex;Mask_Tex;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SmoothstepOpNode;125;-2071.427,3594.293;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;26;-3517.021,-923.8018;Inherit;False;Property;_UV1_WContorlVertexOffset;UV1_WContorlVertexOffset;14;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;83;1668.627,2369.673;Inherit;True;Property;_FadeTex;FadeTex;18;1;[Header];Create;True;1;Fade;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;101;-4044.583,-1575.931;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;126;-1623.426,4458.292;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;127;-1831.426,3482.293;Inherit;False;149;MainTexAlpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;128;-1815.426,3386.293;Inherit;False;Constant;_Float9;Float 9;27;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;39;-3349.993,1428.388;Inherit;True;Property;_VertexOffsetTex;VertexOffsetTex;11;1;[Header];Create;True;1;VertexOffset;0;0;False;0;False;-1;None;b111d5f279d12c64c844b5cc4f357c2a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;99;1997.841,29.32649;Inherit;False;FreOP;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;129;-1543.426,4154.292;Inherit;False;Property;_FreOn;FreOn;36;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;85;1984.71,2393.208;Inherit;False;FadeTexR;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;133;-1495.426,4042.292;Inherit;False;99;FreOP;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;27;-3149.021,-907.8018;Inherit;False;UV1_W;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;134;-1559.426,3338.293;Inherit;False;149;MainTexAlpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;84;2182.328,3281.823;Inherit;False;Mask_TexR;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-3454.44,2329.989;Inherit;False;Constant;_Float7;Float 7;25;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;132;-1463.426,3946.293;Inherit;False;Constant;_Float15;Float 15;39;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;131;-1559.426,3514.293;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;41;-2990.206,1446.7;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-1;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;42;-3627.984,2172.9;Inherit;False;0;49;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;40;-3048.423,1682.809;Inherit;True;Property;_OffsetDir;OffsetDir;20;0;Create;True;0;0;0;False;0;False;1,1,1;1,1,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;44;-3450.845,2414.294;Inherit;False;Property;_VertexOffsetStr;VertexOffsetStr;17;0;Create;True;0;0;0;False;0;False;1;1.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;102;-3825.908,-1460.597;Inherit;False;VertexColorA;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;130;-1495.426,4442.292;Inherit;False;SoftParticle;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;136;-1255.426,3562.293;Inherit;False;130;SoftParticle;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;162;-389.6096,-700.3463;Inherit;False;MatCapColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;46;-3275.606,2041.975;Inherit;False;27;UV1_W;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;157;-2264.038,-1962.594;Inherit;False;0;161;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;135;-1287.426,3466.293;Inherit;False;Property;_DissolutionOn;DissolutionOn;24;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;-3199.671,2352.145;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;49;-3339.569,2151.235;Inherit;True;Property;_VertexOffsetMask;VertexOffsetMask;15;0;Create;True;0;0;0;False;0;False;-1;None;0cf3558dfb9ed9e4e86602625bbbe5c4;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;-2751.133,1477.622;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;137;-1255.426,3850.293;Inherit;False;84;Mask_TexR;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;140;-1271.426,3658.293;Inherit;False;102;VertexColorA;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;-2759.765,1777.568;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;50;-2755.88,1624.799;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;139;-1223.426,3978.292;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;138;-1255.426,3754.293;Inherit;False;85;FadeTexR;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;-2836.213,2054.169;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;51;-2848.773,2211.014;Inherit;True;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;152;-1669.785,-2220.146;Inherit;True;162;MatCapColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;141;-967.4264,3514.293;Inherit;True;6;6;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;161;-1728.325,-1982.943;Inherit;True;Property;_RampTex;RampTex;19;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;53;-2550.174,1560.416;Inherit;True;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-2304.063,1618.486;Inherit;False;Constant;_Float3;Float 2;27;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;153;-1301.437,-2042.24;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;142;-695.4257,3514.293;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;54;-2280.953,1756.97;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;103;-3827.583,-1567.025;Inherit;False;VertexColorRGB;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;143;-487.4256,3498.293;Inherit;False;FinalOpacity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;56;-2079.381,1676.83;Inherit;False;Property;_VertexOffsetOn;VertexOffsetOn;13;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;154;-486.859,-2065.004;Inherit;True;MainColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;164;-918.2313,113.4804;Inherit;False;154;MainColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;28;-4774.11,-941.7842;Inherit;False;490.0942;445.175;Comment;4;32;31;30;29;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;57;-1790.924,1673.871;Inherit;False;VertexOffset;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;15;-4125.02,-315.8016;Inherit;False;1143.907;365.912;Comment;3;19;18;16;UV2;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;147;-839.6068,-118.7861;Inherit;True;143;FinalOpacity;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;181;-915.2871,433.9403;Inherit;False;103;VertexColorRGB;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;150;-922.108,234.7688;Inherit;False;Property;_MainColor;MainColor;5;2;[HDR];[Header];Create;True;1;Main;0;0;False;0;False;0,0,0,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;61;-845.6866,710.397;Inherit;False;Property;_Float4;Float 4;22;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;18;-3613.021,-219.8016;Inherit;False;UV2_W;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;58;-863.9537,592.222;Inherit;False;57;VertexOffset;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;144;-3191.427,3418.293;Inherit;False;Constant;_Float10;Float 10;27;0;Create;True;0;0;0;False;0;False;0.61;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-4710.109,-589.7842;Inherit;False;Property;_Dst;Dst;2;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;0;False;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;148;-546.5227,-112.876;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;60;-578.8294,101.0473;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-4726.109,-781.7842;Inherit;False;Property;_ZTestMode;ZTestMode;4;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CompareFunction;True;0;False;8;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;146;-3015.427,3402.293;Inherit;False;Constant;_Float14;Float 6;23;0;Create;True;0;0;0;False;0;False;0.58;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-4710.109,-893.7842;Inherit;False;Property;_CullMode;CullMode;1;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;16;-4093.02,-251.8016;Inherit;False;1;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;19;-3629.021,-123.8015;Inherit;False;UV2_T;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;111;-3703.427,3050.293;Inherit;False;-1;;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;29;-4726.109,-701.7842;Inherit;False;Property;_ZWriteMode;ZWriteMode;3;1;[Enum];Create;True;0;2;On;1;Off;0;0;True;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-249.1416,-14.53418;Float;False;True;-1;7;ASEMaterialInspector;0;0;CustomLighting;Whl/Fx/ParticleMatCap;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;True;29;7;True;32;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;True;30;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;True;31;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;14;1;13;0
WireConnection;14;0;12;1
WireConnection;168;0;166;1
WireConnection;168;1;166;2
WireConnection;169;0;166;3
WireConnection;17;0;14;0
WireConnection;170;0;167;0
WireConnection;170;2;168;0
WireConnection;170;1;169;0
WireConnection;171;1;170;0
WireConnection;174;0;171;1
WireConnection;174;1;172;0
WireConnection;174;2;173;0
WireConnection;87;0;86;3
WireConnection;177;0;174;0
WireConnection;177;1;175;0
WireConnection;88;0;86;1
WireConnection;88;1;86;2
WireConnection;88;2;87;0
WireConnection;1;0;9;0
WireConnection;178;1;176;0
WireConnection;178;0;177;0
WireConnection;89;0;86;0
WireConnection;89;1;88;0
WireConnection;179;0;178;0
WireConnection;3;0;2;0
WireConnection;3;1;1;0
WireConnection;4;0;3;0
WireConnection;90;0;89;0
WireConnection;23;1;21;0
WireConnection;23;0;22;4
WireConnection;6;0;4;0
WireConnection;6;1;5;0
WireConnection;6;2;180;0
WireConnection;8;0;6;0
WireConnection;8;1;7;0
WireConnection;108;0;106;1
WireConnection;108;1;106;2
WireConnection;24;0;23;0
WireConnection;94;0;91;0
WireConnection;94;2;92;0
WireConnection;94;3;93;0
WireConnection;109;0;106;3
WireConnection;68;0;65;1
WireConnection;68;1;65;2
WireConnection;184;0;8;0
WireConnection;69;0;65;3
WireConnection;96;0;94;0
WireConnection;110;0;107;0
WireConnection;110;2;108;0
WireConnection;110;1;109;0
WireConnection;76;0;67;0
WireConnection;76;2;68;0
WireConnection;76;1;69;0
WireConnection;10;1;8;0
WireConnection;73;0;66;3
WireConnection;119;1;110;0
WireConnection;70;0;66;1
WireConnection;70;1;66;2
WireConnection;117;0;113;0
WireConnection;117;1;114;0
WireConnection;36;0;34;1
WireConnection;36;1;34;2
WireConnection;121;0;115;0
WireConnection;97;0;96;0
WireConnection;97;1;94;0
WireConnection;97;2;95;0
WireConnection;37;0;34;3
WireConnection;149;0;10;1
WireConnection;185;1;183;0
WireConnection;185;0;76;0
WireConnection;98;0;97;0
WireConnection;122;0;119;1
WireConnection;122;1;118;0
WireConnection;122;2;117;0
WireConnection;78;0;72;0
WireConnection;78;2;70;0
WireConnection;78;1;73;0
WireConnection;38;0;35;0
WireConnection;38;2;36;0
WireConnection;38;1;37;0
WireConnection;124;1;116;0
WireConnection;124;0;121;0
WireConnection;123;0;120;0
WireConnection;82;1;185;0
WireConnection;125;0;122;0
WireConnection;125;1;123;0
WireConnection;125;2;120;0
WireConnection;26;1;25;0
WireConnection;26;0;22;3
WireConnection;83;1;78;0
WireConnection;126;0;124;0
WireConnection;39;1;38;0
WireConnection;99;0;98;0
WireConnection;85;0;83;1
WireConnection;27;0;26;0
WireConnection;84;0;82;1
WireConnection;131;0;128;0
WireConnection;131;1;127;0
WireConnection;131;2;125;0
WireConnection;41;0;39;1
WireConnection;102;0;101;4
WireConnection;130;0;126;0
WireConnection;162;0;10;0
WireConnection;135;1;134;0
WireConnection;135;0;131;0
WireConnection;47;0;43;0
WireConnection;47;1;44;0
WireConnection;49;1;42;0
WireConnection;48;0;41;0
WireConnection;48;1;40;1
WireConnection;45;0;41;0
WireConnection;45;1;40;3
WireConnection;50;0;41;0
WireConnection;50;1;40;2
WireConnection;139;0;132;0
WireConnection;139;1;133;0
WireConnection;139;2;129;0
WireConnection;52;0;46;0
WireConnection;52;1;49;1
WireConnection;52;2;47;0
WireConnection;141;0;135;0
WireConnection;141;1;136;0
WireConnection;141;2;140;0
WireConnection;141;3;138;0
WireConnection;141;4;137;0
WireConnection;141;5;139;0
WireConnection;161;1;157;0
WireConnection;53;0;48;0
WireConnection;53;1;50;0
WireConnection;53;2;45;0
WireConnection;153;0;152;0
WireConnection;153;1;161;0
WireConnection;142;0;141;0
WireConnection;54;0;53;0
WireConnection;54;1;52;0
WireConnection;54;2;51;0
WireConnection;103;0;101;0
WireConnection;143;0;142;0
WireConnection;56;1;55;0
WireConnection;56;0;54;0
WireConnection;154;0;153;0
WireConnection;57;0;56;0
WireConnection;18;0;16;3
WireConnection;148;0;147;0
WireConnection;60;0;164;0
WireConnection;60;1;150;0
WireConnection;60;2;181;0
WireConnection;19;0;16;4
WireConnection;0;9;148;0
WireConnection;0;13;60;0
WireConnection;0;11;58;0
ASEEND*/
//CHKSM=11022F398175685932255671635A223D13CFB4BD