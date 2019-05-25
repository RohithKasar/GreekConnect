//
//  SignUpViewController.swift
//  greekConnect
//
//  Created by Rohith Kasar on 4/23/19.
//  Copyright © 2019 rohith.kasar. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    
    var org = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AppDelegate.AppUtility.lockOrientation(.portrait)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        AppDelegate.AppUtility.lockOrientation(.all)
    }
    
    @IBAction func fratPicked(_ sender: Any) {
        org = "frat"
        performSegue(withIdentifier: "gender", sender: self)
    }
    
    @IBAction func sorPicked(_ sender: Any) {
        org = "sorority"
        performSegue(withIdentifier: "gender", sender: self)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let orgViewController = segue.destination as! OrgPickerViewController
        orgViewController.org = org
        
        
    }
    

}
