# Proto - Parse a custom "MPS7" protocol format
require_relative './parse'
require_relative './record'

# File ingest, parse data, create records, calculate totals, and print answers to STDOUT. Should any errors print to STDERR.
begin
  user_id = 2456938384156277127
  bin = File.open('txnlog.dat')
  
  # Parse and create record files before calculating answers to print to console.
  Parse.new(bin)
  printf("total credit amount=%<credit>.2f\n", credit: Record.total_credit)
  printf("total debit amount=%<debit>.2f\n", debit: Record.total_debit)
  printf("autopays started=%<started>d\n", 
         started: Record.total_autopays_started)
  printf("autopays ended=%<ended>d\n", ended: Record.total_autopays_ended)
  printf("balance for user %<user_id>d=%<user_balance>.2f\n",
          user_id: user_id,
          user_balance: Record.user_balance(user_id))
rescue RuntimeError => e
  puts e.message
rescue KeyError => e
  puts "No user balance found with user ID: #{e.key}"
ensure
  bin.close
end
