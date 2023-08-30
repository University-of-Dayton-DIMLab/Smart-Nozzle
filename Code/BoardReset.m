function BoardReset(a,pins)
% Purpose: Sets all digital pin outputs to LOW, 0 V before/after using code

for m = 1:length(pins)
    d(m) = 'D';
    str1 = strcat(d(m),num2str(pins(m)));
    if pins(m) < 10
        pins1(m,:) = str1(:,:);
    elseif pins(m) >= 10
        pins2(m,:) = str1(:,:);
    end
end

for n = 1:height(pins2)
    if pins(n) < 10
        writeDigitalPin(a, pins1(n,:), 0);
    elseif pins(n) >= 10
        writeDigitalPin(a, pins2(n,:), 0);
    end
end
end
