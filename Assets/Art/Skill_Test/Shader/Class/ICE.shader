// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.08088237,fgcg:0.08088237,fgcb:0.08088237,fgca:1,fgde:0.015,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:8389,x:34022,y:32540,varname:node_8389,prsc:2|emission-5493-OUT,alpha-9902-OUT,refract-8979-OUT;n:type:ShaderForge.SFN_Tex2d,id:4355,x:32608,y:32478,ptovrint:False,ptlb:Tex,ptin:_Tex,varname:node_1940,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Color,id:9515,x:32608,y:32272,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_9740,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.2452422,c2:0.5036393,c3:0.9264706,c4:1;n:type:ShaderForge.SFN_Fresnel,id:4664,x:32599,y:32905,varname:node_4664,prsc:2|EXP-5408-OUT;n:type:ShaderForge.SFN_ValueProperty,id:5408,x:32447,y:32905,ptovrint:False,ptlb:Fresnel,ptin:_Fresnel,varname:node_2396,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:3738,x:32698,y:32958,ptovrint:False,ptlb:FrenePower,ptin:_FrenePower,varname:_NormalPower_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1.1;n:type:ShaderForge.SFN_Multiply,id:2405,x:32921,y:32546,varname:node_2405,prsc:2|A-9515-RGB,B-4355-RGB;n:type:ShaderForge.SFN_Multiply,id:4671,x:32845,y:32799,varname:node_4671,prsc:2|A-5148-RGB,B-4664-OUT,C-3738-OUT;n:type:ShaderForge.SFN_Color,id:5148,x:32572,y:32748,ptovrint:False,ptlb:Fre Color,ptin:_FreColor,varname:_node_9740_copy,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.2452422,c2:0.5036393,c3:0.9264706,c4:1;n:type:ShaderForge.SFN_Add,id:5493,x:33249,y:32815,varname:node_5493,prsc:2|A-2405-OUT,B-4671-OUT,C-6925-OUT;n:type:ShaderForge.SFN_Cubemap,id:5011,x:32398,y:33128,ptovrint:False,ptlb:CubeMap,ptin:_CubeMap,varname:node_2127,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,pvfc:0;n:type:ShaderForge.SFN_Desaturate,id:1821,x:32594,y:33122,varname:node_1821,prsc:2|COL-5011-RGB;n:type:ShaderForge.SFN_ValueProperty,id:3429,x:32594,y:33268,ptovrint:False,ptlb:cupemapspower,ptin:_cupemapspower,varname:node_893,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5;n:type:ShaderForge.SFN_Multiply,id:6925,x:32786,y:33141,varname:node_6925,prsc:2|A-1821-OUT,B-3429-OUT;n:type:ShaderForge.SFN_Tex2d,id:5782,x:33333,y:33029,ptovrint:False,ptlb:Ref,ptin:_Ref,varname:node_5782,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Lerp,id:8979,x:33677,y:33203,varname:node_8979,prsc:2|A-4371-OUT,B-8205-OUT,T-8087-OUT;n:type:ShaderForge.SFN_ValueProperty,id:8087,x:33600,y:33446,ptovrint:False,ptlb:REFPOwer,ptin:_REFPOwer,varname:node_8087,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:9902,x:33684,y:32817,ptovrint:False,ptlb:op,ptin:_op,varname:node_9902,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Append,id:4371,x:33513,y:33058,varname:node_4371,prsc:2|A-5782-R,B-5782-G;n:type:ShaderForge.SFN_Vector1,id:8205,x:33190,y:33255,varname:node_8205,prsc:2,v1:0;n:type:ShaderForge.SFN_Cubemap,id:5860,x:32108,y:33205,ptovrint:False,ptlb:node_5860,ptin:_node_5860,varname:node_5860,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,pvfc:0;proporder:4355-9515-5408-3738-5148-5011-3429-5782-8087-9902;pass:END;sub:END;*/

Shader "cokey/other/Ice" {
    Properties {
        _Tex ("Tex", 2D) = "white" {}
        [HDR]_Color ("Color", Color) = (0.2452422,0.5036393,0.9264706,1)
        _Fresnel ("Fresnel", Float ) = 1
        _FrenePower ("FrenePower", Float ) = 1.1
        [HDR]_FreColor ("Fre Color", Color) = (0.2452422,0.5036393,0.9264706,1)
        _CubeMap ("CubeMap", Cube) = "_Skybox" {}
        _cupemapspower ("cupemapspower", Float ) = 0.5
        _Ref ("Ref", 2D) = "white" {}
        _REFPOwer ("REFPOwer", Float ) = 0
        _op ("op", Float ) = 1
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
            uniform sampler2D _Tex; uniform float4 _Tex_ST;
            uniform float4 _Color;
            uniform float _Fresnel;
            uniform float _FrenePower;
            uniform float4 _FreColor;
            uniform samplerCUBE _CubeMap;
            uniform float _cupemapspower;
            uniform sampler2D _Ref; uniform float4 _Ref_ST;
            uniform float _REFPOwer;
            uniform float _op;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float4 projPos : TEXCOORD3;
                UNITY_FOG_COORDS(4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float4 _Ref_var = tex2D(_Ref,TRANSFORM_TEX(i.uv0, _Ref));
                float node_8205 = 0.0;
                float2 sceneUVs = (i.projPos.xy / i.projPos.w) + lerp(float2(_Ref_var.r,_Ref_var.g),float2(node_8205,node_8205),_REFPOwer);
                float4 sceneColor = tex2D(_GrabTexture, sceneUVs);
////// Lighting:
////// Emissive:
                float4 _Tex_var = tex2D(_Tex,TRANSFORM_TEX(i.uv0, _Tex));
                float3 emissive = ((_Color.rgb*_Tex_var.rgb)+(_FreColor.rgb*pow(1.0-max(0,dot(normalDirection, viewDirection)),_Fresnel)*_FrenePower)+(dot(texCUBE(_CubeMap,viewReflectDirection).rgb,float3(0.3,0.59,0.11))*_cupemapspower));
                float3 finalColor = emissive;
                fixed4 finalRGBA = fixed4(lerp(sceneColor.rgb, finalColor,_op),1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
