// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.08088237,fgcg:0.08088237,fgcb:0.08088237,fgca:1,fgde:0.015,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:8389,x:34642,y:32483,varname:node_8389,prsc:2|diff-5248-OUT,spec-2556-OUT,gloss-8580-OUT,normal-7362-OUT,emission-9593-OUT,clip-423-OUT,voffset-6240-OUT;n:type:ShaderForge.SFN_Tex2d,id:4355,x:32614,y:32345,ptovrint:False,ptlb:Tex,ptin:_Tex,varname:node_1940,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Color,id:9515,x:32627,y:32201,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_9740,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.2452422,c2:0.5036393,c3:0.9264706,c4:1;n:type:ShaderForge.SFN_Fresnel,id:4664,x:32079,y:32817,varname:node_4664,prsc:2|EXP-5408-OUT;n:type:ShaderForge.SFN_ValueProperty,id:5408,x:31927,y:32817,ptovrint:False,ptlb:Fresnel,ptin:_Fresnel,varname:node_2396,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:3738,x:32223,y:32942,ptovrint:False,ptlb:FrenePower,ptin:_FrenePower,varname:_NormalPower_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1.1;n:type:ShaderForge.SFN_Multiply,id:2405,x:32921,y:32546,varname:node_2405,prsc:2|A-9515-RGB,B-4355-RGB,C-8769-RGB;n:type:ShaderForge.SFN_Color,id:5148,x:32150,y:32645,ptovrint:False,ptlb:FreCOlor,ptin:_FreCOlor,varname:_node_9740_copy,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.2452422,c2:0.5036393,c3:0.9264706,c4:1;n:type:ShaderForge.SFN_Add,id:5493,x:33395,y:32620,varname:node_5493,prsc:2|A-2405-OUT,B-6925-OUT,C-9171-OUT,D-1240-OUT;n:type:ShaderForge.SFN_Cubemap,id:5011,x:32398,y:33128,ptovrint:False,ptlb:CubeMap,ptin:_CubeMap,varname:node_2127,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,pvfc:0;n:type:ShaderForge.SFN_Desaturate,id:1821,x:32594,y:33122,varname:node_1821,prsc:2|COL-5011-RGB;n:type:ShaderForge.SFN_ValueProperty,id:3429,x:32594,y:33268,ptovrint:False,ptlb:cupemapspower,ptin:_cupemapspower,varname:node_893,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5;n:type:ShaderForge.SFN_Multiply,id:6925,x:32786,y:33141,varname:node_6925,prsc:2|A-1821-OUT,B-3429-OUT;n:type:ShaderForge.SFN_VertexColor,id:8769,x:32594,y:32584,varname:node_8769,prsc:2;n:type:ShaderForge.SFN_Lerp,id:7362,x:34228,y:32959,varname:node_7362,prsc:2|A-604-OUT,B-4998-RGB,T-1291-OUT;n:type:ShaderForge.SFN_Tex2d,id:4998,x:33959,y:32949,ptovrint:False,ptlb:NOrmar,ptin:_NOrmar,varname:node_4998,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_ValueProperty,id:1291,x:33959,y:33138,ptovrint:False,ptlb:Npower,ptin:_Npower,varname:node_1291,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Vector3,id:604,x:33959,y:32842,varname:node_604,prsc:2,v1:0,v2:0,v3:1;n:type:ShaderForge.SFN_Tex2d,id:8944,x:33278,y:32000,ptovrint:False,ptlb:Diffuse,ptin:_Diffuse,varname:node_8944,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Color,id:7302,x:33264,y:31813,ptovrint:False,ptlb:DiffuseColor,ptin:_DiffuseColor,varname:node_7302,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:5248,x:33646,y:31952,varname:node_5248,prsc:2|A-7302-RGB,B-8944-RGB;n:type:ShaderForge.SFN_Tex2d,id:9538,x:32754,y:33412,ptovrint:False,ptlb:Crack,ptin:_Crack,varname:node_9538,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:1240,x:33058,y:33505,varname:node_1240,prsc:2|A-9538-RGB,B-979-RGB;n:type:ShaderForge.SFN_Color,id:979,x:32767,y:33611,ptovrint:False,ptlb:CrackLight,ptin:_CrackLight,varname:node_979,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:9171,x:32502,y:32791,varname:node_9171,prsc:2|A-5148-RGB,B-4664-OUT,C-3738-OUT;n:type:ShaderForge.SFN_ValueProperty,id:2556,x:34035,y:32437,ptovrint:False,ptlb:Specular,ptin:_Specular,varname:node_2556,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:8580,x:33995,y:32521,ptovrint:False,ptlb:Gloss,ptin:_Gloss,varname:node_8580,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Tex2d,id:7461,x:33375,y:33046,ptovrint:False,ptlb:SnowMask,ptin:_SnowMask,varname:node_7461,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:ae706175bb8022e41be26e760f43f622,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:6240,x:34081,y:33276,varname:node_6240,prsc:2|A-7461-RGB,B-4951-OUT,C-2237-OUT;n:type:ShaderForge.SFN_ValueProperty,id:4951,x:33717,y:33421,ptovrint:False,ptlb:SnowVetexPower,ptin:_SnowVetexPower,varname:node_4951,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_NormalVector,id:2237,x:33776,y:33531,prsc:2,pt:False;n:type:ShaderForge.SFN_Lerp,id:6866,x:33674,y:32736,varname:node_6866,prsc:2|A-5493-OUT,B-8759-OUT,T-7461-RGB;n:type:ShaderForge.SFN_Tex2d,id:8569,x:33245,y:32286,ptovrint:False,ptlb:SnowTextures,ptin:_SnowTextures,varname:node_8569,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Color,id:2459,x:33230,y:32473,ptovrint:False,ptlb:SnorColor,ptin:_SnorColor,varname:node_2459,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Add,id:8759,x:33423,y:32412,varname:node_8759,prsc:2|A-8569-RGB,B-2459-RGB;n:type:ShaderForge.SFN_Smoothstep,id:88,x:34505,y:33839,varname:node_88,prsc:2|A-2870-U,B-5475-OUT,V-172-R;n:type:ShaderForge.SFN_Tex2d,id:172,x:34103,y:33964,ptovrint:False,ptlb:RongJie,ptin:_RongJie,varname:node_8001,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:841cc2ecd68f99c47a30e493b34075d5,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Add,id:5475,x:34251,y:33708,varname:node_5475,prsc:2|A-2870-U,B-307-OUT;n:type:ShaderForge.SFN_TexCoord,id:2870,x:33821,y:33742,varname:node_2870,prsc:2,uv:1,uaff:True;n:type:ShaderForge.SFN_Vector1,id:307,x:34033,y:33827,varname:node_307,prsc:2,v1:0;n:type:ShaderForge.SFN_SwitchProperty,id:423,x:34687,y:33682,ptovrint:False,ptlb:RongJieOP,ptin:_RongJieOP,varname:node_423,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-132-OUT,B-88-OUT;n:type:ShaderForge.SFN_Vector1,id:132,x:34449,y:33658,varname:node_132,prsc:2,v1:1;n:type:ShaderForge.SFN_SwitchProperty,id:9593,x:33930,y:32637,ptovrint:False,ptlb:Snow,ptin:_Snow,varname:node_9593,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-5493-OUT,B-6866-OUT;proporder:4355-9515-5408-3738-5148-5011-3429-4998-1291-8944-7302-9538-979-172-423-8580-2556-7461-9593-8569-4951-2459;pass:END;sub:END;*/

