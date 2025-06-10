using UnityEngine;

public class CameraMovement : MonoBehaviour
{
    public float moveSpeed = 5f;
    public float lookSpeed = 2f;

    float yaw = 0f;
    float pitch = 0f;

    void Update()
    {
        if (Input.GetMouseButton(1))
        {
            float h = Input.GetAxis("Horizontal");
            float v = Input.GetAxis("Vertical");
            Vector3 move = (transform.right * h + transform.forward * v) * moveSpeed * Time.deltaTime;
            transform.position += move;
            
            yaw += Input.GetAxis("Mouse X") * lookSpeed;
            pitch -= Input.GetAxis("Mouse Y") * lookSpeed;
            pitch = Mathf.Clamp(pitch, -89f, 89f);
            transform.eulerAngles = new Vector3(pitch, yaw, 0f);
        }
        else
        {
            yaw = transform.eulerAngles.y;
            pitch = transform.eulerAngles.x;
        }
    }
}