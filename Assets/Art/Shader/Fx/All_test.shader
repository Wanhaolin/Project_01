// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "All_test"
{
	Properties
	{
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("CullMode", Float) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)]_ZTestMode("ZTestMode", Float) = 8
		[Enum(On,1,Off,0)]_ZWriteMode("ZWriteMode", Float) = 0
		[Enum(UnityEngine.Rendering.BlendMode)]_Dst("Dst", Float) = 10
		[Main(g1,_KEYWORD,on,off)]_Main("Main", Float) = 0
		[HDR][Sub(g1)]_MainColor("MainColor", Color) = (1,1,1,1)
		[Tex(g1)]_MainTex("MainTex", 2D) = "white" {}
		[Toggle][SubToggle(g1,_)]_AChannelSwitch("AChannelSwitch", Float) = 0
		[Sub(g1)]_MainTexTilingoffset("MainTexTiling&offset", Vector) = (1,1,0,0)
		[Ramp(g1)]_RampTex("RampTex", 2D) = "white" {}
		[Main(g2,_KEYWORD,on,off)]_Mask("Mask", Float) = 0
		[Tex(g2)]_MaskTex("MaskTex", 2D) = "white" {}
		[Sub(g2)]_MaskTexTilingoffset("MaskTexTiling&offset", Vector) = (1,1,0,0)
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
		#pragma target 5.0
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

		uniform float _Main;
		uniform float _Dst;
		uniform float _ZWriteMode;
		uniform float _ZTestMode;
		uniform float _CullMode;
		uniform float _Mask;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float4 _MainTexTilingoffset;
		uniform float _AChannelSwitch;
		uniform sampler2D _MaskTex;
		uniform float4 _MaskTex_ST;
		uniform float4 _MaskTexTilingoffset;
		uniform sampler2D _RampTex;
		uniform float4 _RampTex_ST;
		uniform float4 _MainColor;

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float2 appendResult6 = (float2(_MainTexTilingoffset.x , _MainTexTilingoffset.y));
			float2 appendResult7 = (float2(_MainTexTilingoffset.z , _MainTexTilingoffset.w));
			float4 tex2DNode1 = tex2D( _MainTex, (uv_MainTex*appendResult6 + appendResult7) );
			float lerpResult15 = lerp( tex2DNode1.r , tex2DNode1.a , _AChannelSwitch);
			float2 uv_MaskTex = i.uv_texcoord * _MaskTex_ST.xy + _MaskTex_ST.zw;
			float2 appendResult28 = (float2(_MaskTexTilingoffset.x , _MaskTexTilingoffset.y));
			float2 appendResult29 = (float2(_MaskTexTilingoffset.z , _MaskTexTilingoffset.w));
			float2 uv_RampTex = i.uv_texcoord * _RampTex_ST.xy + _RampTex_ST.zw;
			c.rgb = ( tex2D( _RampTex, uv_RampTex ) * tex2DNode1 * _MainColor ).rgb;
			c.a = saturate( ( lerpResult15 * tex2D( _MaskTex, (uv_MaskTex*appendResult28 + appendResult29) ).r ) );
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
	CustomEditor "LWGUI.LWGUI"
}
/*ASEBEGIN
Version=18935
-62;278;1373.6;883.8;3418.138;767.1086;3.215537;True;False
Node;AmplifyShaderEditor.Vector4Node;5;-1668.063,293.1375;Inherit;False;Property;_MainTexTilingoffset;MainTexTiling&offset;9;0;Create;True;0;0;0;False;1;Sub(g1);False;1,1,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;27;-1489.845,878.6458;Inherit;False;Property;_MaskTexTilingoffset;MaskTexTiling&offset;13;0;Create;True;0;0;0;False;1;Sub(g2);False;1,1,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-1597.113,149.7817;Inherit;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;7;-1419.063,386.1375;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;6;-1417.063,292.1375;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;29;-1240.845,971.6459;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;28;-1238.845,877.6458;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;4;-1213.062,261.1376;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;30;-1418.895,735.2899;Inherit;False;0;13;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScaleAndOffsetNode;31;-1034.844,846.6458;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1;-951.6672,233.1815;Inherit;True;Property;_MainTex;MainTex;7;0;Create;True;0;0;0;False;1;Tex(g1);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;18;-845.2415,676.6715;Inherit;False;Property;_AChannelSwitch;AChannelSwitch;8;1;[Toggle];Create;True;0;0;0;False;1;SubToggle(g1,_);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;13;-746.3934,821.2258;Inherit;True;Property;_MaskTex;MaskTex;12;0;Create;True;0;0;0;False;1;Tex(g2);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;15;-466.817,468.7946;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;19;-2864.26,-1199.863;Inherit;False;260.0947;447.6218;Enum;4;23;22;21;20;Enum;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;24;-2464.399,-1205.645;Inherit;False;222.6;322.4;Group;2;26;2;Group;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;25;-938.8589,-26.33303;Inherit;True;Property;_RampTex;RampTex;10;0;Create;True;0;0;0;False;1;Ramp(g1);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-253.6763,565.1746;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;11;-877.9482,483.2518;Inherit;False;Property;_MainColor;MainColor;6;1;[HDR];Create;True;0;0;0;False;1;Sub(g1);False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;20;-2809.353,-870.554;Inherit;False;Property;_Dst;Dst;4;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;0;False;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-2417.69,-1078.566;Inherit;False;Property;_Mask;Mask;11;0;Create;True;0;0;0;True;1;Main(g2,_KEYWORD,on,off);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2;-2414.399,-1155.645;Inherit;False;Property;_Main;Main;5;0;Create;True;0;0;0;True;1;Main(g1,_KEYWORD,on,off);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-2812.26,-1057.11;Inherit;False;Property;_ZTestMode;ZTestMode;2;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CompareFunction;True;0;False;8;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-2810.78,-1149.864;Inherit;False;Property;_CullMode;CullMode;1;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-2811.292,-965.001;Inherit;False;Property;_ZWriteMode;ZWriteMode;3;1;[Enum];Create;True;0;2;On;1;Off;0;0;True;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-363.0876,208.8876;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;16;-70.97337,575.5778;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;374.2728,179.9938;Float;False;True;-1;7;LWGUI.LWGUI;0;0;CustomLighting;All_test;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;0;True;21;0;True;22;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;False;Custom;;Transparent;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;True;20;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;True;23;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;7;0;5;3
WireConnection;7;1;5;4
WireConnection;6;0;5;1
WireConnection;6;1;5;2
WireConnection;29;0;27;3
WireConnection;29;1;27;4
WireConnection;28;0;27;1
WireConnection;28;1;27;2
WireConnection;4;0;3;0
WireConnection;4;1;6;0
WireConnection;4;2;7;0
WireConnection;31;0;30;0
WireConnection;31;1;28;0
WireConnection;31;2;29;0
WireConnection;1;1;4;0
WireConnection;13;1;31;0
WireConnection;15;0;1;1
WireConnection;15;1;1;4
WireConnection;15;2;18;0
WireConnection;14;0;15;0
WireConnection;14;1;13;1
WireConnection;8;0;25;0
WireConnection;8;1;1;0
WireConnection;8;2;11;0
WireConnection;16;0;14;0
WireConnection;0;9;16;0
WireConnection;0;13;8;0
ASEEND*/
//CHKSM=66926737767FE454064A58582411DBF33F535EF6