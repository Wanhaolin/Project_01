// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Whl/Fx/SpringLine"
{
	Properties
	{
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("CullMode", Float) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)]_ZTestMode("ZTestMode", Float) = 8
		[HDR]_MainColor("MainColor", Color) = (0,0,0,0)
		_WaveLength("WaveLength", Float) = 6
		_Speed("Speed", Float) = 0
		_MainTex("MainTex", 2D) = "white" {}
		_Amplitude("Amplitude", Float) = 0.5
		_Power("Power", Float) = -0.35
		_MainTilingOffset("MainTilingOffset", Vector) = (1,1.5,0,-0.25)
		_RampTex("RampTex", 2D) = "white" {}
		_FadeTex("FadeTex", 2D) = "white" {}
		_DisTex("DisTex", 2D) = "white" {}
		[Toggle(_UV2_WCONTORLDIS_ON)] _UV2_WContorlDis("UV2_WContorlDis", Float) = 0
		_DisTexPanner("DisTexPanner", Vector) = (0,0,1,0)
		_DisInvers("DisInvers", Range( 0 , 1)) = 0
		_Dissolution("Dissolution", Range( 0 , 1)) = 0
		_DissHardness("DissHardness", Range( 0 , 0.999)) = 0
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull [_CullMode]
		ZWrite Off
		ZTest [_ZTestMode]
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _UV2_WCONTORLDIS_ON
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 uv_texcoord;
			float4 vertexColor : COLOR;
			float4 uv2_texcoord2;
		};

		uniform float _CullMode;
		uniform float _ZTestMode;
		uniform float4 _MainColor;
		uniform sampler2D _MainTex;
		uniform float _WaveLength;
		uniform float _Speed;
		uniform float _Amplitude;
		uniform float _Power;
		uniform float4 _MainTilingOffset;
		uniform sampler2D _RampTex;
		uniform float4 _RampTex_ST;
		uniform sampler2D _FadeTex;
		uniform float4 _FadeTex_ST;
		uniform sampler2D _DisTex;
		uniform float3 _DisTexPanner;
		uniform float4 _DisTex_ST;
		uniform float _DisInvers;
		uniform float _Dissolution;
		uniform float _DissHardness;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float mulTime6 = _Time.y * _Speed;
			float2 appendResult15 = (float2(i.uv_texcoord.xy.x , ( i.uv_texcoord.xy.y - ( sin( ( ( i.uv_texcoord.xy.x * _WaveLength * i.uv_texcoord.w ) + mulTime6 ) ) * ( ( _Amplitude * i.uv_texcoord.z ) * _Power ) ) )));
			float2 appendResult19 = (float2(_MainTilingOffset.x , _MainTilingOffset.y));
			float2 appendResult20 = (float2(_MainTilingOffset.z , _MainTilingOffset.w));
			float2 lerpResult29 = lerp( (saturate( appendResult15 )*appendResult19 + appendResult20) , i.uv_texcoord.xy , saturate( ( i.uv_texcoord.xy.x * i.uv_texcoord.z ) ));
			float4 tex2DNode21 = tex2D( _MainTex, lerpResult29 );
			float2 uv_RampTex = i.uv_texcoord * _RampTex_ST.xy + _RampTex_ST.zw;
			o.Emission = ( _MainColor * tex2DNode21.r * i.vertexColor * tex2D( _RampTex, uv_RampTex ) ).rgb;
			float4 uvs_FadeTex = i.uv_texcoord;
			uvs_FadeTex.xy = i.uv_texcoord.xy * _FadeTex_ST.xy + _FadeTex_ST.zw;
			float mulTime50 = _Time.y * _DisTexPanner.z;
			float2 appendResult49 = (float2(_DisTexPanner.x , _DisTexPanner.y));
			float4 uvs_DisTex = i.uv_texcoord;
			uvs_DisTex.xy = i.uv_texcoord.xy * _DisTex_ST.xy + _DisTex_ST.zw;
			float2 panner47 = ( mulTime50 * appendResult49 + uvs_DisTex.xy);
			float temp_output_3_0_g1 = tex2D( _DisTex, panner47 ).r;
			float lerpResult5_g1 = lerp( temp_output_3_0_g1 , ( 1.0 - temp_output_3_0_g1 ) , _DisInvers);
			float UV2_W55 = i.uv2_texcoord2.z;
			#ifdef _UV2_WCONTORLDIS_ON
				float staticSwitch57 = UV2_W55;
			#else
				float staticSwitch57 = _Dissolution;
			#endif
			float temp_output_8_0_g1 = _DissHardness;
			o.Alpha = ( ( tex2DNode21.r * tex2DNode21.a ) * i.vertexColor.a * tex2D( _FadeTex, uvs_FadeTex.xy ).r * saturate( ( ( ( ( lerpResult5_g1 + 1.0 ) - ( ( 1.0 - (-0.5 + (staticSwitch57 - 0.0) * (1.0 - -0.5) / (1.0 - 0.0)) ) * ( ( 1.0 - temp_output_8_0_g1 ) + 1.0 ) ) ) - temp_output_8_0_g1 ) / ( temp_output_8_0_g1 - 1.0 ) ) ) );
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Unlit keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float4 customPack1 : TEXCOORD1;
				float4 customPack2 : TEXCOORD2;
				float3 worldPos : TEXCOORD3;
				half4 color : COLOR0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.customPack1.xyzw = customInputData.uv_texcoord;
				o.customPack1.xyzw = v.texcoord;
				o.customPack2.xyzw = customInputData.uv2_texcoord2;
				o.customPack2.xyzw = v.texcoord1;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				o.color = v.color;
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xyzw;
				surfIN.uv2_texcoord2 = IN.customPack2.xyzw;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.vertexColor = IN.color;
				SurfaceOutput o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutput, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
