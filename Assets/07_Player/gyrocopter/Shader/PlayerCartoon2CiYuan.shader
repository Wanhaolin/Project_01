// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:False,igpj:False,qofs:0,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.1331612,fgcg:0.127848,fgcb:0.1603774,fgca:1,fgde:0.06,fgrn:34.7,fgrf:79.6,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:8389,x:34213,y:32091,varname:node_8389,prsc:2|spec-7093-OUT,gloss-9324-OUT,emission-8445-OUT,clip-3125-OUT,olwid-4443-OUT,olcol-2042-OUT;n:type:ShaderForge.SFN_Tex2d,id:2910,x:33113,y:31643,ptovrint:False,ptlb:Diffuse,ptin:_Diffuse,varname:node_2910,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:49,x:32588,y:33378,ptovrint:False,ptlb:OutLine,ptin:_OutLine,varname:node_49,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:4443,x:32948,y:33144,varname:node_4443,prsc:2|A-2712-OUT,B-49-R;n:type:ShaderForge.SFN_Multiply,id:2042,x:32964,y:32879,varname:node_2042,prsc:2|A-9879-RGB,B-183-RGB,C-6693-OUT;n:type:ShaderForge.SFN_ValueProperty,id:2712,x:32610,y:33272,ptovrint:False,ptlb:OutLinePower,ptin:_OutLinePower,varname:node_2712,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.01;n:type:ShaderForge.SFN_Multiply,id:9844,x:31702,y:33106,varname:node_9844,prsc:2|A-3468-OUT,B-4881-RGB,C-8059-RGB;n:type:ShaderForge.SFN_Tex2d,id:4881,x:31289,y:33080,ptovrint:False,ptlb:LightMask,ptin:_LightMask,varname:node_4881,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_SwitchProperty,id:2703,x:31917,y:33048,ptovrint:False,ptlb:Light,ptin:_Light,varname:node_2703,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-8624-OUT,B-9844-OUT;n:type:ShaderForge.SFN_Vector1,id:8624,x:31702,y:33022,varname:node_8624,prsc:2,v1:0;n:type:ShaderForge.SFN_Add,id:8445,x:33782,y:32318,varname:node_8445,prsc:2|A-1084-OUT,B-2703-OUT,C-6897-OUT,D-8874-OUT;n:type:ShaderForge.SFN_Color,id:8059,x:31262,y:33266,ptovrint:False,ptlb:Lightcolor,ptin:_Lightcolor,varname:node_8059,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Step,id:6031,x:32120,y:31849,varname:node_6031,prsc:2|A-1961-R,B-6679-OUT;n:type:ShaderForge.SFN_Tex2d,id:1961,x:31636,y:31726,ptovrint:False,ptlb:RongJie,ptin:_RongJie,varname:node_1961,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_TexCoord,id:6893,x:31576,y:31903,varname:node_6893,prsc:2,uv:1,uaff:True;n:type:ShaderForge.SFN_ValueProperty,id:641,x:30384,y:31946,ptovrint:False,ptlb:HighLine,ptin:_HighLine,varname:node_641,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Add,id:2673,x:30566,y:31972,varname:node_2673,prsc:2|A-641-OUT,B-4295-Y;n:type:ShaderForge.SFN_ObjectPosition,id:4295,x:30384,y:32033,varname:node_4295,prsc:2;n:type:ShaderForge.SFN_Subtract,id:67,x:30750,y:32078,varname:node_67,prsc:2|A-2673-OUT,B-631-Y;n:type:ShaderForge.SFN_FragmentPosition,id:631,x:30409,y:32213,varname:node_631,prsc:2;n:type:ShaderForge.SFN_Clamp01,id:9564,x:30964,y:31945,varname:node_9564,prsc:2|IN-67-OUT;n:type:ShaderForge.SFN_Multiply,id:2902,x:31903,y:32116,varname:node_2902,prsc:2|A-1961-R,B-8171-OUT;n:type:ShaderForge.SFN_Step,id:1610,x:32140,y:32018,varname:node_1610,prsc:2|A-2902-OUT,B-6679-OUT;n:type:ShaderForge.SFN_SwitchProperty,id:5743,x:32323,y:31944,ptovrint:False,ptlb:SelfUV,ptin:_SelfUV,varname:node_5743,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-6031-OUT,B-1610-OUT;n:type:ShaderForge.SFN_Fresnel,id:8852,x:31261,y:33535,varname:node_8852,prsc:2|EXP-5097-OUT;n:type:ShaderForge.SFN_ValueProperty,id:5097,x:31078,y:33552,ptovrint:False,ptlb:LightFresnelPower,ptin:_LightFresnelPower,varname:node_5097,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Fresnel,id:9068,x:31383,y:32680,varname:node_9068,prsc:2|EXP-4602-OUT;n:type:ShaderForge.SFN_Multiply,id:5478,x:31647,y:32734,varname:node_5478,prsc:2|A-9068-OUT,B-6961-RGB;n:type:ShaderForge.SFN_Color,id:6961,x:31402,y:32840,ptovrint:False,ptlb:Fresnecolor,ptin:_Fresnecolor,varname:_Color_copy,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0,c2:0,c3:0,c4:1;n:type:ShaderForge.SFN_ValueProperty,id:4602,x:31161,y:32776,ptovrint:False,ptlb:FrenelPower,ptin:_FrenelPower,varname:_LightPower_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:2;n:type:ShaderForge.SFN_SwitchProperty,id:1466,x:31897,y:32777,ptovrint:False,ptlb:Frenel,ptin:_Frenel,varname:_Rongj_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-8537-OUT,B-5478-OUT;n:type:ShaderForge.SFN_Vector1,id:8537,x:31647,y:32678,varname:node_8537,prsc:2,v1:0;n:type:ShaderForge.SFN_VertexColor,id:5602,x:31213,y:32526,varname:node_5602,prsc:2;n:type:ShaderForge.SFN_SwitchProperty,id:1084,x:31973,y:32412,ptovrint:False,ptlb:PosGamp,ptin:_PosGamp,varname:node_1084,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:True|A-247-OUT,B-6594-OUT;n:type:ShaderForge.SFN_Vector1,id:247,x:31689,y:32211,varname:node_247,prsc:2,v1:0;n:type:ShaderForge.SFN_Color,id:6345,x:33111,y:31861,ptovrint:False,ptlb:DiffuseCOloer,ptin:_DiffuseCOloer,varname:node_6345,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Color,id:9879,x:32628,y:32838,ptovrint:False,ptlb:OutLineColor,ptin:_OutLineColor,varname:node_9879,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Tex2d,id:183,x:32628,y:33023,ptovrint:False,ptlb:OutLineTex,ptin:_OutLineTex,varname:node_183,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_SwitchProperty,id:3468,x:31629,y:33331,ptovrint:False,ptlb:LightFrenel\,ptin:_LightFrenel,varname:node_3468,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-4989-OUT,B-8852-OUT;n:type:ShaderForge.SFN_Vector1,id:4989,x:31441,y:33331,varname:node_4989,prsc:2,v1:1;n:type:ShaderForge.SFN_SwitchProperty,id:6679,x:31893,y:31902,ptovrint:False,ptlb:RongJieQieNO,ptin:_RongJieQieNO,varname:node_6679,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-6893-U,B-9891-OUT;n:type:ShaderForge.SFN_ValueProperty,id:9891,x:31592,y:32065,ptovrint:False,ptlb:RongJieZhi,ptin:_RongJieZhi,varname:node_9891,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_LightVector,id:6740,x:32661,y:31545,varname:node_6740,prsc:2;n:type:ShaderForge.SFN_Dot,id:5142,x:32841,y:31614,varname:node_5142,prsc:2,dt:4|A-6740-OUT,B-173-OUT;n:type:ShaderForge.SFN_NormalVector,id:173,x:32661,y:31690,prsc:2,pt:False;n:type:ShaderForge.SFN_Append,id:2196,x:32941,y:31931,varname:node_2196,prsc:2|A-5142-OUT,B-1869-OUT;n:type:ShaderForge.SFN_Vector1,id:1869,x:32712,y:31965,varname:node_1869,prsc:2,v1:0;n:type:ShaderForge.SFN_Tex2d,id:9428,x:33111,y:32063,ptovrint:False,ptlb:LightDir,ptin:_LightDir,varname:node_9428,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-2196-OUT;n:type:ShaderForge.SFN_ValueProperty,id:7093,x:33835,y:32113,ptovrint:False,ptlb:Specular,ptin:_Specular,varname:node_7093,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:9324,x:33853,y:32167,ptovrint:False,ptlb:Gloss,ptin:_Gloss,varname:node_9324,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_SwitchProperty,id:2561,x:33353,y:32174,ptovrint:False,ptlb:Self Alpha,ptin:_SelfAlpha,varname:node_2561,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-5056-OUT,B-2910-A;n:type:ShaderForge.SFN_Vector1,id:5056,x:33047,y:32409,varname:node_5056,prsc:2,v1:1;n:type:ShaderForge.SFN_Multiply,id:3125,x:33517,y:32498,varname:node_3125,prsc:2|A-2561-OUT,B-9690-OUT;n:type:ShaderForge.SFN_SwitchProperty,id:9690,x:33287,y:32638,ptovrint:False,ptlb:RongJieON,ptin:_RongJieON,varname:node_9690,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-5056-OUT,B-5743-OUT;n:type:ShaderForge.SFN_Multiply,id:6594,x:31528,y:32309,varname:node_6594,prsc:2|A-8171-OUT,B-6768-RGB;n:type:ShaderForge.SFN_Color,id:6768,x:31239,y:32366,ptovrint:False,ptlb:GampColor,ptin:_GampColor,varname:node_6768,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_SwitchProperty,id:8171,x:31269,y:32134,ptovrint:False,ptlb:Gamp One,ptin:_GampOne,varname:node_8171,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-9564-OUT,B-1135-OUT;n:type:ShaderForge.SFN_OneMinus,id:1135,x:31089,y:32178,varname:node_1135,prsc:2|IN-9564-OUT;n:type:ShaderForge.SFN_Multiply,id:8874,x:33466,y:31871,varname:node_8874,prsc:2|A-2910-RGB,B-9428-RGB,C-6345-RGB;n:type:ShaderForge.SFN_ValueProperty,id:6693,x:32628,y:33196,ptovrint:False,ptlb:OutLineGlowScale,ptin:_OutLineGlowScale,varname:_OutLinePower_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:4164,x:31897,y:32922,ptovrint:False,ptlb:FrenelGlowScale,ptin:_FrenelGlowScale,varname:_FrenelPower_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Multiply,id:6897,x:32147,y:32806,varname:node_6897,prsc:2|A-1466-OUT,B-4164-OUT;proporder:9428-2910-2561-6345-7093-9324-6768-1084-8171-641-1466-6961-4164-4602-4881-2703-8059-3468-5097-1961-9690-5743-6679-9891-49-9879-183-6693-2712;pass:END;sub:END;*/

