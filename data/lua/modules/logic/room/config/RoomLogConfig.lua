module("modules.logic.room.config.RoomLogConfig", package.seeall)

local var_0_0 = class("RoomLogConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._logList = nil
	arg_1_0._logDict = nil
	arg_1_0._logTagList = nil
	arg_1_0._logTagDict = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"log_room_character",
		"log_room_tag"
	}
end

function var_0_0.onInit(arg_3_0)
	return
end

function var_0_0.onConfigLoaded(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == "log_room_character" then
		arg_4_0._logList = arg_4_2.configList
		arg_4_0._logDict = arg_4_2.configDict

		for iter_4_0, iter_4_1 in ipairs(arg_4_0._logList) do
			arg_4_0._logDict[iter_4_1.id] = iter_4_1
		end
	elseif arg_4_1 == "log_room_tag" then
		arg_4_0._logTagList = arg_4_2.configList
		arg_4_0._logTagDict = arg_4_2.configDict
	end
end

function var_0_0.getLogList(arg_5_0)
	return arg_5_0._logList
end

function var_0_0.getLogConfigById(arg_6_0, arg_6_1)
	return arg_6_0._logDict[arg_6_1]
end

function var_0_0.getLogTagList(arg_7_0)
	return arg_7_0._logTagList
end

function var_0_0.getLogTagConfigById(arg_8_0, arg_8_1)
	return arg_8_0._logTagDict[arg_8_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
