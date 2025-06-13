using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FollowProject : MonoBehaviour
{
    public GameObject followTarget;

    public float offsetY;
    void Update()
    {
        Vector3 transform = followTarget.transform.position;
        gameObject.transform.position = new Vector3(transform.x,offsetY,transform.z);
    }
}