Shader "cokey/other/PlayerCartoon2CIYuan" {
    Properties {
        _LightDir ("LightDir", 2D) = "white" {}
        _Diffuse ("Diffuse", 2D) = "white" {}
        [MaterialToggle] _SelfAlpha ("Self Alpha", Float ) = 1
        [HDR]_DiffuseCOloer ("DiffuseCOloer", Color) = (0.5,0.5,0.5,1)
        _Specular ("Specular", Float ) = 0
        _Gloss ("Gloss", Float ) = 0
        [HDR]_GampColor ("GampColor", Color) = (0.5,0.5,0.5,1)
        [MaterialToggle] _PosGamp ("PosGamp", Float ) = 0.5
        [MaterialToggle] _GampOne ("Gamp One", Float ) = 1
        _HighLine ("HighLine", Float ) = 1
        [MaterialToggle] _Frenel ("Frenel", Float ) = 0
        [HDR]_Fresnecolor ("Fresnecolor", Color) = (0,0,0,1)
        _FrenelGlowScale ("FrenelGlowScale", Float ) = 1
        _FrenelPower ("FrenelPower", Float ) = 2
        _LightMask ("LightMask", 2D) = "white" {}
        [MaterialToggle] _Light ("Light", Float ) = 0
        [HDR]_Lightcolor ("Lightcolor", Color) = (0.5,0.5,0.5,1)
        [MaterialToggle] _LightFrenel ("LightFrenel\", Float ) = 1
        _LightFresnelPower ("LightFresnelPower", Float ) = 0
        _RongJie ("RongJie", 2D) = "white" {}
        [MaterialToggle] _RongJieON ("RongJieON", Float ) = 1
        [MaterialToggle] _SelfUV ("SelfUV", Float ) = 1
        [MaterialToggle] _RongJieQieNO ("RongJieQieNO", Float ) = 0
        _RongJieZhi ("RongJieZhi", Float ) = 0
        _OutLine ("OutLine", 2D) = "white" {}
        [HDR]_OutLineColor ("OutLineColor", Color) = (0.5,0.5,0.5,1)
        _OutLineTex ("OutLineTex", 2D) = "white" {}
        _OutLineGlowScale ("OutLineGlowScale", Float ) = 1
        _OutLinePower ("OutLinePower", Float ) = 0.01
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "Queue"="AlphaTest"
            "RenderType"="TransparentCutout"
        }
        LOD 100
        Pass {
            Name "Outline"
            Tags {
            }
            Cull Front
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform sampler2D _Diffuse; uniform float4 _Diffuse_ST;
            uniform sampler2D _OutLine; uniform float4 _OutLine_ST;
            uniform sampler2D _RongJie; uniform float4 _RongJie_ST;
            uniform sampler2D _OutLineTex; uniform float4 _OutLineTex_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _OutLinePower)
                UNITY_DEFINE_INSTANCED_PROP( float, _HighLine)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _SelfUV)
                UNITY_DEFINE_INSTANCED_PROP( float4, _OutLineColor)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _RongJieQieNO)
                UNITY_DEFINE_INSTANCED_PROP( float, _RongJieZhi)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _SelfAlpha)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _RongJieON)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _GampOne)
                UNITY_DEFINE_INSTANCED_PROP( float, _OutLineGlowScale)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
                float4 texcoord1 : TEXCOORD1;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float2 uv0 : TEXCOORD0;
                float4 uv1 : TEXCOORD1;
                float4 posWorld : TEXCOORD2;
                UNITY_FOG_COORDS(3)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float _OutLinePower_var = UNITY_ACCESS_INSTANCED_PROP( Props, _OutLinePower );
                float4 _OutLine_var = tex2Dlod(_OutLine,float4(TRANSFORM_TEX(o.uv0, _OutLine),0.0,0));
                o.pos = UnityObjectToClipPos( float4(v.vertex.xyz + v.normal*(_OutLinePower_var*_OutLine_var.r),1) );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                float node_5056 = 1.0;
                float4 _Diffuse_var = tex2D(_Diffuse,TRANSFORM_TEX(i.uv0, _Diffuse));
                float _SelfAlpha_var = lerp( node_5056, _Diffuse_var.a, UNITY_ACCESS_INSTANCED_PROP( Props, _SelfAlpha ) );
                float4 _RongJie_var = tex2D(_RongJie,TRANSFORM_TEX(i.uv0, _RongJie));
                float _RongJieZhi_var = UNITY_ACCESS_INSTANCED_PROP( Props, _RongJieZhi );
                float _RongJieQieNO_var = lerp( i.uv1.r, _RongJieZhi_var, UNITY_ACCESS_INSTANCED_PROP( Props, _RongJieQieNO ) );
                float _HighLine_var = UNITY_ACCESS_INSTANCED_PROP( Props, _HighLine );
                float node_9564 = saturate(((_HighLine_var+objPos.g)-i.posWorld.g));
                float _GampOne_var = lerp( node_9564, (1.0 - node_9564), UNITY_ACCESS_INSTANCED_PROP( Props, _GampOne ) );
                float _SelfUV_var = lerp( step(_RongJie_var.r,_RongJieQieNO_var), step((_RongJie_var.r*_GampOne_var),_RongJieQieNO_var), UNITY_ACCESS_INSTANCED_PROP( Props, _SelfUV ) );
                float _RongJieON_var = lerp( node_5056, _SelfUV_var, UNITY_ACCESS_INSTANCED_PROP( Props, _RongJieON ) );
                clip((_SelfAlpha_var*_RongJieON_var) - 0.5);
                float4 _OutLineColor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _OutLineColor );
                float4 _OutLineTex_var = tex2D(_OutLineTex,TRANSFORM_TEX(i.uv0, _OutLineTex));
                float _OutLineGlowScale_var = UNITY_ACCESS_INSTANCED_PROP( Props, _OutLineGlowScale );
                return fixed4((_OutLineColor_var.rgb*_OutLineTex_var.rgb*_OutLineGlowScale_var),0);
            }
            ENDCG
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Cull Off
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform sampler2D _Diffuse; uniform float4 _Diffuse_ST;
            uniform sampler2D _LightMask; uniform float4 _LightMask_ST;
            uniform sampler2D _RongJie; uniform float4 _RongJie_ST;
            uniform sampler2D _LightDir; uniform float4 _LightDir_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( fixed, _Light)
                UNITY_DEFINE_INSTANCED_PROP( float4, _Lightcolor)
                UNITY_DEFINE_INSTANCED_PROP( float, _HighLine)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _SelfUV)
                UNITY_DEFINE_INSTANCED_PROP( float, _LightFresnelPower)
                UNITY_DEFINE_INSTANCED_PROP( float4, _Fresnecolor)
                UNITY_DEFINE_INSTANCED_PROP( float, _FrenelPower)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _Frenel)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _PosGamp)
                UNITY_DEFINE_INSTANCED_PROP( float4, _DiffuseCOloer)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _LightFrenel)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _RongJieQieNO)
                UNITY_DEFINE_INSTANCED_PROP( float, _RongJieZhi)
                UNITY_DEFINE_INSTANCED_PROP( float, _Specular)
                UNITY_DEFINE_INSTANCED_PROP( float, _Gloss)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _SelfAlpha)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _RongJieON)
                UNITY_DEFINE_INSTANCED_PROP( float4, _GampColor)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _GampOne)
                UNITY_DEFINE_INSTANCED_PROP( float, _FrenelGlowScale)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
                float4 texcoord1 : TEXCOORD1;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float2 uv0 : TEXCOORD0;
                float4 uv1 : TEXCOORD1;
                float4 posWorld : TEXCOORD2;
                float3 normalDir : TEXCOORD3;
                LIGHTING_COORDS(4,5)
                UNITY_FOG_COORDS(6)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float node_5056 = 1.0;
                float4 _Diffuse_var = tex2D(_Diffuse,TRANSFORM_TEX(i.uv0, _Diffuse));
                float _SelfAlpha_var = lerp( node_5056, _Diffuse_var.a, UNITY_ACCESS_INSTANCED_PROP( Props, _SelfAlpha ) );
                float4 _RongJie_var = tex2D(_RongJie,TRANSFORM_TEX(i.uv0, _RongJie));
                float _RongJieZhi_var = UNITY_ACCESS_INSTANCED_PROP( Props, _RongJieZhi );
                float _RongJieQieNO_var = lerp( i.uv1.r, _RongJieZhi_var, UNITY_ACCESS_INSTANCED_PROP( Props, _RongJieQieNO ) );
                float _HighLine_var = UNITY_ACCESS_INSTANCED_PROP( Props, _HighLine );
                float node_9564 = saturate(((_HighLine_var+objPos.g)-i.posWorld.g));
                float _GampOne_var = lerp( node_9564, (1.0 - node_9564), UNITY_ACCESS_INSTANCED_PROP( Props, _GampOne ) );
                float _SelfUV_var = lerp( step(_RongJie_var.r,_RongJieQieNO_var), step((_RongJie_var.r*_GampOne_var),_RongJieQieNO_var), UNITY_ACCESS_INSTANCED_PROP( Props, _SelfUV ) );
                float _RongJieON_var = lerp( node_5056, _SelfUV_var, UNITY_ACCESS_INSTANCED_PROP( Props, _RongJieON ) );
                clip((_SelfAlpha_var*_RongJieON_var) - 0.5);
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
///////// Gloss:
                float _Gloss_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Gloss );
                float gloss = _Gloss_var;
                float specPow = exp2( gloss * 10.0 + 1.0 );
