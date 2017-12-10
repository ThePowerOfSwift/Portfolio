using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;
using UnityEngine.Advertisements;

public class Main_Menu : MonoBehaviour
{

	public int bestScore;
	public int lastScore;

	public Text bestScoreCount;
	public Text lastScoreCount;

	public GameObject HighScoresPanel;
	public Text[] HS;

	private GameObject Dreamlo;
	private dreamloLeaderBoard DL;

	public AudioClip buttonSound;
	private GameObject buttonSoundGO;
	private AudioSource bsAudio;

	void Start ()
	{
		buttonSoundGO = GameObject.Find ("ButtonSound");
		bsAudio = buttonSoundGO.GetComponent<AudioSource> ();
		bsAudio.clip = buttonSound;
		Dreamlo = GameObject.Find ("Dreamlo");
		DL = (dreamloLeaderBoard)Dreamlo.GetComponent(typeof(dreamloLeaderBoard));
		HighScoresPanel.SetActive (false);
		bestScore = PlayerPrefs.GetInt ("bestScore");
		lastScore = PlayerPrefs.GetInt ("lastScore");
		if (bestScore == 0) {
			bestScore = 0;
		}
		bestScoreCount.text = bestScore.ToString ();
		lastScoreCount.text = lastScore.ToString ();
		DL.LoadScores ();
	}

	public void LoadGame ()
	{
		bsAudio.Play ();
		SceneManager.LoadScene ("Main");
	}

	public void HighScores(){
		bsAudio.Play ();
		if (Application.internetReachability == NetworkReachability.NotReachable) {
			Debug.Log ("Error. Check internet connection!");
			HS[0].text = "NO INTERNET CONNECTION";
			HighScoresPanel.SetActive (true);
		} else {
			List<dreamloLeaderBoard.Score> scoreList = DL.ToListHighToLow ();
			if (scoreList.Count < 1) {
				HS [0].text = "NO HIGHSCORES!";
				HighScoresPanel.SetActive (true);
			} else {
				int maxToDisplay = 10;
				int count = 0;
				foreach (dreamloLeaderBoard.Score currentScore in scoreList) {
					
					HS [count].text = currentScore.playerName + " ... " + currentScore.score.ToString ();
					if (count >= maxToDisplay) {

						break;
					}
					count++;
					HighScoresPanel.SetActive (true);
				}
			}

		}

	}
	public void HighScoreOK(){
		bsAudio.Play ();
		HighScoresPanel.SetActive (false);
	}
}
