class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :runs
  has_many :games, -> { uniq }, through: :runs

  def self.search(term)
    where(User.arel_table[:name].matches "%#{term}%").joins(:runs).uniq.order(:name)
  end

  def load_from_twitch(response = nil)
    response ||= HTTParty.get(URI.parse("https://api.twitch.tv/kraken/user?oauth_token=#{twitch_token}").to_s)

    self.twitch_id = response['_id']
    self.email     = response['email']
    self.name      = response['name']
  end

  def just_signed_up?
    Time.now - 3.seconds < created_at
  end

  def just_signed_in?
    Time.now - 3.seconds < current_sign_in_at
  end

  def as_json(options = {})
    super({
      only: [:id, :twitch_id, :name, :created_at, :updated_at]
    }.merge(options))
  end

  def to_param
    name
  end
end
