//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Mehmet Özkan on 18.09.2023.
//

import Foundation

struct NewsTableViewModel {
    
    let newsList: [News]
    
   
}

extension NewsTableViewModel {
    
    func numberOfRowsInsection() -> Int {
        return self.newsList.count
    }
    
    func newsAtIndexPat(_ index: Int) -> NewsViewModel {
        let news = self.newsList[index]
        return NewsViewModel(news: news)
    }
    
}


struct NewsViewModel {
    
    let news: News
    
    var title: String {
        return self.news.title
    }
    
    var story: String {
        return self.news.story
    }
}


