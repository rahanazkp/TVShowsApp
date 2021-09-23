//
//  DetailViewVC.swift
//  TVShowsApp
//
//  Created by hipoint on 9/23/21.
//

import UIKit
import Cosmos

class DetailViewVC: UIViewController {

    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var premierLbl: UILabel!
    @IBOutlet weak var runLbl: UILabel!
    @IBOutlet weak var officialLbl: UILabel!
    @IBOutlet weak var urlLbl: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    
    
    var showObj: VideoShow!
    var callback : ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        laodValues()
    }
    
    func laodValues() {
        detailImage.sd_setImage(with: URL(string: showObj.image["medium"] ?? ""), completed: nil)
        descriptionLbl.attributedText = showObj.summary.htmlToAttributedString
        statusLbl.text = "Status : \(showObj.status)"
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        let showDate = inputFormatter.date(from: showObj.premiered)
        inputFormatter.dateFormat = "MMM dd, yyyy"
        let resultString = inputFormatter.string(from: showDate!)
        
        premierLbl.text = "Premiered Date : \(resultString)"
        runLbl.text = "Run Time : \(String(showObj.runtime))"
        officialLbl.text = "Official Site : \(showObj.officialSite)"
        urlLbl.text = "Url : \(showObj.url)"
        
        ratingView.didFinishTouchingCosmos = {
            rating in
            print("Rating given :\(rating)")
            self.navigationController?.popViewController(animated: false)
            self.callback?(String(rating))
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
