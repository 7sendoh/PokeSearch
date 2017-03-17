//
//  UIPresentationController.swift
//  PokeSearch
//
//  Created by Ping Li on 2017-02-20.
//  Copyright © 2017 Ping Li. All rights reserved.
//

import UIKit
import AVFoundation

//Screen to show pokemon selections, the selected pokemon will be shown on the map
class UIPresentationController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var filteredPokemon = [Int: String]()   //Pokemon that is filtered based on search
    var inSearchMode = false
    var selectedPokeId = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
    }

    //Show pokemons in collectionView based on search filter
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell{
            if inSearchMode {
                let sortedFilteredArray = filteredPokemon.sorted(by: { $0.key < $1.key})

                let pokeId = sortedFilteredArray[indexPath.row].key
                if let pokeName = pokemon[pokeId]
                {
                    cell.configureCell(pokeId: pokeId, pokeName: pokeName)
                }
            }else{
                if let pokeName = pokemon[indexPath.row + 1]
                {
                    cell.configureCell(pokeId: indexPath.row + 1, pokeName: pokeName)
                }
            }
            return cell
        }else{
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(inSearchMode){
            return filteredPokemon.count
        }
        return pokemon.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)   //Hide keyboard
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            collection.reloadData()
            view.endEditing(true)
        }else{
            inSearchMode = true
            filteredPokemon = [Int: String]()   //new empty array
            let lower = searchBar.text!.lowercased()
            //Filter the pokemon based on search and store them into the list
            let filteredPokeArray = pokemon.filter({$0.value.range(of: lower) != nil})
            for result in filteredPokeArray {
                filteredPokemon[result.key] = result.value
            }
            collection.reloadData()
        }
    }
    
    //Pass selected pokemon id to main
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if inSearchMode{
            let sortedFilteredArray = filteredPokemon.sorted(by: { $0.key < $1.key})
            selectedPokeId = sortedFilteredArray[indexPath.row].key
        }else{
            selectedPokeId = indexPath.row + 1
        }
        performSegue(withIdentifier: "unwindFromPresentationVC", sender: selectedPokeId)
    }

}
