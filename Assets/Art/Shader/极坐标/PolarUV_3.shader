// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Whl/Test/PolarUV_3"
{
	Properties
	{
		[HDR]_EmissionColor("EmissionColor", Color) = (1,1,1,0)
		_MainTex("MainTex", 2D) = "white" {}
		[Toggle(_INVERT_U_ON)] _Invert_U("Invert_U", Float) = 0
		_Count("Count", Float) = 1
		_Panner("Panner", Float) = 0.2
		_Length("Length", Range( 0 , 1)) = 1
		_Smoothness("Smoothness", Range( 0 , 1)) = 0.08444577
		_Min_U("Min_U", Range( 0.51 , 1)) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" }
		Cull Off
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _INVERT_U_ON
		#pragma surface surf StandardCustomLighting keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float2 uv_texcoord;
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

		uniform float _Smoothness;
		uniform float _Length;
		uniform float _Min_U;
		uniform sampler2D _MainTex;
		uniform float _Panner;
		uniform float _Count;
		uniform float4 _EmissionColor;

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float2 temp_cast_0 = (0.5).xx;
			float2 temp_output_3_0 = ( i.uv_texcoord - temp_cast_0 );
			float2 temp_cast_1 = (_Length).xx;
			float smoothstepResult26 = smoothstep( 0.0 , _Smoothness , length( saturate( ( abs( temp_output_3_0 ) - temp_cast_1 ) ) ));
			float temp_output_29_0 = (0.0 + (( 1.0 - smoothstepResult26 ) - _Min_U) * (1.0 - 0.0) / (( 1.0 - _Min_U ) - _Min_U));
			float2 temp_cast_2 = (0.5).xx;
			float2 break5 = temp_output_3_0;
			#ifdef _INVERT_U_ON
				float staticSwitch46 = ( 1.0 - temp_output_29_0 );
			#else
				float staticSwitch46 = temp_output_29_0;
			#endif
			float2 appendResult14 = (float2(( ( (( atan2( break5.x , break5.y ) / UNITY_PI )*0.5 + 0.5) + frac( ( _Time.y * _Panner ) ) ) * _Count ) , staticSwitch46));
			float4 tex2DNode15 = tex2D( _MainTex, appendResult14 );
			c.rgb = ( (tex2DNode15).rgb * (_EmissionColor).rgb );
			c.a = ( saturate( ( ( ( 1.0 - temp_output_29_0 ) * temp_output_29_0 ) * 10.0 ) ) * tex2DNode15.r );
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
276;631;1700;1041;1812.652;175.3628;1;True;True
Node;AmplifyShaderEditor.RangedFloatNode;4;-1729.194,194.4348;Inherit;False;Constant;_Float0;Float 0;0;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-1825.194,33.43465;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;3;-1485.194,115.4348;Inherit;True;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-1328.481,-20.14239;Inherit;False;Property;_Length;Length;6;0;Create;True;0;0;0;False;0;False;1;0.549;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;48;-1146.076,-99.63231;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;49;-1008.498,-60.64225;Inherit;True;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;50;-765.3942,-110.8571;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;5;-483.1851,247.4573;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.LengthOpNode;12;-494.1113,-140.4218;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;51;-751.79,10.36044;Inherit;False;Property;_Smoothness;Smoothness;7;0;Create;True;0;0;0;False;0;False;0.08444577;0.549;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ATan2OpNode;7;-311.1851,248.4573;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PiNode;9;-356.1851,377.4572;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-399.1236,704.4196;Inherit;False;Property;_Panner;Panner;5;0;Create;True;0;0;0;False;0;False;0.2;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-404.9973,101.3097;Inherit;False;Property;_Min_U;Min_U;8;0;Create;True;0;0;0;False;0;False;1;0.882;0.51;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;21;-414.5239,630.571;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;26;-354.9407,-139.2769;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;31;-87.11798,120.0603;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-85.70871,521.0446;Inherit;False;Constant;_Float1;Float 1;0;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-125.3525,636.4026;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;8;-118.1852,300.4572;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;13;-81.37694,-131.1936;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;29;112.8964,-131.4754;Inherit;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;23;38.91917,637.6105;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;10;118.7124,318.1081;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;47;385.3591,207.786;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;25;450.0238,598.4659;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;45;447.549,715.2101;Inherit;False;Property;_Count;Count;4;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;32;490.7413,-171.981;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;46;552.5589,59.786;Inherit;False;Property;_Invert_U;Invert_U;3;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;44;721.2041,592.7653;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;722.2176,-148.6318;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;35;726.1025,-34.82187;Inherit;False;Constant;_Float2;Float 2;4;0;Create;True;0;0;0;False;0;False;10;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;14;1186.733,141.155;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;898.5775,-141.8185;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;15;1427.157,111.4316;Inherit;True;Property;_MainTex;MainTex;2;0;Create;True;0;0;0;False;0;False;-1;None;112a6ded82feb6e4c92aa13f3af147bf;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;40;1714.995,317.454;Inherit;False;Property;_EmissionColor;EmissionColor;1;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;0,3.190712,5.340313,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;36;1056.648,-140.222;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;42;1949.995,316.454;Inherit;False;FLOAT3;0;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode;38;1843.8,152.3415;Inherit;False;FLOAT3;0;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;1866.725,-122.6966;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;2151.59,164.2101;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2438.112,-73.39938;Float;False;True;-1;2;ASEMaterialInspector;0;0;CustomLighting;Whl/Test/PolarUV_3;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3;0;2;0
WireConnection;3;1;4;0
WireConnection;48;0;3;0
WireConnection;49;0;48;0
WireConnection;49;1;27;0
WireConnection;50;0;49;0
WireConnection;5;0;3;0
WireConnection;12;0;50;0
WireConnection;7;0;5;0
WireConnection;7;1;5;1
WireConnection;26;0;12;0
WireConnection;26;2;51;0
WireConnection;31;0;30;0
WireConnection;22;0;21;0
WireConnection;22;1;43;0
WireConnection;8;0;7;0
WireConnection;8;1;9;0
WireConnection;13;0;26;0
WireConnection;29;0;13;0
WireConnection;29;1;30;0
WireConnection;29;2;31;0
WireConnection;23;0;22;0
WireConnection;10;0;8;0
WireConnection;10;1;11;0
WireConnection;10;2;11;0
WireConnection;47;0;29;0
WireConnection;25;0;10;0
WireConnection;25;1;23;0
WireConnection;32;0;29;0
WireConnection;46;1;29;0
WireConnection;46;0;47;0
WireConnection;44;0;25;0
WireConnection;44;1;45;0
WireConnection;33;0;32;0
WireConnection;33;1;29;0
WireConnection;14;0;44;0
WireConnection;14;1;46;0
WireConnection;34;0;33;0
WireConnection;34;1;35;0
WireConnection;15;1;14;0
WireConnection;36;0;34;0
WireConnection;42;0;40;0
WireConnection;38;0;15;0
WireConnection;39;0;36;0
WireConnection;39;1;15;1
WireConnection;41;0;38;0
WireConnection;41;1;42;0
WireConnection;0;9;39;0
WireConnection;0;13;41;0
ASEEND*/
//CHKSM=1BE104563E000FEC6485F34E81FB85D496C3906A