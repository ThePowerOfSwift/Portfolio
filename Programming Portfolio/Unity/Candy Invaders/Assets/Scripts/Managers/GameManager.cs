using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;
using UnityEngine.Advertisements;

public class GameManager : MonoBehaviour
{
	private GameObject InvaderManager;
	private Invader_Manager IM;
	private GameObject LevelManager;
	private Level_Manager LM;
	private Player_Manager PM;
	private GameObject PlayerManager;

	public int currentLevel;
	public int score;
	public int lives;

	public bool configure;
	public bool startGame;
	public bool isRunning;
	public bool nextLevel;
	public bool isDead;
	public bool gameOver;
	public bool wonGame;


	void Awake ()
	{
		InvaderManager = GameObject.Find ("InvaderManager");
		LevelManager = GameObject.Find ("LevelManager");
		PlayerManager = GameObject.Find ("PlayerManager");
		PM = (Player_Manager)PlayerManager.GetComponent (typeof(Player_Manager));
		LM = (Level_Manager)LevelManager.GetComponent (typeof(Level_Manager));
		IM = (Invader_Manager) InvaderManager.GetComponent(typeof(Invader_Manager));

	}

	void Start ()
	{
		LM.Level (1);
	}

	void Update ()
	{
		if (isRunning) {
			LM.CheckGameStatus ();
		}
		if (gameOver) {
			LM.GameOver ();
			gameOver = false;
		}
		if (nextLevel) {
			LM.NextLevel ();
			nextLevel = false;
		}

			
	}
		
	public void RestartLevel(){
		if (LM.paused) {
			
			LM.Unpause ();
		} else {
			SceneManager.LoadScene("Main");
		}

	}
	public void ExitLevel(){
		ShowAd ();
		SceneManager.LoadScene("Menu");

	}
		
	//Simple Ad
	public void ShowAd()
	{
		if (Advertisement.IsReady())
		{
			Advertisement.Show();
		}
	}

}
