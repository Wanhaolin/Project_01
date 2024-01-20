// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Whl/Fx/butterfly"
{
	Properties
	{
		[Toggle(_UV1_WCONTORLRANDOMOFFSET_ON)] _UV1_WContorlRandomOffset("UV1_WContorlRandomOffset", Float) = 0
		_MainTex("MainTex", 2D) = "white" {}
		[HDR]_BaseColor("BaseColor", Color) = (1,1,1,1)
		_Mask("Mask", 2D) = "white" {}
		[Toggle(_UV2_XYCONTROLOFFSET_ON)] _UV2_XYControlOffset("UV2_XYControlOffset", Float) = 0
		_VertexOffsetTex("VertexOffsetTex", 2D) = "white" {}
		_Panner("Panner", Vector) = (0,0,1,0)
		[Toggle(_UV2_WCONTORLOFFSETSTR_ON)] _UV2_WContorlOffsetStr("UV2_WContorlOffsetStr", Float) = 0
		_VertexOffsetStr("VertexOffsetStr", Float) = 1
		_DownStr("DownStr", Float) = 0
		[Toggle(_DISSOLUTIONON_ON)] _DissolutionOn("DissolutionOn", Float) = 0
		[Toggle(_UV1_TCONTORLDIS_ON)] _UV1_TContorlDis("UV1_TContorlDis", Float) = 0
		_DissolutionTex("DissolutionTex", 2D) = "white" {}
		_Invers("Invers", Range( 0 , 1)) = 0
		_Dissolution("Dissolution", Range( 0 , 1)) = 0.15
		_DissHardness("DissHardness", Range( 0 , 0.99)) = 0
		_DissolutionTexPanner("DissolutionTexPanner", Vector) = (0,0,1,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" }
		Cull Off
		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _UV2_XYCONTROLOFFSET_ON
		#pragma shader_feature_local _UV1_WCONTORLRANDOMOFFSET_ON
		#pragma shader_feature_local _UV2_WCONTORLOFFSETSTR_ON
		#pragma shader_feature_local _DISSOLUTIONON_ON
		#pragma shader_feature_local _UV1_TCONTORLDIS_ON
		#pragma surface surf StandardCustomLighting keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
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

		uniform sampler2D _VertexOffsetTex;
		uniform float3 _Panner;
		uniform float4 _VertexOffsetTex_ST;
		uniform float _DownStr;
		uniform float _VertexOffsetStr;
		uniform sampler2D _Mask;
		uniform float4 _Mask_ST;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform sampler2D _DissolutionTex;
		uniform float3 _DissolutionTexPanner;
		uniform float4 _DissolutionTex_ST;
		uniform float _Invers;
		uniform float _Dissolution;
		uniform float _DissHardness;
		uniform float4 _BaseColor;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertexNormal = v.normal.xyz;
			float mulTime14 = _Time.y * _Panner.z;
			#ifdef _UV1_WCONTORLRANDOMOFFSET_ON
				float staticSwitch58 = v.texcoord.z;
			#else
				float staticSwitch58 = 1.0;
			#endif
			float UV1_W59 = staticSwitch58;
			float2 appendResult13 = (float2(_Panner.x , _Panner.y));
			float4 uvs_VertexOffsetTex = v.texcoord;
			uvs_VertexOffsetTex.xy = v.texcoord.xy * _VertexOffsetTex_ST.xy + _VertexOffsetTex_ST.zw;
			float2 panner10 = ( ( mulTime14 + UV1_W59 ) * appendResult13 + uvs_VertexOffsetTex.xy);
			float UV2_X30 = v.texcoord1.x;
			float UV2_Y29 = v.texcoord1.y;
			float2 appendResult33 = (float2(UV2_X30 , UV2_Y29));
			#ifdef _UV2_XYCONTROLOFFSET_ON
				float2 staticSwitch36 = ( uvs_VertexOffsetTex.xy + appendResult33 );
			#else
				float2 staticSwitch36 = panner10;
			#endif
			float4 uvs_Mask = v.texcoord;
			uvs_Mask.xy = v.texcoord.xy * _Mask_ST.xy + _Mask_ST.zw;
			#ifdef _UV2_WCONTORLOFFSETSTR_ON
				float staticSwitch64 = v.texcoord1.z;
			#else
				float staticSwitch64 = 1.0;
			#endif
			float UV2_W63 = staticSwitch64;
			v.vertex.xyz += ( ( ase_vertexNormal * ( (_DownStr + (tex2Dlod( _VertexOffsetTex, float4( staticSwitch36, 0, 0.0) ).r - 0.0) * (1.0 - _DownStr) / (1.0 - 0.0)) * _VertexOffsetStr ) * tex2Dlod( _Mask, float4( uvs_Mask.xy, 0, 0.0) ).r ) * UV2_W63 );
			v.vertex.w = 1;
		}

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 tex2DNode1 = tex2D( _MainTex, uv_MainTex );
			float mulTime44 = _Time.y * _DissolutionTexPanner.z;
			float2 appendResult43 = (float2(_DissolutionTexPanner.x , _DissolutionTexPanner.y));
			float4 uvs_DissolutionTex = i.uv_texcoord;
			uvs_DissolutionTex.xy = i.uv_texcoord.xy * _DissolutionTex_ST.xy + _DissolutionTex_ST.zw;
			float2 panner45 = ( mulTime44 * appendResult43 + uvs_DissolutionTex.xy);
			float temp_output_3_0_g1 = tex2D( _DissolutionTex, panner45 ).r;
			float lerpResult5_g1 = lerp( temp_output_3_0_g1 , ( 1.0 - temp_output_3_0_g1 ) , _Invers);
			#ifdef _UV1_TCONTORLDIS_ON
				float staticSwitch55 = i.uv_texcoord.w;
			#else
				float staticSwitch55 = _Dissolution;
			#endif
			float UV1_T56 = staticSwitch55;
			float temp_output_8_0_g1 = _DissHardness;
			float clampResult49 = clamp( saturate( ( ( ( ( lerpResult5_g1 + 1.0 ) - ( ( 1.0 - (-0.5 + (UV1_T56 - 0.0) * (1.0 - -0.5) / (1.0 - 0.0)) ) * ( ( 1.0 - temp_output_8_0_g1 ) + 1.0 ) ) ) - temp_output_8_0_g1 ) / ( temp_output_8_0_g1 - 1.0 ) ) ) , 0.0 , 1.0 );
			#ifdef _DISSOLUTIONON_ON
				float staticSwitch46 = clampResult49;
			#else
				float staticSwitch46 = 1.0;
			#endif
			c.rgb = ( _BaseColor * tex2DNode1 * float4( (i.vertexColor).rgb , 0.0 ) ).rgb;
			c.a = ( ( tex2DNode1.r * i.vertexColor.a ) * staticSwitch46 );
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
-1814;326;1708;830;873.3665;-461.1512;1;True;True
Node;AmplifyShaderEditor.CommentaryNode;52;-2797.705,-920.4197;Inherit;False;1252.226;378.732;Comment;7;59;58;57;56;55;54;53;UV1;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;27;-2781.705,-355.7536;Inherit;False;1232.766;559.0088;Comment;6;29;30;28;63;64;65;UV2;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;57;-2484.187,-870.4197;Inherit;False;Constant;_Float1;Float 1;7;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;53;-2770.705,-871.6877;Inherit;True;0;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;28;-2752.675,-291.8326;Inherit;False;1;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;58;-2188.878,-864.2703;Inherit;False;Property;_UV1_WContorlRandomOffset;UV1_WContorlRandomOffset;1;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;59;-1821.331,-860.2837;Inherit;False;UV1_W;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;12;-2916.992,725.681;Inherit;False;Property;_Panner;Panner;7;0;Create;True;0;0;0;False;0;False;0,0,1;-4,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;29;-2285.631,-178.7791;Inherit;False;UV2_Y;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;30;-2284.167,-273.4706;Inherit;False;UV2_X;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;14;-2696.708,849.2455;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;62;-2839.719,946.4712;Inherit;False;59;UV1_W;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;32;-2907.07,1306.07;Inherit;False;29;UV2_Y;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;31;-2907.07,1210.07;Inherit;False;30;UV2_X;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;23;-2491.15,861.2976;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;41;-1708.747,1529.69;Inherit;False;Property;_DissolutionTexPanner;DissolutionTexPanner;17;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;13;-2517.673,726.562;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;11;-2795.611,569.8233;Inherit;False;0;4;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;54;-2537.14,-626.6317;Inherit;False;Property;_Dissolution;Dissolution;15;0;Create;True;0;0;0;False;0;False;0.15;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;33;-2683.07,1242.07;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;44;-1414.748,1644.69;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;42;-1610.565,1378.447;Inherit;False;0;40;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;55;-2201.116,-698.7837;Inherit;False;Property;_UV1_TContorlDis;UV1_TContorlDis;12;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;10;-2303.297,643.5749;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;34;-2491.07,1098.07;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;43;-1411.748,1490.69;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;36;-2089.868,692.0703;Inherit;False;Property;_UV2_XYControlOffset;UV2_XYControlOffset;5;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;45;-1239.169,1396.428;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;56;-1824.874,-701.9948;Inherit;False;UV1_T;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;60;-952.1442,1651.881;Inherit;False;56;UV1_T;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;65;-2662.894,-32.08649;Inherit;False;Constant;_Float2;Float 2;18;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;50;-1022.992,1566.439;Inherit;False;Property;_Invers;Invers;14;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;4;-1590.577,650.4778;Inherit;True;Property;_VertexOffsetTex;VertexOffsetTex;6;0;Create;True;0;0;0;False;0;False;-1;None;7ad0fd9f902062140824977f9eca4c4e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;61;-1017.144,1751.881;Inherit;False;Property;_DissHardness;DissHardness;16;0;Create;True;0;0;0;False;0;False;0;0.732;0;0.99;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-1355.748,920.8132;Inherit;False;Property;_DownStr;DownStr;10;0;Create;True;0;0;0;False;0;False;0;-0.3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;40;-995.7744,1368.559;Inherit;True;Property;_DissolutionTex;DissolutionTex;13;0;Create;True;0;0;0;False;0;False;-1;None;ceb50485139911740b046010a8955c2a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;37;-657.769,1399.493;Inherit;False;Dissolution;-1;;1;8ed0a8fdbfe80554382ce257577aff19;0;4;3;FLOAT;0;False;7;FLOAT;0;False;4;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;24;-1033.89,815.8978;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-810.5136,950.26;Inherit;False;Property;_VertexOffsetStr;VertexOffsetStr;9;0;Create;True;0;0;0;False;0;False;1;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;15;-1027.704,1095.506;Inherit;False;0;8;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;64;-2461.665,-30.79388;Inherit;False;Property;_UV2_WContorlOffsetStr;UV2_WContorlOffsetStr;8;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-218.4163,1256.14;Inherit;False;Constant;_Float0;Float 0;12;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-822.3801,197.5824;Inherit;True;Property;_MainTex;MainTex;2;0;Create;True;0;0;0;False;0;False;-1;4c8e02e832983af46a4c0e5fada8c596;ef8dc74d67945894195b99d4243e1ff4;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;8;-698.2673,1070.897;Inherit;True;Property;_Mask;Mask;4;0;Create;True;0;0;0;False;0;False;-1;None;6c4bd7b31c3a4dc4fa0792a443a3174b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;49;-334.3275,1401.161;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;6;-532.0674,577.6966;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-446.2673,830.3966;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;16;-934.8141,421.395;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;63;-2143.366,-31.82813;Inherit;False;UV2_W;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-231.7912,380.2982;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;18;-717.7936,418.7184;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-43.41448,815.011;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;2;-614.5627,9.796509;Inherit;False;Property;_BaseColor;BaseColor;3;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;16.94838,16.94838,16.94838,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;66;-47.86794,988.885;Inherit;False;63;UV2_W;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;46;31.22803,1317.022;Inherit;False;Property;_DissolutionOn;DissolutionOn;11;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;67;205.1155,815.4785;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;108.2014,381.1458;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-307.5627,97.79651;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;478.6484,182.2948;Float;False;True;-1;2;ASEMaterialInspector;0;0;CustomLighting;Whl/Fx/butterfly;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;58;1;57;0
WireConnection;58;0;53;3
WireConnection;59;0;58;0
WireConnection;29;0;28;2
WireConnection;30;0;28;1
WireConnection;14;0;12;3
WireConnection;23;0;14;0
WireConnection;23;1;62;0
WireConnection;13;0;12;1
WireConnection;13;1;12;2
WireConnection;33;0;31;0
WireConnection;33;1;32;0
WireConnection;44;0;41;3
WireConnection;55;1;54;0
WireConnection;55;0;53;4
WireConnection;10;0;11;0
WireConnection;10;2;13;0
WireConnection;10;1;23;0
WireConnection;34;0;11;0
WireConnection;34;1;33;0
WireConnection;43;0;41;1
WireConnection;43;1;41;2
WireConnection;36;1;10;0
WireConnection;36;0;34;0
WireConnection;45;0;42;0
WireConnection;45;2;43;0
WireConnection;45;1;44;0
WireConnection;56;0;55;0
WireConnection;4;1;36;0
WireConnection;40;1;45;0
WireConnection;37;3;40;1
WireConnection;37;7;50;0
WireConnection;37;4;60;0
WireConnection;37;8;61;0
WireConnection;24;0;4;1
WireConnection;24;3;25;0
WireConnection;64;1;65;0
WireConnection;64;0;28;3
WireConnection;8;1;15;0
WireConnection;49;0;37;0
WireConnection;5;0;24;0
WireConnection;5;1;7;0
WireConnection;63;0;64;0
WireConnection;19;0;1;1
WireConnection;19;1;16;4
WireConnection;18;0;16;0
WireConnection;9;0;6;0
WireConnection;9;1;5;0
WireConnection;9;2;8;1
WireConnection;46;1;48;0
WireConnection;46;0;49;0
WireConnection;67;0;9;0
WireConnection;67;1;66;0
WireConnection;47;0;19;0
WireConnection;47;1;46;0
WireConnection;3;0;2;0
WireConnection;3;1;1;0
WireConnection;3;2;18;0
WireConnection;0;9;47;0
WireConnection;0;13;3;0
WireConnection;0;11;67;0
ASEEND*/
//CHKSM=9EBDCE92502F03145E01978A42A87C96D4D2E236