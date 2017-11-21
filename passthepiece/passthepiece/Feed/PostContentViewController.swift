//
//  PostContentViewController.swift
//  passthepiece
//
//  Created by brianna on 11/19/17.
//  Copyright © 2017 brianna. All rights reserved.
//

import UIKit

class PostContentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var post: Post!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "StrainCell")
                cell?.detailTextLabel?.text = post.strain ?? "No Strain"
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "PostBodyCell") as! PostBodyTableViewCell
                cell.bodyTextLabel.text = post.caption
            default:
                return UITableViewCell()
            }
        default:
            return UITableViewCell()
        }
        
        fatalError()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return post.comments.count
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
