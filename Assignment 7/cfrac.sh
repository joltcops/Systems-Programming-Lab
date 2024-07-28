#! /bin/bash
gencfrac(){
    echo -n "Enter fraction (a/b): "
    read a str b
    if [ $b -eq 0 ]
    then echo "Division by zero not allowed!"
    fi
    if [ "$str" = "/" ]
    then
        r=$((a % b))
        q=$((a/b))
        until [ $r -eq 0 ]
            do
                echo -n "$q "
                a=$b
                b=$r
                r=$((a % b))
                q=$((a/b))
        done
        echo "$q "
    fi
}

evalcfrac(){
    echo -n "Enter the array of coefficients: "
    read -a array
    n=${#array[@]}
    num=${array[n-1]}
    den=1
    for((i=n-2; i>=0; i--))
        do temp=$num
            num=$((num*array[i]+den))
            den=$temp
    done
    approx=`echo "scale = 10; $num / $den" | bc`
    echo "The continued fraction evaluates to $num / $den = $approx"
}
evalcfrac
gencfrac