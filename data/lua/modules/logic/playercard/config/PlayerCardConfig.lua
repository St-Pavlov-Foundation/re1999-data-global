module("modules.logic.playercard.config.PlayerCardConfig", package.seeall)

local var_0_0 = class("PlayerCardConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"playercard",
		"player_newspaper"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "playercard" then
		arg_3_0.playcardBaseInfoConfig = arg_3_2
	elseif arg_3_1 == "player_newspaper" then
		arg_3_0.playcardProgressConfig = arg_3_2
	end
end

function var_0_0.getCardBaseInfoList(arg_4_0)
	return arg_4_0.playcardBaseInfoConfig.configList
end

function var_0_0.getCardBaseInfoById(arg_5_0, arg_5_1)
	return arg_5_0.playcardBaseInfoConfig.configList[arg_5_1]
end

function var_0_0.getCardProgressList(arg_6_0)
	return arg_6_0.playcardProgressConfig.configList
end

function var_0_0.getCardProgressById(arg_7_0, arg_7_1)
	return arg_7_0.playcardProgressConfig.configList[arg_7_1]
end

function var_0_0.getBgPath(arg_8_0, arg_8_1)
	if not arg_8_1 then
		return "ui/viewres/player/playercard/playercardview_bg.prefab"
	else
		return string.format("ui/viewres/player/playercard/playercardview_bg_%s.prefab", arg_8_1)
	end
end

function var_0_0.getTopEffectPath(arg_9_0, arg_9_1)
	if not arg_9_1 then
		return "ui/viewres/player/playercard/playercardview_effect.prefab"
	else
		return string.format("ui/viewres/player/playercard/playercardview_playercardview_effect_%s.prefab", arg_9_1)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
