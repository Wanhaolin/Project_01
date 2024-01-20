// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Whl/Test/Shield"
{
	Properties
	{
		_Fre("Fre", Vector) = (0,1,5,0)
		_MaskFre("MaskFre", Vector) = (0,1,5,0)
		[HDR]_Color1("Color1", Color) = (1,1,1,0)
		[HDR]_Color2("Color2", Color) = (0.509434,0.509434,0.509434,0)
		_EdgeWidth("EdgeWidth", Range( 0 , 1)) = 0
		_NoiseMap("NoiseMap", 2D) = "white" {}
		[Toggle(_USETEX_ON)] _UseTex("UseTex", Float) = 0
		_NoisePower("NoisePower", Float) = 5
		_NoiseScale("NoiseScale", Float) = 3
		_NoisePanner("NoisePanner", Vector) = (0,0,1,0)
		_VertexOffsetStr("VertexOffsetStr", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
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
		#pragma shader_feature_local _USETEX_ON
		#pragma surface surf StandardCustomLighting keepalpha noshadow vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
			float2 uv2_texcoord2;
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

		uniform float3 _NoisePanner;
		uniform float _NoiseScale;
		uniform sampler2D _NoiseMap;
		uniform float4 _NoiseMap_ST;
		uniform float _NoisePower;
		uniform float _VertexOffsetStr;
		uniform float3 _MaskFre;
		uniform float _EdgeWidth;
		uniform float3 _Fre;
		uniform float4 _Color1;
		uniform float4 _Color2;


		float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }

		float snoise( float2 v )
		{
			const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
			float2 i = floor( v + dot( v, C.yy ) );
			float2 x0 = v - i + dot( i, C.xx );
			float2 i1;
			i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
			float4 x12 = x0.xyxy + C.xxzz;
			x12.xy -= i1;
			i = mod2D289( i );
			float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
			float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
			m = m * m;
			m = m * m;
			float3 x = 2.0 * frac( p * C.www ) - 1.0;
			float3 h = abs( x ) - 0.5;
			float3 ox = floor( x + 0.5 );
			float3 a0 = x - ox;
			m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
			float3 g;
			g.x = a0.x * x0.x + h.x * x0.y;
			g.yz = a0.yz * x12.xz + h.yz * x12.yw;
			return 130.0 * dot( m, g );
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertexNormal = v.normal.xyz;
			float2 _Vector1 = float2(0,1);
			float mulTime28 = _Time.y * _NoisePanner.z;
			float2 appendResult27 = (float2(_NoisePanner.x , _NoisePanner.y));
			float2 panner25 = ( mulTime28 * appendResult27 + v.texcoord1.xy);
			float simplePerlin2D34 = snoise( panner25*_NoiseScale );
			simplePerlin2D34 = simplePerlin2D34*0.5 + 0.5;
			float2 uv2_NoiseMap = v.texcoord1.xy * _NoiseMap_ST.xy + _NoiseMap_ST.zw;
			float2 panner69 = ( mulTime28 * appendResult27 + uv2_NoiseMap);
			#ifdef _USETEX_ON
				float staticSwitch68 = tex2Dlod( _NoiseMap, float4( panner69, 0, 0.0) ).r;
			#else
				float staticSwitch68 = simplePerlin2D34;
			#endif
			float smoothstepResult52 = smoothstep( _Vector1.x , _Vector1.y , staticSwitch68);
			float Noise43 = pow( smoothstepResult52 , _NoisePower );
			v.vertex.xyz += ( ase_vertexNormal * Noise43 * 0.01 * _VertexOffsetStr );
			v.vertex.w = 1;
		}

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float2 temp_output_9_0 = ( i.uv_texcoord + float2( 0,0.06 ) );
			float2 appendResult11 = (float2(1.16 , 0.955));
			float2 _Vector1 = float2(0,1);
			float mulTime28 = _Time.y * _NoisePanner.z;
			float2 appendResult27 = (float2(_NoisePanner.x , _NoisePanner.y));
			float2 panner25 = ( mulTime28 * appendResult27 + i.uv2_texcoord2);
			float simplePerlin2D34 = snoise( panner25*_NoiseScale );
			simplePerlin2D34 = simplePerlin2D34*0.5 + 0.5;
			float2 uv2_NoiseMap = i.uv2_texcoord2 * _NoiseMap_ST.xy + _NoiseMap_ST.zw;
			float2 panner69 = ( mulTime28 * appendResult27 + uv2_NoiseMap);
			#ifdef _USETEX_ON
				float staticSwitch68 = tex2D( _NoiseMap, panner69 ).r;
			#else
				float staticSwitch68 = simplePerlin2D34;
			#endif
			float smoothstepResult52 = smoothstep( _Vector1.x , _Vector1.y , staticSwitch68);
			float Noise43 = pow( smoothstepResult52 , _NoisePower );
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float3 switchResult73 = (((i.ASEVFace>0)?(ase_worldNormal):(-ase_worldNormal)));
			float fresnelNdotV75 = dot( switchResult73, ase_worldViewDir );
			float fresnelNode75 = ( _MaskFre.x + _MaskFre.y * pow( 1.0 - fresnelNdotV75, _MaskFre.z ) );
			float2 temp_output_31_0 = ( appendResult11 * Noise43 * fresnelNode75 );
			float2 break32 = temp_output_31_0;
			float temp_output_2_0_g1 = 3.0;
			float cosSides12_g1 = cos( ( UNITY_PI / temp_output_2_0_g1 ) );
			float2 appendResult18_g1 = (float2(( break32.x * cosSides12_g1 ) , ( break32.y * cosSides12_g1 )));
			float2 break23_g1 = ( (temp_output_9_0*2.0 + -1.0) / appendResult18_g1 );
			float polarCoords30_g1 = atan2( break23_g1.x , -break23_g1.y );
			float temp_output_52_0_g1 = ( 6.28318548202515 / temp_output_2_0_g1 );
			float2 appendResult25_g1 = (float2(break23_g1.x , -break23_g1.y));
			float2 finalUVs29_g1 = appendResult25_g1;
			float temp_output_44_0_g1 = ( cos( ( ( floor( ( 0.5 + ( polarCoords30_g1 / temp_output_52_0_g1 ) ) ) * temp_output_52_0_g1 ) - polarCoords30_g1 ) ) * length( finalUVs29_g1 ) );
			float temp_output_2_0 = saturate( ( ( 1.0 - temp_output_44_0_g1 ) / fwidth( temp_output_44_0_g1 ) ) );
			float2 temp_cast_0 = (_EdgeWidth).xx;
			float2 break17 = saturate( ( temp_output_31_0 - temp_cast_0 ) );
			float temp_output_2_0_g2 = 3.0;
			float cosSides12_g2 = cos( ( UNITY_PI / temp_output_2_0_g2 ) );
			float2 appendResult18_g2 = (float2(( break17.x * cosSides12_g2 ) , ( break17.y * cosSides12_g2 )));
			float2 break23_g2 = ( (temp_output_9_0*2.0 + -1.0) / appendResult18_g2 );
			float polarCoords30_g2 = atan2( break23_g2.x , -break23_g2.y );
			float temp_output_52_0_g2 = ( 6.28318548202515 / temp_output_2_0_g2 );
			float2 appendResult25_g2 = (float2(break23_g2.x , -break23_g2.y));
			float2 finalUVs29_g2 = appendResult25_g2;
			float temp_output_44_0_g2 = ( cos( ( ( floor( ( 0.5 + ( polarCoords30_g2 / temp_output_52_0_g2 ) ) ) * temp_output_52_0_g2 ) - polarCoords30_g2 ) ) * length( finalUVs29_g2 ) );
			float3 switchResult61 = (((i.ASEVFace>0)?(ase_worldNormal):(-ase_worldNormal)));
			float fresnelNdotV55 = dot( switchResult61, ase_worldViewDir );
			float fresnelNode55 = ( _Fre.x + _Fre.y * pow( 1.0 - fresnelNdotV55, _Fre.z ) );
			float temp_output_58_0 = saturate( ( ( temp_output_2_0 - saturate( ( ( 1.0 - temp_output_44_0_g2 ) / fwidth( temp_output_44_0_g2 ) ) ) ) + ( fresnelNode55 * ( 1.0 - ( Noise43 * 1.0 ) ) ) ) );
			float4 switchResult38 = (((i.ASEVFace>0)?(( temp_output_58_0 * _Color1 )):(( temp_output_58_0 * _Color2 ))));
			c.rgb = switchResult38.rgb;
			c.a = temp_output_58_0;
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
226;616;1700;1063;4239.495;-527.8391;1.712163;True;True
Node;AmplifyShaderEditor.Vector3Node;26;-4849.027,876.4983;Inherit;False;Property;_NoisePanner;NoisePanner;11;0;Create;True;0;0;0;False;0;False;0,0,1;0,0.3,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;27;-4614.695,875.3589;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;70;-4761.582,1104.223;Inherit;False;1;67;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;24;-4791.976,726.8622;Inherit;False;1;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;28;-4631.696,978.359;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;69;-4338.582,1134.223;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;25;-4347.738,833.2433;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-4318.695,974.359;Inherit;False;Property;_NoiseScale;NoiseScale;10;0;Create;True;0;0;0;False;0;False;3;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;67;-4103.996,1057.85;Inherit;True;Property;_NoiseMap;NoiseMap;7;0;Create;True;0;0;0;False;0;False;-1;None;d5ae13cce4f088e4d9f1cb804bdcb758;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NoiseGeneratorNode;34;-4048.909,885.689;Inherit;False;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;54;-3856.817,1249.015;Inherit;False;Constant;_Vector1;Vector 1;9;0;Create;True;0;0;0;False;0;False;0,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.StaticSwitch;68;-3772.996,937.8499;Inherit;False;Property;_UseTex;UseTex;8;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-3662.921,1317.392;Inherit;False;Property;_NoisePower;NoisePower;9;0;Create;True;0;0;0;False;0;False;5;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;52;-3577.417,1017.915;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;71;-3309.904,1417.507;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.PowerNode;33;-3406.444,1059.442;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;72;-3111.904,1564.507;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;43;-3085.155,1055.258;Inherit;False;Noise;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-2900.504,813.143;Inherit;False;Constant;_Float7;Float 7;2;0;Create;True;0;0;0;False;0;False;1.16;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-2903.675,900.2552;Inherit;False;Constant;_Float8;Float 8;2;0;Create;True;0;0;0;False;0;False;0.955;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SwitchByFaceNode;73;-2986.904,1448.507;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;74;-2944.167,1615.257;Inherit;False;Property;_MaskFre;MaskFre;2;0;Create;True;0;0;0;False;0;False;0,1,5;0,0.48,1.5;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.FresnelNode;75;-2709.665,1542.061;Inherit;True;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;11;-2633.562,858.8877;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;44;-2664.609,963.1887;Inherit;False;43;Noise;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-2454.011,899.9187;Inherit;False;3;3;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-2586.237,1056.1;Inherit;False;Property;_EdgeWidth;EdgeWidth;6;0;Create;True;0;0;0;False;0;False;0;0.216;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;60;-2410.23,1301.668;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleSubtractOpNode;15;-2159.532,951.8102;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;20;-1917.476,498.1599;Inherit;False;Constant;_Vector0;Vector 0;2;0;Create;True;0;0;0;False;0;False;0,0.06;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;64;-1625.913,1648.33;Inherit;False;43;Noise;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;21;-1997.901,950.64;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-1955.646,367.2786;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NegateNode;62;-2212.23,1448.668;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;56;-2044.493,1499.418;Inherit;False;Property;_Fre;Fre;1;0;Create;True;0;0;0;False;0;False;0,1,5;0,0.48,1.5;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SwitchByFaceNode;61;-2087.23,1332.668;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;9;-1602.673,414.6965;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0.055;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;32;-2086.553,628.5421;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;4;-1712.747,767.8783;Inherit;False;Constant;_Float6;Float 6;2;0;Create;True;0;0;0;False;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;65;-1423.913,1652.33;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;17;-1748.268,954.3196;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.FresnelNode;55;-1809.991,1426.222;Inherit;True;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;66;-1250.913,1651.33;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2;-1389.913,580.1616;Inherit;True;Polygon;-1;;1;6906ef7087298c94c853d6753e182169;0;4;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;14;-1373.757,880.7789;Inherit;True;Polygon;-1;;2;6906ef7087298c94c853d6753e182169;0;4;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;63;-1077.913,1480.33;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;18;-1056.076,742.3912;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;57;-773.7981,802.8643;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;41;-912.6218,966.0658;Inherit;False;Property;_Color1;Color1;3;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;5.807997,0,0.5097318,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;42;-912.6218,1152.066;Inherit;False;Property;_Color2;Color2;4;1;[HDR];Create;True;0;0;0;False;0;False;0.509434,0.509434,0.509434,0;0.3515486,0.5405064,0.9433963,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;58;-625.4153,799.3725;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;49;-433.2975,1899.001;Inherit;False;Property;_VertexOffsetStr;VertexOffsetStr;12;0;Create;True;0;0;0;False;0;False;1;-5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;45;-435.161,1548.356;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;47;-459.2974,1706.001;Inherit;False;43;Noise;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;-400.8533,1048.887;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-402.2975,1800.001;Inherit;False;Constant;_Float9;Float 9;8;0;Create;True;0;0;0;False;0;False;0.01;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;-416.1148,921.3528;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;22;-961.8594,373.2493;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;-41.34398,1679.624;Inherit;False;4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;1;-1402.23,277.8348;Inherit;True;Property;_Mask_1;Mask_1;5;0;Create;True;0;0;0;False;0;False;-1;3a847961b3207fd438b5497eadf18b42;3a847961b3207fd438b5497eadf18b42;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.AbsOpNode;23;-687.0757,356.5758;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwitchByFaceNode;38;-226.2725,871.1506;Inherit;False;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;231.6548,624.4531;Float;False;True;-1;2;ASEMaterialInspector;0;0;CustomLighting;Whl/Test/Shield;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;27;0;26;1
WireConnection;27;1;26;2
WireConnection;28;0;26;3
WireConnection;69;0;70;0
WireConnection;69;2;27;0
WireConnection;69;1;28;0
WireConnection;25;0;24;0
WireConnection;25;2;27;0
WireConnection;25;1;28;0
WireConnection;67;1;69;0
WireConnection;34;0;25;0
WireConnection;34;1;30;0
WireConnection;68;1;34;0
WireConnection;68;0;67;1
WireConnection;52;0;68;0
WireConnection;52;1;54;1
WireConnection;52;2;54;2
WireConnection;33;0;52;0
WireConnection;33;1;35;0
WireConnection;72;0;71;0
WireConnection;43;0;33;0
WireConnection;73;0;71;0
WireConnection;73;1;72;0
WireConnection;75;0;73;0
WireConnection;75;1;74;1
WireConnection;75;2;74;2
WireConnection;75;3;74;3
WireConnection;11;0;5;0
WireConnection;11;1;6;0
WireConnection;31;0;11;0
WireConnection;31;1;44;0
WireConnection;31;2;75;0
WireConnection;15;0;31;0
WireConnection;15;1;13;0
WireConnection;21;0;15;0
WireConnection;62;0;60;0
WireConnection;61;0;60;0
WireConnection;61;1;62;0
WireConnection;9;0;3;0
WireConnection;9;1;20;0
WireConnection;32;0;31;0
WireConnection;65;0;64;0
WireConnection;17;0;21;0
WireConnection;55;0;61;0
WireConnection;55;1;56;1
WireConnection;55;2;56;2
WireConnection;55;3;56;3
WireConnection;66;0;65;0
WireConnection;2;1;9;0
WireConnection;2;2;4;0
WireConnection;2;3;32;0
WireConnection;2;4;32;1
WireConnection;14;1;9;0
WireConnection;14;2;4;0
WireConnection;14;3;17;0
WireConnection;14;4;17;1
WireConnection;63;0;55;0
WireConnection;63;1;66;0
WireConnection;18;0;2;0
WireConnection;18;1;14;0
WireConnection;57;0;18;0
WireConnection;57;1;63;0
WireConnection;58;0;57;0
WireConnection;39;0;58;0
WireConnection;39;1;42;0
WireConnection;40;0;58;0
WireConnection;40;1;41;0
WireConnection;22;0;1;1
WireConnection;22;1;2;0
WireConnection;46;0;45;0
WireConnection;46;1;47;0
WireConnection;46;2;48;0
WireConnection;46;3;49;0
WireConnection;23;0;22;0
WireConnection;38;0;40;0
WireConnection;38;1;39;0
WireConnection;0;9;58;0
WireConnection;0;13;38;0
WireConnection;0;11;46;0
ASEEND*/
//CHKSM=4F132147B5E62C0F5D94551394F45BA3BC0871A6