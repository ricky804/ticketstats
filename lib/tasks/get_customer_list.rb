require 'rubygems'
require 'mysql'
require 'ValidateEmail'

user = "rtmon"
passwd = "Rqt5gcvVM"
db = "rt3"
host = "rt1.hosts.cdnetworks.net"

db = Mysql.connect(host, user, passwd, db)
sql ='
  select
    tickets.Creator,
    tickets.Status,
    LOWER(tickets.Subject),
    users.Comments,
    LOWER(users.EmailAddress),
    users.id
  from
    tickets left join users on tickets.Creator = users.id
  where
    tickets.Status != "deleted"
    and tickets.Status != "rejected"
    and users.Comments = "Autocreated on ticket submission"
    and users.EmailAddress not like "%cdnetworks%"
    and tickets.Subject not like "%spam%"
'



result = db.query(sql)

#List of customers along with email addresses
customers = Hash.new
i = 0


result.each do |email|
  #Valid email address only
  if ValidateEmail.validate(email[0])
    email_addr = email[0].to_s.downcase
    lst_email = [email_addr]
    splitted = email_addr.downcase.strip.split('@')
    name = splitted[0]
    domain = splitted[1].split('.')

    #Find name of the customer
    if domain.length == 2
      customer_name = domain[0]
    elsif domain.length > 2
      customer_name = splitted[1]
    end

    #Put in the hash
    if customers.has_key? customer_name
      customers[customer_name] << email_addr
    else
      customers[customer_name] = lst_email
    end
    i += 1
  end
end

puts i
#Insert to Customer Database
#
customers = customers.sort_by {|k,v| v.length}.reverse
customers.each do |key, value|
    puts key, value.length
end
