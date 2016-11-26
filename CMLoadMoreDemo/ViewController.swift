//
//  ViewController.swift
//  CMLoadMoreDemo
//
//  Created by Chaiyasit Tayabovorn on 12/28/2558 BE.
//  Copyright © 2558 Pantip. All rights reserved.
//

import UIKit
import Alamofire
import MapleBacon


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var mTableView:UITableView!
    var mDataArray:NSMutableArray = NSMutableArray()
    var mPageIndex = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mTableView.addLoadMoreActionHandler({ () -> Void in
            // handle event
            self.feedData()
            }, progressImagesGifName: "farmTruck@2x.gif", loadingImagesGifName: "bounce_sammy@2x.gif", progressScrollThreshold: 30)
        // Do any additional setup after loading the view, typically from a nib.
        
        self.feedData()
    }
    
    func feedData(){

        Alamofire.request(.GET, "http://sawaparrjewelry.com/pantipservice/image.php?page=\(mPageIndex)").responseJSON { (request, response, result) -> Void in
            if result.value != nil {
                let newData  = result.value as! NSArray;
                self.mDataArray.addObjectsFromArray(newData as [AnyObject])
                self.mPageIndex++
                self.mTableView.reloadData()
                self.mTableView.stopLoadMoreAnimation()
            }

        }
     
    }
    
    /*
    func addDummyData(){
        for index in self.mDataArray.count...(self.mDataArray.count+15) {
            self.mDataArray.insert(String(index), atIndex: index)
        }
        self.mTableView.reloadData()
        self.mTableView.stopLoadMoreAnimation()
        print(self.mDataArray.description)
    }
    */
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mDataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        let item = self.mDataArray[indexPath.row]
        cell?.textLabel?.text = item["title"] as? String
        let imageDict = item["image"] as! String
        let imageURL = NSURL(string: imageDict)
        cell?.imageView?.setImageWithURL(imageURL!)
        
        return cell!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

