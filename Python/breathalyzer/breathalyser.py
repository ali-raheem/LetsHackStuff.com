#!/usr/bin/env python
import pygame,serial,sys
from time import gmtime, strftime
#heat map generation
mo = 255
def R(x,mi,mo):
        if(x>mi/2):
                return mo*(2*x/mi-1)
        return 0

def G(x,mi,mo):
        if(x<mi/2):
                return 2*mo*x/mi
        return 2*mo*(1-x/mi)

def B(x,mi,mo):
        if(x<mi/2):
                return mo*(1-2*x/mi)
        return 0

#set up the serial port
s = serial.Serial(sys.argv[1], sys.argv[2])

#some variables
w = 1280
h = 720
mi = 500 # max input
highscore_wav = 'woohoo.wav'
highscore = 0 #to prevent homer screaming atthe start
black = (0,0,0)
white = (255,255,255)
x=0
y=0
quit = False
mute = False

#pygame objects
screen = pygame.display.set_mode((w, h))
pygame.font.init()
pygame.mixer.init()
fontSmall = pygame.font.Font(None, 20)
fontLarge = pygame.font.Font(None, 40)
pygame.display.set_caption("Breathalyzer")
pygame.mouse.set_visible(False)
clock = pygame.time.Clock()
highscoreSound = pygame.mixer.Sound(highscore_wav)
while not quit:
	x += 1
	if(x>=w):
		screen.fill(black)
		x = 0
		pygame.draw.line(screen, white,(0,h-highscore),(w,h-highscore))
	try:	
		y  = int(s.readline())
		screen.set_at((x,h-y), (R(y,mi,mo),G(y,mi,mo),B(y,mi,mo)))
	except:
		print "#Couldn't get sane value from Serial port!"
	if(y>highscore):
		if not mute:
			 highscoreSound.play()
		highscore = y
		print "#NEW HIGHSCORE!"
		
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
			if event.key == pygame.K_m:
				mute = not mute
	textHS = fontSmall.render("Highscore: "+str(highscore),1,white,black)
	screen.blit(textHS,(0,0))
	textScore = fontLarge.render(str(y),1,white,black)
	textScorePos = textScore.get_rect(centerx=w/2)
	screen.blit(textScore,textScorePos)

	pygame.display.flip()
	clock.tick(240)

print "#Highscore was", highscore
s.close()
pygame.quit()
