// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:2768,x:33197,y:32692,varname:node_2768,prsc:2|alpha-4764-OUT,refract-9289-OUT;n:type:ShaderForge.SFN_Tex2d,id:819,x:32138,y:32791,ptovrint:False,ptlb:node_819,ptin:_node_819,varname:node_819,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:8b41799994002164e884e3a242efdb1f,ntxv:0,isnm:False|UVIN-7601-OUT;n:type:ShaderForge.SFN_VertexColor,id:3116,x:31995,y:32986,varname:node_3116,prsc:2;n:type:ShaderForge.SFN_Tex2d,id:2276,x:32031,y:33241,ptovrint:False,ptlb:Mask,ptin:_Mask,varname:node_2276,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Clamp01,id:6122,x:32261,y:33048,varname:node_6122,prsc:2|IN-3116-A;n:type:ShaderForge.SFN_Vector1,id:4764,x:32527,y:32821,varname:node_4764,prsc:2,v1:0;n:type:ShaderForge.SFN_Append,id:3151,x:32454,y:32894,varname:node_3151,prsc:2|A-819-R,B-819-G;n:type:ShaderForge.SFN_Multiply,id:9289,x:32895,y:33071,varname:node_9289,prsc:2|A-5995-OUT,B-6122-OUT,C-2276-R,D-2825-OUT;n:type:ShaderForge.SFN_DepthBlend,id:110,x:32478,y:33499,varname:node_110,prsc:2|DIST-7070-OUT;n:type:ShaderForge.SFN_ValueProperty,id:7070,x:32271,y:33587,ptovrint:False,ptlb:DepthPower,ptin:_DepthPower,varname:node_7070,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_SwitchProperty,id:2825,x:32686,y:33428,ptovrint:False,ptlb:Soft1,ptin:_Soft1,varname:node_2825,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-3981-OUT,B-110-OUT;n:type:ShaderForge.SFN_Vector1,id:3981,x:32424,y:33334,varname:node_3981,prsc:2,v1:1;n:type:ShaderForge.SFN_RemapRange,id:5995,x:32651,y:32917,varname:node_5995,prsc:2,frmn:0,frmx:1,tomn:-1,tomx:1|IN-3151-OUT;n:type:ShaderForge.SFN_Add,id:7928,x:31743,y:32704,varname:node_7928,prsc:2|A-4878-OUT,B-5431-U;n:type:ShaderForge.SFN_Add,id:8249,x:31665,y:33019,varname:node_8249,prsc:2|A-5431-V,B-3977-OUT;n:type:ShaderForge.SFN_ValueProperty,id:2356,x:31290,y:32684,ptovrint:False,ptlb:USpeed,ptin:_USpeed,varname:node_2356,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:3780,x:31232,y:33045,ptovrint:False,ptlb:VSpeed,ptin:_VSpeed,varname:node_3780,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Time,id:5181,x:31253,y:32800,varname:node_5181,prsc:2;n:type:ShaderForge.SFN_Multiply,id:4878,x:31458,y:32664,varname:node_4878,prsc:2|A-2356-OUT,B-5181-T;n:type:ShaderForge.SFN_Multiply,id:3977,x:31437,y:32983,varname:node_3977,prsc:2|A-5181-T,B-3780-OUT;n:type:ShaderForge.SFN_TexCoord,id:5431,x:31567,y:32809,varname:node_5431,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Append,id:7601,x:31889,y:32912,varname:node_7601,prsc:2|A-7928-OUT,B-8249-OUT;proporder:819-2276-7070-2825-2356-3780;pass:END;sub:END;*/

Shader "cokey/Refractian" {
    Properties {
        _node_819 ("node_819", 2D) = "white" {}
        _Mask ("Mask", 2D) = "white" {}
        _DepthPower ("DepthPower", Float ) = 0
        [MaterialToggle] _Soft1 ("Soft1", Float ) = 1
        _USpeed ("USpeed", Float ) = 0
        _VSpeed ("VSpeed", Float ) = 0
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        LOD 100
        GrabPass{ }
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
            uniform sampler2D _GrabTexture;
            uniform sampler2D _CameraDepthTexture;
            uniform sampler2D _node_819; uniform float4 _node_819_ST;
            uniform sampler2D _Mask; uniform float4 _Mask_ST;
            uniform float _DepthPower;
            uniform fixed _Soft1;
            uniform float _USpeed;
            uniform float _VSpeed;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 vertexColor : COLOR;
                float4 projPos : TEXCOORD1;
                UNITY_FOG_COORDS(2)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float sceneZ = max(0,LinearEyeDepth (UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(i.projPos)))) - _ProjectionParams.g);
                float partZ = max(0,i.projPos.z - _ProjectionParams.g);
                float4 node_5181 = _Time;
                float2 node_7601 = float2(((_USpeed*node_5181.g)+i.uv0.r),(i.uv0.g+(node_5181.g*_VSpeed)));
                float4 _node_819_var = tex2D(_node_819,TRANSFORM_TEX(node_7601, _node_819));
                float4 _Mask_var = tex2D(_Mask,TRANSFORM_TEX(i.uv0, _Mask));
                float2 sceneUVs = (i.projPos.xy / i.projPos.w) + ((float2(_node_819_var.r,_node_819_var.g)*2.0+-1.0)*saturate(i.vertexColor.a)*_Mask_var.r*lerp( 1.0, saturate((sceneZ-partZ)/_DepthPower), _Soft1 ));
                float4 sceneColor = tex2D(_GrabTexture, sceneUVs);
////// Lighting:
                float3 finalColor = 0;
                fixed4 finalRGBA = fixed4(lerp(sceneColor.rgb, finalColor,0.0),1);
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
            struct VertexInput {
                float4 vertex : POSITION;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
