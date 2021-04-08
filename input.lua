input_x = 0
input_jump = false
input_jump_pressed = 0
input_switch = false
input_switch_pressed = 0


function update_input()
    input_x = btn(1) and 1 or btn(0) and -1 or 0

    local jump = btn(4)
    if jump and not input_jump then
        input_jump_pressed =  4
    else
        input_jump_pressed = jump and max(input_jump_pressed - 1) or 0
    end
    input_jump = jump

    local switch = btn(5)
    if switch and not input_switch then
        input_switch_pressed =  4
    else
        input_switch_pressed = switch and max(input_switch_pressed - 1) or 0
    end
    input_switch = switch
end

function consume_jump_press()
    local val = input_jump_pressed > 0
    input_jump_pressed = 0
    return val
end

function consume_switch_press()
    local val = input_switch_pressed > 0
    input_switch_pressed = 0
    return val
end