////// Specular:
                float NdotL = saturate(dot( normalDirection, lightDirection ));
                float _Specular_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Specular );
                float3 specularColor = float3(_Specular_var,_Specular_var,_Specular_var);
                float3 directSpecular = attenColor * pow(max(0,dot(halfDirection,normalDirection)),specPow)*specularColor;
                float3 specular = directSpecular;
////// Emissive:
                float4 _GampColor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _GampColor );
                float3 _PosGamp_var = lerp( 0.0, (_GampOne_var*_GampColor_var.rgb), UNITY_ACCESS_INSTANCED_PROP( Props, _PosGamp ) );
                float _LightFresnelPower_var = UNITY_ACCESS_INSTANCED_PROP( Props, _LightFresnelPower );
                float _LightFrenel_var = lerp( 1.0, pow(1.0-max(0,dot(normalDirection, viewDirection)),_LightFresnelPower_var), UNITY_ACCESS_INSTANCED_PROP( Props, _LightFrenel ) );
                float4 _LightMask_var = tex2D(_LightMask,TRANSFORM_TEX(i.uv0, _LightMask));
                float4 _Lightcolor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Lightcolor );
                float3 _Light_var = lerp( 0.0, (_LightFrenel_var*_LightMask_var.rgb*_Lightcolor_var.rgb), UNITY_ACCESS_INSTANCED_PROP( Props, _Light ) );
                float _FrenelPower_var = UNITY_ACCESS_INSTANCED_PROP( Props, _FrenelPower );
                float4 _Fresnecolor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Fresnecolor );
                float3 _Frenel_var = lerp( 0.0, (pow(1.0-max(0,dot(normalDirection, viewDirection)),_FrenelPower_var)*_Fresnecolor_var.rgb), UNITY_ACCESS_INSTANCED_PROP( Props, _Frenel ) );
                float _FrenelGlowScale_var = UNITY_ACCESS_INSTANCED_PROP( Props, _FrenelGlowScale );
                float2 node_2196 = float2(0.5*dot(lightDirection,i.normalDir)+0.5,0.0);
                float4 _LightDir_var = tex2D(_LightDir,TRANSFORM_TEX(node_2196, _LightDir));
                float4 _DiffuseCOloer_var = UNITY_ACCESS_INSTANCED_PROP( Props, _DiffuseCOloer );
                float3 emissive = (_PosGamp_var+_Light_var+(_Frenel_var*_FrenelGlowScale_var)+(_Diffuse_var.rgb*_LightDir_var.rgb*_DiffuseCOloer_var.rgb));
