using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SlowMo : MonoBehaviour {

	private GameObject InvaderManager;
	private Invader_Manager IM;
	private Player_Manager PM;
	private GameObject PlayerManager;
	// Use this for initialization
	void Start () {
		InvaderManager = GameObject.Find ("InvaderManager");
		IM = (Invader_Manager) InvaderManager.GetComponent(typeof(Invader_Manager));
		PlayerManager = GameObject.Find ("PlayerManager");
		PM = (Player_Manager)PlayerManager.GetComponent (typeof(Player_Manager));
	}
	
	// Update is called once per frame
	void Update () {
		IM.invaderSpeed = 1;
		IM.invaderBulletSpeed = 1;
		IM.invaderAttackSpeed = 15;

		if (PM.slowMoTimer > 0) {
			PM.slowMoTimer -= Time.deltaTime;
		} else if (PM.slowMoTimer <= 0) {
			PM.slowMo = true;
		}

		if (PM.slowMo) {
			IM.invaderUpdate = true;
			IM.invaderSpeed = IM.currentSpeed;
			IM.invaderBulletSpeed = IM.currentBullet;
			IM.invaderAttackSpeed = IM.currentAttack;
			Destroy (this.gameObject);
			PM.slowMo = false;
		}
	}
}
