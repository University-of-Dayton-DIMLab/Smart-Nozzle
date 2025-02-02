classdef pump
    properties
        controller 

        directionPin
        PWMPin
        brakePin
    end
    
    methods
        function obj = pump(controller, pinAssignments)
            % Pump Constructor
            obj.controller = controller;

            obj.directionPin = pinAssignments(1);
            obj.PWMPin = pinAssignments(2);
            obj.brakePin = pinAssignments(3);
        end
        
        function setDirection(obj, direction)
            % Set Pump Direction: 0 = forward, 1 = reverse
            writeDigitalPin(obj.controller, obj.directionPin, direction);
        end

        function setBrake(obj, brake)
            % Set Brake: 0 = off, 1 = on
            writeDigitalPin(obj.controller, obj.brakePin, brake);
        end

        function setPower(obj, power)
            % Set motor power: 0 = 0%, 1 = 100%
            writePWMDutyCycle(obj.controller, obj.PWMPin, power);
        end

        function kill(obj)
            % Stop the pump and engage the brake
            obj.setPower(0);
            obj.setBrake(1);
        end

        function reset(obj)
            % Rest the pump after being killed
            obj.setBrake(0);
        end
    end
end