/// Final Color:
                float3 finalColor = specular + emissive;
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
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform sampler2D _Diffuse; uniform float4 _Diffuse_ST;
            uniform sampler2D _LightMask; uniform float4 _LightMask_ST;
            uniform sampler2D _RongJie; uniform float4 _RongJie_ST;
            uniform sampler2D _LightDir; uniform float4 _LightDir_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( fixed, _Light)
                UNITY_DEFINE_INSTANCED_PROP( float4, _Lightcolor)
                UNITY_DEFINE_INSTANCED_PROP( float, _HighLine)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _SelfUV)
                UNITY_DEFINE_INSTANCED_PROP( float, _LightFresnelPower)
                UNITY_DEFINE_INSTANCED_PROP( float4, _Fresnecolor)
                UNITY_DEFINE_INSTANCED_PROP( float, _FrenelPower)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _Frenel)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _PosGamp)
                UNITY_DEFINE_INSTANCED_PROP( float4, _DiffuseCOloer)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _LightFrenel)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _RongJieQieNO)
                UNITY_DEFINE_INSTANCED_PROP( float, _RongJieZhi)
                UNITY_DEFINE_INSTANCED_PROP( float, _Specular)
                UNITY_DEFINE_INSTANCED_PROP( float, _Gloss)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _SelfAlpha)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _RongJieON)
                UNITY_DEFINE_INSTANCED_PROP( float4, _GampColor)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _GampOne)
                UNITY_DEFINE_INSTANCED_PROP( float, _FrenelGlowScale)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
                float4 texcoord1 : TEXCOORD1;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float2 uv0 : TEXCOORD0;
                float4 uv1 : TEXCOORD1;
                float4 posWorld : TEXCOORD2;
                float3 normalDir : TEXCOORD3;
                LIGHTING_COORDS(4,5)
                UNITY_FOG_COORDS(6)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float node_5056 = 1.0;
                float4 _Diffuse_var = tex2D(_Diffuse,TRANSFORM_TEX(i.uv0, _Diffuse));
                float _SelfAlpha_var = lerp( node_5056, _Diffuse_var.a, UNITY_ACCESS_INSTANCED_PROP( Props, _SelfAlpha ) );
                float4 _RongJie_var = tex2D(_RongJie,TRANSFORM_TEX(i.uv0, _RongJie));
                float _RongJieZhi_var = UNITY_ACCESS_INSTANCED_PROP( Props, _RongJieZhi );
                float _RongJieQieNO_var = lerp( i.uv1.r, _RongJieZhi_var, UNITY_ACCESS_INSTANCED_PROP( Props, _RongJieQieNO ) );
                float _HighLine_var = UNITY_ACCESS_INSTANCED_PROP( Props, _HighLine );
                float node_9564 = saturate(((_HighLine_var+objPos.g)-i.posWorld.g));
                float _GampOne_var = lerp( node_9564, (1.0 - node_9564), UNITY_ACCESS_INSTANCED_PROP( Props, _GampOne ) );
                float _SelfUV_var = lerp( step(_RongJie_var.r,_RongJieQieNO_var), step((_RongJie_var.r*_GampOne_var),_RongJieQieNO_var), UNITY_ACCESS_INSTANCED_PROP( Props, _SelfUV ) );
                float _RongJieON_var = lerp( node_5056, _SelfUV_var, UNITY_ACCESS_INSTANCED_PROP( Props, _RongJieON ) );
                clip((_SelfAlpha_var*_RongJieON_var) - 0.5);
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
///////// Gloss:
                float _Gloss_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Gloss );
                float gloss = _Gloss_var;
                float specPow = exp2( gloss * 10.0 + 1.0 );
