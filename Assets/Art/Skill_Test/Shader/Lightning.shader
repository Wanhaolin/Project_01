// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Whl/Fx/Lightning"
{
	Properties
	{
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("CullMode", Float) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)]_ZTestMode("ZTestMode", Float) = 8
		[Enum(Off,0,On,1)]_ZWriteMode("ZWriteMode", Float) = 8
		[HDR][Header(Main)]_MainColor("MainColor", Color) = (0,0,0,0)
		[Toggle(_UV2CONTROLOFFSET_ON)] _UV2ControlOffset("UV2ControlOffset", Float) = 0
		_MainTex("MainTex", 2D) = "white" {}
		_ColorScale("ColorScale", Float) = 1
		_Rotater("Rotater", Range( 0 , 360)) = 0
		[Toggle(_RISALPHA_ON)] _RIsAlpha("RIsAlpha", Float) = 0
		_MainTexPanner("MainTexPanner", Vector) = (0,0,1,0)
		_RampTex("RampTex", 2D) = "white" {}
		[Toggle(_DISTURBRAMP_ON)] _DisturbRamp("DisturbRamp", Float) = 0
		_RampDisStr("RampDisStr", Float) = 0
		[Header(VertexOffset)]_VertexOffsetTex("VertexOffsetTex", 2D) = "white" {}
		[Toggle(_VERTEXOFFSETON_ON)] _VertexOffsetOn("VertexOffsetOn", Float) = 0
		[Toggle(_UV1_WCONTORLVERTEXOFFSET_ON)] _UV1_WContorlVertexOffset("UV1_WContorlVertexOffset", Float) = 0
		_VertexOffsetMask("VertexOffsetMask", 2D) = "white" {}
		_VertexOffsetTexPanner("VertexOffsetTexPanner", Vector) = (0,0,1,0)
		_OffsetDir("OffsetDir", Vector) = (1,1,1,0)
		_Offset_1("Offset_1", Vector) = (0,0.1,0,0)
		_Offset_2("Offset_2", Vector) = (0,0.05,0,0)
		_VertexOffsetStr("VertexOffsetStr", Float) = 1
		[Header(Dissolution)]_DissolutionTex("DissolutionTex", 2D) = "white" {}
		[Toggle(_DISSOLUTIONON_ON)] _DissolutionOn("DissolutionOn", Float) = 0
		[Toggle(_UV1_TCONTORLDIS_ON)] _UV1_TContorlDis("UV1_TContorlDis", Float) = 0
		_DissolutionTexPanner("DissolutionTexPanner", Vector) = (0,0,1,0)
		_Dissolution("Dissolution", Range( 0 , 1)) = 0.15
		_DissoluInvers("DissoluInvers", Range( 0 , 1)) = 0
		_DissolutionHardness("DissolutionHardness", Range( 0 , 0.999)) = 0.3935294
		[Header(Disturb)]_DisturbTex("DisturbTex", 2D) = "white" {}
		[Toggle(_DISTURBON_ON)] _DisturbOn("DisturbOn", Float) = 0
		[Toggle(_UV3_XCONTORLDISTURB_ON)] _UV3_XContorlDisturb("UV3_XContorlDisturb", Float) = 0
		_DisturbPanner("DisturbPanner", Vector) = (0,0,1,0)
		_DisturbDir("DisturbDir", Vector) = (1,1,0,0)
		_DisturbStr("DisturbStr", Float) = 0
		[Header(SoftParticle)]_FadeRange("FadeRange", Float) = 1
		[Toggle(_SOFTPARTICLE_ON)] _SoftParticle("SoftParticle", Float) = 0
		[HideInInspector] _texcoord3( "", 2D ) = "white" {}
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" }
		Cull [_CullMode]
		ZWrite [_ZWriteMode]
		ZTest [_ZTestMode]
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#pragma target 4.6
		#pragma shader_feature_local _VERTEXOFFSETON_ON
		#pragma shader_feature_local _UV1_WCONTORLVERTEXOFFSET_ON
		#pragma shader_feature_local _DISSOLUTIONON_ON
		#pragma shader_feature_local _UV2CONTROLOFFSET_ON
		#pragma shader_feature_local _DISTURBON_ON
		#pragma shader_feature_local _UV3_XCONTORLDISTURB_ON
		#pragma shader_feature_local _UV1_TCONTORLDIS_ON
		#pragma shader_feature_local _RISALPHA_ON
		#pragma shader_feature_local _SOFTPARTICLE_ON
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

		uniform float _ZWriteMode;
		uniform float _CullMode;
		uniform float _ZTestMode;
		uniform sampler2D _VertexOffsetTex;
		uniform float3 _VertexOffsetTexPanner;
		uniform float4 _VertexOffsetTex_ST;
		uniform float2 _Offset_1;
		uniform float2 _Offset_2;
		uniform float3 _OffsetDir;
		uniform sampler2D _VertexOffsetMask;
		uniform float4 _VertexOffsetMask_ST;
		uniform float _VertexOffsetStr;
		uniform sampler2D _MainTex;
		uniform float3 _MainTexPanner;
		uniform float4 _MainTex_ST;
		uniform float _Rotater;
		uniform sampler2D _DisturbTex;
		uniform float3 _DisturbPanner;
		uniform float4 _DisturbTex_ST;
		uniform float _DisturbStr;
		uniform float2 _DisturbDir;
		uniform sampler2D _DissolutionTex;
		uniform float3 _DissolutionTexPanner;
		uniform float4 _DissolutionTex_ST;
		uniform float _DissoluInvers;
		uniform float _Dissolution;
		uniform float _DissolutionHardness;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _FadeRange;
		uniform float _ColorScale;
		uniform float4 _MainColor;
		uniform sampler2D _RampTex;
		uniform float _RampDisStr;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 temp_cast_0 = (0.0).xxx;
			float mulTime49 = _Time.y * _VertexOffsetTexPanner.z;
			float2 appendResult48 = (float2(_VertexOffsetTexPanner.x , _VertexOffsetTexPanner.y));
			float4 uvs_VertexOffsetTex = v.texcoord;
			uvs_VertexOffsetTex.xy = v.texcoord.xy * _VertexOffsetTex_ST.xy + _VertexOffsetTex_ST.zw;
			float2 panner50 = ( mulTime49 * appendResult48 + uvs_VertexOffsetTex.xy);
			float UV2_W8 = v.texcoord1.z;
			float2 appendResult181 = (float2(0.0 , UV2_W8));
			float UV2_T9 = v.texcoord1.w;
			float2 appendResult182 = (float2(0.0 , UV2_T9));
			float3 appendResult64 = (float3((tex2Dlod( _VertexOffsetTex, float4( panner50, 0, 0.0) ).r*2.0 + -0.5) , (tex2Dlod( _VertexOffsetTex, float4( ( ( panner50 + _Offset_1 ) * appendResult181 ), 0, 0.0) ).r*2.0 + -0.5) , (tex2Dlod( _VertexOffsetTex, float4( ( ( panner50 + _Offset_2 ) * appendResult182 ), 0, 0.0) ).r*2.0 + -0.5)));
			#ifdef _UV1_WCONTORLVERTEXOFFSET_ON
				float staticSwitch16 = v.texcoord.z;
			#else
				float staticSwitch16 = 1.0;
			#endif
			float UV1_W17 = staticSwitch16;
			float4 uvs_VertexOffsetMask = v.texcoord;
			uvs_VertexOffsetMask.xy = v.texcoord.xy * _VertexOffsetMask_ST.xy + _VertexOffsetMask_ST.zw;
			#ifdef _VERTEXOFFSETON_ON
				float3 staticSwitch68 = ( ( appendResult64 * _OffsetDir ) * ( UV1_W17 * tex2Dlod( _VertexOffsetMask, float4( uvs_VertexOffsetMask.xy, 0, 0.0) ).r * ( 0.1 * _VertexOffsetStr ) ) );
			#else
				float3 staticSwitch68 = temp_cast_0;
			#endif
			float3 VertexOffset69 = staticSwitch68;
			v.vertex.xyz += VertexOffset69;
			v.vertex.w = 1;
		}

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float mulTime30 = _Time.y * _MainTexPanner.z;
			float2 appendResult28 = (float2(_MainTexPanner.x , _MainTexPanner.y));
			float4 uvs_MainTex = i.uv_texcoord;
			uvs_MainTex.xy = i.uv_texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
			float2 panner32 = ( mulTime30 * appendResult28 + uvs_MainTex.xy);
			float UV2_W8 = i.uv2_texcoord2.z;
			float UV2_T9 = i.uv2_texcoord2.w;
			float2 appendResult25 = (float2(UV2_W8 , UV2_T9));
			#ifdef _UV2CONTROLOFFSET_ON
				float2 staticSwitch34 = ( uvs_MainTex.xy + appendResult25 );
			#else
				float2 staticSwitch34 = panner32;
			#endif
			float2 temp_cast_0 = (0.5).xx;
			float cos37 = cos( ( (0.0 + (_Rotater - 0.0) * (2.0 - 0.0) / (360.0 - 0.0)) * UNITY_PI ) );
			float sin37 = sin( ( (0.0 + (_Rotater - 0.0) * (2.0 - 0.0) / (360.0 - 0.0)) * UNITY_PI ) );
			float2 rotator37 = mul( staticSwitch34 - temp_cast_0 , float2x2( cos37 , -sin37 , sin37 , cos37 )) + temp_cast_0;
			float2 temp_cast_1 = (0.0).xx;
			float mulTime82 = _Time.y * _DisturbPanner.z;
			float2 appendResult84 = (float2(_DisturbPanner.x , _DisturbPanner.y));
			float4 uvs_DisturbTex = i.uv_texcoord;
			uvs_DisturbTex.xy = i.uv_texcoord.xy * _DisturbTex_ST.xy + _DisturbTex_ST.zw;
			float UV3_Y186 = i.uv3_texcoord3.y;
			float2 panner85 = ( mulTime82 * appendResult84 + ( uvs_DisturbTex.xy + UV3_Y186 ));
			#ifdef _UV3_XCONTORLDISTURB_ON
				float staticSwitch4 = i.uv3_texcoord3.x;
			#else
				float staticSwitch4 = 1.0;
			#endif
			float UV3_X6 = staticSwitch4;
			#ifdef _DISTURBON_ON
				float2 staticSwitch93 = ( ( tex2D( _DisturbTex, panner85 ).r * _DisturbStr * UV3_X6 ) * _DisturbDir );
			#else
				float2 staticSwitch93 = temp_cast_1;
			#endif
			float2 DisturbColor94 = staticSwitch93;
			float2 temp_output_95_0 = ( rotator37 + DisturbColor94 );
			float4 tex2DNode39 = tex2D( _MainTex, temp_output_95_0 );
			float MainTexAlpha118 = ( tex2DNode39.r * tex2DNode39.a );
			float mulTime78 = _Time.y * _DissolutionTexPanner.z;
			float2 appendResult73 = (float2(_DissolutionTexPanner.x , _DissolutionTexPanner.y));
			float4 uvs_DissolutionTex = i.uv_texcoord;
			uvs_DissolutionTex.xy = i.uv_texcoord.xy * _DissolutionTex_ST.xy + _DissolutionTex_ST.zw;
			float2 panner75 = ( mulTime78 * appendResult73 + uvs_DissolutionTex.xy);
			float temp_output_3_0_g1 = tex2D( _DissolutionTex, ( DisturbColor94 + panner75 ) ).r;
			float lerpResult5_g1 = lerp( temp_output_3_0_g1 , ( 1.0 - temp_output_3_0_g1 ) , _DissoluInvers);
			#ifdef _UV1_TCONTORLDIS_ON
				float staticSwitch13 = i.uv_texcoord.w;
			#else
				float staticSwitch13 = _Dissolution;
			#endif
			float UV1_T14 = staticSwitch13;
			float temp_output_8_0_g1 = _DissolutionHardness;
			#ifdef _RISALPHA_ON
				float staticSwitch117 = tex2DNode39.r;
			#else
				float staticSwitch117 = (tex2DNode39).a;
			#endif
			float MainTexA171 = staticSwitch117;
			#ifdef _DISSOLUTIONON_ON
				float staticSwitch113 = ( saturate( ( ( ( ( lerpResult5_g1 + 1.0 ) - ( ( 1.0 - (-0.5 + (UV1_T14 - 0.0) * (1.0 - -0.5) / (1.0 - 0.0)) ) * ( ( 1.0 - temp_output_8_0_g1 ) + 1.0 ) ) ) - temp_output_8_0_g1 ) / ( temp_output_8_0_g1 - 1.0 ) ) ) * MainTexA171 );
			#else
				float staticSwitch113 = MainTexAlpha118;
			#endif
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth103 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth103 = abs( ( screenDepth103 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _FadeRange ) );
			#ifdef _SOFTPARTICLE_ON
				float staticSwitch105 = distanceDepth103;
			#else
				float staticSwitch105 = 1.0;
			#endif
			float SoftParticle107 = saturate( staticSwitch105 );
			float VertexColorA99 = i.vertexColor.a;
			float FinalOpacity112 = ( ( staticSwitch113 * SoftParticle107 * VertexColorA99 ) * _ColorScale );
			float3 MainTexColor120 = (tex2DNode39).rgb;
			#ifdef _DISTURBRAMP_ON
				float2 staticSwitch127 = ( i.uv_texcoord.xy + ( DisturbColor94 * _RampDisStr ) );
			#else
				float2 staticSwitch127 = i.uv_texcoord.xy;
			#endif
			float4 MainColor131 = ( float4( MainTexColor120 , 0.0 ) * tex2D( _RampTex, staticSwitch127 ) );
			float4 VertexColorRGB100 = i.vertexColor;
			c.rgb = ( _MainColor * MainColor131 * VertexColorRGB100 ).rgb;
			c.a = FinalOpacity112;
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
260;738;1632;1043;2838.293;-1614.613;1;True;True
Node;AmplifyShaderEditor.CommentaryNode;1;-1168.477,592.8947;Inherit;False;1124.562;519.4683;Comment;5;6;4;3;2;186;UV3;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-1101.96,768.2218;Inherit;False;2;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;80;2261.759,110.9449;Inherit;False;1883.194;986.6012;DisturbColor;16;94;93;92;91;90;89;88;87;86;85;84;83;82;81;187;188;DisturbColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;186;-770.5056,822.4932;Inherit;False;UV3_Y;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;83;2336.166,181.0352;Inherit;False;0;86;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;188;2364.788,326.3347;Inherit;False;186;UV3_Y;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-1064.012,653.2003;Inherit;False;Constant;_Float12;Float 12;28;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;81;2365.983,414.2783;Inherit;False;Property;_DisturbPanner;DisturbPanner;33;0;Create;True;0;0;0;False;0;False;0,0,1;0.1,0.2,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleTimeNode;82;2613.982,521.2783;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;187;2617.788,195.3347;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;84;2616.982,367.2783;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;5;-1178.97,7.123303;Inherit;False;1143.907;365.912;Comment;3;9;8;7;UV2;1,1,1,1;0;0
Node;AmplifyShaderEditor.StaticSwitch;4;-802.0125,682.2003;Inherit;False;Property;_UV3_XContorlDisturb;UV3_XContorlDisturb;32;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;6;-472.8394,688.5657;Inherit;False;UV3_X;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;7;-1149.94,71.04432;Inherit;False;1;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;85;2798.663,335.4163;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;87;3128.022,529.2565;Inherit;False;Property;_DisturbStr;DisturbStr;35;0;Create;True;0;0;0;False;0;False;0;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;88;3117.932,652.9449;Inherit;False;6;UV3_X;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;86;3037.798,323.5701;Inherit;True;Property;_DisturbTex;DisturbTex;30;1;[Header];Create;True;1;Disturb;0;0;False;0;False;-1;None;9cc7a8b6de1161a4cbab22df0bf8ecf4;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;8;-801.9844,114.1582;Inherit;False;UV2_W;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;42;-2557.249,1658.544;Inherit;False;2818.091;1014.558;MainColor;32;26;32;28;30;40;118;120;171;115;119;117;174;116;39;95;96;37;36;34;35;33;31;27;25;29;23;22;24;191;192;193;194;MainColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;9;-803.4185,197.4489;Inherit;False;UV2_T;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;22;-2448.139,2436.927;Inherit;False;9;UV2_T;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;24;-2562.229,1856.23;Inherit;False;Property;_MainTexPanner;MainTexPanner;10;0;Create;True;0;0;0;False;0;False;0,0,1;0,-0.2,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;23;-2450.868,2342.279;Inherit;False;8;UV2_W;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;90;3370.396,505.8226;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;89;3343.03,689.9744;Inherit;False;Property;_DisturbDir;DisturbDir;34;0;Create;True;0;0;0;False;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;27;-2308.658,2203.953;Inherit;False;0;39;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;91;3528.449,509.918;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;92;3414.994,272.5452;Inherit;False;Constant;_0;0;32;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;25;-2216.595,2363.844;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;28;-2268.23,1861.23;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;30;-2276.23,1968.231;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;26;-2539.067,1685.544;Inherit;False;0;39;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;29;-1872.757,2211.906;Inherit;False;Property;_Rotater;Rotater;8;0;Create;True;0;0;0;False;0;False;0;0;0;360;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;31;-2032.145,2234.204;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;33;-1599.986,2217.627;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;360;False;3;FLOAT;0;False;4;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;93;3678.452,363.882;Inherit;False;Property;_DisturbOn;DisturbOn;31;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;32;-2106.774,1844.846;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;45;1065.156,2894.221;Inherit;False;3519.303;2214.157;VertexOffset;36;50;49;48;46;47;143;54;140;51;69;68;66;67;64;63;65;60;59;61;52;53;56;148;149;165;166;167;168;169;170;179;180;181;182;184;185;VertexOffset;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;94;3921.127,370.7291;Inherit;False;DisturbColor;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-1565.722,2116.61;Inherit;False;Constant;_Float11;Float 11;26;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PiNode;35;-1423.695,2217.621;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;34;-1803.133,2029.75;Inherit;False;Property;_UV2ControlOffset;UV2ControlOffset;5;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector3Node;46;1125.583,3118.001;Inherit;False;Property;_VertexOffsetTexPanner;VertexOffsetTexPanner;18;0;Create;True;0;0;0;False;0;False;0,0,1;0.1,-0.05,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;79;387.945,1447.665;Inherit;False;3023.793;1030.786;Dissolution;22;78;77;76;75;74;73;72;71;108;109;110;111;112;113;114;136;137;138;172;173;189;190;Dissolution;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;96;-1250.192,2232.583;Inherit;False;94;DisturbColor;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RotatorNode;37;-1252.184,2066.303;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;48;1437.672,3112.256;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;10;-1183.364,-536.1884;Inherit;False;1252.226;378.732;Comment;7;17;16;15;14;13;12;11;UV1;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;95;-1054.805,2087.542;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;47;1142.795,2962.431;Inherit;False;0;51;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;49;1405.344,3229.668;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;71;523.6,1904.634;Inherit;False;Property;_DissolutionTexPanner;DissolutionTexPanner;26;0;Create;True;0;0;0;False;0;False;0,0,1;0.5,-0.35,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.PannerNode;50;1594.403,3087.215;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;39;-909.2775,2038.354;Inherit;True;Property;_MainTex;MainTex;6;0;Create;True;0;0;0;False;0;False;-1;None;b3c1313334f7ca04ebdbd307020d412d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;12;-1133.364,-459.4564;Inherit;True;0;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;169;1396.293,3320.356;Inherit;False;Property;_Offset_1;Offset_1;20;0;Create;True;0;0;0;False;0;False;0,0.1;0,0.1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;180;1271.234,3758.819;Inherit;False;9;UV2_T;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;170;1404.954,3587.208;Inherit;False;Property;_Offset_2;Offset_2;21;0;Create;True;0;0;0;False;0;False;0,0.05;0,0.1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;179;1261.082,3491.467;Inherit;False;8;UV2_W;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-922.7993,-242.4004;Inherit;False;Property;_Dissolution;Dissolution;27;0;Create;True;0;0;0;False;0;False;0.15;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;73;820.6002,1865.634;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;101;4625.016,1368.489;Inherit;False;1080.439;324.1655;SoftParticle;6;107;106;105;104;103;102;SoftParticle;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;72;621.782,1753.391;Inherit;False;0;77;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;78;817.6002,2019.634;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;182;1475.534,3740.229;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ComponentMaskNode;116;-522.8215,2211.861;Inherit;False;False;False;False;True;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;13;-586.7751,-314.5524;Inherit;False;Property;_UV1_TContorlDis;UV1_TContorlDis;25;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;75;993.1782,1771.372;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;102;4686.355,1556.468;Inherit;False;Property;_FadeRange;FadeRange;36;1;[Header];Create;True;1;SoftParticle;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;181;1496.735,3459.813;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;149;1757.968,3567.127;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;74;918.6901,1619.172;Inherit;False;94;DisturbColor;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;121;-2551.825,2893.289;Inherit;False;2227.146;782.8557;MainColor;10;131;130;129;128;127;126;125;124;123;122;MainColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;148;1735.765,3333.612;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;174;-567.3885,2278.604;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;117;-284.4009,2229.833;Inherit;False;Property;_RIsAlpha;RIsAlpha;9;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;104;4894.967,1441.169;Inherit;False;Constant;_Float1;Float 1;14;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;123;-2449.571,3548.544;Inherit;False;Property;_RampDisStr;RampDisStr;13;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;122;-2417.194,3456.397;Inherit;False;94;DisturbColor;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;76;1225.69,1714.172;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;184;1886.065,3633.713;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-869.8462,-486.1884;Inherit;False;Constant;_Float0;Float 0;7;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;14;-210.5332,-317.7634;Inherit;False;UV1_T;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;103;4865.88,1536.654;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;185;1872.36,3365.107;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;16;-574.5371,-478.3984;Inherit;False;Property;_UV1_WContorlVertexOffset;UV1_WContorlVertexOffset;16;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;171;-16.12266,2228.788;Inherit;False;MainTexA;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;111;1587.79,2066.245;Inherit;False;Property;_DissolutionHardness;DissolutionHardness;29;0;Create;True;0;0;0;False;0;False;0.3935294;0.612;0;0.999;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;105;5129.613,1448.415;Inherit;False;Property;_SoftParticle;SoftParticle;37;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;140;2019.04,3348.679;Inherit;True;Property;_VertexOffsetTex1;VertexOffsetTex;14;1;[Header];Create;True;1;VertexOffset;0;0;False;0;False;-1;None;b111d5f279d12c64c844b5cc4f357c2a;True;0;False;white;Auto;False;Instance;51;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;97;2284.388,-588.6133;Inherit;False;498.0005;281.3341;VertexColor;3;100;99;98;VertexColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;110;1581.155,1965.114;Inherit;False;14;UV1_T;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;109;1533.632,1887.753;Inherit;False;Property;_DissoluInvers;DissoluInvers;28;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;115;-428.1233,2094.184;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;143;2022.026,3595.968;Inherit;True;Property;_VertexOffsetTex2;VertexOffsetTex;14;1;[Header];Create;True;1;VertexOffset;0;0;False;0;False;-1;None;b111d5f279d12c64c844b5cc4f357c2a;True;0;False;white;Auto;False;Instance;51;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;125;-2472.542,3173.502;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;51;2007.332,3082.356;Inherit;True;Property;_VertexOffsetTex;VertexOffsetTex;14;1;[Header];Create;True;1;VertexOffset;0;0;False;0;False;-1;None;de9161b9d1d70954faf16a198c75f420;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;124;-2146.473,3437.145;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;77;1453.746,1688.134;Inherit;True;Property;_DissolutionTex;DissolutionTex;23;1;[Header];Create;True;1;Dissolution;0;0;False;0;False;-1;None;e9460174e26405c48bf83b11285ac140;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScaleAndOffsetNode;166;2442.506,3377.079;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;2;False;2;FLOAT;-0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;52;2353.578,4031.86;Inherit;False;0;61;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScaleAndOffsetNode;165;2453.377,3111.717;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;2;False;2;FLOAT;-0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;173;1993.966,2038.556;Inherit;False;171;MainTexA;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;98;2334.388,-538.6133;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;56;2610.661,4322.707;Inherit;False;Property;_VertexOffsetStr;VertexOffsetStr;22;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;108;1914.552,1841.033;Inherit;False;Dissolution;-1;;1;8ed0a8fdbfe80554382ce257577aff19;0;4;3;FLOAT;0;False;7;FLOAT;0;False;4;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;118;-177.5807,2092.634;Inherit;False;MainTexAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;17;-206.9902,-476.0524;Inherit;False;UV1_W;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;119;-549.2791,2432.693;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;167;2439.324,3624.475;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;2;False;2;FLOAT;-0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;53;2647.554,4229.386;Inherit;False;Constant;_Float7;Float 7;25;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;126;-1981.706,3346.872;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;106;5361.568,1470.237;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;114;1939.461,1649.688;Inherit;False;118;MainTexAlpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;59;2839.019,4249.845;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;64;2873.377,3302.292;Inherit;True;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;120;-266.6536,2435.602;Inherit;False;MainTexColor;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;99;2553.063,-423.2793;Inherit;False;VertexColorA;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;61;2641.991,4010.195;Inherit;True;Property;_VertexOffsetMask;VertexOffsetMask;17;0;Create;True;0;0;0;False;0;False;-1;None;e7f62f3b9c4a97e45bb6ef2fc94b2138;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;127;-1837.193,3212.297;Inherit;False;Property;_DisturbRamp;DisturbRamp;12;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;60;2808.933,3909.205;Inherit;False;17;UV1_W;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;172;2195.882,1856.422;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;107;5492.348,1453.024;Inherit;False;SoftParticle;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;54;2929.768,3525.503;Inherit;False;Property;_OffsetDir;OffsetDir;19;0;Create;True;0;0;0;False;0;False;1,1,1;-0.96,0.53,-0.53;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;138;2295.846,2066.737;Inherit;False;99;VertexColorA;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;113;2346.61,1807.581;Inherit;False;Property;_DissolutionOn;DissolutionOn;24;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;63;3384.28,3926.643;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;137;2303.482,1970.931;Inherit;False;107;SoftParticle;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;128;-1590.882,3206.518;Inherit;True;Property;_RampTex;RampTex;11;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;168;3242.306,3300.086;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;129;-1532.342,2969.314;Inherit;True;120;MainTexColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;136;2583.038,1837.663;Inherit;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;66;3500.18,3160.718;Inherit;False;Constant;_Float2;Float 2;27;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;67;3548.586,3277.436;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;130;-1163.994,3147.219;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;189;2630.344,2084.285;Inherit;False;Property;_ColorScale;ColorScale;7;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;100;2551.388,-529.7073;Inherit;False;VertexColorRGB;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;131;-863.3976,3142.386;Inherit;False;MainColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;190;2824.344,1854.285;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;68;3717.722,3188.728;Inherit;True;Property;_VertexOffsetOn;VertexOffsetOn;15;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;112;2998.233,1832.809;Inherit;False;FinalOpacity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;18;-1678.61,-528.0214;Inherit;False;446.8218;360.5826;Comment;3;21;19;20;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;132;702.043,-497.3837;Inherit;False;131;MainColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;135;678.505,-394.874;Inherit;False;100;VertexColorRGB;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;134;664.0232,-698.8541;Inherit;False;Property;_MainColor;MainColor;4;2;[HDR];[Header];Create;True;1;Main;0;0;False;0;False;0,0,0,0;1.498039,1.498039,1.498039,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;69;3988.702,3186.79;Inherit;False;VertexOffset;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;194;-2217.569,2054.438;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;139;1320.922,-358.9371;Inherit;False;112;FinalOpacity;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1657.61,-380.2684;Inherit;False;Property;_ZTestMode;ZTestMode;2;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CompareFunction;True;0;False;8;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-1656.236,-283.8083;Inherit;False;Property;_ZWriteMode;ZWriteMode;3;1;[Enum];Create;True;0;2;Off;0;On;1;0;True;0;False;8;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;40;-955.2706,1931.041;Inherit;False;MainTexUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-1654.13,-478.0223;Inherit;False;Property;_CullMode;CullMode;0;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;133;1054.635,-555.9345;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.NormalVertexDataNode;65;2981.435,3853.089;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;193;-2439.569,2034.437;Inherit;False;Constant;_Float3;Float 3;38;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;192;-2450.542,2114.113;Inherit;False;186;UV3_Y;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;70;1280.404,-190.1584;Inherit;False;69;VertexOffset;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;191;-1961.127,2006.032;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1811.832,-541.7811;Float;False;True;-1;6;ASEMaterialInspector;0;0;CustomLighting;Whl/Fx/Lightning;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;True;21;0;True;20;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;1;-1;-1;-1;0;False;0;0;True;19;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;186;0;2;2
WireConnection;82;0;81;3
WireConnection;187;0;83;0
WireConnection;187;1;188;0
WireConnection;84;0;81;1
WireConnection;84;1;81;2
WireConnection;4;1;3;0
WireConnection;4;0;2;1
WireConnection;6;0;4;0
WireConnection;85;0;187;0
WireConnection;85;2;84;0
WireConnection;85;1;82;0
WireConnection;86;1;85;0
WireConnection;8;0;7;3
WireConnection;9;0;7;4
WireConnection;90;0;86;1
WireConnection;90;1;87;0
WireConnection;90;2;88;0
WireConnection;91;0;90;0
WireConnection;91;1;89;0
WireConnection;25;0;23;0
WireConnection;25;1;22;0
WireConnection;28;0;24;1
WireConnection;28;1;24;2
WireConnection;30;0;24;3
WireConnection;31;0;27;0
WireConnection;31;1;25;0
WireConnection;33;0;29;0
WireConnection;93;1;92;0
WireConnection;93;0;91;0
WireConnection;32;0;26;0
WireConnection;32;2;28;0
WireConnection;32;1;30;0
WireConnection;94;0;93;0
WireConnection;35;0;33;0
WireConnection;34;1;32;0
WireConnection;34;0;31;0
WireConnection;37;0;34;0
WireConnection;37;1;36;0
WireConnection;37;2;35;0
WireConnection;48;0;46;1
WireConnection;48;1;46;2
WireConnection;95;0;37;0
WireConnection;95;1;96;0
WireConnection;49;0;46;3
WireConnection;50;0;47;0
WireConnection;50;2;48;0
WireConnection;50;1;49;0
WireConnection;39;1;95;0
WireConnection;73;0;71;1
WireConnection;73;1;71;2
WireConnection;78;0;71;3
WireConnection;182;1;180;0
WireConnection;116;0;39;0
WireConnection;13;1;11;0
WireConnection;13;0;12;4
WireConnection;75;0;72;0
WireConnection;75;2;73;0
WireConnection;75;1;78;0
WireConnection;181;1;179;0
WireConnection;149;0;50;0
WireConnection;149;1;170;0
WireConnection;148;0;50;0
WireConnection;148;1;169;0
WireConnection;174;0;39;1
WireConnection;117;1;116;0
WireConnection;117;0;174;0
WireConnection;76;0;74;0
WireConnection;76;1;75;0
WireConnection;184;0;149;0
WireConnection;184;1;182;0
WireConnection;14;0;13;0
WireConnection;103;0;102;0
WireConnection;185;0;148;0
WireConnection;185;1;181;0
WireConnection;16;1;15;0
WireConnection;16;0;12;3
WireConnection;171;0;117;0
WireConnection;105;1;104;0
WireConnection;105;0;103;0
WireConnection;140;1;185;0
WireConnection;115;0;39;1
WireConnection;115;1;39;4
WireConnection;143;1;184;0
WireConnection;51;1;50;0
WireConnection;124;0;122;0
WireConnection;124;1;123;0
WireConnection;77;1;76;0
WireConnection;166;0;140;1
WireConnection;165;0;51;1
WireConnection;108;3;77;1
WireConnection;108;7;109;0
WireConnection;108;4;110;0
WireConnection;108;8;111;0
WireConnection;118;0;115;0
WireConnection;17;0;16;0
WireConnection;119;0;39;0
WireConnection;167;0;143;1
WireConnection;126;0;125;0
WireConnection;126;1;124;0
WireConnection;106;0;105;0
WireConnection;59;0;53;0
WireConnection;59;1;56;0
WireConnection;64;0;165;0
WireConnection;64;1;166;0
WireConnection;64;2;167;0
WireConnection;120;0;119;0
WireConnection;99;0;98;4
WireConnection;61;1;52;0
WireConnection;127;1;125;0
WireConnection;127;0;126;0
WireConnection;172;0;108;0
WireConnection;172;1;173;0
WireConnection;107;0;106;0
WireConnection;113;1;114;0
WireConnection;113;0;172;0
WireConnection;63;0;60;0
WireConnection;63;1;61;1
WireConnection;63;2;59;0
WireConnection;128;1;127;0
WireConnection;168;0;64;0
WireConnection;168;1;54;0
WireConnection;136;0;113;0
WireConnection;136;1;137;0
WireConnection;136;2;138;0
WireConnection;67;0;168;0
WireConnection;67;1;63;0
WireConnection;130;0;129;0
WireConnection;130;1;128;0
WireConnection;100;0;98;0
WireConnection;131;0;130;0
WireConnection;190;0;136;0
WireConnection;190;1;189;0
WireConnection;68;1;66;0
WireConnection;68;0;67;0
WireConnection;112;0;190;0
WireConnection;69;0;68;0
WireConnection;194;0;193;0
WireConnection;194;1;192;0
WireConnection;40;0;95;0
WireConnection;133;0;134;0
WireConnection;133;1;132;0
WireConnection;133;2;135;0
WireConnection;191;1;194;0
WireConnection;0;9;139;0
WireConnection;0;13;133;0
WireConnection;0;11;70;0
ASEEND*/
//CHKSM=411CB61970208C9E35354DCAFE7555F2BDE6FA6B