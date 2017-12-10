using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Player_Manager : MonoBehaviour {

	private GameObject InvaderManager;
	private Invader_Manager IM;
	private GameManager gm;
	private GameObject LevelManager;
	private Level_Manager LM;

	public GameObject playerPrefab;
	public float playerBulletSpeed;
	public bool playerLoaded;
	public int playerBankSpeed;
	public int playerBulletsMade;
	public int playerBulletLimit;
	public float timeBetweenShots;

	public GameObject extraLife_PowerUp;
	public GameObject[] Normal_PowerUp;
	public GameObject minusLifePrefab;
	public float powerUpTimer;
	public float slowMoTimer;
	public bool poweredUp;
	public bool rapidShot;
	public bool dualShot;
	public bool doublePoints;
	public bool shield;
	public bool slowMo;

	public int playerLives;
	public int EnemyDestroyedForLife;

	void Awake()
	{
		gm = GameObject.Find("GameManager").GetComponent<GameManager>();
		InvaderManager = GameObject.Find ("InvaderManager");
		LevelManager = GameObject.Find ("LevelManager");
		IM = (Invader_Manager) InvaderManager.GetComponent(typeof(Invader_Manager));
		LM = (Level_Manager)LevelManager.GetComponent (typeof(Level_Manager));
	}

	void Start(){
		
	}
	public void CheckPowerUps(){
		if (poweredUp) {
			if (powerUpTimer > 0) {
				powerUpTimer -= Time.deltaTime;

			} else if (powerUpTimer <= 0) {
				dualShot = false;
				shield = false;
				doublePoints = false;
				rapidShot = false;
				poweredUp = false;
			}

		}
	}

	public void CreatePlayer(){
		GameObject player = (GameObject)Instantiate (playerPrefab);
		player.name = "Player_Ship";
		playerLoaded = true;
	}
		
}
