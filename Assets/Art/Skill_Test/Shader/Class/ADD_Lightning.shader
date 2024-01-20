// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:0,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:1761,x:35776,y:32652,varname:node_1761,prsc:2|emission-5526-OUT,voffset-5945-OUT;n:type:ShaderForge.SFN_Multiply,id:3596,x:33155,y:33023,varname:node_3596,prsc:2|A-60-OUT,B-7929-OUT;n:type:ShaderForge.SFN_Tex2d,id:8357,x:31988,y:32561,ptovrint:False,ptlb:Textures,ptin:_Textures,varname:_Textures,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-8267-OUT;n:type:ShaderForge.SFN_VertexColor,id:7109,x:32577,y:32834,varname:node_7109,prsc:2;n:type:ShaderForge.SFN_Color,id:1737,x:32603,y:32588,ptovrint:False,ptlb:Color,ptin:_Color,varname:_Color,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:60,x:32880,y:32722,varname:node_60,prsc:2|A-1737-RGB,B-8357-RGB,C-3034-OUT,D-7109-RGB,E-7109-A;n:type:ShaderForge.SFN_SwitchProperty,id:2211,x:32221,y:32720,ptovrint:False,ptlb:TextureAlpha,ptin:_TextureAlpha,varname:_TextureAlpha,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-8357-R,B-8357-A;n:type:ShaderForge.SFN_Multiply,id:3034,x:32401,y:32763,varname:node_3034,prsc:2|A-2211-OUT,B-1332-OUT;n:type:ShaderForge.SFN_SwitchProperty,id:1332,x:32210,y:32960,ptovrint:False,ptlb:Mask Tex,ptin:_MaskTex,varname:_MaskTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-8726-OUT,B-1876-R;n:type:ShaderForge.SFN_Tex2d,id:1876,x:31947,y:33072,ptovrint:False,ptlb:Opacity Textures,ptin:_OpacityTextures,varname:_OpacityTextures,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-4580-OUT;n:type:ShaderForge.SFN_Vector1,id:8726,x:31947,y:32912,varname:node_8726,prsc:2,v1:1;n:type:ShaderForge.SFN_SwitchProperty,id:7929,x:32584,y:33535,ptovrint:False,ptlb:Disslove Off,ptin:_DissloveOff,varname:_DissloveOff,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-6544-OUT,B-6276-OUT;n:type:ShaderForge.SFN_Vector1,id:6544,x:32319,y:33533,varname:node_6544,prsc:2,v1:1;n:type:ShaderForge.SFN_TexCoord,id:9115,x:31326,y:33588,varname:node_9115,prsc:2,uv:1,uaff:True;n:type:ShaderForge.SFN_Tex2d,id:6481,x:31945,y:33964,ptovrint:False,ptlb:Disslove,ptin:_Disslove,varname:_Disslove,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-3828-OUT;n:type:ShaderForge.SFN_Tex2d,id:8262,x:33962,y:34636,varname:_NiuQu,prsc:2,tex:ae5de4ee441e4224a976910c0243fcee,ntxv:0,isnm:False|UVIN-5564-OUT,TEX-7187-TEX;n:type:ShaderForge.SFN_Append,id:5564,x:33332,y:34796,varname:node_5564,prsc:2|A-7506-OUT,B-2572-OUT;n:type:ShaderForge.SFN_Add,id:7506,x:33124,y:34746,varname:node_7506,prsc:2|A-1183-OUT,B-7181-U;n:type:ShaderForge.SFN_Add,id:2572,x:33124,y:34943,varname:node_2572,prsc:2|A-7181-V,B-3857-OUT;n:type:ShaderForge.SFN_Multiply,id:3857,x:32952,y:34990,varname:node_3857,prsc:2|A-3347-T,B-7675-OUT;n:type:ShaderForge.SFN_Multiply,id:1183,x:32940,y:34669,varname:node_1183,prsc:2|A-4681-OUT,B-3347-T;n:type:ShaderForge.SFN_Time,id:3347,x:32715,y:34886,varname:node_3347,prsc:2;n:type:ShaderForge.SFN_ValueProperty,id:4681,x:32738,y:34716,ptovrint:False,ptlb:U speed Niuqu,ptin:_UspeedNiuqu,varname:_UspeedNiuqu,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:7675,x:32740,y:35057,ptovrint:False,ptlb:V Speed Niuqu,ptin:_VSpeedNiuqu,varname:_VSpeedNiuqu,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_TexCoord,id:7181,x:32919,y:34805,varname:node_7181,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_SwitchProperty,id:6189,x:31930,y:33495,ptovrint:False,ptlb:Disslove UV or Power,ptin:_DissloveUVorPower,varname:_DissloveUVorPower,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-1519-OUT,B-3928-OUT;n:type:ShaderForge.SFN_ValueProperty,id:3928,x:31630,y:33730,ptovrint:False,ptlb:DisslovePower,ptin:_DisslovePower,varname:_DisslovePower,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Multiply,id:5526,x:33390,y:32792,varname:node_5526,prsc:2|A-8110-RGB,B-3596-OUT;n:type:ShaderForge.SFN_Tex2d,id:8110,x:33025,y:32540,ptovrint:False,ptlb:GamColor,ptin:_GamColor,varname:_GamColor,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Smoothstep,id:6276,x:32355,y:33625,varname:node_6276,prsc:2|A-6189-OUT,B-4798-OUT,V-6481-R;n:type:ShaderForge.SFN_ValueProperty,id:8360,x:31894,y:33774,ptovrint:False,ptlb:Smooth,ptin:_Smooth,varname:_Smooth,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Add,id:4798,x:32090,y:33646,varname:node_4798,prsc:2|A-6189-OUT,B-8360-OUT;n:type:ShaderForge.SFN_OneMinus,id:1519,x:31564,y:33564,varname:node_1519,prsc:2|IN-9115-U;n:type:ShaderForge.SFN_Tex2d,id:6095,x:33695,y:33666,varname:_VertexR,prsc:2,tex:ae5de4ee441e4224a976910c0243fcee,ntxv:0,isnm:False|UVIN-3423-OUT,TEX-7187-TEX;n:type:ShaderForge.SFN_Append,id:3423,x:33138,y:33650,varname:node_3423,prsc:2|A-5998-OUT,B-7035-OUT;n:type:ShaderForge.SFN_Add,id:5998,x:32707,y:33898,varname:node_5998,prsc:2|A-1669-OUT,B-1309-U;n:type:ShaderForge.SFN_Add,id:7035,x:32707,y:34130,varname:node_7035,prsc:2|A-1309-V,B-4322-OUT;n:type:ShaderForge.SFN_Multiply,id:4322,x:32457,y:34185,varname:node_4322,prsc:2|A-4829-T,B-9913-OUT;n:type:ShaderForge.SFN_Multiply,id:1669,x:32487,y:33898,varname:node_1669,prsc:2|A-626-OUT,B-4829-T;n:type:ShaderForge.SFN_Time,id:4829,x:32297,y:34024,varname:node_4829,prsc:2;n:type:ShaderForge.SFN_TexCoord,id:1309,x:32517,y:34024,varname:node_1309,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_ValueProperty,id:626,x:32297,y:33932,ptovrint:False,ptlb:VPan_U,ptin:_VPan_U,varname:_VPan_U,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:9913,x:32268,y:34219,ptovrint:False,ptlb:VPan_V,ptin:_VPan_V,varname:_VPan_V,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_SwitchProperty,id:5945,x:35465,y:33207,ptovrint:False,ptlb:VerTexOffest,ptin:_VerTexOffest,varname:_VerTexOffest,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-6660-OUT,B-4805-OUT;n:type:ShaderForge.SFN_Vector1,id:6660,x:35224,y:33207,varname:node_6660,prsc:2,v1:0;n:type:ShaderForge.SFN_Append,id:4580,x:31236,y:33246,varname:node_4580,prsc:2|A-9312-OUT,B-4070-OUT;n:type:ShaderForge.SFN_Add,id:9312,x:31011,y:33212,varname:node_9312,prsc:2|A-8987-OUT,B-6975-U;n:type:ShaderForge.SFN_Add,id:4070,x:31011,y:33409,varname:node_4070,prsc:2|A-6975-V,B-881-OUT;n:type:ShaderForge.SFN_Multiply,id:881,x:30839,y:33456,varname:node_881,prsc:2|A-8282-T,B-8795-OUT;n:type:ShaderForge.SFN_Multiply,id:8987,x:30827,y:33135,varname:node_8987,prsc:2|A-3788-OUT,B-8282-T;n:type:ShaderForge.SFN_TexCoord,id:6975,x:30806,y:33271,varname:node_6975,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Time,id:8282,x:30164,y:33367,varname:node_8282,prsc:2;n:type:ShaderForge.SFN_ValueProperty,id:3788,x:30477,y:33261,ptovrint:False,ptlb:Mask_U_Speed,ptin:_Mask_U_Speed,varname:_Mask_U_Speed,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:8795,x:30437,y:33476,ptovrint:False,ptlb:Mask_V_Speed,ptin:_Mask_V_Speed,varname:_Mask_V_Speed,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Append,id:3828,x:31690,y:34276,varname:node_3828,prsc:2|A-7184-OUT,B-6560-OUT;n:type:ShaderForge.SFN_Add,id:7184,x:31341,y:34204,varname:node_7184,prsc:2|A-5158-OUT,B-9717-U;n:type:ShaderForge.SFN_Add,id:6560,x:31341,y:34401,varname:node_6560,prsc:2|A-9717-V,B-5967-OUT;n:type:ShaderForge.SFN_Multiply,id:5967,x:31169,y:34448,varname:node_5967,prsc:2|A-1240-T,B-5487-OUT;n:type:ShaderForge.SFN_Multiply,id:5158,x:31157,y:34127,varname:node_5158,prsc:2|A-5827-OUT,B-1240-T;n:type:ShaderForge.SFN_TexCoord,id:9717,x:31136,y:34263,varname:node_9717,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Time,id:1240,x:30932,y:34344,varname:node_1240,prsc:2;n:type:ShaderForge.SFN_ValueProperty,id:5827,x:30879,y:34075,ptovrint:False,ptlb:DissU_Speed,ptin:_DissU_Speed,varname:_DissU_Speed,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:5487,x:30987,y:34540,ptovrint:False,ptlb:DissV_Speed,ptin:_DissV_Speed,varname:_DissV_Speed,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Append,id:4217,x:34788,y:33847,varname:node_4217,prsc:2|A-6214-OUT,B-1436-OUT,C-8002-OUT,D-7746-OUT;n:type:ShaderForge.SFN_Tex2d,id:3053,x:33698,y:33981,varname:_VertexT_G,prsc:2,tex:ae5de4ee441e4224a976910c0243fcee,ntxv:0,isnm:False|UVIN-2201-OUT,TEX-7187-TEX;n:type:ShaderForge.SFN_Multiply,id:8334,x:34221,y:33921,varname:node_8334,prsc:2|A-3051-OUT,B-9404-OUT;n:type:ShaderForge.SFN_Tex2d,id:9340,x:33674,y:34221,varname:_Vertex_B,prsc:2,tex:ae5de4ee441e4224a976910c0243fcee,ntxv:0,isnm:False|UVIN-6174-OUT,TEX-7187-TEX;n:type:ShaderForge.SFN_Vector1,id:7746,x:34571,y:34372,varname:node_7746,prsc:2,v1:0;n:type:ShaderForge.SFN_Tex2dAsset,id:7187,x:33331,y:34426,ptovrint:False,ptlb:NiuQuTieTu,ptin:_NiuQuTieTu,varname:node_7187,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:ae5de4ee441e4224a976910c0243fcee,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Add,id:1479,x:33133,y:33979,varname:node_1479,prsc:2|A-7035-OUT,B-9625-OUT;n:type:ShaderForge.SFN_Vector1,id:9625,x:33003,y:34068,varname:node_9625,prsc:2,v1:0.1;n:type:ShaderForge.SFN_Add,id:5640,x:33146,y:34252,varname:node_5640,prsc:2|A-7035-OUT,B-3496-OUT;n:type:ShaderForge.SFN_Vector1,id:3496,x:32980,y:34336,varname:node_3496,prsc:2,v1:0.05;n:type:ShaderForge.SFN_Append,id:2201,x:33327,y:33942,varname:node_2201,prsc:2|A-5998-OUT,B-1479-OUT;n:type:ShaderForge.SFN_Append,id:6174,x:33350,y:34225,varname:node_6174,prsc:2|A-5998-OUT,B-5640-OUT;n:type:ShaderForge.SFN_Multiply,id:4805,x:35246,y:33483,varname:node_4805,prsc:2|A-4217-OUT,B-7411-RGB,C-6239-XYZ;n:type:ShaderForge.SFN_Tex2d,id:7411,x:35053,y:34014,ptovrint:False,ptlb:VertexMask,ptin:_VertexMask,varname:node_7411,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Vector4Property,id:6239,x:34822,y:34071,ptovrint:False,ptlb:Drect,ptin:_Drect,varname:node_6239,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1,v2:1,v3:1,v4:0;n:type:ShaderForge.SFN_TexCoord,id:6972,x:30811,y:32537,varname:node_6972,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Add,id:2122,x:31016,y:32537,varname:node_2122,prsc:2|A-6972-U,B-7634-Z;n:type:ShaderForge.SFN_TexCoord,id:7634,x:30811,y:32706,varname:node_7634,prsc:2,uv:1,uaff:True;n:type:ShaderForge.SFN_Add,id:3062,x:31016,y:32716,varname:node_3062,prsc:2|A-6972-V,B-7634-W;n:type:ShaderForge.SFN_Append,id:1265,x:31219,y:32623,varname:node_1265,prsc:2|A-2122-OUT,B-3062-OUT;n:type:ShaderForge.SFN_Append,id:4333,x:31664,y:32173,varname:node_4333,prsc:2|A-2975-OUT,B-415-OUT;n:type:ShaderForge.SFN_Add,id:2975,x:31439,y:32139,varname:node_2975,prsc:2|A-6752-OUT,B-5772-U;n:type:ShaderForge.SFN_Add,id:415,x:31439,y:32336,varname:node_415,prsc:2|A-5772-V,B-4847-OUT;n:type:ShaderForge.SFN_Multiply,id:4847,x:31267,y:32383,varname:node_4847,prsc:2|A-6679-T,B-2267-OUT;n:type:ShaderForge.SFN_Multiply,id:6752,x:31255,y:32062,varname:node_6752,prsc:2|A-6494-OUT,B-6679-T;n:type:ShaderForge.SFN_TexCoord,id:5772,x:31267,y:32200,varname:node_5772,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_SwitchProperty,id:8267,x:31826,y:32396,ptovrint:False,ptlb:ONE UV,ptin:_ONEUV,varname:node_8267,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-4333-OUT,B-7167-OUT;n:type:ShaderForge.SFN_ValueProperty,id:6494,x:31034,y:32096,ptovrint:False,ptlb:U_Textures,ptin:_U_Textures,varname:node_6494,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:2267,x:31014,y:32338,ptovrint:False,ptlb:V_textures,ptin:_V_textures,varname:node_2267,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Time,id:6679,x:31014,y:32172,varname:node_6679,prsc:2;n:type:ShaderForge.SFN_SwitchProperty,id:7167,x:31651,y:32615,ptovrint:False,ptlb:ClampTex,ptin:_ClampTex,varname:node_7167,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-1265-OUT,B-3124-OUT;n:type:ShaderForge.SFN_Clamp01,id:3124,x:31420,y:32683,varname:node_3124,prsc:2|IN-1265-OUT;n:type:ShaderForge.SFN_Multiply,id:8180,x:34273,y:33680,varname:node_8180,prsc:2|A-448-OUT,B-3051-OUT;n:type:ShaderForge.SFN_Subtract,id:448,x:33993,y:33675,varname:node_448,prsc:2|A-6095-R,B-9518-OUT;n:type:ShaderForge.SFN_Subtract,id:9404,x:33993,y:33932,varname:node_9404,prsc:2|A-3053-R,B-9518-OUT;n:type:ShaderForge.SFN_Multiply,id:729,x:34262,y:34090,varname:node_729,prsc:2|A-1422-OUT,B-3051-OUT;n:type:ShaderForge.SFN_Subtract,id:1422,x:33993,y:34099,varname:node_1422,prsc:2|A-9340-R,B-9518-OUT;n:type:ShaderForge.SFN_Vector1,id:9518,x:33771,y:33918,varname:node_9518,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Vector1,id:3051,x:34084,y:33812,varname:node_3051,prsc:2,v1:2;n:type:ShaderForge.SFN_Multiply,id:6214,x:34550,y:33713,varname:node_6214,prsc:2|A-8180-OUT,B-1841-OUT;n:type:ShaderForge.SFN_Multiply,id:1436,x:34587,y:33890,varname:node_1436,prsc:2|A-8334-OUT,B-1841-OUT;n:type:ShaderForge.SFN_Multiply,id:8002,x:34531,y:34040,varname:node_8002,prsc:2|A-729-OUT,B-1841-OUT;n:type:ShaderForge.SFN_Subtract,id:5773,x:34288,y:34504,varname:node_5773,prsc:2|A-8262-R,B-9518-OUT;n:type:ShaderForge.SFN_Multiply,id:1841,x:34340,y:34287,varname:node_1841,prsc:2|A-3051-OUT,B-5773-OUT;proporder:8357-8267-7167-6494-2267-2211-1737-1876-1332-3788-8795-6481-7929-6189-5827-5487-8360-3928-8110-4681-7675-7187-5945-6239-626-9913-7411;pass:END;sub:END;*/

