using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraFollow : MonoBehaviour
{
    public Transform player; // El transform del personaje
    public Vector3 offset = new Vector3(0,0,0); // Offset de la cámara respecto al personaje
    public float rotationSpeed = 5.0f; // Velocidad de rotación

    private void Start()
    {
        // Inicializar el offset si no se ha configurado
        if (offset == Vector3.zero)
        {
            offset = transform.position - player.position;
        }
    }

    private void LateUpdate()
    {
        // Seguir al personaje
        transform.position = player.position + offset;

        // Rotar la cámara con el clic derecho
        if (Input.GetMouseButton(1))
        {
            float horizontal = Input.GetAxis("Mouse X") * rotationSpeed;
            float vertical = -Input.GetAxis("Mouse Y") * rotationSpeed;

            transform.RotateAround(player.position, Vector3.up, horizontal);
            transform.RotateAround(player.position, transform.right, vertical);

            // Actualizar el offset después de la rotación
            offset = transform.position - player.position;
        }
    }
}