﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Shield_PowerUp : MonoBehaviour {

	private GameObject InvaderManager;
	private Invader_Manager IM;
	private Player_Manager PM;
	private GameObject PlayerManager;
	private GameManager gm;
	private Rigidbody2D rb2d;
	public GameObject popUpPrefab;
	private GameObject player;
	private PlayerShip p;
	// Update is called once per frame
	void Awake()
	{
		
		gm = GameObject.Find("GameManager").GetComponent<GameManager>();
		InvaderManager = GameObject.Find ("InvaderManager");
		IM = (Invader_Manager) InvaderManager.GetComponent(typeof(Invader_Manager));
		PlayerManager = GameObject.Find ("PlayerManager");
		PM = (Player_Manager)PlayerManager.GetComponent (typeof(Player_Manager));
		rb2d = GetComponent<Rigidbody2D> ();
		player = GameObject.Find ("Player_Ship");
		p = (PlayerShip)player.GetComponent (typeof(PlayerShip));
	}
	void Update () {
		if (gm.isRunning) {
			rb2d.velocity = (Vector3.down * 50 * Time.deltaTime);
		} else {
			rb2d.velocity = Vector3.zero;
		}
		Vector2 min = Camera.main.ViewportToWorldPoint (new Vector2 (0, 0));


		if (transform.position.y < min.y) {
			Destroy (gameObject);
		}
	}
	void OnTriggerEnter2D (Collider2D col)
	{
		if (col.gameObject.tag == "Player") {

			Destroy(this.gameObject);
			p.Shield ();
		}
	}	
	void OnTriggerExit2D(Collider2D col){
		if (col.gameObject.tag == "Player") {
			PM.shield = true;
			PM.poweredUp = true;
			PM.powerUpTimer = 15;
			GameObject popup = GameObject.Instantiate (popUpPrefab);
		}

	}
}