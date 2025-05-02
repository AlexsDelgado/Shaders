using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NewBehaviourScript : MonoBehaviour
{

    public GameObject shaderMenu;
    private bool menuActive = false;
    public void ChangeMenu()
    {
        if (menuActive)
        {
            shaderMenu.SetActive(false);
            menuActive = false;
        }
        else
        {
            shaderMenu.SetActive(true);
            menuActive = true;
        }
    }

}
