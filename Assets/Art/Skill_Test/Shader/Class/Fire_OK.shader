// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:1761,x:33900,y:32561,varname:node_1761,prsc:2|emission-2320-OUT,alpha-4889-OUT,voffset-8570-OUT;n:type:ShaderForge.SFN_Tex2d,id:5485,x:30812,y:32613,ptovrint:False,ptlb:Textures,ptin:_Textures,varname:node_5485,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-7461-OUT;n:type:ShaderForge.SFN_TexCoord,id:1130,x:29756,y:32107,varname:node_1130,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Time,id:3610,x:29543,y:32164,varname:node_3610,prsc:2;n:type:ShaderForge.SFN_ValueProperty,id:8092,x:29566,y:32008,ptovrint:False,ptlb:U Speed,ptin:_USpeed,varname:node_8092,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:899,x:29568,y:32349,ptovrint:False,ptlb:V Speed,ptin:_VSpeed,varname:node_899,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Multiply,id:6103,x:29851,y:32394,varname:node_6103,prsc:2|A-3610-T,B-899-OUT;n:type:ShaderForge.SFN_Multiply,id:2835,x:29768,y:31961,varname:node_2835,prsc:2|A-8092-OUT,B-3610-T;n:type:ShaderForge.SFN_Append,id:7461,x:30138,y:32126,varname:node_7461,prsc:2|A-5074-OUT,B-31-OUT;n:type:ShaderForge.SFN_Add,id:5074,x:29952,y:32038,varname:node_5074,prsc:2|A-2835-OUT,B-1130-U;n:type:ShaderForge.SFN_Add,id:31,x:30063,y:32260,varname:node_31,prsc:2|A-1130-V,B-6103-OUT;n:type:ShaderForge.SFN_Tex2d,id:272,x:31285,y:33225,ptovrint:False,ptlb:Opacity Textures,ptin:_OpacityTextures,varname:node_272,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-1785-OUT;n:type:ShaderForge.SFN_SwitchProperty,id:1785,x:30862,y:33132,ptovrint:False,ptlb:PanUV,ptin:_PanUV,varname:node_9480,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-3064-OUT,B-1362-OUT;n:type:ShaderForge.SFN_TexCoord,id:3152,x:29738,y:32888,varname:node_3152,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Add,id:358,x:30070,y:32877,varname:node_358,prsc:2|A-3152-UVOUT,B-2626-OUT;n:type:ShaderForge.SFN_Append,id:2626,x:29975,y:33016,varname:node_2626,prsc:2|A-1530-Z,B-1530-W;n:type:ShaderForge.SFN_TexCoord,id:1530,x:29690,y:33071,varname:node_1530,prsc:2,uv:1,uaff:True;n:type:ShaderForge.SFN_TexCoord,id:925,x:30402,y:33397,varname:node_925,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Multiply,id:6743,x:30426,y:33575,varname:node_6743,prsc:2|A-2775-T,B-1871-OUT;n:type:ShaderForge.SFN_Multiply,id:4948,x:30414,y:33251,varname:node_4948,prsc:2|A-773-OUT,B-2775-T;n:type:ShaderForge.SFN_Append,id:3064,x:30784,y:33416,varname:node_3064,prsc:2|A-8670-OUT,B-8504-OUT;n:type:ShaderForge.SFN_Add,id:8670,x:30598,y:33328,varname:node_8670,prsc:2|A-4948-OUT,B-925-U;n:type:ShaderForge.SFN_Add,id:8504,x:30598,y:33525,varname:node_8504,prsc:2|A-925-V,B-6743-OUT;n:type:ShaderForge.SFN_Time,id:2775,x:30189,y:33468,varname:node_2775,prsc:2;n:type:ShaderForge.SFN_ValueProperty,id:773,x:30189,y:33251,ptovrint:False,ptlb:OpacityU_Speed,ptin:_OpacityU_Speed,varname:node_773,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:1871,x:30189,y:33629,ptovrint:False,ptlb:OpacityV_Speed,ptin:_OpacityV_Speed,varname:_OpacityU_Speed_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_SwitchProperty,id:1362,x:30470,y:32947,ptovrint:False,ptlb:Tile Off,ptin:_TileOff,varname:node_1362,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-358-OUT,B-205-OUT;n:type:ShaderForge.SFN_Clamp01,id:205,x:30222,y:33016,varname:node_205,prsc:2|IN-358-OUT;n:type:ShaderForge.SFN_Smoothstep,id:4889,x:32476,y:32943,varname:node_4889,prsc:2|A-5266-OUT,B-9042-OUT,V-1777-OUT;n:type:ShaderForge.SFN_Add,id:9042,x:32007,y:32835,varname:node_9042,prsc:2|A-5266-OUT,B-6569-OUT;n:type:ShaderForge.SFN_TexCoord,id:1040,x:31540,y:32630,varname:node_1040,prsc:2,uv:1,uaff:True;n:type:ShaderForge.SFN_Multiply,id:1777,x:31718,y:33170,varname:node_1777,prsc:2|A-5485-R,B-272-R;n:type:ShaderForge.SFN_Color,id:3686,x:32330,y:32294,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_3686,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:2320,x:32878,y:32272,varname:node_2320,prsc:2|A-3686-RGB,B-8300-RGB,C-1786-OUT;n:type:ShaderForge.SFN_VertexColor,id:8300,x:32330,y:32426,varname:node_8300,prsc:2;n:type:ShaderForge.SFN_Lerp,id:1786,x:32915,y:32610,varname:node_1786,prsc:2|A-5485-RGB,B-4297-OUT,T-1690-OUT;n:type:ShaderForge.SFN_Vector1,id:4297,x:32614,y:32732,varname:node_4297,prsc:2,v1:1;n:type:ShaderForge.SFN_SwitchProperty,id:5266,x:31869,y:32697,ptovrint:False,ptlb:RongJieUV or Value,ptin:_RongJieUVorValue,varname:node_5266,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-1040-U,B-3473-OUT;n:type:ShaderForge.SFN_ValueProperty,id:3473,x:31524,y:32820,ptovrint:False,ptlb:Rongjie,ptin:_Rongjie,varname:node_3473,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:6569,x:31761,y:32902,ptovrint:False,ptlb:Soft,ptin:_Soft,varname:node_6569,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:1690,x:32614,y:32837,ptovrint:False,ptlb:Detil,ptin:_Detil,varname:node_1690,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Tex2d,id:8843,x:33311,y:32988,ptovrint:False,ptlb:Vertex,ptin:_Vertex,varname:node_8843,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-8268-OUT;n:type:ShaderForge.SFN_TexCoord,id:1840,x:33311,y:33179,varname:node_1840,prsc:2,uv:1,uaff:True;n:type:ShaderForge.SFN_Multiply,id:70,x:33665,y:33051,varname:node_70,prsc:2|A-8843-RGB,B-1840-V,C-140-OUT;n:type:ShaderForge.SFN_NormalVector,id:140,x:33298,y:33337,prsc:2,pt:False;n:type:ShaderForge.SFN_SwitchProperty,id:8570,x:33830,y:33202,ptovrint:False,ptlb:VertexOffset,ptin:_VertexOffset,varname:node_8570,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-9851-OUT,B-70-OUT;n:type:ShaderForge.SFN_Vector1,id:9851,x:33631,y:33316,varname:node_9851,prsc:2,v1:0;n:type:ShaderForge.SFN_TexCoord,id:2162,x:32560,y:33582,varname:node_2162,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Multiply,id:6313,x:32655,y:33869,varname:node_6313,prsc:2|A-2301-T,B-8882-OUT;n:type:ShaderForge.SFN_Multiply,id:9297,x:32572,y:33436,varname:node_9297,prsc:2|A-3953-OUT,B-2301-T;n:type:ShaderForge.SFN_Add,id:8758,x:32756,y:33513,varname:node_8758,prsc:2|A-9297-OUT,B-2162-U;n:type:ShaderForge.SFN_Add,id:7556,x:32756,y:33707,varname:node_7556,prsc:2|A-2162-V,B-6313-OUT;n:type:ShaderForge.SFN_Time,id:2301,x:32347,y:33639,varname:node_2301,prsc:2;n:type:ShaderForge.SFN_ValueProperty,id:3953,x:32315,y:33397,ptovrint:False,ptlb:VPanU,ptin:_VPanU,varname:node_3953,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:8882,x:32296,y:33866,ptovrint:False,ptlb:VPanV,ptin:_VPanV,varname:_VPanU_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Append,id:8268,x:32987,y:33555,varname:node_8268,prsc:2|A-8758-OUT,B-7556-OUT;proporder:5485-3686-1690-3473-5266-6569-1785-1362-8092-899-272-773-1871-8843-8570-3953-8882;pass:END;sub:END;*/

