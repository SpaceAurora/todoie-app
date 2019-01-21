//
//  WelcomingViewModel.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/21/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import Foundation

class WelcomingViewModel {
    
    // Bindings
    var dataArray = Bindable<[PageViewModel]>()
    var nextButtonText = Bindable<(String,Bool)>()
    var currentPage = Bindable<Int>()
    var currentIndexPath = Bindable<IndexPath>()
    
    // Generates the Pages that are going to be on display
    func generatePages() {
        dataArray.value = getPages().map { (page) -> PageViewModel in
            page.toViewModel()
        }
    }
    
    // handles the nextbutton press.
    func handleNext(page: Int) {
        let nextPage = page + 1
        
        // checks if we are still withing the limit
        if nextPage != dataArray.value?.count {
            // creates a new index path for the collectionView
            let indexPath = IndexPath(item: nextPage, section: 0)
            currentPage.value = nextPage
            currentIndexPath.value = indexPath
        }
        changeText()
    }
    // Handles the change of the currentPage Value and calls the change text function
    func handleSwipeChange(withValue page: Int) {
        currentPage.value = page
        changeText()
    }
    
    // Handles the change that will happen to the nextbutton when pressed
    private func changeText() {
        let page = currentPage.value ?? 0
        if page + 1 == dataArray.value?.count {
            nextButtonText.value = ("Start", true)
        } else {
            nextButtonText.value = ("Next", false)
        }
    }
}

// returns a Pages array
func getPages() -> [Page] {
    let firstPage = [
        Word(word: "Create\n", isHighlighted: false),
        Word(word: "Tasks ", isHighlighted: true),
        Word(word: "& ", isHighlighted: false),
        Word(word: "Events", isHighlighted: true)]
    let secondPage = [
        Word(word: "Remind ", isHighlighted: true),
        Word(word: "Others\n", isHighlighted: false),
        Word(word: "&\n", isHighlighted: false),
        Word(word: "Be ", isHighlighted: false),
        Word(word: "Reminded", isHighlighted: true)]
    let thirdPage = [
        Word(word: "Track ", isHighlighted: false),
        Word(word: "Your\n", isHighlighted: false),
        Word(word: "Productivity", isHighlighted: true)]
    
     return [
        Page(image: #imageLiteral(resourceName: "Welcome1"), title: firstPage, description: "Create tasks and events, all in one place. Plan your whole day and let us micromanage your day for the best effeciency and productivity", textColor: .blueTodoieColor, lineColor: .todoiePurple),
        Page(image: #imageLiteral(resourceName: "Welcome2"), title: secondPage, description: "Smart reminders notify when it’s time for an event or a task to be done. Quickly set reminds for others too, so they dont have an excuse.", textColor: .todoieDustyBlue, lineColor: .todoiePink),
        Page(image: #imageLiteral(resourceName: "Welcome3"), title: thirdPage, description: "Log in the status of your tasks and let us carry the weight of providing the complete productivity analysis within the desired periods", textColor: .blueTodoieColor, lineColor: .todoieLightGreen),
        ]
}
