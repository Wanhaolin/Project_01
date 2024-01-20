// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Whl/Fx/Cutting"
{
	Properties
	{
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("CullMode", Float) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)]_ZTestMode("ZTestMode", Float) = 8
		_MainTex("MainTex", 2D) = "white" {}
		_Rotater("Rotater", Range( 0 , 360)) = 0
		[HDR]_EmissionColor("EmissionColor", Color) = (0,0,0,0)
		_MainTexPanner("MainTexPanner", Vector) = (0,0,1,0)
		_TilingOffset("Tiling&Offset", Vector) = (0,0,0,0)
		_DotTex("DotTex", 2D) = "white" {}
		_Rotater2("Rotater2", Range( 0 , 360)) = 0
		[HDR]_DotColor("DotColor", Color) = (0,0,0,0)
		_DotTiling("DotTiling", Vector) = (0,0,0,0)
		_DotPanner("DotPanner", Vector) = (0,0,1,0)
		[Toggle(_UV1_WTCONTORLOFFSET_ON)] _UV1_WTContorlOffset("UV1_WT ContorlOffset", Float) = 0
		_Power("Power", Float) = 0
		_Scale("Scale", Float) = 1
		_BlackEdgeIntensity("BlackEdgeIntensity", Range( 0 , 1)) = 1
		_DisturbTex("DisturbTex", 2D) = "white" {}
		_Rotater3("Rotater3", Range( 0 , 360)) = 0
		_DisturTiling("DisturTiling", Vector) = (0,0,0,0)
		_DisturbPanner("DisturbPanner", Vector) = (0,0,1,0)
		_DisturbStr("DisturbStr", Range( 0 , 2)) = 0
		_VertexNoiseTex("VertexNoiseTex", 2D) = "white" {}
		_VertexNoisePanner("VertexNoisePanner", Vector) = (0,0,1,0)
		_VertexOffsetMask("VertexOffsetMask", 2D) = "white" {}
		_VertexOffsetMask2("VertexOffsetMask2", 2D) = "white" {}
		_VertexOffsetStr("VertexOffsetStr", Float) = 1
		[Toggle(_SOFTPARTICLE_ON)] _SoftParticle("SoftParticle", Float) = 0
		_SoftTilingOffset("SoftTiling&Offset", Vector) = (0,0,0,0)
		_Rotater5("Rotater5", Range( 0 , 360)) = 0
		_SoftFadeHardness("SoftFadeHardness", Range( 0.51 , 1)) = 0.51
		_FadeRange("FadeRange", Range( 0 , 20)) = 1
		_Hardness("Hardness", Range( 0 , 0.99)) = 0.51
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" }
		Cull [_CullMode]
		ZWrite Off
		ZTest [_ZTestMode]
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _UV1_WTCONTORLOFFSET_ON
		#pragma shader_feature_local _SOFTPARTICLE_ON
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 screenPos;
			float4 vertexColor : COLOR;
			float4 uv_texcoord;
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

		uniform float _ZTestMode;
		uniform float _CullMode;
		uniform sampler2D _VertexNoiseTex;
		uniform float3 _VertexNoisePanner;
		uniform float4 _VertexNoiseTex_ST;
		uniform sampler2D _VertexOffsetMask2;
		uniform float4 _VertexOffsetMask2_ST;
		uniform float _VertexOffsetStr;
		uniform sampler2D _VertexOffsetMask;
		uniform sampler2D _DisturbTex;
		uniform float _Rotater5;
		uniform float4 _SoftTilingOffset;
		uniform float _SoftFadeHardness;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _FadeRange;
		uniform float _Hardness;
		uniform sampler2D _MainTex;
		uniform float3 _MainTexPanner;
		uniform float _Rotater;
		uniform float4 _TilingOffset;
		uniform float3 _DisturbPanner;
		uniform float _Rotater3;
		uniform float2 _DisturTiling;
		uniform float _DisturbStr;
		uniform float4 _EmissionColor;
		uniform sampler2D _DotTex;
		uniform float3 _DotPanner;
		uniform float _Rotater2;
		uniform float2 _DotTiling;
		uniform float4 _DotColor;
		uniform float _Power;
		uniform float _Scale;
		uniform float _BlackEdgeIntensity;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float mulTime11 = _Time.y * _VertexNoisePanner.z;
			float2 appendResult10 = (float2(_VertexNoisePanner.x , _VertexNoisePanner.y));
			float2 uv2_VertexNoiseTex = v.texcoord1.xy * _VertexNoiseTex_ST.xy + _VertexNoiseTex_ST.zw;
			float2 panner7 = ( mulTime11 * appendResult10 + uv2_VertexNoiseTex);
			float4 uvs_VertexOffsetMask2 = v.texcoord;
			uvs_VertexOffsetMask2.xy = v.texcoord.xy * _VertexOffsetMask2_ST.xy + _VertexOffsetMask2_ST.zw;
			float2 appendResult20 = (float2(1.0 , v.texcoord.w));
			#ifdef _UV1_WTCONTORLOFFSET_ON
				float2 staticSwitch21 = appendResult20;
			#else
				float2 staticSwitch21 = float2( 0,0 );
			#endif
			float lerpResult14 = lerp( 0.0 , tex2Dlod( _VertexNoiseTex, float4( panner7, 0, 0.0) ).r , tex2Dlod( _VertexOffsetMask2, float4( ( uvs_VertexOffsetMask2.xy + staticSwitch21 ), 0, 0.0) ).r);
			float3 ase_vertexNormal = v.normal.xyz;
			float3 VertexOffset52 = ( ( lerpResult14 * v.texcoord.z ) * ase_vertexNormal * 0.01 * _VertexOffsetStr * tex2Dlod( _VertexOffsetMask, float4( uv2_VertexNoiseTex, 0, 0.0) ).r );
			v.vertex.xyz += VertexOffset52;
			v.vertex.w = 1;
		}

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float2 appendResult23 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
			float2 ScreenUV85 = appendResult23;
			float2 temp_cast_0 = (0.5).xx;
			float cos154 = cos( ( (0.0 + (_Rotater5 - 0.0) * (2.0 - 0.0) / (360.0 - 0.0)) * UNITY_PI ) );
			float sin154 = sin( ( (0.0 + (_Rotater5 - 0.0) * (2.0 - 0.0) / (360.0 - 0.0)) * UNITY_PI ) );
			float2 rotator154 = mul( ScreenUV85 - temp_cast_0 , float2x2( cos154 , -sin154 , sin154 , cos154 )) + temp_cast_0;
			float2 appendResult155 = (float2(_SoftTilingOffset.x , _SoftTilingOffset.y));
			float2 appendResult157 = (float2(_SoftTilingOffset.z , _SoftTilingOffset.w));
			float temp_output_3_0_g1 = tex2D( _DisturbTex, ( ( rotator154 * appendResult155 ) + appendResult157 ) ).r;
			float lerpResult5_g1 = lerp( temp_output_3_0_g1 , ( 1.0 - temp_output_3_0_g1 ) , 0.0);
			float screenDepth102 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth102 = abs( ( screenDepth102 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _FadeRange ) );
			#ifdef _SOFTPARTICLE_ON
				float staticSwitch104 = distanceDepth102;
			#else
				float staticSwitch104 = 1.0;
			#endif
			float SoftParticle106 = saturate( staticSwitch104 );
			float smoothstepResult171 = smoothstep( _SoftFadeHardness , ( 1.0 - _SoftFadeHardness ) , SoftParticle106);
			float temp_output_8_0_g1 = _Hardness;
			float mulTime135 = _Time.y * _MainTexPanner.z;
			float2 appendResult134 = (float2(_MainTexPanner.x , _MainTexPanner.y));
			float2 temp_cast_1 = (0.5).xx;
			float cos96 = cos( ( (0.0 + (_Rotater - 0.0) * (2.0 - 0.0) / (360.0 - 0.0)) * UNITY_PI ) );
			float sin96 = sin( ( (0.0 + (_Rotater - 0.0) * (2.0 - 0.0) / (360.0 - 0.0)) * UNITY_PI ) );
			float2 rotator96 = mul( ScreenUV85 - temp_cast_1 , float2x2( cos96 , -sin96 , sin96 , cos96 )) + temp_cast_1;
			float2 panner136 = ( mulTime135 * appendResult134 + rotator96);
			float2 appendResult34 = (float2(_TilingOffset.x , _TilingOffset.y));
			float2 appendResult35 = (float2(_TilingOffset.z , _TilingOffset.w));
			float mulTime64 = _Time.y * _DisturbPanner.z;
			float2 appendResult65 = (float2(_DisturbPanner.x , _DisturbPanner.y));
			float2 temp_cast_2 = (0.5).xx;
			float cos132 = cos( ( (0.0 + (_Rotater3 - 0.0) * (2.0 - 0.0) / (360.0 - 0.0)) * UNITY_PI ) );
			float sin132 = sin( ( (0.0 + (_Rotater3 - 0.0) * (2.0 - 0.0) / (360.0 - 0.0)) * UNITY_PI ) );
			float2 rotator132 = mul( ScreenUV85 - temp_cast_2 , float2x2( cos132 , -sin132 , sin132 , cos132 )) + temp_cast_2;
			float2 panner66 = ( mulTime64 * appendResult65 + ( rotator132 * _DisturTiling ));
			float4 tex2DNode67 = tex2D( _DisturbTex, panner66 );
			float2 appendResult73 = (float2(0.0 , ( tex2DNode67.r * _DisturbStr * 0.1 )));
			float2 DisturbColor110 = appendResult73;
			float4 MainColor112 = tex2D( _MainTex, ( ( ( panner136 * appendResult34 ) + appendResult35 ) + DisturbColor110 ) );
			float mulTime80 = _Time.y * _DotPanner.z;
			float2 appendResult81 = (float2(_DotPanner.x , _DotPanner.y));
			float2 temp_cast_4 = (0.5).xx;
			float cos126 = cos( ( (0.0 + (_Rotater2 - 0.0) * (2.0 - 0.0) / (360.0 - 0.0)) * UNITY_PI ) );
			float sin126 = sin( ( (0.0 + (_Rotater2 - 0.0) * (2.0 - 0.0) / (360.0 - 0.0)) * UNITY_PI ) );
			float2 rotator126 = mul( ScreenUV85 - temp_cast_4 , float2x2( cos126 , -sin126 , sin126 , cos126 )) + temp_cast_4;
			float2 panner82 = ( mulTime80 * appendResult81 + ( rotator126 * _DotTiling ));
			float4 DotColor118 = ( MainColor112 * tex2D( _DotTex, panner82 ).r * _DotColor );
			float2 break139 = ( i.uv_texcoord.xy + DisturbColor110 );
			float BlackEdge121 = ( saturate( ( pow( ( break139.x + distance( break139.y , 0.5 ) ) , _Power ) * _Scale ) ) * _BlackEdgeIntensity );
			float4 lerpResult54 = lerp( ( ( MainColor112 * _EmissionColor * float4( (i.vertexColor).rgb , 0.0 ) ) + DotColor118 ) , float4( 0,0,0,0 ) , BlackEdge121);
			c.rgb = lerpResult54.rgb;
			c.a = saturate( ( ( ( ( lerpResult5_g1 + 1.0 ) - ( ( 1.0 - (-0.5 + (smoothstepResult171 - 0.0) * (1.0 - -0.5) / (1.0 - 0.0)) ) * ( ( 1.0 - temp_output_8_0_g1 ) + 1.0 ) ) ) - temp_output_8_0_g1 ) / ( temp_output_8_0_g1 - 1.0 ) ) );
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
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float4 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				float4 screenPos : TEXCOORD3;
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
				o.customPack1.xyzw = customInputData.uv_texcoord;
				o.customPack1.xyzw = v.texcoord;
				o.worldPos = worldPos;
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
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
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
-1814;326;1708;830;1022.381;580.6882;1;True;True
Node;AmplifyShaderEditor.CommentaryNode;108;-3851.834,-1827.074;Inherit;False;690.3901;262;ScreenUV;3;24;23;85;ScreenUV;1,1,1,1;0;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;24;-3801.834,-1777.074;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;109;-7053.14,-1817.742;Inherit;False;2951.691;692.1406;DisturbColor;19;110;73;69;74;70;67;66;71;64;65;63;72;132;130;131;87;129;128;142;DisturbColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;128;-7024.627,-1565.114;Inherit;False;Property;_Rotater3;Rotater3;18;0;Create;True;0;0;0;False;0;False;0;145;0;360;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;23;-3549.902,-1747.474;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;129;-6751.856,-1559.392;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;360;False;3;FLOAT;0;False;4;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;85;-3385.444,-1749.796;Inherit;False;ScreenUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;87;-6501.058,-1766.674;Inherit;False;85;ScreenUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;130;-6532.294,-1659.471;Inherit;False;Constant;_Float7;Float 7;26;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PiNode;131;-6575.565,-1559.399;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;72;-5745.83,-1666.957;Inherit;False;Property;_DisturTiling;DisturTiling;19;0;Create;True;0;0;0;False;0;False;0,0;1,0.7;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector3Node;63;-5897.539,-1548.999;Inherit;False;Property;_DisturbPanner;DisturbPanner;20;0;Create;True;0;0;0;False;0;False;0,0,1;0,5,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RotatorNode;132;-6220.122,-1722.552;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;65;-5576.278,-1553.247;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;71;-5409.082,-1734.549;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;64;-5594.485,-1437.164;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;115;-6418.075,-945.0215;Inherit;False;3023.126;721.5464;MainColor;17;112;1;68;31;111;35;25;34;96;86;95;92;33;93;94;136;133;MainColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.PannerNode;66;-5236.489,-1580.662;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;94;-6358.523,-712.6783;Inherit;False;Property;_Rotater;Rotater;4;0;Create;True;0;0;0;False;0;False;0;0;0;360;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;70;-5023.783,-1404.471;Inherit;False;Property;_DisturbStr;DisturbStr;21;0;Create;True;0;0;0;False;0;False;0;2;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;67;-5011.802,-1608.682;Inherit;True;Property;_DisturbTex;DisturbTex;17;0;Create;True;0;0;0;False;0;False;-1;None;00f89943297a75241b347aebf637e968;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;74;-4907.676,-1320.551;Inherit;False;Constant;_Float3;Float 3;19;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;69;-4652.952,-1485.728;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;93;-6085.752,-706.9564;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;360;False;3;FLOAT;0;False;4;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;73;-4491.466,-1508.017;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;86;-5868.648,-893.6331;Inherit;False;85;ScreenUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PiNode;92;-5909.461,-706.9633;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;95;-5866.19,-807.0361;Inherit;False;Constant;_Float11;Float 11;26;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;133;-5883.159,-474.7502;Inherit;False;Property;_MainTexPanner;MainTexPanner;6;0;Create;True;0;0;0;False;0;False;0,0,1;0.1,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;117;-6484.876,-187.2162;Inherit;False;3078.673;863.483;DotColor;17;118;49;114;46;50;82;84;81;80;79;83;126;127;88;124;123;125;DotColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleTimeNode;135;-5602.935,-376.0247;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;120;-6153.704,2754.882;Inherit;False;2452.249;808.2228;BlackEdge;17;36;97;60;121;56;57;39;43;40;44;41;99;58;59;137;138;139;BlackEdge;1,1,1,1;0;0
Node;AmplifyShaderEditor.RotatorNode;96;-5554.017,-870.1166;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;110;-4310.337,-1512.76;Inherit;False;DisturbColor;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;134;-5613.944,-505.9825;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector4Node;33;-4912,-720;Inherit;False;Property;_TilingOffset;Tiling&Offset;7;0;Create;True;0;0;0;False;0;False;0,0,0,0;2.98,1,0,0.58;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;36;-6063.306,2866.405;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;136;-5173.423,-852.9458;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;125;-6406.64,-29.14296;Inherit;False;Property;_Rotater2;Rotater2;9;0;Create;True;0;0;0;False;0;False;0;178;0;360;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;34;-4624,-720;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;137;-6071.084,3069.096;Inherit;False;110;DisturbColor;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;35;-4640,-608;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;138;-5824.873,2866.677;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;-4464,-848;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;123;-6133.869,-23.42103;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;360;False;3;FLOAT;0;False;4;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;51;-5913.195,843.8367;Inherit;False;2485.714;1640.178;VertexOffset;22;52;3;5;14;6;12;4;2;15;16;7;18;17;10;11;8;21;9;20;19;75;78;VertexOffset;0.9811321,0.3193307,0.8939583,1;0;0
Node;AmplifyShaderEditor.PiNode;124;-5957.578,-23.42793;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;19;-5891.72,1409.582;Inherit;False;0;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;88;-5815.888,-138.7397;Inherit;False;85;ScreenUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;139;-5692.176,2865.712;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleAddOpNode;31;-4320,-832;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;59;-5774.844,3055.482;Inherit;False;Constant;_Float2;Float 2;15;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;127;-6177.729,-117.8007;Inherit;False;Constant;_Float8;Float 8;26;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;111;-4388.137,-698.0154;Inherit;False;110;DisturbColor;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;68;-4132.137,-858.0154;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector3Node;79;-5353.288,206.0078;Inherit;False;Property;_DotPanner;DotPanner;12;0;Create;True;0;0;0;False;0;False;0,0,1;0,1,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;9;-5862.217,1031.362;Inherit;False;Property;_VertexNoisePanner;VertexNoisePanner;23;0;Create;True;0;0;0;False;0;False;0,0,1;0,2,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RotatorNode;126;-5590.455,-110.0684;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;83;-5283.122,49.48408;Inherit;False;Property;_DotTiling;DotTiling;11;0;Create;True;0;0;0;False;0;False;0,0;10,0.01;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.DynamicAppendNode;20;-5643.864,1403.545;Inherit;False;FLOAT2;4;0;FLOAT;1;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;100;-5871.281,3662.591;Inherit;False;1224.518;355.4113;SoftParticle;6;106;105;104;102;103;101;SoftParticle;1,1,1,1;0;0
Node;AmplifyShaderEditor.DistanceOpNode;58;-5521.151,3067.635;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;80;-5073.064,304.7334;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;17;-5506.751,1251.788;Inherit;False;0;16;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;41;-5233.921,3146.09;Inherit;False;Property;_Power;Power;14;0;Create;True;0;0;0;False;0;False;0;1.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;81;-5084.073,174.7756;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;84;-5095.34,9.988783;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;10;-5557.635,1029.362;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;150;-3278.512,-575.8741;Inherit;False;Property;_Rotater5;Rotater5;29;0;Create;True;0;0;0;False;0;False;0;104;0;360;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;101;-5809.942,3850.57;Inherit;False;Property;_FadeRange;FadeRange;31;0;Create;True;0;0;0;False;0;False;1;3.84;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-3979.117,-885.9083;Inherit;True;Property;_MainTex;MainTex;3;0;Create;True;0;0;0;False;0;False;-1;None;9f7491c024c068c4fa1db13a179d44ea;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;21;-5503.821,1376.459;Inherit;False;Property;_UV1_WTContorlOffset;UV1_WT ContorlOffset;13;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;99;-5255.781,2906.474;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;11;-5587.635,1173.362;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;8;-5624.638,1742.518;Inherit;False;1;2;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;82;-4840.848,78.80894;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-4879.701,3148.298;Inherit;False;Property;_Scale;Scale;15;0;Create;True;0;0;0;False;0;False;1;1.81;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;153;-3005.741,-570.152;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;360;False;3;FLOAT;0;False;4;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;40;-4973.063,2877.33;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;103;-5601.331,3735.271;Inherit;False;Constant;_Float4;Float 4;14;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;102;-5630.417,3830.756;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;18;-5216.495,1304.686;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;112;-3618.951,-888.3113;Inherit;False;MainColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.PannerNode;7;-5355.635,1004.362;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;50;-4223.777,204.6088;Inherit;False;Property;_DotColor;DotColor;10;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;11.98431,11.98431,11.98431,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;151;-2786.179,-670.231;Inherit;False;Constant;_Float9;Float 9;26;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;16;-5050.247,1264.882;Inherit;True;Property;_VertexOffsetMask2;VertexOffsetMask2;25;0;Create;True;0;0;0;False;0;False;-1;None;89609648b6dd11e46bbb56d663098269;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;156;-2804.172,-460.3553;Inherit;False;Property;_SoftTilingOffset;SoftTiling&Offset;28;0;Create;True;0;0;0;False;0;False;0,0,0,0;2,2,0,0.58;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;15;-4857.694,893.8367;Inherit;False;Constant;_Float1;Float 1;6;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;-4680.923,2891.459;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;114;-4161.45,42.81666;Inherit;False;112;MainColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;46;-4526.224,58.19568;Inherit;True;Property;_DotTex;DotTex;8;0;Create;True;0;0;0;False;0;False;-1;None;7fb1b7a1c6a48df42ade1df70ae5000b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;104;-5366.685,3742.517;Inherit;False;Property;_SoftParticle;SoftParticle;27;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PiNode;152;-2829.45,-570.1591;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-5106.635,977.3623;Inherit;True;Property;_VertexNoiseTex;VertexNoiseTex;22;0;Create;True;0;0;0;False;0;False;-1;None;1eae6143ce30e2849b37136524e197f0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;149;-2828.657,-872.7291;Inherit;False;85;ScreenUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;49;-3895.308,84.3924;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;105;-4996.73,3764.339;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;39;-4483.604,2885.133;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;154;-2555.06,-868.3986;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;14;-4624.893,1069.58;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;57;-4579.119,3028.431;Inherit;False;Property;_BlackEdgeIntensity;BlackEdgeIntensity;16;0;Create;True;0;0;0;False;0;False;1;0.75;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;176;-1899.215,58.87443;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;155;-2516.172,-460.3553;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;172;-2047.482,-527.4603;Inherit;False;Property;_SoftFadeHardness;SoftFadeHardness;30;0;Create;True;0;0;0;False;0;False;0.51;1;0.51;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;158;-2316.63,-841.9882;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;106;-4849.951,3761.126;Inherit;False;SoftParticle;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-4930.016,1961.468;Inherit;False;Property;_VertexOffsetStr;VertexOffsetStr;26;0;Create;True;0;0;0;False;0;False;1;170;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;4;-4936.016,1687.468;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;157;-2532.172,-348.3551;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;78;-4399.673,1488.303;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;178;-1726.941,54.43958;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;12;-5019.829,2114.45;Inherit;True;Property;_VertexOffsetMask;VertexOffsetMask;24;0;Create;True;0;0;0;False;0;False;-1;None;6c4bd7b31c3a4dc4fa0792a443a3174b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;-4236.981,2919.531;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;113;-1713.486,-237.2864;Inherit;False;112;MainColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;118;-3704.625,78.2366;Inherit;False;DotColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;27;-1764.326,-144.6893;Inherit;False;Property;_EmissionColor;EmissionColor;5;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;1.158054,1.371249,2.828427,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;5;-4901.016,1845.467;Inherit;False;Constant;_Float0;Float 0;3;0;Create;True;0;0;0;False;0;False;0.01;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;107;-1834.559,-614.2794;Inherit;False;106;SoftParticle;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-4244.703,1628.96;Inherit;False;5;5;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;159;-2090.928,-848.2704;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;173;-1736.27,-446.4451;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;119;-1479.19,-84.53514;Inherit;False;118;DotColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;-1441.231,-230.1069;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;121;-4077.723,2913.351;Inherit;False;BlackEdge;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;168;-1549.538,-380.7507;Inherit;False;Property;_Hardness;Hardness;32;0;Create;True;0;0;0;False;0;False;0.51;0.36;0;0.99;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;148;-1876.705,-879.6238;Inherit;True;Property;_TextureSample0;Texture Sample 0;17;0;Create;True;0;0;0;False;0;False;-1;None;00f89943297a75241b347aebf637e968;True;0;False;white;Auto;False;Instance;67;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SmoothstepOpNode;171;-1555.153,-539.3475;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;89;-2931.299,-1829.385;Inherit;False;448;277.753;Comment;2;91;90;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;122;-1266.864,-45.06293;Inherit;False;121;BlackEdge;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;48;-1251.536,-170.9127;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;52;-3826.552,1313.788;Inherit;False;VertexOffset;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;175;-1243.885,-637.7062;Inherit;False;Dissolution;-1;;1;8ed0a8fdbfe80554382ce257577aff19;0;4;3;FLOAT;0;False;7;FLOAT;0;False;4;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;97;-5499.575,2804.882;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;53;-873.3285,-30.40857;Inherit;False;52;VertexOffset;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;90;-2881.299,-1681.632;Inherit;False;Property;_ZTestMode;ZTestMode;1;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CompareFunction;True;0;False;8;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;60;-5027.081,3142.253;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;142;-4622.983,-1628.357;Inherit;False;DisturbTexR;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;75;-4749.946,1542.049;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;91;-2877.819,-1779.386;Inherit;False;Property;_CullMode;CullMode;0;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;54;-1059.979,-129.2913;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;20.37033,-531.9373;Float;False;True;-1;2;ASEMaterialInspector;0;0;CustomLighting;Whl/Fx/Cutting;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;True;90;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Custom;;Transparent;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;2;-1;-1;-1;0;False;0;0;True;91;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;23;0;24;1
WireConnection;23;1;24;2
WireConnection;129;0;128;0
WireConnection;85;0;23;0
WireConnection;131;0;129;0
WireConnection;132;0;87;0
WireConnection;132;1;130;0
WireConnection;132;2;131;0
WireConnection;65;0;63;1
WireConnection;65;1;63;2
WireConnection;71;0;132;0
WireConnection;71;1;72;0
WireConnection;64;0;63;3
WireConnection;66;0;71;0
WireConnection;66;2;65;0
WireConnection;66;1;64;0
WireConnection;67;1;66;0
WireConnection;69;0;67;1
WireConnection;69;1;70;0
WireConnection;69;2;74;0
WireConnection;93;0;94;0
WireConnection;73;1;69;0
WireConnection;92;0;93;0
WireConnection;135;0;133;3
WireConnection;96;0;86;0
WireConnection;96;1;95;0
WireConnection;96;2;92;0
WireConnection;110;0;73;0
WireConnection;134;0;133;1
WireConnection;134;1;133;2
WireConnection;136;0;96;0
WireConnection;136;2;134;0
WireConnection;136;1;135;0
WireConnection;34;0;33;1
WireConnection;34;1;33;2
WireConnection;35;0;33;3
WireConnection;35;1;33;4
WireConnection;138;0;36;0
WireConnection;138;1;137;0
WireConnection;25;0;136;0
WireConnection;25;1;34;0
WireConnection;123;0;125;0
WireConnection;124;0;123;0
WireConnection;139;0;138;0
WireConnection;31;0;25;0
WireConnection;31;1;35;0
WireConnection;68;0;31;0
WireConnection;68;1;111;0
WireConnection;126;0;88;0
WireConnection;126;1;127;0
WireConnection;126;2;124;0
WireConnection;20;1;19;4
WireConnection;58;0;139;1
WireConnection;58;1;59;0
WireConnection;80;0;79;3
WireConnection;81;0;79;1
WireConnection;81;1;79;2
WireConnection;84;0;126;0
WireConnection;84;1;83;0
WireConnection;10;0;9;1
WireConnection;10;1;9;2
WireConnection;1;1;68;0
WireConnection;21;0;20;0
WireConnection;99;0;139;0
WireConnection;99;1;58;0
WireConnection;11;0;9;3
WireConnection;82;0;84;0
WireConnection;82;2;81;0
WireConnection;82;1;80;0
WireConnection;153;0;150;0
WireConnection;40;0;99;0
WireConnection;40;1;41;0
WireConnection;102;0;101;0
WireConnection;18;0;17;0
WireConnection;18;1;21;0
WireConnection;112;0;1;0
WireConnection;7;0;8;0
WireConnection;7;2;10;0
WireConnection;7;1;11;0
WireConnection;16;1;18;0
WireConnection;43;0;40;0
WireConnection;43;1;44;0
WireConnection;46;1;82;0
WireConnection;104;1;103;0
WireConnection;104;0;102;0
WireConnection;152;0;153;0
WireConnection;2;1;7;0
WireConnection;49;0;114;0
WireConnection;49;1;46;1
WireConnection;49;2;50;0
WireConnection;105;0;104;0
WireConnection;39;0;43;0
WireConnection;154;0;149;0
WireConnection;154;1;151;0
WireConnection;154;2;152;0
WireConnection;14;0;15;0
WireConnection;14;1;2;1
WireConnection;14;2;16;1
WireConnection;155;0;156;1
WireConnection;155;1;156;2
WireConnection;158;0;154;0
WireConnection;158;1;155;0
WireConnection;106;0;105;0
WireConnection;157;0;156;3
WireConnection;157;1;156;4
WireConnection;78;0;14;0
WireConnection;78;1;19;3
WireConnection;178;0;176;0
WireConnection;12;1;8;0
WireConnection;56;0;39;0
WireConnection;56;1;57;0
WireConnection;118;0;49;0
WireConnection;3;0;78;0
WireConnection;3;1;4;0
WireConnection;3;2;5;0
WireConnection;3;3;6;0
WireConnection;3;4;12;1
WireConnection;159;0;158;0
WireConnection;159;1;157;0
WireConnection;173;0;172;0
WireConnection;47;0;113;0
WireConnection;47;1;27;0
WireConnection;47;2;178;0
WireConnection;121;0;56;0
WireConnection;148;1;159;0
WireConnection;171;0;107;0
WireConnection;171;1;172;0
WireConnection;171;2;173;0
WireConnection;48;0;47;0
WireConnection;48;1;119;0
WireConnection;52;0;3;0
WireConnection;175;3;148;1
WireConnection;175;4;171;0
WireConnection;175;8;168;0
WireConnection;142;0;67;1
WireConnection;54;0;48;0
WireConnection;54;2;122;0
WireConnection;0;9;175;0
WireConnection;0;13;54;0
WireConnection;0;11;53;0
ASEEND*/
//CHKSM=B501185617AE4A69668EFD7138FBA92EAFD9D37F