// genesis

//
// piriform_utils.g: various utility functions.
//

// This function clears a disk file.

function clearfile (filename)
    str       filename
    openfile  {filename} w
    closefile {filename}
end


//
// These functions allow us to define an arbitrary sigmoidal function.
//

// A basic dimensionless sigmoid with a slope of 1.0 at the midpoint.

function basic_sigmoid(x)
    float x

    return {1.0 / (1.0 + {exp {-4.0 * x}})}
end


// A basic upward-going sigmoid.

function sigmoid(x, mid, deltay, deltax, low, high)
    float low, mid, high, deltax, deltay
    float normalized_y, slope
    float scaled_x, result

    // Check inputs.

    if ((low >= high) || (deltax <= 0.0) || (deltay <= 0.0))
        error
        echo usage: sigmoid x mid deltay deltax low high
        echo    (low must be lower than high)
        echo    (deltax, deltay must be >= 0)
        return
    end

    // Calculate slope.  Slope must be positive.

    normalized_y = deltay / (high - low)  // Dimensionless.
    slope = normalized_y / deltax

    // x and mid are in x units; slope is in 1/x units;
    // thus scaled_x is dimensionless.

    scaled_x = (x - mid) * slope

    // low and high have the same units; NOT the same as x units.

    // NOTE: this was changed from:
    //     result = low + high * {basic_sigmoid {scaled_x}}
    // This may fuck things up, since some of the parameterizations
    // depended on the old values.

    result = low + (high - low) * {basic_sigmoid {scaled_x}}
    return result
end



// A basic downward-going sigmoid.  Here deltay is the absolute value
// of a negative quantity and high and low are reversed.

function negative_sigmoid(x, mid, deltay, deltax, low, high)
    float low, mid, high, deltax, deltay
    float val

    val = 1.0 - {sigmoid {x} {mid} {deltay} {deltax} {high} {low}}
    return val
end



//
// This function calculates whether a given (x,y) pair is within
// a particular ellipse.
//

function is_in_ellipse(x, y, axis1, axis2)
    float x, y, axis1, axis2
    float val

    val = (x * x) / (axis1 * axis1) + (y * y) / (axis2 * axis2)

    if (val <= 1.0)
        return 1
    else
        return 0
    end
end



//
// This function returns the region of piriform cortex that a
// particular (x,y) pair is in.
//

function get_region(x, y)
    float x, y

    if ({is_in_ellipse {x} {y} {PIRIFORM_X_CENTER} {PIRIFORM_Y_CENTER}})
        return "VAPC"
    elif (x < PIRIFORM_X_CENTER)
        return "DAPC"
    else
        return "PPC"
    end
end



