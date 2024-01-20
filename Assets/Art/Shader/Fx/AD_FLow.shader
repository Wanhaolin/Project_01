// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Whl/Fx/AD_FLow"
{
	Properties
	{
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("CullMode", Float) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)]_ZTestMode("ZTestMode", Float) = 8
		[HDR][Header(Main)]_MainColor("MainColor", Color) = (0,0,0,0)
		[Toggle(_UV2CONTROLOFFSET_ON)] _UV2ControlOffset("UV2ControlOffset", Float) = 0
		_MainTex("MainTex", 2D) = "white" {}
		_Mask_Tex("Mask_Tex", 2D) = "white" {}
		[Toggle(_RGB_ON)] _RGB("RGB", Float) = 0
		_Rotater("Rotater", Range( 0 , 360)) = 0
		_MainTexPanner("MainTexPanner", Vector) = (0,0,1,0)
		[Header(Fade)]_FadeTex("FadeTex", 2D) = "white" {}
		_FadeTexPanner("FadeTexPanner", Vector) = (0,0,1,0)
		[Toggle(_DISTURBFADETEX_ON)] _DisturbFadeTex("DisturbFadeTex", Float) = 0
		_RampTex("RampTex", 2D) = "white" {}
		[Toggle(_DISTURBRAMP_ON)] _DisturbRamp("DisturbRamp", Float) = 0
		_RampDisStr("RampDisStr", Float) = 0
		[Header(Dissolution)]_DissolutionTex("DissolutionTex", 2D) = "white" {}
		[Toggle(_DISSOLUTIONON_ON)] _DissolutionOn("DissolutionOn", Float) = 0
		[Toggle(_UV1_TCONTORLDIS_ON)] _UV1_TContorlDis("UV1_TContorlDis", Float) = 0
		_Dissolution("Dissolution", Range( 0 , 1)) = 0.15
		_DissolutionSoft("DissolutionSoft", Range( 0.51 , 1)) = 0.3935294
		_DissolutionTexPanner("DissolutionTexPanner", Vector) = (0,0,1,0)
		[Header(Disturb)]_DisturbTex("DisturbTex", 2D) = "white" {}
		[Toggle(_DISTURBON_ON)] _DisturbOn("DisturbOn", Float) = 0
		[Toggle(_UV3_XCONTORLDISTURB_ON)] _UV3_XContorlDisturb("UV3_XContorlDisturb", Float) = 0
		_DisturbPanner("DisturbPanner", Vector) = (0,0,1,0)
		_DisturbStr("DisturbStr", Float) = 0
		_DisturbDir("DisturbDir", Vector) = (1,1,0,0)
		[Header(VertexOffset)]_VertexOffsetTex("VertexOffsetTex", 2D) = "white" {}
		[Toggle(_VERTEXOFFSETON_ON)] _VertexOffsetOn("VertexOffsetOn", Float) = 0
		[Toggle(_UV1_WCONTORLVERTEXOFFSET_ON)] _UV1_WContorlVertexOffset("UV1_WContorlVertexOffset", Float) = 0
		_VertexOffsetMask("VertexOffsetMask", 2D) = "white" {}
		_VertexOffsetTexPanner("VertexOffsetTexPanner", Vector) = (0,0,1,0)
		_VertexOffsetStr("VertexOffsetStr", Float) = 1
		_OffsetDir("OffsetDir", Vector) = (1,1,1,0)
		[Header(SoftParticle)]_FadeRange("FadeRange", Float) = 1
		[Toggle(_SOFTPARTICLE_ON)] _SoftParticle("SoftParticle", Float) = 0
		_FreOn("FreOn", Range( 0 , 1)) = 0
		_FreScale("FreScale", Float) = 1
		[HideInInspector] _texcoord3( "", 2D ) = "white" {}
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" }
		Cull [_CullMode]
		ZWrite Off
		ZTest [_ZTestMode]
		Blend SrcAlpha One
		
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _VERTEXOFFSETON_ON
		#pragma shader_feature_local _UV1_WCONTORLVERTEXOFFSET_ON
		#pragma shader_feature_local _DISSOLUTIONON_ON
		#pragma shader_feature_local _RGB_ON
		#pragma shader_feature_local _UV2CONTROLOFFSET_ON
		#pragma shader_feature_local _DISTURBON_ON
		#pragma shader_feature_local _UV3_XCONTORLDISTURB_ON
		#pragma shader_feature_local _UV1_TCONTORLDIS_ON
		#pragma shader_feature_local _SOFTPARTICLE_ON
		#pragma shader_feature_local _DISTURBFADETEX_ON
		#pragma shader_feature_local _DISTURBRAMP_ON
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 uv_texcoord;
			float4 uv2_texcoord2;
			float2 uv3_texcoord3;
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

		uniform float _ZTestMode;
		uniform float _CullMode;
		uniform sampler2D _VertexOffsetTex;
		uniform float3 _VertexOffsetTexPanner;
		uniform float4 _VertexOffsetTex_ST;
		uniform float3 _OffsetDir;
		uniform sampler2D _VertexOffsetMask;
		uniform float _VertexOffsetStr;
		uniform sampler2D _MainTex;
		uniform float3 _MainTexPanner;
		uniform float4 _MainTex_ST;
		uniform float _Rotater;
		uniform sampler2D _DisturbTex;
		uniform float3 _DisturbPanner;
		uniform float4 _DisturbTex_ST;
		uniform float _DisturbStr;
		uniform float2 _DisturbDir;
		uniform float _DissolutionSoft;
		uniform sampler2D _DissolutionTex;
		uniform float3 _DissolutionTexPanner;
		uniform float4 _DissolutionTex_ST;
		uniform float _Dissolution;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _FadeRange;
		uniform sampler2D _FadeTex;
		uniform float3 _FadeTexPanner;
		uniform float4 _FadeTex_ST;
		uniform sampler2D _Mask_Tex;
		uniform float _FreScale;
		uniform float _FreOn;
		uniform float4 _MainColor;
		uniform sampler2D _RampTex;
		uniform float4 _RampTex_ST;
		uniform float _RampDisStr;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 temp_cast_0 = (0.0).xxx;
			float mulTime130 = _Time.y * _VertexOffsetTexPanner.z;
			float2 appendResult128 = (float2(_VertexOffsetTexPanner.x , _VertexOffsetTexPanner.y));
			float4 uvs_VertexOffsetTex = v.texcoord;
			uvs_VertexOffsetTex.xy = v.texcoord.xy * _VertexOffsetTex_ST.xy + _VertexOffsetTex_ST.zw;
			float2 panner131 = ( mulTime130 * appendResult128 + uvs_VertexOffsetTex.xy);
			float temp_output_262_0 = (-1.0 + (tex2Dlod( _VertexOffsetTex, float4( panner131, 0, 0.0) ).r - 0.0) * (1.0 - -1.0) / (1.0 - 0.0));
			float3 appendResult267 = (float3(( temp_output_262_0 * _OffsetDir.x ) , ( temp_output_262_0 * _OffsetDir.y ) , ( temp_output_262_0 * _OffsetDir.z )));
			#ifdef _UV1_WCONTORLVERTEXOFFSET_ON
				float staticSwitch21 = v.texcoord.z;
			#else
				float staticSwitch21 = 1.0;
			#endif
			float UV1_W82 = staticSwitch21;
			float3 ase_vertexNormal = v.normal.xyz;
			#ifdef _VERTEXOFFSETON_ON
				float3 staticSwitch191 = ( appendResult267 * ( UV1_W82 * tex2Dlod( _VertexOffsetMask, float4( v.texcoord.xy, 0, 0.0) ).r * ( 0.1 * _VertexOffsetStr ) ) * ase_vertexNormal );
			#else
				float3 staticSwitch191 = temp_cast_0;
			#endif
			float3 VertexOffset137 = staticSwitch191;
			v.vertex.xyz += VertexOffset137;
			v.vertex.w = 1;
		}

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float mulTime31 = _Time.y * _MainTexPanner.z;
			float2 appendResult30 = (float2(_MainTexPanner.x , _MainTexPanner.y));
			float4 uvs_MainTex = i.uv_texcoord;
			uvs_MainTex.xy = i.uv_texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
			float2 panner27 = ( mulTime31 * appendResult30 + uvs_MainTex.xy);
			float UV2_W152 = i.uv2_texcoord2.z;
			float UV2_T160 = i.uv2_texcoord2.w;
			float2 appendResult157 = (float2(UV2_W152 , UV2_T160));
			#ifdef _UV2CONTROLOFFSET_ON
				float2 staticSwitch154 = ( uvs_MainTex.xy + appendResult157 );
			#else
				float2 staticSwitch154 = panner27;
			#endif
			float2 temp_cast_0 = (0.5).xx;
			float cos193 = cos( ( (0.0 + (_Rotater - 0.0) * (2.0 - 0.0) / (360.0 - 0.0)) * UNITY_PI ) );
			float sin193 = sin( ( (0.0 + (_Rotater - 0.0) * (2.0 - 0.0) / (360.0 - 0.0)) * UNITY_PI ) );
			float2 rotator193 = mul( staticSwitch154 - temp_cast_0 , float2x2( cos193 , -sin193 , sin193 , cos193 )) + temp_cast_0;
			float2 temp_cast_1 = (0.0).xx;
			float mulTime173 = _Time.y * _DisturbPanner.z;
			float2 appendResult174 = (float2(_DisturbPanner.x , _DisturbPanner.y));
			float4 uvs_DisturbTex = i.uv_texcoord;
			uvs_DisturbTex.xy = i.uv_texcoord.xy * _DisturbTex_ST.xy + _DisturbTex_ST.zw;
			float2 panner175 = ( mulTime173 * appendResult174 + uvs_DisturbTex.xy);
			#ifdef _UV3_XCONTORLDISTURB_ON
				float staticSwitch205 = i.uv3_texcoord3.x;
			#else
				float staticSwitch205 = 1.0;
			#endif
			float UV3_X200 = staticSwitch205;
			#ifdef _DISTURBON_ON
				float2 staticSwitch179 = ( ( tex2D( _DisturbTex, panner175 ).r * _DisturbStr * UV3_X200 ) * _DisturbDir );
			#else
				float2 staticSwitch179 = temp_cast_1;
			#endif
			float2 DisturbColor167 = staticSwitch179;
			float4 tex2DNode1 = tex2D( _MainTex, ( rotator193 + DisturbColor167 ) );
			#ifdef _RGB_ON
				float staticSwitch214 = (tex2DNode1).a;
			#else
				float staticSwitch214 = ( tex2DNode1.r * tex2DNode1.a );
			#endif
			float MainTexAlpha68 = staticSwitch214;
			float mulTime122 = _Time.y * _DissolutionTexPanner.z;
			float2 appendResult121 = (float2(_DissolutionTexPanner.x , _DissolutionTexPanner.y));
			float4 uvs_DissolutionTex = i.uv_texcoord;
			uvs_DissolutionTex.xy = i.uv_texcoord.xy * _DissolutionTex_ST.xy + _DissolutionTex_ST.zw;
			float2 panner124 = ( mulTime122 * appendResult121 + uvs_DissolutionTex.xy);
			#ifdef _UV1_TCONTORLDIS_ON
				float staticSwitch23 = i.uv_texcoord.w;
			#else
				float staticSwitch23 = _Dissolution;
			#endif
			float UV1_T83 = staticSwitch23;
			float smoothstepResult9 = smoothstep( ( 1.0 - _DissolutionSoft ) , _DissolutionSoft , ( tex2D( _DissolutionTex, ( DisturbColor167 + panner124 ) ).r + 1.0 + ( UV1_T83 * -2.0 ) ));
			float lerpResult112 = lerp( 0.0 , MainTexAlpha68 , ( smoothstepResult9 * 5.0 ));
			#ifdef _DISSOLUTIONON_ON
				float staticSwitch162 = lerpResult112;
			#else
				float staticSwitch162 = MainTexAlpha68;
			#endif
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth187 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth187 = abs( ( screenDepth187 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _FadeRange ) );
			#ifdef _SOFTPARTICLE_ON
				float staticSwitch51 = distanceDepth187;
			#else
				float staticSwitch51 = 1.0;
			#endif
			float SoftParticle189 = saturate( staticSwitch51 );
			float VertexColorA77 = i.vertexColor.a;
			float mulTime244 = _Time.y * _FadeTexPanner.z;
			float2 appendResult245 = (float2(_FadeTexPanner.x , _FadeTexPanner.y));
			float4 uvs_FadeTex = i.uv_texcoord;
			uvs_FadeTex.xy = i.uv_texcoord.xy * _FadeTex_ST.xy + _FadeTex_ST.zw;
			float2 panner246 = ( mulTime244 * appendResult245 + uvs_FadeTex.xy);
			float2 temp_cast_2 = (0.0).xx;
			#ifdef _DISTURBFADETEX_ON
				float2 staticSwitch221 = DisturbColor167;
			#else
				float2 staticSwitch221 = temp_cast_2;
			#endif
			float FadeTexR142 = tex2D( _FadeTex, ( panner246 + staticSwitch221 ) ).r;
			float2 MainTexUV229 = staticSwitch154;
			float Mask_TexR227 = tex2D( _Mask_Tex, MainTexUV229 ).r;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float3 ase_normWorldNormal = normalize( ase_worldNormal );
			float3 appendResult249 = (float3(ase_normWorldNormal.x , ase_normWorldNormal.y , -ase_normWorldNormal.z));
			float3 switchResult248 = (((i.ASEVFace>0)?(ase_normWorldNormal):(appendResult249)));
			float3 WorldNormal251 = switchResult248;
			float fresnelNdotV235 = dot( WorldNormal251, ase_worldViewDir );
			float fresnelNode235 = ( 0.0 + _FreScale * pow( max( 1.0 - fresnelNdotV235 , 0.0001 ), 5.0 ) );
			float clampResult237 = clamp( ( 1.0 - fresnelNode235 ) , 0.0 , 1.0 );
			float FreOP238 = clampResult237;
			float lerpResult242 = lerp( 1.0 , FreOP238 , _FreOn);
			float FinalOpacity95 = saturate( ( staticSwitch162 * SoftParticle189 * VertexColorA77 * FadeTexR142 * Mask_TexR227 * lerpResult242 ) );
			float4 VertexColorRGB75 = i.vertexColor;
			float3 MainTexColor217 = (tex2DNode1).rgb;
			float4 uvs_RampTex = i.uv_texcoord;
			uvs_RampTex.xy = i.uv_texcoord.xy * _RampTex_ST.xy + _RampTex_ST.zw;
			#ifdef _DISTURBRAMP_ON
				float2 staticSwitch259 = ( uvs_RampTex.xy + ( DisturbColor167 * _RampDisStr ) );
			#else
				float2 staticSwitch259 = uvs_RampTex.xy;
			#endif
			float4 MainColor91 = ( float4( MainTexColor217 , 0.0 ) * tex2D( _RampTex, staticSwitch259 ) );
			c.rgb = ( _MainColor * VertexColorRGB75 * MainColor91 ).rgb;
			c.a = saturate( FinalOpacity95 );
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
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 

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
				float2 customPack3 : TEXCOORD3;
				float4 screenPos : TEXCOORD4;
				float4 tSpace0 : TEXCOORD5;
				float4 tSpace1 : TEXCOORD6;
				float4 tSpace2 : TEXCOORD7;
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
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xyzw = customInputData.uv_texcoord;
				o.customPack1.xyzw = v.texcoord;
				o.customPack2.xyzw = customInputData.uv2_texcoord2;
				o.customPack2.xyzw = v.texcoord1;
				o.customPack3.xy = customInputData.uv3_texcoord3;
				o.customPack3.xy = v.texcoord2;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				o.screenPos = ComputeScreenPos( o.pos );
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
				surfIN.uv3_texcoord3 = IN.customPack3.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				surfIN.screenPos = IN.screenPos;
				surfIN.vertexColor = IN.color;
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
				surf( surfIN, o );
				UnityGI gi;
				UNITY_INITIALIZE_OUTPUT( UnityGI, gi );
				o.Alpha = LightingStandardCustomLighting( o, worldViewDir, gi ).a;
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
174.4;264.8;1528;878.2;3925.425;-1196.734;3.679189;True;True
Node;AmplifyShaderEditor.CommentaryNode;169;-5061.914,455.8446;Inherit;False;1861.461;712.423;DisturbColor;14;167;166;171;172;173;174;175;177;178;179;180;201;224;223;DisturbColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;203;-4060.576,-533.9757;Inherit;False;1124.562;519.4683;Comment;4;200;202;205;206;UV3;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector3Node;171;-4957.69,759.1779;Inherit;False;Property;_DisturbPanner;DisturbPanner;25;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TextureCoordinatesNode;202;-3994.059,-358.6486;Inherit;False;2;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;206;-3956.111,-473.67;Inherit;False;Constant;_Float12;Float 12;28;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;173;-4709.691,866.1779;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;205;-3694.111,-444.67;Inherit;False;Property;_UV3_XContorlDisturb;UV3_XContorlDisturb;24;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;172;-4904.507,598.9349;Inherit;False;0;166;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;174;-4706.691,712.1779;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;151;-4025.395,-1142.584;Inherit;False;1143.907;365.912;Comment;3;160;152;38;UV2;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;200;-3374.938,-421.3047;Inherit;False;UV3_X;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;38;-3996.365,-1078.663;Inherit;False;1;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;175;-4525.01,680.3159;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;178;-4164.755,886.5152;Inherit;False;Property;_DisturbStr;DisturbStr;26;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;160;-3529.321,-965.6096;Inherit;False;UV2_T;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;80;-2611.824,-2316.12;Inherit;False;2552.892;803.1612;MainTex;26;68;214;213;210;1;170;181;193;194;154;196;159;27;207;195;157;31;30;158;28;29;153;161;215;217;229;MainTex;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;152;-3527.857,-1060.301;Inherit;False;UV2_W;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;201;-4183.382,998.9465;Inherit;False;200;UV3_X;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;166;-4285.875,668.4697;Inherit;True;Property;_DisturbTex;DisturbTex;22;1;[Header];Create;True;1;Disturb;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;177;-3932.278,762.2213;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;252;1134.844,901.1813;Inherit;False;1088.13;274.4167;WorldNormal;5;247;250;249;248;251;WorldNormal;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;161;-2514.756,-1662.183;Inherit;False;160;UV2_T;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;29;-2561.824,-2105.876;Inherit;False;Property;_MainTexPanner;MainTexPanner;9;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;153;-2517.486,-1756.831;Inherit;False;152;UV2_W;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;223;-3963.931,998.5938;Inherit;False;Property;_DisturbDir;DisturbDir;27;0;Create;True;0;0;0;False;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;195;-1939.375,-1887.204;Inherit;False;Property;_Rotater;Rotater;8;0;Create;True;0;0;0;False;0;False;0;0;0;360;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;30;-2310.825,-2152.876;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;224;-3766.512,776.5373;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;157;-2283.213,-1735.265;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WorldNormalVector;247;1184.844,951.1813;Inherit;False;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TextureCoordinatesNode;158;-2373.718,-1893.599;Inherit;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;180;-3908.679,617.4449;Inherit;False;Constant;_0;0;32;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;28;-2508.641,-2266.12;Inherit;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;31;-2313.825,-1998.876;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;179;-3630.612,707.074;Inherit;False;Property;_DisturbOn;DisturbOn;23;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.NegateNode;250;1387.57,1064.598;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;159;-2098.762,-1864.906;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;94;-3150.239,422.7572;Inherit;False;4022.833;1852.103;Comment;38;145;125;147;95;6;89;97;150;162;112;163;146;73;115;9;116;111;144;13;106;102;105;107;124;84;122;123;121;120;182;183;188;190;230;239;240;241;242;FinalOpacity;1,1,1,1;0;0
Node;AmplifyShaderEditor.TFHCRemapNode;207;-1666.604,-1881.482;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;360;False;3;FLOAT;0;False;4;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;27;-2129.145,-2184.739;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;93;-4029.789,-1809.215;Inherit;False;1252.226;378.732;Comment;7;23;83;5;82;21;22;20;UV1;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;167;-3429.736,706.9774;Inherit;False;DisturbColor;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;249;1544.57,1007.598;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;154;-1954.75,-2068.359;Inherit;False;Property;_UV2ControlOffset;UV2ControlOffset;4;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-3769.224,-1515.427;Inherit;False;Property;_Dissolution;Dissolution;19;0;Create;True;0;0;0;False;0;False;0.15;0.15;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PiNode;196;-1490.313,-1881.489;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;194;-1632.339,-1982.5;Inherit;False;Constant;_Float11;Float 11;26;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;20;-4002.789,-1760.483;Inherit;True;0;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;120;-3081.241,831.2411;Inherit;False;Property;_DissolutionTexPanner;DissolutionTexPanner;21;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SwitchByFaceNode;248;1781.57,956.598;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;181;-1591.122,-1761.188;Inherit;False;167;DisturbColor;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;123;-2983.059,679.998;Inherit;False;0;102;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;122;-2787.242,946.2411;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;121;-2784.242,792.2411;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RotatorNode;193;-1378.421,-2031.266;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;23;-3433.2,-1587.579;Inherit;False;Property;_UV1_TContorlDis;UV1_TContorlDis;18;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;233;971.0353,1861.758;Inherit;False;1459.488;425.4343;FreOP;5;238;237;236;235;234;FreOP;1,1,1,1;0;0
Node;AmplifyShaderEditor.PannerNode;124;-2611.663,697.979;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;251;1998.974,952.452;Inherit;False;WorldNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;170;-1118.779,-2030.309;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;165;290.2191,2541.126;Inherit;False;1504.63;1065.357;FadeTex;14;243;119;246;218;220;219;221;245;244;222;142;227;226;225;FadeTex;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;182;-2686.151,545.7786;Inherit;False;167;DisturbColor;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;83;-3056.958,-1590.79;Inherit;False;UV1_T;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;234;1097.219,2121.954;Inherit;False;Property;_FreScale;FreScale;38;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;164;-2593.921,2466.331;Inherit;False;2633.635;1437.561;VertexOffset;24;260;132;133;134;136;262;137;191;261;192;139;232;231;126;131;130;129;128;127;263;264;265;266;267;VertexOffset;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;188;-2061.675,1673.743;Inherit;False;1246.439;416.1655;SoftParticle;6;189;209;51;52;187;43;SoftParticle;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;84;-2574.404,1004.793;Inherit;False;83;UV1_T;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-985.5342,-2059.936;Inherit;True;Property;_MainTex;MainTex;5;0;Create;True;0;0;0;False;0;False;-1;None;37d8e480cdf79b4499ba6e8db2e7b29b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;107;-2548.189,1108.655;Inherit;False;Constant;_Float4;Float 4;20;0;Create;True;0;0;0;False;0;False;-2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;183;-2379.151,640.7786;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector3Node;243;325.8191,2795.344;Inherit;False;Property;_FadeTexPanner;FadeTexPanner;11;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;253;1049.385,2024.979;Inherit;False;251;WorldNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-2107.969,1054.098;Inherit;False;Property;_DissolutionSoft;DissolutionSoft;20;0;Create;True;0;0;0;False;0;False;0.3935294;0.3935294;0.51;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-2000.336,1861.722;Inherit;False;Property;_FadeRange;FadeRange;35;1;[Header];Create;True;1;SoftParticle;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;105;-2163.894,860.5591;Inherit;False;Constant;_Float3;Float 3;20;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;244;553.8181,2902.344;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;218;418.1068,2612.277;Inherit;False;0;119;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;102;-2236.871,662.9398;Inherit;True;Property;_DissolutionTex;DissolutionTex;16;1;[Header];Create;True;1;Dissolution;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;127;-2543.921,2681.715;Inherit;False;Property;_VertexOffsetTexPanner;VertexOffsetTexPanner;32;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;106;-2269.67,1004.331;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;215;-626.4937,-1908.67;Inherit;False;False;False;False;True;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;210;-596.4579,-2017.672;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;235;1332.274,2032.795;Inherit;True;Standard;WorldNormal;ViewDir;False;True;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;222;502.3695,3028.956;Inherit;False;Constant;_Float13;Float 13;30;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;219;463.3695,3112.956;Inherit;False;167;DisturbColor;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;245;576.8181,2748.344;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;236;1652.602,2033.009;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;128;-2190.026,2684.331;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;90;-2498.941,-647.7783;Inherit;False;2227.146;782.8557;MainColor;10;148;91;71;149;254;256;257;258;259;255;MainColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleTimeNode;130;-2224.027,2778.331;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;129;-2360.028,2516.331;Inherit;False;0;126;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;111;-1790.104,811.2529;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;221;719.3694,3052.956;Inherit;False;Property;_DisturbFadeTex;DisturbFadeTex;12;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;144;-1803.972,948.0927;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;229;-1567.646,-2178.143;Inherit;False;MainTexUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DepthFade;187;-1820.811,1841.908;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;214;-418.752,-2006.705;Inherit;False;Property;_RGB;RGB;7;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;52;-1791.724,1746.424;Inherit;False;Constant;_Float1;Float 1;14;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;246;757.498,2678.48;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;255;-2379.084,-7.301426;Inherit;False;Property;_RampDisStr;RampDisStr;15;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;131;-1976.025,2678.331;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;116;-1195.548,1216.3;Inherit;False;Constant;_Float5;Float 5;21;0;Create;True;0;0;0;False;0;False;5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;225;453.8857,3371.892;Inherit;False;229;MainTexUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;68;-241.0383,-2009.257;Inherit;True;MainTexAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;237;1836.69,2033.456;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;254;-2388.281,-109.8427;Inherit;False;167;DisturbColor;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;51;-1557.078,1753.669;Inherit;False;Property;_SoftParticle;SoftParticle;36;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;9;-1539.37,918.7987;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;81;-49.7229,-1838.438;Inherit;False;498.0005;281.3341;VertexColor;3;75;77;24;VertexColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-3716.271,-1759.215;Inherit;False;Constant;_Float0;Float 0;7;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;220;962.107,2647.277;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;73;-844.4359,1062.773;Inherit;False;68;MainTexAlpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;21;-3420.962,-1751.425;Inherit;False;Property;_UV1_WContorlVertexOffset;UV1_WContorlVertexOffset;30;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;226;676.9673,3350.896;Inherit;True;Property;_Mask_Tex;Mask_Tex;6;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;119;1111.129,2600.279;Inherit;True;Property;_FadeTex;FadeTex;10;1;[Header];Create;True;1;Fade;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;126;-1720.243,2642.189;Inherit;True;Property;_VertexOffsetTex;VertexOffsetTex;28;1;[Header];Create;True;1;VertexOffset;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;24;0.2770872,-1788.438;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;115;-950.5482,1168.3;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;146;-833.4948,953.9972;Inherit;False;Constant;_Float9;Float 9;27;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;256;-2443.629,-392.7382;Inherit;False;0;148;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;257;-2117.559,-129.0951;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;209;-1317.207,1782.699;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;238;2007.187,2027.926;Inherit;False;FreOP;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;136;-1760.432,3793.033;Inherit;False;Property;_VertexOffsetStr;VertexOffsetStr;33;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;134;-1735.646,3721.625;Inherit;False;Constant;_Float7;Float 7;25;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;240;-466.6094,1777.918;Inherit;False;Property;_FreOn;FreOn;37;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;112;-527.3167,1011.487;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;213;-624.7521,-1716.722;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;227;1121.086,3372.903;Inherit;False;Mask_TexR;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;239;-385.1196,1568.026;Inherit;False;Constant;_Float15;Float 15;39;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;77;218.9524,-1673.104;Inherit;False;VertexColorA;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;241;-416.3823,1667.421;Inherit;False;238;FreOP;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;262;-1420.423,2648.764;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-1;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;258;-1952.793,-219.3686;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;163;-516.0894,845.3393;Inherit;False;68;MainTexAlpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;189;-1131.33,1769.279;Inherit;False;SoftParticle;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;231;-1890.461,3434.716;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;82;-3053.415,-1749.079;Inherit;False;UV1_W;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;142;1477.157,2624.002;Inherit;False;FadeTexR;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;266;-1636.649,2904.214;Inherit;True;Property;_OffsetDir;OffsetDir;34;0;Create;True;0;0;0;False;0;False;1,1,1;1,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;264;-1147.73,2830.992;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;263;-1155.754,2674.872;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;133;-1466.123,3738.992;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;162;-268.5611,959.7405;Inherit;False;Property;_DissolutionOn;DissolutionOn;17;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;139;-1537.321,3270.139;Inherit;False;82;UV1_W;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;230;-213.2357,1445.5;Inherit;False;227;Mask_TexR;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;232;-1602.047,3413.051;Inherit;True;Property;_VertexOffsetMask;VertexOffsetMask;31;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;242;-146.4715,1599.916;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;217;-346.7415,-1717.997;Inherit;False;MainTexColor;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;190;-225.2671,1138.991;Inherit;False;189;SoftParticle;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;150;-209.7535,1333.518;Inherit;False;142;FadeTexR;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;259;-1808.28,-353.9427;Inherit;False;Property;_DisturbRamp;DisturbRamp;14;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;97;-237.6361,1235.806;Inherit;False;77;VertexColorA;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;265;-1143.309,2984.5;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;89;49.80009,1019.094;Inherit;True;6;6;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;148;-1539.229,-370.248;Inherit;True;Property;_RampTex;RampTex;13;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;267;-957.4949,2755.884;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;71;-1326.458,-466.7523;Inherit;False;217;MainTexColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;260;-1209.531,3335.134;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;132;-1196.121,3590.29;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;192;-785.5792,2798.911;Inherit;False;Constant;_Float2;Float 2;27;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;261;-797.4515,2942.786;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;6;336.8301,1013.601;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;149;-1072.11,-393.847;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;91;-803.9272,-405.2676;Inherit;False;MainColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;191;-591.7778,2856.514;Inherit;False;Property;_VertexOffsetOn;VertexOffsetOn;29;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;75;217.2776,-1779.532;Inherit;False;VertexColorRGB;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;95;536.4009,996.0136;Inherit;False;FinalOpacity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;137;-297.8711,2857.235;Inherit;False;VertexOffset;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;16;-174.3261,-700.9083;Inherit;False;Property;_MainColor;MainColor;3;2;[HDR];[Header];Create;True;1;Main;0;0;False;0;False;0,0,0,0;47.93726,47.93726,47.93726,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;92;-154.1754,-402.1346;Inherit;False;91;MainColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;96;158.913,-853.712;Inherit;True;95;FinalOpacity;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;46;-4525.035,-1801.048;Inherit;False;448;277.753;Comment;2;36;37;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;78;-166.3018,-501.6696;Inherit;False;75;VertexColorRGB;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-4471.555,-1751.049;Inherit;False;Property;_CullMode;CullMode;0;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;37;-4475.035,-1653.295;Inherit;False;Property;_ZTestMode;ZTestMode;1;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CompareFunction;True;0;False;8;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;247.5879,-592.9905;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;145;-2533.892,1221.801;Inherit;False;Constant;_Float8;Float 8;27;0;Create;True;0;0;0;False;0;False;0.57;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;147;-2535.341,895.1389;Inherit;False;Constant;_Float10;Float 10;27;0;Create;True;0;0;0;False;0;False;0.61;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;208;500.5122,-842.7086;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;125;-2363.776,868.5873;Inherit;False;Constant;_Float6;Float 6;23;0;Create;True;0;0;0;False;0;False;0.58;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;138;216.2339,-150.8215;Inherit;False;137;VertexOffset;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;832.2584,-770.3762;Float;False;True;-1;2;ASEMaterialInspector;0;0;CustomLighting;Whl/Fx/AD_FLow;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;2;False;225;0;True;37;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Custom;;Transparent;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;2;-1;-1;-1;0;False;0;0;True;36;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;173;0;171;3
WireConnection;205;1;206;0
WireConnection;205;0;202;1
WireConnection;174;0;171;1
WireConnection;174;1;171;2
WireConnection;200;0;205;0
WireConnection;175;0;172;0
WireConnection;175;2;174;0
WireConnection;175;1;173;0
WireConnection;160;0;38;4
WireConnection;152;0;38;3
WireConnection;166;1;175;0
WireConnection;177;0;166;1
WireConnection;177;1;178;0
WireConnection;177;2;201;0
WireConnection;30;0;29;1
WireConnection;30;1;29;2
WireConnection;224;0;177;0
WireConnection;224;1;223;0
WireConnection;157;0;153;0
WireConnection;157;1;161;0
WireConnection;31;0;29;3
WireConnection;179;1;180;0
WireConnection;179;0;224;0
WireConnection;250;0;247;3
WireConnection;159;0;158;0
WireConnection;159;1;157;0
WireConnection;207;0;195;0
WireConnection;27;0;28;0
WireConnection;27;2;30;0
WireConnection;27;1;31;0
WireConnection;167;0;179;0
WireConnection;249;0;247;1
WireConnection;249;1;247;2
WireConnection;249;2;250;0
WireConnection;154;1;27;0
WireConnection;154;0;159;0
WireConnection;196;0;207;0
WireConnection;248;0;247;0
WireConnection;248;1;249;0
WireConnection;122;0;120;3
WireConnection;121;0;120;1
WireConnection;121;1;120;2
WireConnection;193;0;154;0
WireConnection;193;1;194;0
WireConnection;193;2;196;0
WireConnection;23;1;5;0
WireConnection;23;0;20;4
WireConnection;124;0;123;0
WireConnection;124;2;121;0
WireConnection;124;1;122;0
WireConnection;251;0;248;0
WireConnection;170;0;193;0
WireConnection;170;1;181;0
WireConnection;83;0;23;0
WireConnection;1;1;170;0
WireConnection;183;0;182;0
WireConnection;183;1;124;0
WireConnection;244;0;243;3
WireConnection;102;1;183;0
WireConnection;106;0;84;0
WireConnection;106;1;107;0
WireConnection;215;0;1;0
WireConnection;210;0;1;1
WireConnection;210;1;1;4
WireConnection;235;0;253;0
WireConnection;235;2;234;0
WireConnection;245;0;243;1
WireConnection;245;1;243;2
WireConnection;236;0;235;0
WireConnection;128;0;127;1
WireConnection;128;1;127;2
WireConnection;130;0;127;3
WireConnection;111;0;102;1
WireConnection;111;1;105;0
WireConnection;111;2;106;0
WireConnection;221;1;222;0
WireConnection;221;0;219;0
WireConnection;144;0;13;0
WireConnection;229;0;154;0
WireConnection;187;0;43;0
WireConnection;214;1;210;0
WireConnection;214;0;215;0
WireConnection;246;0;218;0
WireConnection;246;2;245;0
WireConnection;246;1;244;0
WireConnection;131;0;129;0
WireConnection;131;2;128;0
WireConnection;131;1;130;0
WireConnection;68;0;214;0
WireConnection;237;0;236;0
WireConnection;51;1;52;0
WireConnection;51;0;187;0
WireConnection;9;0;111;0
WireConnection;9;1;144;0
WireConnection;9;2;13;0
WireConnection;220;0;246;0
WireConnection;220;1;221;0
WireConnection;21;1;22;0
WireConnection;21;0;20;3
WireConnection;226;1;225;0
WireConnection;119;1;220;0
WireConnection;126;1;131;0
WireConnection;115;0;9;0
WireConnection;115;1;116;0
WireConnection;257;0;254;0
WireConnection;257;1;255;0
WireConnection;209;0;51;0
WireConnection;238;0;237;0
WireConnection;112;0;146;0
WireConnection;112;1;73;0
WireConnection;112;2;115;0
WireConnection;213;0;1;0
WireConnection;227;0;226;1
WireConnection;77;0;24;4
WireConnection;262;0;126;1
WireConnection;258;0;256;0
WireConnection;258;1;257;0
WireConnection;189;0;209;0
WireConnection;82;0;21;0
WireConnection;142;0;119;1
WireConnection;264;0;262;0
WireConnection;264;1;266;2
WireConnection;263;0;262;0
WireConnection;263;1;266;1
WireConnection;133;0;134;0
WireConnection;133;1;136;0
WireConnection;162;1;163;0
WireConnection;162;0;112;0
WireConnection;232;1;231;0
WireConnection;242;0;239;0
WireConnection;242;1;241;0
WireConnection;242;2;240;0
WireConnection;217;0;213;0
WireConnection;259;1;256;0
WireConnection;259;0;258;0
WireConnection;265;0;262;0
WireConnection;265;1;266;3
WireConnection;89;0;162;0
WireConnection;89;1;190;0
WireConnection;89;2;97;0
WireConnection;89;3;150;0
WireConnection;89;4;230;0
WireConnection;89;5;242;0
WireConnection;148;1;259;0
WireConnection;267;0;263;0
WireConnection;267;1;264;0
WireConnection;267;2;265;0
WireConnection;260;0;139;0
WireConnection;260;1;232;1
WireConnection;260;2;133;0
WireConnection;261;0;267;0
WireConnection;261;1;260;0
WireConnection;261;2;132;0
WireConnection;6;0;89;0
WireConnection;149;0;71;0
WireConnection;149;1;148;0
WireConnection;91;0;149;0
WireConnection;191;1;192;0
WireConnection;191;0;261;0
WireConnection;75;0;24;0
WireConnection;95;0;6;0
WireConnection;137;0;191;0
WireConnection;15;0;16;0
WireConnection;15;1;78;0
WireConnection;15;2;92;0
WireConnection;208;0;96;0
WireConnection;0;9;208;0
WireConnection;0;13;15;0
WireConnection;0;11;138;0
ASEEND*/
//CHKSM=9171489571DF6B1319AB392F55AF0E826AF8F09A