// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Agua"
{
	Properties
	{
		_W_Speed("W_Speed", Range( 0 , 0.5)) = 0.5
		_WaveDirection("Wave Direction", Vector) = (-1,0,0,0)
		_WaveTile("Wave Tile", Range( 0.1 , 1)) = 1
		_WaveHeight("Wave Height", Range( 0.1 , 0.5)) = 0.5
		_NormalMap("NormalMap", 2D) = "white" {}
		_WaterColour("Water Colour", Color) = (0.2006942,0.6344855,0.7735849,0)
		_TopColour("Top Colour", Color) = (0.1921568,0.7105235,0.7450981,1)
		_EdgeDistance("Edge Distance", Range( 0 , 1)) = 1
		_BIas("BIas", Range( 0 , 2)) = 0
		_Scale("Scale", Range( 0 , 2)) = 0
		_Power("Power", Range( 0 , 8)) = 0
		_RefNormalMap("RefNormalMap", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Back
		GrabPass{ }
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#include "UnityCG.cginc"
		#include "Tessellation.cginc"
		#pragma target 4.6
		#if defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_STEREO_MULTIVIEW_ENABLED)
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex);
		#else
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex)
		#endif
		#pragma surface surf Standard alpha:fade keepalpha noshadow vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float3 worldPos;
			float4 screenPos;
			float2 uv_texcoord;
		};

		uniform float _WaveHeight;
		uniform float _W_Speed;
		uniform float2 _WaveDirection;
		uniform float _WaveTile;
		ASE_DECLARE_SCREENSPACE_TEXTURE( _GrabTexture )
		uniform sampler2D _RefNormalMap;
		uniform float4 _RefNormalMap_ST;
		uniform sampler2D _NormalMap;
		uniform float4 _NormalMap_ST;
		uniform float4 _WaterColour;
		uniform float4 _TopColour;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _EdgeDistance;
		uniform float _BIas;
		uniform float _Scale;
		uniform float _Power;


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


		inline float4 ASE_ComputeGrabScreenPos( float4 pos )
		{
			#if UNITY_UV_STARTS_AT_TOP
			float scale = -1.0;
			#else
			float scale = 1.0;
			#endif
			float4 o = pos;
			o.y = pos.w * 0.5f;
			o.y = ( pos.y - o.y ) * _ProjectionParams.x * scale + o.y;
			return o;
		}


		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			float4 temp_cast_3 = (8.0).xxxx;
			return temp_cast_3;
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float temp_output_216_0 = ( _Time.y * _W_Speed );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float4 appendResult219 = (float4(ase_worldPos.x , ase_worldPos.z , 0.0 , 0.0));
			float4 WorldSpaceTile220 = appendResult219;
			float4 WaveTileUV231 = ( ( WorldSpaceTile220 * float4( float2( 0.15,0.02 ), 0.0 , 0.0 ) ) * _WaveTile );
			float2 panner213 = ( temp_output_216_0 * _WaveDirection + WaveTileUV231.xy);
			float simplePerlin2D211 = snoise( panner213 );
			float2 panner234 = ( temp_output_216_0 * _WaveDirection + ( WaveTileUV231 * float4( 0.1,0.1,0,0 ) ).xy);
			float simplePerlin2D233 = snoise( panner234 );
			float temp_output_236_0 = ( simplePerlin2D211 + simplePerlin2D233 );
			float3 WaveHeight243 = ( ( float3(0,1,0) * _WaveHeight ) * temp_output_236_0 );
			v.vertex.xyz += WaveHeight243;
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			float4 ase_grabScreenPosNorm = ase_grabScreenPos / ase_grabScreenPos.w;
			float2 appendResult280 = (float2(ase_grabScreenPosNorm.r , ase_grabScreenPosNorm.g));
			float2 uv_RefNormalMap = i.uv_texcoord * _RefNormalMap_ST.xy + _RefNormalMap_ST.zw;
			float4 screenColor284 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,( float3( appendResult280 ,  0.0 ) + UnpackScaleNormal( tex2D( _RefNormalMap, uv_RefNormalMap ), 1.0 ) ).xy);
			float4 Distortion285 = screenColor284;
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			o.Normal = ( Distortion285 * float4( UnpackNormal( tex2D( _NormalMap, uv_NormalMap ) ) , 0.0 ) ).rgb;
			float temp_output_216_0 = ( _Time.y * _W_Speed );
			float3 ase_worldPos = i.worldPos;
			float4 appendResult219 = (float4(ase_worldPos.x , ase_worldPos.z , 0.0 , 0.0));
			float4 WorldSpaceTile220 = appendResult219;
			float4 WaveTileUV231 = ( ( WorldSpaceTile220 * float4( float2( 0.15,0.02 ), 0.0 , 0.0 ) ) * _WaveTile );
			float2 panner213 = ( temp_output_216_0 * _WaveDirection + WaveTileUV231.xy);
			float simplePerlin2D211 = snoise( panner213 );
			float2 panner234 = ( temp_output_216_0 * _WaveDirection + ( WaveTileUV231 * float4( 0.1,0.1,0,0 ) ).xy);
			float simplePerlin2D233 = snoise( panner234 );
			float temp_output_236_0 = ( simplePerlin2D211 + simplePerlin2D233 );
			float WavePattern240 = temp_output_236_0;
			float clampResult255 = clamp( WavePattern240 , 0.0 , 1.0 );
			float4 lerpResult253 = lerp( _WaterColour , _TopColour , clampResult255);
			float4 Albedo256 = lerpResult253;
			float4 screenColor302 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,( float4( (ase_grabScreenPosNorm).xy, 0.0 , 0.0 ) + ( 0.0 * Distortion285 ) ).rg);
			float4 clampResult303 = clamp( screenColor302 , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
			float4 Refraction304 = clampResult303;
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth259 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth259 = abs( ( screenDepth259 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _EdgeDistance ) );
			float DepthFade274 = ( 1.0 - saturate( pow( ( ( distanceDepth259 + _BIas ) * _Scale ) , _Power ) ) );
			float4 lerpResult311 = lerp( Albedo256 , Refraction304 , DepthFade274);
			o.Albedo = lerpResult311.rgb;
			o.Smoothness = 0.9;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
124;255;1352;628;1662.658;-2475.201;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;221;-2727.989,2604.514;Inherit;False;660.4336;233.0002;World Space UVs;3;218;219;220;UVs;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldPosInputsNode;218;-2677.988,2654.513;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;219;-2459.588,2654.513;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;220;-2296.554,2659.18;Inherit;False;WorldSpaceTile;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CommentaryNode;245;-1939.118,2480.694;Inherit;False;1870.53;505.0205;Comment;11;229;241;230;242;243;224;222;227;223;226;231;UV y Height;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;222;-1887.568,2628.866;Inherit;False;220;WorldSpaceTile;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.Vector2Node;224;-1889.118,2762.672;Inherit;False;Constant;_WaveStretch;Wave Stretch;17;0;Create;True;0;0;0;False;0;False;0.15,0.02;0.23,0.01;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;223;-1595.119,2658.672;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;227;-1578.119,2832.672;Inherit;False;Property;_WaveTile;Wave Tile;2;0;Create;True;0;0;0;False;0;False;1;0;0.1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;226;-1384.118,2713.672;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CommentaryNode;314;-1927.183,3960.366;Inherit;False;1185.573;499.0388;Comment;7;283;279;280;282;281;284;285;Distorsión;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;283;-1877.183,4306.01;Inherit;False;Constant;_NormalScale;Normal Scale;11;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GrabScreenPosition;279;-1844.457,4010.366;Inherit;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;246;-1905.442,3151.058;Inherit;False;1484.594;662.3958;Comment;13;217;215;238;239;216;214;234;213;233;236;240;211;232;Pattern;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;231;-1204.32,2660.843;Inherit;False;WaveTileUV;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;280;-1612.836,4031.199;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;217;-1871.442,3662.315;Inherit;False;Property;_W_Speed;W_Speed;0;0;Create;True;0;0;0;False;0;False;0.5;0;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;282;-1659.405,4229.405;Inherit;True;Property;_RefNormalMap;RefNormalMap;14;0;Create;True;0;0;0;False;0;False;248;None;None;True;0;False;white;Auto;True;Instance;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;238;-1578.671,3678.015;Inherit;False;231;WaveTileUV;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleTimeNode;215;-1855.442,3546.315;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;216;-1626.442,3482.315;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;239;-1345.576,3676.454;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0.1,0.1,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.Vector2Node;214;-1625.185,3325.993;Inherit;False;Property;_WaveDirection;Wave Direction;1;0;Create;True;0;0;0;False;0;False;-1,0;-1,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.CommentaryNode;312;-2284.05,1975.17;Inherit;False;1676.737;342.9178;Comment;11;260;259;268;270;267;269;272;271;292;261;274;Edge;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;281;-1410.628,4044.679;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;232;-1673.645,3211.456;Inherit;False;231;WaveTileUV;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ScreenColorNode;284;-1223.586,4071.673;Inherit;False;Global;_GrabScreen0;Grab Screen 0;16;0;Create;True;0;0;0;False;0;False;Object;-1;False;False;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;234;-1265.816,3457.594;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;213;-1316.185,3243.745;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;260;-2260.172,2156.882;Inherit;False;Property;_EdgeDistance;Edge Distance;7;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;259;-2018.178,2025.842;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;233;-1056.914,3442.87;Inherit;True;Simplex2D;False;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;313;-2215.616,1187.938;Inherit;False;1397.822;537.54;Comment;9;296;300;301;299;297;298;302;303;304;Refracción;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;285;-965.6102,4098.468;Inherit;False;Distortion;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;211;-1063.514,3201.058;Inherit;True;Simplex2D;False;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;268;-2016.62,2232.306;Inherit;False;Property;_BIas;BIas;8;0;Create;True;0;0;0;False;0;False;0;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;301;-2013.946,1609.478;Inherit;False;285;Distortion;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GrabScreenPosition;296;-2165.615,1237.937;Inherit;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;236;-815.4755,3288.09;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;267;-1733.075,2027.728;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;270;-1720.548,2213.206;Inherit;False;Property;_Scale;Scale;9;0;Create;True;0;0;0;False;0;False;0;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;300;-2007.609,1485.317;Inherit;False;Constant;_RefractionAmount;Refraction Amount;11;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;269;-1534.877,2025.17;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;272;-1434.829,2202.088;Inherit;False;Property;_Power;Power;10;0;Create;True;0;0;0;False;0;False;0;0;0;8;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;258;-505.5445,1667.884;Inherit;False;859.9768;576.5291;Comment;6;254;250;249;255;253;256;Albedo;1,1,1,1;0;0
Node;AmplifyShaderEditor.ComponentMaskNode;297;-1902.61,1261.316;Inherit;True;True;True;False;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;240;-644.8486,3324.188;Inherit;False;WavePattern;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;299;-1744.61,1511.317;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;271;-1367.605,2036.711;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;254;-455.5446,2128.413;Inherit;False;240;WavePattern;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;298;-1594.611,1314.316;Inherit;False;2;2;0;FLOAT2;0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ScreenColorNode;302;-1412.775,1339.208;Inherit;False;Global;_GrabScreen1;Grab Screen 1;15;0;Create;True;0;0;0;False;0;False;Object;-1;False;False;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;250;-431.0795,1923.545;Inherit;False;Property;_TopColour;Top Colour;6;0;Create;True;0;0;0;False;0;False;0.1921568,0.7105235,0.7450981,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;249;-442.3341,1717.884;Inherit;False;Property;_WaterColour;Water Colour;5;0;Create;True;0;0;0;False;0;False;0.2006942,0.6344855,0.7735849,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;229;-927.5098,2529.694;Inherit;False;Constant;_WaveUp;Wave Up;11;0;Create;True;0;0;0;False;0;False;0,1,0;0,1,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SaturateNode;292;-1209.7,2084.839;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;241;-920.0612,2749.774;Inherit;False;Property;_WaveHeight;Wave Height;3;0;Create;True;0;0;0;False;0;False;0.5;0;0.1;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;255;-186.5876,2047.967;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;253;-97.4765,1858.838;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;230;-711.8595,2657.222;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ClampOpNode;303;-1218.551,1351.541;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;261;-1047.953,2060.14;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;274;-831.3135,2072.034;Inherit;False;DepthFade;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;304;-1041.796,1380.313;Inherit;False;Refraction;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;256;130.4322,1887.359;Inherit;False;Albedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;242;-484.37,2850.715;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;294;856.6108,2516.304;Inherit;False;285;Distortion;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;305;758.0925,2358.236;Inherit;False;304;Refraction;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;275;489.4745,2456.156;Inherit;False;274;DepthFade;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;248;687.2498,2596.013;Inherit;True;Property;_NormalMap;NormalMap;4;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;257;756.176,2265.638;Inherit;False;256;Albedo;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;243;-292.5886,2866.432;Inherit;False;WaveHeight;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;228;1000.482,2947.344;Inherit;False;Constant;_Tessellation;Tessellation;3;0;Create;True;0;0;0;False;0;False;8;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;295;1027.106,2598.807;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;311;1014.238,2369.337;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;247;950.8996,2783.747;Inherit;False;Constant;_Smoothness;Smoothness;4;0;Create;True;0;0;0;False;0;False;0.9;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;244;931.4125,2867.988;Inherit;False;243;WaveHeight;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;290;1193.066,2480.968;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;Agua;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;219;0;218;1
WireConnection;219;1;218;3
WireConnection;220;0;219;0
WireConnection;223;0;222;0
WireConnection;223;1;224;0
WireConnection;226;0;223;0
WireConnection;226;1;227;0
WireConnection;231;0;226;0
WireConnection;280;0;279;1
WireConnection;280;1;279;2
WireConnection;282;5;283;0
WireConnection;216;0;215;0
WireConnection;216;1;217;0
WireConnection;239;0;238;0
WireConnection;281;0;280;0
WireConnection;281;1;282;0
WireConnection;284;0;281;0
WireConnection;234;0;239;0
WireConnection;234;2;214;0
WireConnection;234;1;216;0
WireConnection;213;0;232;0
WireConnection;213;2;214;0
WireConnection;213;1;216;0
WireConnection;259;0;260;0
WireConnection;233;0;234;0
WireConnection;285;0;284;0
WireConnection;211;0;213;0
WireConnection;236;0;211;0
WireConnection;236;1;233;0
WireConnection;267;0;259;0
WireConnection;267;1;268;0
WireConnection;269;0;267;0
WireConnection;269;1;270;0
WireConnection;297;0;296;0
WireConnection;240;0;236;0
WireConnection;299;0;300;0
WireConnection;299;1;301;0
WireConnection;271;0;269;0
WireConnection;271;1;272;0
WireConnection;298;0;297;0
WireConnection;298;1;299;0
WireConnection;302;0;298;0
WireConnection;292;0;271;0
WireConnection;255;0;254;0
WireConnection;253;0;249;0
WireConnection;253;1;250;0
WireConnection;253;2;255;0
WireConnection;230;0;229;0
WireConnection;230;1;241;0
WireConnection;303;0;302;0
WireConnection;261;0;292;0
WireConnection;274;0;261;0
WireConnection;304;0;303;0
WireConnection;256;0;253;0
WireConnection;242;0;230;0
WireConnection;242;1;236;0
WireConnection;243;0;242;0
WireConnection;295;0;294;0
WireConnection;295;1;248;0
WireConnection;311;0;257;0
WireConnection;311;1;305;0
WireConnection;311;2;275;0
WireConnection;290;0;311;0
WireConnection;290;1;295;0
WireConnection;290;4;247;0
WireConnection;290;11;244;0
WireConnection;290;14;228;0
ASEEND*/
//CHKSM=8795100FAEE93374CB6005B4835B5C0741018048