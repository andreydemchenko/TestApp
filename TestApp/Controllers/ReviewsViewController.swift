//
//  ReviewsViewController.swift
//  TestApp
//
//  Created by andreydem on 24.09.2022.
//

import UIKit

class ReviewsViewController: UIViewController {
    
    var result: ReviewResponse?
    lazy var reviews = [ReviewModel]()

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        let url = URL(string: "https://api.nytimes.com/svc/movies/v2/reviews/search.json?api-key=GW5a0tJfWOcfQ7k3dpQizIsrmpZ33Bmm")
        
        getData(from: url!)
        
    }
    
    private func getData(from url: URL) {
       
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                print("Something went wrong!")
                return
            }
            
            do {
                self.result = try JSONDecoder().decode(ReviewResponse.self, from: data)
            }
            catch {
                print("failed to convert \(error)")
            }
            
            guard let json = self.result else {
                return
            }
            
            self.reviews = json.results
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
    
        }
        
        task.resume()
        
    }
    
}

extension ReviewsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewCollectionViewCell", for: indexPath) as! ReviewCollectionViewCell
        cell.setup(with: (reviews[indexPath.row]))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        if UIDevice.current.orientation.isPortrait {
            return CGSize(width: width - 20, height: 240)
        } else if UIDevice.current.orientation.isLandscape {
            return CGSize(width: width / 3 - 20, height: 240)
        } else {
            return CGSize(width: width - 20, height: 240)
        }
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        if UIDevice.current.orientation.isLandscape,
                    let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                    let width = view.frame.width
                    layout.itemSize = CGSize(width: width / 3 - 20, height: 240)
                    layout.invalidateLayout()
                } else if UIDevice.current.orientation.isPortrait,
                    let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                    let width = view.frame.width
                    layout.itemSize = CGSize(width: width - 20, height: 240)
                    layout.invalidateLayout()
                }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(reviews[indexPath.row].display_title)
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailReviewViewController") as? DetailReviewViewController
        vc?.reviewDetails = reviews[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
 
