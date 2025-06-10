// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Vignette"
{
	Properties
	{
		_MainTex ( "Screen", 2D ) = "black" {}
		_SightWidth("SightWidth", Range( 0 , 2)) = 0.8613273
		_BlinkBase("Blink Base", Float) = 24
		_BlinkHeight("BlinkHeight", Range( 0 , 1)) = 0
		_Brightness("Brightness", Range( 0 , 5)) = 5
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

	}

	SubShader
	{
		LOD 0

		
		
		ZTest Always
		Cull Off
		ZWrite Off

		
		Pass
		{ 
			CGPROGRAM 

			

			#pragma vertex vert_img_custom 
			#pragma fragment frag
			#pragma target 3.0
			#include "UnityCG.cginc"
			

			struct appdata_img_custom
			{
				float4 vertex : POSITION;
				half2 texcoord : TEXCOORD0;
				
			};

			struct v2f_img_custom
			{
				float4 pos : SV_POSITION;
				half2 uv   : TEXCOORD0;
				half2 stereoUV : TEXCOORD2;
		#if UNITY_UV_STARTS_AT_TOP
				half4 uv2 : TEXCOORD1;
				half4 stereoUV2 : TEXCOORD3;
		#endif
				
			};

			uniform sampler2D _MainTex;
			uniform half4 _MainTex_TexelSize;
			uniform half4 _MainTex_ST;
			
			uniform float _SightWidth;
			uniform float _BlinkBase;
			uniform float _BlinkHeight;
			uniform float _Brightness;


			v2f_img_custom vert_img_custom ( appdata_img_custom v  )
			{
				v2f_img_custom o;
				
				o.pos = UnityObjectToClipPos( v.vertex );
				o.uv = float4( v.texcoord.xy, 1, 1 );

				#if UNITY_UV_STARTS_AT_TOP
					o.uv2 = float4( v.texcoord.xy, 1, 1 );
					o.stereoUV2 = UnityStereoScreenSpaceUVAdjust ( o.uv2, _MainTex_ST );

					if ( _MainTex_TexelSize.y < 0.0 )
						o.uv.y = 1.0 - o.uv.y;
				#endif
				o.stereoUV = UnityStereoScreenSpaceUVAdjust ( o.uv, _MainTex_ST );
				return o;
			}

			half4 frag ( v2f_img_custom i ) : SV_Target
			{
				#ifdef UNITY_UV_STARTS_AT_TOP
					half2 uv = i.uv2;
					half2 stereoUV = i.stereoUV2;
				#else
					half2 uv = i.uv;
					half2 stereoUV = i.stereoUV;
				#endif	
				
				half4 finalColor;

				// ase common template code
				float2 uv_MainTex = i.uv.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 appendResult81 = (float2(0.5 , 0.5));
				float2 VignettePosition84 = ( i.uv.xy - appendResult81 );
				float SitghtWidth87 = ( 2.0 / _SightWidth );
				float2 break58 = ( VignettePosition84 * SitghtWidth87 );
				float BlinkHeight89 = pow( _BlinkBase , _BlinkHeight );
				float2 appendResult54 = (float2(break58.x , ( break58.y * BlinkHeight89 )));
				float VignetteAndBlink92 = ( 1.0 - length( appendResult54 ) );
				float4 VignetteBrightnessAndScreen95 = ( tex2D( _MainTex, uv_MainTex ) * VignetteAndBlink92 * _Brightness );
				

				finalColor = VignetteBrightnessAndScreen95;

				return finalColor;
			} 
			ENDCG 
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18900
479;585;950;414;1899.052;-48.65028;1;False;False
Node;AmplifyShaderEditor.CommentaryNode;83;-1866.047,-743.9674;Inherit;False;1101.154;343.2443;Position;6;84;80;79;43;42;81;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;86;-1607.765,-302.7407;Inherit;False;753.6233;270.9449;Sight Width;4;46;48;47;87;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;80;-1816.047,-516.1831;Inherit;False;Constant;_PositionY;Position Y;0;0;Create;True;0;0;0;False;0;False;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;79;-1813.836,-600.4003;Inherit;False;Constant;_PositionX;Position X;0;0;Create;True;0;0;0;False;0;False;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;47;-1445.765,-252.7407;Inherit;False;Constant;_Constant2;Constant 2;0;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-1557.765,-158.7408;Inherit;False;Property;_SightWidth;SightWidth;0;0;Create;True;0;0;0;False;0;False;0.8613273;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;42;-1405.987,-693.9674;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;81;-1511.963,-570.9722;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;43;-1146.308,-640.4708;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;46;-1219.765,-244.7407;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;90;-1656.562,24.2978;Inherit;False;766.1174;260.1598;Blink Height;4;53;52;51;89;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;84;-982.9109,-643.6631;Inherit;False;VignettePosition;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;93;-2274.313,386.9682;Inherit;False;1715.241;426.875;Vignette And Blink;10;88;85;45;58;91;50;54;55;59;92;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;53;-1606.562,169.2976;Inherit;False;Property;_BlinkHeight;BlinkHeight;2;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;87;-1075.875,-250.0388;Inherit;False;SitghtWidth;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;52;-1481.563,74.29776;Inherit;False;Property;_BlinkBase;Blink Base;1;0;Create;True;0;0;0;False;0;False;24;24;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;85;-2224.313,436.9683;Inherit;False;84;VignettePosition;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PowerNode;51;-1312.563,110.2976;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;88;-2196.274,538.1352;Inherit;False;87;SitghtWidth;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;-1977.055,494.0081;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;89;-1129.845,105.6073;Inherit;False;BlinkHeight;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;91;-1877.847,635.1065;Inherit;False;89;BlinkHeight;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;58;-1819.023,503.3766;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;50;-1605.325,588.4492;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;54;-1420.964,513.0536;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LengthOpNode;55;-1239.956,522.1541;Inherit;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;96;-1795.721,957.8261;Inherit;False;1108.892;493.0613;Brightness And Screen;6;60;94;82;61;78;95;;1,1,1,1;0;0
Node;AmplifyShaderEditor.OneMinusNode;59;-1040.855,560.6832;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;78;-1745.721,1013.252;Inherit;False;0;0;_MainTex;Shader;False;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;92;-809.552,555.0355;Inherit;False;VignetteAndBlink;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;61;-1585.398,1007.826;Inherit;True;Property;_TextureSample0;Texture Sample 0;3;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;94;-1515.541,1216.711;Inherit;False;92;VignetteAndBlink;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;82;-1565.104,1310.093;Inherit;False;Property;_Brightness;Brightness;3;0;Create;True;0;0;0;False;0;False;5;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;60;-1254.003,1197.728;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;95;-1012.709,1193.61;Inherit;False;VignetteBrightnessAndScreen;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;97;-449.7365,-3.923553;Inherit;False;95;VignetteBrightnessAndScreen;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;16;-135.6359,1.440399;Float;False;True;-1;2;ASEMaterialInspector;0;2;Vignette;c71b220b631b6344493ea3cf87110c93;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;True;7;False;-1;False;True;0;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;;False;0
WireConnection;81;0;79;0
WireConnection;81;1;80;0
WireConnection;43;0;42;0
WireConnection;43;1;81;0
WireConnection;46;0;47;0
WireConnection;46;1;48;0
WireConnection;84;0;43;0
WireConnection;87;0;46;0
WireConnection;51;0;52;0
WireConnection;51;1;53;0
WireConnection;45;0;85;0
WireConnection;45;1;88;0
WireConnection;89;0;51;0
WireConnection;58;0;45;0
WireConnection;50;0;58;1
WireConnection;50;1;91;0
WireConnection;54;0;58;0
WireConnection;54;1;50;0
WireConnection;55;0;54;0
WireConnection;59;0;55;0
WireConnection;92;0;59;0
WireConnection;61;0;78;0
WireConnection;60;0;61;0
WireConnection;60;1;94;0
WireConnection;60;2;82;0
WireConnection;95;0;60;0
WireConnection;16;0;97;0
ASEEND*/
//CHKSM=DC5D9B489ADB74C9EDA5E0AF4B9270B3D3FC97EE