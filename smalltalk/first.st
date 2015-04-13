3 raisedTo: 5

3 squared. 5 squared 25

Transcript clear;
	show: 'Hello world!';
	cr;
	show: 'How are you?'

| price tax total |
price := (Dialog request: 'Please enter price' initialAnswer:'100') asNumber  50

tax := (Dialog request: 'Please enter price %' initialAnswer:'10') asNumber 20

total := price + (price * tax / 100) 60

