// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Shader2"
{
	Properties
	{
		_Effect("Effect", 2D) = "white" {}
		_SpeedPanner("Speed Panner", Vector) = (1,1,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Effect;
		uniform float2 _SpeedPanner;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 color58 = IsGammaSpace() ? float4(0,0,1,0) : float4(0,0,1,0);
			float4 color61 = IsGammaSpace() ? float4(0,1,0,0) : float4(0,1,0,0);
			float2 uv_TexCoord41 = i.uv_texcoord * float2( 3,3 );
			float2 panner42 = ( _Time.y * _SpeedPanner + uv_TexCoord41);
			float3 tex2DNode46 = UnpackScaleNormal( tex2D( _Effect, panner42 ), 2.0 );
			float4 lerpResult57 = lerp( color58 , color61 , float4( tex2DNode46 , 0.0 ));
			o.Emission = lerpResult57.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
124.8;73.6;1091.6;504.6;724.2366;152.9766;1.838175;False;False
Node;AmplifyShaderEditor.Vector2Node;47;-1108.121,139.6604;Inherit;False;Constant;_Vector1;Vector 1;1;0;Create;True;0;0;0;False;0;False;3,3;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleTimeNode;45;-750.48,538.7004;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;41;-826.4002,185.1004;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;43;-741.1202,383.7404;Inherit;False;Property;_SpeedPanner;Speed Panner;1;0;Create;True;0;0;0;False;0;False;1,1;0.5,1.5;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TexturePropertyNode;56;-509.8771,477.7156;Inherit;True;Property;_Effect;Effect;0;0;Create;True;0;0;0;False;0;False;67ddd511a4ddb1f46ba6d16f1bdb7acd;67ddd511a4ddb1f46ba6d16f1bdb7acd;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.PannerNode;42;-518.5603,300.5404;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;61;-190.6117,-78.6608;Inherit;False;Constant;_Color1;Color 1;3;0;Create;True;0;0;0;False;0;False;0,1,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;58;-217.8976,184.3154;Inherit;False;Constant;_Color0;Color 0;3;0;Create;True;0;0;0;False;0;False;0,0,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;46;-205.7804,430.5405;Inherit;True;Property;_EFECTO;EFECTO;0;0;Create;True;0;0;0;False;0;False;-1;67ddd511a4ddb1f46ba6d16f1bdb7acd;67ddd511a4ddb1f46ba6d16f1bdb7acd;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;2;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;75;56.22057,1200.846;Inherit;False;Constant;_Color2;Color 2;5;0;Create;True;0;0;0;False;0;False;1,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PosVertexDataNode;66;-93.41162,689.4617;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;90;319.0875,1590.795;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;81;-531.154,1038.661;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;72;-231.8055,1007.727;Inherit;True;Property;_TextureSample0;Texture Sample 0;5;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;73;90.56519,1010.314;Inherit;False;True;True;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;82;591.9856,1018.941;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;74;385.5652,1021.314;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;68;231.34,696.2025;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;69;-248.8745,853.9547;Inherit;False;Property;_VertexPos;VertexPos;4;0;Create;True;0;0;0;False;0;False;1;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;77;371.82,1183.539;Inherit;False;Constant;_Float0;Float 0;5;0;Create;True;0;0;0;False;0;False;10;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;55;-953.9567,-144.4046;Inherit;True;Property;_Texture;Texture;3;0;Create;True;0;0;0;False;0;False;8c4a7fca2884fab419769ccc0355c0c1;af5ab63a69b074347be0e4c17fb9dc1b;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SamplerNode;53;-682.5994,-127.0598;Inherit;True;Property;_MID;MID;1;0;Create;True;0;0;0;False;0;False;-1;None;826f80ee0ad07444c8558af826a4df2e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;80;-812.8748,993.2209;Inherit;False;Constant;_Vector2;Vector 1;1;0;Create;True;0;0;0;False;0;False;3,3;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.LerpOp;83;538.3543,558.7722;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;70;336.1536,557.5453;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;57;219.261,28.3858;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;88;-59.26959,1648.239;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;89;-301.2696,1873.239;Inherit;False;Constant;_Float1;Float 1;6;0;Create;True;0;0;0;False;0;False;0.3026927;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;87;-479.1106,1576.269;Inherit;True;Property;_TextureSample1;Texture Sample 1;6;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;85;-846.1106,1536.269;Inherit;True;Property;_Texture0;Texture 0;5;0;Create;True;0;0;0;False;0;False;None;0bf07e292ca3527499ac978f7e05ca1b;True;bump;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleTimeNode;67;132.7129,852.5328;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;530.9565,-78.7542;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Shader2;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Transparent;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;2;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;41;0;47;0
WireConnection;42;0;41;0
WireConnection;42;2;43;0
WireConnection;42;1;45;0
WireConnection;46;0;56;0
WireConnection;46;1;42;0
WireConnection;90;0;88;0
WireConnection;90;1;57;0
WireConnection;81;0;80;0
WireConnection;72;0;56;0
WireConnection;72;1;81;0
WireConnection;73;0;72;0
WireConnection;82;0;74;0
WireConnection;82;1;77;0
WireConnection;74;0;73;0
WireConnection;74;1;75;0
WireConnection;68;0;66;2
WireConnection;68;1;67;0
WireConnection;53;0;55;0
WireConnection;83;0;82;0
WireConnection;83;1;46;0
WireConnection;70;0;46;0
WireConnection;70;1;68;0
WireConnection;57;0;58;0
WireConnection;57;1;61;0
WireConnection;57;2;46;0
WireConnection;88;0;87;1
WireConnection;88;1;89;0
WireConnection;87;0;85;0
WireConnection;67;0;69;0
WireConnection;0;2;57;0
ASEEND*/
//CHKSM=A9315EC24F5165FFAA324F4DE18FABA46CA10421