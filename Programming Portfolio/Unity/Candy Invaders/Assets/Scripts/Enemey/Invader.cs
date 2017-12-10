using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Invader : MonoBehaviour {

	private GameManager gm;
	private Vector3 invaderPos;
	private GameObject InvaderGrid;
	private InvaderGrid IG;
	private GameObject InvaderManager;
	private Invader_Manager IM;
	private Player_Manager PM;
	private GameObject PlayerManager;
	private GameObject LevelManager;
	private Level_Manager LM;
	private Rigidbody2D rb2d;

	private float invaderRadius;
	private float minX, maxX, minY, maxY;
	public bool moveDown;
	public string invaderDirection;
	private bool update = true;
	private float eTime = 0.2f;
	private int randomNumber;
	private Animator anim;
	public int value;
	public string invaderType;
	public int invaderNumber;
	public string moveType;
	public float moveD;


	void Awake () {
		anim = GetComponent<Animator> ();
		invaderType = anim.runtimeAnimatorController.name.ToString();
		rb2d = GetComponent<Rigidbody2D> ();
		gm = GameObject.Find("GameManager").GetComponent<GameManager>();
		InvaderManager = GameObject.Find ("InvaderManager");
		IM = (Invader_Manager) InvaderManager.GetComponent(typeof(Invader_Manager));
		PlayerManager = GameObject.Find ("PlayerManager");
		PM = (Player_Manager)PlayerManager.GetComponent (typeof(Player_Manager));
		LevelManager = GameObject.Find ("LevelManager");
		LM = (Level_Manager)LevelManager.GetComponent (typeof(Level_Manager));
		InvaderGrid = GameObject.FindGameObjectWithTag ("InvaderGrid");
		IG = (InvaderGrid)InvaderGrid.GetComponent (typeof(InvaderGrid));
		PolygonCollider2D playerCollider = GetComponent<PolygonCollider2D>();
		invaderRadius = playerCollider.bounds.extents.x;		
		float camDistance = Vector3.Distance (transform.position, Camera.main.transform.position);
		Vector2 bottomCorner = Camera.main.ViewportToWorldPoint (new Vector3 (0, 0, camDistance));
		Vector2 topCorner = Camera.main.ViewportToWorldPoint (new Vector3 (1, 1, camDistance));
		randomNumber = Random.Range (0, IM.explosions.Length);
		IM.currentInvaders = GameObject.FindGameObjectsWithTag ("Invaders").Length;
		minX = bottomCorner.x + invaderRadius;
		maxX = topCorner.x - invaderRadius;
		minY = bottomCorner.y + invaderRadius;
		maxY = topCorner.y - invaderRadius;
		IG.invaderDir = "Right";
		invaderDirection = "Right";


	}
		
	void Start(){
		switch (invaderType){
		case "Emeny_Red":
			value = 40;
			break;
		case "Enemy_Blue":
			value = 10;
			break;
		case "Enemy_Orange":
			value = 20;
			break;
		case "Emeny_Purple":
			value = 30;
			break;
		default:
			break;

		}
	}
	void Update () {
		if (gm.isRunning) {
			if (moveType == "Single") {
				IG.moveType = "Single";
				MoveInvaderSingle ();
			} else {
				IG.moveType = "Whole";
				MoveInvaderWhole ();
			}
		} else {
			rb2d.velocity = Vector3.zero;
		}

	}
	void MoveInvaderSingle(){
		invaderPos = transform.position;

		if(invaderPos.x < minX) invaderPos.x = minX;
		if(invaderPos.x > maxX) invaderPos.x = maxX;

		if(invaderPos.y < minY) invaderPos.y  = minY;
		if(invaderPos.y > maxY) invaderPos.y  = maxY;


		if (invaderDirection == "Right") {
			rb2d.velocity = (Vector3.right * IM.invaderSpeed * Time.deltaTime);
			if (invaderPos.x >= maxX) {
				moveDown = true;
				invaderDirection = "Left";


			}
		} else if (invaderDirection == "Left") {
			rb2d.velocity = (Vector3.left * IM.invaderSpeed * Time.deltaTime);
			if (invaderPos.x <= minX) {
				moveDown = true;
				invaderDirection = "Right";
			}
		}
		if (moveDown) {
			invaderPos.y -= moveD;
			moveDown = false;
		}

		transform.position = invaderPos;
	}
	void MoveInvaderWhole()
	{
		invaderPos = transform.position;

		if(invaderPos.x < minX) invaderPos.x = minX;
		if(invaderPos.x > maxX) invaderPos.x = maxX;

		if(invaderPos.y < minY) invaderPos.y  = minY;
		if(invaderPos.y > maxY) invaderPos.y  = maxY;


		if (IM.invaderDirection == "Right") {
			if (invaderPos.x >= maxX) {
				IM.moveDown = true;
				IM.invaderDirection = "Left";


			}
		} else if (IM.invaderDirection == "Left") {
			if (invaderPos.x <= minX) {
				IM.moveDown = true;
				IM.invaderDirection = "Right";
			}
		}
		if (moveDown) {
			invaderPos.y -= moveD;
			moveDown = false;
		}

		transform.position = invaderPos;

	}
	void OnTriggerEnter2D (Collider2D col)
	{
		if (col.gameObject.tag == "Invaders") {
			if (invaderDirection == "Left") {
				invaderDirection = "Right";
			} else if (invaderDirection == "Right") {
				invaderDirection = "Left";
			}
		}
		if (col.gameObject.tag == "Player_Bullet") {
			Destroy(col.gameObject);
			IM.invaderDie.Play ();
			this.gameObject.SetActive (false);
			List<GameObject> list = new List<GameObject>(IM.enemyObject);
			list.Remove(this.gameObject);
			IM.enemyObject = list.ToArray();

			if (update) {
				if (PM.doublePoints) {
					LM.score += (value * 2);
				} else {
					LM.score += value;
				}
				IM.currentInvaders--;
				if (PM.playerBulletsMade > 0) {
					PM.playerBulletsMade--;
				}
				if (invaderNumber == IM.randomInvaderPowerUp) {
					GameObject powerUp = GameObject.Instantiate (PM.Normal_PowerUp[Random.Range(0,PM.Normal_PowerUp.Length)]);
					powerUp.transform.position = this.gameObject.transform.position;
				}
				update = false;
			}

		}
		if (col.gameObject.tag == "Player") {
			PM.playerLives--;
			if (!gm.gameOver) {
				GameObject mLife = GameObject.Instantiate (PM.minusLifePrefab);
			}
		}

	}	
	void OnTriggerExit2D(Collider2D col){
		if (col.gameObject.tag == "Player_Bullet") {
			GameObject explosion = GameObject.Instantiate (IM.explosions [randomNumber]);
			explosion.transform.position = this.transform.position;
			DestroyObject (explosion, eTime);
			IM.invaderUpdate = true;

		}
	}
}
