// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Whl/Viv/Shining Cross"
{
	Properties
	{
		_MainColor("MainColor", Color) = (0,0,0,0)
		_ColorScale("ColorScale", Float) = 1
		[Toggle(_UV1_WTCONTORLCHANGE_ON)] _UV1_WTContorlChange("UV1_WTContorlChange", Float) = 0
		_Change1("Change1", Float) = 0.52
		_Change2("Change2", Float) = 0
		_MainTex("MainTex", 2D) = "white" {}
		[KeywordEnum(R,G,B,A)] _MainTexChannel("MainTexChannel", Float) = 0
		_RampTex("RampTex", 2D) = "white" {}
		[Enum(UnityEngine.Rendering.CompareFunction)]_ZTestMode("ZTestMode", Float) = 8
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" }
		Cull Back
		ZWrite Off
		ZTest [_ZTestMode]
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _MAINTEXCHANNEL_R _MAINTEXCHANNEL_G _MAINTEXCHANNEL_B _MAINTEXCHANNEL_A
		#pragma shader_feature_local _UV1_WTCONTORLCHANGE_ON
		#pragma surface surf StandardCustomLighting keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
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
		uniform sampler2D _MainTex;
		uniform float _Change1;
		uniform float _Change2;
		uniform float4 _MainColor;
		uniform float _ColorScale;
		uniform sampler2D _RampTex;

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float2 temp_cast_0 = (0.5).xx;
			float2 appendResult86 = (float2(_Change1 , _Change2));
			float2 appendResult79 = (float2(i.uv_texcoord.z , i.uv_texcoord.w));
			#ifdef _UV1_WTCONTORLCHANGE_ON
				float2 staticSwitch64 = appendResult79;
			#else
				float2 staticSwitch64 = appendResult86;
			#endif
			float2 UV1_WT65 = staticSwitch64;
			float2 CrossUV89 = ( i.uv_texcoord.xy + ( ( i.uv_texcoord.xy - temp_cast_0 ) * (-70.0 + (UV1_WT65.y - 0.0) * (25.0 - -70.0) / (1.0 - 0.0)) * saturate( ( ( 1.0 - distance( i.uv_texcoord.xy , float2( 0.5,0.5 ) ) ) - UV1_WT65.x ) ) ) );
			float4 tex2DNode7 = tex2D( _MainTex, CrossUV89 );
			#if defined(_MAINTEXCHANNEL_R)
				float staticSwitch94 = tex2DNode7.r;
			#elif defined(_MAINTEXCHANNEL_G)
				float staticSwitch94 = tex2DNode7.g;
			#elif defined(_MAINTEXCHANNEL_B)
				float staticSwitch94 = tex2DNode7.b;
			#elif defined(_MAINTEXCHANNEL_A)
				float staticSwitch94 = tex2DNode7.a;
			#else
				float staticSwitch94 = tex2DNode7.r;
			#endif
			float MainColor91 = staticSwitch94;
			float VertexColorA72 = i.vertexColor.a;
			float2 temp_cast_1 = (MainColor91).xx;
			float4 VertexColorRGB73 = i.vertexColor;
			c.rgb = ( _MainColor * _ColorScale * tex2D( _RampTex, temp_cast_1 ) * VertexColorRGB73 ).rgb;
			c.a = ( MainColor91 * VertexColorA72 );
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
253.3333;293.3333;1719.333;1039;2184.128;1097.381;1.784076;True;True
Node;AmplifyShaderEditor.CommentaryNode;68;-1987.532,1135.042;Inherit;False;1365.134;444.5488;Comment;7;79;62;65;64;86;50;41;UV1;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;41;-1605.993,1178.355;Inherit;False;Property;_Change1;Change1;4;0;Create;True;0;0;0;False;0;False;0.52;0.49;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;62;-1958.505,1295.837;Inherit;True;0;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;50;-1609.097,1263.028;Inherit;False;Property;_Change2;Change2;5;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;79;-1613.753,1360.143;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;86;-1283.932,1210.801;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;88;-3923.526,-529.8466;Inherit;False;2442.514;1285.446;Comment;18;42;40;38;52;54;39;83;49;37;51;85;70;84;46;48;44;43;89;;1,1,1,1;0;0
Node;AmplifyShaderEditor.StaticSwitch;64;-1136.183,1261.38;Inherit;False;Property;_UV1_WTContorlChange;UV1_WTContorlChange;3;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;65;-832.401,1267.074;Inherit;False;UV1_WT;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;48;-3834.467,351.0299;Inherit;False;Constant;_Vector0;Vector 0;4;0;Create;True;0;0;0;False;0;False;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;44;-3873.526,183.5181;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DistanceOpNode;46;-3547.467,243.5612;Inherit;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;84;-3494.122,556.8405;Inherit;False;65;UV1_WT;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;51;-3291.024,242.8377;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;85;-3290.002,561.0957;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.GetLocalVarNode;70;-3498.107,-29.7483;Inherit;False;65;UV1_WT;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;83;-3293.988,-25.49311;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleSubtractOpNode;49;-3073.702,261.6459;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;37;-3301.683,-479.8466;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;39;-3257.166,-167.2144;Inherit;False;Constant;_Float0;Float 0;2;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;54;-3021.064,-1.946969;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-70;False;4;FLOAT;25;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;52;-2841.425,262.5696;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;38;-2975.219,-181.6358;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;-2578.954,-199.5664;Inherit;True;3;3;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;42;-2222.729,-257.9664;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;89;-2049.292,-260.1321;Inherit;False;CrossUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;90;-1285.618,-478.4456;Inherit;False;89;CrossUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;7;-1075.519,-501.8702;Inherit;True;Property;_MainTex;MainTex;6;0;Create;True;0;0;0;False;0;False;-1;f9f85f52c5ad25c48955458e0c2ad9a8;6318fd17177eacc4ab840b67eaf1fcba;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;94;-732.2555,-479.1039;Inherit;False;Property;_MainTexChannel;MainTexChannel;7;0;Create;True;0;0;0;False;0;False;0;0;0;True;;KeywordEnum;4;R;G;B;A;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;74;-333.1693,1101.437;Inherit;False;498.0005;281.3341;VertexColor;3;73;72;71;VertexColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;91;-440.1138,-480.5237;Inherit;False;MainColor;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;71;-283.1693,1151.437;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;73;-66.1687,1160.343;Inherit;False;VertexColorRGB;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;72;-64.4939,1266.771;Inherit;False;VertexColorA;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;92;-18.41992,14.93146;Inherit;False;91;MainColor;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;76;400.4691,607.1586;Inherit;False;72;VertexColorA;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;93;418.9102,518.873;Inherit;False;91;MainColor;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;59;318.5189,-91.63905;Inherit;False;Property;_ColorScale;ColorScale;2;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;78;267.5849,-281.1708;Inherit;False;Property;_MainColor;MainColor;1;0;Create;True;0;0;0;False;0;False;0,0,0,0;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;75;214.9511,206.072;Inherit;False;73;VertexColorRGB;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;61;178.068,-1.726269;Inherit;True;Property;_RampTex;RampTex;8;0;Create;True;0;0;0;False;0;False;-1;None;fde817294a5b8bc45820eac6b2d6db88;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;57;729.9222,-105.8846;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;58;659.3782,524.4141;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-3822.15,-71.40237;Inherit;False;Property;_ZTestMode;ZTestMode;9;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CompareFunction;True;0;False;8;8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1357.306,-23.56844;Float;False;True;-1;2;ASEMaterialInspector;0;0;CustomLighting;Whl/Viv/Shining Cross;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;True;43;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;79;0;62;3
WireConnection;79;1;62;4
WireConnection;86;0;41;0
WireConnection;86;1;50;0
WireConnection;64;1;86;0
WireConnection;64;0;79;0
WireConnection;65;0;64;0
WireConnection;46;0;44;0
WireConnection;46;1;48;0
WireConnection;51;0;46;0
WireConnection;85;0;84;0
WireConnection;83;0;70;0
WireConnection;49;0;51;0
WireConnection;49;1;85;0
WireConnection;54;0;83;1
WireConnection;52;0;49;0
WireConnection;38;0;37;0
WireConnection;38;1;39;0
WireConnection;40;0;38;0
WireConnection;40;1;54;0
WireConnection;40;2;52;0
WireConnection;42;0;37;0
WireConnection;42;1;40;0
WireConnection;89;0;42;0
WireConnection;7;1;90;0
WireConnection;94;1;7;1
WireConnection;94;0;7;2
WireConnection;94;2;7;3
WireConnection;94;3;7;4
WireConnection;91;0;94;0
WireConnection;73;0;71;0
WireConnection;72;0;71;4
WireConnection;61;1;92;0
WireConnection;57;0;78;0
WireConnection;57;1;59;0
WireConnection;57;2;61;0
WireConnection;57;3;75;0
WireConnection;58;0;93;0
WireConnection;58;1;76;0
WireConnection;0;9;58;0
WireConnection;0;13;57;0
ASEEND*/
//CHKSM=08A885C1C3002F55D26094AC023B588166E811FE