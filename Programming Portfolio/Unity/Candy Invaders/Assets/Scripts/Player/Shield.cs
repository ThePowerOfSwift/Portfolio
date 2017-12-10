using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Shield : MonoBehaviour {

	private GameObject PlayerManager;
	private Player_Manager PM;


	void Start(){
		
		PlayerManager = GameObject.Find ("PlayerManager");
		PM = (Player_Manager)PlayerManager.GetComponent (typeof(Player_Manager));
	}
	void Update(){
		if (PM.powerUpTimer <= 0) {
			Destroy (this.gameObject);
		}
	}

	void OnTriggerEnter2D (Collider2D col)
	{
		if (col.gameObject.tag == "Enemy_Bullet") {
			Destroy(col.gameObject);
		}

	}	

}
