using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Player_Bullet : MonoBehaviour {
	private GameManager gm;
	private Player_Manager PM;
	private GameObject PlayerManager;
	private Rigidbody2D rb2d;
	// Update is called once per frame
	void Awake(){
		rb2d = GetComponent<Rigidbody2D>();
		gm = GameObject.Find("GameManager").GetComponent<GameManager>();
		PlayerManager = GameObject.Find ("PlayerManager");
		PM = (Player_Manager)PlayerManager.GetComponent (typeof(Player_Manager));
	}
	void Update () {
		if (gm.isRunning) {
			rb2d.velocity =  (Vector3.up * PM.playerBulletSpeed * 20 * Time.deltaTime);
		} else {
			rb2d.velocity = Vector3.zero;
		}
		Vector2 max = Camera.main.ViewportToWorldPoint (new Vector2 (1, 1));


		if (transform.position.y > max.y) {
			Destroy (gameObject);
			PM.playerBulletsMade--;
		}
	}
}
