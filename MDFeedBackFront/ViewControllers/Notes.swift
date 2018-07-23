//
//  Notes.swift
//  MDFeedBackFront
//
//  Created by Андрей Васильев on 19.07.2018.
//  Copyright © 2018 Андрей Васильев. All rights reserved.
//

//let myCellIndef = "myCellIndef"

//@IBOutlet weak var myTableView: UITableView!


//extension MessageViewController: MDFeedBackDelegate, UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: myCellIndef, for: indexPath)
//
//        return cell
//    }
//
//    func getMDFeedBacksLoaded(_ response: DataResponse<Any>?) {
//        mdFeedBackManager.getMDFeedBacksLoaded(response)
//
//        myTableView.beginUpdates()
//        myTableView.insertRows(at: [IndexPath(row: mdFeedBackManager.mdFeedBacks.count - 1, section: 0)], with: .automatic)
//        myTableView.endUpdates()
//
//        for index in 0..<mdFeedBackManager.mdFeedBacks.count {
//            myTableView.cellForRow(at: IndexPath(row: index, section: 0))?.textLabel?.numberOfLines = 2
//            myTableView.cellForRow(at: IndexPath(row: index, section: 0))?.textLabel?.text =
//            "\(mdFeedBackManager.mdFeedBacks[index].firstName) " +
//            "\(mdFeedBackManager.mdFeedBacks[index].lastName)\n" +
//            "\(mdFeedBackManager.mdFeedBacks[index].text)"
//        }
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80.0
//    }
//
//    func getMDFeedBackLoaded(_ response: DataResponse<Any>?) {
//        mdFeedBackManager.getMDFeedBackLoaded(response)
//    }
//
//    func postMDFeedBackLoaded(_ response: DataResponse<Any>?) {
//        mdFeedBackManager.postMDFeedBackLoaded(response)
//    }
//
//    func editMDFeedBackLoaded(_ response: DataResponse<Any>?) {
//        mdFeedBackManager.editMDFeedBackLoaded(response)
//    }
//
//    func deleteMDFeedBackLoaded(_ response: DataResponse<Any>?) {
//        mdFeedBackManager.deleteMDFeedBackLoaded(response)
//    }
//}

//    var view1: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
//        view.backgroundColor = UIColor.red
//        return view
//    }()
//
//    var view2: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
//        view.backgroundColor = UIColor.blue
//        return view
//    }()

//    var viewRed: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = UIColor.red
//        return view
//    }()
//
//    var viewBlue: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = UIColor.blue
//        return view
//    }()

//view.addSubview(viewRed)
//view.addSubview(viewBlue)
//
//        let viewVFL = ["viewRed": viewRed, "viewBlue": viewBlue]
//        let metrics = ["height": 100, "width": self.view.bounds.size.width / 3, "top": 100]
//
//        self.view.addConstraints(NSLayoutConstraint.constraints(
//            withVisualFormat: "V:|-top-[viewRed(height)]|",
//            options: [],
//            metrics: metrics,
//            views: viewVFL))
//
//        self.view.addConstraints(NSLayoutConstraint.constraints(
//            withVisualFormat: "V:|-top-[viewBlue(height)]|",
//            options: [],
//            metrics: metrics,
//            views: viewVFL))
//
//        self.view.addConstraints(NSLayoutConstraint.constraints(
//            withVisualFormat: "H:|-[viewRed(width)]-(50)-[viewBlue(width)]-|",
//            options: [],
//            metrics: metrics,
//            views: viewVFL))

//        view.addSubview(view1)
//        view.addSubview(view2)

//        createView1Constraint()
//        createView2Constraint()

//createViewRedConstraint()
//createViewBlueConstraint()

//    func createViewRedConstraint() {
//        viewRed.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
//        viewRed.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
//        viewRed.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        viewRed.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//    }
//
//    func createViewBlueConstraint() {
//        viewBlue.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
//        viewBlue.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
//        viewBlue.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        viewBlue.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//    }

//    func createView1Constraint() {
//        NSLayoutConstraint(
//            item: view1,
//            attribute: .leading,
//            relatedBy: .equal,
//            toItem: view,
//            attribute: .leadingMargin,
//            multiplier: 1,
//            constant: 0).isActive = true
//        NSLayoutConstraint(
//            item: view1,
//            attribute: .trailing,
//            relatedBy: .equal,
//            toItem: view,
//            attribute: .trailingMargin,
//            multiplier: 1,
//            constant: 0).isActive = true
//        NSLayoutConstraint(
//            item: view1,
//            attribute: .top,
//            relatedBy: .equal,
//            toItem: view,
//            attribute: .topMargin,
//            multiplier: 1,
//            constant: 88).isActive = true
//        NSLayoutConstraint(
//            item: view1,
//            attribute: .height,
//            relatedBy: .equal,
//            toItem: view,
//            attribute: .width,
//            multiplier: 1,
//            constant: 0).isActive = true
//    }

//    func createView1Constraint() {
//        NSLayoutConstraint(
//            item: view1,
//            attribute: .centerX,
//            relatedBy: .equal,
//            toItem: view,
//            attribute: .centerX,
//            multiplier: 1,
//            constant: 0).isActive = true
//        NSLayoutConstraint(
//            item: view1,
//            attribute: .centerY,
//            relatedBy: .equal,
//            toItem: view,
//            attribute: .centerY,
//            multiplier: 1,
//            constant: 0).isActive = true
//        NSLayoutConstraint(
//            item: view1,
//            attribute: .width,
//            relatedBy: .equal,
//            toItem: nil,
//            attribute: .notAnAttribute,
//            multiplier: 1,
//            constant: 200).isActive = true
//        NSLayoutConstraint(
//            item: view1,
//            attribute: .height,
//            relatedBy: .equal,
//            toItem: nil,
//            attribute: .notAnAttribute,
//            multiplier: 1,
//            constant: 200).isActive = true
//    }

//    func createView2Constraint() {
//        NSLayoutConstraint(
//            item: view2,
//            attribute: .centerX,
//            relatedBy: .equal,
//            toItem: view1,
//            attribute: .centerX,
//            multiplier: 1,
//            constant: 0).isActive = true
//        NSLayoutConstraint(
//            item: view2,
//            attribute: .bottom,
//            relatedBy: .equal,
//            toItem: view1,
//            attribute: .top,
//            multiplier: 1,
//            constant: -8).isActive = true
//        NSLayoutConstraint(
//            item: view2,
//            attribute: .width,
//            relatedBy: .equal,
//            toItem: nil,
//            attribute: .notAnAttribute,
//            multiplier: 1,
//            constant: 100).isActive = true
//        NSLayoutConstraint(
//            item: view2,
//            attribute: .height,
//            relatedBy: .equal,
//            toItem: nil,
//            attribute: .notAnAttribute,
//            multiplier: 1,
//            constant: 100).isActive = true
//    }

//let button = UIButton(frame: CGRect(
//    x: 0, y: 0,
//    width: 160, height: 40))
//
//button.center = self.view.center
//
//button.layer.cornerRadius = button.frame.size.height / 2
//button.backgroundColor = UIColor.white
//button.setTitleColor(UIColor.black, for: .normal)
//button.setTitleColor(UIColor.orange, for: .highlighted)
//button.setTitle("Hello world", for: .normal)
//
//self.view.addSubview(button)