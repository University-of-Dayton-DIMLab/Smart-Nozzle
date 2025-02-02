classdef solenoid
    properties
        controller
        solenoidPin
    end
    
    methods
        function obj = solenoid(controller, pin)
            % Solenoid Constructor
            obj.controller = controller;
            obj.solenoidPin = pin;
        end
        
        function open(obj)
            % Open the solenoid
            writeDigitalPin(obj.controller, obj.solenoidPin, 1);
        end

        function close(obj)
            % Close the solenoid
            writeDigitalPin(obj.controller, obj.solenoidPin, 0);
        end
    end
end

