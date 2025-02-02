function Solenoid_Logic_16APR2023(a,Marker,User,MotorNumber,SolenoidNumber,Tolerance,DutyCycle,Axis)
    
    MotorPin = strcat('D',num2str(MotorNumber));
    SolenoidPin = strcat('D',num2str(SolenoidNumber));

    if Axis > 0 % Lets user flip a negative to reverse the logic
        Error = Marker - User;
        if Error <= -Tolerance
            Condition = 2;
        elseif Error >= Tolerance
            Condition = 1;
        elseif abs(Error) < abs(Tolerance)
            Condition = 3;
        end
    
        if Condition == 1
            % Closes Inlet, Opens Outlet, lower pressure
            writeDigitalPin(a, MotorPin, 0); 
            writeDigitalPin(a, SolenoidPin, 1); 
        elseif Condition == 2
            % Opens Inlet, Closes Outlet, raise pressure
            writePWMDutyCycle(a, MotorPin, DutyCycle); 
            writeDigitalPin(a, SolenoidPin, 0); 
        elseif Condition == 3
            % Close both valves, maintain pressure
            Inlet = 0; Outlet = 0;
            writeDigitalPin(a, MotorPin, 0); 
            writeDigitalPin(a, SolenoidPin, 0); 
        end

    elseif Axis < 0
        Error = Marker - User;
        if Error <= -Tolerance
            Condition = 1;
        elseif Error >= Tolerance
            Condition = 2;
        elseif abs(Error) < abs(Tolerance)
            Condition = 3;
        end
    
        if Condition == 1
            % Closes Inlet, Opens Outlet, lower pressure
            writeDigitalPin(a, MotorPin, 0); 
            writeDigitalPin(a, SolenoidPin, 1); 
        elseif Condition == 2
            % Opens Inlet, Closes Outlet, raise pressure
            writePWMDutyCycle(a, MotorPin, DutyCycle); 
            writeDigitalPin(a, SolenoidPin, 0); 
        elseif Condition == 3
            % Close both valves, maintain pressure
            writeDigitalPin(a, MotorPin, 0); 
            writeDigitalPin(a, SolenoidPin, 0); 
        end
    end
end