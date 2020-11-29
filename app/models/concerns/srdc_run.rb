require 'active_support/concern'

require 'speedrundotcom'

module SRDCRun
  extend ActiveSupport::Concern

  included do
    def srdc_url
      SpeedrunDotCom::Run.url_from_id(srdc_id) if srdc_id.present?
    end

    def srdc_url=(url)
      srdc_id = SpeedrunDotCom::Run.id_from_url(url)
    end

    def set_runner_from_srdc
      return if srdc_id.nil?
      update(user:
        User.find_by(
          name: SpeedrunDotCom.user(
            SpeedrunDotCom.run(srdc_id).players[0]['id']
          ).twitch_login
        )
      )
    end
  end
end
