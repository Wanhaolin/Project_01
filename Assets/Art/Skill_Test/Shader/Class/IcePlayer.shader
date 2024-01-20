// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:1,spmd:1,trmd:0,grmd:1,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.08088237,fgcg:0.08088237,fgcb:0.08088237,fgca:1,fgde:0.015,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:8389,x:35465,y:32591,varname:node_8389,prsc:2|diff-6158-OUT,spec-1831-OUT,gloss-8349-OUT,normal-2423-OUT,emission-1723-OUT,voffset-8693-OUT;n:type:ShaderForge.SFN_Tex2d,id:4355,x:32566,y:31911,ptovrint:False,ptlb:IceTex,ptin:_IceTex,varname:node_1940,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-4693-UVOUT;n:type:ShaderForge.SFN_Color,id:9515,x:33247,y:31858,ptovrint:False,ptlb:Icecolor,ptin:_Icecolor,varname:node_9740,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.2452422,c2:0.5036393,c3:0.9264706,c4:1;n:type:ShaderForge.SFN_Fresnel,id:4664,x:32444,y:32609,varname:node_4664,prsc:2|EXP-5408-OUT;n:type:ShaderForge.SFN_ValueProperty,id:5408,x:32293,y:32659,ptovrint:False,ptlb:Fresnel,ptin:_Fresnel,varname:node_2396,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:3738,x:32595,y:32672,ptovrint:False,ptlb:FrenePower,ptin:_FrenePower,varname:_NormalPower_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1.1;n:type:ShaderForge.SFN_Multiply,id:2405,x:33495,y:32135,varname:node_2405,prsc:2|A-9515-RGB,B-1394-OUT;n:type:ShaderForge.SFN_Multiply,id:4671,x:32717,y:32519,varname:node_4671,prsc:2|A-5148-RGB,B-4664-OUT,C-3738-OUT;n:type:ShaderForge.SFN_Color,id:5148,x:32444,y:32468,ptovrint:False,ptlb:Fre Color,ptin:_FreColor,varname:_node_9740_copy,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.2452422,c2:0.5036393,c3:0.9264706,c4:1;n:type:ShaderForge.SFN_Add,id:5493,x:33617,y:32451,varname:node_5493,prsc:2|A-2405-OUT,B-4671-OUT,C-6925-OUT;n:type:ShaderForge.SFN_Cubemap,id:5011,x:32630,y:32766,ptovrint:False,ptlb:CubeMap,ptin:_CubeMap,varname:node_2127,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,pvfc:0;n:type:ShaderForge.SFN_Desaturate,id:1821,x:32826,y:32760,varname:node_1821,prsc:2|COL-5011-RGB;n:type:ShaderForge.SFN_ValueProperty,id:3429,x:32826,y:32928,ptovrint:False,ptlb:cupemapspower,ptin:_cupemapspower,varname:node_893,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5;n:type:ShaderForge.SFN_Multiply,id:6925,x:33018,y:32779,varname:node_6925,prsc:2|A-1821-OUT,B-3429-OUT;n:type:ShaderForge.SFN_Tex2d,id:9724,x:34085,y:32086,ptovrint:False,ptlb:Nomar,ptin:_Nomar,varname:node_9724,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Lerp,id:2423,x:34378,y:32223,varname:node_2423,prsc:2|A-9724-RGB,B-5168-OUT,T-1768-OUT;n:type:ShaderForge.SFN_Vector3,id:5168,x:34091,y:32302,varname:node_5168,prsc:2,v1:0,v2:0,v3:1;n:type:ShaderForge.SFN_ValueProperty,id:1768,x:34091,y:32426,ptovrint:False,ptlb:NormalPower,ptin:_NormalPower,varname:node_1768,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Lerp,id:6158,x:34509,y:32532,varname:node_6158,prsc:2|A-5493-OUT,B-7652-RGB,T-4885-OUT;n:type:ShaderForge.SFN_Tex2d,id:7652,x:33800,y:32675,ptovrint:False,ptlb:Diffues,ptin:_Diffues,varname:node_7652,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Lerp,id:1723,x:34642,y:32881,varname:node_1723,prsc:2|A-6503-OUT,B-6476-OUT,T-4885-OUT;n:type:ShaderForge.SFN_NormalVector,id:2481,x:34775,y:33135,prsc:2,pt:False;n:type:ShaderForge.SFN_Multiply,id:9350,x:35025,y:33145,varname:node_9350,prsc:2|A-190-OUT,B-2481-OUT,C-1934-RGB;n:type:ShaderForge.SFN_Lerp,id:8693,x:35199,y:33567,varname:node_8693,prsc:2|A-9350-OUT,B-3385-OUT,T-4885-OUT;n:type:ShaderForge.SFN_Vector1,id:3385,x:34902,y:33526,varname:node_3385,prsc:2,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:190,x:34763,y:33038,ptovrint:False,ptlb:VetexPower,ptin:_VetexPower,varname:node_190,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Tex2d,id:1934,x:34791,y:33295,ptovrint:False,ptlb:VetexTextues,ptin:_VetexTextues,varname:node_1934,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Smoothstep,id:4885,x:34242,y:33490,varname:node_4885,prsc:2|A-494-OUT,B-7740-OUT,V-2870-R;n:type:ShaderForge.SFN_Color,id:2534,x:33800,y:32856,ptovrint:False,ptlb:DiffColor,ptin:_DiffColor,varname:node_2534,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0,c2:0,c3:0,c4:1;n:type:ShaderForge.SFN_Multiply,id:6476,x:34098,y:32790,varname:node_6476,prsc:2|A-7652-RGB,B-2534-RGB;n:type:ShaderForge.SFN_Relay,id:6503,x:33767,y:33040,varname:node_6503,prsc:2|IN-5493-OUT;n:type:ShaderForge.SFN_Tex2d,id:2870,x:33938,y:33635,ptovrint:False,ptlb:RongJieTextures,ptin:_RongJieTextures,varname:node_2870,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-7016-UVOUT;n:type:ShaderForge.SFN_ValueProperty,id:494,x:33792,y:33298,ptovrint:False,ptlb:RongJie,ptin:_RongJie,varname:node_494,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:5413,x:33792,y:33445,ptovrint:False,ptlb:RongJieSoft,ptin:_RongJieSoft,varname:node_5413,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Add,id:7740,x:33982,y:33468,varname:node_7740,prsc:2|A-494-OUT,B-5413-OUT;n:type:ShaderForge.SFN_Lerp,id:1394,x:33052,y:32021,varname:node_1394,prsc:2|A-4355-RGB,B-7652-RGB,T-7867-OUT;n:type:ShaderForge.SFN_Slider,id:7867,x:32600,y:32217,ptovrint:False,ptlb:IceOpacity,ptin:_IceOpacity,varname:node_7867,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_ValueProperty,id:1831,x:35075,y:32650,ptovrint:False,ptlb:Specular,ptin:_Specular,varname:node_1831,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:8349,x:35075,y:32728,ptovrint:False,ptlb:Roughness,ptin:_Roughness,varname:_Specular_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_TexCoord,id:4693,x:32351,y:31937,varname:node_4693,prsc:2,uv:2,uaff:False;n:type:ShaderForge.SFN_TexCoord,id:7016,x:33441,y:33576,varname:node_7016,prsc:2,uv:2,uaff:False;proporder:2870-494-5413-7652-2534-1831-8349-4355-9515-7867-5148-5408-3738-5011-3429-9724-1768-1934-190;pass:END;sub:END;*/

