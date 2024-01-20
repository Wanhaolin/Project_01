// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Whl/Fx/Vine"
{
	Properties
	{
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("CullMode", Float) = 0
		[Enum(UnityEngine.Rendering.BlendMode)]_Dst("Dst", Float) = 10
		[Enum(On,1,Off,0)]_ZWriteMode("ZWriteMode", Float) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)]_ZTestMode("ZTestMode", Float) = 8
		_HeadCutRange("HeadCutRange", Range( 0 , 0.5)) = 0
		[HDR][Header(Main)]_MainColor("MainColor", Color) = (0,0,0,0)
		[Toggle(_UV2_WTCONTROLOFFSET_ON)] _UV2_WTControlOffset("UV2_WTControlOffset", Float) = 0
		_MainTex("MainTex", 2D) = "white" {}
		[Toggle(_ALPHACHANNEL_ON)] _AlphaChannel("AlphaChannel", Float) = 0
		_Rotater("Rotater", Range( 0 , 360)) = 0
		_RampTex("RampTex", 2D) = "white" {}
		[Toggle(_UV1_WCONTORLVERTEXOFFSET_ON)] _UV1_WContorlVertexOffset("UV1_WContorlVertexOffset", Float) = 0
		_MainTexPanner("MainTexPanner", Vector) = (0,0,1,0)
		[Header(VertexOffset)]_VertexOffsetTex("VertexOffsetTex", 2D) = "white" {}
		[Toggle(_VERTEXOFFSETON_ON)] _VertexOffsetOn("VertexOffsetOn", Float) = 0
		[Toggle(_UV2_WTCONTORLOFFSET_ON)] _UV2_WTContorlOffset("UV2_WTContorlOffset", Float) = 0
		_VertexOffsetStr("VertexOffsetStr", Float) = 1
		_VertexOffsetMask("VertexOffsetMask", 2D) = "white" {}
		_VertexOffsetTexPanner("VertexOffsetTexPanner", Vector) = (0,0,1,0)
		_OffsetDir("OffsetDir", Vector) = (1,1,1,0)
		[Header(Dissolution)]_DissolutionTex("DissolutionTex", 2D) = "white" {}
		[Toggle(_DISSOLUTIONON_ON)] _DissolutionOn("DissolutionOn", Float) = 0
		[Toggle(_UV1_TCONTORLDIS_ON)] _UV1_TContorlDis("UV1_TContorlDis", Float) = 0
		_DissolutionTexPanner("DissolutionTexPanner", Vector) = (0,0,1,0)
		_Dissolution("Dissolution", Range( 0 , 1)) = 0.15
		_Float10("DissSoft", Range( 0 , 2)) = 0
		_Invers("Invers", Range( 0 , 1)) = 0
		[Toggle]_ToggleSwitch4("DissEdgeOn", Float) = 1
		[HDR]_DissEdgeColor("DissEdgeColor", Color) = (0,0,0,0)
		_Float14("DissEdgeWidth", Range( 0 , 0.5)) = 0.1
		[Header(SoftParticle)]_FadeRange("FadeRange", Float) = 1
		[Toggle(_SOFTPARTICLE_ON)] _SoftParticle("SoftParticle", Float) = 0
		_FreOn("FreOn", Range( 0 , 1)) = 0
		_FreInvers("FreInvers", Range( 0 , 1)) = 0
		_FreScale("FreScale", Float) = 1
		_FrePower("FrePower", Float) = 5
		[Toggle(_FOGON_ON)] _FogOn("FogOn", Float) = 0
		_FogColor("FogColor", Color) = (0,0,0,0)
		_Start("Start", Float) = 0
		_End("End", Float) = 700
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
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _VERTEXOFFSETON_ON
		#pragma shader_feature_local _UV2_WTCONTORLOFFSET_ON
		#pragma shader_feature_local _UV1_WCONTORLVERTEXOFFSET_ON
		#pragma shader_feature_local _DISSOLUTIONON_ON
		#pragma shader_feature_local _UV1_TCONTORLDIS_ON
		#pragma shader_feature_local _ALPHACHANNEL_ON
		#pragma shader_feature_local _UV2_WTCONTROLOFFSET_ON
		#pragma shader_feature_local _SOFTPARTICLE_ON
		#pragma shader_feature_local _FOGON_ON
		#pragma surface surf StandardCustomLighting keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 uv_texcoord;
			float4 uv2_texcoord2;
			float4 screenPos;
			float4 vertexColor : COLOR;
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
		uniform float _ZWriteMode;
		uniform float _Dst;
		uniform sampler2D _VertexOffsetTex;
		uniform float3 _VertexOffsetTexPanner;
		uniform float4 _VertexOffsetTex_ST;
		uniform float3 _OffsetDir;
		uniform sampler2D _VertexOffsetMask;
		uniform float4 _VertexOffsetMask_ST;
		uniform float _VertexOffsetStr;
		uniform float _Dissolution;
		uniform float _Float10;
		uniform sampler2D _DissolutionTex;
		uniform float3 _DissolutionTexPanner;
		uniform float4 _DissolutionTex_ST;
		uniform float _Invers;
		uniform sampler2D _MainTex;
		uniform float3 _MainTexPanner;
		uniform float4 _MainTex_ST;
		uniform float _Rotater;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _FadeRange;
		uniform float _FreScale;
		uniform float _FrePower;
		uniform float _FreInvers;
		uniform float _FreOn;
		uniform float _HeadCutRange;
		uniform float4 _FogColor;
		uniform sampler2D _RampTex;
		uniform float4 _RampTex_ST;
		uniform float4 _MainColor;
		uniform float _ToggleSwitch4;
		uniform float _Float14;
		uniform float4 _DissEdgeColor;
		uniform float _End;
		uniform float _Start;


		float2 UnStereo( float2 UV )
		{
			#if UNITY_SINGLE_PASS_STEREO
			float4 scaleOffset = unity_StereoScaleOffset[ unity_StereoEyeIndex ];
			UV.xy = (UV.xy - scaleOffset.zw) / scaleOffset.xy;
			#endif
			return UV;
		}


		float3 InvertDepthDir72_g7( float3 In )
		{
			float3 result = In;
			#if !defined(ASE_SRP_VERSION) || ASE_SRP_VERSION <= 70301
			result *= float3(1,1,-1);
			#endif
			return result;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 temp_cast_0 = (0.0).xxx;
			float mulTime29 = _Time.y * _VertexOffsetTexPanner.z;
			float2 appendResult27 = (float2(_VertexOffsetTexPanner.x , _VertexOffsetTexPanner.y));
			float4 uvs_VertexOffsetTex = v.texcoord;
			uvs_VertexOffsetTex.xy = v.texcoord.xy * _VertexOffsetTex_ST.xy + _VertexOffsetTex_ST.zw;
			float2 panner30 = ( mulTime29 * appendResult27 + uvs_VertexOffsetTex.xy);
			float2 temp_cast_1 = (0.0).xx;
			float UV2_W12 = v.texcoord1.z;
			float UV2_T11 = v.texcoord1.w;
			float2 appendResult56 = (float2(UV2_W12 , UV2_T11));
			#ifdef _UV2_WTCONTORLOFFSET_ON
				float2 staticSwitch59 = appendResult56;
			#else
				float2 staticSwitch59 = temp_cast_1;
			#endif
			float4 tex2DNode31 = tex2Dlod( _VertexOffsetTex, float4( ( panner30 + staticSwitch59 ), 0, 0.0) );
			float temp_output_34_0 = (-1.0 + (tex2DNode31.r - 0.0) * (1.0 - -1.0) / (1.0 - 0.0));
			float3 appendResult44 = (float3(( temp_output_34_0 * _OffsetDir.x ) , ( temp_output_34_0 * _OffsetDir.y ) , ( temp_output_34_0 * _OffsetDir.z )));
			#ifdef _UV1_WCONTORLVERTEXOFFSET_ON
				float staticSwitch16 = v.texcoord.z;
			#else
				float staticSwitch16 = 1.0;
			#endif
			float UV1_W17 = staticSwitch16;
			float4 uvs_VertexOffsetMask = v.texcoord;
			uvs_VertexOffsetMask.xy = v.texcoord.xy * _VertexOffsetMask_ST.xy + _VertexOffsetMask_ST.zw;
			float3 ase_vertexNormal = v.normal.xyz;
			#ifdef _VERTEXOFFSETON_ON
				float3 staticSwitch48 = ( appendResult44 * ( UV1_W17 * tex2Dlod( _VertexOffsetMask, float4( uvs_VertexOffsetMask.xy, 0, 0.0) ).r * ( 0.1 * _VertexOffsetStr ) ) * ase_vertexNormal );
			#else
				float3 staticSwitch48 = temp_cast_0;
			#endif
			float3 VertexOffset49 = staticSwitch48;
			v.vertex.xyz += VertexOffset49;
			v.vertex.w = 1;
		}

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			#ifdef _UV1_TCONTORLDIS_ON
				float staticSwitch13 = i.uv_texcoord.w;
			#else
				float staticSwitch13 = _Dissolution;
			#endif
			float UV1_T14 = staticSwitch13;
			float temp_output_126_0 = ( 1.0 - UV1_T14 );
			float mulTime112 = _Time.y * _DissolutionTexPanner.z;
			float2 appendResult115 = (float2(_DissolutionTexPanner.x , _DissolutionTexPanner.y));
			float4 uvs_DissolutionTex = i.uv_texcoord;
			uvs_DissolutionTex.xy = i.uv_texcoord.xy * _DissolutionTex_ST.xy + _DissolutionTex_ST.zw;
			float2 panner117 = ( mulTime112 * appendResult115 + uvs_DissolutionTex.xy);
			float4 tex2DNode123 = tex2D( _DissolutionTex, panner117 );
			float lerpResult135 = lerp( tex2DNode123.r , ( 1.0 - tex2DNode123.r ) , _Invers);
			float smoothstepResult139 = smoothstep( temp_output_126_0 , ( temp_output_126_0 + _Float10 ) , lerpResult135);
			#ifdef _DISSOLUTIONON_ON
				float staticSwitch164 = smoothstepResult139;
			#else
				float staticSwitch164 = 1.0;
			#endif
			float mulTime67 = _Time.y * _MainTexPanner.z;
			float2 appendResult69 = (float2(_MainTexPanner.x , _MainTexPanner.y));
			float4 uvs_MainTex = i.uv_texcoord;
			uvs_MainTex.xy = i.uv_texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
			float2 panner71 = ( mulTime67 * appendResult69 + uvs_MainTex.xy);
			float UV2_W12 = i.uv2_texcoord2.z;
			float UV2_T11 = i.uv2_texcoord2.w;
			float2 appendResult66 = (float2(UV2_W12 , UV2_T11));
			#ifdef _UV2_WTCONTROLOFFSET_ON
				float2 staticSwitch74 = ( uvs_MainTex.xy + appendResult66 );
			#else
				float2 staticSwitch74 = panner71;
			#endif
			float2 temp_cast_0 = (0.5).xx;
			float cos78 = cos( ( (0.0 + (_Rotater - 0.0) * (2.0 - 0.0) / (360.0 - 0.0)) * UNITY_PI ) );
			float sin78 = sin( ( (0.0 + (_Rotater - 0.0) * (2.0 - 0.0) / (360.0 - 0.0)) * UNITY_PI ) );
			float2 rotator78 = mul( staticSwitch74 - temp_cast_0 , float2x2( cos78 , -sin78 , sin78 , cos78 )) + temp_cast_0;
			float4 tex2DNode88 = tex2D( _MainTex, rotator78 );
			#ifdef _ALPHACHANNEL_ON
				float staticSwitch84 = tex2DNode88.a;
			#else
				float staticSwitch84 = tex2DNode88.r;
			#endif
			float MainTexAlpha85 = staticSwitch84;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth146 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth146 = abs( ( screenDepth146 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _FadeRange ) );
			#ifdef _SOFTPARTICLE_ON
				float staticSwitch152 = distanceDepth146;
			#else
				float staticSwitch152 = 1.0;
			#endif
			float SoftParticle158 = saturate( staticSwitch152 );
			float VertexColorA107 = i.vertexColor.a;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float3 ase_normWorldNormal = normalize( ase_worldNormal );
			float3 appendResult116 = (float3(ase_normWorldNormal.x , ase_normWorldNormal.y , -ase_normWorldNormal.z));
			float3 switchResult121 = (((i.ASEVFace>0)?(ase_normWorldNormal):(appendResult116)));
			float3 WorldNormal125 = switchResult121;
			float fresnelNdotV137 = dot( WorldNormal125, ase_worldViewDir );
			float fresnelNode137 = ( 0.0 + _FreScale * pow( max( 1.0 - fresnelNdotV137 , 0.0001 ), _FrePower ) );
			float lerpResult148 = lerp( ( 1.0 - fresnelNode137 ) , fresnelNode137 , _FreInvers);
			float clampResult151 = clamp( lerpResult148 , 0.0 , 1.0 );
			float FreOP155 = clampResult151;
			float lerpResult168 = lerp( 1.0 , FreOP155 , _FreOn);
			float mulTime29 = _Time.y * _VertexOffsetTexPanner.z;
			float2 appendResult27 = (float2(_VertexOffsetTexPanner.x , _VertexOffsetTexPanner.y));
			float4 uvs_VertexOffsetTex = i.uv_texcoord;
			uvs_VertexOffsetTex.xy = i.uv_texcoord.xy * _VertexOffsetTex_ST.xy + _VertexOffsetTex_ST.zw;
			float2 panner30 = ( mulTime29 * appendResult27 + uvs_VertexOffsetTex.xy);
			float2 temp_cast_1 = (0.0).xx;
			float2 appendResult56 = (float2(UV2_W12 , UV2_T11));
			#ifdef _UV2_WTCONTORLOFFSET_ON
				float2 staticSwitch59 = appendResult56;
			#else
				float2 staticSwitch59 = temp_cast_1;
			#endif
			float4 tex2DNode31 = tex2D( _VertexOffsetTex, ( panner30 + staticSwitch59 ) );
			float Mas51 = tex2DNode31.r;
			float FinalOpacity171 = saturate( ( staticSwitch164 * MainTexAlpha85 * SoftParticle158 * VertexColorA107 * lerpResult168 * step( 0.5 , ( Mas51 + _HeadCutRange ) ) ) );
			float4 MainTexColor83 = (tex2DNode88).rgba;
			float4 uvs_RampTex = i.uv_texcoord;
			uvs_RampTex.xy = i.uv_texcoord.xy * _RampTex_ST.xy + _RampTex_ST.zw;
			float4 VertexColorRGB106 = i.vertexColor;
			float4 temp_cast_2 = (0.0).xxxx;
			float temp_output_131_0 = ( temp_output_126_0 + _Float14 );
			float smoothstepResult140 = smoothstep( temp_output_131_0 , ( temp_output_131_0 + _Float10 ) , lerpResult135);
			float4 EmissEdgeColor156 = (( _ToggleSwitch4 )?( ( ( smoothstepResult139 - smoothstepResult140 ) * _DissEdgeColor ) ):( temp_cast_2 ));
			float4 MainColor102 = ( ( MainTexColor83 * tex2D( _RampTex, uvs_RampTex.xy ) * VertexColorRGB106 * _MainColor ) + EmissEdgeColor156 );
			float temp_output_11_0_g1 = _End;
			float2 UV22_g8 = ase_screenPosNorm.xy;
			float2 localUnStereo22_g8 = UnStereo( UV22_g8 );
			float2 break64_g7 = localUnStereo22_g8;
			float clampDepth69_g7 = SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy );
			#ifdef UNITY_REVERSED_Z
				float staticSwitch38_g7 = ( 1.0 - clampDepth69_g7 );
			#else
				float staticSwitch38_g7 = clampDepth69_g7;
			#endif
			float3 appendResult39_g7 = (float3(break64_g7.x , break64_g7.y , staticSwitch38_g7));
			float4 appendResult42_g7 = (float4((appendResult39_g7*2.0 + -1.0) , 1.0));
			float4 temp_output_43_0_g7 = mul( unity_CameraInvProjection, appendResult42_g7 );
			float3 temp_output_46_0_g7 = ( (temp_output_43_0_g7).xyz / (temp_output_43_0_g7).w );
			float3 In72_g7 = temp_output_46_0_g7;
			float3 localInvertDepthDir72_g7 = InvertDepthDir72_g7( In72_g7 );
			float4 appendResult49_g7 = (float4(localInvertDepthDir72_g7 , 1.0));
			float4 WorldPosFormDepth197 = mul( unity_CameraToWorld, appendResult49_g7 );
			float clampResult7_g1 = clamp( ( ( temp_output_11_0_g1 - distance( WorldPosFormDepth197 , float4( _WorldSpaceCameraPos , 0.0 ) ) ) / ( temp_output_11_0_g1 - _Start ) ) , 0.0 , 1.0 );
			float Fog202 = ( 1.0 - ( 1.0 - clampResult7_g1 ) );
			#ifdef _FOGON_ON
				float staticSwitch204 = Fog202;
			#else
				float staticSwitch204 = 1.0;
			#endif
			float4 lerpResult208 = lerp( _FogColor , MainColor102 , staticSwitch204);
			c.rgb = lerpResult208.rgb;
			c.a = FinalOpacity171;
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
-1549;693;1492;812;-520.581;997.4697;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;109;5562.537,-2160.003;Inherit;False;1088.13;274.4167;WorldNormal;5;125;121;116;113;111;WorldNormal;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;7;-2607.153,-778.2181;Inherit;False;1252.226;378.732;Comment;7;17;16;15;14;13;10;9;UV1;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldNormalVector;111;5612.537,-2110.003;Inherit;False;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;6;-2607.913,-327.9151;Inherit;False;1143.907;365.912;Comment;3;12;11;8;UV2;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;108;1394.978,-3152.017;Inherit;False;4022.833;1852.103;Comment;43;171;170;169;168;167;165;164;162;161;160;159;157;156;154;150;149;145;144;140;139;138;136;135;134;131;130;129;127;126;123;122;120;119;118;117;115;114;112;110;54;52;53;188;FinalOpacity;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-2346.59,-484.4299;Inherit;False;Property;_Dissolution;Dissolution;26;0;Create;True;0;0;0;False;0;False;0.15;0.476;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;10;-2557.153,-701.4861;Inherit;True;0;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NegateNode;113;5815.263,-1996.586;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;110;1467.164,-2582.288;Inherit;False;Property;_DissolutionTexPanner;DissolutionTexPanner;25;0;Create;True;0;0;0;False;0;False;0,0,1;0,-0.2,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TextureCoordinatesNode;8;-2578.884,-263.994;Inherit;False;1;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;13;-2010.564,-556.583;Inherit;False;Property;_UV1_TContorlDis;UV1_TContorlDis;24;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;116;5972.263,-2053.586;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;114;1565.345,-2733.531;Inherit;False;0;123;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;11;-2111.839,-150.941;Inherit;False;UV2_T;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;115;1764.163,-2621.288;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;12;-2110.375,-245.6319;Inherit;False;UV2_W;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;61;-1677.549,-3032.815;Inherit;False;2819.581;793.3801;MainTex;24;88;81;80;78;77;76;75;74;73;72;71;70;69;68;67;66;65;64;63;62;82;83;84;85;MainTex;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleTimeNode;112;1761.163,-2467.288;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;14;-1634.321,-559.7939;Inherit;False;UV1_T;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;25;-1089.706,833.5085;Inherit;False;2578.479;1252.42;VertexOffset;31;49;48;47;46;45;44;43;42;41;40;39;38;37;36;35;34;33;32;31;30;29;28;27;26;55;56;57;58;59;60;51;VertexOffset;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;119;2133.551,-2424.22;Inherit;False;14;UV1_T;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;63;-1583.211,-2473.526;Inherit;False;12;UV2_W;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwitchByFaceNode;121;6209.263,-2104.586;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;62;-1580.481,-2378.878;Inherit;False;11;UV2_T;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;117;1936.741,-2715.55;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector3Node;64;-1627.549,-2822.571;Inherit;False;Property;_MainTexPanner;MainTexPanner;14;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;124;5547.462,-3032.32;Inherit;False;1485.673;682.3762;FreOP;9;155;151;148;142;141;137;133;132;128;FreOP;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;66;-1348.938,-2451.96;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector3Node;26;-1103.832,1073.199;Inherit;False;Property;_VertexOffsetTexPanner;VertexOffsetTexPanner;20;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;125;6426.667,-2108.732;Inherit;False;WorldNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;58;-990.8349,1450.235;Inherit;False;11;UV2_T;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;57;-998.8349,1373.235;Inherit;False;12;UV2_W;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;69;-1376.55,-2869.571;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;67;-1379.55,-2715.571;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;70;-1642.366,-2989.815;Inherit;False;0;88;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;68;-1439.443,-2610.294;Inherit;False;0;88;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;122;2357.322,-2173.667;Inherit;False;Property;_Float14;DissEdgeWidth;33;0;Create;False;0;0;0;False;0;False;0.1;0.1;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;65;-1005.099,-2603.899;Inherit;False;Property;_Rotater;Rotater;11;0;Create;True;0;0;0;False;0;False;0;0;0;360;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;123;2313.588,-2796.239;Inherit;True;Property;_DissolutionTex;DissolutionTex;22;1;[Header];Create;True;1;Dissolution;0;0;False;0;False;-1;None;f69b5bbf3863af147872e70002ed843e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;126;2351.731,-2419.052;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;128;5578.531,-2898.493;Inherit;False;125;WorldNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;60;-801.6829,1282.403;Inherit;False;Constant;_Float1;Float 1;18;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;127;2664.333,-2595.441;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;29;-783.9386,1169.815;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;56;-795.2087,1393.94;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;28;-940.1947,895.6606;Inherit;False;0;31;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;73;-732.3287,-2598.177;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;360;False;3;FLOAT;0;False;4;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;27;-749.9376,1075.815;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;133;5631.815,-2709.872;Inherit;False;Property;_FrePower;FrePower;44;0;Create;True;0;0;0;False;0;False;5;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;132;5601.462,-2799.886;Inherit;False;Property;_FreScale;FreScale;43;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;130;2358.859,-2052.816;Inherit;False;Property;_Float10;DissSoft;28;0;Create;False;0;0;0;False;0;False;0;0.099;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;131;2810.334,-2185.413;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;72;-1164.487,-2581.601;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;129;2376.557,-2554.24;Inherit;False;Property;_Invers;Invers;30;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;71;-1194.87,-2901.434;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;76;-698.0638,-2699.195;Inherit;False;Constant;_Float11;Float 11;26;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;136;2938.334,-2073.413;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;138;3827.812,-1671.275;Inherit;False;1080.439;324.1655;SoftParticle;6;158;153;152;147;146;143;SoftParticle;1,1,1,1;0;0
Node;AmplifyShaderEditor.LerpOp;135;2860.334,-2613.342;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;137;5820.776,-2873.006;Inherit;True;Standard;WorldNormal;ViewDir;False;True;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;59;-609.5305,1315.211;Inherit;False;Property;_UV2_WTContorlOffset;UV2_WTContorlOffset;17;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;201;44.0948,-98.54707;Inherit;False;2078.375;514.0557;Comment;10;202;199;194;189;196;191;192;195;198;197;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;134;2721.661,-2308.417;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;74;-935.4737,-2786.054;Inherit;False;Property;_UV2_WTControlOffset;UV2_WTControlOffset;7;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PiNode;75;-556.0367,-2598.184;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;30;-607.6726,987.4014;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;198;96.78323,40.17088;Inherit;False;Reconstruct World Position From Depth;-1;;7;e7094bcbcc80eb140b2a3dbe6a861de8;0;0;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;141;6019.606,-2541.463;Inherit;False;Property;_FreInvers;FreInvers;42;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;55;-413.5012,1112.028;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;142;6132.771,-2805.144;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;139;3087.12,-2471.373;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;140;3087.962,-2228.144;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;78;-363.1009,-2765.575;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;143;3889.151,-1483.296;Inherit;False;Property;_FadeRange;FadeRange;39;1;[Header];Create;True;1;SoftParticle;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;31;-293.2824,956.7205;Inherit;True;Property;_VertexOffsetTex;VertexOffsetTex;15;1;[Header];Create;True;1;VertexOffset;0;0;False;0;False;-1;None;08697de5c04370349835b5ecc1b30810;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;15;-2293.635,-728.2181;Inherit;False;Constant;_Float0;Float 0;7;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;197;458.2162,-8.292524;Inherit;False;WorldPosFormDepth;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DepthFade;146;4068.677,-1503.109;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;148;6313.606,-2875.463;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;88;-41.61879,-2779.45;Inherit;True;Property;_MainTex;MainTex;8;0;Create;True;0;0;0;False;0;False;-1;None;7d2e76a76747b2b4ab1da697163ef330;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;145;3234.539,-1967.91;Inherit;False;Property;_DissEdgeColor;DissEdgeColor;32;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;2.558482,0.9286558,0.4441137,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;104;560.0229,-1944.814;Inherit;False;498.0005;281.3341;VertexColor;3;105;106;107;VertexColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;144;3311.524,-2325.929;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;147;4097.764,-1598.593;Inherit;False;Constant;_Float3;Float 3;14;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;16;-1998.325,-720.429;Inherit;False;Property;_UV1_WContorlVertexOffset;UV1_WContorlVertexOffset;13;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;151;6564.111,-2875.742;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;79;-1658.951,-1975.181;Inherit;False;2096.024;1032.097;MainColor;14;101;100;99;98;97;96;95;94;93;92;91;90;89;102;MainColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;51;37.3579,878.3511;Inherit;False;Mas;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;152;4332.41,-1591.348;Inherit;False;Property;_SoftParticle;SoftParticle;40;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;105;610.0229,-1894.814;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldSpaceCameraPos;195;704.1304,124.7645;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;149;3511.328,-2091.624;Inherit;False;Constant;_Float26;Float 26;40;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;82;407.3389,-2783.565;Inherit;False;True;True;True;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;150;3501.994,-1978.083;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;194;720.1304,28.76447;Inherit;False;197;WorldPosFormDepth;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.Vector3Node;35;19.30006,1217.795;Inherit;True;Property;_OffsetDir;OffsetDir;21;0;Create;True;0;0;0;False;0;False;1,1,1;1,1,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;192;1168.131,300.7645;Inherit;False;Property;_End;End;48;0;Create;True;0;0;0;False;0;False;700;23.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;17;-1630.778,-718.0821;Inherit;False;UV1_W;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;191;1184.131,204.7645;Inherit;False;Property;_Start;Start;47;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;196;1152.131,60.76446;Inherit;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-343.0701,1906.942;Inherit;False;Constant;_Float7;Float 7;25;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;153;4564.365,-1569.526;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;34;38.52027,987.8428;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-1;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;54;4027.053,-2066.723;Inherit;False;Property;_HeadCutRange;HeadCutRange;5;0;Create;True;0;0;0;False;0;False;0;0.46;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;154;3727.904,-1988.156;Inherit;False;Property;_ToggleSwitch4;DissEdgeOn;31;0;Create;False;0;0;0;False;0;False;1;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;33;-560.261,1707.885;Inherit;False;0;38;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;84;436.2374,-2676.436;Inherit;False;Property;_AlphaChannel;AlphaChannel;10;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;52;4037.695,-2186.845;Inherit;False;51;Mas;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;92;-1589.393,-1709.556;Inherit;False;0;98;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;155;6718.316,-2881.228;Inherit;False;FreOP;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;83;676.6997,-2777.727;Inherit;False;MainTexColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-371.3711,1999.641;Inherit;False;Property;_VertexOffsetStr;VertexOffsetStr;18;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;106;827.0236,-1885.908;Inherit;False;VertexColorRGB;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;53;4348.03,-2220.702;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;160;4076.717,-2519.774;Inherit;False;Constant;_Float15;Float 15;39;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;161;4045.454,-2420.379;Inherit;False;155;FreOP;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;158;4695.145,-1586.739;Inherit;False;SoftParticle;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;85;732.1484,-2662.557;Inherit;False;MainTexAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;311.843,1159.785;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;107;828.6984,-1779.48;Inherit;False;VertexColorA;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;189;1424.131,108.7645;Inherit;False;Fog Linear;-1;;1;4c9a774ba65ded846812a5c17586cdf5;0;3;13;FLOAT;500;False;12;FLOAT;0;False;11;FLOAT;700;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;307.958,1312.554;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;41;-207.8831,1578.127;Inherit;False;17;UV1_W;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;-115.1609,1971.066;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;97;-663.7218,-1382.909;Inherit;False;106;VertexColorRGB;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;98;-679.1348,-1684.341;Inherit;True;Property;_RampTex;RampTex;12;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;96;-649.1937,-1913.744;Inherit;True;83;MainTexColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;95;-646.1827,-1253.041;Inherit;False;Property;_MainColor;MainColor;6;2;[HDR];[Header];Create;True;1;Main;0;0;False;0;False;0,0,0,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;316.59,1012.608;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;156;3987.621,-1944.455;Inherit;False;EmissEdgeColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;159;3718.973,-2890.1;Inherit;False;Constant;_Float4;Float 4;52;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;38;-271.8459,1686.22;Inherit;True;Property;_VertexOffsetMask;VertexOffsetMask;19;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;157;3995.227,-2309.882;Inherit;False;Property;_FreOn;FreOn;41;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;99;-269.5258,-1527.063;Inherit;False;156;EmissEdgeColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;231.51,1589.155;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;164;3965.897,-2891.282;Inherit;False;Property;_DissolutionOn;DissolutionOn;23;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;162;4282.758,-2669.855;Inherit;False;158;SoftParticle;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;168;4319.366,-2489.775;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;167;4273.389,-2575.04;Inherit;False;107;VertexColorA;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;165;4272.414,-2754.093;Inherit;False;85;MainTexAlpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;199;1648.131,108.7645;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;100;-250.4468,-1718.238;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;188;4518.046,-2326.504;Inherit;False;2;0;FLOAT;0.5;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;43;218.9501,1745.999;Inherit;True;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;44;517.5491,1095.401;Inherit;True;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;101;1.952248,-1660.838;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;169;4651.571,-2748.549;Inherit;True;6;6;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;202;1850.981,105.6076;Inherit;False;Fog;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;46;763.66,1153.472;Inherit;False;Constant;_Float2;Float 2;27;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;786.77,1291.956;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;170;4864.624,-2742.681;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;48;964.994,1224.684;Inherit;False;Property;_VertexOffsetOn;VertexOffsetOn;16;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;205;958.0248,-473.5113;Inherit;False;Constant;_Float5;Float 5;48;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;203;889.5493,-374.7835;Inherit;False;202;Fog;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;102;175.7452,-1678.204;Inherit;False;MainColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;49;1253.458,1290.189;Inherit;False;VertexOffset;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;204;1127.865,-469.9976;Inherit;False;Property;_FogOn;FogOn;45;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;207;908.5811,-819.4697;Inherit;False;Property;_FogColor;FogColor;46;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.1031684,0.3844019,0.5943396,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;103;930.837,-622.0568;Inherit;False;102;MainColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;1;-2605.083,122.7376;Inherit;False;1124.562;519.4683;Comment;4;5;4;3;2;UV3;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;171;5157.127,-2745.748;Inherit;False;FinalOpacity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;172;-1662.374,-4358.916;Inherit;False;1883.194;986.6012;DisturbColor;14;186;185;184;183;182;181;180;179;178;177;176;175;174;173;DisturbColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;18;-3123.357,-780.8113;Inherit;False;490.0942;445.175;Enum;4;22;21;20;19;Enum;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;183;-395.686,-3959.943;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;118;1862.253,-2867.751;Inherit;False;-1;;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-3072.386,-540.9502;Inherit;False;Property;_ZWriteMode;ZWriteMode;3;1;[Enum];Create;True;0;2;On;1;Off;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;90;-1566.423,-1334.513;Inherit;False;Property;_RampDisStr;RampDisStr;29;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;80;-221.1048,-2639.084;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;81;-87.61184,-2884.763;Inherit;False;MainTexUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;176;-1307.152,-4102.583;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;182;-581.104,-3779.886;Inherit;False;Property;_DisturbDir;DisturbDir;37;0;Create;True;0;0;0;False;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;181;-553.7393,-3964.038;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-3069.877,-730.8123;Inherit;False;Property;_CullMode;CullMode;1;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;4;-2238.618,212.0436;Inherit;False;Property;_UV3_XContorlDisturb;UV3_XContorlDisturb;9;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;175;-1504.968,-4215.825;Inherit;False;0;179;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;177;-1125.471,-4134.445;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;89;-1554.044,-1435.66;Inherit;False;-1;;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;174;-1310.152,-3948.582;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;178;-806.2028,-3816.916;Inherit;False;5;UV3_X;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;94;-950.1456,-1499.16;Inherit;False;Property;_DisturbRamp;DisturbRamp;27;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;185;-245.683,-4105.979;Inherit;False;Property;_DisturbOn;DisturbOn;35;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;184;-509.1411,-4197.315;Inherit;False;Constant;_0;0;32;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;173;-1558.15,-4055.582;Inherit;False;Property;_DisturbPanner;DisturbPanner;36;0;Create;True;0;0;0;False;0;False;0,0,1;0.3,0.3,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;179;-886.3355,-4146.291;Inherit;True;Property;_DisturbTex;DisturbTex;34;1;[Header];Create;True;1;Disturb;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;21;-3069.448,-434.5021;Inherit;False;Property;_Dst;Dst;2;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;0;False;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;77;-527.9485,-2440.426;Inherit;False;-1;;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;180;-796.1119,-3940.604;Inherit;False;Property;_DisturbStr;DisturbStr;38;0;Create;True;0;0;0;False;0;False;0;-0.07;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-3073.357,-633.0593;Inherit;False;Property;_ZTestMode;ZTestMode;4;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CompareFunction;True;0;False;8;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;120;2167.904,-2907.842;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;91;-1263.324,-1445.913;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;93;-1083.558,-1458.186;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;5;-1919.445,235.4086;Inherit;False;UV3_X;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;50;1380.476,-490.3787;Inherit;False;49;VertexOffset;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;187;1206.539,-901.3521;Inherit;False;171;FinalOpacity;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-2538.565,298.0645;Inherit;False;2;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;186;-3.007196,-4099.132;Inherit;False;DisturbColor;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;2;-2500.618,183.0437;Inherit;False;Constant;_Float12;Float 12;28;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;208;1288.581,-729.4697;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1742.635,-948.956;Float;False;True;-1;2;ASEMaterialInspector;0;0;CustomLighting;Whl/Fx/Vine;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;0;True;19;0;True;22;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;True;21;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;True;20;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;113;0;111;3
WireConnection;13;1;9;0
WireConnection;13;0;10;4
WireConnection;116;0;111;1
WireConnection;116;1;111;2
WireConnection;116;2;113;0
WireConnection;11;0;8;4
WireConnection;115;0;110;1
WireConnection;115;1;110;2
WireConnection;12;0;8;3
WireConnection;112;0;110;3
WireConnection;14;0;13;0
WireConnection;121;0;111;0
WireConnection;121;1;116;0
WireConnection;117;0;114;0
WireConnection;117;2;115;0
WireConnection;117;1;112;0
WireConnection;66;0;63;0
WireConnection;66;1;62;0
WireConnection;125;0;121;0
WireConnection;69;0;64;1
WireConnection;69;1;64;2
WireConnection;67;0;64;3
WireConnection;123;1;117;0
WireConnection;126;0;119;0
WireConnection;127;0;123;1
WireConnection;29;0;26;3
WireConnection;56;0;57;0
WireConnection;56;1;58;0
WireConnection;73;0;65;0
WireConnection;27;0;26;1
WireConnection;27;1;26;2
WireConnection;131;0;126;0
WireConnection;131;1;122;0
WireConnection;72;0;68;0
WireConnection;72;1;66;0
WireConnection;71;0;70;0
WireConnection;71;2;69;0
WireConnection;71;1;67;0
WireConnection;136;0;131;0
WireConnection;136;1;130;0
WireConnection;135;0;123;1
WireConnection;135;1;127;0
WireConnection;135;2;129;0
WireConnection;137;0;128;0
WireConnection;137;2;132;0
WireConnection;137;3;133;0
WireConnection;59;1;60;0
WireConnection;59;0;56;0
WireConnection;134;0;126;0
WireConnection;134;1;130;0
WireConnection;74;1;71;0
WireConnection;74;0;72;0
WireConnection;75;0;73;0
WireConnection;30;0;28;0
WireConnection;30;2;27;0
WireConnection;30;1;29;0
WireConnection;55;0;30;0
WireConnection;55;1;59;0
WireConnection;142;0;137;0
WireConnection;139;0;135;0
WireConnection;139;1;126;0
WireConnection;139;2;134;0
WireConnection;140;0;135;0
WireConnection;140;1;131;0
WireConnection;140;2;136;0
WireConnection;78;0;74;0
WireConnection;78;1;76;0
WireConnection;78;2;75;0
WireConnection;31;1;55;0
WireConnection;197;0;198;0
WireConnection;146;0;143;0
WireConnection;148;0;142;0
WireConnection;148;1;137;0
WireConnection;148;2;141;0
WireConnection;88;1;78;0
WireConnection;144;0;139;0
WireConnection;144;1;140;0
WireConnection;16;1;15;0
WireConnection;16;0;10;3
WireConnection;151;0;148;0
WireConnection;51;0;31;1
WireConnection;152;1;147;0
WireConnection;152;0;146;0
WireConnection;82;0;88;0
WireConnection;150;0;144;0
WireConnection;150;1;145;0
WireConnection;17;0;16;0
WireConnection;196;0;194;0
WireConnection;196;1;195;0
WireConnection;153;0;152;0
WireConnection;34;0;31;1
WireConnection;154;0;149;0
WireConnection;154;1;150;0
WireConnection;84;1;88;1
WireConnection;84;0;88;4
WireConnection;155;0;151;0
WireConnection;83;0;82;0
WireConnection;106;0;105;0
WireConnection;53;0;52;0
WireConnection;53;1;54;0
WireConnection;158;0;153;0
WireConnection;85;0;84;0
WireConnection;40;0;34;0
WireConnection;40;1;35;2
WireConnection;107;0;105;4
WireConnection;189;13;196;0
WireConnection;189;12;191;0
WireConnection;189;11;192;0
WireConnection;42;0;34;0
WireConnection;42;1;35;3
WireConnection;37;0;36;0
WireConnection;37;1;32;0
WireConnection;98;1;92;0
WireConnection;39;0;34;0
WireConnection;39;1;35;1
WireConnection;156;0;154;0
WireConnection;38;1;33;0
WireConnection;45;0;41;0
WireConnection;45;1;38;1
WireConnection;45;2;37;0
WireConnection;164;1;159;0
WireConnection;164;0;139;0
WireConnection;168;0;160;0
WireConnection;168;1;161;0
WireConnection;168;2;157;0
WireConnection;199;0;189;0
WireConnection;100;0;96;0
WireConnection;100;1;98;0
WireConnection;100;2;97;0
WireConnection;100;3;95;0
WireConnection;188;1;53;0
WireConnection;44;0;39;0
WireConnection;44;1;40;0
WireConnection;44;2;42;0
WireConnection;101;0;100;0
WireConnection;101;1;99;0
WireConnection;169;0;164;0
WireConnection;169;1;165;0
WireConnection;169;2;162;0
WireConnection;169;3;167;0
WireConnection;169;4;168;0
WireConnection;169;5;188;0
WireConnection;202;0;199;0
WireConnection;47;0;44;0
WireConnection;47;1;45;0
WireConnection;47;2;43;0
WireConnection;170;0;169;0
WireConnection;48;1;46;0
WireConnection;48;0;47;0
WireConnection;102;0;101;0
WireConnection;49;0;48;0
WireConnection;204;1;205;0
WireConnection;204;0;203;0
WireConnection;171;0;170;0
WireConnection;183;0;181;0
WireConnection;183;1;182;0
WireConnection;81;0;78;0
WireConnection;176;0;173;1
WireConnection;176;1;173;2
WireConnection;181;0;179;1
WireConnection;181;1;180;0
WireConnection;181;2;178;0
WireConnection;4;1;2;0
WireConnection;4;0;3;1
WireConnection;177;0;175;0
WireConnection;177;2;176;0
WireConnection;177;1;174;0
WireConnection;174;0;173;3
WireConnection;94;0;92;0
WireConnection;185;1;184;0
WireConnection;185;0;183;0
WireConnection;179;1;177;0
WireConnection;91;0;89;0
WireConnection;91;1;90;0
WireConnection;93;1;91;0
WireConnection;5;0;4;0
WireConnection;186;0;185;0
WireConnection;208;0;207;0
WireConnection;208;1;103;0
WireConnection;208;2;204;0
WireConnection;0;9;187;0
WireConnection;0;13;208;0
WireConnection;0;11;50;0
ASEEND*/
//CHKSM=68A69EBA27DCE8B844A808EE32D7262CD7125ED4