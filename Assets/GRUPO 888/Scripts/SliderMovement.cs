using System;
using UnityEngine;
using UnityEngine.UI;

public class SphereMovement : MonoBehaviour
{
    public float speed;
    public GameObject target1;
    public GameObject target2;

    private bool target1Active;
     // Asigna el material desde el inspector
   

    void Start()
    {

        target1Active =true;
    }

    private void Update()
    {
        if (target1Active)
        {
            transform.position = Vector3.MoveTowards(transform.position, target1.transform.position, speed * Time.deltaTime); 
            if (transform.position.z == target1.transform.position.z)
            {
                target1Active = false;
            }
        }
        else
        {
            transform.position = Vector3.MoveTowards(transform.position, target2.transform.position, speed * Time.deltaTime); 
            if (transform.position.z == target2.transform.position.z)
            {
                target1Active = true;
            }
        }
    }
}