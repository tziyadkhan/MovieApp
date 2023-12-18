//
//  PeopleInfoController.swift
//  MovieApp
//
//  Created by Ziyadkhan on 18.12.23.
//

import UIKit

class PeopleInfoController: UIViewController {
    
    @IBOutlet weak var peopleInfoCollection: UICollectionView!
    
    let viewModel = PeopleInfoViewModel()
    var selectedID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureXib()
        configureViewModel()
    }
    
}

extension PeopleInfoController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.peopleInfoItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = viewModel.peopleInfoItems[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopImageBottomLabelCell", for: indexPath) as! TopImageBottomLabelCell
        cell.movieTitleLabel.text = item.title
        cell.movieImage.showImage(imageURL: item.backdropPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "MovieInfoController") as! MovieInfoController
        controller.selectedID = viewModel.peopleInfoItems[indexPath.item].id
        navigationController?.show(controller, sender: nil)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width/2-10, height: 280)
    }
}


// MARK: Functions
extension PeopleInfoController {
    
    func configureViewModel() {
        viewModel.error = { error in
            print(error)
        }
        viewModel.sucess = {
            self.peopleInfoCollection.reloadData()
//            print(self.viewModel.peopleInfoItems)
        }
        viewModel.getPeopleInfoItems(peopleID: selectedID)
    }
    
    func configureXib() {
        peopleInfoCollection.register(UINib(nibName: "TopImageBottomLabelCell", bundle: nil),forCellWithReuseIdentifier: "TopImageBottomLabelCell")
    }
}