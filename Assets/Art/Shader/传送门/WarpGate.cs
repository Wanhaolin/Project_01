using System.Collections;
using System.Collections.Generic;
using UnityEngine;
[ExecuteInEditMode]

public class WarpGate : MonoBehaviour
{
    public Material material;
    [Range(0, 2)]
    public float rotation;
    private const string rotationName = "_Rotation";
    void Update()
    {
        if(material != null)
        {
            material.SetFloat(rotationName, rotation);
        }
    }
}
