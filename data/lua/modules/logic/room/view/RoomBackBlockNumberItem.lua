module("modules.logic.room.view.RoomBackBlockNumberItem", package.seeall)

local var_0_0 = class("RoomBackBlockNumberItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._goTrs = arg_1_1.transform
	arg_1_0._txtnumber = gohelper.findChildText(arg_1_1, "txt_number")
end

function var_0_0.getGO(arg_2_0)
	return arg_2_0._go
end

function var_0_0.getGOTrs(arg_3_0)
	return arg_3_0._goTrs
end

function var_0_0.setNumber(arg_4_0, arg_4_1)
	arg_4_0._txtnumber.text = arg_4_1
end

function var_0_0.setBlockMO(arg_5_0, arg_5_1)
	arg_5_0._blockMO = arg_5_1

	if arg_5_0._blockMO then
		gohelper.setActive(arg_5_0._go, true)
	else
		gohelper.setActive(arg_5_0._go, false)
	end
end

function var_0_0.getBlockMO(arg_6_0, arg_6_1)
	return arg_6_0._blockMO
end

return var_0_0
