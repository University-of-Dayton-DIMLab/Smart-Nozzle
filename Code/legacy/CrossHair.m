function CrossHair(xpos,ypos,Tolerance,Target,Border,Color)
    
    xline(xpos,'-.','Color',Color,'LineWidth',Target)
    yline(ypos,'-.','Color',Color,'LineWidth',Target)

    if Tolerance > 0
        xline(xpos-Tolerance,'k-.','LineWidth',Border)
        yline(ypos-Tolerance,'k-.','LineWidth',Border)
        
        xline(xpos+Tolerance,'k-.','LineWidth',Border)
        yline(ypos+Tolerance,'k-.','LineWidth',Border)    
    else
        % Zero tolerance, doesn't include tolerance lines
    end
end