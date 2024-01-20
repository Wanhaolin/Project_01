// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Whl/Fx/FreGlow"
{
	Properties
	{
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("CullMode", Float) = 0
		_Fre("Fre", Vector) = (0,1,5,0)
		[Enum(UnityEngine.Rendering.CompareFunction)]_ZTestMode("ZTestMode", Float) = 8
		[HDR]_MainColor("MainColor", Color) = (1,1,1,0)
		[HDR]_SubColor("SubColor", Color) = (0,0,0,0)
		[Toggle(_SOFTPARTICLE_ON)] _SoftParticle("SoftParticle", Float) = 0
		_FadeRange("FadeRange", Float) = 1
		_FreOn("FreOn", Range( 0 , 1)) = 0
		_FreScale("FreScale", Float) = 1
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" }
		Cull [_CullMode]
		ZWrite Off
		ZTest [_ZTestMode]
		Blend SrcAlpha One
		
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _SOFTPARTICLE_ON
		#pragma surface surf StandardCustomLighting keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float4 vertexColor : COLOR;
			float4 screenPos;
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

		uniform float _CullMode;
		uniform float _ZTestMode;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _FadeRange;
		uniform float _FreScale;
		uniform float _FreOn;
		uniform float4 _MainColor;
		uniform float4 _SubColor;
		uniform float3 _Fre;

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth20 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth20 = abs( ( screenDepth20 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _FadeRange ) );
			#ifdef _SOFTPARTICLE_ON
				float staticSwitch22 = distanceDepth20;
			#else
				float staticSwitch22 = 1.0;
			#endif
			float SoftParticle24 = saturate( staticSwitch22 );
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float3 ase_normWorldNormal = normalize( ase_worldNormal );
			float3 appendResult41 = (float3(ase_normWorldNormal.x , ase_normWorldNormal.y , -ase_normWorldNormal.z));
			float3 switchResult42 = (((i.ASEVFace>0)?(ase_normWorldNormal):(appendResult41)));
			float3 WorldNormal43 = switchResult42;
			float fresnelNdotV30 = dot( WorldNormal43, ase_worldViewDir );
			float fresnelNode30 = ( 0.0 + _FreScale * pow( max( 1.0 - fresnelNdotV30 , 0.0001 ), 5.0 ) );
			float clampResult32 = clamp( ( 1.0 - fresnelNode30 ) , 0.0 , 1.0 );
			float FreOP33 = clampResult32;
			float lerpResult34 = lerp( 1.0 , FreOP33 , _FreOn);
			float fresnelNdotV3 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode3 = ( _Fre.x + _Fre.y * pow( 1.0 - fresnelNdotV3, _Fre.z ) );
			float4 lerpResult5 = lerp( _MainColor , _SubColor , saturate( fresnelNode3 ));
			c.rgb = ( lerpResult5 * float4( (i.vertexColor).rgb , 0.0 ) ).rgb;
			c.a = ( i.vertexColor.a * SoftParticle24 * lerpResult34 );
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
-1600;654;1559;826;1837.11;376.6872;2.810657;True;True
Node;AmplifyShaderEditor.CommentaryNode;38;670.3026,2015.791;Inherit;False;1088.13;274.4167;WorldNormal;5;43;42;41;40;39;WorldNormal;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldNormalVector;39;720.3026,2065.79;Inherit;False;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NegateNode;40;923.0286,2179.207;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;41;1080.029,2122.207;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwitchByFaceNode;42;1317.029,2071.207;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;43;1534.433,2067.061;Inherit;False;WorldNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;27;692.7525,1349.175;Inherit;False;1459.488;425.4343;FreOP;6;33;32;31;30;29;28;FreOP;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;29;771.1022,1513.782;Inherit;False;43;WorldNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;18;-2021.911,1370.998;Inherit;False;1246.439;416.1655;SoftParticle;6;24;23;22;21;20;19;SoftParticle;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;28;818.9362,1609.371;Inherit;False;Property;_FreScale;FreScale;9;0;Create;True;0;0;0;False;0;False;1;1.64;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-1960.572,1558.977;Inherit;False;Property;_FadeRange;FadeRange;7;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;30;1053.991,1520.212;Inherit;True;Standard;WorldNormal;ViewDir;False;True;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;31;1374.319,1520.426;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;20;-1781.047,1539.163;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-1751.96,1443.679;Inherit;False;Constant;_Float1;Float 1;14;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;4;-1351.67,358.2366;Inherit;False;Property;_Fre;Fre;2;0;Create;True;0;0;0;False;0;False;0,1,5;0,0.23,1.09;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ClampOpNode;32;1558.407,1520.873;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;22;-1517.313,1450.924;Inherit;False;Property;_SoftParticle;SoftParticle;6;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;23;-1277.443,1479.954;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;3;-1109.67,342.0368;Inherit;True;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;33;1728.904,1515.343;Inherit;False;FreOP;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-600.0048,370.0633;Inherit;False;Constant;_Float15;Float 15;39;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-681.4946,579.9554;Inherit;False;Property;_FreOn;FreOn;8;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;37;-631.2675,469.4584;Inherit;False;33;FreOP;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;7;-795.9337,277.0782;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;24;-1091.566,1466.534;Inherit;False;SoftParticle;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1;-1027.766,-62.29997;Inherit;False;Property;_MainColor;MainColor;4;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;0.05891288,0.01149873,0.3584906,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;8;-485.9436,-104.4596;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;6;-1032.76,148.5521;Inherit;False;Property;_SubColor;SubColor;5;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;15.44932,17.38048,61.4754,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;13;-286.6223,572.7093;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;5;-640.1796,108.8101;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;15;-1313.228,608.3724;Inherit;False;448;277.753;Comment;2;17;16;;1,1,1,1;0;0
Node;AmplifyShaderEditor.LerpOp;34;-289.6063,316.1344;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;25;-280.5314,93.83036;Inherit;False;24;SoftParticle;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-1259.748,658.3715;Inherit;False;Property;_CullMode;CullMode;1;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;-58.17126,42.13458;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-1263.228,756.1254;Inherit;False;Property;_ZTestMode;ZTestMode;3;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CompareFunction;True;0;False;8;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;57.62605,550.0988;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;284.8919,-139.2574;Float;False;True;-1;2;ASEMaterialInspector;0;0;CustomLighting;Whl/Fx/FreGlow;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;True;16;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;True;17;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;40;0;39;3
WireConnection;41;0;39;1
WireConnection;41;1;39;2
WireConnection;41;2;40;0
WireConnection;42;0;39;0
WireConnection;42;1;41;0
WireConnection;43;0;42;0
WireConnection;30;0;29;0
WireConnection;30;2;28;0
WireConnection;31;0;30;0
WireConnection;20;0;19;0
WireConnection;32;0;31;0
WireConnection;22;1;21;0
WireConnection;22;0;20;0
WireConnection;23;0;22;0
WireConnection;3;1;4;1
WireConnection;3;2;4;2
WireConnection;3;3;4;3
WireConnection;33;0;32;0
WireConnection;7;0;3;0
WireConnection;24;0;23;0
WireConnection;13;0;8;0
WireConnection;5;0;1;0
WireConnection;5;1;6;0
WireConnection;5;2;7;0
WireConnection;34;0;35;0
WireConnection;34;1;37;0
WireConnection;34;2;36;0
WireConnection;26;0;8;4
WireConnection;26;1;25;0
WireConnection;26;2;34;0
WireConnection;9;0;5;0
WireConnection;9;1;13;0
WireConnection;0;9;26;0
WireConnection;0;13;9;0
ASEEND*/
//CHKSM=D864245FAAEBCF8682926E1AA8229757AFB0B840