Shader "cokey/Fire/Fire_Lesson" {
    Properties {
        _Textures ("Textures", 2D) = "white" {}
        [HDR]_Color ("Color", Color) = (0.5,0.5,0.5,1)
        _Detil ("Detil", Float ) = 0
        _Rongjie ("Rongjie", Float ) = 0
        [MaterialToggle] _RongJieUVorValue ("RongJieUV or Value", Float ) = 0
        _Soft ("Soft", Float ) = 0
        [MaterialToggle] _PanUV ("PanUV", Float ) = 0
        [MaterialToggle] _TileOff ("Tile Off", Float ) = 0
        _USpeed ("U Speed", Float ) = 0
        _VSpeed ("V Speed", Float ) = 0
        _OpacityTextures ("Opacity Textures", 2D) = "white" {}
        _OpacityU_Speed ("OpacityU_Speed", Float ) = 0
        _OpacityV_Speed ("OpacityV_Speed", Float ) = 0
        _Vertex ("Vertex", 2D) = "white" {}
        [MaterialToggle] _VertexOffset ("VertexOffset", Float ) = 0
        _VPanU ("VPanU", Float ) = 0
        _VPanV ("VPanV", Float ) = 0
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        LOD 100
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend SrcAlpha OneMinusSrcAlpha
            Cull Off
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _Textures; uniform float4 _Textures_ST;
            uniform float _USpeed;
            uniform float _VSpeed;
            uniform sampler2D _OpacityTextures; uniform float4 _OpacityTextures_ST;
            uniform fixed _PanUV;
            uniform float _OpacityU_Speed;
            uniform float _OpacityV_Speed;
            uniform fixed _TileOff;
            uniform float4 _Color;
            uniform fixed _RongJieUVorValue;
            uniform float _Rongjie;
            uniform float _Soft;
            uniform float _Detil;
            uniform sampler2D _Vertex; uniform float4 _Vertex_ST;
            uniform fixed _VertexOffset;
            uniform float _VPanU;
            uniform float _VPanV;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
                float4 texcoord1 : TEXCOORD1;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 uv1 : TEXCOORD1;
                float4 posWorld : TEXCOORD2;
                float3 normalDir : TEXCOORD3;
                float4 vertexColor : COLOR;
                UNITY_FOG_COORDS(4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.vertexColor = v.vertexColor;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                float4 node_2301 = _Time;
                float2 node_8268 = float2(((_VPanU*node_2301.g)+o.uv0.r),(o.uv0.g+(node_2301.g*_VPanV)));
                float4 _Vertex_var = tex2Dlod(_Vertex,float4(TRANSFORM_TEX(node_8268, _Vertex),0.0,0));
                v.vertex.xyz += lerp( 0.0, (_Vertex_var.rgb*o.uv1.g*v.normal), _VertexOffset );
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
////// Lighting:
////// Emissive:
                float4 node_3610 = _Time;
                float2 node_7461 = float2(((_USpeed*node_3610.g)+i.uv0.r),(i.uv0.g+(node_3610.g*_VSpeed)));
                float4 _Textures_var = tex2D(_Textures,TRANSFORM_TEX(node_7461, _Textures));
                float node_4297 = 1.0;
                float3 emissive = (_Color.rgb*i.vertexColor.rgb*lerp(_Textures_var.rgb,float3(node_4297,node_4297,node_4297),_Detil));
                float3 finalColor = emissive;
                float _RongJieUVorValue_var = lerp( i.uv1.r, _Rongjie, _RongJieUVorValue );
                float4 node_2775 = _Time;
                float2 node_358 = (i.uv0+float2(i.uv1.b,i.uv1.a));
                float2 _PanUV_var = lerp( float2(((_OpacityU_Speed*node_2775.g)+i.uv0.r),(i.uv0.g+(node_2775.g*_OpacityV_Speed))), lerp( node_358, saturate(node_358), _TileOff ), _PanUV );
                float4 _OpacityTextures_var = tex2D(_OpacityTextures,TRANSFORM_TEX(_PanUV_var, _OpacityTextures));
                fixed4 finalRGBA = fixed4(finalColor,smoothstep( _RongJieUVorValue_var, (_RongJieUVorValue_var+_Soft), (_Textures_var.r*_OpacityTextures_var.r) ));
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Offset 1, 1
            Cull Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _Vertex; uniform float4 _Vertex_ST;
            uniform fixed _VertexOffset;
            uniform float _VPanU;
            uniform float _VPanV;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
                float4 texcoord1 : TEXCOORD1;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float2 uv0 : TEXCOORD1;
                float4 uv1 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
                float3 normalDir : TEXCOORD4;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                float4 node_2301 = _Time;
                float2 node_8268 = float2(((_VPanU*node_2301.g)+o.uv0.r),(o.uv0.g+(node_2301.g*_VPanV)));
                float4 _Vertex_var = tex2Dlod(_Vertex,float4(TRANSFORM_TEX(node_8268, _Vertex),0.0,0));
                v.vertex.xyz += lerp( 0.0, (_Vertex_var.rgb*o.uv1.g*v.normal), _VertexOffset );
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
