class User < ActiveRecord::Base
  has_many :articles, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", 
                           dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  

  authenticates_with_sorcery!

  before_save { self.email = email.downcase }

  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { message: '', with: VALID_EMAIL_REGEX, },
                    uniqueness: true
  validates :password,
    length:       { message: 'Не менее 6 символов', minimum: 6 },
    presence:     { message: 'Не может быть пустым' },
    confirmation: { message: 'Пароли не совпадают' },
    on:           :create

  validates :password,
    confirmation: { message: 'Пароли не совпадают' },
    on:           :update

  def feed
    Article.from_users_followed_by(self)
  end

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy!
  end

end
