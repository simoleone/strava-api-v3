require 'httmultiparty'

module Strava::Api::V3
  class PushSubscription
    # Create a new webhook push subscription.
    #
    # See {https://strava.github.io/api/v3/events/#create} for details.
    #
    # @param [Integer] client_id
    # @param [String] client_secret
    # @param [String] object_type
    # @param [String] aspect_type
    # @param [String] callback_url
    # @param [String] verify_token
    def self.create_push_subscription(client_id, client_secret, object_type, aspect_type, callback_url, verify_token=nil)
      query = {client_id: client_id,
               client_secret: client_secret,
               object_type: object_type,
               aspect_type: aspect_type,
               callback_url: callback_url}
      query.merge!({verify_token: verify_token}) if verify_token

      HTTMultiParty.post(
        Strava::Api::V3::Configuration::DEFAULT_PUSH_SUBSCRIPTION_ENDPOINT,
        query: query)
    end

    # Delete a webhook push subscription.
    #
    # See {https://strava.github.io/api/v3/events/#delete} for details.
    #
    # @param [Integer] client_id
    # @param [String] client_secret
    # @param [Integer] subscription_id
    def self.delete_push_subscription(client_id, client_secret, subscription_id)
      HTTMultiParty.delete(
        "#{Strava::Api::V3::Configuration::DEFAULT_PUSH_SUBSCRIPTION_ENDPOINT}/#{subscription_id}",
        query: {client_id: client_id, client_secret: client_secret})
    end

    # List existing webhook push subscriptions
    #
    # See {https://strava.github.io/api/v3/events/#list} for details
    #
    # @param [Integer] client_id
    # @param [String] client_secret
    def self.list_push_subscriptions(client_id, client_secret)
      HTTMultiParty.get(
        "#{Strava::Api::V3::Configuration::DEFAULT_PUSH_SUBSCRIPTION_ENDPOINT}",
        query: {client_id: client_id, client_secret: client_secret})
    end
  end
end
