CODE BACKLEFT
    import RPi.GPIO as GPIO
    from time import sleep
    GPIO.setmode(GPIO.BOARD)
    GPIO.setwarnings(False)

    GPIO.setup(11, GPIO.OUT)
    GPIO.setup(13, GPIO.OUT)
    GPIO.setup(7, GPIO.OUT)

    p=GPIO.PWM(7,100)
    p.start(0)

    

    GPIO.output(7, False)
    GPIO.output(11, False)
    GPIO.output(13, True)
    p.ChangeDutyCycle(100)
    GPIO.output(7, True)
    sleep(.01)

    GPIO.output(7, False)
    p.stop()
    GPIO.cleanup()
END-CODE
( MotorARGl.fth )
