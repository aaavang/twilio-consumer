# frozen_string_literal: true

require "twilio-ruby"

# Your Account SID and Auth Token from console.twilio.com
account_sid = ENV["TWILIO_ACCOUNT_SID"]
auth_token = ENV["TWILIO_AUTH_TOKEN"]

@client = Twilio::REST::Client.new account_sid, auth_token

loop do
  messages = @client.messages.list(limit: 20)

  messages.each do |message|
    puts "Message SID: #{message.sid}, From: #{message.from}, To: #{message.to}, Body: #{message.body}"
    @client.messages(message.sid).fetch.delete ? puts("Deleted message SID: #{message.sid}") : puts("Failed to delete message SID: #{message.sid}")
  end
  sleep 15
end
