class SearchesController < ApplicationController
    def search
      word = params[:search]
      @mensore_ranks = Mensore.where('title LIKE ? OR body LIKE ?', "%#{word}%", "%#{word}%").includes(:bookmarkd_users).sort {|a,b| b.bookmarkd_users.size <=> a.bookmarkd_users.size}
    end
    #@datasに最終的な検索結果が入ります

    private

    def match(model, value)
      if model == 'user' 
        User.where(name: value) 
      elsif model == 'mensore'
        Mensore.where(title: value)
      end
    end

    def forward(model, value)
      if model == 'User'
        User.where("name LIKE ?", "#{value}%")
      elsif model == 'mensore'
        Mensore.where("title LIKE ?", "#{value}%")
      end
    end

    def mensoreward(model, value)
      if model == 'user'
        User.where("name LIKE ?", "%#{value}")
      elsif model == 'mensore'
        Mensore.where("title LIKE ?", "%#{value}")
      end
    end

    def partical(model, value)
      if model == 'user'
        User.where("name LIKE ?", "%#{value}%")
      elsif model == 'mensore'
        Mensore.where("title LIKE ?", "%#{value}%")
      end
    end

    def search_for(how, model, value)#searchアクションで定義した情報が引数に入っている
      case how #検索方法のhowの中身がどれなのかwhenの条件分岐の中から探す処理
      when 'match'
        match(model, value) #検索方法の引数に(model, value)を定義している
      when 'forward' #例えばhowがmatchの場合は def match の処理に進みます
        forward(model, value)
      when 'backward'
        backward(model, value)
      when 'partical'
        partical(model, value)
      end
    end
end