////// Specular:
                float NdotL = saturate(dot( normalDirection, lightDirection ));
                float _Specular_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Specular );
                float3 specularColor = float3(_Specular_var,_Specular_var,_Specular_var);
                float3 directSpecular = attenColor * pow(max(0,dot(halfDirection,normalDirection)),specPow)*specularColor;
                float3 specular = directSpecular;
/// Final Color:
                float3 finalColor = specular;
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
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform sampler2D _Diffuse; uniform float4 _Diffuse_ST;
            uniform sampler2D _RongJie; uniform float4 _RongJie_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _HighLine)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _SelfUV)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _RongJieQieNO)
                UNITY_DEFINE_INSTANCED_PROP( float, _RongJieZhi)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _SelfAlpha)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _RongJieON)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _GampOne)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float4 texcoord1 : TEXCOORD1;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float2 uv0 : TEXCOORD1;
                float4 uv1 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                float node_5056 = 1.0;
                float4 _Diffuse_var = tex2D(_Diffuse,TRANSFORM_TEX(i.uv0, _Diffuse));
                float _SelfAlpha_var = lerp( node_5056, _Diffuse_var.a, UNITY_ACCESS_INSTANCED_PROP( Props, _SelfAlpha ) );
                float4 _RongJie_var = tex2D(_RongJie,TRANSFORM_TEX(i.uv0, _RongJie));
                float _RongJieZhi_var = UNITY_ACCESS_INSTANCED_PROP( Props, _RongJieZhi );
                float _RongJieQieNO_var = lerp( i.uv1.r, _RongJieZhi_var, UNITY_ACCESS_INSTANCED_PROP( Props, _RongJieQieNO ) );
                float _HighLine_var = UNITY_ACCESS_INSTANCED_PROP( Props, _HighLine );
                float node_9564 = saturate(((_HighLine_var+objPos.g)-i.posWorld.g));
                float _GampOne_var = lerp( node_9564, (1.0 - node_9564), UNITY_ACCESS_INSTANCED_PROP( Props, _GampOne ) );
                float _SelfUV_var = lerp( step(_RongJie_var.r,_RongJieQieNO_var), step((_RongJie_var.r*_GampOne_var),_RongJieQieNO_var), UNITY_ACCESS_INSTANCED_PROP( Props, _SelfUV ) );
                float _RongJieON_var = lerp( node_5056, _SelfUV_var, UNITY_ACCESS_INSTANCED_PROP( Props, _RongJieON ) );
                clip((_SelfAlpha_var*_RongJieON_var) - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
