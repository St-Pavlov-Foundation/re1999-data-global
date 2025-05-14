module("modules.logic.act201.config.Activity201Config", package.seeall)

local var_0_0 = class("Activity201Config", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"turnback_sp_h5_channel",
		"turnback_sp_h5_roletype"
	}
end

local function var_0_1(arg_2_0)
	return lua_turnback_sp_h5_roletype.configDict[arg_2_0]
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "turnback_sp_h5_channel" then
		arg_3_0:_initTurnBackH5Config(arg_3_2)
	end
end

function var_0_0._initTurnBackH5Config(arg_4_0, arg_4_1)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.configList) do
		if var_4_0[iter_4_1.channelId] == nil then
			var_4_0[iter_4_1.channelId] = iter_4_1.url
		end
	end

	arg_4_0._channelUrlDic = var_4_0
end

function var_0_0.getChannelConfig(arg_5_0, arg_5_1)
	return lua_turnback_sp_h5_channel.configDict[arg_5_1]
end

function var_0_0.getUrlByChannelId(arg_6_0, arg_6_1)
	return arg_6_0._channelUrlDic[arg_6_1]
end

function var_0_0.getRoleTypeStr(arg_7_0, arg_7_1)
	local var_7_0 = var_0_1(arg_7_1 or 1) or var_0_1(1)

	return gohelper.getRichColorText(var_7_0.name, var_7_0.nameHexColor)
end

var_0_0.instance = var_0_0.New()

return var_0_0
