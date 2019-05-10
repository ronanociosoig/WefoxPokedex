//
//  PokemonDetailViewController.swift
//  Wefox Pokedex
//
//  Created by Ronan on 10/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import UIKit
import Haneke

class PokemonDetailViewController: UIViewController {
    var presenter: PokemonDetailPresenting?
    
    var pokemonView: PokemonView?
    
    override func viewDidLoad() {
        guard let pokemonView = PokemonView.loadFromNib() else { return }

        view.addSubview(pokemonView)
        
        pokemonView.center = view.center
        var point = pokemonView.center
        let height = pokemonView.frame.size.height
        point.y = height/2
        pokemonView.center = point
        
        self.pokemonView = pokemonView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let presenter = presenter else { return }
        guard let pokemonView = pokemonView else { return }
        
        pokemonView.weight.text = presenter.weight()
        pokemonView.height.text = presenter.height()
        pokemonView.name.text = ""
        
        pokemonView.experience.isHidden = false
        pokemonView.experience.text = presenter.baseExperience()
        
        title = presenter.name().capitalized

        guard let imagePath = presenter.imagePath() else { return }
        guard let imageURL = URL(string: imagePath) else { return }
        pokemonView.imageView.hnk_setImage(from: imageURL)
    }
}

extension PokemonDetailViewController: PokemonDetailView {
    func setPokemon(name: String) {
        title = name
    }
}
