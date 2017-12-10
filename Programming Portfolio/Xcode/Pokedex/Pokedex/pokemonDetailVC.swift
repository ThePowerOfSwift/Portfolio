//
//  pokemonDetailVC.swift
//  Pokedex
//
//  Created by Kel Robertson on 29/09/2016.
//  Copyright © 2016 Kel Robertson. All rights reserved.
//

import UIKit
import AVFoundation

class pokemonDetailVC: UIViewController {

    var pokemon: Pokemon!
    var player: AVAudioPlayer!
    
    var isMPlaying: Bool!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var pokedexIDLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var evoLabel: UILabel!
    @IBOutlet weak var currentEvoImage: UIImageView!
    @IBOutlet weak var nextEvoImage: UIImageView!
    @IBOutlet weak var musicButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = pokemon.name.capitalized
        let image = UIImage(named: "\(pokemon.pokedexId)")
            mainImage.image = image
            currentEvoImage.image = image
            pokedexIDLabel.text = "\(pokemon.pokedexId)"
        musicButtonUI()
        
        pokemon.downloadPokemonDetails {
            
            
            self.updateUI()
        }
    }
    func musicButtonUI () {
        if isMPlaying == true {
            musicButton.alpha = 1
        } else {
            musicButton.alpha = 0.5
        }
    }

    func updateUI() {
        
        attackLabel.text = pokemon.attack
        defenseLabel.text = pokemon.defense
        heightLabel.text = pokemon.height
        weightLabel.text = pokemon.weight
        typeLabel.text = pokemon.type
        descriptionLabel.text = pokemon.description
        
        if pokemon.nextEvolutionID == "" {
            nextEvoImage.isHidden = true

            evoLabel.text = "No Evolutions"
            
        } else {
            nextEvoImage.isHidden = false
            nextEvoImage.image = UIImage(named: pokemon.nextEvolutionID)
            let evoString = "Next Evolution: \(pokemon.nextEvolutionName) - Lvl \(pokemon.nextEvolutionLvl)"
            evoLabel.text = evoString
        }
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        musicButtonUI()
    }
   
    @IBAction func musicButtonPressed(_ sender: UIButton) {
    
        if player.isPlaying {
            player.pause()
            isMPlaying = false
            musicButtonUI()
        } else {
            player.play()
            isMPlaying = true
            musicButtonUI()
        }
    }
    
}
