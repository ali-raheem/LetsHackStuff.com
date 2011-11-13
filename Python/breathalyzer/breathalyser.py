#!/usr/bin/env python
import pygame,serial,sys
from time import gmtime, strftime
#set up the serial port
s = serial.Serial(sys.argv[1], sys.argv[2])

#some variables
w = 1920
h = 1080
highscore_wav = 'woohoo.wav'
colour = {}
colour['HIGH'] = (255,0,0)
colour['MEDIUM'] = (0,255,0)
colour['LOW'] = (0,0,255)
black = (0,0,0)
white = (255,255,255)
x=0
y=0
highscore = 0
quit = False

#pygame objects
screen = pygame.display.set_mode((w, h))
pygame.font.init()
pygame.mixer.init()
fontSmall = pygame.font.Font(None, 20)
fontLarge = pygame.font.Font(None, 40)
pygame.display.set_caption("Breathalyzer")
pygame.mouse.set_visible(False)
clock = pygame.time.Clock()
highscoreSound = pygame.mixer.Sound('woohoo.wav')
while not quit:
	x += 1
	if(x>=w):
		screen.fill(black)
		x = 0
		pygame.draw.line(screen, white,(0,h-highscore),(w,h-highscore))
	try:	
		y  = int(s.readline())
		if(y>200):
			RGB = colour['HIGH']
		elif(y>100):
			RGB = colour['MEDIUM']
		else:
			RGB = colour['LOW']
		screen.set_at((x,h-y), RGB)
	except:
		print "Error!"
	if(y>highscore):
		highscoreSound.play()
		highscore = y
		print "NEW HIGHSCORE!"
		
	print x,y
	for event in pygame.event.get():
		if event.type == pygame.QUIT:
			quit = True
		if event.type == pygame.KEYDOWN:
			if event.key == pygame.K_f:
				pygame.display.toggle_fullscreen()
			if event.key == pygame.K_s:
				image_file = "breathalyser-"+strftime("%H:%M:%S", gmtime())+'.png'
				pygame.image.save(screen, image_file)
				print "Screenshot saved to",image_file
			if event.key == pygame.K_q:
				quit = True
	textHS = fontSmall.render("Highscore: "+str(highscore),1,white,black)
	screen.blit(textHS,(0,0))
	textScore = fontLarge.render(str(y),1,white,black)
	textScorePos = textScore.get_rect(centerx=w/2)
	screen.blit(textScore,textScorePos)

	pygame.display.flip()
	clock.tick(240)
print "Highscore was", highscore
s.close()
pygame.quit()
