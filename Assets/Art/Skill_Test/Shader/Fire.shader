// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Whl/Fx/Fire"
{
	Properties
	{
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("CullMode", Float) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)]_ZTestMode("ZTestMode", Float) = 8
		[HDR]_MainColor("MainColor", Color) = (1,1,1,1)
		[HDR]_SubColor("SubColor", Color) = (1,1,1,1)
		_SubColorRange("SubColorRange", Range( 0 , 1)) = 0.5
		[Toggle(_UV3_XCONTORLSUBCOLORRANGE_ON)] _UV3_XContorlSubColorRange("UV3_XContorlSubColorRange", Float) = 0
		_SubColorHardness("SubColorHardness", Range( 0 , 0.99)) = 0
		[Toggle(_UV2CONTROLOFFSET_ON)] _UV2ControlOffset("UV2ControlOffset", Float) = 0
		_MainTex("MainTex", 2D) = "white" {}
		_MainTexHardness("MainTexHardness", Range( 0 , 0.5)) = 0.5
		_MainTexPanner("MainTexPanner", Vector) = (0,0,1,0)
		_NoiseTex("NoiseTex", 2D) = "white" {}
		_NoiseTexPanner("NoiseTexPanner", Vector) = (0,0,1,0)
		_Noise2Tex("Noise2Tex", 2D) = "white" {}
		_NoiseTex2Panner("NoiseTex2Panner", Vector) = (0,0,1,0)
		[Toggle(_UV1_TCONTORLDIS_ON)] _UV1_TContorlDis("UV1_TContorlDis", Float) = 0
		_Dissolution("Dissolution", Range( 0 , 1)) = 0.15
		_Hardness("Hardness", Range( 0 , 0.99)) = 0
		_DisInvers("DisInvers", Range( 0 , 1)) = 0
		_ColorChange("ColorChange", Range( 0 , 1)) = 1
		[Header(VertexOffset)]_VertexOffsetTex("VertexOffsetTex", 2D) = "white" {}
		[Toggle(_VERTEXOFFSETON_ON)] _VertexOffsetOn("VertexOffsetOn", Float) = 0
		[Toggle(_UV1_WCONTORLVERTEXOFFSET_ON)] _UV1_WContorlVertexOffset("UV1_WContorlVertexOffset", Float) = 0
		_VertexOffsetMask("VertexOffsetMask", 2D) = "white" {}
		_VertexOffsetTexPanner("VertexOffsetTexPanner", Vector) = (0,0,1,0)
		_OffsetDir("OffsetDir", Vector) = (1,1,1,0)
		_VertexOffsetStr("VertexOffsetStr", Float) = 1
		[Header(SoftParticle)]_FadeRange("FadeRange", Float) = 1
		[Toggle(_SOFTPARTICLE_ON)] _SoftParticle("SoftParticle", Float) = 0
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord3( "", 2D ) = "white" {}
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
		
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _VERTEXOFFSETON_ON
		#pragma shader_feature_local _UV1_WCONTORLVERTEXOFFSET_ON
		#pragma shader_feature_local _UV2CONTROLOFFSET_ON
		#pragma shader_feature_local _UV1_TCONTORLDIS_ON
		#pragma shader_feature_local _SOFTPARTICLE_ON
		#pragma shader_feature_local _UV3_XCONTORLSUBCOLORRANGE_ON
		#pragma surface surf StandardCustomLighting keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 uv_texcoord;
			float4 uv2_texcoord2;
			float4 vertexColor : COLOR;
			float4 screenPos;
			float2 uv3_texcoord3;
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
		uniform float3 _OffsetDir;
		uniform sampler2D _VertexOffsetMask;
		uniform float4 _VertexOffsetMask_ST;
		uniform float _VertexOffsetStr;
		uniform sampler2D _NoiseTex;
		uniform float3 _NoiseTexPanner;
		uniform float4 _NoiseTex_ST;
		uniform sampler2D _Noise2Tex;
		uniform float3 _NoiseTex2Panner;
		uniform float4 _Noise2Tex_ST;
		uniform float _MainTexHardness;
		uniform sampler2D _MainTex;
		uniform float3 _MainTexPanner;
		uniform float4 _MainTex_ST;
		uniform float _DisInvers;
		uniform float _Dissolution;
		uniform float _Hardness;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _FadeRange;
		uniform float4 _MainColor;
		uniform float4 _SubColor;
		uniform float _SubColorRange;
		uniform float _SubColorHardness;
		uniform float _ColorChange;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 temp_cast_0 = (0.0).xxx;
			float mulTime82 = _Time.y * _VertexOffsetTexPanner.z;
			float2 appendResult83 = (float2(_VertexOffsetTexPanner.x , _VertexOffsetTexPanner.y));
			float4 uvs_VertexOffsetTex = v.texcoord;
			uvs_VertexOffsetTex.xy = v.texcoord.xy * _VertexOffsetTex_ST.xy + _VertexOffsetTex_ST.zw;
			float2 panner84 = ( mulTime82 * appendResult83 + uvs_VertexOffsetTex.xy);
			float temp_output_124_0 = (-1.0 + (tex2Dlod( _VertexOffsetTex, float4( panner84, 0, 0.0) ).r - 0.0) * (1.0 - -1.0) / (1.0 - 0.0));
			float3 appendResult130 = (float3(( temp_output_124_0 * _OffsetDir.x ) , ( temp_output_124_0 * _OffsetDir.y ) , ( temp_output_124_0 * _OffsetDir.z )));
			#ifdef _UV1_WCONTORLVERTEXOFFSET_ON
				float staticSwitch20 = v.texcoord.z;
			#else
				float staticSwitch20 = 1.0;
			#endif
			float UV1_W21 = staticSwitch20;
			float4 uvs_VertexOffsetMask = v.texcoord;
			uvs_VertexOffsetMask.xy = v.texcoord.xy * _VertexOffsetMask_ST.xy + _VertexOffsetMask_ST.zw;
			float3 ase_vertexNormal = v.normal.xyz;
			#ifdef _VERTEXOFFSETON_ON
				float3 staticSwitch94 = ( appendResult130 * ( UV1_W21 * tex2Dlod( _VertexOffsetMask, float4( uvs_VertexOffsetMask.xy, 0, 0.0) ).r * ( 0.1 * _VertexOffsetStr ) ) * ase_vertexNormal );
			#else
				float3 staticSwitch94 = temp_cast_0;
			#endif
			float3 VertexOffset95 = staticSwitch94;
			v.vertex.xyz += VertexOffset95;
			v.vertex.w = 1;
		}

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float mulTime5 = _Time.y * _NoiseTexPanner.z;
			float2 appendResult4 = (float2(_NoiseTexPanner.x , _NoiseTexPanner.y));
			float4 uvs_NoiseTex = i.uv_texcoord;
			uvs_NoiseTex.xy = i.uv_texcoord.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
			float2 panner7 = ( mulTime5 * appendResult4 + uvs_NoiseTex.xy);
			float mulTime47 = _Time.y * _NoiseTex2Panner.z;
			float2 appendResult48 = (float2(_NoiseTex2Panner.x , _NoiseTex2Panner.y));
			float4 uvs_Noise2Tex = i.uv_texcoord;
			uvs_Noise2Tex.xy = i.uv_texcoord.xy * _Noise2Tex_ST.xy + _Noise2Tex_ST.zw;
			float2 panner50 = ( mulTime47 * appendResult48 + uvs_Noise2Tex.xy);
			float blendOpSrc45 = tex2D( _NoiseTex, panner7 ).r;
			float blendOpDest45 = tex2D( _Noise2Tex, panner50 ).r;
			float mulTime32 = _Time.y * _MainTexPanner.z;
			float2 appendResult31 = (float2(_MainTexPanner.x , _MainTexPanner.y));
			float4 uvs_MainTex = i.uv_texcoord;
			uvs_MainTex.xy = i.uv_texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
			float2 panner34 = ( mulTime32 * appendResult31 + uvs_MainTex.xy);
			float UV2_W14 = i.uv2_texcoord2.z;
			float UV2_T13 = i.uv2_texcoord2.w;
			float2 appendResult28 = (float2(UV2_W14 , UV2_T13));
			#ifdef _UV2CONTROLOFFSET_ON
				float2 staticSwitch35 = ( uvs_MainTex.xy + appendResult28 );
			#else
				float2 staticSwitch35 = panner34;
			#endif
			float smoothstepResult42 = smoothstep( _MainTexHardness , ( 1.0 - _MainTexHardness ) , tex2D( _MainTex, staticSwitch35 ).r);
			float MainColor59 = smoothstepResult42;
			float NosieColor54 = ( ( saturate( ( 1.0 - ( 1.0 - blendOpSrc45 ) * ( 1.0 - blendOpDest45 ) ) )) * MainColor59 );
			float temp_output_3_0_g4 = NosieColor54;
			float lerpResult5_g4 = lerp( temp_output_3_0_g4 , ( 1.0 - temp_output_3_0_g4 ) , _DisInvers);
			#ifdef _UV1_TCONTORLDIS_ON
				float staticSwitch17 = i.uv_texcoord.w;
			#else
				float staticSwitch17 = _Dissolution;
			#endif
			float UV1_T18 = staticSwitch17;
			float temp_output_8_0_g4 = _Hardness;
			float VertexColorA109 = i.vertexColor.a;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth115 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth115 = abs( ( screenDepth115 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _FadeRange ) );
			#ifdef _SOFTPARTICLE_ON
				float staticSwitch116 = distanceDepth115;
			#else
				float staticSwitch116 = 1.0;
			#endif
			float SoftParticle118 = saturate( staticSwitch116 );
			float4 VertexColor74 = i.vertexColor;
			float temp_output_3_0_g3 = NosieColor54;
			float lerpResult5_g3 = lerp( temp_output_3_0_g3 , ( 1.0 - temp_output_3_0_g3 ) , 1.0);
			#ifdef _UV3_XCONTORLSUBCOLORRANGE_ON
				float staticSwitch100 = i.uv3_texcoord3.x;
			#else
				float staticSwitch100 = _SubColorRange;
			#endif
			float UV3_X102 = staticSwitch100;
			float temp_output_8_0_g3 = _SubColorHardness;
			float4 lerpResult78 = lerp( ( _MainColor * MainColor59 ) , ( _SubColor * MainColor59 ) , saturate( ( ( ( ( lerpResult5_g3 + 1.0 ) - ( ( 1.0 - (-0.5 + (UV3_X102 - 0.0) * (1.0 - -0.5) / (1.0 - 0.0)) ) * ( ( 1.0 - temp_output_8_0_g3 ) + 1.0 ) ) ) - temp_output_8_0_g3 ) / ( temp_output_8_0_g3 - 1.0 ) ) ));
			float4 lerpResult67 = lerp( ( _MainColor * VertexColor74 ) , ( lerpResult78 * VertexColor74 ) , _ColorChange);
			c.rgb = lerpResult67.rgb;
			c.a = saturate( ( saturate( ( ( ( ( lerpResult5_g4 + 1.0 ) - ( ( 1.0 - (-0.5 + (UV1_T18 - 0.0) * (1.0 - -0.5) / (1.0 - 0.0)) ) * ( ( 1.0 - temp_output_8_0_g4 ) + 1.0 ) ) ) - temp_output_8_0_g4 ) / ( temp_output_8_0_g4 - 1.0 ) ) ) * VertexColorA109 * SoftParticle118 ) );
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
-875;232;1527;877;1412.054;-2515.922;1.964794;False;True
Node;AmplifyShaderEditor.CommentaryNode;9;-3549.034,4150.698;Inherit;False;1143.907;365.912;Comment;3;14;13;12;UV2;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;12;-3520.004,4214.619;Inherit;False;1;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;14;-3051.496,4232.981;Inherit;False;UV2_W;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;13;-3052.96,4327.672;Inherit;False;UV2_T;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;65;-4055.734,2517.728;Inherit;False;2092.313;826.4783;MainColor;16;26;25;30;27;33;28;31;32;34;29;35;40;8;41;42;59;MainColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector3Node;30;-4005.734,2727.972;Inherit;False;Property;_MainTexPanner;MainTexPanner;11;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;26;-3961.396,3077.017;Inherit;False;14;UV2_W;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;25;-3958.666,3171.665;Inherit;False;13;UV2_T;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;28;-3727.122,3098.583;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;33;-3952.551,2567.728;Inherit;False;0;8;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;32;-3757.734,2834.972;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;27;-3819.227,2940.249;Inherit;False;0;8;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;31;-3754.734,2680.972;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;53;-4047.915,1027.914;Inherit;False;2064.748;1387.778;NosieColor;16;45;54;1;43;7;50;47;48;49;5;6;4;3;46;60;64;NosieColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;29;-3542.672,2968.942;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;34;-3573.055,2649.108;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;35;-3398.66,2765.489;Inherit;False;Property;_UV2ControlOffset;UV2ControlOffset;8;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector3Node;46;-3964.558,1947.113;Inherit;False;Property;_NoiseTex2Panner;NoiseTex2Panner;15;0;Create;True;0;0;0;False;0;False;0,0,1;-3,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;3;-3943.152,1551.712;Inherit;False;Property;_NoiseTexPanner;NoiseTexPanner;13;0;Create;True;0;0;0;False;0;False;0,0,1;-2.5,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;40;-3161.52,3072.62;Inherit;False;Property;_MainTexHardness;MainTexHardness;10;0;Create;True;0;0;0;False;0;False;0.5;0;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;79;-1915.678,2622.326;Inherit;False;3274.872;1450.182;VertexOffset;24;92;87;130;132;125;128;131;124;86;90;89;127;91;88;85;95;94;93;133;84;82;83;81;80;VertexOffset;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleTimeNode;47;-3716.56,2054.113;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;41;-2876.779,3233.206;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;48;-3713.56,1900.113;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;8;-3037.166,2742.124;Inherit;True;Property;_MainTex;MainTex;9;0;Create;True;0;0;0;False;0;False;-1;None;f31a4d7e5b965f54a8cfac4ce3b465a3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;49;-3911.375,1786.869;Inherit;False;0;43;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;6;-3889.969,1391.468;Inherit;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;80;-1865.678,2837.71;Inherit;False;Property;_VertexOffsetTexPanner;VertexOffsetTexPanner;25;0;Create;True;0;0;0;False;0;False;0,0,1;-2,1,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleTimeNode;5;-3695.154,1658.712;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;4;-3692.154,1504.712;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;81;-1681.785,2672.326;Inherit;False;0;86;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;83;-1511.783,2840.326;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;82;-1545.784,2934.326;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;10;-3545.714,3583.767;Inherit;False;1252.226;378.732;Comment;7;21;20;19;18;17;16;15;UV1;1,1,1,1;0;0
Node;AmplifyShaderEditor.SmoothstepOpNode;42;-2530.775,2882.97;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;50;-3531.88,1868.25;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;7;-3510.474,1472.849;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;112;-1840.955,4228.021;Inherit;False;1080.439;324.1655;SoftParticle;6;118;117;116;115;114;113;SoftParticle;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;1;-3280.311,1444.152;Inherit;True;Property;_NoiseTex;NoiseTex;12;0;Create;True;0;0;0;False;0;False;-1;523107cb5d9dce94f8de804bd35aa029;4aca1df6d2aea3e4bac0aa50ecba1fbe;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;43;-3266.605,1772.34;Inherit;True;Property;_Noise2Tex;Noise2Tex;14;0;Create;True;0;0;0;False;0;False;-1;523107cb5d9dce94f8de804bd35aa029;914a5439765647d4c8d2458461ff477a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;84;-1297.782,2834.326;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;97;-3512.315,4707.731;Inherit;False;1124.562;519.4683;Comment;4;102;100;98;104;UV3;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-3232.196,3633.767;Inherit;False;Constant;_Float0;Float 0;7;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;59;-2226.065,2877.294;Inherit;False;MainColor;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;16;-3518.714,3632.499;Inherit;True;0;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;86;-1095.379,2803.188;Inherit;True;Property;_VertexOffsetTex;VertexOffsetTex;21;1;[Header];Create;True;1;VertexOffset;0;0;False;0;False;-1;None;b111d5f279d12c64c844b5cc4f357c2a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;113;-1779.616,4416;Inherit;False;Property;_FadeRange;FadeRange;28;1;[Header];Create;True;1;SoftParticle;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;20;-2936.887,3641.557;Inherit;False;Property;_UV1_WContorlVertexOffset;UV1_WContorlVertexOffset;23;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;45;-2855.49,1604.74;Inherit;True;Screen;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;60;-2791.377,1852.476;Inherit;False;59;MainColor;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;98;-3445.798,4883.058;Inherit;False;2;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;104;-3463.551,4774.788;Inherit;False;Property;_SubColorRange;SubColorRange;5;0;Create;True;0;0;0;False;0;False;0.5;0.761;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;21;-2569.34,3643.903;Inherit;False;UV1_W;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;85;-1237.674,3501.675;Inherit;False;0;91;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;89;-956.6981,3700.202;Inherit;False;Constant;_Float7;Float 7;25;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;115;-1600.091,4396.186;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;64;-2558.106,1649.055;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;114;-1571.004,4300.702;Inherit;False;Constant;_Float3;Float 3;14;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;128;-607.903,3081.318;Inherit;True;Property;_OffsetDir;OffsetDir;26;0;Create;True;0;0;0;False;0;False;1,1,1;1,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TFHCRemapNode;124;-776.5477,2836.555;Inherit;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-1;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;100;-3145.85,4797.037;Inherit;False;Property;_UV3_XContorlSubColorRange;UV3_XContorlSubColorRange;6;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;90;-980.5914,3792.523;Inherit;False;Property;_VertexOffsetStr;VertexOffsetStr;27;0;Create;True;0;0;0;False;0;False;1;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-3285.15,3869.75;Inherit;False;Property;_Dissolution;Dissolution;17;0;Create;True;0;0;0;False;0;False;0.15;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;131;-276.9305,2881.906;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;116;-1336.357,4307.947;Inherit;False;Property;_SoftParticle;SoftParticle;29;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;54;-2257.721,1643.597;Inherit;True;NosieColor;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;102;-2754.677,4799.402;Inherit;False;UV3_X;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;17;-2949.125,3805.403;Inherit;False;Property;_UV1_TContorlDis;UV1_TContorlDis;16;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;132;-281.6769,3029.083;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;92;-752.233,3719.661;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;88;-782.3192,3379.02;Inherit;False;21;UV1_W;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;91;-949.2614,3480.01;Inherit;True;Property;_VertexOffsetMask;VertexOffsetMask;24;0;Create;True;0;0;0;False;0;False;-1;None;c52f18f9a3ad49379bb0d8a16d3e8cd8;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;133;-285.5629,3181.852;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;127;-206.9716,3455.701;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;72;-1937.049,-1051.602;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;77;-1038.638,-986.3694;Inherit;False;Property;_SubColor;SubColor;4;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;0,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;121;-1005.135,-789.3836;Inherit;False;59;MainColor;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;69;-1190.733,-731.7783;Inherit;False;54;NosieColor;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;68;-1035.507,-1192.308;Inherit;False;Property;_MainColor;MainColor;3;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;4.419672,1.408566,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;130;-16.17239,2936.497;Inherit;True;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;106;-1299.1,-647.129;Inherit;False;Constant;_Float1;Float 1;29;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;18;-2572.883,3802.192;Inherit;False;UV1_T;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;105;-1276.6,-411.929;Inherit;False;Property;_SubColorHardness;SubColorHardness;7;0;Create;True;0;0;0;False;0;False;0;0.792;0;0.99;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;120;-1243.171,-552.284;Inherit;False;102;UV3_X;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;117;-1104.403,4329.769;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;87;20.06892,3456.606;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;37;-816.8383,-45.31952;Inherit;False;Property;_Hardness;Hardness;18;0;Create;True;0;0;0;False;0;False;0;0.729;0;0.99;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;118;-973.6229,4312.557;Inherit;False;SoftParticle;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;52;-751.621,-238.9276;Inherit;False;Property;_DisInvers;DisInvers;19;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;55;-709.998,-336.6267;Inherit;False;54;NosieColor;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;93;291.7325,2888.823;Inherit;False;Constant;_Float2;Float 2;27;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;125;340.1389,3005.541;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;74;-1647.02,-1059.678;Inherit;False;VertexColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;57;-744.347,-138.0442;Inherit;False;18;UV1_T;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;122;-788.0918,-887.2008;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;109;-1617.471,-922.8843;Inherit;False;VertexColorA;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;103;-926.5529,-642.3422;Inherit;True;Dissolution;-1;;3;8ed0a8fdbfe80554382ce257577aff19;0;4;3;FLOAT;0;False;7;FLOAT;0;False;4;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;123;-777.7996,-1041.561;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;63;-380.0583,-304.6715;Inherit;True;Dissolution;-1;;4;8ed0a8fdbfe80554382ce257577aff19;0;4;3;FLOAT;0;False;7;FLOAT;0;False;4;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;94;509.275,2916.833;Inherit;True;Property;_VertexOffsetOn;VertexOffsetOn;22;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;119;-281.5833,102.9918;Inherit;False;118;SoftParticle;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;78;-595.8901,-843.1027;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;76;-563.7713,-678.4067;Inherit;False;74;VertexColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;108;-279.3604,-50.44938;Inherit;False;109;VertexColorA;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;75;-507.4176,-983.6727;Inherit;False;74;VertexColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;70;-478.5073,-486.7084;Inherit;False;Property;_ColorChange;ColorChange;20;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;95;780.2545,2914.895;Inherit;False;VertexOffset;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;71;-280.4861,-836.7051;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;73;-220.4191,-1043.827;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;11;-4156.865,3513.119;Inherit;False;448;277.753;Comment;2;23;22;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;110;-3.593848,-281.9124;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;111;223.3195,-354.0787;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-4103.385,3563.118;Inherit;False;Property;_CullMode;CullMode;1;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;96;-81.89458,-480.5425;Inherit;False;95;VertexOffset;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-4106.865,3660.872;Inherit;False;Property;_ZTestMode;ZTestMode;2;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CompareFunction;True;0;False;8;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;67;31.0634,-864.1265;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;403.6867,-729.6188;Float;False;True;-1;2;ASEMaterialInspector;0;0;CustomLighting;Whl/Fx/Fire;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;True;22;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;True;23;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;14;0;12;3
WireConnection;13;0;12;4
WireConnection;28;0;26;0
WireConnection;28;1;25;0
WireConnection;32;0;30;3
WireConnection;31;0;30;1
WireConnection;31;1;30;2
WireConnection;29;0;27;0
WireConnection;29;1;28;0
WireConnection;34;0;33;0
WireConnection;34;2;31;0
WireConnection;34;1;32;0
WireConnection;35;1;34;0
WireConnection;35;0;29;0
WireConnection;47;0;46;3
WireConnection;41;0;40;0
WireConnection;48;0;46;1
WireConnection;48;1;46;2
WireConnection;8;1;35;0
WireConnection;5;0;3;3
WireConnection;4;0;3;1
WireConnection;4;1;3;2
WireConnection;83;0;80;1
WireConnection;83;1;80;2
WireConnection;82;0;80;3
WireConnection;42;0;8;1
WireConnection;42;1;40;0
WireConnection;42;2;41;0
WireConnection;50;0;49;0
WireConnection;50;2;48;0
WireConnection;50;1;47;0
WireConnection;7;0;6;0
WireConnection;7;2;4;0
WireConnection;7;1;5;0
WireConnection;1;1;7;0
WireConnection;43;1;50;0
WireConnection;84;0;81;0
WireConnection;84;2;83;0
WireConnection;84;1;82;0
WireConnection;59;0;42;0
WireConnection;86;1;84;0
WireConnection;20;1;19;0
WireConnection;20;0;16;3
WireConnection;45;0;1;1
WireConnection;45;1;43;1
WireConnection;21;0;20;0
WireConnection;115;0;113;0
WireConnection;64;0;45;0
WireConnection;64;1;60;0
WireConnection;124;0;86;1
WireConnection;100;1;104;0
WireConnection;100;0;98;1
WireConnection;131;0;124;0
WireConnection;131;1;128;1
WireConnection;116;1;114;0
WireConnection;116;0;115;0
WireConnection;54;0;64;0
WireConnection;102;0;100;0
WireConnection;17;1;15;0
WireConnection;17;0;16;4
WireConnection;132;0;124;0
WireConnection;132;1;128;2
WireConnection;92;0;89;0
WireConnection;92;1;90;0
WireConnection;91;1;85;0
WireConnection;133;0;124;0
WireConnection;133;1;128;3
WireConnection;127;0;88;0
WireConnection;127;1;91;1
WireConnection;127;2;92;0
WireConnection;130;0;131;0
WireConnection;130;1;132;0
WireConnection;130;2;133;0
WireConnection;18;0;17;0
WireConnection;117;0;116;0
WireConnection;118;0;117;0
WireConnection;125;0;130;0
WireConnection;125;1;127;0
WireConnection;125;2;87;0
WireConnection;74;0;72;0
WireConnection;122;0;77;0
WireConnection;122;1;121;0
WireConnection;109;0;72;4
WireConnection;103;3;69;0
WireConnection;103;7;106;0
WireConnection;103;4;120;0
WireConnection;103;8;105;0
WireConnection;123;0;68;0
WireConnection;123;1;121;0
WireConnection;63;3;55;0
WireConnection;63;7;52;0
WireConnection;63;4;57;0
WireConnection;63;8;37;0
WireConnection;94;1;93;0
WireConnection;94;0;125;0
WireConnection;78;0;123;0
WireConnection;78;1;122;0
WireConnection;78;2;103;0
WireConnection;95;0;94;0
WireConnection;71;0;78;0
WireConnection;71;1;76;0
WireConnection;73;0;68;0
WireConnection;73;1;75;0
WireConnection;110;0;63;0
WireConnection;110;1;108;0
WireConnection;110;2;119;0
WireConnection;111;0;110;0
WireConnection;67;0;73;0
WireConnection;67;1;71;0
WireConnection;67;2;70;0
WireConnection;0;9;111;0
WireConnection;0;13;67;0
WireConnection;0;11;96;0
ASEEND*/
//CHKSM=0884B6A95C5E87E38B086192465F731F73EB0649