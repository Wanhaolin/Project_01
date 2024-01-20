// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Whl/Fx/stone"
{
	Properties
	{
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("CullMode", Float) = 0
		[Enum(UnityEngine.Rendering.BlendMode)]_Dst("Dst", Float) = 10
		[Enum(On,1,Off,0)]_ZWriteMode("ZWriteMode", Float) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)]_ZTestMode("ZTestMode", Float) = 8
		[HDR][Header(Main)]_MainColor("MainColor", Color) = (0,0,0,0)
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_MainTex("MainTex", 2D) = "white" {}
		[Toggle(_RGBA_ON)] _RGBA("RGBA", Float) = 0
		[HDR]_EmissColor("EmissColor", Color) = (0,0,0,0)
		_EmissTex("EmissTex", 2D) = "black" {}
		_EmissNoise("EmissNoise", 2D) = "white" {}
		_EmissNoisePanner("EmissNoisePanner", Vector) = (0,0,1,0)
		[HDR]_FlowEmissColor("FlowEmissColor", Color) = (0,0,0,0)
		_FlowEmissTex("FlowEmissTex", 2D) = "black" {}
		[Toggle(_UV2_WTCONTROLOFFSET_ON)] _UV2_WTControlOffset("UV2_WTControlOffset", Float) = 0
		_Rotater("Rotater", Range( 0 , 360)) = 0
		_MainTexPanner("MainTexPanner", Vector) = (0,0,1,0)
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
		[Toggle(_UV2_WTCONTORLOFFSET_ON)] _UV2_WTContorlOffset("UV2_WTContorlOffset", Float) = 0
		[Toggle(_UV1_WCONTORLVERTEXOFFSET_ON)] _UV1_WContorlVertexOffset("UV1_WContorlVertexOffset", Float) = 0
		_VertexOffsetMask("VertexOffsetMask", 2D) = "white" {}
		_VertexOffsetTexPanner("VertexOffsetTexPanner", Vector) = (0,0,1,0)
		_OffsetDir("OffsetDir", Vector) = (1,1,1,0)
		_VertexOffsetStr("VertexOffsetStr", Float) = 1
		[HideInInspector] _texcoord3( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
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
		#pragma shader_feature_local _VERTEXOFFSETON_ON
		#pragma shader_feature_local _UV2_WTCONTORLOFFSET_ON
		#pragma shader_feature_local _UV1_WCONTORLVERTEXOFFSET_ON
		#pragma shader_feature_local _DISSOLUTIONON_ON
		#pragma shader_feature_local _RGBA_ON
		#pragma shader_feature_local _DISTURBON_ON
		#pragma shader_feature_local _UV3_XCONTORLDISTURB_ON
		#pragma shader_feature_local _UV1_TCONTORLDIS_ON
		#pragma shader_feature_local _DISTURBRAMP_ON
		#pragma shader_feature_local _UV2_WTCONTROLOFFSET_ON
		#pragma surface surf StandardCustomLighting keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 screenPosition;
			float4 uv_texcoord;
			float4 uv3_texcoord3;
			float4 vertexColor : COLOR;
			float4 uv2_texcoord2;
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
		uniform float _ZTestMode;
		uniform float _CullMode;
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
		uniform float4 _MainColor;
		uniform sampler2D _RampTex;
		uniform float4 _RampTex_ST;
		uniform float _RampDisStr;
		uniform float4 _EmissColor;
		uniform sampler2D _EmissTex;
		uniform float4 _EmissTex_ST;
		uniform sampler2D _EmissNoise;
		uniform float3 _EmissNoisePanner;
		uniform float4 _EmissNoise_ST;
		uniform sampler2D _FlowEmissTex;
		uniform float4 _FlowEmissTex_ST;
		uniform float4 _FlowEmissColor;
		uniform float _Cutoff = 0.5;


		inline float Dither4x4Bayer( int x, int y )
		{
			const float dither[ 16 ] = {
				 1,  9,  3, 11,
				13,  5, 15,  7,
				 4, 12,  2, 10,
				16,  8, 14,  6 };
			int r = y * 4 + x;
			return dither[r] / 16; // same # of instructions as pre-dividing due to compiler magic
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 temp_cast_0 = (0.0).xxx;
			float mulTime130 = _Time.y * _VertexOffsetTexPanner.z;
			float2 appendResult128 = (float2(_VertexOffsetTexPanner.x , _VertexOffsetTexPanner.y));
			float4 uv2s_VertexOffsetTex = v.texcoord1;
			uv2s_VertexOffsetTex.xy = v.texcoord1.xy * _VertexOffsetTex_ST.xy + _VertexOffsetTex_ST.zw;
			float2 panner131 = ( mulTime130 * appendResult128 + uv2s_VertexOffsetTex.xy);
			float2 temp_cast_1 = (0.0).xx;
			float UV2_W152 = v.texcoord1.z;
			float UV2_T160 = v.texcoord1.w;
			float2 appendResult301 = (float2(UV2_W152 , UV2_T160));
			#ifdef _UV2_WTCONTORLOFFSET_ON
				float2 staticSwitch303 = appendResult301;
			#else
				float2 staticSwitch303 = temp_cast_1;
			#endif
			float4 tex2DNode126 = tex2Dlod( _VertexOffsetTex, float4( ( panner131 + staticSwitch303 ), 0, 0.0) );
			float3 appendResult272 = (float3(( tex2DNode126.r * _OffsetDir.x ) , ( tex2DNode126.r * _OffsetDir.y ) , ( tex2DNode126.r * _OffsetDir.z )));
			#ifdef _UV1_WCONTORLVERTEXOFFSET_ON
				float staticSwitch21 = v.texcoord.z;
			#else
				float staticSwitch21 = 1.0;
			#endif
			float UV1_W82 = staticSwitch21;
			float4 uv2s_VertexOffsetMask = v.texcoord1;
			uv2s_VertexOffsetMask.xy = v.texcoord1.xy * _VertexOffsetMask_ST.xy + _VertexOffsetMask_ST.zw;
			float3 ase_vertexNormal = v.normal.xyz;
			#ifdef _VERTEXOFFSETON_ON
				float3 staticSwitch191 = ( appendResult272 * ( UV1_W82 * tex2Dlod( _VertexOffsetMask, float4( uv2s_VertexOffsetMask.xy, 0, 0.0) ).r * ( 0.1 * _VertexOffsetStr ) ) * ase_vertexNormal );
			#else
				float3 staticSwitch191 = temp_cast_0;
			#endif
			float3 VertexOffset137 = staticSwitch191;
			v.vertex.xyz += VertexOffset137;
			v.vertex.w = 1;
			float4 ase_screenPos = ComputeScreenPos( UnityObjectToClipPos( v.vertex ) );
			o.screenPosition = ase_screenPos;
		}

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float4 ase_screenPos = i.screenPosition;
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float2 clipScreen283 = ase_screenPosNorm.xy * _ScreenParams.xy;
			float dither283 = Dither4x4Bayer( fmod(clipScreen283.x, 4), fmod(clipScreen283.y, 4) );
			float mulTime31 = _Time.y * _MainTexPanner.z;
			float2 appendResult30 = (float2(_MainTexPanner.x , _MainTexPanner.y));
			float4 uvs_MainTex = i.uv_texcoord;
			uvs_MainTex.xy = i.uv_texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
			float2 panner27 = ( mulTime31 * appendResult30 + uvs_MainTex.xy);
			float2 temp_cast_0 = (0.5).xx;
			float cos193 = cos( ( (0.0 + (_Rotater - 0.0) * (2.0 - 0.0) / (360.0 - 0.0)) * UNITY_PI ) );
			float sin193 = sin( ( (0.0 + (_Rotater - 0.0) * (2.0 - 0.0) / (360.0 - 0.0)) * UNITY_PI ) );
			float2 rotator193 = mul( panner27 - temp_cast_0 , float2x2( cos193 , -sin193 , sin193 , cos193 )) + temp_cast_0;
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
				float staticSwitch210 = tex2DNode1.a;
			#else
				float staticSwitch210 = tex2DNode1.r;
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
			float VertexColorA77 = i.vertexColor.a;
			float FinalOpacity95 = saturate( ( staticSwitch162 * VertexColorA77 ) );
			dither283 = step( dither283, FinalOpacity95 );
			float3 MainTexColor214 = (tex2DNode1).rgb;
			float4 uvs_RampTex = i.uv_texcoord;
			uvs_RampTex.xy = i.uv_texcoord.xy * _RampTex_ST.xy + _RampTex_ST.zw;
			#ifdef _DISTURBRAMP_ON
				float2 staticSwitch230 = ( uvs_RampTex.xy + ( DisturbColor167 * _RampDisStr ) );
			#else
				float2 staticSwitch230 = uvs_RampTex.xy;
			#endif
			float4 MainColor91 = ( float4( MainTexColor214 , 0.0 ) * tex2D( _RampTex, staticSwitch230 ) );
			float4 VertexColorRGB75 = i.vertexColor;
			float4 temp_output_15_0 = ( _MainColor * MainColor91 * VertexColorRGB75 );
			float2 uv_EmissTex = i.uv_texcoord * _EmissTex_ST.xy + _EmissTex_ST.zw;
			float mulTime297 = _Time.y * _EmissNoisePanner.z;
			float2 appendResult296 = (float2(_EmissNoisePanner.x , _EmissNoisePanner.y));
			float4 uvs_EmissNoise = i.uv_texcoord;
			uvs_EmissNoise.xy = i.uv_texcoord.xy * _EmissNoise_ST.xy + _EmissNoise_ST.zw;
			float2 panner294 = ( mulTime297 * appendResult296 + uvs_EmissNoise.xy);
			float4 EmissColor286 = ( _EmissColor * tex2D( _EmissTex, uv_EmissTex ).r * tex2D( _EmissNoise, panner294 ).r * VertexColorRGB75 );
			float4 uv2s_FlowEmissTex = i.uv2_texcoord2;
			uv2s_FlowEmissTex.xy = i.uv2_texcoord2.xy * _FlowEmissTex_ST.xy + _FlowEmissTex_ST.zw;
			float4 uvs_FlowEmissTex = i.uv_texcoord;
			uvs_FlowEmissTex.xy = i.uv_texcoord.xy * _FlowEmissTex_ST.xy + _FlowEmissTex_ST.zw;
			float UV2_W152 = i.uv2_texcoord2.z;
			float UV2_T160 = i.uv2_texcoord2.w;
			float2 appendResult157 = (float2(UV2_W152 , UV2_T160));
			#ifdef _UV2_WTCONTROLOFFSET_ON
				float2 staticSwitch154 = ( uvs_FlowEmissTex.xy + appendResult157 );
			#else
				float2 staticSwitch154 = uv2s_FlowEmissTex.xy;
			#endif
			float4 EmissColor2288 = ( tex2D( _FlowEmissTex, staticSwitch154 ).r * _FlowEmissColor );
			c.rgb = ( temp_output_15_0 + EmissColor286 + EmissColor2288 ).rgb;
			c.a = 1;
			clip( saturate( dither283 ) - _Cutoff );
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
284.8;241.6;1120.8;743.8;941.8132;1265.467;2.488742;True;False
Node;AmplifyShaderEditor.CommentaryNode;169;-5169.745,563.6747;Inherit;False;1883.194;986.6012;DisturbColor;14;178;167;179;177;201;180;166;175;172;174;173;171;222;223;DisturbColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;203;-4060.576,-533.9757;Inherit;False;1124.562;519.4683;Comment;4;200;202;205;206;UV3;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;206;-3956.111,-473.67;Inherit;False;Constant;_Float12;Float 12;28;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;202;-3994.059,-358.6486;Inherit;False;2;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;171;-5065.521,867.0081;Inherit;False;Property;_DisturbPanner;DisturbPanner;29;0;Create;True;0;0;0;False;0;False;0,0,1;0.3,0.3,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleTimeNode;173;-4817.521,974.0081;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;172;-5012.337,706.765;Inherit;False;0;166;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;174;-4814.521,820.0081;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;205;-3694.111,-444.67;Inherit;False;Property;_UV3_XContorlDisturb;UV3_XContorlDisturb;28;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;175;-4632.84,788.1461;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;200;-3374.938,-421.3047;Inherit;False;UV3_X;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;166;-4393.706,776.2999;Inherit;True;Property;_DisturbTex;DisturbTex;26;1;[Header];Create;True;1;Disturb;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;201;-4313.572,1105.675;Inherit;False;200;UV3_X;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;178;-4303.481,981.9863;Inherit;False;Property;_DisturbStr;DisturbStr;31;0;Create;True;0;0;0;False;0;False;0;-0.07;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;222;-4088.473,1142.704;Inherit;False;Property;_DisturbDir;DisturbDir;30;0;Create;True;0;0;0;False;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.CommentaryNode;80;-2611.824,-2316.12;Inherit;False;2819.581;793.3801;MainTex;18;210;68;211;1;170;193;181;196;194;207;27;31;30;195;28;29;214;227;MainTex;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;177;-4061.107,958.5524;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;29;-2561.824,-2105.876;Inherit;False;Property;_MainTexPanner;MainTexPanner;16;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;195;-1939.375,-1887.204;Inherit;False;Property;_Rotater;Rotater;15;0;Create;True;0;0;0;False;0;False;0;0;0;360;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;180;-4016.509,725.275;Inherit;False;Constant;_0;0;32;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;223;-3903.054,962.6478;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;30;-2310.825,-2152.876;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;31;-2313.825,-1998.876;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;179;-3753.051,816.6118;Inherit;False;Property;_DisturbOn;DisturbOn;27;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;93;-4029.789,-1809.215;Inherit;False;1252.226;378.732;Comment;7;23;83;5;82;21;22;20;UV1;1,1,1,1;0;0
Node;AmplifyShaderEditor.TFHCRemapNode;207;-1666.604,-1881.482;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;360;False;3;FLOAT;0;False;4;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;94;-3215.365,546.3636;Inherit;False;3905.305;1039.2;Comment;28;125;147;145;95;6;89;97;162;163;112;9;146;73;144;111;105;102;13;106;107;183;84;124;182;122;121;123;120;FinalOpacity;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;28;-2508.641,-2266.12;Inherit;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;167;-3510.376,823.4589;Inherit;False;DisturbColor;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;27;-2129.145,-2184.739;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PiNode;196;-1490.313,-1881.489;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;120;-3146.367,954.8475;Inherit;False;Property;_DissolutionTexPanner;DissolutionTexPanner;25;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TextureCoordinatesNode;20;-3979.789,-1732.483;Inherit;True;0;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;5;-3769.224,-1515.427;Inherit;False;Property;_Dissolution;Dissolution;23;0;Create;True;0;0;0;False;0;False;0.15;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;194;-1632.339,-1982.5;Inherit;False;Constant;_Float11;Float 11;26;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;151;-4025.395,-1142.584;Inherit;False;1143.907;365.912;Comment;3;160;152;38;UV2;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleTimeNode;122;-2852.368,1069.847;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;23;-3433.2,-1587.579;Inherit;False;Property;_UV1_TContorlDis;UV1_TContorlDis;22;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;121;-2849.368,915.8475;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;123;-3048.185,803.6044;Inherit;False;0;102;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;181;-1591.122,-1761.188;Inherit;False;167;DisturbColor;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RotatorNode;193;-1384.377,-2038.88;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;182;-2751.276,669.3851;Inherit;False;167;DisturbColor;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;83;-3056.958,-1590.79;Inherit;False;UV1_T;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;38;-3996.365,-1078.663;Inherit;False;1;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;124;-2676.789,821.5853;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;170;-1194.381,-2029.389;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;183;-2444.276,764.3851;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;84;-2268.134,1153.838;Inherit;False;83;UV1_T;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;107;-2241.919,1257.7;Inherit;False;Constant;_Float4;Float 4;20;0;Create;True;0;0;0;False;0;False;-2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;164;-3116.152,1858.793;Inherit;False;2578.479;1252.42;VertexOffset;30;137;192;191;127;128;130;129;131;126;266;267;265;132;234;139;235;268;269;270;271;272;134;136;133;299;300;301;302;303;304;VertexOffset;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;1;-975.8948,-2060.755;Inherit;True;Property;_MainTex;MainTex;6;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;152;-3527.857,-1060.301;Inherit;False;UV2_W;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;160;-3529.321,-965.6096;Inherit;False;UV2_T;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;300;-2875.388,2403.655;Inherit;False;160;UV2_T;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;210;-260.8716,-2100.742;Inherit;False;Property;_RGBA;RGBA;7;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;106;-1963.399,1153.376;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;90;-2498.941,-647.7783;Inherit;False;2227.146;782.8557;MainColor;10;148;91;71;149;184;229;230;231;232;233;MainColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;102;-1930.599,811.9844;Inherit;True;Property;_DissolutionTex;DissolutionTex;20;1;[Header];Create;True;1;Dissolution;0;0;False;0;False;-1;None;7519396695347864f82d2ff824f697f2;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;105;-1857.621,1009.604;Inherit;False;Constant;_Float3;Float 3;20;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;127;-3062.102,2098.483;Inherit;False;Property;_VertexOffsetTexPanner;VertexOffsetTexPanner;37;0;Create;True;0;0;0;False;0;False;0,0,1;0,1,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;299;-2878.118,2309.007;Inherit;False;152;UV2_W;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-1801.696,1203.143;Inherit;False;Property;_DissolutionSoft;DissolutionSoft;24;0;Create;True;0;0;0;False;0;False;0.3935294;0.51;0.51;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;144;-1497.699,1097.137;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;304;-2599.34,2234.544;Inherit;False;Constant;_Float1;Float 1;43;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;301;-2643.845,2330.573;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;68;-46.006,-2099.116;Inherit;False;MainTexAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;233;-2396.687,7.478149;Inherit;False;Property;_RampDisStr;RampDisStr;19;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;81;378.5724,-1825.137;Inherit;False;498.0005;281.3341;VertexColor;3;75;77;24;VertexColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;229;-2364.309,-84.66939;Inherit;False;167;DisturbColor;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;130;-2778.609,2192.499;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;128;-2748.508,2086.799;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;129;-2898.463,1920.945;Inherit;False;1;126;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;111;-1483.831,960.2977;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;184;-2419.658,-367.5649;Inherit;False;0;148;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;73;-874.8689,1097.553;Inherit;False;68;MainTexAlpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;9;-1119.579,1211.05;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-3716.271,-1759.215;Inherit;False;Constant;_Float0;Float 0;7;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;24;428.5724,-1775.137;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;303;-2447.537,2234.546;Inherit;False;Property;_UV2_WTContorlOffset;UV2_WTContorlOffset;34;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;146;-848.3202,1014.804;Inherit;False;Constant;_Float9;Float 9;27;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;153;1095.517,790.6044;Inherit;False;152;UV2_W;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;161;1098.247,885.2521;Inherit;False;160;UV2_T;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;131;-2573.344,2001.077;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;232;-2093.588,-103.9218;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector3Node;295;1151.755,158.4331;Inherit;False;Property;_EmissNoisePanner;EmissNoisePanner;11;0;Create;True;0;0;0;False;0;False;0,0,1;0,0.2,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;157;1329.79,812.17;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;163;-600.215,966.9457;Inherit;False;68;MainTexAlpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;302;-2384.469,2002.649;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ComponentMaskNode;211;-551.2866,-1775.902;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;112;-592.4423,1135.094;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;231;-1928.822,-194.1953;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;158;1239.285,656.5435;Inherit;False;0;285;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;21;-3420.962,-1751.425;Inherit;False;Property;_UV1_WContorlVertexOffset;UV1_WContorlVertexOffset;35;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;77;647.2477,-1659.803;Inherit;False;VertexColorA;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;162;-333.6866,1083.347;Inherit;False;Property;_DissolutionOn;DissolutionOn;21;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;134;-2369.517,2932.226;Inherit;False;Constant;_Float7;Float 7;25;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;271;-2007.146,2243.079;Inherit;True;Property;_OffsetDir;OffsetDir;38;0;Create;True;0;0;0;False;0;False;1,1,1;1,1,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;136;-2397.817,3024.925;Inherit;False;Property;_VertexOffsetStr;VertexOffsetStr;39;0;Create;True;0;0;0;False;0;False;1;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;230;-1784.309,-328.7694;Inherit;False;Property;_DisturbRamp;DisturbRamp;18;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;235;-2586.708,2733.169;Inherit;False;1;234;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;292;1282.888,43.37549;Inherit;False;0;293;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;214;-141,-1779.253;Inherit;False;MainTexColor;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;97;-312.7616,1275.413;Inherit;False;77;VertexColorA;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;296;1397.755,170.4331;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;297;1385.794,274.4193;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;126;-2258.677,1977.935;Inherit;True;Property;_VertexOffsetTex;VertexOffsetTex;32;1;[Header];Create;True;1;VertexOffset;0;0;False;0;False;-1;None;fed0bbbeffbe67d459eca7054dac7444;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;159;1514.241,682.5294;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;284;1342.933,435.9604;Inherit;False;1;285;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;82;-3053.415,-1749.079;Inherit;False;UV1_W;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;268;-1714.603,2185.069;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;234;-2298.292,2711.504;Inherit;True;Property;_VertexOffsetMask;VertexOffsetMask;36;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;71;-1479.458,-571.7523;Inherit;True;214;MainTexColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;89;-15.32546,1142.701;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;75;645.5729,-1766.231;Inherit;False;VertexColorRGB;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;270;-1709.856,2037.892;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;133;-2141.607,2996.35;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;269;-1718.488,2337.838;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;154;1674.555,525.5202;Inherit;False;Property;_UV2_WTControlOffset;UV2_WTControlOffset;14;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;139;-2234.33,2603.411;Inherit;False;82;UV1_W;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;148;-1537.998,-334.5495;Inherit;True;Property;_RampTex;RampTex;17;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;294;1630.66,122.0683;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;6;271.7046,1137.208;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;290;2150.373,777.7768;Inherit;False;Property;_FlowEmissColor;FlowEmissColor;12;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;0.9056604,0.4570934,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;282;1945.711,-263.9691;Inherit;False;Property;_EmissColor;EmissColor;8;1;[HDR];Create;True;1;BackFaceColor;0;0;False;0;False;0,0,0,0;4.20335,3.999951,3.875489,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;149;-1111.11,-393.847;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;265;-1794.936,2614.438;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;293;1917.646,156.7749;Inherit;True;Property;_EmissNoise;EmissNoise;10;0;Create;True;0;0;0;False;0;False;-1;None;8b11858a6b89d594593faf2c070f13d3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;279;1908.262,-96.15366;Inherit;True;Property;_EmissTex;EmissTex;9;0;Create;True;0;0;0;False;0;False;-1;None;004a19e8d104fea42b0f448b4e800be1;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalVertexDataNode;132;-1807.496,2771.282;Inherit;True;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;272;-1508.897,2120.686;Inherit;True;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;285;2091.182,505.7378;Inherit;True;Property;_FlowEmissTex;FlowEmissTex;13;0;Create;True;0;0;0;False;0;False;-1;None;2e15387a9124b084ba0dc9d5998b54d7;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;298;1984.465,369.9319;Inherit;False;75;VertexColorRGB;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;291;2476.533,537.2359;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;281;2395.461,-148.6314;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;192;-1262.786,2178.756;Inherit;False;Constant;_Float2;Float 2;27;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;91;-810.5136,-398.6811;Inherit;True;MainColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;266;-1239.676,2317.24;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;95;471.2752,1119.62;Inherit;False;FinalOpacity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;286;2828.128,-148.4993;Inherit;False;EmissColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;92;-238.0034,-458.2107;Inherit;False;91;MainColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;288;2698.617,493.2374;Inherit;False;EmissColor2;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;78;-244.9297,-580.5457;Inherit;False;75;VertexColorRGB;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;191;-1061.452,2249.968;Inherit;False;Property;_VertexOffsetOn;VertexOffsetOn;33;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;16;-212.954,-815.0086;Inherit;False;Property;_MainColor;MainColor;4;2;[HDR];[Header];Create;True;1;Main;0;0;False;0;False;0,0,0,0;0.3113208,0.238945,0.2099947,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;96;290.4589,-864.7418;Inherit;True;95;FinalOpacity;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.DitheringNode;283;540.9182,-856.5413;Inherit;False;0;True;4;0;FLOAT;0;False;1;SAMPLER2D;;False;2;FLOAT4;0,0,0,0;False;3;SAMPLERSTATE;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;289;338.4512,-174.166;Inherit;False;288;EmissColor2;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;287;321.0099,-430.6715;Inherit;False;286;EmissColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;137;-772.9873,2315.473;Inherit;False;VertexOffset;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;46;-4595.354,-1806.908;Inherit;False;490.0942;445.175;Comment;4;278;37;36;273;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;225.9324,-642.8297;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;253;1062.243,1214.427;Inherit;False;1088.13;274.4167;WorldNormal;5;258;257;256;255;254;WorldNormal;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;280;538.435,-609.4197;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;220;275.0029,-330.1549;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;125;-2057.506,1017.632;Inherit;False;Constant;_Float6;Float 6;23;0;Create;True;0;0;0;False;0;False;0.58;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;255;1314.969,1377.844;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwitchByFaceNode;257;1708.969,1269.844;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;278;-4540.446,-1657.599;Inherit;False;Property;_Dst;Dst;1;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;0;False;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;267;-1948.929,2006.97;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-1;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;218;859.354,-522.8275;Inherit;False;Property;_BackFaceOn;BackFaceOn;41;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;227;-1021.888,-2168.068;Inherit;False;MainTexUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;258;1926.373,1265.698;Inherit;False;WorldNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;147;-2229.071,1044.183;Inherit;False;Constant;_Float10;Float 10;27;0;Create;True;0;0;0;False;0;False;0.61;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-4541.874,-1756.909;Inherit;False;Property;_CullMode;CullMode;0;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;138;828.8001,-329.0221;Inherit;False;137;VertexOffset;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;37;-4547.354,-1491.155;Inherit;False;Property;_ZTestMode;ZTestMode;3;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CompareFunction;True;0;False;8;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;256;1471.969,1320.844;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldNormalVector;254;1112.243,1264.427;Inherit;False;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;217;-118.6549,-76.52956;Inherit;False;Property;_BackFaceIntensity;BackFaceIntensity;42;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SwitchByFaceNode;215;632.3391,-478.4238;Inherit;False;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;273;-4544.385,-1569.046;Inherit;False;Property;_ZWriteMode;ZWriteMode;2;1;[Enum];Create;True;0;2;On;1;Off;0;0;True;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;145;-2227.622,1370.846;Inherit;False;Constant;_Float8;Float 8;27;0;Create;True;0;0;0;False;0;False;0.57;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;208;791.6816,-849.2772;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;219;-168.7295,-293.0279;Inherit;False;Property;_BackFaceColor;BackFaceColor;40;2;[HDR];[Header];Create;True;1;BackFaceColor;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1210.138,-839.6459;Float;False;True;-1;7;ASEMaterialInspector;0;0;CustomLighting;Whl/Fx/stone;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;2;True;273;0;True;37;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;True;278;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;5;-1;-1;-1;0;False;0;0;True;36;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
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
WireConnection;177;0;166;1
WireConnection;177;1;178;0
WireConnection;177;2;201;0
WireConnection;223;0;177;0
WireConnection;223;1;222;0
WireConnection;30;0;29;1
WireConnection;30;1;29;2
WireConnection;31;0;29;3
WireConnection;179;1;180;0
WireConnection;179;0;223;0
WireConnection;207;0;195;0
WireConnection;167;0;179;0
WireConnection;27;0;28;0
WireConnection;27;2;30;0
WireConnection;27;1;31;0
WireConnection;196;0;207;0
WireConnection;122;0;120;3
WireConnection;23;1;5;0
WireConnection;23;0;20;4
WireConnection;121;0;120;1
WireConnection;121;1;120;2
WireConnection;193;0;27;0
WireConnection;193;1;194;0
WireConnection;193;2;196;0
WireConnection;83;0;23;0
WireConnection;124;0;123;0
WireConnection;124;2;121;0
WireConnection;124;1;122;0
WireConnection;170;0;193;0
WireConnection;170;1;181;0
WireConnection;183;0;182;0
WireConnection;183;1;124;0
WireConnection;1;1;170;0
WireConnection;152;0;38;3
WireConnection;160;0;38;4
WireConnection;210;1;1;1
WireConnection;210;0;1;4
WireConnection;106;0;84;0
WireConnection;106;1;107;0
WireConnection;102;1;183;0
WireConnection;144;0;13;0
WireConnection;301;0;299;0
WireConnection;301;1;300;0
WireConnection;68;0;210;0
WireConnection;130;0;127;3
WireConnection;128;0;127;1
WireConnection;128;1;127;2
WireConnection;111;0;102;1
WireConnection;111;1;105;0
WireConnection;111;2;106;0
WireConnection;9;0;111;0
WireConnection;9;1;144;0
WireConnection;9;2;13;0
WireConnection;303;1;304;0
WireConnection;303;0;301;0
WireConnection;131;0;129;0
WireConnection;131;2;128;0
WireConnection;131;1;130;0
WireConnection;232;0;229;0
WireConnection;232;1;233;0
WireConnection;157;0;153;0
WireConnection;157;1;161;0
WireConnection;302;0;131;0
WireConnection;302;1;303;0
WireConnection;211;0;1;0
WireConnection;112;0;146;0
WireConnection;112;1;73;0
WireConnection;112;2;9;0
WireConnection;231;0;184;0
WireConnection;231;1;232;0
WireConnection;21;1;22;0
WireConnection;21;0;20;3
WireConnection;77;0;24;4
WireConnection;162;1;163;0
WireConnection;162;0;112;0
WireConnection;230;1;184;0
WireConnection;230;0;231;0
WireConnection;214;0;211;0
WireConnection;296;0;295;1
WireConnection;296;1;295;2
WireConnection;297;0;295;3
WireConnection;126;1;302;0
WireConnection;159;0;158;0
WireConnection;159;1;157;0
WireConnection;82;0;21;0
WireConnection;268;0;126;1
WireConnection;268;1;271;2
WireConnection;234;1;235;0
WireConnection;89;0;162;0
WireConnection;89;1;97;0
WireConnection;75;0;24;0
WireConnection;270;0;126;1
WireConnection;270;1;271;1
WireConnection;133;0;134;0
WireConnection;133;1;136;0
WireConnection;269;0;126;1
WireConnection;269;1;271;3
WireConnection;154;1;284;0
WireConnection;154;0;159;0
WireConnection;148;1;230;0
WireConnection;294;0;292;0
WireConnection;294;2;296;0
WireConnection;294;1;297;0
WireConnection;6;0;89;0
WireConnection;149;0;71;0
WireConnection;149;1;148;0
WireConnection;265;0;139;0
WireConnection;265;1;234;1
WireConnection;265;2;133;0
WireConnection;293;1;294;0
WireConnection;272;0;270;0
WireConnection;272;1;268;0
WireConnection;272;2;269;0
WireConnection;285;1;154;0
WireConnection;291;0;285;1
WireConnection;291;1;290;0
WireConnection;281;0;282;0
WireConnection;281;1;279;1
WireConnection;281;2;293;1
WireConnection;281;3;298;0
WireConnection;91;0;149;0
WireConnection;266;0;272;0
WireConnection;266;1;265;0
WireConnection;266;2;132;0
WireConnection;95;0;6;0
WireConnection;286;0;281;0
WireConnection;288;0;291;0
WireConnection;191;1;192;0
WireConnection;191;0;266;0
WireConnection;283;0;96;0
WireConnection;137;0;191;0
WireConnection;15;0;16;0
WireConnection;15;1;92;0
WireConnection;15;2;78;0
WireConnection;280;0;15;0
WireConnection;280;1;287;0
WireConnection;280;2;289;0
WireConnection;220;0;92;0
WireConnection;220;1;219;0
WireConnection;220;2;217;0
WireConnection;220;3;78;0
WireConnection;255;0;254;3
WireConnection;257;0;254;0
WireConnection;257;1;256;0
WireConnection;218;0;215;0
WireConnection;227;0;170;0
WireConnection;258;0;257;0
WireConnection;256;0;254;1
WireConnection;256;1;254;2
WireConnection;256;2;255;0
WireConnection;215;0;220;0
WireConnection;215;1;15;0
WireConnection;208;0;283;0
WireConnection;0;10;208;0
WireConnection;0;13;280;0
WireConnection;0;11;138;0
ASEEND*/
//CHKSM=6314734A10CC3B09EC1A3751CEDAFE679545166A