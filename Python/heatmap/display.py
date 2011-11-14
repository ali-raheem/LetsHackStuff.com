#!/usr/bin/env python
import pygame

#variables
quit = False
w = 640
h = 400
x = 200
y = 0
mo = 255.
mi = 640.

#pygame objects
screen = pygame.display.set_mode((w, h))
clock = pygame.time.Clock()


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

while not quit:
	for x in range(0,400):
		screen.set_at((y,x), (R(y,mi,mo),G(y,mi,mo),B(y,mi,mo)))
	y += 1
	pygame.display.flip()
	clock.tick(240)
        for event in pygame.event.get():
        	if event.type == pygame.QUIT:
                	quit = True
 		if event.type == pygame.KEYDOWN:
                	if event.key == pygame.K_s:
                        	pygame.image.save(screen, 'spectrum.png')

