module("modules.logic.versionactivity1_6.act148.model.Activity148Mo", package.seeall)

local var_0_0 = pureTable("Activity148Mo")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._lv = arg_1_2
	arg_1_0._type = arg_1_1
end

function var_0_0.getLevel(arg_2_0)
	return arg_2_0._lv
end

function var_0_0.updateByServerData(arg_3_0, arg_3_1)
	arg_3_0._lv = arg_3_1.level
end

return var_0_0
