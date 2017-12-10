using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public class PointerEventRight : MonoBehaviour, IPointerDownHandler, IPointerUpHandler {

	private GameObject player;
	private PlayerShip playerScript;
	private Player_Manager PM;
	private GameManager gm;
	private GameObject PlayerManager;

	void Awake() {
		gm = GameObject.Find("GameManager").GetComponent<GameManager>();
		PlayerManager = GameObject.Find ("PlayerManager");
		PM = (Player_Manager)PlayerManager.GetComponent (typeof(Player_Manager));
	}
	void Update(){
		if (PM.playerLoaded) {
			player = GameObject.Find("Player_Ship");
			playerScript = (PlayerShip) player.GetComponent(typeof(PlayerShip));
		}

	}
	public void OnPointerDown(PointerEventData eventData)
	{
		if (gm.isRunning) {
			playerScript.moveRightDown ();
		}

	}

	public void OnPointerUp(PointerEventData eventData)
	{
			playerScript.moveRightUp ();
	}
}
