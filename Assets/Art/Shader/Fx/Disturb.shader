// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Whl/Fx/Disturb"
{
	Properties
	{
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("CullMode", Float) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)]_ZTestMode("ZTestMode", Float) = 8
		_MainTex("MainTex", 2D) = "white" {}
		[Toggle(_UV2_WTCONTROLOFFSET_ON)] _UV2_WTControlOffset("UV2_WTControlOffset", Float) = 0
		_MainTexPanner("MainTexPanner", Vector) = (0,0,1,0)
		_DisturbDir("DisturbDir", Vector) = (1,1,0,0)
		_DisturbStr("DisturbStr", Float) = 0
		_FadeTex("FadeTex", 2D) = "white" {}
		[Toggle(_DISSOLUTIONON_ON)] _DissolutionOn("DissolutionOn", Float) = 0
		[Toggle(_UV1_TCONTORLDIS_ON)] _UV1_TContorlDis("UV1_TContorlDis", Float) = 0
		_DissolutionTex("DissolutionTex", 2D) = "white" {}
		_Dissolution("Dissolution", Range( 0 , 1)) = 0.15
		_DissolutionTexPanner("DissolutionTexPanner", Vector) = (0,0,1,0)
		_Float12("DissSoft", Range( 0 , 2)) = 0
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" }
		Cull [_CullMode]
		ZWrite On
		ZTest [_ZTestMode]
		Blend SrcAlpha OneMinusSrcAlpha
		
		GrabPass{ }
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _UV2_WTCONTROLOFFSET_ON
		#pragma shader_feature_local _DISSOLUTIONON_ON
		#pragma shader_feature_local _UV1_TCONTORLDIS_ON
		#if defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_STEREO_MULTIVIEW_ENABLED)
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex);
		#else
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex)
		#endif
		#pragma surface surf StandardCustomLighting keepalpha addshadow fullforwardshadows noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 screenPos;
			float4 uv_texcoord;
			float4 uv2_texcoord2;
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
		uniform float _CullMode;
		ASE_DECLARE_SCREENSPACE_TEXTURE( _GrabTexture )
		uniform sampler2D _MainTex;
		uniform float3 _MainTexPanner;
		uniform float4 _MainTex_ST;
		uniform float _DisturbStr;
		uniform float2 _DisturbDir;
		uniform float _Dissolution;
		uniform float _Float12;
		uniform sampler2D _DissolutionTex;
		uniform float3 _DissolutionTexPanner;
		uniform float4 _DissolutionTex_ST;
		uniform sampler2D _FadeTex;
		uniform float4 _FadeTex_ST;

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float2 temp_output_197_0 = (ase_screenPosNorm).xy;
			float2 temp_cast_0 = (0.5).xx;
			float mulTime221 = _Time.y * _MainTexPanner.z;
			float2 appendResult223 = (float2(_MainTexPanner.x , _MainTexPanner.y));
			float4 uvs_MainTex = i.uv_texcoord;
			uvs_MainTex.xy = i.uv_texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
			float2 panner225 = ( mulTime221 * appendResult223 + uvs_MainTex.xy);
			float UV2_W152 = i.uv2_texcoord2.z;
			float UV2_T160 = i.uv2_texcoord2.w;
			float2 appendResult220 = (float2(UV2_W152 , UV2_T160));
			#ifdef _UV2_WTCONTROLOFFSET_ON
				float2 staticSwitch226 = ( uvs_MainTex.xy + appendResult220 );
			#else
				float2 staticSwitch226 = panner225;
			#endif
			float2 DisturbColor167 = ( ( tex2D( _MainTex, staticSwitch226 ).r * _DisturbStr ) * _DisturbDir );
			float VertexColorA77 = i.vertexColor.a;
			#ifdef _UV1_TCONTORLDIS_ON
				float staticSwitch23 = i.uv_texcoord.w;
			#else
				float staticSwitch23 = _Dissolution;
			#endif
			float UV1_T83 = staticSwitch23;
			float temp_output_207_0 = ( 1.0 - UV1_T83 );
			float mulTime122 = _Time.y * _DissolutionTexPanner.z;
			float2 appendResult121 = (float2(_DissolutionTexPanner.x , _DissolutionTexPanner.y));
			float4 uvs_DissolutionTex = i.uv_texcoord;
			uvs_DissolutionTex.xy = i.uv_texcoord.xy * _DissolutionTex_ST.xy + _DissolutionTex_ST.zw;
			float2 panner124 = ( mulTime122 * appendResult121 + uvs_DissolutionTex.xy);
			float smoothstepResult210 = smoothstep( temp_output_207_0 , ( temp_output_207_0 + _Float12 ) , tex2D( _DissolutionTex, panner124 ).r);
			#ifdef _DISSOLUTIONON_ON
				float staticSwitch162 = smoothstepResult210;
			#else
				float staticSwitch162 = 1.0;
			#endif
			float4 uvs_FadeTex = i.uv_texcoord;
			uvs_FadeTex.xy = i.uv_texcoord.xy * _FadeTex_ST.xy + _FadeTex_ST.zw;
			float FadeTexR142 = tex2D( _FadeTex, uvs_FadeTex.xy ).r;
			float FinalOpacity95 = saturate( ( staticSwitch162 * FadeTexR142 * VertexColorA77 ) );
			float4 screenColor195 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,( temp_output_197_0 + ( ( temp_output_197_0 - temp_cast_0 ) * ( DisturbColor167 * VertexColorA77 * FinalOpacity95 ) ) ));
			c.rgb = screenColor195.rgb;
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
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
46.4;405.6;1121.6;685.4;7505.145;964.1656;3.729598;True;False
Node;AmplifyShaderEditor.CommentaryNode;93;-4029.789,-1809.215;Inherit;False;1252.226;378.732;Comment;7;23;83;5;82;21;22;20;UV1;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;151;-3983.962,-1004.838;Inherit;False;1235.21;417.3196;Comment;3;38;152;160;UV2;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-3739.224,-1500.427;Inherit;False;Property;_Dissolution;Dissolution;13;0;Create;True;0;0;0;False;0;False;0.15;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;20;-3979.789,-1732.483;Inherit;True;0;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;94;-2506.983,-20.86744;Inherit;False;3046.858;1075.76;Comment;18;95;6;89;150;162;212;205;210;102;208;209;124;207;121;122;123;206;120;FinalOpacity;1,1,1,1;0;0
Node;AmplifyShaderEditor.StaticSwitch;23;-3433.2,-1587.579;Inherit;False;Property;_UV1_TContorlDis;UV1_TContorlDis;11;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;38;-3939.264,-838.3944;Inherit;False;1;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;120;-2285.701,387.6163;Inherit;False;Property;_DissolutionTexPanner;DissolutionTexPanner;14;0;Create;True;0;0;0;False;0;False;0,0,1;0,-1,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;152;-3621.013,-800.6278;Inherit;False;UV2_W;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;160;-3628.127,-700.9579;Inherit;False;UV2_T;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;169;-5413.829,3.464239;Inherit;False;2819.108;825.0873;DisturbColor;17;219;166;226;225;224;223;222;221;220;218;217;216;167;213;214;177;178;DisturbColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;83;-3059.958,-1584.79;Inherit;False;UV1_T;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;165;-2635.826,1396.534;Inherit;False;848.1375;327.2599;FadeTex;3;142;119;227;FadeTex;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;217;-5223.166,564.2579;Inherit;False;152;UV2_W;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;218;-5220.436,658.9059;Inherit;False;160;UV2_T;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;121;-1988.701,348.6163;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;123;-2187.519,236.3733;Inherit;False;0;102;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;216;-5267.504,215.2131;Inherit;False;Property;_MainTexPanner;MainTexPanner;4;0;Create;True;0;0;0;False;0;False;0,0,1;0.2,-1,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleTimeNode;122;-1991.701,502.6164;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;206;-1635.12,570.4293;Inherit;False;83;UV1_T;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;221;-5019.505,322.2131;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;223;-5016.505,168.2131;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;124;-1816.122,254.3542;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;209;-1426.118,740.4293;Inherit;False;Property;_Float12;DissSoft;16;0;Create;False;0;0;0;False;0;False;0;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;220;-4988.893,585.824;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;207;-1411.118,570.4293;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;222;-5079.398,427.4901;Inherit;False;0;166;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;227;-2584.784,1478.142;Inherit;False;0;119;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;219;-5282.321,47.96893;Inherit;False;0;166;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;225;-4834.825,136.35;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;208;-1043.118,682.4292;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;102;-1593.616,219.3152;Inherit;True;Property;_DissolutionTex;DissolutionTex;12;0;Create;True;0;0;0;False;0;False;-1;None;f69b5bbf3863af147872e70002ed843e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;24;-531.2078,-1788.438;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;224;-4804.442,456.1831;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;119;-2361.021,1459.534;Inherit;True;Property;_FadeTex;FadeTex;9;0;Create;True;0;0;0;False;0;False;-1;None;0cf3558dfb9ed9e4e86602625bbbe5c4;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;205;-799.5858,438.3438;Inherit;False;Constant;_Float2;Float 2;18;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;77;-312.5325,-1673.104;Inherit;False;VertexColorA;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;210;-841.2753,545.4359;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;142;-2011.688,1472.553;Inherit;False;FadeTexR;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;226;-4575.43,251.7301;Inherit;False;Property;_UV2_WTControlOffset;UV2_WTControlOffset;3;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;150;-480.313,645.6192;Inherit;False;142;FadeTexR;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;162;-509.7356,525.1159;Inherit;False;Property;_DissolutionOn;DissolutionOn;10;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;212;-487.8888,729.1912;Inherit;False;77;VertexColorA;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;178;-4084.409,451.6476;Inherit;False;Property;_DisturbStr;DisturbStr;6;0;Create;True;0;0;0;False;0;False;0;-0.3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;166;-4205.529,233.6021;Inherit;True;Property;_MainTex;MainTex;2;0;Create;True;0;0;0;False;0;False;-1;None;e40e2f95009ac3d4f99610da4c781570;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;89;-196.4532,574.0464;Inherit;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;177;-3862.75,256.0781;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;214;-3805.236,481.9893;Inherit;False;Property;_DisturbDir;DisturbDir;5;0;Create;True;0;0;0;False;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;213;-3617.818,297.9328;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;6;70.65525,569.9763;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;167;-3409.394,291.0858;Inherit;False;DisturbColor;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;196;-286.7626,-987.6613;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;95;270.2261,552.3891;Inherit;False;FinalOpacity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;203;70.50143,-785.4707;Inherit;False;Constant;_Float11;Float 11;27;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;197;-39.32967,-984.7921;Inherit;False;True;True;False;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;201;-6.911743,-560.9816;Inherit;False;77;VertexColorA;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;198;5.529861,-664.4307;Inherit;False;167;DisturbColor;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;96;13.23989,-470.6639;Inherit;True;95;FinalOpacity;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;200;302.8181,-660.4084;Inherit;False;3;3;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;202;303.3013,-837.2708;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;211;465.7206,-753.2175;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;46;-4025.268,-1389.026;Inherit;False;448;277.753;Comment;2;36;37;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;199;621.1716,-919.3757;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;21;-3420.962,-1751.425;Inherit;False;Property;_UV1_WContorlDisturb;UV1_WContorlDisturb;15;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;37;-3975.268,-1241.273;Inherit;False;Property;_ZTestMode;ZTestMode;1;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CompareFunction;True;0;False;8;8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;75;-314.2073,-1779.532;Inherit;False;VertexColorRGB;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-3716.271,-1759.215;Inherit;False;Property;_Float0;Float 0;8;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenColorNode;195;951.8682,-726.5708;Inherit;False;Global;_GrabScreen0;Grab Screen 0;51;0;Create;True;0;0;0;False;0;False;Object;-1;False;False;False;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;36;-3971.789,-1339.027;Inherit;False;Property;_CullMode;CullMode;0;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;82;-3059.415,-1707.079;Inherit;False;UV1_W;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1383.339,-770.8715;Float;False;True;-1;2;ASEMaterialInspector;0;0;CustomLighting;Whl/Fx/Disturb;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;1;False;141;0;True;37;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Custom;;Transparent;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;7;-1;-1;-1;0;False;0;0;True;36;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;81;-581.2078,-1838.438;Inherit;False;498.0005;281.3341;VertexColor;0;VertexColor;1,1,1,1;0;0
WireConnection;23;1;5;0
WireConnection;23;0;20;4
WireConnection;152;0;38;3
WireConnection;160;0;38;4
WireConnection;83;0;23;0
WireConnection;121;0;120;1
WireConnection;121;1;120;2
WireConnection;122;0;120;3
WireConnection;221;0;216;3
WireConnection;223;0;216;1
WireConnection;223;1;216;2
WireConnection;124;0;123;0
WireConnection;124;2;121;0
WireConnection;124;1;122;0
WireConnection;220;0;217;0
WireConnection;220;1;218;0
WireConnection;207;0;206;0
WireConnection;225;0;219;0
WireConnection;225;2;223;0
WireConnection;225;1;221;0
WireConnection;208;0;207;0
WireConnection;208;1;209;0
WireConnection;102;1;124;0
WireConnection;224;0;222;0
WireConnection;224;1;220;0
WireConnection;119;1;227;0
WireConnection;77;0;24;4
WireConnection;210;0;102;1
WireConnection;210;1;207;0
WireConnection;210;2;208;0
WireConnection;142;0;119;1
WireConnection;226;1;225;0
WireConnection;226;0;224;0
WireConnection;162;1;205;0
WireConnection;162;0;210;0
WireConnection;166;1;226;0
WireConnection;89;0;162;0
WireConnection;89;1;150;0
WireConnection;89;2;212;0
WireConnection;177;0;166;1
WireConnection;177;1;178;0
WireConnection;213;0;177;0
WireConnection;213;1;214;0
WireConnection;6;0;89;0
WireConnection;167;0;213;0
WireConnection;95;0;6;0
WireConnection;197;0;196;0
WireConnection;200;0;198;0
WireConnection;200;1;201;0
WireConnection;200;2;96;0
WireConnection;202;0;197;0
WireConnection;202;1;203;0
WireConnection;211;0;202;0
WireConnection;211;1;200;0
WireConnection;199;0;197;0
WireConnection;199;1;211;0
WireConnection;21;1;22;0
WireConnection;21;0;20;3
WireConnection;75;0;24;0
WireConnection;195;0;199;0
WireConnection;82;0;21;0
WireConnection;0;13;195;0
ASEEND*/
//CHKSM=3AC17487B14F8D6477A82D3DEAB7AACB71674260