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

    fileprivate func moveOffScreen() {
        animatingTableView.frame.origin = CGPoint(x: animatingTableView.frame.origin.x,
            y: animatingTableView.frame.origin.y + UIScreen.main.bounds.size.height)
    }

    func setupSliders() {
        durationSlider.addTarget(self, action: #selector(ViewController.updateLabels), for: .valueChanged)
        springDampingSlider.addTarget(self, action: #selector(ViewController.updateLabels), for: .valueChanged)
        velocitySlider.addTarget(self, action: #selector(ViewController.updateLabels), for: .valueChanged)
    }
    @IBAction func restartAnimation(_ sender: AnyObject) {
        presentTableView()
    }

    func presentTableView() {
        let duration = durationSlider.value
        let springDamping = CGFloat(springDampingSlider.value)
        let velocity = CGFloat(velocitySlider.value)

        var option: UIViewAnimationOptions?

        switch animatingOptions.selectedSegmentIndex {
        case 1:
            option = .curveEaseIn
        case 2:
            option = .curveEaseOut
        case 3:
            option = UIViewAnimationOptions()
        case _:
            option = .curveLinear
        }

        moveOffScreen()
        
        UIView.animate(withDuration: TimeInterval(duration), delay: 0,
            usingSpringWithDamping: springDamping,
            initialSpringVelocity: velocity, options: option!, animations: {
                self.animatingTableView.frame.origin = self.defaultValue
            }, completion: nil)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "None")
        cell.textLabel?.text = "Hello"
        return cell
    }
}
