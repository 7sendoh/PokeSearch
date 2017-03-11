//
//  PokeCellCollectionViewCell.swift
//  pokedex3
//
//  Created by Ping Li on 2017-01-10.
//  Copyright © 2017 Ping Li. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokeId: Int = -1
    
    required init?(coder adecoder: NSCoder){
        super.init(coder: adecoder)
        layer.cornerRadius = 5.0
    }
    
    func configureCell(pokeId: Int, pokeName: String) {
        self.pokeId = pokeId
        nameLbl.text = pokeName.capitalized
        thumbImg.image = UIImage(named: "\(self.pokeId)")
    }
    
}
