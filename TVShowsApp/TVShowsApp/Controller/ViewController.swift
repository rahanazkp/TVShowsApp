//
//  ViewController.swift
//  TVShowsApp
//
//  Created by hipoint on 9/23/21.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    @IBOutlet weak var videoCollection: UICollectionView!

    var videoshows = [VideoShow]()
    var showObj: VideoShow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchDataFromApi()
    }
    
    func fetchDataFromApi() {
        let urlString = "https://api.tvmaze.com/shows?page=1"

            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    parse(json: data)
                }
            }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonVideoShows = try? decoder.decode([VideoShow].self, from: json) {
            videoshows = jsonVideoShows
            DispatchQueue.main.async {
                self.videoCollection.reloadData()
            }
        }
    }
    
    func showAlert(msg:String) {
        
        let alert = UIAlertController(title: "Rating" , message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "vcToDetail" {
            if let DetailViewVC = segue.destination as? DetailViewVC {
                DetailViewVC.showObj = showObj
                DetailViewVC.callback = { rateVal in
                    self.showAlert(msg: rateVal)
                }
            }
        }
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoshows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let videoShow = self.videoshows[indexPath.row] as? VideoShow else {
            return UICollectionViewCell()
        }
        let cell:videoShowCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoShowCollectionCell", for: indexPath)as! videoShowCollectionCell
        cell.showTitle.text = videoShow.name
        cell.showImage.sd_setImage(with: URL(string: videoShow.image["medium"] ?? ""), completed: nil)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        let yourWidth = videoCollection.bounds.width/2.0
        let yourHeight = yourWidth
        return CGSize(width: yourWidth, height: yourHeight)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return  0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return  0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let obj = self.videoshows[indexPath.row] as? VideoShow {
            showObj = obj
            self.performSegue(withIdentifier: "vcToDetail", sender: self)
        }
    }
}
