# Ad Hoc Proto Take Home

## Problem:
Parse a custom protocol format that your payment processing application must interface with. The custom protocol is in an old-school mainframe format that is named "MPS7". This means consuming a proprietary binary protocol format that is not fully understood. Original problem description can be found [here](https://homework.adhoc.team/proto/) or in the README.

## Getting Started:
These instructions will allow you get your copy of this repo, up and running locally.

### Prerequisites:
Ruby `version 2.7.2`

Incompatabilities could occur if a different version is used. There are no Gem dependencies.
```sh
$ ruby -v
ruby 2.7.2p137 (2020-10-01 revision 5445e04352) [arm64-darwin20]
```

### Running the Application:
To run the application from the CL, just run the `proto.rb` file with Ruby command.

```sh
$ ruby proto.rb
```

### Application Output:
```sh
$ ruby proto.rb
total credit amount=18203.70
total debit amount=9366.02
autopays started=10
autopays ended=8
balance for user 2456938384156277127=0.00
```
