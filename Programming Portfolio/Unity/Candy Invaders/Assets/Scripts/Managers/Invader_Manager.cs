using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Invader_Manager : MonoBehaviour
{

	private GameManager gm;
	private GameObject LevelManager;
	private Level_Manager LM;

	public GameObject[] enemyPrefabs;
	public GameObject enemyBullet01;
	public GameObject[] enemyObject;
	public int totalMissiles;
	public int maxMissiles;

	public int[] enemyValue;
	public int invaderNr;
	public int currentInvaders;
	public int maxInvaders;
	public int randomInvader;
	public int randomInvaderPowerUp;
	public bool invaderUpdate;

	public int rowSize;
	public float rowSpacing;
	private Vector3 enemyPos = Vector3.zero;

	public GameObject[] topInvaders;
	public float topInvaderSpeed;
	public int topInvaderSpawnTime;
	public string topInvaderDirection;
	public Transform topInvaderPosLeft;
	public Transform topInvaderPosRight;

	public GameObject[] explosions;

	public int invaderAttackSpeed;
	public float invaderBulletSpeed;
	public float invaderBounds;
	public float invaderSpeed;
	public float currentSpeed;
	public int currentAttack;
	public float currentBullet;
	private float invaderStartSpeed;
	public string invaderDirection;
	public bool moveDown;

	private AudioSource invaderSounds;
	private GameObject invaderDieSound;
	public AudioSource invaderDie;

	private GameObject bulletExplosion;
	public AudioSource bulletExp;

	void Awake ()
	{
		enemyObject = GameObject.FindGameObjectsWithTag ("Invaders");
		gm = GameObject.Find ("GameManager").GetComponent<GameManager> ();
		topInvaderDirection = "Left";
		LevelManager = GameObject.Find ("LevelManager");
		LM = (Level_Manager)LevelManager.GetComponent (typeof(Level_Manager));
		invaderSounds = GetComponent<AudioSource> ();
		invaderDieSound = GameObject.Find ("InvaderDieSound");
		invaderDie = invaderDieSound.GetComponent<AudioSource> ();
		invaderDie.clip = LM.invadermarchSound [2];
		invaderDie.pitch = 0.5f;
		bulletExplosion = GameObject.Find ("BulletExplosion");
		bulletExp = bulletExplosion.GetComponent<AudioSource> ();
		bulletExp.clip = LM.invadermarchSound [2];
		bulletExp.pitch = 0.3f;

	}

	void Update ()
	{
		if (gm.isRunning) {
			InvaderUpdates ();
			if (moveDown) {
				foreach (GameObject entity in enemyObject) {
					if (entity != null)
						entity.GetComponent<Invader> ().moveDown = true;
				}
				moveDown = false;
			}
		}
	}

	public void InvaderUpdates ()
	{
		
		if (invaderUpdate) {

			switch (currentInvaders) {
			case (50):
				invaderAttackSpeed = 10;

				invaderBulletSpeed = 5;
				invaderUpdate = false;
				break;
			case 45:
				topInvaderSpeed = 1.5f;
				invaderAttackSpeed = 9;
				invaderBulletSpeed = 5;
				invaderUpdate = false;
				break;
			case 40:
				topInvaderSpeed = 1.5f;
				invaderAttackSpeed = 8;
				invaderBulletSpeed = 6;
				invaderSpeed += 1;
				invaderUpdate = false;
				break;
			case 35:
				topInvaderSpeed = 1.6f;
				invaderAttackSpeed = 8;
				invaderBulletSpeed = 7;
				invaderUpdate = false;
				break;
			case 30:
				topInvaderSpeed = 1.7f;
				invaderAttackSpeed = 7;
				invaderBulletSpeed = 7;
				invaderUpdate = false;
				break;
			case 25:
				topInvaderSpeed = 1.7f;
				invaderAttackSpeed = 7;
				invaderBulletSpeed = 8;
				invaderSpeed += 1;
				invaderUpdate = false;
				break;
			case 20:
				topInvaderSpeed = 4;
				invaderAttackSpeed = 6;
				invaderBulletSpeed = 9;
				invaderUpdate = false;
				break;
			case 15:
				topInvaderSpeed = 1.8f;
				invaderAttackSpeed = 6;
				invaderBulletSpeed = 9;
				invaderSpeed += 1;
				invaderUpdate = false;
				break;
			case 10:
				topInvaderSpeed = 1.8f;
				invaderAttackSpeed = 5;
				invaderBulletSpeed = 9;
				invaderSpeed += 1;
				invaderUpdate = false;
				break;
			case 5:
				topInvaderSpeed = 2.0f;
				invaderAttackSpeed = 5;
				invaderBulletSpeed = 9;
				invaderSpeed += 1;
				invaderUpdate = false;
				break;
			case 1:
				topInvaderSpeed = 4.0f;
				invaderAttackSpeed = 5;
				invaderBulletSpeed = 10;
				invaderSpeed = 30;
				invaderUpdate = false;
				break;
			default:
				invaderUpdate = false;
				break;
			}
		}

			
	}

	public void StartCoRoutinesInvaders ()
	{
		StartCoroutine (SpawnBullets ());
		StartCoroutine (SpawnTopEnemy ());
	}

	public void StopCoRoutineInvaders ()
	{
		StopAllCoroutines ();
	}

	IEnumerator SpawnBullets ()
	{
		yield return new WaitForSeconds (invaderAttackSpeed / 2);
		while (gm.isRunning) {
			invaderSounds.clip = LM.invadermarchSound [10];
			invaderSounds.pitch = 0.5f;
			invaderSounds.Play ();
			randomInvader = Random.Range (0, currentInvaders);
			Vector3 pos = enemyObject [randomInvader].gameObject.transform.position;
			GameObject bullet01 = (GameObject)Instantiate (enemyBullet01);
			bullet01.transform.position = pos;
			yield return new WaitForSeconds (invaderAttackSpeed / 2);
		}
	}

	IEnumerator SpawnTopEnemy ()
	{
		yield return new WaitForSeconds (topInvaderSpawnTime);
		int randomNumber = Random.Range (0, topInvaders.Length);
		while (gm.isRunning) {
			
			if (topInvaderDirection == "Left") {
				
				GameObject topEnemy = (GameObject)Instantiate (topInvaders [randomNumber]);
				topEnemy.transform.position = topInvaderPosRight.position;
				topInvaderDirection = "Right";
	
			} else if (topInvaderDirection == "Right") {
				GameObject topEnemy = (GameObject)Instantiate (topInvaders [randomNumber]);
				topEnemy.transform.position = topInvaderPosLeft.position;
				topInvaderDirection = "Left";
			}
			yield return new WaitForSeconds (topInvaderSpawnTime);
		}
	}
		
}
