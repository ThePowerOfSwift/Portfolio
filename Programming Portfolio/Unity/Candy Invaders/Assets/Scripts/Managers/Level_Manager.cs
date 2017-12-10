using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Advertisements;

public class Level_Manager : MonoBehaviour
{
	private GameObject InvaderManager;
	private Invader_Manager IM;
	private GameManager gm;
	private Player_Manager PM;
	private GameObject PlayerManager;

	public GameObject[] barrierPrefabs;
	public Transform[] barrierSpawnPos;
	private GameObject[] barrierObjects;

	public Transform[] powerUpSpawnPos;
	public float powerUpSpawnWait;
	public GameObject shieldPowerUp;

	public GameObject[] invaderGridPrefabs;

	public Text scoreText;
	public Text livesText;
	public Text levelText;
	public Text levelTextTitle;
	public Button restart;
	public Button exit;

	public GameObject backgroundImage;
	public Sprite[] bImages;

	public GameObject topItems;
	public GameObject ctrlHUD;
	public GameObject endButtons;
	public Text endButtonTextScore;
	public Text endButtonsTitle;
	public Text resumeRestart;
	public GameObject endLevel;
	public Text nextLevelTextScore;
	public Text bonusScore;
	public Text endTitle;
	private bool bonusUpdate;
	private int bonusAmount;

	public bool loading;
	public bool paused;
	public float levelStartWait;
	private float invaderMaxSpeed;
	public bool nextLevel;
	private float levelTimer;
	private bool levelCount;

	public int score;
	public int bestScore;
	public int level;

	public bool adShown;
	private GameObject Dreamlo;
	private dreamloLeaderBoard DL;
	public InputField nameField;
	public GameObject AddScore;
	public bool addScore;

	public AudioClip[] invadermarchSound;
	public AudioClip extralifeSound;
	public AudioClip stageclearSound;
	public AudioClip gameoverSound;
	public AudioClip powerUpSound;
	private AudioSource levelSounds;

	public GameObject mainMusic;
	public AudioClip[] backgroundMusic;
	private AudioSource mMusic;

	void Awake ()
	{
		gm = GameObject.Find ("GameManager").GetComponent<GameManager> ();
		InvaderManager = GameObject.Find ("InvaderManager");
		IM = (Invader_Manager)InvaderManager.GetComponent (typeof(Invader_Manager));
		PlayerManager = GameObject.Find ("PlayerManager");
		PM = (Player_Manager)PlayerManager.GetComponent (typeof(Player_Manager));
		Dreamlo = GameObject.Find ("dreamlo");
		DL = (dreamloLeaderBoard)Dreamlo.GetComponent (typeof(dreamloLeaderBoard));
		mMusic = mainMusic.GetComponent<AudioSource> ();
		bestScore = PlayerPrefs.GetInt ("bestScore");
		endButtons.SetActive (false);
		endLevel.SetActive (false);
		AddScore.SetActive (false);
		PM.CreatePlayer ();
		invaderMaxSpeed = 21f;
		levelSounds = GetComponent<AudioSource> ();
	}
	void Start(){

	}

	void Update ()
	{
		if (levelCount) {
			levelTimer += Time.deltaTime;
		}

		if (loading) {
			if (levelStartWait > 0) {
				levelStartWait -= Time.deltaTime;
			}
			if (levelStartWait > 0.1 && levelStartWait < 0.4) {
				levelTextTitle.text = "GO";
			}
			if (levelStartWait <= 0) {
				loading = false;
				StartGame ();
			}

		}
		if (gm.isDead && !gm.gameOver) {
			PlayerDie ();
			if (levelStartWait > 0) {
				levelStartWait -= Time.deltaTime;
			}
			if (levelStartWait <= 0) {
				IM.StartCoRoutinesInvaders ();
				StartGame ();

			}
		}

	}

	public void Level (int lvl)
	{
		mMusic.clip = backgroundMusic [Random.Range (0, backgroundMusic.Length)];
		if (mMusic.clip == backgroundMusic [0]) {
			mMusic.volume = 0.125f;
		} else {
			mMusic.volume = 0.45f;
		}

		mMusic.loop = true;
		mMusic.Play ();
		levelTimer = 0;
		levelCount = true;
		LoadPlayer ();
		ChangeBackground ();
		CreateInvaders (lvl);
		bonusUpdate = false;
		level = lvl;
		ctrlHUD.SetActive (true);
		topItems.SetActive (true);
		levelStartWait = 2;
		loading = true;
		SetupCounters ();
		CreateBarriers ();
		IM.StartCoRoutinesInvaders ();
	}

	void ChangeBackground ()
	{
		Image img = backgroundImage.GetComponent<Image> ();
		img.sprite = bImages [Random.Range (0, bImages.Length)];
	}

