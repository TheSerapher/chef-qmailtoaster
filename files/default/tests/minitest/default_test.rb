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
#

require File.expand_path('../support/helpers', __FILE__)

describe "qmailtoaster::default" do
  include Helpers::QmailtoasterTest

  before do
    # Create test domain and user
    system("! test -d /home/vpopmail/domains/#{INTERNALDOMAIN} && /home/vpopmail/bin/vadddomain #{INTERNALDOMAIN} test")
    assert $?.success?, "Unable to create domain #{INTERNALDOMAIN}"
    system("/home/vpopmail/bin/vadduser #{INTERNALEMAIL} #{INTERNALPASSWORD}")
    assert $?.success?, "Unable to create user #{INTERNALEMAIL}"
  end

  after do
    system("/home/vpopmail/bin/vdeluser #{INTERNALEMAIL}")
    assert $?.success?, "Unable to delete user #{INTERNALEMAIL}"
    # Delete test domain
    system("/home/vpopmail/bin/vdeldomain #{INTERNALDOMAIN}")
    assert $?.success?, "Unable to delete domain #{INTERNALDOMAIN}"
  end

  it 'checking directories' do
    %w(
    /var/qmail
    /home/vpopmail
    /etc/tcprules.d
    /var/qmail/supervise/send
    /var/qmail/supervise/smtp
    /var/qmail/supervise/submission
    /var/qmail/supervise/clamd
    /var/qmail/supervise/pop3-ssl
    /var/qmail/supervise/imap4
    /var/qmail/supervise/imap4-ssl
    /var/qmail/supervise/authlib
    /var/log/clamav
    /var/log/qmail
    /var/log/qmail/clamd
    /var/log/qmail/spamd
    /var/log/qmail/send
    /var/log/qmail/submission
    /var/log/qmail/imap4
    /var/log/qmail/imap4-ssl
    /var/log/qmail/pop3-ssl
    /var/log/qmail/authlib
    /etc/courier
    ).each do |dir|
      directory(dir).must_exist
    end
  end

  it 'checking files' do
    %w(
    /var/qmail/bin/qmail-smtpd
    /var/qmail/bin/qmail-queue
    /var/qmail/bin/qmail-send
    /var/qmail/bin/qmail-remote
    /etc/tcprules.d/tcp.smtp
    /etc/rc.d/init.d/qmail
    /usr/bin/clamdscan
    /usr/bin/clamscan
    /usr/sbin/clamd
    /etc/logrotate.d/freshclam
    /etc/rc.d/init.d/freshclam
    /usr/bin/spamassassin
    /usr/bin/spamc
    /usr/bin/spamd
    /usr/bin/sa-update
    /etc/cron.d/sa-update
    /etc/logrotate.d/sa-update
    /usr/bin/couriertls
    /usr/sbin/pop3login
    /usr/sbin/imaplogin
    /usr/bin/pop3d
    /usr/bin/imapd
    ).each do |file|
      file(file).must_exist
    end
  end

  it 'checking smtp and submission services' do
    [ 25, 587 ].each do |port|
      assert Net::SMTP.start(IPADDRESS, port, 'localhost').started?, 'Unable to establish a connection to port ' + port.to_s
      assert Net::SMTP.start(IPADDRESS, port, 'localhost', INTERNALEMAIL, INTERNALPASSWORD).started?, 'Unable to authenticate on port ' + port.to_s
      assert Net::SMTP.start(IPADDRESS, port, 'localhost').capable_starttls?, 'Server does not support STARTTLS on port ' + port.to_s
      assert Net::SMTP.start(IPADDRESS, port, 'localhost').enable_tls,'Unable to create TLS session to port ' + port.to_s
    end
    assert sendMail, 'Unable to deliver mail to local user'
    refute sendMail('external'), 'Host acting as an open relay'
  end

  it 'checking imap and imap-ssl services' do
    assert Net::IMAP.new(IPADDRESS, 143).capability, 'Unable to establish an IMAP connection'
    assert Net::IMAP.new(IPADDRESS, 993, true, nil, false).capability, 'Unable to establish an IMAP-SSL connection'
    assert Net::IMAP.new(IPADDRESS, 143).authenticate('LOGIN',INTERNALEMAIL, INTERNALPASSWORD), 'Unable to authenticate against IMAP server'
    assert Net::IMAP.new(IPADDRESS, 993, true, nil, false).authenticate('LOGIN', INTERNALEMAIL, INTERNALPASSWORD), 'Unable to authenticate against IMAP-SSL server'
    sendMail
    imap = Net::IMAP.new(IPADDRESS, 143)
    imap.authenticate('LOGIN', INTERNALEMAIL, INTERNALPASSWORD)
    imap.status('INBOX', [ 'UNSEEN' ])['UNSEEN'].must_equal 1, 'Unable to read mailbox'
  end

  it 'checking pop3 and pop3-ssl services' do
    # assert Net::POP3.new(IPADDRESS).start(INTERNALEMAIL, INTERNALPASSWORD).started?, 'Unable to establish a pop3 connection'
    Net::POP3.enable_ssl(OpenSSL::SSL::VERIFY_NONE)
    assert Net::POP3.new(IPADDRESS).start(INTERNALEMAIL, INTERNALPASSWORD).started?, 'Unable to establish a pop3-ssl connection'
    sendMail
    Net::POP3.new(IPADDRESS).start(INTERNALEMAIL, INTERNALPASSWORD).mails.size.must_equal 1, 'Unable to read mailbox'
  end

  it 'checking spamd service' do
    `echo "#{INTERNALMAILMESSAGE}" | /usr/bin/spamc`.must_match(/X-Spam-Status: No/)
    `echo test | /usr/bin/spamc`.must_match(/X-Spam-Status: Yes/)
  end

  it 'checking clamd service' do
    `echo "#{INTERNALMAILMESSAGE}" > /tmp/mail.txt; sleep 5; /usr/bin/clamdscan /tmp/mail.txt; rm -f /tmp/mail.txt`.wont_match(/Total errors:/)
  end
end
