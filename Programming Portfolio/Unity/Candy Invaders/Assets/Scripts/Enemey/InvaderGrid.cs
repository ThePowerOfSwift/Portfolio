using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InvaderGrid : MonoBehaviour {

	private GameManager gm;
	private GameObject InvaderManager;
	private Invader_Manager IM;
	private Vector3 invaderPos;
	private Rigidbody2D rb2d;
	public bool moveDown;
	public string invaderDir;
	public GameObject enemyBullet01;
	public string moveType;


	void Start () {
		rb2d = GetComponent<Rigidbody2D> ();
		InvaderManager = GameObject.Find ("InvaderManager");
		IM = (Invader_Manager) InvaderManager.GetComponent(typeof(Invader_Manager));
		invaderDir = IM.invaderDirection;
		gm = GameObject.Find("GameManager").GetComponent<GameManager>();
	}

	void Update () {
		if (moveType == "Whole") {
			MoveGrid ();
		}

	}
	void MoveGrid()
	{
		if (gm.isRunning) {

			if (IM.invaderDirection == "Right") {
				rb2d.velocity = (Vector3.right * IM.invaderSpeed * Time.deltaTime);

			} else if (IM.invaderDirection == "Left") {
				rb2d.velocity = (Vector3.left * IM.invaderSpeed * Time.deltaTime);

			}
				
		} else {
			rb2d.velocity = Vector3.zero;
		}

	}
}
