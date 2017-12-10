using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
public class Popup : MonoBehaviour {
	private GameManager gm;
	private Rigidbody2D rb2d;
	private float minX,maxX;
	public float fadeDuration = 1.0f;
	private SpriteRenderer image;
	// Use this for initialization
	void Start () {
		gm = GameObject.Find("GameManager").GetComponent<GameManager>();
		rb2d = GetComponent<Rigidbody2D>();
		float camDistance = Vector3.Distance (transform.position, Camera.main.transform.position);
		Vector2 bottomCorner = Camera.main.ViewportToWorldPoint (new Vector3 (0, 0, camDistance));
		Vector2 topCorner = Camera.main.ViewportToWorldPoint (new Vector3 (1, 1, camDistance));

		minX = bottomCorner.x;
		maxX = topCorner.x;
		rb2d.velocity = Vector3.up *50*Time.deltaTime;
		image = gameObject.GetComponent<SpriteRenderer> ();
		StartCoroutine (Fade (1.0f, 0.0f, fadeDuration));
		Destroy (this.gameObject, fadeDuration);
	}



	private IEnumerator Fade (float startLevel, float endLevel, float time)
	{
		float speed = 1.0f/time;

		for (float t = 0.0f; t < 1.0; t += Time.deltaTime*speed)
		{
			float a = Mathf.Lerp(startLevel, endLevel, t);
			image.color = new Color(image.color.r,
				image.color.g,
				image.color.b, a);
			
			yield return 0;
		}
	}
}
