CODE BACKRIGHT
    import RPi.GPIO as GPIO
    from time import sleep
    GPIO.setmode(GPIO.BOARD)
    GPIO.setwarnings(False)

    GPIO.setup(8, GPIO.OUT)
    GPIO.setup(10, GPIO.OUT)
    GPIO.setup(12, GPIO.OUT)

    p=GPIO.PWM(12,100)
    p.start(0)

    GPIO.output(12, False)
    GPIO.output(8, False)
    GPIO.output(10, True)
    p.ChangeDutyCycle(100)
    GPIO.output(12, True)
    sleep(.01)

    GPIO.output(12, False)
    p.stop()
    GPIO.cleanup()
END-CODE
( MotorARDw.fth )
