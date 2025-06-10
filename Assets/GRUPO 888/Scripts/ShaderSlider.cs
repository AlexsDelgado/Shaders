using UnityEngine;
using UnityEngine.UI;

public class ShaderSlider : MonoBehaviour
{
    public Slider slider; // Asigna el slider desde el inspector
    public Material material; // Asigna el material desde el inspector
    public string shaderProperty = "_MyShaderProperty"; // Nombre de la propiedad del shader

    void Start()
    {
        // Asegúrate de que el slider tenga un listener para el evento de cambio de valor
        slider.onValueChanged.AddListener(OnSliderValueChanged);
    }

    void OnSliderValueChanged(float value)
    {
        // Actualiza el valor de la propiedad del shader en el material
        material.SetFloat(shaderProperty, value);
        Debug.Log(material.name);
        Debug.Log(value);
    }
}