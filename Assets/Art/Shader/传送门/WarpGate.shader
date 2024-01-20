// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Whl/WarpGate"
{
	Properties
	{
		[Toggle(_SCRIPTCONTROL_ON)] _ScriptControl("ScriptControl", Float) = 0
		[Toggle(_ROTATIONMODE_ON)] _RotationMode("RotationMode", Float) = 0
		_RotationAxis("RotationAxis", Vector) = (0,1,0,0)
		_MainTex("MainTex", 2D) = "white" {}
		_RotCount("RotCount", Float) = 1
		_Range("Range", Vector) = (0,1,0,0)
		_Appear("Appear", Range( 0 , 2)) = 0
		[Toggle(_PIVOTPOINTCHANGE_ON)] _PivotPointChange("PivotPointChange", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _ROTATIONMODE_ON
		#pragma shader_feature_local _SCRIPTCONTROL_ON
		#pragma shader_feature_local _PIVOTPOINTCHANGE_ON
		struct Input
		{
			float3 worldNormal;
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

		uniform float3 _RotationAxis;
		uniform float _RotCount;
		uniform float2 _Range;
		uniform float _Appear;
		uniform float _Rotation;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;


		float3 RotateAroundAxis( float3 center, float3 original, float3 u, float angle )
		{
			original -= center;
			float C = cos( angle );
			float S = sin( angle );
			float t = 1 - C;
			float m00 = t * u.x * u.x + C;
			float m01 = t * u.x * u.y - S * u.z;
			float m02 = t * u.x * u.z + S * u.y;
			float m10 = t * u.x * u.y + S * u.z;
			float m11 = t * u.y * u.y + C;
			float m12 = t * u.y * u.z - S * u.x;
			float m20 = t * u.x * u.z - S * u.y;
			float m21 = t * u.y * u.z + S * u.x;
			float m22 = t * u.z * u.z + C;
			float3x3 finalMatrix = float3x3( m00, m01, m02, m10, m11, m12, m20, m21, m22 );
			return mul( finalMatrix, original ) + center;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 appendResult45 = (float3(( ( 1.0 - v.color.r ) - 0.5 ) , ( v.color.g - 0.5 ) , ( v.color.b - 0.5 )));
			float3 VertexColorPos100 = appendResult45;
			#ifdef _ROTATIONMODE_ON
				float3 staticSwitch103 = VertexColorPos100;
			#else
				float3 staticSwitch103 = _RotationAxis;
			#endif
			float Turn22 = ( ( UNITY_PI / 180.0 ) * ( 360.0 * _RotCount ) );
			#ifdef _SCRIPTCONTROL_ON
				float staticSwitch92 = _Rotation;
			#else
				float staticSwitch92 = _Appear;
			#endif
			float clampResult64 = clamp( ( ( ( staticSwitch92 - abs( ( v.texcoord1.xy.x - 0.5 ) ) ) + ( staticSwitch92 - abs( ( v.texcoord1.xy.y - 0.5 ) ) ) ) / 2.0 ) , 0.0 , 1.0 );
			float smoothstepResult27 = smoothstep( _Range.x , _Range.y , clampResult64);
			#ifdef _PIVOTPOINTCHANGE_ON
				float3 staticSwitch96 = float3(0,0,0);
			#else
				float3 staticSwitch96 = VertexColorPos100;
			#endif
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 rotatedValue1 = RotateAroundAxis( staticSwitch96, ase_vertex3Pos, normalize( staticSwitch103 ), min( Turn22 , ( Turn22 * smoothstepResult27 ) ) );
			float clampResult99 = clamp( smoothstepResult27 , 0.0 , 1.0 );
			float Alpha29 = clampResult99;
			v.vertex.xyz = ( rotatedValue1 * Alpha29 );
			v.vertex.w = 1;
		}

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			SurfaceOutputStandard s13 = (SurfaceOutputStandard ) 0;
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			s13.Albedo = tex2D( _MainTex, uv_MainTex ).rgb;
			float3 ase_worldNormal = i.worldNormal;
			s13.Normal = ase_worldNormal;
			s13.Emission = float3( 0,0,0 );
			s13.Metallic = 0.0;
			s13.Smoothness = 0.0;
			s13.Occlusion = 1.0;

			data.light = gi.light;

			UnityGI gi13 = gi;
			#ifdef UNITY_PASS_FORWARDBASE
			Unity_GlossyEnvironmentData g13 = UnityGlossyEnvironmentSetup( s13.Smoothness, data.worldViewDir, s13.Normal, float3(0,0,0));
			gi13 = UnityGlobalIllumination( data, s13.Occlusion, s13.Normal, g13 );
			#endif

			float3 surfResult13 = LightingStandard ( s13, viewDir, gi13 ).rgb;
			surfResult13 += s13.Emission;

			#ifdef UNITY_PASS_FORWARDADD//13
			surfResult13 -= s13.Emission;
			#endif//13
			c.rgb = surfResult13;
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
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows vertex:vertexDataFunc 

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
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				float3 worldNormal : TEXCOORD3;
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
				o.worldNormal = worldNormal;
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
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
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldNormal = IN.worldNormal;
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
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
-1808;215;1708;830;1485.794;-69.64278;1.038173;True;True
Node;AmplifyShaderEditor.TexCoordVertexDataNode;39;-3693.555,1256.26;Inherit;False;1;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;19;-3705.674,1482.186;Inherit;False;Constant;_Float2;Float 2;4;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;42;-3352.861,1093.724;Inherit;False;Property;_Appear;Appear;6;0;Create;True;0;0;0;False;0;False;0;0.322;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-3365.632,1207.493;Inherit;False;Global;_Rotation;_Rotation;4;0;Create;False;0;0;0;False;0;False;0;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;18;-3341.132,1392.2;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;59;-3344.423,1643.042;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;20;-3077.366,1391.709;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;92;-3053.484,1168.084;Inherit;False;Property;_ScriptControl;ScriptControl;0;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;60;-3073.678,1646.19;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;9;-3160.405,654.4124;Inherit;False;492.6771;261.8062;OneAngle;3;4;5;6;OneAngle;1,1,1,1;0;0
Node;AmplifyShaderEditor.VertexColorNode;40;-1465.764,1278.164;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PiNode;4;-3110.405,704.4124;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;21;-2701.724,1254.692;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-2744.922,1060.475;Inherit;False;Property;_RotCount;RotCount;4;0;Create;True;0;0;0;False;0;False;1;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-3078.128,800.8186;Inherit;False;Constant;_Float0;Float 0;0;0;Create;True;0;0;0;False;0;False;180;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-2742.903,952.8329;Inherit;False;Constant;_Float1;Float 1;0;0;Create;True;0;0;0;False;0;False;360;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;61;-2686.588,1565.222;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;49;-1239.045,1263.28;Inherit;False;Constant;_Float4;Float 4;8;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;5;-2820.128,750.8186;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-2511.844,980.293;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;62;-2458.076,1441.335;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;44;-1224.847,1160.19;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;51;-1030.96,1423.378;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;50;-1029.682,1314.482;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;48;-1033.35,1181.942;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-2320.928,896.3188;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;94;-2305.806,1318;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;64;-2157.729,1317.759;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;45;-788.058,1279.509;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;22;-2178.553,891.5327;Inherit;False;Turn;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;28;-2213.081,1466.555;Inherit;False;Property;_Range;Range;5;0;Create;True;0;0;0;False;0;False;0,1;0,0.2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SmoothstepOpNode;27;-1970.754,1316.582;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;100;-589.8284,1276.551;Inherit;False;VertexColorPos;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;25;-1879.734,1042.538;Inherit;False;22;Turn;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;23;-1144.636,520.2607;Inherit;False;22;Turn;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;-1629.444,1044.637;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;2;-836.8167,315.6194;Inherit;False;Property;_RotationAxis;RotationAxis;2;0;Create;True;0;0;0;False;0;False;0,1,0;0,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;101;-835.7159,476.8663;Inherit;False;100;VertexColorPos;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;98;-1663.294,603.9988;Inherit;False;Constant;_Vector0;Vector 0;9;0;Create;True;0;0;0;False;0;False;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;102;-1707.84,522.4931;Inherit;False;100;VertexColorPos;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ClampOpNode;99;-1719.263,1353.566;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMinOpNode;24;-961.8008,523.3359;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;96;-1435.245,556.342;Inherit;False;Property;_PivotPointChange;PivotPointChange;7;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;103;-595.8371,402.4031;Inherit;False;Property;_RotationMode;RotationMode;1;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;29;-1527.965,1482.298;Inherit;False;Alpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;65;-753.0687,577.8013;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;15;-702.0035,132.0085;Inherit;True;Property;_MainTex;MainTex;3;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RotateAboutAxisNode;1;-251.3393,499.9198;Inherit;False;True;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;32;-106.7044,666.7101;Inherit;False;29;Alpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;83;153.1019,1819.921;Inherit;False;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;90;479.9431,1071.741;Inherit;False;89;Center;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldPosInputsNode;81;-194.2941,1609.092;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NegateNode;85;563.34,1694.115;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TransformPositionNode;95;-832.1992,868.7827;Inherit;False;Object;World;False;Fast;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.FunctionNode;86;387.2667,1693.038;Inherit;False;Rejection;-1;;1;ea6ca936e02c9e74fae837451ff893c3;0;2;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;91;766.2511,1151.124;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;84;164.2678,1690.038;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;89;754.5156,1685.069;Inherit;False;Center;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TransformPositionNode;82;-200.1243,1793.558;Inherit;False;Object;World;False;Fast;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TransformPositionNode;87;456.9933,1203.34;Inherit;False;Object;World;False;Fast;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.PosVertexDataNode;3;-1043.068,871.3564;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CustomStandardSurface;13;-361.0519,135.7628;Inherit;False;Metallic;Tangent;6;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,1;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;73;105.5251,542.3365;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;278.2226,-95.69484;Float;False;True;-1;2;ASEMaterialInspector;0;0;CustomLighting;Whl/WarpGate;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Absolute;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;18;0;39;1
WireConnection;18;1;19;0
WireConnection;59;0;39;2
WireConnection;59;1;19;0
WireConnection;20;0;18;0
WireConnection;92;1;42;0
WireConnection;92;0;16;0
WireConnection;60;0;59;0
WireConnection;21;0;92;0
WireConnection;21;1;20;0
WireConnection;61;0;92;0
WireConnection;61;1;60;0
WireConnection;5;0;4;0
WireConnection;5;1;6;0
WireConnection;12;0;8;0
WireConnection;12;1;11;0
WireConnection;62;0;21;0
WireConnection;62;1;61;0
WireConnection;44;0;40;1
WireConnection;51;0;40;3
WireConnection;51;1;49;0
WireConnection;50;0;40;2
WireConnection;50;1;49;0
WireConnection;48;0;44;0
WireConnection;48;1;49;0
WireConnection;7;0;5;0
WireConnection;7;1;12;0
WireConnection;94;0;62;0
WireConnection;64;0;94;0
WireConnection;45;0;48;0
WireConnection;45;1;50;0
WireConnection;45;2;51;0
WireConnection;22;0;7;0
WireConnection;27;0;64;0
WireConnection;27;1;28;1
WireConnection;27;2;28;2
WireConnection;100;0;45;0
WireConnection;26;0;25;0
WireConnection;26;1;27;0
WireConnection;99;0;27;0
WireConnection;24;0;23;0
WireConnection;24;1;26;0
WireConnection;96;1;102;0
WireConnection;96;0;98;0
WireConnection;103;1;2;0
WireConnection;103;0;101;0
WireConnection;29;0;99;0
WireConnection;1;0;103;0
WireConnection;1;1;24;0
WireConnection;1;2;96;0
WireConnection;1;3;65;0
WireConnection;85;0;86;0
WireConnection;95;0;3;0
WireConnection;86;3;84;0
WireConnection;86;4;83;0
WireConnection;91;0;90;0
WireConnection;91;1;87;0
WireConnection;84;0;81;0
WireConnection;84;1;82;0
WireConnection;89;0;85;0
WireConnection;13;0;15;0
WireConnection;73;0;1;0
WireConnection;73;1;32;0
WireConnection;0;13;13;0
WireConnection;0;11;73;0
ASEEND*/
//CHKSM=0A222B3F4941A2E7533C0C2A0B9D87AD34978FE7