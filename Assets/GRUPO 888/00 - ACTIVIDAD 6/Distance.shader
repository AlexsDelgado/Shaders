// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Distance"
{
	Properties
	{
		_Frequency("Frequency", Float) = 5.59
		_Color0("Color 0", Color) = (0.1177983,1,0,0)
		_DeformationVector("DeformationVector", Vector) = (0,0,0,0)
		_Height("Height", Float) = 0
		_Color1("Color 1", Color) = (1,0,0,0)
		_EpicenterX("EpicenterX", Range( -70 , 130)) = 0
		_EpicenterY("EpicenterY", Range( 500 , 1500)) = 0
		_EpicenterZ("EpicenterZ", Range( -150 , 130)) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 4.6
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
		};

		uniform float _EpicenterX;
		uniform float _EpicenterY;
		uniform float _EpicenterZ;
		uniform float _Frequency;
		uniform float3 _DeformationVector;
		uniform float _Height;
		uniform float4 _Color1;
		uniform float4 _Color0;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float3 appendResult17 = (float3(_EpicenterX , _EpicenterY , _EpicenterZ));
			float Distance20 = distance( ase_worldPos , appendResult17 );
			float temp_output_6_0 = sin( ( ( Distance20 + _Time.y ) * _Frequency ) );
			float3 DeformationAndHeight24 = ( temp_output_6_0 * _DeformationVector * _Height );
			float3 temp_output_25_0 = DeformationAndHeight24;
			v.vertex.xyz += temp_output_25_0;
			v.vertex.w = 1;
			v.normal = temp_output_25_0;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldPos = i.worldPos;
			float3 appendResult17 = (float3(_EpicenterX , _EpicenterY , _EpicenterZ));
			float Distance20 = distance( ase_worldPos , appendResult17 );
			float temp_output_6_0 = sin( ( ( Distance20 + _Time.y ) * _Frequency ) );
			float4 lerpResult4 = lerp( _Color1 , _Color0 , (0.0 + (temp_output_6_0 - -1.0) * (1.0 - 0.0) / (1.0 - -1.0)));
			float4 Waves22 = lerpResult4;
			o.Albedo = Waves22.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
479;585;950;414;3153.75;349.8885;4.049946;False;False
Node;AmplifyShaderEditor.CommentaryNode;28;-2037.142,-408.6808;Inherit;False;1018.791;464.6494;Distance;7;18;16;19;17;15;14;20;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-1985.119,-59.19143;Inherit;False;Property;_EpicenterZ;EpicenterZ;7;0;Create;True;0;0;0;False;0;False;0;0;-150;130;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-1986.13,-216.085;Inherit;False;Property;_EpicenterX;EpicenterX;5;0;Create;True;0;0;0;False;0;False;0;0;-70;130;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-1987.143,-139.1567;Inherit;False;Property;_EpicenterY;EpicenterY;6;0;Create;True;0;0;0;False;0;False;0;0;500;1500;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;15;-1706.884,-358.6808;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;17;-1655.137,-202.9263;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DistanceOpNode;14;-1420.883,-269.6807;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;20;-1257.751,-274.5525;Inherit;False;Distance;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;27;-2118.668,91.84162;Inherit;False;1520.864;672.348;Sin Waves;11;13;21;7;9;8;6;5;10;11;4;22;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleTimeNode;13;-2062.897,599.9395;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;21;-2068.668,481.3971;Inherit;False;20;Distance;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;9;-1854.879,509.8041;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1856.916,619.8332;Inherit;False;Property;_Frequency;Frequency;0;0;Create;True;0;0;0;False;0;False;5.59;7;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-1686.796,510.0295;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;26;-1668.953,918.325;Inherit;False;738.9368;360.0446;Deformation and Height;4;2;3;1;24;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SinOpNode;6;-1532.863,511.0294;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;11;-1319.741,141.8416;Inherit;False;Property;_Color1;Color 1;4;0;Create;True;0;0;0;False;0;False;1,0,0,0;1,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;10;-1320.627,321.4985;Inherit;False;Property;_Color0;Color 0;1;0;Create;True;0;0;0;False;0;False;0.1177983,1,0,0;0.1177983,1,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;5;-1374.988,511.0296;Inherit;True;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;2;-1618.954,992.1242;Inherit;False;Property;_DeformationVector;DeformationVector;2;0;Create;True;0;0;0;False;0;False;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;3;-1548.791,1163.209;Inherit;False;Property;_Height;Height;3;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;4;-1024.636,375.7141;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1;-1369.731,973.9205;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;22;-837.2039,369.9896;Inherit;False;Waves;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;24;-1213.267,968.325;Inherit;False;DeformationAndHeight;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;25;-349.1995,295.2541;Inherit;False;24;DeformationAndHeight;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;23;-243.7091,-6.730423;Inherit;False;22;Waves;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;Distance;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;17;0;16;0
WireConnection;17;1;18;0
WireConnection;17;2;19;0
WireConnection;14;0;15;0
WireConnection;14;1;17;0
WireConnection;20;0;14;0
WireConnection;9;0;21;0
WireConnection;9;1;13;0
WireConnection;8;0;9;0
WireConnection;8;1;7;0
WireConnection;6;0;8;0
WireConnection;5;0;6;0
WireConnection;4;0;11;0
WireConnection;4;1;10;0
WireConnection;4;2;5;0
WireConnection;1;0;6;0
WireConnection;1;1;2;0
WireConnection;1;2;3;0
WireConnection;22;0;4;0
WireConnection;24;0;1;0
WireConnection;0;0;23;0
WireConnection;0;11;25;0
WireConnection;0;12;25;0
ASEEND*/
//CHKSM=EA500D8D56B690091F37B4D2C142CC0C739D527D