Shader "cokey/Ice/IcePlayer" {
    Properties {
        _RongJieTextures ("RongJieTextures", 2D) = "white" {}
        _RongJie ("RongJie", Float ) = 0
        _RongJieSoft ("RongJieSoft", Float ) = 0
        _Diffues ("Diffues", 2D) = "white" {}
        _DiffColor ("DiffColor", Color) = (0,0,0,1)
        _Specular ("Specular", Float ) = 0
        _Roughness ("Roughness", Float ) = 0
        _IceTex ("IceTex", 2D) = "white" {}
        [HDR]_Icecolor ("Icecolor", Color) = (0.2452422,0.5036393,0.9264706,1)
        _IceOpacity ("IceOpacity", Range(0, 1)) = 0
        [HDR]_FreColor ("Fre Color", Color) = (0.2452422,0.5036393,0.9264706,1)
        _Fresnel ("Fresnel", Float ) = 1
        _FrenePower ("FrenePower", Float ) = 1.1
        _CubeMap ("CubeMap", Cube) = "_Skybox" {}
        _cupemapspower ("cupemapspower", Float ) = 0.5
        _Nomar ("Nomar", 2D) = "white" {}
        _NormalPower ("NormalPower", Float ) = 1
        _VetexTextues ("VetexTextues", 2D) = "white" {}
        _VetexPower ("VetexPower", Float ) = 0
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        LOD 100
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Cull Off
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform sampler2D _IceTex; uniform float4 _IceTex_ST;
            uniform float4 _Icecolor;
            uniform float _Fresnel;
            uniform float _FrenePower;
            uniform float4 _FreColor;
            uniform samplerCUBE _CubeMap;
            uniform float _cupemapspower;
            uniform sampler2D _Nomar; uniform float4 _Nomar_ST;
            uniform float _NormalPower;
            uniform sampler2D _Diffues; uniform float4 _Diffues_ST;
            uniform float _VetexPower;
            uniform sampler2D _VetexTextues; uniform float4 _VetexTextues_ST;
            uniform float4 _DiffColor;
            uniform sampler2D _RongJieTextures; uniform float4 _RongJieTextures_ST;
            uniform float _RongJie;
            uniform float _RongJieSoft;
            uniform float _IceOpacity;
            uniform float _Specular;
            uniform float _Roughness;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv2 : TEXCOORD1;
                float4 posWorld : TEXCOORD2;
                float3 normalDir : TEXCOORD3;
                float3 tangentDir : TEXCOORD4;
                float3 bitangentDir : TEXCOORD5;
                LIGHTING_COORDS(6,7)
                UNITY_FOG_COORDS(8)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv2 = v.texcoord2;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                float4 _VetexTextues_var = tex2Dlod(_VetexTextues,float4(TRANSFORM_TEX(o.uv0, _VetexTextues),0.0,0));
                float node_3385 = 0.0;
                float4 _RongJieTextures_var = tex2Dlod(_RongJieTextures,float4(TRANSFORM_TEX(o.uv2, _RongJieTextures),0.0,0));
                float node_4885 = smoothstep( _RongJie, (_RongJie+_RongJieSoft), _RongJieTextures_var.r );
                v.vertex.xyz += lerp((_VetexPower*v.normal*_VetexTextues_var.rgb),float3(node_3385,node_3385,node_3385),node_4885);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float4 _Nomar_var = tex2D(_Nomar,TRANSFORM_TEX(i.uv0, _Nomar));
                float3 normalLocal = lerp(_Nomar_var.rgb,float3(0,0,1),_NormalPower);
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                UNITY_LIGHT_ATTENUATION(attenuation,i, i.posWorld.xyz);
                float3 attenColor = attenuation * _LightColor0.xyz;
///////// Gloss:
                float gloss = 1.0 - _Roughness; // Convert roughness to gloss
                float specPow = exp2( gloss * 10.0 + 1.0 );
////// Specular:
                float NdotL = saturate(dot( normalDirection, lightDirection ));
                float3 specularColor = float3(_Specular,_Specular,_Specular);
                float3 directSpecular = attenColor * pow(max(0,dot(halfDirection,normalDirection)),specPow)*specularColor;
                float3 specular = directSpecular;
/////// Diffuse:
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                float3 directDiffuse = max( 0.0, NdotL) * attenColor;
                float3 indirectDiffuse = float3(0,0,0);
                indirectDiffuse += UNITY_LIGHTMODEL_AMBIENT.rgb; // Ambient Light
                float4 _IceTex_var = tex2D(_IceTex,TRANSFORM_TEX(i.uv2, _IceTex));
                float4 _Diffues_var = tex2D(_Diffues,TRANSFORM_TEX(i.uv0, _Diffues));
                float3 node_5493 = ((_Icecolor.rgb*lerp(_IceTex_var.rgb,_Diffues_var.rgb,_IceOpacity))+(_FreColor.rgb*pow(1.0-max(0,dot(normalDirection, viewDirection)),_Fresnel)*_FrenePower)+(dot(texCUBE(_CubeMap,viewReflectDirection).rgb,float3(0.3,0.59,0.11))*_cupemapspower));
                float4 _RongJieTextures_var = tex2D(_RongJieTextures,TRANSFORM_TEX(i.uv2, _RongJieTextures));
                float node_4885 = smoothstep( _RongJie, (_RongJie+_RongJieSoft), _RongJieTextures_var.r );
                float3 diffuseColor = lerp(node_5493,_Diffues_var.rgb,node_4885);
                float3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
////// Emissive:
                float3 emissive = lerp(node_5493,(_Diffues_var.rgb*_DiffColor.rgb),node_4885);
/// Final Color:
                float3 finalColor = diffuse + specular + emissive;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            Cull Off
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform sampler2D _IceTex; uniform float4 _IceTex_ST;
            uniform float4 _Icecolor;
            uniform float _Fresnel;
            uniform float _FrenePower;
            uniform float4 _FreColor;
            uniform samplerCUBE _CubeMap;
            uniform float _cupemapspower;
            uniform sampler2D _Nomar; uniform float4 _Nomar_ST;
            uniform float _NormalPower;
            uniform sampler2D _Diffues; uniform float4 _Diffues_ST;
            uniform float _VetexPower;
            uniform sampler2D _VetexTextues; uniform float4 _VetexTextues_ST;
            uniform float4 _DiffColor;
            uniform sampler2D _RongJieTextures; uniform float4 _RongJieTextures_ST;
            uniform float _RongJie;
            uniform float _RongJieSoft;
            uniform float _IceOpacity;
            uniform float _Specular;
            uniform float _Roughness;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv2 : TEXCOORD1;
                float4 posWorld : TEXCOORD2;
                float3 normalDir : TEXCOORD3;
                float3 tangentDir : TEXCOORD4;
                float3 bitangentDir : TEXCOORD5;
                LIGHTING_COORDS(6,7)
                UNITY_FOG_COORDS(8)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv2 = v.texcoord2;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                float4 _VetexTextues_var = tex2Dlod(_VetexTextues,float4(TRANSFORM_TEX(o.uv0, _VetexTextues),0.0,0));
                float node_3385 = 0.0;
                float4 _RongJieTextures_var = tex2Dlod(_RongJieTextures,float4(TRANSFORM_TEX(o.uv2, _RongJieTextures),0.0,0));
                float node_4885 = smoothstep( _RongJie, (_RongJie+_RongJieSoft), _RongJieTextures_var.r );
                v.vertex.xyz += lerp((_VetexPower*v.normal*_VetexTextues_var.rgb),float3(node_3385,node_3385,node_3385),node_4885);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float4 _Nomar_var = tex2D(_Nomar,TRANSFORM_TEX(i.uv0, _Nomar));
                float3 normalLocal = lerp(_Nomar_var.rgb,float3(0,0,1),_NormalPower);
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                UNITY_LIGHT_ATTENUATION(attenuation,i, i.posWorld.xyz);
                float3 attenColor = attenuation * _LightColor0.xyz;
///////// Gloss:
                float gloss = 1.0 - _Roughness; // Convert roughness to gloss
                float specPow = exp2( gloss * 10.0 + 1.0 );
////// Specular:
                float NdotL = saturate(dot( normalDirection, lightDirection ));
                float3 specularColor = float3(_Specular,_Specular,_Specular);
                float3 directSpecular = attenColor * pow(max(0,dot(halfDirection,normalDirection)),specPow)*specularColor;
                float3 specular = directSpecular;
/////// Diffuse:
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                float3 directDiffuse = max( 0.0, NdotL) * attenColor;
                float4 _IceTex_var = tex2D(_IceTex,TRANSFORM_TEX(i.uv2, _IceTex));
                float4 _Diffues_var = tex2D(_Diffues,TRANSFORM_TEX(i.uv0, _Diffues));
                float3 node_5493 = ((_Icecolor.rgb*lerp(_IceTex_var.rgb,_Diffues_var.rgb,_IceOpacity))+(_FreColor.rgb*pow(1.0-max(0,dot(normalDirection, viewDirection)),_Fresnel)*_FrenePower)+(dot(texCUBE(_CubeMap,viewReflectDirection).rgb,float3(0.3,0.59,0.11))*_cupemapspower));
                float4 _RongJieTextures_var = tex2D(_RongJieTextures,TRANSFORM_TEX(i.uv2, _RongJieTextures));
                float node_4885 = smoothstep( _RongJie, (_RongJie+_RongJieSoft), _RongJieTextures_var.r );
                float3 diffuseColor = lerp(node_5493,_Diffues_var.rgb,node_4885);
                float3 diffuse = directDiffuse * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse + specular;
                fixed4 finalRGBA = fixed4(finalColor * 1,0);
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
            uniform float _VetexPower;
            uniform sampler2D _VetexTextues; uniform float4 _VetexTextues_ST;
            uniform sampler2D _RongJieTextures; uniform float4 _RongJieTextures_ST;
            uniform float _RongJie;
            uniform float _RongJieSoft;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float2 uv0 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
                float3 normalDir : TEXCOORD4;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv2 = v.texcoord2;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                float4 _VetexTextues_var = tex2Dlod(_VetexTextues,float4(TRANSFORM_TEX(o.uv0, _VetexTextues),0.0,0));
                float node_3385 = 0.0;
                float4 _RongJieTextures_var = tex2Dlod(_RongJieTextures,float4(TRANSFORM_TEX(o.uv2, _RongJieTextures),0.0,0));
                float node_4885 = smoothstep( _RongJie, (_RongJie+_RongJieSoft), _RongJieTextures_var.r );
                v.vertex.xyz += lerp((_VetexPower*v.normal*_VetexTextues_var.rgb),float3(node_3385,node_3385,node_3385),node_4885);
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
