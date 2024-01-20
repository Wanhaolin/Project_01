// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Whl/Fx/BlurGlow"
{
	Properties
	{
		[Toggle(_UV1_WCONTORLBLUR_ON)] _UV1_WContorlBlur("UV1_W ContorlBlur", Float) = 0
		_MainTex("MainTex", 2D) = "white" {}
		[HDR]_MainColor("MainColor", Color) = (1,1,1,1)
		_Blur("Blur", Range( 0 , 1)) = 0
		[Toggle(_UV1_TCONTORLDIS_ON)] _UV1_TContorlDis("UV1_T ContorlDis", Float) = 0
		_DisTex("DisTex", 2D) = "white" {}
		_DisTexPanner("DisTexPanner", Vector) = (0,0,1,0)
		_Invers("Invers", Range( 0 , 1)) = 0
		_Dis("Dis", Range( 0 , 1)) = 0
		_DisHardness("DisHardness", Range( 0 , 0.99)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" }
		Cull Off
		ZWrite Off
		ZTest Always
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _UV1_WCONTORLBLUR_ON
		#pragma shader_feature_local _UV1_TCONTORLDIS_ON
		#pragma surface surf StandardCustomLighting keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 uv_texcoord;
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

		uniform sampler2D _MainTex;
		uniform float _Blur;
		uniform sampler2D _DisTex;
		uniform float3 _DisTexPanner;
		uniform float4 _DisTex_ST;
		uniform float _Invers;
		uniform float _Dis;
		uniform float _DisHardness;
		uniform float4 _MainColor;

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float2 uvs_TexCoord5 = i.uv_texcoord;
			uvs_TexCoord5.xy = i.uv_texcoord.xy * float2( 0.5,0.5 ) + float2( 1,0.5 );
			float2 uvs_TexCoord9 = i.uv_texcoord;
			uvs_TexCoord9.xy = i.uv_texcoord.xy * float2( 0.5,0.5 ) + float2( 0.5,0.5 );
			#ifdef _UV1_WCONTORLBLUR_ON
				float staticSwitch19 = i.uv_texcoord.z;
			#else
				float staticSwitch19 = _Blur;
			#endif
			float Blur17 = staticSwitch19;
			float lerpResult12 = lerp( tex2D( _MainTex, uvs_TexCoord5.xy ).r , tex2D( _MainTex, uvs_TexCoord9.xy ).r , Blur17);
			float2 uvs_TexCoord10 = i.uv_texcoord;
			uvs_TexCoord10.xy = i.uv_texcoord.xy * float2( 0.5,0.5 ) + float2( 1,1 );
			float lerpResult13 = lerp( lerpResult12 , tex2D( _MainTex, uvs_TexCoord10.xy ).r , Blur17);
			float2 uvs_TexCoord11 = i.uv_texcoord;
			uvs_TexCoord11.xy = i.uv_texcoord.xy * float2( 0.5,0.5 ) + float2( 0.5,1 );
			float lerpResult14 = lerp( lerpResult13 , tex2D( _MainTex, uvs_TexCoord11.xy ).r , Blur17);
			float mulTime40 = _Time.y * _DisTexPanner.z;
			float2 appendResult39 = (float2(_DisTexPanner.x , _DisTexPanner.y));
			float4 uvs_DisTex = i.uv_texcoord;
			uvs_DisTex.xy = i.uv_texcoord.xy * _DisTex_ST.xy + _DisTex_ST.zw;
			float2 appendResult42 = (float2(i.uv2_texcoord2.x , i.uv2_texcoord2.y));
			float2 panner37 = ( mulTime40 * appendResult39 + ( uvs_DisTex.xy + appendResult42 ));
			float temp_output_3_0_g1 = tex2D( _DisTex, panner37 ).r;
			float lerpResult5_g1 = lerp( temp_output_3_0_g1 , ( 1.0 - temp_output_3_0_g1 ) , _Invers);
			#ifdef _UV1_TCONTORLDIS_ON
				float staticSwitch33 = i.uv_texcoord.w;
			#else
				float staticSwitch33 = _Dis;
			#endif
			float temp_output_8_0_g1 = _DisHardness;
			c.rgb = ( float4( (i.vertexColor).rgb , 0.0 ) * _MainColor ).rgb;
			c.a = ( ( lerpResult14 * i.vertexColor.a ) * saturate( ( ( ( ( lerpResult5_g1 + 1.0 ) - ( ( 1.0 - (-0.5 + (staticSwitch33 - 0.0) * (1.0 - -0.5) / (1.0 - 0.0)) ) * ( ( 1.0 - temp_output_8_0_g1 ) + 1.0 ) ) ) - temp_output_8_0_g1 ) / ( temp_output_8_0_g1 - 1.0 ) ) ) );
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
-1512;70;1464;802;1549.069;-1189.6;1.601024;True;True
Node;AmplifyShaderEditor.TextureCoordinatesNode;16;-429.0423,1580.698;Inherit;False;0;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;15;-473.2165,1457.853;Inherit;False;Property;_Blur;Blur;4;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;19;-155.983,1537.402;Inherit;False;Property;_UV1_WContorlBlur;UV1_W ContorlBlur;1;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;9;-565.6212,407.5441;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;0.5,0.5;False;1;FLOAT2;0.5,0.5;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;41;-988.769,1846.149;Inherit;False;1;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;17;134.1566,1532.056;Inherit;False;Blur;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;5;-563.5432,106.4642;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;0.5,0.5;False;1;FLOAT2;1,0.5;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;38;-670.9483,1978.457;Inherit;False;Property;_DisTexPanner;DisTexPanner;7;0;Create;True;0;0;0;False;0;False;0,0,1;-0.1,-1,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;2;-270.4861,383.9132;Inherit;True;Property;_glow_2;glow_2;2;0;Create;True;0;0;0;False;0;False;-1;37e5a417c7cd1e14fb8fbcd8c40804fa;37e5a417c7cd1e14fb8fbcd8c40804fa;True;0;False;white;Auto;False;Instance;1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-268.8,96.69998;Inherit;True;Property;_MainTex;MainTex;2;0;Create;True;0;0;0;False;0;False;-1;37e5a417c7cd1e14fb8fbcd8c40804fa;37e5a417c7cd1e14fb8fbcd8c40804fa;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;18;-154.2992,1081.642;Inherit;False;17;Blur;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;10;-550.4956,640.2769;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;0.5,0.5;False;1;FLOAT2;1,1;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;36;-733.2436,1734.34;Inherit;False;0;29;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;42;-734.1048,1870.061;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;3;-273.0862,633.5133;Inherit;True;Property;_TextureSample0;Texture Sample 0;2;0;Create;True;0;0;0;False;0;False;-1;37e5a417c7cd1e14fb8fbcd8c40804fa;37e5a417c7cd1e14fb8fbcd8c40804fa;True;0;False;white;Auto;False;Instance;1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;12;105.2366,389.713;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;43;-405.4785,1805.289;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;40;-424.7267,2093.86;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;11;-554.2919,895.1089;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;0.5,0.5;False;1;FLOAT2;0.5,1;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;39;-401.8198,1992.86;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;31;-105.6257,2026.912;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;13;299.2261,584.749;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-295.763,2177.276;Inherit;False;Property;_Dis;Dis;9;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;4;-273.0858,866.2133;Inherit;True;Property;_TextureSample1;Texture Sample 1;2;0;Create;True;0;0;0;False;0;False;-1;37e5a417c7cd1e14fb8fbcd8c40804fa;37e5a417c7cd1e14fb8fbcd8c40804fa;True;0;False;white;Auto;False;Instance;1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;37;-181.5522,1776.046;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;30;398.8833,1972.864;Inherit;False;Property;_Invers;Invers;8;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;22;462.9537,1222.62;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;29;374.0957,1753.382;Inherit;True;Property;_DisTex;DisTex;6;0;Create;True;0;0;0;False;0;False;-1;None;ecf5ddd689bf9984d8422de99b50f312;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;33;95.3367,2094.52;Inherit;False;Property;_UV1_TContorlDis;UV1_T ContorlDis;5;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;32;402.4958,2097.731;Inherit;False;Property;_DisHardness;DisHardness;10;0;Create;True;0;0;0;False;0;False;0;0.5;0;0.99;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;14;469.251,983.1222;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;747.3856,994.0188;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;28;981.2749,1941.187;Inherit;False;Dissolution;-1;;1;8ed0a8fdbfe80554382ce257577aff19;0;4;3;FLOAT;0;False;7;FLOAT;0;False;4;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;27;683.7178,1255.704;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;21;675.183,1352.368;Inherit;False;Property;_MainColor;MainColor;3;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;2,2,2,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;999.9832,1242.592;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;1308.219,1031.417;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1720.907,805.7537;Float;False;True;-1;2;ASEMaterialInspector;0;0;CustomLighting;Whl/Fx/BlurGlow;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;2;False;-1;7;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;19;1;15;0
WireConnection;19;0;16;3
WireConnection;17;0;19;0
WireConnection;2;1;9;0
WireConnection;1;1;5;0
WireConnection;42;0;41;1
WireConnection;42;1;41;2
WireConnection;3;1;10;0
WireConnection;12;0;1;1
WireConnection;12;1;2;1
WireConnection;12;2;18;0
WireConnection;43;0;36;0
WireConnection;43;1;42;0
WireConnection;40;0;38;3
WireConnection;39;0;38;1
WireConnection;39;1;38;2
WireConnection;31;0;16;4
WireConnection;13;0;12;0
WireConnection;13;1;3;1
WireConnection;13;2;18;0
WireConnection;4;1;11;0
WireConnection;37;0;43;0
WireConnection;37;2;39;0
WireConnection;37;1;40;0
WireConnection;29;1;37;0
WireConnection;33;1;34;0
WireConnection;33;0;31;0
WireConnection;14;0;13;0
WireConnection;14;1;4;1
WireConnection;14;2;18;0
WireConnection;23;0;14;0
WireConnection;23;1;22;4
WireConnection;28;3;29;1
WireConnection;28;7;30;0
WireConnection;28;4;33;0
WireConnection;28;8;32;0
WireConnection;27;0;22;0
WireConnection;24;0;27;0
WireConnection;24;1;21;0
WireConnection;35;0;23;0
WireConnection;35;1;28;0
WireConnection;0;9;35;0
WireConnection;0;13;24;0
ASEEND*/
//CHKSM=C66D1C89652B5D00AB9260D301C3A750835D8A77