Shader "cokey/lightning/Add_Lightning" {
    Properties {
        _Textures ("Textures", 2D) = "white" {}
        [MaterialToggle] _ONEUV ("ONE UV", Float ) = 0
        [MaterialToggle] _ClampTex ("ClampTex", Float ) = 0
        _U_Textures ("U_Textures", Float ) = 0
        _V_textures ("V_textures", Float ) = 0
        [MaterialToggle] _TextureAlpha ("TextureAlpha", Float ) = 0
        [HDR]_Color ("Color", Color) = (0.5,0.5,0.5,1)
        _OpacityTextures ("Opacity Textures", 2D) = "white" {}
        [MaterialToggle] _MaskTex ("Mask Tex", Float ) = 1
        _Mask_U_Speed ("Mask_U_Speed", Float ) = 0
        _Mask_V_Speed ("Mask_V_Speed", Float ) = 0
        _Disslove ("Disslove", 2D) = "white" {}
        [MaterialToggle] _DissloveOff ("Disslove Off", Float ) = 1
        [MaterialToggle] _DissloveUVorPower ("Disslove UV or Power", Float ) = 1
        _DissU_Speed ("DissU_Speed", Float ) = 0
        _DissV_Speed ("DissV_Speed", Float ) = 0
        _Smooth ("Smooth", Float ) = 0
        _DisslovePower ("DisslovePower", Float ) = 0
        _GamColor ("GamColor", 2D) = "white" {}
        _UspeedNiuqu ("U speed Niuqu", Float ) = 0
        _VSpeedNiuqu ("V Speed Niuqu", Float ) = 0
        _NiuQuTieTu ("NiuQuTieTu", 2D) = "white" {}
        [MaterialToggle] _VerTexOffest ("VerTexOffest", Float ) = 0
        _Drect ("Drect", Vector) = (1,1,1,0)
        _VPan_U ("VPan_U", Float ) = 0
        _VPan_V ("VPan_V", Float ) = 0
        _VertexMask ("VertexMask", 2D) = "white" {}
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
            Blend One One
            Cull Off
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma target 3.0
            uniform sampler2D _Textures; uniform float4 _Textures_ST;
            uniform sampler2D _OpacityTextures; uniform float4 _OpacityTextures_ST;
            uniform sampler2D _Disslove; uniform float4 _Disslove_ST;
            uniform sampler2D _GamColor; uniform float4 _GamColor_ST;
            uniform sampler2D _NiuQuTieTu; uniform float4 _NiuQuTieTu_ST;
            uniform sampler2D _VertexMask; uniform float4 _VertexMask_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _Color)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _TextureAlpha)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _MaskTex)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _DissloveOff)
                UNITY_DEFINE_INSTANCED_PROP( float, _UspeedNiuqu)
                UNITY_DEFINE_INSTANCED_PROP( float, _VSpeedNiuqu)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _DissloveUVorPower)
                UNITY_DEFINE_INSTANCED_PROP( float, _DisslovePower)
                UNITY_DEFINE_INSTANCED_PROP( float, _Smooth)
                UNITY_DEFINE_INSTANCED_PROP( float, _VPan_U)
                UNITY_DEFINE_INSTANCED_PROP( float, _VPan_V)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _VerTexOffest)
                UNITY_DEFINE_INSTANCED_PROP( float, _Mask_U_Speed)
                UNITY_DEFINE_INSTANCED_PROP( float, _Mask_V_Speed)
                UNITY_DEFINE_INSTANCED_PROP( float, _DissU_Speed)
                UNITY_DEFINE_INSTANCED_PROP( float, _DissV_Speed)
                UNITY_DEFINE_INSTANCED_PROP( float4, _Drect)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _ONEUV)
                UNITY_DEFINE_INSTANCED_PROP( float, _U_Textures)
                UNITY_DEFINE_INSTANCED_PROP( float, _V_textures)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _ClampTex)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float4 texcoord1 : TEXCOORD1;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float2 uv0 : TEXCOORD0;
                float4 uv1 : TEXCOORD1;
                float4 vertexColor : COLOR;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.vertexColor = v.vertexColor;
                float _VPan_U_var = UNITY_ACCESS_INSTANCED_PROP( Props, _VPan_U );
                float4 node_4829 = _Time;
                float node_5998 = ((_VPan_U_var*node_4829.g)+o.uv0.r);
                float _VPan_V_var = UNITY_ACCESS_INSTANCED_PROP( Props, _VPan_V );
                float node_7035 = (o.uv0.g+(node_4829.g*_VPan_V_var));
                float2 node_3423 = float2(node_5998,node_7035);
                float4 _VertexR = tex2Dlod(_NiuQuTieTu,float4(TRANSFORM_TEX(node_3423, _NiuQuTieTu),0.0,0));
                float node_9518 = 0.5;
                float node_3051 = 2.0;
                float _UspeedNiuqu_var = UNITY_ACCESS_INSTANCED_PROP( Props, _UspeedNiuqu );
                float4 node_3347 = _Time;
                float _VSpeedNiuqu_var = UNITY_ACCESS_INSTANCED_PROP( Props, _VSpeedNiuqu );
                float2 node_5564 = float2(((_UspeedNiuqu_var*node_3347.g)+o.uv0.r),(o.uv0.g+(node_3347.g*_VSpeedNiuqu_var)));
                float4 _NiuQu = tex2Dlod(_NiuQuTieTu,float4(TRANSFORM_TEX(node_5564, _NiuQuTieTu),0.0,0));
                float node_1841 = (node_3051*(_NiuQu.r-node_9518));
                float2 node_2201 = float2(node_5998,(node_7035+0.1));
                float4 _VertexT_G = tex2Dlod(_NiuQuTieTu,float4(TRANSFORM_TEX(node_2201, _NiuQuTieTu),0.0,0));
                float2 node_6174 = float2(node_5998,(node_7035+0.05));
                float4 _Vertex_B = tex2Dlod(_NiuQuTieTu,float4(TRANSFORM_TEX(node_6174, _NiuQuTieTu),0.0,0));
                float4 _VertexMask_var = tex2Dlod(_VertexMask,float4(TRANSFORM_TEX(o.uv0, _VertexMask),0.0,0));
                float4 _Drect_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Drect );
                float4 _VerTexOffest_var = lerp( 0.0, (float4((((_VertexR.r-node_9518)*node_3051)*node_1841),((node_3051*(_VertexT_G.r-node_9518))*node_1841),(((_Vertex_B.r-node_9518)*node_3051)*node_1841),0.0)*_VertexMask_var.rgb*_Drect_var.rgb), UNITY_ACCESS_INSTANCED_PROP( Props, _VerTexOffest ) );
                v.vertex.xyz += _VerTexOffest_var.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