	void CreateInvaders (int lvl)
	{
		IM.invaderSpeed = lvl + 3;
		if (IM.invaderSpeed > invaderMaxSpeed) {
			IM.invaderSpeed = invaderMaxSpeed;
		}

		IM.topInvaderSpeed = 1.3f;

		IM.currentSpeed = IM.invaderSpeed;
		IM.currentBullet = 5;
		IM.currentAttack = 10;
		IM.invaderDirection = "Right";
		int randomGrid = Random.Range (0, invaderGridPrefabs.Length);
//		int randomGrid = 7;

		GameObject Grid = GameObject.Instantiate (invaderGridPrefabs [randomGrid]);
		if (randomGrid == 6) {
			Grid.name = "InvaderGrid_SingleMove";
			IM.enemyObject = GameObject.FindGameObjectsWithTag ("Invaders");
			int number = 0;
			foreach (GameObject enemy in IM.enemyObject) {
				Invader I = enemy.GetComponent<Invader> ();
				I.moveType = "Single";
				I.moveD = 0.1f;
				I.invaderNumber = number;
				number++;
			}
		} else if (randomGrid == 7) {
			Grid.name = "InvaderGrid_SingleMove";
			IM.enemyObject = GameObject.FindGameObjectsWithTag ("Invaders");
			int number = 0;
			foreach (GameObject enemy in IM.enemyObject) {
				Invader I = enemy.GetComponent<Invader> ();
				I.moveType = "Single";
				I.invaderNumber = number;
				I.moveD = 0.285f;
				number++;
			}
			
		} else {
			IM.enemyObject = GameObject.FindGameObjectsWithTag ("Invaders");
			int number = 0;
			foreach (GameObject enemy in IM.enemyObject) {
				Invader I = enemy.GetComponent<Invader> ();
				I.moveType = "Whole";
				I.moveD = 0.1f;
				I.invaderNumber = number;
				number++;
			}
		}


		IM.randomInvaderPowerUp = Random.Range (0, IM.enemyObject.Length);
		IM.maxInvaders = IM.enemyObject.Length;
	}

	void LoadPlayer(){
		GameObject player = GameObject.Find ("Player_Ship");
		player.GetComponent<Renderer> ().enabled = true;
	}

	public void CreateBarriers ()
	{
		barrierObjects = new GameObject[3];
		int randomNumber = Random.Range (0, barrierPrefabs.Length);
		for (int x = 0; x < barrierSpawnPos.Length; x++) {
			barrierObjects [x] = (GameObject)Instantiate (barrierPrefabs [randomNumber], barrierSpawnPos [x].transform.position, Quaternion.identity) as GameObject;
			barrierObjects [x].name = "Barrier";
		}

	}

	public void CheckGameStatus ()
	{
		if (gm.isRunning) {
			livesText.text = PM.playerLives.ToString ();
			scoreText.text = score.ToString ();
			if (bestScore < score) {
				PlayerPrefs.SetInt ("bestScore", score);
			}
			PM.CheckPowerUps ();

			if (IM.currentInvaders == 0) {
				gm.isRunning = false;
				gm.nextLevel = true;
			}

	
		}
		if (PM.playerLives == 0) {
			gm.isRunning = false;
			gm.gameOver = true;
		}

	}

	void StartGame ()
	{
		LoadPlayer ();
		gm.isDead = false;

		if (shieldPowerUp != null) {
			shieldPowerUp.SetActive (true);
		}
		gm.isRunning = true;
		levelTextTitle.text = "";

	}

	void PlayerDie ()
	{
		levelSounds.PlayOneShot (invadermarchSound[9], 0.5f);
		gm.isRunning = false;
		IM.StopCoRoutineInvaders();
	}

	public void PauseGame ()
	{
		PlayerPrefs.SetInt ("lastScore", score);
		paused = true;
		mMusic.Pause ();
		gm.isRunning = false;
		endButtonsTitle.text = "PAUSED";
		endButtonTextScore.text = score.ToString ();
		resumeRestart.text = "Resume";
		endButtons.SetActive (true);
		IM.StopCoRoutineInvaders ();
	
	}

	public void Unpause ()
	{
		mMusic.UnPause ();
		paused = false;
		gm.isRunning = true;
		resumeRestart.text = "Resume";
		endButtons.SetActive (false);
		IM.StartCoRoutinesInvaders ();

	}

	public void NextLevel ()
	{
		mMusic.Stop ();
		levelSounds.PlayOneShot (stageclearSound);
		adShown = false;
		GameObject player = GameObject.Find ("Player_Ship");
		PlayerShip play = (PlayerShip)player.GetComponent (typeof(PlayerShip));
		if (play.isLeft) {
			play.moveLeftUp();
		} else if (play.isRight) {
			play.moveRightUp ();
		}
		if (shieldPowerUp != null) {
			shieldPowerUp.SetActive (false);
		}
		gm.isRunning = false;

		endLevel.SetActive (true);
		ctrlHUD.SetActive (false);
		topItems.SetActive (false);
		BonusCheck ();
		nextLevelTextScore.text = score.ToString ();
		level++;
		if (bestScore < score) {
			PlayerPrefs.SetInt ("bestScore", score);
		}
		foreach (GameObject enemy in IM.enemyObject) {
			if (enemy != null) {
				Destroy (enemy);
			}

		}
		DestroyObjects ();
		IM.StopCoRoutineInvaders ();

	}

