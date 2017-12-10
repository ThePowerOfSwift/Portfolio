using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerShip : MonoBehaviour
{
	private GameManager gm;
	private Player_Manager PM;
	private GameObject PlayerManager;
	private GameObject InvaderManager;
	private Invader_Manager IM;
	private GameObject LevelManager;
	private Level_Manager LM;

	public GameObject bulletPrefab;
	public GameObject bulletSpawn01;
	public GameObject bulletSpawn02;
	public float playerRadius;
	public GameObject shieldPrefab;

	private Rigidbody2D rb2d;
	public bool isLeft;
	public bool isRight;
	public float minX, maxX, minY, maxY;

	private float eTime = 0.2f;
	private int randomNumber;

	private AudioSource playerSounds;

	void Awake ()
	{
		gm = GameObject.Find ("GameManager").GetComponent<GameManager> ();
		PlayerManager = GameObject.Find ("PlayerManager");
		PM = (Player_Manager)PlayerManager.GetComponent (typeof(Player_Manager));
		InvaderManager = GameObject.Find ("InvaderManager");
		IM = (Invader_Manager)InvaderManager.GetComponent (typeof(Invader_Manager));

		LevelManager = GameObject.Find ("LevelManager");
		LM = (Level_Manager)LevelManager.GetComponent (typeof(Level_Manager));
		isLeft = false;
		isRight = false;
		randomNumber = Random.Range (0, IM.explosions.Length);
		playerSounds = GetComponent<AudioSource> ();
	}

	void Start ()
	{
		rb2d = GetComponent<Rigidbody2D> ();
		PolygonCollider2D playerCollider = GetComponent<PolygonCollider2D> ();
		playerRadius = playerCollider.bounds.extents.x;

		float camDistance = Vector3.Distance (transform.position, Camera.main.transform.position);
		Vector2 bottomCorner = Camera.main.ViewportToWorldPoint (new Vector3 (0, 0, camDistance));
		Vector2 topCorner = Camera.main.ViewportToWorldPoint (new Vector3 (1, 1, camDistance));

		minX = bottomCorner.x + playerRadius;
		maxX = topCorner.x - playerRadius;
		minY = bottomCorner.y + playerRadius;
		maxY = topCorner.y - playerRadius;
	}

	void  Update ()
	{


		if (PM.timeBetweenShots > 0) {
			PM.timeBetweenShots -= Time.deltaTime;

		}

		Vector3 pos = transform.position;
		if (pos.x < minX)
			pos.x = minX;
		if (pos.x > maxX)
			pos.x = maxX;

		if (pos.y < minY)
			pos.y = minY;
		if (pos.y > maxY)
			pos.y = maxY;

		#if UNITY_EDITOR
		if (Input.GetKey (KeyCode.LeftArrow)) {
			isLeft = true;
			isRight = false;
		} else if (Input.GetKey (KeyCode.RightArrow)) {
			isRight = true;
			isLeft = false;
		} else {
			isLeft = false;
			isRight = false;
		}
		if (Input.GetKey (KeyCode.Space)) {
			fireBullet ();
		}

		#endif

		if (gm.isRunning) {
			if (isLeft) {
				rb2d.velocity = Vector3.left;
			} else if (isRight) {
				rb2d.velocity = Vector3.right;
			} else {
				rb2d.velocity = Vector3.zero;
			}
		} else {
			rb2d.velocity = Vector3.zero;
		}



		transform.position = pos;

	}

	public void moveLeftDown ()
	{
		isLeft = true;
	}

	public void moveLeftUp ()
	{
		isLeft = false;

	}

	public void moveRightDown ()
	{
		isRight = true;
	
	}

	public void moveRightUp ()
	{
		isRight = false;
	
	}

	public void Shield ()
	{
		LM.shieldPowerUp = GameObject.Instantiate (shieldPrefab);
		LM.shieldPowerUp.transform.position = transform.position;
		LM.shieldPowerUp.transform.parent = transform;
		LM.shieldPowerUp.name = "Shield";
			
	}

	public void fireBullet ()
	{
		if (gm.isRunning) {
			if (PM.timeBetweenShots <= 0) {			
				playerSounds.clip = LM.invadermarchSound [10];
				playerSounds.Play ();
				PM.playerBulletsMade++;
				if (PM.rapidShot) {
					GameObject bullet = (GameObject)Instantiate (bulletPrefab);
					bullet.transform.position = transform.position;
					PM.timeBetweenShots = 0.1f;
				} else if (PM.dualShot) {
					GameObject bullet01 = (GameObject)Instantiate (bulletPrefab);
					GameObject bullet02 = (GameObject)Instantiate (bulletPrefab);
					bullet01.transform.position = bulletSpawn01.transform.position;
					bullet02.transform.position = bulletSpawn02.transform.position;
					PM.timeBetweenShots = 0.3f;
				} else {
					GameObject bullet = (GameObject)Instantiate (bulletPrefab);
					bullet.transform.position = transform.position;
					PM.timeBetweenShots = 0.6f;
				}
			}
		}
			
	}

	void OnTriggerEnter2D (Collider2D col)
	{
		if (col.gameObject.tag == "Power_Up") {
			playerSounds.PlayOneShot (LM.powerUpSound);
		}
		if (col.gameObject.tag == "Enemy") {
			PM.playerLives--;
		}
		if (!PM.shield) {
			if (col.gameObject.tag == "Enemy_Bullet") {
				GameObject explosion = GameObject.Instantiate (IM.explosions [randomNumber]);
				explosion.transform.position = this.transform.position;
				DestroyObject (explosion, eTime);
			}
		}
	}
		
}
