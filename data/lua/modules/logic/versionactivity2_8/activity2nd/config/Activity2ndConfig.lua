module("modules.logic.versionactivity2_8.activity2nd.config.Activity2ndConfig", package.seeall)

local var_0_0 = class("Activity2ndConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"activity196",
		"activity200",
		"activity196_const"
	}
end

function var_0_0.onInit(arg_2_0)
	arg_2_0._strDict = {}
	arg_2_0._strList = {}
	arg_2_0._act200config = {}
	arg_2_0._act196const = {}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity196" then
		for iter_3_0, iter_3_1 in ipairs(arg_3_2.configList) do
			arg_3_0._strDict[iter_3_1.code] = iter_3_1.id
		end

		arg_3_0._strList = arg_3_2.configList
	elseif arg_3_1 == "activity200" then
		arg_3_0._act200config = arg_3_2
	elseif arg_3_1 == "activity196_const" then
		arg_3_0._act196const = arg_3_2
	end
end

function var_0_0.getIdByStr(arg_4_0, arg_4_1)
	return arg_4_0._strDict[arg_4_1]
end

function var_0_0.getStrList(arg_5_0)
	return arg_5_0._strList
end

function var_0_0.getAct200ConfigList(arg_6_0)
	return arg_6_0._act200config.configList
end

function var_0_0.getAct200ConfigById(arg_7_0, arg_7_1)
	return arg_7_0._act200config.configList[arg_7_1]
end

function var_0_0.getAct196ConstById(arg_8_0, arg_8_1)
	return arg_8_0._act196const.configDict[arg_8_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