////// Lighting:
////// Emissive:
                float4 _GamColor_var = tex2D(_GamColor,TRANSFORM_TEX(i.uv0, _GamColor));
                float4 _Color_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Color );
                float _U_Textures_var = UNITY_ACCESS_INSTANCED_PROP( Props, _U_Textures );
                float4 node_6679 = _Time;
                float _V_textures_var = UNITY_ACCESS_INSTANCED_PROP( Props, _V_textures );
                float2 node_1265 = float2((i.uv0.r+i.uv1.b),(i.uv0.g+i.uv1.a));
                float2 _ClampTex_var = lerp( node_1265, saturate(node_1265), UNITY_ACCESS_INSTANCED_PROP( Props, _ClampTex ) );
                float2 _ONEUV_var = lerp( float2(((_U_Textures_var*node_6679.g)+i.uv0.r),(i.uv0.g+(node_6679.g*_V_textures_var))), _ClampTex_var, UNITY_ACCESS_INSTANCED_PROP( Props, _ONEUV ) );
                float4 _Textures_var = tex2D(_Textures,TRANSFORM_TEX(_ONEUV_var, _Textures));
                float _TextureAlpha_var = lerp( _Textures_var.r, _Textures_var.a, UNITY_ACCESS_INSTANCED_PROP( Props, _TextureAlpha ) );
                float _Mask_U_Speed_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Mask_U_Speed );
                float4 node_8282 = _Time;
                float _Mask_V_Speed_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Mask_V_Speed );
                float2 node_4580 = float2(((_Mask_U_Speed_var*node_8282.g)+i.uv0.r),(i.uv0.g+(node_8282.g*_Mask_V_Speed_var)));
                float4 _OpacityTextures_var = tex2D(_OpacityTextures,TRANSFORM_TEX(node_4580, _OpacityTextures));
                float _MaskTex_var = lerp( 1.0, _OpacityTextures_var.r, UNITY_ACCESS_INSTANCED_PROP( Props, _MaskTex ) );
                float _DisslovePower_var = UNITY_ACCESS_INSTANCED_PROP( Props, _DisslovePower );
                float _DissloveUVorPower_var = lerp( (1.0 - i.uv1.r), _DisslovePower_var, UNITY_ACCESS_INSTANCED_PROP( Props, _DissloveUVorPower ) );
                float _Smooth_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Smooth );
                float _DissU_Speed_var = UNITY_ACCESS_INSTANCED_PROP( Props, _DissU_Speed );
                float4 node_1240 = _Time;
                float _DissV_Speed_var = UNITY_ACCESS_INSTANCED_PROP( Props, _DissV_Speed );
                float2 node_3828 = float2(((_DissU_Speed_var*node_1240.g)+i.uv0.r),(i.uv0.g+(node_1240.g*_DissV_Speed_var)));
                float4 _Disslove_var = tex2D(_Disslove,TRANSFORM_TEX(node_3828, _Disslove));
                float _DissloveOff_var = lerp( 1.0, smoothstep( _DissloveUVorPower_var, (_DissloveUVorPower_var+_Smooth_var), _Disslove_var.r ), UNITY_ACCESS_INSTANCED_PROP( Props, _DissloveOff ) );
                float3 emissive = (_GamColor_var.rgb*((_Color_var.rgb*_Textures_var.rgb*(_TextureAlpha_var*_MaskTex_var)*i.vertexColor.rgb*i.vertexColor.a)*_DissloveOff_var));
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
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
            #pragma target 3.0
            uniform sampler2D _NiuQuTieTu; uniform float4 _NiuQuTieTu_ST;
            uniform sampler2D _VertexMask; uniform float4 _VertexMask_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _UspeedNiuqu)
                UNITY_DEFINE_INSTANCED_PROP( float, _VSpeedNiuqu)
                UNITY_DEFINE_INSTANCED_PROP( float, _VPan_U)
                UNITY_DEFINE_INSTANCED_PROP( float, _VPan_V)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _VerTexOffest)
                UNITY_DEFINE_INSTANCED_PROP( float4, _Drect)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float2 uv0 : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
                float _VPan_U_var = UNITY_ACCESS_INSTANCED_PROP( Props, _VPan_U );
                float4 node_4829 = _Time;
                float node_5998 = ((_VPan_U_var*node_4829.g)+o.uv0.r);
                float _VPan_V_var = UNITY_ACCESS_INSTANCED_PROP( Props, _VPan_V );
                float node_7035 = (o.uv0.g+(node_4829.g*_VPan_V_var));
                float2 node_3423 = float2(node_5998,node_7035);
                float4 _VertexR = tex2Dlod(_NiuQuTieTu,float4(TRANSFORM_TEX(node_3423, _NiuQuTieTu),0.0,0));
                float node_9518 = 0.5;
                float node_3051 = 2.0;
                float _UspeedNiuqu_var = UNITY_ACCESS_INSTANCED_PROP( Props, _UspeedNiuqu );
                float4 node_3347 = _Time;
                float _VSpeedNiuqu_var = UNITY_ACCESS_INSTANCED_PROP( Props, _VSpeedNiuqu );
                float2 node_5564 = float2(((_UspeedNiuqu_var*node_3347.g)+o.uv0.r),(o.uv0.g+(node_3347.g*_VSpeedNiuqu_var)));
                float4 _NiuQu = tex2Dlod(_NiuQuTieTu,float4(TRANSFORM_TEX(node_5564, _NiuQuTieTu),0.0,0));
                float node_1841 = (node_3051*(_NiuQu.r-node_9518));
                float2 node_2201 = float2(node_5998,(node_7035+0.1));
                float4 _VertexT_G = tex2Dlod(_NiuQuTieTu,float4(TRANSFORM_TEX(node_2201, _NiuQuTieTu),0.0,0));
                float2 node_6174 = float2(node_5998,(node_7035+0.05));
                float4 _Vertex_B = tex2Dlod(_NiuQuTieTu,float4(TRANSFORM_TEX(node_6174, _NiuQuTieTu),0.0,0));
                float4 _VertexMask_var = tex2Dlod(_VertexMask,float4(TRANSFORM_TEX(o.uv0, _VertexMask),0.0,0));
                float4 _Drect_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Drect );
                float4 _VerTexOffest_var = lerp( 0.0, (float4((((_VertexR.r-node_9518)*node_3051)*node_1841),((node_3051*(_VertexT_G.r-node_9518))*node_1841),(((_Vertex_B.r-node_9518)*node_3051)*node_1841),0.0)*_VertexMask_var.rgb*_Drect_var.rgb), UNITY_ACCESS_INSTANCED_PROP( Props, _VerTexOffest ) );
                v.vertex.xyz += _VerTexOffest_var.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
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
