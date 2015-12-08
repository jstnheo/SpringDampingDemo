//
//  ViewController.swift
//  AnimateUsingSpringDamping
//
//  Created by Justin Heo on 11/30/15.
//  Copyright © 2015 Justin Heo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var headerContainer: UIView!

    @IBOutlet weak var durationSlider: UISlider!
    @IBOutlet weak var springDampingSlider: UISlider!
    @IBOutlet weak var velocitySlider: UISlider!

    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var springDampingLabel: UILabel!
    @IBOutlet weak var velocityLabel: UILabel!

    @IBOutlet weak var animatingOptions: UISegmentedControl!

    @IBOutlet weak var animatingTableView: UITableView!

    var defaultValue: CGPoint!

    override func viewDidLoad() {
        super.viewDidLoad()

        defaultValue = animatingTableView.frame.origin
        setupSliders()

        presentTableView()
    }

    func updateLabels() {
        durationLabel.text = String(format: "%.1f", durationSlider.value)
        springDampingLabel.text = String(format: "%.1f", springDampingSlider.value)
        velocityLabel.text = String(format: "%.1f", velocitySlider.value)
    }

    private func moveOffScreen() {
        animatingTableView.frame.origin = CGPointMake(animatingTableView.frame.origin.x,
            animatingTableView.frame.origin.y + UIScreen.mainScreen().bounds.size.height)
    }

    func setupSliders() {
        durationSlider.addTarget(self, action: "updateLabels", forControlEvents: .ValueChanged)
        springDampingSlider.addTarget(self, action: "updateLabels", forControlEvents: .ValueChanged)
        velocitySlider.addTarget(self, action: "updateLabels", forControlEvents: .ValueChanged)
    }
    @IBAction func restartAnimation(sender: AnyObject) {
        presentTableView()
    }

    func presentTableView() {
        let duration = durationSlider.value
        let springDamping = CGFloat(springDampingSlider.value)
        let velocity = CGFloat(velocitySlider.value)

        var option: UIViewAnimationOptions?

        switch animatingOptions {
        case 1:
            option = .CurveEaseIn
        case 2:
            option = .CurveEaseOut
        case 3:
            option = .CurveEaseInOut
        case _:
            option = .CurveLinear
        }

        moveOffScreen()
        
        UIView.animateWithDuration(NSTimeInterval(duration), delay: 0,
            usingSpringWithDamping: springDamping,
            initialSpringVelocity: velocity, options: option!, animations: {
                self.animatingTableView.frame.origin = self.defaultValue
            }, completion: nil)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "None")
        cell.textLabel?.text = "Hello"
        return cell
    }
}
