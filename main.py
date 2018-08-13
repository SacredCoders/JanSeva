from chatterbot.trainers import ListTrainer
from chatterbot import ChatBot 
import os

bot=ChatBot('Bot')
bot.set_trainer(ListTrainer)

for files in os.listdir('/home/rahul/chatterbot_corpus/data/english/'):
		data=open('/home/rahul/chatterbot_corpus/data/english/'+ files,'r').readlines()
		bot.train(data)


while True:
	message=input('You:')
	if message.strip()!="Bye":
		reply=bot.get_response(message)
		print('ChatBot:',reply)
	if message.strip()=="Bye":
		print('ChatBot: Bye Bye!!! Have a great Day')
		break;
