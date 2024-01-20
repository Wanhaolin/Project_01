// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Whl/Fx/ScreenFx"
{
	Properties
	{
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("CullMode", Float) = 0
		[Enum(UnityEngine.Rendering.BlendMode)]_Dst("Dst", Float) = 10
		[Enum(On,1,Off,0)]_ZWriteMode("ZWriteMode", Float) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)]_ZTestMode("ZTestMode", Float) = 8
		[HDR][Header(Main)]_MainColor("MainColor", Color) = (1,1,1,1)
		_MainTex("MainTex", 2D) = "white" {}
		[Enum(OFF,0,ON,1)]_Int0("主贴图UV是否极坐标", Int) = 0
		_MainTlingOffset("MainTlingOffset", Vector) = (1,1,0,0)
		_MainTexPanner("MainTexPanner", Vector) = (0,0,1,0)
		_MaskTex("MaskTex", 2D) = "white" {}
		_MaskTlingOffset("MaskTlingOffset", Vector) = (1,1,0,0)
		_MaskTexPanner("MaskTexPanner", Vector) = (0,0,1,0)
		[Header(Fade)]_FadeTex("FadeTex", 2D) = "white" {}
		_FadeTlingOffset("FadeTlingOffset", Vector) = (1,1,0,0)
		_FadeTexPanner("FadeTexPanner", Vector) = (0,0,1,0)
		[Toggle(_DISTURBFADETEX_ON)] _DisturbFadeTex("DisturbFadeTex", Float) = 0
		_RampTex("RampTex", 2D) = "white" {}
		[Toggle(_DISTURBRAMP_ON)] _DisturbRamp("DisturbRamp", Float) = 0
		_RampDisStr("RampDisStr", Float) = 0
		[Header(Dissolution)]_DissolutionTex("DissolutionTex", 2D) = "white" {}
		[Toggle(_DISSOLUTIONON_ON)] _DissolutionOn("DissolutionOn", Float) = 0
		[Toggle(_UV1_TCONTORLDIS_ON)] _UV1_TContorlDis("UV1_TContorlDis", Float) = 0
		_DissolutionTlingOffset("DissolutionTlingOffset", Vector) = (1,1,0,0)
		_DissolutionTexPanner("DissolutionTexPanner", Vector) = (0,0,1,0)
		_Invers("Invers", Range( 0 , 1)) = 0
		_Dissolution("Dissolution", Range( 0 , 1)) = 0.15
		_Hardness("Hardness", Range( 0 , 0.999)) = 0
		[Header(Disturb)]_DisturbTex("DisturbTex", 2D) = "white" {}
		[Toggle(_DISTURBON_ON)] _DisturbOn("DisturbOn", Float) = 0
		[Toggle(_UV3_XCONTORLDISTURB_ON)] _UV3_XContorlDisturb("UV3_XContorlDisturb", Float) = 0
		_DisturbTlingOffset("DisturbTlingOffset", Vector) = (0,0,0,0)
		_DisturbPanner("DisturbPanner", Vector) = (0,0,1,0)
		_DisturbDir("DisturbDir", Vector) = (1,1,0,0)
		_DisturbStr("DisturbStr", Float) = 0
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
		#pragma target 5.0
		#pragma shader_feature_local _DISTURBON_ON
		#pragma shader_feature_local _UV3_XCONTORLDISTURB_ON
		#pragma shader_feature_local _DISSOLUTIONON_ON
		#pragma shader_feature_local _UV1_TCONTORLDIS_ON
		#pragma shader_feature_local _DISTURBFADETEX_ON
		#pragma shader_feature_local _DISTURBRAMP_ON
		#pragma surface surf StandardCustomLighting keepalpha noshadow 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 screenPos;
			float2 uv3_texcoord3;
			float4 uv_texcoord;
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

		uniform float _ZTestMode;
		uniform float _ZWriteMode;
		uniform float _CullMode;
		uniform float _Dst;
		uniform sampler2D _MainTex;
		uniform float4 _MainTexPanner;
		uniform int _Int0;
		uniform float4 _MainTlingOffset;
		uniform sampler2D _DisturbTex;
		uniform float3 _DisturbPanner;
		uniform float4 _DisturbTlingOffset;
		uniform float _DisturbStr;
		uniform float2 _DisturbDir;
		uniform sampler2D _DissolutionTex;
		uniform float3 _DissolutionTexPanner;
		uniform float4 _DissolutionTlingOffset;
		uniform float _Invers;
		uniform float _Dissolution;
		uniform float _Hardness;
		uniform sampler2D _FadeTex;
		uniform float3 _FadeTexPanner;
		uniform float4 _FadeTlingOffset;
		uniform sampler2D _MaskTex;
		uniform float3 _MaskTexPanner;
		uniform float4 _MaskTlingOffset;
		uniform sampler2D _RampTex;
		uniform float _RampDisStr;
		uniform float4 _MainColor;

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float mulTime16 = _Time.y * _MainTexPanner.z;
			float2 appendResult15 = (float2(_MainTexPanner.x , _MainTexPanner.y));
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float2 appendResult8 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
			float2 appendResult34 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
			float2 temp_output_35_0 = (appendResult34*2.0 + -1.0);
			float2 break37 = temp_output_35_0;
			float2 appendResult40 = (float2((0.0 + (atan2( break37.y , break37.x ) - 0.0) * (1.0 - 0.0) / (3.141593 - 0.0)) , ( 1.0 - length( temp_output_35_0 ) )));
			float2 lerpResult43 = lerp( appendResult8 , appendResult40 , (float)_Int0);
			float2 ScreenUV78 = lerpResult43;
			float2 appendResult12 = (float2(_MainTlingOffset.x , _MainTlingOffset.y));
			float2 appendResult13 = (float2(_MainTlingOffset.z , _MainTlingOffset.w));
			float2 panner9 = ( ( mulTime16 + _MainTexPanner.w ) * appendResult15 + (ScreenUV78*appendResult12 + appendResult13));
			float2 temp_cast_1 = (0.0).xx;
			float mulTime99 = _Time.y * _DisturbPanner.z;
			float2 appendResult101 = (float2(_DisturbPanner.x , _DisturbPanner.y));
			float2 appendResult115 = (float2(_DisturbTlingOffset.x , _DisturbTlingOffset.y));
			float2 appendResult114 = (float2(_DisturbTlingOffset.z , _DisturbTlingOffset.w));
			float2 panner102 = ( mulTime99 * appendResult101 + (ScreenUV78*appendResult115 + appendResult114));
			#ifdef _UV3_XCONTORLDISTURB_ON
				float staticSwitch50 = i.uv3_texcoord3.x;
			#else
				float staticSwitch50 = 1.0;
			#endif
			float UV3_X53 = staticSwitch50;
			#ifdef _DISTURBON_ON
				float2 staticSwitch110 = ( ( tex2D( _DisturbTex, panner102 ).r * _DisturbStr * UV3_X53 ) * _DisturbDir );
			#else
				float2 staticSwitch110 = temp_cast_1;
			#endif
			float2 DisturbColor111 = staticSwitch110;
			float4 tex2DNode1 = tex2D( _MainTex, ( panner9 + DisturbColor111 ) );
			float MainTexAlpha75 = ( tex2DNode1.r * tex2DNode1.a );
			float mulTime121 = _Time.y * _DissolutionTexPanner.z;
			float2 appendResult120 = (float2(_DissolutionTexPanner.x , _DissolutionTexPanner.y));
			float2 appendResult184 = (float2(_DissolutionTlingOffset.x , _DissolutionTlingOffset.y));
			float2 appendResult183 = (float2(_DissolutionTlingOffset.z , _DissolutionTlingOffset.w));
			float2 panner122 = ( mulTime121 * appendResult120 + (ScreenUV78*appendResult184 + appendResult183));
			float temp_output_3_0_g1 = tex2D( _DissolutionTex, ( panner122 + DisturbColor111 ) ).r;
			float lerpResult5_g1 = lerp( temp_output_3_0_g1 , ( 1.0 - temp_output_3_0_g1 ) , _Invers);
			#ifdef _UV1_TCONTORLDIS_ON
				float staticSwitch59 = i.uv_texcoord.w;
			#else
				float staticSwitch59 = _Dissolution;
			#endif
			float UV1_T60 = staticSwitch59;
			float temp_output_8_0_g1 = _Hardness;
			#ifdef _DISSOLUTIONON_ON
				float staticSwitch148 = saturate( ( ( ( ( lerpResult5_g1 + 1.0 ) - ( ( 1.0 - (-0.5 + (UV1_T60 - 0.0) * (1.0 - -0.5) / (1.0 - 0.0)) ) * ( ( 1.0 - temp_output_8_0_g1 ) + 1.0 ) ) ) - temp_output_8_0_g1 ) / ( temp_output_8_0_g1 - 1.0 ) ) );
			#else
				float staticSwitch148 = 1.0;
			#endif
			float VertexColorA66 = i.vertexColor.a;
			float mulTime170 = _Time.y * _FadeTexPanner.z;
			float2 appendResult167 = (float2(_FadeTexPanner.x , _FadeTexPanner.y));
			float2 appendResult188 = (float2(_FadeTlingOffset.x , _FadeTlingOffset.y));
			float2 appendResult187 = (float2(_FadeTlingOffset.z , _FadeTlingOffset.w));
			float2 panner175 = ( mulTime170 * appendResult167 + (ScreenUV78*appendResult188 + appendResult187));
			float2 temp_cast_2 = (0.0).xx;
			#ifdef _DISTURBFADETEX_ON
				float2 staticSwitch174 = DisturbColor111;
			#else
				float2 staticSwitch174 = temp_cast_2;
			#endif
			float FadeTexR182 = tex2D( _FadeTex, ( panner175 + staticSwitch174 ) ).r;
			float mulTime166 = _Time.y * _MaskTexPanner.z;
			float2 appendResult165 = (float2(_MaskTexPanner.x , _MaskTexPanner.y));
			float2 appendResult193 = (float2(_MaskTlingOffset.x , _MaskTlingOffset.y));
			float2 appendResult192 = (float2(_MaskTlingOffset.z , _MaskTlingOffset.w));
			float2 panner173 = ( mulTime166 * appendResult165 + (ScreenUV78*appendResult193 + appendResult192));
			float Mask_TexR181 = tex2D( _MaskTex, ( panner173 + DisturbColor111 ) ).r;
			float FinalOpacity156 = saturate( ( ( MainTexAlpha75 * staticSwitch148 ) * VertexColorA66 * FadeTexR182 * Mask_TexR181 ) );
			float MainTexColor74 = tex2DNode1.r;
			#ifdef _DISTURBRAMP_ON
				float2 staticSwitch91 = ( ScreenUV78 + ( DisturbColor111 * _RampDisStr ) );
			#else
				float2 staticSwitch91 = ScreenUV78;
			#endif
			float4 MainColor95 = ( MainTexColor74 * tex2D( _RampTex, staticSwitch91 ) );
			float4 VertexColorRGB67 = i.vertexColor;
			c.rgb = ( MainColor95 * _MainColor * VertexColorRGB67 ).rgb;
			c.a = FinalOpacity156;
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
14.4;340.8;1367.2;711;7306.358;-16.28877;8.03729;True;False
Node;AmplifyShaderEditor.CommentaryNode;83;-4536.015,-37.64318;Inherit;False;2999.897;881.5392;ScreenUV;13;78;43;45;7;36;8;40;39;38;37;35;34;208;ScreenUV;1,1,1,1;0;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;7;-4486.015,12.35683;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;34;-4207.711,261.3387;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;35;-3977.693,263.5572;Inherit;True;3;0;FLOAT2;0,0;False;1;FLOAT;2;False;2;FLOAT;-1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;37;-3661.907,510.0107;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.ATan2OpNode;38;-3484.626,508.1281;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LengthOpNode;36;-3075.685,273.1111;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;208;-2886.264,280.1723;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;39;-3214.415,510.3767;Inherit;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;3.141593;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;40;-2632.921,262.1043;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;8;-2815.675,41.026;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.IntNode;45;-2573.509,139.3133;Inherit;False;Property;_Int0;主贴图UV是否极坐标;8;1;[Enum];Create;False;0;2;OFF;0;ON;1;0;True;0;False;0;1;False;0;1;INT;0
Node;AmplifyShaderEditor.CommentaryNode;97;9.642059,1624.269;Inherit;False;2260.76;972.6346;DisturbColor;18;101;99;98;113;112;116;115;114;103;111;110;109;108;107;106;105;104;102;DisturbColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.LerpOp;43;-2306.432,63.99339;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;47;-4228.999,3214.226;Inherit;False;1124.562;519.4683;Comment;4;53;50;49;48;UV3;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;78;-1978.476,34.93995;Inherit;False;ScreenUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector4Node;113;99.99104,1855.452;Inherit;False;Property;_DisturbTlingOffset;DisturbTlingOffset;34;0;Create;True;0;0;0;False;0;False;0,0,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;98;259.9192,2114.006;Inherit;False;Property;_DisturbPanner;DisturbPanner;35;0;Create;True;0;0;0;False;0;False;0,0,1;0,0.36,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;49;-4124.535,3274.531;Inherit;False;Constant;_Float12;Float 12;28;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;48;-4162.482,3389.553;Inherit;False;2;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;115;340.3218,1856.72;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;114;341.4617,1970.105;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;112;129.1704,1704.001;Inherit;False;78;ScreenUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;50;-3862.535,3303.531;Inherit;False;Property;_UV3_XContorlDisturb;UV3_XContorlDisturb;33;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;116;583.0547,1776.597;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;101;510.6068,2098.933;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;99;478.3182,2227.006;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;102;833.8209,1909.432;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;53;-3543.362,3326.897;Inherit;False;UV3_X;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;105;1153.089,2226.959;Inherit;False;53;UV3_X;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;103;1072.955,1897.586;Inherit;True;Property;_DisturbTex;DisturbTex;31;1;[Header];Create;True;1;Disturb;0;0;False;0;False;-1;None;b111d5f279d12c64c844b5cc4f357c2a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;104;1163.18,2103.271;Inherit;False;Property;_DisturbStr;DisturbStr;37;0;Create;True;0;0;0;False;0;False;0;-0.08;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;107;1378.188,2263.99;Inherit;False;Property;_DisturbDir;DisturbDir;36;0;Create;True;0;0;0;False;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.CommentaryNode;82;-2871.674,1525.184;Inherit;False;2625.545;1380.121;MainTex;24;13;11;14;15;9;17;16;42;41;74;75;24;21;22;20;23;1;19;10;12;81;202;210;212;MainTex;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;106;1405.554,2079.838;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;108;1563.607,2083.934;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;117;-4475.365,4241.435;Inherit;False;4204.708;1212.861;Comment;26;150;151;153;156;155;154;148;147;132;133;126;125;124;122;121;120;186;184;183;118;160;185;204;205;206;207;FinalOpacity;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector4Node;14;-2770.302,2387.128;Inherit;False;Property;_MainTexPanner;MainTexPanner;10;0;Create;True;0;0;0;False;0;False;0,0,1,0;0,0,1,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;109;1478.363,1925.553;Inherit;False;Constant;_0;0;32;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;11;-2800.731,1917.274;Inherit;False;Property;_MainTlingOffset;MainTlingOffset;9;0;Create;True;0;0;0;False;0;False;1,1,0,0;0.5,1,0,0.39;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;12;-2514.611,1935.28;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;110;1713.61,1937.897;Inherit;False;Property;_DisturbOn;DisturbOn;32;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;81;-2775.846,1609.782;Inherit;False;78;ScreenUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;16;-2514.637,2470.048;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;13;-2513.215,2087.583;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;161;47.32695,4249.607;Inherit;False;2016.646;1963.877;FadeTex;27;180;191;190;188;187;175;182;177;174;171;170;168;167;163;181;179;173;166;165;162;195;192;193;196;194;189;217;FadeTex;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector4Node;185;-4410.291,4484.384;Inherit;False;Property;_DissolutionTlingOffset;DissolutionTlingOffset;26;0;Create;True;0;0;0;False;0;False;1,1,0,0;2,0.5,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;194;21.73664,5400.28;Inherit;False;Property;_MaskTlingOffset;MaskTlingOffset;12;0;Create;True;0;0;0;False;0;False;1,1,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;15;-2348.304,2267.857;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;17;-2286.094,2470.883;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;10;-2287.228,1901.807;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;111;1958.008,1937.853;Inherit;False;DisturbColor;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector3Node;118;-4229.768,4715.241;Inherit;False;Property;_DissolutionTexPanner;DissolutionTexPanner;27;0;Create;True;0;0;0;False;0;False;0,0,1;0,-0.5,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;160;-4267.65,4360.446;Inherit;False;78;ScreenUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;56;-4198.212,1938.986;Inherit;False;1252.226;378.732;Comment;7;65;63;62;60;59;58;57;UV1;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;184;-4142.96,4485.651;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector4Node;189;65.59278,4608.683;Inherit;False;Property;_FadeTlingOffset;FadeTlingOffset;15;0;Create;True;0;0;0;False;0;False;1,1,0,0;1,1,1,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;183;-4142.82,4580.038;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector3Node;162;289.0202,5691.491;Inherit;False;Property;_MaskTexPanner;MaskTexPanner;13;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;192;263.2074,5514.934;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;196;188.5922,5301.471;Inherit;False;78;ScreenUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;193;262.0675,5401.548;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;9;-2089.305,2099.811;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector3Node;163;426.294,4692.672;Inherit;False;Property;_FadeTexPanner;FadeTexPanner;16;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;210;-2055.326,2413.269;Inherit;False;111;DisturbColor;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;57;-3917.648,2156.774;Inherit;False;Property;_Dissolution;Dissolution;29;0;Create;True;0;0;0;False;0;False;0.15;0.757;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;187;259.865,4716.594;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;58;-4148.212,2015.718;Inherit;True;0;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;188;258.7251,4603.208;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;120;-3966.568,4698.339;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;121;-3969.568,4801.642;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;186;-3967.508,4439.582;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;191;166.9857,4459.257;Inherit;False;78;ScreenUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;166;628.1116,5737.515;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;171;560.1859,4897.201;Inherit;False;Constant;_Float13;Float 13;30;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;195;449.3007,5352.625;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;85;-2736.712,3120.307;Inherit;False;2227.146;782.8557;MainColor;10;95;94;93;92;91;90;89;87;86;96;MainColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.StaticSwitch;59;-3522.323,2161.922;Inherit;False;Property;_UV1_TContorlDis;UV1_TContorlDis;25;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;190;493.9582,4489.285;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;122;-3710.127,4516.656;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;170;654.293,4799.672;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;212;-1876.209,2174.405;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;167;677.293,4645.672;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;168;516.1859,4981.984;Inherit;False;111;DisturbColor;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;124;-3681.915,4676.455;Inherit;False;111;DisturbColor;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;165;625.2214,5598.287;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;218;946.9263,5821.582;Inherit;False;111;DisturbColor;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;173;837.9956,5610.88;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;174;818.9807,4900.116;Inherit;False;Property;_DisturbFadeTex;DisturbFadeTex;18;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;87;-2639.858,3734.363;Inherit;False;Property;_RampDisStr;RampDisStr;22;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;86;-2647.281,3628.516;Inherit;False;111;DisturbColor;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1;-1737.739,1805.244;Inherit;True;Property;_MainTex;MainTex;6;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;175;857.973,4575.808;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;60;-3225.382,2157.411;Inherit;False;UV1_T;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;125;-3430.814,4521.856;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;202;-878.92,2234.705;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;217;1138.902,5657.032;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;177;1101.838,4769.765;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;133;-3161.912,4884.589;Inherit;False;Property;_Hardness;Hardness;30;0;Create;True;0;0;0;False;0;False;0;0.584;0;0.999;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;96;-2648.043,3436.652;Inherit;False;78;ScreenUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;61;-4214.681,1427.481;Inherit;False;498.0005;281.3341;VertexColor;3;67;66;64;VertexColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;132;-3243.887,4492.696;Inherit;True;Property;_DissolutionTex;DissolutionTex;23;1;[Header];Create;True;1;Dissolution;0;0;False;0;False;-1;None;f69b5bbf3863af147872e70002ed843e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;207;-3127.972,4707.437;Inherit;False;Property;_Invers;Invers;28;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;126;-3059.337,4803.233;Inherit;False;60;UV1_T;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;89;-2393.759,3619.964;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;90;-2228.994,3529.69;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;206;-2588.559,4651.304;Inherit;False;Constant;_Float2;Float 2;37;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;75;-482.8258,2238.097;Inherit;False;MainTexAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;204;-2693.108,4739.438;Inherit;False;Dissolution;-1;;1;8ed0a8fdbfe80554382ce257577aff19;0;4;3;FLOAT;0;False;7;FLOAT;0;False;4;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;64;-4164.681,1477.481;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;180;1260.155,4734.668;Inherit;True;Property;_FadeTex;FadeTex;14;1;[Header];Create;True;1;Fade;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;179;1401.428,5652.14;Inherit;True;Property;_MaskTex;MaskTex;11;0;Create;True;0;0;0;False;0;False;-1;None;d65afcb62be606e468624fd302d9f33d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;74;-1270.243,1793.952;Inherit;True;MainTexColor;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;147;-2702.851,4565.631;Inherit;False;75;MainTexAlpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;91;-2032.481,3464.016;Inherit;False;Property;_DisturbRamp;DisturbRamp;20;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;182;1576.238,4758.203;Inherit;False;FadeTexR;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;66;-3943.005,1568.815;Inherit;False;VertexColorA;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;148;-2366.549,4663.43;Inherit;False;Property;_DissolutionOn;DissolutionOn;24;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;181;1782.996,5699.681;Inherit;False;Mask_TexR;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;205;-2070.595,4612.557;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;150;-1858.039,5130.115;Inherit;False;181;Mask_TexR;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;153;-1869.145,4907.15;Inherit;False;66;VertexColorA;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;93;-1775.77,3433.536;Inherit;True;Property;_RampTex;RampTex;19;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;151;-1853.633,5018.151;Inherit;False;182;FadeTexR;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;92;-1717.23,3196.333;Inherit;True;74;MainTexColor;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;94;-1348.882,3374.239;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;154;-1443.325,4756.565;Inherit;True;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;67;-3943.679,1472.388;Inherit;False;VertexColorRGB;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;155;-1179.243,4759.121;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;95;-1048.285,3369.404;Inherit;True;MainColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;68;-4741.788,1936.413;Inherit;False;490.0942;445.175;Comment;4;72;71;70;69;Enum;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;198;940.4324,170.1573;Inherit;False;95;MainColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;51;-4193.818,2605.617;Inherit;False;1143.907;365.912;Comment;3;55;54;52;UV2;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;156;-964.7698,4750.353;Inherit;True;FinalOpacity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;2;941.8734,309.3006;Inherit;False;Property;_MainColor;MainColor;5;2;[HDR];[Header];Create;True;1;Main;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;199;944.1631,475.6164;Inherit;False;67;VertexColorRGB;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;65;-3221.839,1999.122;Inherit;False;UV1_W;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-1340.972,2412.866;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;71;-4688.308,1986.412;Inherit;False;Property;_CullMode;CullMode;1;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;19;-1680.313,2267.873;Inherit;False;Property;_RGBAMask;RGBA Mask;7;0;Create;True;0;0;0;False;0;False;1,0,0,0;1,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;24;-1074.072,2247.22;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;41;-796.3121,2032.145;Inherit;False;Property;_MulMainTexChannel;MulMainTexChannel;17;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;72;-4691.788,2084.166;Inherit;False;Property;_ZTestMode;ZTestMode;4;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CompareFunction;True;0;False;8;8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-1340.972,2315.706;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;63;-3589.386,1996.776;Inherit;False;Property;_UV1_WContorlVertexOffset;UV1_WContorlVertexOffset;21;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;62;-3884.695,1988.986;Inherit;False;Constant;_Float1;Float 1;7;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;197;1246.395,28.0338;Inherit;True;156;FinalOpacity;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;42;-1037.298,1890.479;Inherit;False;Constant;_Float0;Float 0;11;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-1342.467,2223.03;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;55;-3697.745,2782.592;Inherit;False;UV2_T;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;54;-3696.281,2687.9;Inherit;False;UV2_W;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;1272.82,265.3355;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;70;-4687.88,2282.722;Inherit;False;Property;_Dst;Dst;2;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;0;False;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-1345.456,2124.375;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;52;-4164.789,2669.539;Inherit;False;1;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;69;-4690.819,2176.275;Inherit;False;Property;_ZWriteMode;ZWriteMode;3;1;[Enum];Create;True;0;2;On;1;Off;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;73;1638.056,-98.56476;Float;False;True;-1;7;ASEMaterialInspector;0;0;CustomLighting;Whl/Fx/ScreenFx;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;True;69;0;True;72;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;True;70;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;True;71;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;34;0;7;1
WireConnection;34;1;7;2
WireConnection;35;0;34;0
WireConnection;37;0;35;0
WireConnection;38;0;37;1
WireConnection;38;1;37;0
WireConnection;36;0;35;0
WireConnection;208;0;36;0
WireConnection;39;0;38;0
WireConnection;40;0;39;0
WireConnection;40;1;208;0
WireConnection;8;0;7;1
WireConnection;8;1;7;2
WireConnection;43;0;8;0
WireConnection;43;1;40;0
WireConnection;43;2;45;0
WireConnection;78;0;43;0
WireConnection;115;0;113;1
WireConnection;115;1;113;2
WireConnection;114;0;113;3
WireConnection;114;1;113;4
WireConnection;50;1;49;0
WireConnection;50;0;48;1
WireConnection;116;0;112;0
WireConnection;116;1;115;0
WireConnection;116;2;114;0
WireConnection;101;0;98;1
WireConnection;101;1;98;2
WireConnection;99;0;98;3
WireConnection;102;0;116;0
WireConnection;102;2;101;0
WireConnection;102;1;99;0
WireConnection;53;0;50;0
WireConnection;103;1;102;0
WireConnection;106;0;103;1
WireConnection;106;1;104;0
WireConnection;106;2;105;0
WireConnection;108;0;106;0
WireConnection;108;1;107;0
WireConnection;12;0;11;1
WireConnection;12;1;11;2
WireConnection;110;1;109;0
WireConnection;110;0;108;0
WireConnection;16;0;14;3
WireConnection;13;0;11;3
WireConnection;13;1;11;4
WireConnection;15;0;14;1
WireConnection;15;1;14;2
WireConnection;17;0;16;0
WireConnection;17;1;14;4
WireConnection;10;0;81;0
WireConnection;10;1;12;0
WireConnection;10;2;13;0
WireConnection;111;0;110;0
WireConnection;184;0;185;1
WireConnection;184;1;185;2
WireConnection;183;0;185;3
WireConnection;183;1;185;4
WireConnection;192;0;194;3
WireConnection;192;1;194;4
WireConnection;193;0;194;1
WireConnection;193;1;194;2
WireConnection;9;0;10;0
WireConnection;9;2;15;0
WireConnection;9;1;17;0
WireConnection;187;0;189;3
WireConnection;187;1;189;4
WireConnection;188;0;189;1
WireConnection;188;1;189;2
WireConnection;120;0;118;1
WireConnection;120;1;118;2
WireConnection;121;0;118;3
WireConnection;186;0;160;0
WireConnection;186;1;184;0
WireConnection;186;2;183;0
WireConnection;166;0;162;3
WireConnection;195;0;196;0
WireConnection;195;1;193;0
WireConnection;195;2;192;0
WireConnection;59;1;57;0
WireConnection;59;0;58;4
WireConnection;190;0;191;0
WireConnection;190;1;188;0
WireConnection;190;2;187;0
WireConnection;122;0;186;0
WireConnection;122;2;120;0
WireConnection;122;1;121;0
WireConnection;170;0;163;3
WireConnection;212;0;9;0
WireConnection;212;1;210;0
WireConnection;167;0;163;1
WireConnection;167;1;163;2
WireConnection;165;0;162;1
WireConnection;165;1;162;2
WireConnection;173;0;195;0
WireConnection;173;2;165;0
WireConnection;173;1;166;0
WireConnection;174;1;171;0
WireConnection;174;0;168;0
WireConnection;1;1;212;0
WireConnection;175;0;190;0
WireConnection;175;2;167;0
WireConnection;175;1;170;0
WireConnection;60;0;59;0
WireConnection;125;0;122;0
WireConnection;125;1;124;0
WireConnection;202;0;1;1
WireConnection;202;1;1;4
WireConnection;217;0;173;0
WireConnection;217;1;218;0
WireConnection;177;0;175;0
WireConnection;177;1;174;0
WireConnection;132;1;125;0
WireConnection;89;0;86;0
WireConnection;89;1;87;0
WireConnection;90;0;96;0
WireConnection;90;1;89;0
WireConnection;75;0;202;0
WireConnection;204;3;132;1
WireConnection;204;7;207;0
WireConnection;204;4;126;0
WireConnection;204;8;133;0
WireConnection;180;1;177;0
WireConnection;179;1;217;0
WireConnection;74;0;1;1
WireConnection;91;1;96;0
WireConnection;91;0;90;0
WireConnection;182;0;180;1
WireConnection;66;0;64;4
WireConnection;148;1;206;0
WireConnection;148;0;204;0
WireConnection;181;0;179;1
WireConnection;205;0;147;0
WireConnection;205;1;148;0
WireConnection;93;1;91;0
WireConnection;94;0;92;0
WireConnection;94;1;93;0
WireConnection;154;0;205;0
WireConnection;154;1;153;0
WireConnection;154;2;151;0
WireConnection;154;3;150;0
WireConnection;67;0;64;0
WireConnection;155;0;154;0
WireConnection;95;0;94;0
WireConnection;156;0;155;0
WireConnection;65;0;63;0
WireConnection;23;0;19;4
WireConnection;23;1;1;4
WireConnection;24;0;20;0
WireConnection;24;1;21;0
WireConnection;24;2;22;0
WireConnection;24;3;23;0
WireConnection;41;1;42;0
WireConnection;22;0;19;3
WireConnection;22;1;1;3
WireConnection;63;1;62;0
WireConnection;63;0;58;3
WireConnection;21;0;19;2
WireConnection;21;1;1;2
WireConnection;55;0;52;4
WireConnection;54;0;52;3
WireConnection;4;0;198;0
WireConnection;4;1;2;0
WireConnection;4;2;199;0
WireConnection;20;0;19;1
WireConnection;20;1;1;1
WireConnection;73;9;197;0
WireConnection;73;13;4;0
ASEEND*/
//CHKSM=16EBD19C1A6D0AD1C80842540C56D1FF7D9D012A