Shader "cokey/other/Ice-NoOpacity" {
    Properties {
        _Tex ("Tex", 2D) = "white" {}
        [HDR]_Color ("Color", Color) = (0.2452422,0.5036393,0.9264706,1)
        _Fresnel ("Fresnel", Float ) = 1
        _FrenePower ("FrenePower", Float ) = 1.1
        [HDR]_FreCOlor ("FreCOlor", Color) = (0.2452422,0.5036393,0.9264706,1)
        _CubeMap ("CubeMap", Cube) = "_Skybox" {}
        _cupemapspower ("cupemapspower", Float ) = 0.5
        _NOrmar ("NOrmar", 2D) = "white" {}
        _Npower ("Npower", Float ) = 0
        _Diffuse ("Diffuse", 2D) = "white" {}
        _DiffuseColor ("DiffuseColor", Color) = (0.5,0.5,0.5,1)
        _Crack ("Crack", 2D) = "white" {}
        [HDR]_CrackLight ("CrackLight", Color) = (0.5,0.5,0.5,1)
        _RongJie ("RongJie", 2D) = "white" {}
        [MaterialToggle] _RongJieOP ("RongJieOP", Float ) = 1
        _Gloss ("Gloss", Float ) = 0
        _Specular ("Specular", Float ) = 0
        _SnowMask ("SnowMask", 2D) = "white" {}
        [MaterialToggle] _Snow ("Snow", Float ) = 0
        _SnowTextures ("SnowTextures", 2D) = "white" {}
        _SnowVetexPower ("SnowVetexPower", Float ) = 0
        _SnorColor ("SnorColor", Color) = (0.5,0.5,0.5,1)
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "Queue"="AlphaTest"
            "RenderType"="TransparentCutout"
        }
        LOD 100
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
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
            uniform sampler2D _Tex; uniform float4 _Tex_ST;
            uniform float4 _Color;
            uniform float _Fresnel;
            uniform float _FrenePower;
            uniform float4 _FreCOlor;
            uniform samplerCUBE _CubeMap;
            uniform float _cupemapspower;
            uniform sampler2D _NOrmar; uniform float4 _NOrmar_ST;
            uniform float _Npower;
            uniform sampler2D _Diffuse; uniform float4 _Diffuse_ST;
            uniform float4 _DiffuseColor;
            uniform sampler2D _Crack; uniform float4 _Crack_ST;
            uniform float4 _CrackLight;
            uniform float _Specular;
            uniform float _Gloss;
            uniform sampler2D _SnowMask; uniform float4 _SnowMask_ST;
            uniform float _SnowVetexPower;
            uniform sampler2D _SnowTextures; uniform float4 _SnowTextures_ST;
            uniform float4 _SnorColor;
            uniform sampler2D _RongJie; uniform float4 _RongJie_ST;
            uniform fixed _RongJieOP;
            uniform fixed _Snow;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
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
                float3 tangentDir : TEXCOORD4;
                float3 bitangentDir : TEXCOORD5;
                float4 vertexColor : COLOR;
                LIGHTING_COORDS(6,7)
                UNITY_FOG_COORDS(8)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.vertexColor = v.vertexColor;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                float4 _SnowMask_var = tex2Dlod(_SnowMask,float4(TRANSFORM_TEX(o.uv0, _SnowMask),0.0,0));
                v.vertex.xyz += (_SnowMask_var.rgb*_SnowVetexPower*v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float4 _NOrmar_var = tex2D(_NOrmar,TRANSFORM_TEX(i.uv0, _NOrmar));
                float3 normalLocal = lerp(float3(0,0,1),_NOrmar_var.rgb,_Npower);
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float4 _RongJie_var = tex2D(_RongJie,TRANSFORM_TEX(i.uv0, _RongJie));
                clip(lerp( 1.0, smoothstep( i.uv1.r, (i.uv1.r+0.0), _RongJie_var.r ), _RongJieOP ) - 0.5);
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                UNITY_LIGHT_ATTENUATION(attenuation,i, i.posWorld.xyz);
                float3 attenColor = attenuation * _LightColor0.xyz;
///////// Gloss:
                float gloss = _Gloss;
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
                float4 _Diffuse_var = tex2D(_Diffuse,TRANSFORM_TEX(i.uv0, _Diffuse));
                float3 diffuseColor = (_DiffuseColor.rgb*_Diffuse_var.rgb);
                float3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
////// Emissive:
                float4 _Tex_var = tex2D(_Tex,TRANSFORM_TEX(i.uv0, _Tex));
                float4 _Crack_var = tex2D(_Crack,TRANSFORM_TEX(i.uv0, _Crack));
                float3 node_5493 = ((_Color.rgb*_Tex_var.rgb*i.vertexColor.rgb)+(dot(texCUBE(_CubeMap,viewReflectDirection).rgb,float3(0.3,0.59,0.11))*_cupemapspower)+(_FreCOlor.rgb*pow(1.0-max(0,dot(normalDirection, viewDirection)),_Fresnel)*_FrenePower)+(_Crack_var.rgb*_CrackLight.rgb));
                float4 _SnowTextures_var = tex2D(_SnowTextures,TRANSFORM_TEX(i.uv0, _SnowTextures));
                float4 _SnowMask_var = tex2D(_SnowMask,TRANSFORM_TEX(i.uv0, _SnowMask));
                float3 emissive = lerp( node_5493, lerp(node_5493,(_SnowTextures_var.rgb+_SnorColor.rgb),_SnowMask_var.rgb), _Snow );
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
            uniform sampler2D _Tex; uniform float4 _Tex_ST;
            uniform float4 _Color;
            uniform float _Fresnel;
            uniform float _FrenePower;
            uniform float4 _FreCOlor;
            uniform samplerCUBE _CubeMap;
            uniform float _cupemapspower;
            uniform sampler2D _NOrmar; uniform float4 _NOrmar_ST;
            uniform float _Npower;
            uniform sampler2D _Diffuse; uniform float4 _Diffuse_ST;
            uniform float4 _DiffuseColor;
            uniform sampler2D _Crack; uniform float4 _Crack_ST;
            uniform float4 _CrackLight;
            uniform float _Specular;
            uniform float _Gloss;
            uniform sampler2D _SnowMask; uniform float4 _SnowMask_ST;
            uniform float _SnowVetexPower;
            uniform sampler2D _SnowTextures; uniform float4 _SnowTextures_ST;
            uniform float4 _SnorColor;
            uniform sampler2D _RongJie; uniform float4 _RongJie_ST;
            uniform fixed _RongJieOP;
            uniform fixed _Snow;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
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
                float3 tangentDir : TEXCOORD4;
                float3 bitangentDir : TEXCOORD5;
                float4 vertexColor : COLOR;
                LIGHTING_COORDS(6,7)
                UNITY_FOG_COORDS(8)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.vertexColor = v.vertexColor;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                float4 _SnowMask_var = tex2Dlod(_SnowMask,float4(TRANSFORM_TEX(o.uv0, _SnowMask),0.0,0));
                v.vertex.xyz += (_SnowMask_var.rgb*_SnowVetexPower*v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float4 _NOrmar_var = tex2D(_NOrmar,TRANSFORM_TEX(i.uv0, _NOrmar));
                float3 normalLocal = lerp(float3(0,0,1),_NOrmar_var.rgb,_Npower);
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float4 _RongJie_var = tex2D(_RongJie,TRANSFORM_TEX(i.uv0, _RongJie));
                clip(lerp( 1.0, smoothstep( i.uv1.r, (i.uv1.r+0.0), _RongJie_var.r ), _RongJieOP ) - 0.5);
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                UNITY_LIGHT_ATTENUATION(attenuation,i, i.posWorld.xyz);
                float3 attenColor = attenuation * _LightColor0.xyz;
///////// Gloss:
                float gloss = _Gloss;
                float specPow = exp2( gloss * 10.0 + 1.0 );
////// Specular:
                float NdotL = saturate(dot( normalDirection, lightDirection ));
                float3 specularColor = float3(_Specular,_Specular,_Specular);
                float3 directSpecular = attenColor * pow(max(0,dot(halfDirection,normalDirection)),specPow)*specularColor;
                float3 specular = directSpecular;
/////// Diffuse:
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                float3 directDiffuse = max( 0.0, NdotL) * attenColor;
                float4 _Diffuse_var = tex2D(_Diffuse,TRANSFORM_TEX(i.uv0, _Diffuse));
                float3 diffuseColor = (_DiffuseColor.rgb*_Diffuse_var.rgb);
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
            Cull Back
            
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
            uniform sampler2D _SnowMask; uniform float4 _SnowMask_ST;
            uniform float _SnowVetexPower;
            uniform sampler2D _RongJie; uniform float4 _RongJie_ST;
            uniform fixed _RongJieOP;
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
                float3 normalDir : TEXCOORD3;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                float4 _SnowMask_var = tex2Dlod(_SnowMask,float4(TRANSFORM_TEX(o.uv0, _SnowMask),0.0,0));
                v.vertex.xyz += (_SnowMask_var.rgb*_SnowVetexPower*v.normal);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
                float4 _RongJie_var = tex2D(_RongJie,TRANSFORM_TEX(i.uv0, _RongJie));
                clip(lerp( 1.0, smoothstep( i.uv1.r, (i.uv1.r+0.0), _RongJie_var.r ), _RongJieOP ) - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
