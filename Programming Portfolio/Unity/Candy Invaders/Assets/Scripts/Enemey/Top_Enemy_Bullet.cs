using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Top_Enemy_Bullet : MonoBehaviour {

	private GameObject InvaderManager;
	private Invader_Manager IM;
	private Player_Manager PM;
	private GameObject PlayerManager;
	private GameManager gm;
	private Rigidbody2D rb2d;
	private float eTime = 0.2f;
	private int randomNumber;
	private AudioSource bulletSound;
	private GameObject LevelManager;
	private Level_Manager LM;
	void Awake()
	{
		gm = GameObject.Find("GameManager").GetComponent<GameManager>();
		InvaderManager = GameObject.Find ("InvaderManager");
		IM = (Invader_Manager) InvaderManager.GetComponent(typeof(Invader_Manager));
		PlayerManager = GameObject.Find ("PlayerManager");
		PM = (Player_Manager)PlayerManager.GetComponent (typeof(Player_Manager));
		LevelManager = GameObject.Find ("LevelManager");
		LM = (Level_Manager)LevelManager.GetComponent (typeof(Level_Manager));
		rb2d = GetComponent<Rigidbody2D> ();
		randomNumber = Random.Range (0, IM.explosions.Length);
		bulletSound = GetComponent<AudioSource> ();
		bulletSound.clip = LM.invadermarchSound [10];
		bulletSound.pitch = 0.7f;

	}
	void Start(){
		bulletSound.Play ();
	}
	void Update () {
		if (gm.isRunning) {
			rb2d.velocity = (Vector3.down * IM.invaderBulletSpeed * 10* Time.deltaTime);
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
		if (col.gameObject.tag == "Player_Shield") {
			GetComponent<SpriteRenderer> ().enabled = false;
			IM.bulletExp.Play();
			Destroy (this.gameObject,IM.bulletExp.clip.length);
			GameObject explosion = GameObject.Instantiate (IM.explosions [randomNumber]);
			explosion.transform.position = this.transform.position;
			DestroyObject (explosion, eTime);
		}
		if (col.gameObject.tag == "Player") {
			GetComponent<SpriteRenderer> ().enabled = false;
			IM.bulletExp.Play();
			Destroy (this.gameObject,IM.bulletExp.clip.length);
			gm.isDead = true;
			col.gameObject.GetComponent<Renderer>().enabled = false;

		}
		if (col.gameObject.tag == "Player_Bullet") {
			GetComponent<SpriteRenderer> ().enabled = false;
			IM.bulletExp.Play();
			Destroy (this.gameObject,IM.bulletExp.clip.length);
			Destroy (col.gameObject);
			GameObject explosion = GameObject.Instantiate (IM.explosions [randomNumber]);
			explosion.transform.position = this.transform.position;
			DestroyObject (explosion, eTime);
		}
	}	
	void OnTriggerExit2D(Collider2D col){
		if (col.gameObject.tag == "Player") {
			PM.playerLives--;
			if (!gm.gameOver) {
				GameObject mLife = GameObject.Instantiate (PM.minusLifePrefab);
			}
		}
		if (col.gameObject.tag == "Player_Bullet") {
			PM.playerBulletsMade--;
		}

	}
}
