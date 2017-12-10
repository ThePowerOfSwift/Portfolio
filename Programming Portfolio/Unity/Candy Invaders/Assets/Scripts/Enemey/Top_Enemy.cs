using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Top_Enemy : MonoBehaviour {

	private GameObject InvaderManager;
	private Invader_Manager IM;
	private GameManager gm;
	private Player_Manager PM;
	private GameObject PlayerManager;
	private GameObject LevelManager;
	private Level_Manager LM;

	private Rigidbody2D rb2d;
	public int value = 100;
	public GameObject bulletPrefab;
	private float playerRadius;
	private float minX, maxX;
	private bool update = true;
	private bool isLeft;
	private float eTime = 0.2f;
	private int randomNumber;
	private AudioSource topInvaderSound;

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
		topInvaderSound = GetComponent<AudioSource> ();
		topInvaderSound.clip = LM.invadermarchSound [12];
		topInvaderSound.Play();
	}
	void Start(){
		PolygonCollider2D playerCollider = GetComponent<PolygonCollider2D>();
		playerRadius = playerCollider.bounds.extents.x;
		float camDistance = Vector3.Distance (transform.position, Camera.main.transform.position);
		Vector2 bottomCorner = Camera.main.ViewportToWorldPoint (new Vector3 (0, 0, camDistance));
		Vector2 topCorner = Camera.main.ViewportToWorldPoint (new Vector3 (1, 1, camDistance));
		topInvaderSound.PlayOneShot ( LM.invadermarchSound [12]);
		minX = bottomCorner.x - playerRadius;
		maxX = topCorner.x + playerRadius;
		if (gm.isRunning) {
			if (IM.topInvaderDirection == "Right") {
				rb2d.velocity = (Vector3.right * IM.topInvaderSpeed * 10 * Time.deltaTime);
				isLeft = true;
			} else if (IM.topInvaderDirection == "Left") {
				rb2d.velocity = (Vector3.left * IM.topInvaderSpeed * 10 * Time.deltaTime);
				isLeft = false;
			}
		} else {
			
		}
		InvokeRepeating("FireBullet",0,4f);
	}
	void Update(){
		
		if (isLeft) {
			
			if (this.transform.position.x > maxX) {
				Destroy (this.gameObject);
			}
		} else {
			
			if (this.transform.position.x < minX) {
				Destroy (this.gameObject);
			}
		}
			
	}
	void FireBullet(){
		topInvaderSound.pitch = 2.0f;
		topInvaderSound.PlayOneShot ( LM.invadermarchSound [5]);
		GameObject bullet = (GameObject)Instantiate (bulletPrefab);
		bullet.transform.position = this.transform.position;
	}
	void OnTriggerEnter2D (Collider2D col)
	{
		if (col.gameObject.tag == "Player_Bullet") {
			Destroy(col.gameObject);
			CancelInvoke ();
			Destroy (this.gameObject);
//			if (IM.topInvaderDirection == "Right") {
//				IM.topInvaderDirection = "Left";
//			} else if (IM.topInvaderDirection == "Left") {
//				IM.topInvaderDirection = "Right";
//			}

		}
	}	
	void OnTriggerExit2D(Collider2D col){
		if (col.gameObject.tag == "Player_Bullet") {
				GameObject explosion = GameObject.Instantiate (IM.explosions [randomNumber]);
				explosion.transform.position = this.transform.position;
				DestroyObject (explosion, eTime);
			if (update) {
				if (PM.doublePoints) {
					LM.score += (value * 2);
				} else {
					LM.score += value;
				}

				if (PM.EnemyDestroyedForLife < 6) {
					GameObject powerUp = GameObject.Instantiate (PM.Normal_PowerUp[Random.Range(0,PM.Normal_PowerUp.Length)]);
					powerUp.transform.position = this.gameObject.transform.position;
					PM.EnemyDestroyedForLife++;
				} else if (PM.EnemyDestroyedForLife == 6) {
					GameObject extraLife = GameObject.Instantiate (PM.extraLife_PowerUp);
					extraLife.transform.position = this.gameObject.transform.position;
					PM.EnemyDestroyedForLife = 0;
				}
				if (PM.playerBulletsMade > 0) {
					PM.playerBulletsMade--;
				}
				update = false;
			}

		}

	}
}
