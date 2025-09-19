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

local function var_0_2(arg_3_0)
	return lua_turnback_sp_h5_roletype.configDict[arg_3_0]
end

function var_0_0.onConfigLoaded(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == "turnback_sp_h5_channel" then
		arg_4_0:_initTurnBackH5Config(arg_4_2)
	end
end

function var_0_0._initTurnBackH5Config(arg_5_0, arg_5_1)
	local var_5_0 = {}
	local var_5_1 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1.configList) do
		if var_5_0[iter_5_1.channelId] == nil then
			var_5_0[iter_5_1.channelId] = iter_5_1.url
			var_5_1[iter_5_1.channelId] = iter_5_1.testUrl
		end
	end

	arg_5_0._channelUrlDic = var_5_0
	arg_5_0._channelTestDic = var_5_1
end

function var_0_0.getChannelConfig(arg_6_0, arg_6_1)
	return lua_turnback_sp_h5_channel.configDict[arg_6_1]
end

function var_0_0.getUrlByChannelId(arg_7_0, arg_7_1)
	return arg_7_0._channelUrlDic[arg_7_1]
end

function var_0_0.getTestUrlByChannelId(arg_8_0, arg_8_1)
	if arg_8_0._channelTestDic[arg_8_1] ~= nil then
		return arg_8_0._channelTestDic[arg_8_1]
	end

	return arg_8_0._channelUrlDic[arg_8_1]
end

function var_0_0.getRoleTypeStr(arg_9_0, arg_9_1)
	local var_9_0 = var_0_1[arg_9_1 or 1] or var_0_1[1]

	return gohelper.getRichColorText(var_9_0.name, var_9_0.nameHexColor)
end

var_0_0.instance = var_0_0.New()

return var_0_0
