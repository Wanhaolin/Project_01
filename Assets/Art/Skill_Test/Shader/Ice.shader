// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Whl/Fx/Ice"
{
	Properties
	{
		[HDR]_MainColor("MainColor", Color) = (1,1,1,1)
		_MainTex("MainTex", 2D) = "white" {}
		[HDR]_FreColor("FreColor", Color) = (1,1,1,1)
		_FreOn("FreOn", Range( 0 , 1)) = 0
		_FreInvers("FreInvers", Range( 0 , 1)) = 0
		_FreScale("FreScale", Float) = 1
		_FrePower("FrePower", Float) = 5
		_NormalMap("NormalMap", 2D) = "bump" {}
		_NormalScale("NormalScale", Range( 0 , 2)) = 0.2
		_Matcap("Matcap", 2D) = "black" {}
		_MatCapIntensity("MatCapIntensity", Range( 0 , 1)) = 0
		[HDR]_GlowColor("GlowColor", Color) = (1,1,1,1)
		_GlowTex("GlowTex", 2D) = "black" {}
		_NormalDisturStr("NormalDisturStr", Range( 0 , 1)) = 0
		_FadeColor("FadeColor", Color) = (1,1,1,0)
		[Header(SoftParticle)]_FadeRange("FadeRange", Float) = 1
		[Toggle(_SOFTPARTICLE_ON)] _SoftParticle("SoftParticle", Float) = 0
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _SOFTPARTICLE_ON
		#pragma surface surf StandardCustomLighting keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
			half ASEVFace : VFACE;
			float4 uv2_texcoord2;
			float4 screenPos;
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

		uniform float4 _FadeColor;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float4 _MainColor;
		uniform float _FreScale;
		uniform float _FrePower;
		uniform float _FreInvers;
		uniform float _FreOn;
		uniform float4 _FreColor;
		uniform sampler2D _GlowTex;
		uniform float4 _GlowTex_ST;
		uniform float _NormalDisturStr;
		uniform float4 _GlowColor;
		uniform sampler2D _Matcap;
		uniform sampler2D _NormalMap;
		uniform float4 _NormalMap_ST;
		uniform float _NormalScale;
		uniform float _MatCapIntensity;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _FadeRange;

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 temp_output_2_0 = ( tex2D( _MainTex, uv_MainTex ) * _MainColor );
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_normWorldNormal = normalize( ase_worldNormal );
			float3 appendResult7 = (float3(ase_normWorldNormal.x , ase_normWorldNormal.y , -ase_normWorldNormal.z));
			float3 switchResult8 = (((i.ASEVFace>0)?(ase_normWorldNormal):(appendResult7)));
			float3 WorldNormal9 = switchResult8;
			float fresnelNdotV14 = dot( WorldNormal9, ase_worldViewDir );
			float fresnelNode14 = ( 0.0 + _FreScale * pow( max( 1.0 - fresnelNdotV14 , 0.0001 ), _FrePower ) );
			float lerpResult17 = lerp( ( 1.0 - fresnelNode14 ) , fresnelNode14 , _FreInvers);
			float clampResult18 = clamp( lerpResult17 , 0.0 , 1.0 );
			float FreOP19 = clampResult18;
			float lerpResult20 = lerp( 1.0 , FreOP19 , _FreOn);
			float2 uv_GlowTex = i.uv_texcoord * _GlowTex_ST.xy + _GlowTex_ST.zw;
			float UV2_W55 = i.uv2_texcoord2.z;
			float UV2_T56 = i.uv2_texcoord2.w;
			float2 appendResult67 = (float2(UV2_W55 , UV2_T56));
			float2 appendResult74 = (float2(0.0 , WorldNormal9.y));
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			float2 temp_output_38_0 = ( ( (mul( UNITY_MATRIX_V, float4( (WorldNormalVector( i , UnpackScaleNormal( tex2D( _NormalMap, uv_NormalMap ), _NormalScale ) )) , 0.0 ) ).xyz).xy + 1.0 ) * 0.5 );
			float4 tex2DNode40 = tex2D( _Matcap, temp_output_38_0 );
			float4 MatCapColor41 = tex2DNode40;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth82 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth82 = abs( ( screenDepth82 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _FadeRange ) );
			#ifdef _SOFTPARTICLE_ON
				float staticSwitch84 = distanceDepth82;
			#else
				float staticSwitch84 = 1.0;
			#endif
			float SoftParticle86 = saturate( staticSwitch84 );
			float4 lerpResult88 = lerp( _FadeColor , ( temp_output_2_0 + ( lerpResult20 * _FreColor * temp_output_2_0 ) + ( tex2D( _GlowTex, ( uv_GlowTex + appendResult67 + ( appendResult74 * _NormalDisturStr ) ) ).r * _GlowColor ) + ( MatCapColor41 * _MatCapIntensity ) ) , SoftParticle86);
			c.rgb = lerpResult88.rgb;
			c.a = 1;
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
Version=18935
-1454;146;1324;743;1952.177;373.9792;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;4;-719.478,-954.1366;Inherit;False;1088.13;274.4167;WorldNormal;5;9;8;7;6;5;WorldNormal;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldNormalVector;5;-669.478,-904.1365;Inherit;False;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NegateNode;6;-466.7509,-790.7196;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;7;-309.7502,-847.7195;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;27;-6148.438,-918.4856;Inherit;False;2856.676;458.1624;MatCapColor;13;41;40;39;38;37;36;35;34;32;31;30;29;28;MatCapColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;78;-6409.452,-648.554;Inherit;False;Property;_NormalScale;NormalScale;8;0;Create;True;0;0;0;False;0;False;0.2;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SwitchByFaceNode;8;-72.74959,-898.7195;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;79;-6441.452,-787.554;Inherit;False;0;29;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;10;-2886.951,-972.8474;Inherit;False;2076.767;835.9675;FreOP;9;19;18;17;16;15;14;11;12;13;FreOP;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;9;144.6537,-902.8655;Inherit;False;WorldNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;29;-6098.438,-751.4778;Inherit;True;Property;_NormalMap;NormalMap;7;0;Create;True;0;0;0;False;0;False;-1;None;8857e2a02b748674494aece67f013717;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ViewMatrixNode;31;-5691.645,-847.0858;Inherit;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.WorldNormalVector;30;-5750.399,-747.4772;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;12;-2832.951,-740.4137;Inherit;False;Property;_FreScale;FreScale;5;0;Create;True;0;0;0;False;0;False;1;1.4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-2802.598,-650.3989;Inherit;False;Property;_FrePower;FrePower;6;0;Create;True;0;0;0;False;0;False;5;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;13;-2855.882,-839.0198;Inherit;False;9;WorldNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FresnelNode;14;-2613.636,-813.5336;Inherit;True;Standard;WorldNormal;ViewDir;False;True;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;48;-5169.39,493.1069;Inherit;False;1143.907;365.912;Comment;3;56;55;54;UV2;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-5506.104,-830.3622;Inherit;False;2;2;0;FLOAT4x4;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;54;-5140.36,557.028;Inherit;False;1;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;16;-2386.417,-517.4749;Inherit;False;Property;_FreInvers;FreInvers;4;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;34;-5295.686,-827.1698;Inherit;False;FLOAT2;0;1;2;3;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;71;-3138.051,1353.004;Inherit;False;9;WorldNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;15;-2301.64,-745.6712;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-5514.072,-731.9985;Inherit;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;80;-2137.718,1844.419;Inherit;False;1186.397;394.8047;SoftParticle;6;86;85;84;83;82;81;SoftParticle;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;36;-5115.616,-830.8715;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;37;-5150.768,-653.2465;Inherit;False;Constant;_Float1;Float 1;1;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;17;-2067.577,-830.1838;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;72;-2943.051,1374.004;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RegisterLocalVarNode;56;-4673.316,670.0813;Inherit;False;UV2_T;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;55;-4671.852,575.3899;Inherit;False;UV2_W;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;81;-2076.379,2032.398;Inherit;False;Property;_FadeRange;FadeRange;19;1;[Header];Create;True;1;SoftParticle;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;74;-2773.14,1328.933;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ClampOpNode;18;-1817.073,-830.4625;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;-4925.616,-832.8715;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;64;-2917.2,1141.084;Inherit;False;56;UV2_T;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;76;-2815.392,1565.007;Inherit;False;Property;_NormalDisturStr;NormalDisturStr;17;0;Create;True;0;0;0;False;0;False;0;0.343;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;65;-2919.93,1046.436;Inherit;False;55;UV2_W;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;83;-1867.767,1917.1;Inherit;False;Constant;_Float3;Float 1;14;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;82;-1896.854,2012.584;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;19;-1662.869,-835.9485;Inherit;False;FreOP;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;66;-2702.939,911.6472;Inherit;False;0;46;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;40;-4391.775,-767.776;Inherit;True;Property;_Matcap;Matcap;9;0;Create;True;0;0;0;False;0;False;-1;None;8148fbf358af13840ac8bd3df7904d1b;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;75;-2452.071,1466.991;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;67;-2685.657,1068.002;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-2006.17,318.984;Inherit;False;Constant;_Float15;Float 15;39;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;84;-1633.12,1924.345;Inherit;False;Property;_SoftParticle;SoftParticle;20;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-1893.558,-115.0882;Inherit;True;Property;_MainTex;MainTex;1;0;Create;True;0;0;0;False;0;False;-1;None;21c273d0a41e0cf41afaaec1b74e93bb;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;22;-2103.66,533.8758;Inherit;False;Property;_FreOn;FreOn;3;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;3;-1802.548,109.3455;Inherit;False;Property;_MainColor;MainColor;0;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;68;-2427.983,940.3402;Inherit;False;3;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;41;-4021.551,-779.2606;Inherit;False;MatCapColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;23;-2046.979,416.0278;Inherit;False;19;FreOP;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;42;-1137.64,485.9652;Inherit;False;41;MatCapColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2;-1528.963,22.5117;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;20;-1771.521,330.873;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;24;-1787.026,509.9607;Inherit;False;Property;_FreColor;FreColor;2;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;1.21369,3.814991,11.28519,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;46;-2213.25,965.9437;Inherit;True;Property;_GlowTex;GlowTex;12;0;Create;True;0;0;0;False;0;False;-1;None;3341c7daba9545649a97988dec1148df;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;85;-1409.166,1939.167;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-1206.846,588.0801;Inherit;False;Property;_MatCapIntensity;MatCapIntensity;10;0;Create;True;0;0;0;False;0;False;0;0.7;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;69;-1787.69,1119.787;Inherit;False;Property;_GlowColor;GlowColor;11;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;8.658824,10.91765,11.98431,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;-1426.617,324.7071;Inherit;False;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;77;-1061.155,322.5441;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;86;-1270.386,1928.955;Inherit;True;SoftParticle;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;70;-1449.69,986.7874;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;25;-1162.082,95.00212;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;49;-5173.784,-173.524;Inherit;False;1252.226;378.732;Comment;7;63;62;61;60;59;58;57;UV1;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;87;-1312.654,-23.09738;Inherit;False;86;SoftParticle;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;89;-1324.69,-215.8627;Inherit;False;Property;_FadeColor;FadeColor;18;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;47;-5204.571,1101.715;Inherit;False;1124.562;519.4683;Comment;4;53;52;51;50;UV3;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;61;-4860.266,-123.524;Inherit;False;Constant;_Float2;Float 2;7;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;59;-4577.195,48.11194;Inherit;False;Property;_UV1_TContorlDis;UV1_TContorlDis;13;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;39;-4703.55,-852.6803;Inherit;False;MatCapUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;62;-4564.957,-115.7341;Inherit;False;Property;_UV1_WContorlVertexOffset;UV1_WContorlVertexOffset;16;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;28;-4014.814,-650.1022;Inherit;False;MainTexAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;60;-4200.953,44.90088;Inherit;False;UV1_T;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;57;-5123.784,-96.79211;Inherit;True;0;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;50;-5100.106,1162.021;Inherit;False;Constant;_Float12;Float 12;28;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;52;-4838.106,1191.021;Inherit;False;Property;_UV3_XContorlDisturb;UV3_XContorlDisturb;15;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;58;-4913.219,120.2639;Inherit;False;Property;_Dissolution;Dissolution;14;0;Create;True;0;0;0;False;0;False;0.15;0.498;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;53;-4518.933,1214.386;Inherit;False;UV3_X;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;45;-838.7214,312.2703;Inherit;False;Screen;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;73;-2185.678,1402.395;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;88;-944.2427,20.69598;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;51;-5138.054,1277.042;Inherit;False;2;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;63;-4197.41,-113.3881;Inherit;False;UV1_W;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-516.589,-51.2177;Float;False;True;-1;2;ASEMaterialInspector;0;0;CustomLighting;Whl/Fx/Ice;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;6;0;5;3
WireConnection;7;0;5;1
WireConnection;7;1;5;2
WireConnection;7;2;6;0
WireConnection;8;0;5;0
WireConnection;8;1;7;0
WireConnection;9;0;8;0
WireConnection;29;1;79;0
WireConnection;29;5;78;0
WireConnection;30;0;29;0
WireConnection;14;0;13;0
WireConnection;14;2;12;0
WireConnection;14;3;11;0
WireConnection;32;0;31;0
WireConnection;32;1;30;0
WireConnection;34;0;32;0
WireConnection;15;0;14;0
WireConnection;36;0;34;0
WireConnection;36;1;35;0
WireConnection;17;0;15;0
WireConnection;17;1;14;0
WireConnection;17;2;16;0
WireConnection;72;0;71;0
WireConnection;56;0;54;4
WireConnection;55;0;54;3
WireConnection;74;1;72;1
WireConnection;18;0;17;0
WireConnection;38;0;36;0
WireConnection;38;1;37;0
WireConnection;82;0;81;0
WireConnection;19;0;18;0
WireConnection;40;1;38;0
WireConnection;75;0;74;0
WireConnection;75;1;76;0
WireConnection;67;0;65;0
WireConnection;67;1;64;0
WireConnection;84;1;83;0
WireConnection;84;0;82;0
WireConnection;68;0;66;0
WireConnection;68;1;67;0
WireConnection;68;2;75;0
WireConnection;41;0;40;0
WireConnection;2;0;1;0
WireConnection;2;1;3;0
WireConnection;20;0;21;0
WireConnection;20;1;23;0
WireConnection;20;2;22;0
WireConnection;46;1;68;0
WireConnection;85;0;84;0
WireConnection;26;0;20;0
WireConnection;26;1;24;0
WireConnection;26;2;2;0
WireConnection;77;0;42;0
WireConnection;77;1;44;0
WireConnection;86;0;85;0
WireConnection;70;0;46;1
WireConnection;70;1;69;0
WireConnection;25;0;2;0
WireConnection;25;1;26;0
WireConnection;25;2;70;0
WireConnection;25;3;77;0
WireConnection;59;1;58;0
WireConnection;59;0;57;4
WireConnection;39;0;38;0
WireConnection;62;1;61;0
WireConnection;62;0;57;3
WireConnection;28;0;40;1
WireConnection;60;0;59;0
WireConnection;52;1;50;0
WireConnection;52;0;51;1
WireConnection;53;0;52;0
WireConnection;45;2;44;0
WireConnection;88;0;89;0
WireConnection;88;1;25;0
WireConnection;88;2;87;0
WireConnection;63;0;62;0
WireConnection;0;13;88;0
ASEEND*/
//CHKSM=6DBE2376775AEC1ABDEAA883048C6EA1A03930D8