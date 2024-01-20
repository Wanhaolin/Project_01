// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "cokey/Ice_2.0"
{
	Properties
	{
		_EdgeLength ( "Edge length", Range( 2, 50 ) ) = 15
		_TextureSample0("角色表面", 2D) = "white" {}
		_Color1("角色颜色", Color) = (0,0,0,0)
		_Float12("Metallic", Float) = 0
		_Float13("Smoothness", Float) = 0
		_TextureSample5("角色法线", 2D) = "white" {}
		_Float11("角色法线强度", Float) = 0
		_TextureSample2("结冰过程贴图", 2D) = "white" {}
		_Float0("结冰过程", Float) = 0
		_Float1("结冰边缘模糊", Range( 0 , 0.2)) = 0
		_Float4("结冰整齐边缘(三套UV时才起作用)", Range( 0 , 0.1)) = 0
		_TextureSample1("冰块表面", 2D) = "black" {}
		_Color0("冰颜色", Color) = (0.3517711,0.6478854,0.8773585,0)
		_Float8("冰块透明度", Range( 0 , 1)) = 1
		_Color2("边缘色", Color) = (0,0,0,0)
		_Float2("边缘光宽度", Float) = 1
		_Float3("边缘光强度", Float) = 1
		_TextureSample4("结冰突出", 2D) = "black" {}
		_Float5("结冰凸起强度", Float) = 0
		_TextureSample3("镜面反射贴图", 2D) = "white" {}
		_Float9("镜面反射强度", Float) = 0
		_TextureSample6("冰块法线", 2D) = "white" {}
		_Float10("冰块法线强度", Float) = 0
		[Toggle]_ToggleSwitch0("第三套UV或shader", Float) = 1
		[Toggle]_ToggleSwitch1("上面如果勾了,这个也要勾!!!", Float) = 1
		_Float14("结冰溶解高度值", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord3( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "Tessellation.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 4.6
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float3 worldPos;
			float2 uv3_texcoord3;
			float2 uv_texcoord;
			float3 worldNormal;
			INTERNAL_DATA
			float3 worldRefl;
		};

		uniform sampler2D _TextureSample4;
		uniform float _ToggleSwitch1;
		uniform float _Float14;
		uniform float _Float5;
		uniform float _Float0;
		uniform float _Float1;
		uniform float _ToggleSwitch0;
		uniform sampler2D _TextureSample2;
		uniform float _Float4;
		uniform sampler2D _TextureSample6;
		uniform float _Float10;
		uniform sampler2D _TextureSample5;
		uniform float4 _TextureSample5_ST;
		uniform float _Float11;
		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;
		uniform sampler2D _TextureSample1;
		uniform float _Float8;
		uniform float4 _Color0;
		uniform float _Float3;
		uniform float _Float2;
		uniform float4 _Color2;
		uniform sampler2D _TextureSample3;
		uniform float _Float9;
		uniform float4 _Color1;
		uniform float _Float12;
		uniform float _Float13;
		uniform float _EdgeLength;


		float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }

		float snoise( float2 v )
		{
			const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
			float2 i = floor( v + dot( v, C.yy ) );
			float2 x0 = v - i + dot( i, C.xx );
			float2 i1;
			i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
			float4 x12 = x0.xyxy + C.xxzz;
			x12.xy -= i1;
			i = mod2D289( i );
			float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
			float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
			m = m * m;
			m = m * m;
			float3 x = 2.0 * frac( p * C.www ) - 1.0;
			float3 h = abs( x ) - 0.5;
			float3 ox = floor( x + 0.5 );
			float3 a0 = x - ox;
			m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
			float3 g;
			g.x = a0.x * x0.x + h.x * x0.y;
			g.yz = a0.yz * x12.xz + h.yz * x12.yw;
			return 130.0 * dot( m, g );
		}


		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			return UnityEdgeLengthBasedTess (v0.vertex, v1.vertex, v2.vertex, _EdgeLength);
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float3 objToWorld71 = mul( unity_ObjectToWorld, float4( float3( 0,0,0 ), 1 ) ).xyz;
			float clampResult73 = clamp( ( ( ( ( _Float14 + ase_worldPos.y ) - objToWorld71.y ) + 1.0 ) / 2.0 ) , 0.0 , 1.0 );
			float4 appendResult85 = (float4(v.texcoord.xy.x , clampResult73 , 0.0 , 0.0));
			float2 UV3orShader95 = (( _ToggleSwitch1 )?( (appendResult85).xy ):( v.texcoord2.xy ));
			float3 ase_vertexNormal = v.normal.xyz;
			float4 temp_cast_1 = (0.0).xxxx;
			float simplePerlin2D43 = snoise( v.texcoord.xy*20.0 );
			simplePerlin2D43 = simplePerlin2D43*0.5 + 0.5;
			float smoothstepResult8 = smoothstep( _Float0 , ( _Float0 + _Float1 ) , (( _ToggleSwitch0 )?( clampResult73 ):( tex2Dlod( _TextureSample2, float4( ( v.texcoord2.xy + ( simplePerlin2D43 * _Float4 ) ), 0, 0.0) ).r )));
			float IceDisslove17 = smoothstepResult8;
			float4 lerpResult41 = lerp( ( tex2Dlod( _TextureSample4, float4( UV3orShader95, 0, 0.0) ) * _Float5 * float4( ase_vertexNormal , 0.0 ) ) , temp_cast_1 , IceDisslove17);
			v.vertex.xyz += lerpResult41.rgb;
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 _Vector0 = float3(0,0,1);
			float3 ase_worldPos = i.worldPos;
			float3 objToWorld71 = mul( unity_ObjectToWorld, float4( float3( 0,0,0 ), 1 ) ).xyz;
			float clampResult73 = clamp( ( ( ( ( _Float14 + ase_worldPos.y ) - objToWorld71.y ) + 1.0 ) / 2.0 ) , 0.0 , 1.0 );
			float4 appendResult85 = (float4(i.uv_texcoord.x , clampResult73 , 0.0 , 0.0));
			float2 UV3orShader95 = (( _ToggleSwitch1 )?( (appendResult85).xy ):( i.uv3_texcoord3 ));
			float4 lerpResult60 = lerp( float4( _Vector0 , 0.0 ) , tex2D( _TextureSample6, UV3orShader95 ) , _Float10);
			float2 uv_TextureSample5 = i.uv_texcoord * _TextureSample5_ST.xy + _TextureSample5_ST.zw;
			float4 lerpResult63 = lerp( float4( _Vector0 , 0.0 ) , tex2D( _TextureSample5, uv_TextureSample5 ) , _Float11);
			float simplePerlin2D43 = snoise( i.uv_texcoord*20.0 );
			simplePerlin2D43 = simplePerlin2D43*0.5 + 0.5;
			float smoothstepResult8 = smoothstep( _Float0 , ( _Float0 + _Float1 ) , (( _ToggleSwitch0 )?( clampResult73 ):( tex2D( _TextureSample2, ( i.uv3_texcoord3 + ( simplePerlin2D43 * _Float4 ) ) ).r )));
			float IceDisslove17 = smoothstepResult8;
			float4 lerpResult58 = lerp( lerpResult60 , lerpResult63 , IceDisslove17);
			o.Normal = lerpResult58.rgb;
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float4 tex2DNode1 = tex2D( _TextureSample0, uv_TextureSample0 );
			float4 lerpResult50 = lerp( tex2DNode1 , tex2D( _TextureSample1, UV3orShader95 ) , _Float8);
			float4 lerpResult2 = lerp( lerpResult50 , tex2DNode1 , IceDisslove17);
			o.Albedo = lerpResult2.rgb;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float fresnelNdotV20 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode20 = ( 0.0 + _Float3 * pow( 1.0 - fresnelNdotV20, _Float2 ) );
			float clampResult35 = clamp( fresnelNode20 , 0.0 , 1.0 );
			float4 Fresnel26 = ( clampResult35 * _Color2 );
			float3 ase_worldReflection = WorldReflectionVector( i, float3( 0, 0, 1 ) );
			float4 lerpResult14 = lerp( ( _Color0 + Fresnel26 + ( tex2D( _TextureSample3, ase_worldReflection.xy ) * _Float9 ) ) , ( tex2DNode1 * _Color1 ) , IceDisslove17);
			o.Emission = lerpResult14.rgb;
			o.Metallic = _Float12;
			o.Smoothness = _Float13;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.6
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
				float4 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
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
				vertexDataFunc( v );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv3_texcoord3;
				o.customPack1.xy = v.texcoord2;
				o.customPack1.zw = customInputData.uv_texcoord;
				o.customPack1.zw = v.texcoord;
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
				surfIN.uv3_texcoord3 = IN.customPack1.xy;
				surfIN.uv_texcoord = IN.customPack1.zw;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.worldRefl = -worldViewDir;
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
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
160.8;118.4;1324.8;755;1544.832;26.77784;1.417298;True;False
Node;AmplifyShaderEditor.CommentaryNode;15;-2834.682,815.0045;Inherit;False;2309.321;1209.385;结冰;26;8;7;11;10;32;9;12;31;33;43;46;45;71;72;73;76;70;78;79;81;80;82;85;84;36;94;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldPosInputsNode;70;-2844.095,1617.958;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;79;-2850.732,1467.446;Inherit;False;Property;_Float14;结冰溶解高度值;29;0;Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;78;-2544.732,1493.446;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TransformPositionNode;71;-2812.695,1771.559;Inherit;False;Object;World;False;Fast;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleSubtractOpNode;72;-2383.54,1686.054;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;81;-2150.313,1860.602;Inherit;False;Constant;_Float15;Float 15;25;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;80;-1976.313,1691.602;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;82;-1776.676,1672.635;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;45;-2785.946,1029.911;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;46;-2768.946,1191.911;Inherit;False;Constant;_Float7;Float 7;13;0;Create;True;0;0;0;False;0;False;20;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;43;-2511.946,1058.911;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-2530.349,1305.374;Inherit;False;Property;_Float4;结冰整齐边缘(三套UV时才起作用);14;0;Create;False;0;0;0;False;0;False;0;0;0;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;73;-1636.927,1386.036;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;84;-1314.089,1541.273;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;25;-1807.908,2230.036;Inherit;False;1184.609;513.4198;菲尼尔;7;26;20;22;21;24;23;35;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;85;-1027.172,1546.033;Inherit;True;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-1764.908,2415.67;Inherit;False;Property;_Float2;边缘光宽度;19;0;Create;False;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-1752.908,2318.671;Inherit;False;Property;_Float3;边缘光强度;20;0;Create;False;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;12;-2355.945,876.156;Inherit;False;2;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-2117.776,1132.518;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;36;-1025.373,1321.81;Inherit;False;2;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;32;-2020.776,1008.518;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FresnelNode;20;-1519.15,2280.035;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;94;-787.5147,1535.559;Inherit;True;True;True;False;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;7;-1868.69,865.0046;Inherit;True;Property;_TextureSample2;结冰过程贴图;11;0;Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;9;-1441.432,1080.502;Inherit;False;Property;_Float0;结冰过程;12;0;Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-1498.848,1184.318;Inherit;False;Property;_Float1;结冰边缘模糊;13;0;Create;False;0;0;0;False;0;False;0;0.2;0;0.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;24;-1343.546,2583.416;Inherit;False;Property;_Color2;边缘色;18;0;Create;False;0;0;0;False;0;False;0,0,0,0;0.6509434,0.6509434,0.6509434,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ToggleSwitchNode;93;-522.2575,1433.345;Inherit;False;Property;_ToggleSwitch1;上面如果勾了,这个也要勾!!!;28;0;Create;False;0;0;0;False;0;False;1;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ClampOpNode;35;-1194.948,2380.161;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;95;-222.7573,1460.345;Inherit;False;UV3orShader;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WorldReflectionVector;52;-2105,-125;Inherit;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;11;-1127.601,1180.124;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-999.9114,2406.67;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;76;-1565.723,920.3515;Inherit;False;Property;_ToggleSwitch0;第三套UV或shader;27;0;Create;False;0;0;0;False;0;False;1;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;98;-406.1663,931.2117;Inherit;False;95;UV3orShader;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;96;-1133.708,-825.4047;Inherit;False;95;UV3orShader;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;26;-809.351,2406.652;Inherit;False;Fresnel;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-1378.127,231.8773;Inherit;False;Property;_Float9;镜面反射强度;24;0;Create;False;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;97;-2829.651,-868.9991;Inherit;False;95;UV3orShader;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;53;-1616,-64;Inherit;True;Property;_TextureSample3;镜面反射贴图;23;0;Create;False;0;0;0;False;0;False;-1;None;a083a7dc9ceb347468f2f00dfc88a60d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SmoothstepOpNode;8;-957.1982,916.6998;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;40;-183.4365,1110.968;Inherit;False;Property;_Float5;结冰凸起强度;22;0;Create;False;0;0;0;False;0;False;0;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;51;-503.9951,-666.726;Inherit;False;Property;_Float8;冰块透明度;17;0;Create;False;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;5;-652.2131,236.7641;Inherit;False;Property;_Color1;角色颜色;6;0;Create;False;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;61;-2285.327,-1031.768;Inherit;False;Constant;_Vector0;Vector 0;19;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;1;-850.7898,-477.2625;Inherit;True;Property;_TextureSample0;角色表面;5;0;Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;57;-2362.923,-888.158;Inherit;True;Property;_TextureSample6;冰块法线;25;0;Create;False;0;0;0;False;0;False;-1;None;47c6dd6e843f9224b9609bf1d4666201;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;4;-1089.928,-145.2186;Inherit;False;Property;_Color0;冰颜色;16;0;Create;False;0;0;0;False;0;False;0.3517711,0.6478854,0.8773585,0;0.3517711,0.6478854,0.8773585,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;54;-1082.556,128.2711;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;38;-198.8785,921.3498;Inherit;True;Property;_TextureSample4;结冰突出;21;0;Create;False;0;0;0;False;0;False;-1;None;3433162ddc7ee6b4687996d52e67fac4;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;62;-2292.327,-698.7675;Inherit;False;Property;_Float10;冰块法线强度;26;0;Create;False;0;0;0;False;0;False;0;0.75;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;48;-86.06523,1262.379;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;28;-1079.273,44.5351;Inherit;False;26;Fresnel;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;56;-2386.324,-531.8575;Inherit;True;Property;_TextureSample5;角色法线;9;0;Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-828.2959,-859.2483;Inherit;True;Property;_TextureSample1;冰块表面;15;0;Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;17;-510.1644,1036.225;Inherit;False;IceDisslove;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;64;-2296.501,-335.5799;Inherit;False;Property;_Float11;角色法线强度;10;0;Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;60;-2026.901,-940.4999;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-366.4731,201.4182;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;63;-1976.701,-622.88;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;59;-1981.589,-333.573;Inherit;False;17;IceDisslove;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;47;96.03346,1393.236;Inherit;False;17;IceDisslove;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;42;148.7406,1274.304;Inherit;False;Constant;_Float6;Float 6;13;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;50;-213.9951,-769.726;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;16;-208.3362,-254.1225;Inherit;False;17;IceDisslove;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;29;-784,-48;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;18;-638.4958,482.3653;Inherit;False;17;IceDisslove;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;215.7547,1040.188;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;100;-703.9442,577.246;Inherit;False;Property;_IceIntensity;IceIntensity;30;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;67;31.63025,-44.61169;Inherit;False;Property;_Float12;Metallic;7;0;Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;2;95.82127,-453.6921;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;58;-1612.022,-592.6581;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;41;423.2485,1188.589;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;68;6.630249,47.38831;Inherit;False;Property;_Float13;Smoothness;8;0;Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;14;-84.37928,171.4495;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;99;-301.7464,541.9172;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;319.8,-96.20002;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;cokey/Ice_2.0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;0;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;78;0;79;0
WireConnection;78;1;70;2
WireConnection;72;0;78;0
WireConnection;72;1;71;2
WireConnection;80;0;72;0
WireConnection;80;1;81;0
WireConnection;82;0;80;0
WireConnection;43;0;45;0
WireConnection;43;1;46;0
WireConnection;73;0;82;0
WireConnection;85;0;84;1
WireConnection;85;1;73;0
WireConnection;31;0;43;0
WireConnection;31;1;33;0
WireConnection;32;0;12;0
WireConnection;32;1;31;0
WireConnection;20;2;22;0
WireConnection;20;3;21;0
WireConnection;94;0;85;0
WireConnection;7;1;32;0
WireConnection;93;0;36;0
WireConnection;93;1;94;0
WireConnection;35;0;20;0
WireConnection;95;0;93;0
WireConnection;11;0;9;0
WireConnection;11;1;10;0
WireConnection;23;0;35;0
WireConnection;23;1;24;0
WireConnection;76;0;7;1
WireConnection;76;1;73;0
WireConnection;26;0;23;0
WireConnection;53;1;52;0
WireConnection;8;0;76;0
WireConnection;8;1;9;0
WireConnection;8;2;11;0
WireConnection;57;1;97;0
WireConnection;54;0;53;0
WireConnection;54;1;55;0
WireConnection;38;1;98;0
WireConnection;3;1;96;0
WireConnection;17;0;8;0
WireConnection;60;0;61;0
WireConnection;60;1;57;0
WireConnection;60;2;62;0
WireConnection;19;0;1;0
WireConnection;19;1;5;0
WireConnection;63;0;61;0
WireConnection;63;1;56;0
WireConnection;63;2;64;0
WireConnection;50;0;1;0
WireConnection;50;1;3;0
WireConnection;50;2;51;0
WireConnection;29;0;4;0
WireConnection;29;1;28;0
WireConnection;29;2;54;0
WireConnection;39;0;38;0
WireConnection;39;1;40;0
WireConnection;39;2;48;0
WireConnection;2;0;50;0
WireConnection;2;1;1;0
WireConnection;2;2;16;0
WireConnection;58;0;60;0
WireConnection;58;1;63;0
WireConnection;58;2;59;0
WireConnection;41;0;39;0
WireConnection;41;1;42;0
WireConnection;41;2;47;0
WireConnection;14;0;29;0
WireConnection;14;1;19;0
WireConnection;14;2;18;0
WireConnection;99;1;100;0
WireConnection;0;0;2;0
WireConnection;0;1;58;0
WireConnection;0;2;14;0
WireConnection;0;3;67;0
WireConnection;0;4;68;0
WireConnection;0;11;41;0
ASEEND*/
//CHKSM=379FC7AF9D65CB98F538EA2A8DBF8AD44564771D