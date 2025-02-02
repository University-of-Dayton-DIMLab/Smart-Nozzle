classdef SmozzleController
    % Controller to be used with Arduino Uno and Motor Shield in conjuction
    % with two pumps with two controllable solenoid valves.
    properties
        pump1
        pump2

        solenoid1
        solenoid2
    end
    
    methods
        function obj = SmozzleController(controller)
            % Smozzle Controller Constructor
            obj.pump1 = pump(controller, ["D12", "D3", "D9"]);
            obj.pump2 = pump(controller, ["D13", "D11", "D8"]);
            obj.solenoid1 = solenoid(controller, "D4");
            obj.solenoid2 = solenoid(controller, "D6");
        end

        function init(obj)
            obj.pump1.setDirection(0);
            obj.pump2.setDirection(0);
            obj.pump1.setPower(0);
            obj.pump2.setPower(0);
            obj.pump1.setBrake(0);
            obj.pump1.setBrake(0);

            obj.solenoid1.close();
            obj.solenoid2.close();
        end
        
        function kill(obj)
            % Stop Pumps
            obj.pump1.kill();
            obj.pump2.kill();

            % Open Solenoids
            obj.solenoid1.open();
            obj.solenoid2.open();
        end

        function reset(obj)
            % Reset Pumps
            obj.pump1.reset();
            obj.pump2.reset();

            % Close Solenoids
            obj.solenoid1.close();
            obj.solenoid2.close();
        end

        function setPower(obj, powers)
            arguments(Input)
                obj
                powers (1,2)
            end

            obj.pump1.setPower(powers(1));
            obj.pump2.setPower(powers(2));
        end
    end
end