385.6;218.4;1373.6;847.8;-205.4681;-576.6803;1.647291;True;False
Node;AmplifyShaderEditor.RangedFloatNode;3;-883.3254,96.99323;Inherit;False;Property;_WaveLength;WaveLength;4;0;Create;True;0;0;0;False;0;False;6;15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-934.8538,221.5526;Inherit;False;Property;_Speed;Speed;5;0;Create;True;0;0;0;False;0;False;0;20;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-910.785,-29.24829;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;22;-1408.682,387.5813;Inherit;False;0;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;9;-571.6898,343.2068;Inherit;False;Property;_Amplitude;Amplitude;7;0;Create;True;0;0;0;False;0;False;0.5;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2;-622.2258,27.93802;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;6;-759.8538,227.5526;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-368.5204,420.2744;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-417.982,602.1166;Inherit;False;Property;_Power;Power;8;0;Create;True;0;0;0;False;0;False;-0.35;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;4;-404.8538,208.5526;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;7;-254.7914,229.5668;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-221.9821,413.1165;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;12;-350.6143,-76.45761;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-113.473,264.0483;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;13;172.9897,115.3771;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;18;491.3098,365.3505;Inherit;False;Property;_MainTilingOffset;MainTilingOffset;9;0;Create;True;0;0;0;False;0;False;1,1.5,0,-0.25;0,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;15;647.9321,64.85439;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector3Node;48;680.5835,1162.359;Inherit;False;Property;_DisTexPanner;DisTexPanner;14;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TextureCoordinatesNode;54;-1416.951,596.2561;Inherit;False;1;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;147.9583,290.1514;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;20;795.3376,537.8871;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;16;859.2724,66.95399;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;19;798.2716,300.6185;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;33;338.716,292.0241;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;49;944.5835,1146.359;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;46;722.5835,1020.359;Inherit;False;0;45;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;55;-1092.221,665.155;Inherit;False;UV2_W;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;50;930.5835,1237.359;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;30;1100.623,396.4657;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScaleAndOffsetNode;17;1104.022,116.8726;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;58;1387.336,1517.001;Inherit;False;55;UV2_W;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;59;1255.336,1416.001;Inherit;False;Property;_Dissolution;Dissolution;16;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;29;1379.535,208.8766;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;47;1177.583,1119.359;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;52;1532.256,1309.425;Inherit;False;Property;_DisInvers;DisInvers;15;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;45;1492.706,1095.08;Inherit;True;Property;_DisTex;DisTex;12;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;57;1631.336,1415.001;Inherit;False;Property;_UV2_WContorlDis;UV2_WContorlDis;13;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;21;1508.153,353.5948;Inherit;True;Property;_MainTex;MainTex;6;0;Create;True;0;0;0;False;0;False;-1;None;898cfb542f9b4e0478bb3ea8f030764d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;43;1270.69,794.9698;Inherit;False;0;42;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;60;1605.336,1580.001;Inherit;False;Property;_DissHardness;DissHardness;17;0;Create;True;0;0;0;False;0;False;0;0;0;0.999;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;36;1611.851,137.7201;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;38;1507.458,579.4749;Inherit;True;Property;_RampTex;RampTex;10;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;39;-455.3328,-760.9972;Inherit;False;448;277.753;Comment;2;41;40;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;44;1901.979,398.6396;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;42;1518.643,809.9217;Inherit;True;Property;_FadeTex;FadeTex;11;0;Create;True;0;0;0;False;0;False;-1;None;cdb2d2db9413c394dbec41075b788bff;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;34;1593.577,-99.58807;Inherit;False;Property;_MainColor;MainColor;3;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;25.41659,25.41659,25.41659,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;51;1943.339,1330.713;Inherit;False;Dissolution;-1;;1;8ed0a8fdbfe80554382ce257577aff19;0;4;3;FLOAT;0;False;7;FLOAT;0;False;4;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;40;-405.3328,-613.2441;Inherit;False;Property;_ZTestMode;ZTestMode;2;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CompareFunction;True;0;False;8;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;41;-401.8538,-710.9982;Inherit;False;Property;_CullMode;CullMode;1;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;1877.421,45.88744;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;2204.673,621.5615;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2347.249,-81.45205;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;Whl/Fx/SpringLine;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;2;False;-1;0;True;40;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Custom;;Transparent;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;True;41;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2;0;1;1
WireConnection;2;1;3;0
WireConnection;2;2;22;4
WireConnection;6;0;5;0
WireConnection;23;0;9;0
WireConnection;23;1;22;3
WireConnection;4;0;2;0
WireConnection;4;1;6;0
WireConnection;7;0;4;0
WireConnection;10;0;23;0
WireConnection;10;1;11;0
WireConnection;8;0;7;0
WireConnection;8;1;10;0
WireConnection;13;0;12;2
WireConnection;13;1;8;0
WireConnection;15;0;12;1
WireConnection;15;1;13;0
WireConnection;24;0;12;1
WireConnection;24;1;22;3
WireConnection;20;0;18;3
WireConnection;20;1;18;4
WireConnection;16;0;15;0
WireConnection;19;0;18;1
WireConnection;19;1;18;2
WireConnection;33;0;24;0
WireConnection;49;0;48;1
WireConnection;49;1;48;2
WireConnection;55;0;54;3
WireConnection;50;0;48;3
WireConnection;17;0;16;0
WireConnection;17;1;19;0
WireConnection;17;2;20;0
WireConnection;29;0;17;0
WireConnection;29;1;30;0
WireConnection;29;2;33;0
WireConnection;47;0;46;0
WireConnection;47;2;49;0
WireConnection;47;1;50;0
WireConnection;45;1;47;0
WireConnection;57;1;59;0
WireConnection;57;0;58;0
WireConnection;21;1;29;0
WireConnection;44;0;21;1
WireConnection;44;1;21;4
WireConnection;42;1;43;0
WireConnection;51;3;45;1
WireConnection;51;7;52;0
WireConnection;51;4;57;0
WireConnection;51;8;60;0
WireConnection;35;0;34;0
WireConnection;35;1;21;1
WireConnection;35;2;36;0
WireConnection;35;3;38;0
WireConnection;37;0;44;0
WireConnection;37;1;36;4
WireConnection;37;2;42;1
WireConnection;37;3;51;0
WireConnection;0;2;35;0
WireConnection;0;9;37;0
ASEEND*/
//CHKSM=3CCC986A0E7CD974D415ED6EFC3EAB54EB356025