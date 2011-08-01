require 'net/ssh'
require 'net/scp'

namespace :db do
  desc 'Download the latest production database and restore locally'
  task :load_live_data do
    host = 'libreteka.com'
    ssh_user = 'deploy'
    db_user = 'wallstickers'
    db_name = 'wallstickers_production'

    tmpfile = ''

    puts 'dumping...'
    Net::SSH.start(host, ssh_user) do |ssh|
      tmpfile = ssh.exec!('tempfile').chomp
      cmd = "pg_dump -U #{db_user} -O -F c -b -f '#{tmpfile}' #{db_name}"
      ssh.exec!(cmd)
    end

    puts 'downloading...'
    Net::SCP.download!(host, ssh_user, tmpfile, "live_data.db")

    puts 'removing remote tempfile...'
    Net::SSH.start(host, ssh_user) do |ssh|
      ssh.exec!("rm #{tmpfile}")
    end

    puts 'dropping and recreating db...'
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke

    puts 'importing db...'
    system 'pg_restore -O --username=wallstickers --dbname=wallstickers_development live_data.db'
    system 'rm live_data.db'

    tmpfile = ''
    puts 'gzipping uploads...'
    Net::SSH.start(host, ssh_user) do |ssh|
      tmpfile = ssh.exec!("tempfile -s '.tar.bz2'").chomp
      ssh.exec!("cd /srv/apps/production/wallstickers.pl/shared/uploads && tar -cjf #{tmpfile} production")
    end

    Net::SCP.download!(host, ssh_user, tmpfile, 'latest_uploads.tar.bz2', :verbose => true)

    puts 'removing remote tempfile...'
    Net::SSH.start(host, ssh_user) do |ssh|
      ssh.exec!("rm #{tmpfile}")
    end

    puts 'replacing uploads...'
    system 'rm -r public/uploads/development'
    system 'tar -xjf latest_uploads.tar.bz2 -C public/uploads'
    system 'mv public/uploads/production public/uploads/development'
    sytemm 'rm latest_uploads.tar.bz2'

    puts 'all done!'
  end
end
