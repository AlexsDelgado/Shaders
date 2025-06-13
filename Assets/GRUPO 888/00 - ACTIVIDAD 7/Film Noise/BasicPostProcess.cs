using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(Camera))]
public class BasicPostProcess : MonoBehaviour
{
    private static readonly int TextureNoise = Shader.PropertyToID("_TextureNoise");

    [SerializeField] private Shader shader;
    [SerializeField] private Texture textureNoise;

    private Material material;

    private void Awake()
    {
        material = new Material(shader);
    }

    private void Update()
    {
        material.SetTexture(TextureNoise, textureNoise);
    }

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        Graphics.Blit(source, destination, material);
    }
}
