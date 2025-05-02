using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CamaraShader : MonoBehaviour
{
   public Transform[] shaders = new Transform[12];

   private void Start()
   {
      this.transform.position = shaders[0].position;
      this.transform.rotation = shaders[0].rotation;
   }

   public void ChangeShader(int shaderID)
   {
      this.transform.position = shaders[shaderID].position;
      this.transform.rotation = shaders[shaderID].rotation;
   }
}
