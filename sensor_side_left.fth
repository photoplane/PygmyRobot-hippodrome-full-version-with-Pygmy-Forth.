CODE SENSORSIDELEFT
    import RPi.GPIO as GPIO     
    GPIO.setmode(GPIO.BOARD)
    GPIO.setwarnings(False)
    capteur4 = 24 # capteur optique
    GPIO.setup(capteur4, GPIO.IN)
    etat4 = GPIO.input(capteur4)
    dpush(etat4)
END-CODE

