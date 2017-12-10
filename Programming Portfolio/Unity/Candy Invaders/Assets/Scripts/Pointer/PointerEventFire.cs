using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public class PointerEventFire : MonoBehaviour, IPointerDownHandler, IPointerUpHandler
{

	private GameManager gm;
	private GameObject player;
	private PlayerShip playerScript;
	private Player_Manager PM;
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

	void FixedUpdate ()
	{


	}

	void Fire ()
	{
		playerScript.fireBullet ();
	}

	public void OnPointerDown (PointerEventData eventData)
	{
		if (PM.rapidShot) {
			PM.playerBulletLimit = 30;
			InvokeRepeating ("Fire", 0.0f, 0.2f);
		} else {
			Fire ();
		}


	}

	public void OnPointerUp (PointerEventData eventData)
	{
		CancelInvoke ();
	}
}
