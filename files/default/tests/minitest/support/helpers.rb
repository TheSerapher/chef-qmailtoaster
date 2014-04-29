# Copyright 2012, Sebastian Grewe <sebastian@grewe.ca>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'chef/mixin/shell_out'
require 'net/smtp'
require 'net/imap'
require 'net/pop'

# Some constants used through this test
EXTERNALEMAIL = 'test@example.com'
IPADDRESS = '10.0.2.15'
INTERNALDOMAIN = 'domain.com'
INTERNALUSER = 'test'
INTERNALPASSWORD = 'test'
INTERNALEMAIL = INTERNALUSER + '@' + INTERNALDOMAIN
EXTERNALMAILMESSAGE = "From: Test Internal <test@domain.com>
To: Test External <test@example.com>
Subject: test message
Date: Sat, 23 Jun 2001 16:26:43 +0900
Message-Id: <unique.message.id.string@example.com>

This is a test message.
"
INTERNALMAILMESSAGE = "From: Test External <test@example.com>
To: Test Internal <test@domain.com>
Subject: test message
Date: Sat, 23 Jun 2001 16:26:43 +0900
Message-Id: <unique.message.id.string@example.com>

This is a test message.
"

module Helpers
  # Helper module for Qmailtoaster tests
  module QmailtoasterTest
    include Chef::Mixin::ShellOut
    include MiniTest::Chef::Assertions
    include MiniTest::Chef::Context
    include MiniTest::Chef::Resources
    # Create default testing domain and user
    def send_mail(type = 'internal')
      smtp = Net::SMTP.start(IPADDRESS, 25)
      case type
      when 'internal'
        begin
          ret = smtp.send_message INTERNALMAILMESSAGE, INTERNALEMAIL, INTERNALEMAIL
        end
      when 'external'
        begin
          ret = smtp.send_message EXTERNALMAILMESSAGE, EXTERNALEMAIL, EXTERNALEMAIL
        end
      end
      smtp.finish
      sleep(2)
      ret
    end
  end
end
