//
//  ViewController.swift
//  Project10
//
//  Created by Lawrence Dizon on 11/16/20.
//

import UIKit
//
//ViewController
//
class ViewController: UICollectionViewController {
    
    //
    //MARK:- ViewController Properties
    //
    
    
    //
    //MARK:- ViewController View States
    //

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //
    //MARK:- CollectionView Properties
    //
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
            
            fatalError("Unable to dequeue PersonCell.")
        }

        return cell
    }


}

