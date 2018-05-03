function [D ,L] = IndexDetector(Bf,B_abs, AL)  %Switch D and L to strings

switch AL
    case 1
        L=3;
        D=5;
    case 2
        L=4;
         if (Bf(2)=='1')
            D=9;
         else D=12;
         end
         
    case 3
        L=5;
        switch Bf(2:3)
            case '00'
                D=28;
            case '01'
                D=24;
           case '10'
                D=20;
            case '11'
                D=17;
         end      
    case 4
        L=7;
        switch Bf(2:4)
            case '000'
                D=120;
            case '001'
                D=108;
           case '010'
                D=97;
            case '011'
                D=88;
            case '100'
                D=82;
            case '101'
                D=76;
           case '110'
                D=70;
            case '111'
                D=66;     
        end  


end


end