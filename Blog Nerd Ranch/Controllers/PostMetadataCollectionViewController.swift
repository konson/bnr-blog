//
//  PostMetadataCollectionViewController.swift
//  Blog Nerd Ranch
//
//  Created by Chris Downie on 8/28/18.
//  Copyright © 2018 Chris Downie. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PostMetadataCollectionViewCell"

enum MetadataError : Error {
    case missingData
    case unableToDecodeData
}

class PostMetadataCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var server = Servers.mock
    var downloadTask : URLSessionTask?
    var orderingController = PostMetadataOrderingController(ordering: DisplayOrdering(grouping: .none, sorting: .byPublishDate(recentFirst: true)))
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    fileprivate let itemsPerRow: CGFloat = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.register(UINib(nibName: "PostMetadataCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
//        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
//            flowLayout.estimatedItemSize = CGSize(width: 400, height: 270)
//        }

        // Do any additional setup after loading the view.
        title = "Blog Nerd Ranch"
        fetchPostMetadata()
    }
    
    // MARK: Actions
    @IBAction func groupByTapped(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: nil, message: "Group the posts by...", preferredStyle: .actionSheet)
        
        let groupByAuthorAction = UIAlertAction(title: "Author", style: .default) { [weak self] _ in
            self?.update(grouping: .byAuthor)
        }
        let groupByMonthAction = UIAlertAction(title: "Month", style: .default) { [weak self] _ in
            self?.update(grouping: .byMonth)
        }
        let noGroupAction = UIAlertAction(title: "No Grouping", style: .default) { [weak self] _ in
            self?.update(grouping: .none)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(groupByAuthorAction)
        alertController.addAction(groupByMonthAction)
        alertController.addAction(noGroupAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func sortTapped(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: nil, message: "Sort the posts by...", preferredStyle: .actionSheet)
        
        let sortByAuthorAscendingAction = UIAlertAction(title: "Author from A to Z", style: .default) { [weak self] _ in
            self?.update(sorting: .alphabeticalByAuthor(ascending: true))
        }
        let sortByAuthorDescendingAction = UIAlertAction(title: "Author from Z to A", style: .default) { [weak self] _ in
            self?.update(sorting: .alphabeticalByAuthor(ascending: false))
        }
        let sortByTitleAscendingAction = UIAlertAction(title: "Title from A to Z", style: .default) { [weak self] _ in
            self?.update(sorting: .alphabeticalByTitle(ascending: true))
        }
        let sortByTitleDescendingAction = UIAlertAction(title: "Title from Z to A", style: .default) { [weak self] _ in
            self?.update(sorting: .alphabeticalByTitle(ascending: false))
        }
        let sortByDateAscendingAction = UIAlertAction(title: "Chronologically", style: .default) { [weak self] _ in
            self?.update(sorting: .byPublishDate(recentFirst: false))
        }
        let sortByDateDescendingAction = UIAlertAction(title: "Recent Posts First", style: .default) { [weak self] _ in
            self?.update(sorting: .byPublishDate(recentFirst: true))
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(sortByAuthorAscendingAction)
        alertController.addAction(sortByAuthorDescendingAction)
        alertController.addAction(sortByTitleAscendingAction)
        alertController.addAction(sortByTitleDescendingAction)
        alertController.addAction(sortByDateAscendingAction)
        alertController.addAction(sortByDateDescendingAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    // this updates Display Ordering to the new group selection but preserves the sorting selection
    func update(grouping: Grouping) {
        let oldSorting = orderingController.ordering.sorting
        orderingController.ordering = DisplayOrdering(grouping: grouping, sorting: oldSorting)
        collectionView?.reloadData()
    }
    
    // this updates Display Ordering to the new sorting selection but preserves the grouping selection
    func update(sorting: Sorting) {
        let oldGrouping = orderingController.ordering.grouping
        orderingController.ordering = DisplayOrdering(grouping: oldGrouping, sorting: sorting)
        collectionView?.reloadData()
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return orderingController.groups.count
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orderingController.groups[section].postMetadata.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PostMetadataCollectionViewCell
        let group = orderingController.groups[indexPath.section]
        let metadataum = group.postMetadata[group.postMetadata.startIndex.advanced(by: indexPath.item)]
        let url = server.postMetadataImageUrlFor(imageUrlString: metadataum.author.image)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let publishDateString = dateFormatter.string(from: metadataum.publishDate as Date)
        
        // Configure the cell
        cell.titleLabel.text = metadataum.title
        cell.publishDateLabel.text = publishDateString
        cell.summaryLabel.text = metadataum.summary
        cell.authorNameLabel.text = metadataum.author.name
        cell.authorTitleLabel.text = metadataum.author.title
        cell.imageURL = url
        cell.setAuthorImage()
    
        return cell
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: "PostHeaderReusableView",
                                                                     for: indexPath) as! PostHeaderReusableView
        
        header.sectionHeaderLabel.text = orderingController.groups[indexPath.section].name

        return header
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let postMetadata = orderingController.groups[indexPath.section].postMetadata[indexPath.item]
        
        let url = server.postUrlFor(id: postMetadata.postId)

        if downloadTask?.progress.isCancellable ?? false {
            downloadTask?.cancel()
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            guard error == nil else {
                self?.displayError(error: error!)
                return
            }
            guard let data = data else {
                self?.displayError(error: MetadataError.missingData)
                return
            }
            
            let post : Post?
            let decoder = JSONDecoder();
            decoder.dateDecodingStrategy = .iso8601
            do {
                post = try decoder.decode(Post.self, from: data)
            } catch {
                self?.displayError(error: error)
                return
            }
            
            let selectedPost = post
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let postController = storyboard.instantiateViewController(withIdentifier: "PostViewController") as! PostViewController
            postController.post = selectedPost
            
            DispatchQueue.main.async {
                self?.navigationController?.pushViewController(postController, animated: true)
            }
        }
        task.resume()
        downloadTask = task
    }

    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    // Mark: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: 270)
    }

    
    // MARK: - Data methods
    func fetchPostMetadata() {
        let url = server.allPostMetadataUrl
        
        if downloadTask?.progress.isCancellable ?? false {
            downloadTask?.cancel()
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard error == nil else {
                self?.displayError(error: error!)
                return
            }
            guard let data = data else {
                self?.displayError(error: MetadataError.missingData)
                return
            }
            let metadataList : [PostMetadata]?
            let decoder = JSONDecoder();
            decoder.dateDecodingStrategy = .iso8601
            do {
                metadataList = try decoder.decode(Array.self, from: data)
            } catch {
                self?.displayError(error: error)
                return
            }
            
            if let list = metadataList {
                self?.orderingController.postMetadataList = list
            }
            
            DispatchQueue.main.async {
                self?.collectionView?.reloadData()
            }
        }
        task.resume()
        downloadTask = task
        
    }
    
    func displayError(error: Error) {
        print("Error: \(error.localizedDescription)")
    }
    
}
