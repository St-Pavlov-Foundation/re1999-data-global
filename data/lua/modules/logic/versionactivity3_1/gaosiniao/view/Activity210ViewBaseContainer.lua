module("modules.logic.versionactivity3_1.gaosiniao.view.Activity210ViewBaseContainer", package.seeall)

local var_0_0 = class("Activity210ViewBaseContainer", TaskViewBaseContainer)
local var_0_1 = "Activity210|"

function var_0_0.getPrefsKeyPrefix(arg_1_0)
	return var_0_1 .. tostring(arg_1_0:actId())
end

function var_0_0.saveInt(arg_2_0, arg_2_1, arg_2_2)
	GameUtil.playerPrefsSetNumberByUserId(arg_2_1, arg_2_2)
end

function var_0_0.getInt(arg_3_0, arg_3_1, arg_3_2)
	return GameUtil.playerPrefsGetNumberByUserId(arg_3_1, arg_3_2)
end

return var_0_0
