using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BarrierPiece : MonoBehaviour {

	private Player_Manager PM;
	private GameObject InvaderManager;
	private Invader_Manager IM;
	private GameObject PlayerManager;
	private GameObject LevelManager;
	private Level_Manager LM;

	private float eTime = 0.2f;
	private int randomNumber;

	private AudioSource barrierSound;

	void Awake() {
		PlayerManager = GameObject.Find ("PlayerManager");
		InvaderManager = GameObject.Find ("InvaderManager");
		IM = (Invader_Manager) InvaderManager.GetComponent(typeof(Invader_Manager));
		PM = (Player_Manager)PlayerManager.GetComponent (typeof(Player_Manager));
		LevelManager = GameObject.Find ("LevelManager");
		LM = (Level_Manager)LevelManager.GetComponent (typeof(Level_Manager));
		randomNumber = Random.Range (0, IM.explosions.Length);
		barrierSound = GetComponent<AudioSource> ();
		barrierSound.clip = LM.invadermarchSound [2];

	}
	void OnTriggerEnter2D (Collider2D col)
	{
		
		if (col.gameObject.tag == "Player_Bullet") {
			GetComponent<SpriteRenderer> ().enabled = false;
			barrierSound.PlayOneShot (LM.invadermarchSound [2]);
			Destroy (col.gameObject);
			Destroy (this.gameObject,barrierSound.clip.length);
			GameObject explosion = GameObject.Instantiate (IM.explosions [randomNumber]);
			explosion.transform.position = this.transform.position;
			DestroyObject (explosion, eTime);
		} else if (col.gameObject.tag == "Enemy_Bullet") {
			GetComponent<SpriteRenderer> ().enabled = false;
			barrierSound.PlayOneShot (LM.invadermarchSound [2]);
			Destroy (col.gameObject);
			Destroy (this.gameObject,barrierSound.clip.length);
			GameObject explosion = GameObject.Instantiate (IM.explosions [randomNumber]);
			explosion.transform.position = this.transform.position;
			DestroyObject (explosion, eTime);
		} else if (col.gameObject.tag == "Enemy") {
			GetComponent<SpriteRenderer> ().enabled = false;
			barrierSound.PlayOneShot (LM.invadermarchSound [2]);
			Destroy (this.gameObject,barrierSound.clip.length);
			GameObject explosion = GameObject.Instantiate (IM.explosions [randomNumber]);
			explosion.transform.position = this.transform.position;
			DestroyObject (explosion, eTime);
		}

	}	
	void OnTriggerExit2D(Collider2D col){
		if (col.gameObject.tag == "Player_Bullet") {
			Destroy (col.gameObject);
			if (PM.playerBulletsMade > 0) {
				PM.playerBulletsMade--;
			}
		} else if (col.gameObject.tag == "Enemy_Bullet") {
				
		}

	}
}
