using System;
using UnityEngine;
using UnityEngine.UI;

public class OffsetSlideer : MonoBehaviour
{
    public Slider slider; // Asigna el slider desde el inspector
    public FollowProject Projector; // Asigna el material desde el inspector
   

    void Start()
    {
        slider.onValueChanged.AddListener(OnSliderValueChanged);
    }

    void OnSliderValueChanged(float value)
    {
        Projector.offsetY=value;
    }
}