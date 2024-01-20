// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "GameEffect/ChushouUV"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0
		_Float0("形变位置", Range( -1 , 1)) = 0
		[Normal]_Normal("法线贴图", 2D) = "bump" {}
		_Float3("法线强度", Float) = 1
		_3sTexture("3STexture", 2D) = "white" {}
		HighLightPower("高光强度", Float) = 0.3
		_Color0("主体颜色", Color) = (1,1,1,1)
		[HDR]_Color1("渐变颜色", Color) = (1,0.6199594,0,0)
		_Float8("渐变软硬", Float) = 1
		_Float7("渐变位置", Float) = 0
		_BloodScale("BloodScale", Float) = 0.2
		[HDR]_Color2("BloodColor", Color) = (0,0,0,0)
		_Float1("触手位置", Float) = 0
		_Float9("触手软硬", Float) = 0
		_Float10("触手大小", Float) = 0
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "AlphaTest+0" }
		Cull Back
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma surface surf StandardCustomLighting keepalpha noshadow vertex:vertexDataFunc 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 uv_tex4coord;
			float2 uv_texcoord;
			float3 worldNormal;
			INTERNAL_DATA
			float3 worldPos;
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

		uniform float _Float1;
		uniform float _Float9;
		uniform float _Float10;
		uniform float _Float0;
		uniform float _BloodScale;
		uniform sampler2D _3sTexture;
		uniform sampler2D _Normal;
		uniform float4 _Normal_ST;
		uniform float _Float3;
		uniform float4 _Color0;
		uniform float HighLightPower;
		uniform float4 _Color1;
		uniform float _Float7;
		uniform float _Float8;
		uniform float4 _Color2;
		uniform float _Cutoff = 0;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float2 temp_cast_0 = (v.texcoord.z).xx;
			float2 uv_TexCoord1 = v.texcoord.xy + temp_cast_0;
			float smoothstepResult76 = smoothstep( _Float1 , ( _Float1 + _Float9 ) , uv_TexCoord1.y);
			float3 ase_vertexNormal = v.normal.xyz;
			float mulTime61 = _Time.y * v.texcoord.w;
			float2 temp_cast_1 = ((-1.0 + (frac( mulTime61 ) - 0.0) * (1.0 - -1.0) / (1.0 - 0.0))).xx;
			float2 uv_TexCoord63 = v.texcoord.xy + temp_cast_1;
			float smoothstepResult67 = smoothstep( _BloodScale , ( _BloodScale + 0.2 ) , ( uv_TexCoord63.y * ( 1.0 - uv_TexCoord63.y ) ));
			float temp_output_71_0 = saturate( smoothstepResult67 );
			v.vertex.xyz += ( ( ( smoothstepResult76 - _Float10 ) * ase_vertexNormal * _Float0 ) + ( ase_vertexNormal * temp_output_71_0 ) );
			v.vertex.w = 1;
		}

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float2 temp_cast_0 = (i.uv_tex4coord.z).xx;
			float2 uv_TexCoord1 = i.uv_texcoord + temp_cast_0;
			float2 uv_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			float2 appendResult48 = (float2(0.0 , i.uv_tex4coord.z));
			float3 tex2DNode21 = UnpackScaleNormal( tex2D( _Normal, ( uv_Normal + appendResult48 ) ), _Float3 );
			float3 newWorldNormal29 = (WorldNormalVector( i , tex2DNode21 ));
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float dotResult33 = dot( newWorldNormal29 , ase_worldViewDir );
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float dotResult32 = dot( ase_worldlightDir , newWorldNormal29 );
			float2 appendResult36 = (float2(( dotResult33 * 0.86 ) , (dotResult32*0.01 + 0.23)));
			float3 newWorldNormal12 = (WorldNormalVector( i , tex2DNode21 ));
			float dotResult13 = dot( ase_worldlightDir , newWorldNormal12 );
			float dotResult19 = dot( ( ( dotResult13 * newWorldNormal12 * 2.0 ) - ase_worldlightDir ) , ase_worldViewDir );
			float smoothstepResult56 = smoothstep( _Float7 , ( _Float7 + _Float8 ) , saturate( uv_TexCoord1.y ));
			float mulTime61 = _Time.y * i.uv_tex4coord.w;
			float2 temp_cast_1 = ((-1.0 + (frac( mulTime61 ) - 0.0) * (1.0 - -1.0) / (1.0 - 0.0))).xx;
			float2 uv_TexCoord63 = i.uv_texcoord + temp_cast_1;
			float smoothstepResult67 = smoothstep( _BloodScale , ( _BloodScale + 0.2 ) , ( uv_TexCoord63.y * ( 1.0 - uv_TexCoord63.y ) ));
			float temp_output_71_0 = saturate( smoothstepResult67 );
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			c.rgb = ( ( ( tex2D( _3sTexture, appendResult36 ) * _Color0 ) + pow( saturate( dotResult19 ) , HighLightPower ) + ( _Color1 * smoothstepResult56 ) + ( _Color2 * temp_output_71_0 ) ) * ase_lightColor ).rgb;
			c.a = 1;
			clip( ( 1.0 - uv_TexCoord1.y ) - _Cutoff );
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
Version=18910
51;605;2036;1200;834.5044;1731.654;1;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;59;-2481.016,-567.7503;Inherit;False;0;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;47;-2138.995,-745.5828;Inherit;False;0;21;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;48;-1966.198,-557.3785;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-1724.781,-593.188;Inherit;False;Property;_Float3;法线强度;3;0;Create;False;0;0;0;False;0;False;1;0.3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;49;-1810.058,-744.663;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;61;-1723.364,375.9631;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;62;-1507.565,377.2632;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;10;-1064.932,-986.7078;Inherit;False;885.381;559.7994;Comment;6;17;15;16;13;12;14;R=2*(-Normal Dot LightDir)*Normal-LightDir;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;21;-1499.209,-773.149;Inherit;True;Property;_Normal;法线贴图;2;1;[Normal];Create;False;0;0;0;False;0;False;21;e8aeda4dcd4ca9c42b9320291d19bb14;2549a0d985ac5044d92b3db3a58e6094;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldNormalVector;12;-1043.293,-765.1327;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;14;-1053.524,-909.2907;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TFHCRemapNode;66;-1344.444,375.7712;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-1;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-977.0871,-605.8303;Inherit;False;Constant;_Float2;Float 2;3;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;13;-764.8928,-838.8328;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;63;-1140.661,324.3659;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;34;-1009.148,-1174.418;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;29;-1017.148,-1330.418;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;28;-1022.116,-1527.81;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;40;-592.0803,-1220.993;Inherit;False;Constant;_Float6;Float 6;6;0;Create;True;0;0;0;False;0;False;0.86;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;38;-576.6802,-1448.192;Inherit;False;Constant;_Float4;Float 4;6;0;Create;True;0;0;0;False;0;False;0.01;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-579.4779,-792.9221;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;64;-916.6606,424.7662;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;68;-523.1155,430.8456;Inherit;False;Property;_BloodScale;BloodScale;10;0;Create;True;0;0;0;False;0;False;0.2;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;39;-575.6802,-1389.192;Inherit;False;Constant;_Float5;Float 5;6;0;Create;True;0;0;0;False;0;False;0.23;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;32;-713.1847,-1505.4;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;33;-698.1484,-1290.418;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;69;-517.1154,537.8457;Inherit;False;Constant;_BloodSoft;BloodSoft;11;0;Create;True;0;0;0;False;0;False;0.2;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;70;-348.1154,520.8456;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;78;-1027.385,-76.03755;Inherit;False;Property;_Float1;触手位置;12;0;Create;False;0;0;0;False;0;False;0;-0.3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;20;-336.1362,-411.5076;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-1113.929,-324.4503;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;17;-385.8475,-931.6924;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;53;-50.31081,-93.84679;Inherit;False;Property;_Float7;渐变位置;9;0;Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;79;-1037.891,50.47802;Inherit;False;Property;_Float9;触手软硬;13;0;Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;54;-50.27939,-7.49247;Inherit;False;Property;_Float8;渐变软硬;8;0;Create;False;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;-403.4093,-1288.412;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.8;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;35;-406.9344,-1501.3;Inherit;False;3;0;FLOAT;0.3;False;1;FLOAT;0.3;False;2;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;65;-707.7605,372.5657;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;50;-205.8459,-199.2752;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;19;-97.13625,-817.5077;Inherit;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;67;-193.1155,375.8456;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;55;134.9807,-49.55533;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;36;-187.2799,-1372.032;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;77;-848.8874,-17.77803;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;81;-670.2455,39.35806;Inherit;False;Property;_Float10;触手大小;14;0;Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;41;114.2955,-1401.785;Inherit;True;Property;_3sTexture;3STexture;4;0;Create;False;0;0;0;False;0;False;-1;None;0c339500b5351b8428ae5bc191e2fed9;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SmoothstepOpNode;56;244.5564,-197.5395;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;43;170.076,-1002.612;Inherit;False;Property;_Color0;主体颜色;6;0;Create;False;0;0;0;False;0;False;1,1,1,1;0.6037736,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;24;-69.32513,-500.5854;Inherit;False;Property;HighLightPower;高光强度;5;0;Create;False;0;0;0;False;0;False;0.3;32.79;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;57;128.1831,-711.0282;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;71;103.2574,362.5966;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;75;548.3505,-42.98962;Inherit;False;Property;_Color2;BloodColor;11;1;[HDR];Create;False;0;0;0;False;0;False;0,0,0,0;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SmoothstepOpNode;76;-710.1229,-93.05493;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;51;-4.907349,-270.5739;Inherit;False;Property;_Color1;渐变颜色;7;1;[HDR];Create;False;0;0;0;False;0;False;1,0.6199594,0,0;0,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;407.0927,-269.5739;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;74;845.3792,104.8323;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;23;309.4096,-712.6646;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;2;-823.4662,69.83877;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;5;-808.0018,227.1145;Inherit;False;Property;_Float0;形变位置;1;0;Create;False;0;0;0;False;0;False;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;80;-528.2455,3.358063;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;480.0759,-1021.602;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;44;630.8126,-663.416;Inherit;True;4;4;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;73;299.0393,290.4181;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LightColorNode;26;691.023,-400.3829;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-379.9695,34.81331;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;83;-528.7609,-1736.574;Inherit;False;Property;_Float11;Float 0;16;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;89;58.55344,-1637.233;Inherit;True;Property;_TextureSample0;Texture Sample 0;15;0;Create;True;0;0;0;False;0;False;89;None;eea07c4a3bb09bf4ab03e097e2495bcf;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;86;-351.2175,-1700.574;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;84;-532.761,-1629.574;Inherit;False;Property;_Float12;Float 1;17;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;87;-133.9211,-1796.593;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;8;68.79498,-342.2602;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;72;464.1059,152.6758;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;60;-2268.077,-535.1039;Inherit;False;Constant;_Contal;Contal;3;0;Create;True;0;0;0;False;0;False;0;-0.47;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;887.8107,-425.9657;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;85;-425.8783,-1876.397;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;91;-148.4352,-1551.797;Inherit;False;Constant;_Float13;Float 13;18;0;Create;True;0;0;0;False;0;False;0.4;0.63;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1216.351,-555.2798;Float;False;True;-1;2;ASEMaterialInspector;0;0;CustomLighting;GameEffect/ChushouUV;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0;True;False;0;True;Opaque;;AlphaTest;All;16;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;48;1;59;3
WireConnection;49;0;47;0
WireConnection;49;1;48;0
WireConnection;61;0;59;4
WireConnection;62;0;61;0
WireConnection;21;1;49;0
WireConnection;21;5;22;0
WireConnection;12;0;21;0
WireConnection;66;0;62;0
WireConnection;13;0;14;0
WireConnection;13;1;12;0
WireConnection;63;1;66;0
WireConnection;29;0;21;0
WireConnection;15;0;13;0
WireConnection;15;1;12;0
WireConnection;15;2;16;0
WireConnection;64;0;63;2
WireConnection;32;0;28;0
WireConnection;32;1;29;0
WireConnection;33;0;29;0
WireConnection;33;1;34;0
WireConnection;70;0;68;0
WireConnection;70;1;69;0
WireConnection;1;1;59;3
WireConnection;17;0;15;0
WireConnection;17;1;14;0
WireConnection;37;0;33;0
WireConnection;37;1;40;0
WireConnection;35;0;32;0
WireConnection;35;1;38;0
WireConnection;35;2;39;0
WireConnection;65;0;63;2
WireConnection;65;1;64;0
WireConnection;50;0;1;2
WireConnection;19;0;17;0
WireConnection;19;1;20;0
WireConnection;67;0;65;0
WireConnection;67;1;68;0
WireConnection;67;2;70;0
WireConnection;55;0;53;0
WireConnection;55;1;54;0
WireConnection;36;0;37;0
WireConnection;36;1;35;0
WireConnection;77;0;78;0
WireConnection;77;1;79;0
WireConnection;41;1;36;0
WireConnection;56;0;50;0
WireConnection;56;1;53;0
WireConnection;56;2;55;0
WireConnection;57;0;19;0
WireConnection;71;0;67;0
WireConnection;76;0;1;2
WireConnection;76;1;78;0
WireConnection;76;2;77;0
WireConnection;52;0;51;0
WireConnection;52;1;56;0
WireConnection;74;0;75;0
WireConnection;74;1;71;0
WireConnection;23;0;57;0
WireConnection;23;1;24;0
WireConnection;80;0;76;0
WireConnection;80;1;81;0
WireConnection;42;0;41;0
WireConnection;42;1;43;0
WireConnection;44;0;42;0
WireConnection;44;1;23;0
WireConnection;44;2;52;0
WireConnection;44;3;74;0
WireConnection;73;0;2;0
WireConnection;73;1;71;0
WireConnection;3;0;80;0
WireConnection;3;1;2;0
WireConnection;3;2;5;0
WireConnection;89;1;87;0
WireConnection;86;0;83;0
WireConnection;86;1;84;0
WireConnection;87;0;85;0
WireConnection;87;2;86;0
WireConnection;8;0;1;2
WireConnection;72;0;3;0
WireConnection;72;1;73;0
WireConnection;45;0;44;0
WireConnection;45;1;26;0
WireConnection;0;10;8;0
WireConnection;0;13;45;0
WireConnection;0;11;72;0
ASEEND*/
//CHKSM=2AAFD9294224A8EB81C79BB8CC3777815110A0E8