	public void NextLevelButton ()
	{
		endLevel.SetActive (false);
//		Level (level);
		switch (level) {
		case 5:
			ShowRewardedAd ();
			break;
		case 10:
			ShowRewardedAd ();
			break;
		case 15:
			ShowRewardedAd ();
			break;
		case 20:
			ShowRewardedAd ();
			break;
		case 25:
			ShowRewardedAd ();
			break;
		default: 
			Level (level);
			break;
		}
	}

	public void GameOver ()
	{
		mMusic.Stop ();
		levelSounds.PlayOneShot (gameoverSound);
		addScore = true;
		endButtonsTitle.text = "GAME OVER";
		endButtonTextScore.text = score.ToString ();
		IM.StopCoRoutineInvaders ();
		if (bestScore < score) {
			PlayerPrefs.SetInt ("bestScore", score);
		}
		PlayerPrefs.SetInt ("lastScore", score);
		DestroyObjects ();
		level = 1;
		topItems.SetActive (false);
		ctrlHUD.SetActive (false);
		AddScore.SetActive (true);


	}
	public void PlayerNameOK(){
		string name = nameField.text;
		PlayerPrefs.SetString ("playerName", name);
		AddScore.SetActive (false);
		endButtons.SetActive (true);
		if (addScore) {
			DL.AddScore (name, score);
			addScore = false;
		}
	}

	void SetupCounters ()
	{
		gm.lives = PM.playerLives;
		gm.score = score;
		gm.currentLevel = level;
		scoreText.text = score.ToString ();
		levelText.text = level.ToString ();
		livesText.text = PM.playerLives.ToString ();
		levelTextTitle.text = "LEVEL " + level.ToString ();
		gm.configure = true;
	}

	void DestroyObjects ()
	{

		GameObject invaderGrid = GameObject.FindGameObjectWithTag ("InvaderGrid");
		Destroy (invaderGrid);
		GameObject[] pBullets = GameObject.FindGameObjectsWithTag ("Player_Bullet");
		foreach (GameObject pBullet in pBullets) {
			Destroy (pBullet);
		}
		GameObject player = GameObject.Find ("Player_Ship");
		player.GetComponent<Renderer> ().enabled = false;
		PM.playerLoaded = false;



		GameObject[] barriers = GameObject.FindGameObjectsWithTag ("Barrier");
		foreach (GameObject barrier in barriers) {
			Destroy (barrier);
		}
		GameObject[] topEnemies = GameObject.FindGameObjectsWithTag ("Top_Enemy");
		foreach (GameObject topEnemy in topEnemies) {
			Destroy (topEnemy);
		}
		GameObject[] bullets = GameObject.FindGameObjectsWithTag ("Enemy_Bullet");
		foreach (GameObject bullet in bullets) {
			Destroy (bullet);
		}
		IM.enemyObject = null;
	}

	void BonusCheck ()
	{
		
		if (levelTimer <= 30.0f) {
			endTitle.text = "UNBELIEVABLE!";
			endTitle.fontSize = 36;
			endTitle.color = Color.green;
			bonusAmount = 2500;
			bonusUpdate = true;
		} else if (levelTimer <= 45.0f) {
			endTitle.text = "AWESOME!";
			bonusAmount = 1500;
			endTitle.color = Color.blue;
			bonusUpdate = true;
		} else if (levelTimer <= 90.0f) {
			endTitle.text = "WELL DONE";
			bonusAmount = 500;
			bonusUpdate = true;
		} else {
			endTitle.text = "GREAT";
			bonusScore.color = Color.red;
			bonusScore.text = "NO BONUS";

		}
		if (bonusUpdate == true) {
			bonusScore.text = bonusAmount.ToString ();
			score += bonusAmount;
			bonusUpdate = false;
		}
	}
	void PowerUpCheck(){
		if (PM.poweredUp) {
			GameObject shield = GameObject.Find ("Shield");
			if (shield != null) {
				shield.SetActive (false);
			}
		}


	}
	//Simple Ad
	public void ShowAd()
	{
		if (Advertisement.IsReady())
		{
			Advertisement.Show();
		}
	}
	//Rewarded Ads
	public void ShowRewardedAd()
	{
		if (Advertisement.IsReady("rewardedVideo"))
		{
			var options = new ShowOptions { resultCallback = HandleShowResult };
			Advertisement.Show("rewardedVideo", options);
		}
	}
		
	private void HandleShowResult(ShowResult result)
	{
		switch (result)
		{
		case ShowResult.Finished:
//			Debug.Log ("The ad was successfully shown.");
			Level (level);
			adShown = true;

			break;
		case ShowResult.Skipped:
//			Debug.Log("The ad was skipped before reaching the end.");
			Level (level);
			adShown = true;
			break;
		case ShowResult.Failed:
//			Debug.LogError("The ad failed to be shown.");
			Level (level);
			adShown = true;
			break;
		}
	}
}

