module("modules.logic.turnback.invitation.config.TurnBackInvitationConfig", package.seeall)

local var_0_0 = class("TurnBackInvitationConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._turnBackH5ChannelConfig = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"turnback_h5_channel"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "turnback_h5_channel" then
		arg_3_0._turnBackH5ChannelConfig = arg_3_2

		arg_3_0:_initTurnBackH5Config()
	end
end

function var_0_0._initTurnBackH5Config(arg_4_0)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._turnBackH5ChannelConfig.configList) do
		if var_4_0[iter_4_1.channelId] == nil then
			var_4_0[iter_4_1.channelId] = iter_4_1.url
		end
	end

	arg_4_0._channelUrlDic = var_4_0
end

function var_0_0.getChannelConfig(arg_5_0, arg_5_1)
	return arg_5_0._turnBackH5ChannelConfig.configDict[arg_5_1]
end

function var_0_0.getUrlByChannelId(arg_6_0, arg_6_1)
	return arg_6_0._channelUrlDic[arg_6_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
