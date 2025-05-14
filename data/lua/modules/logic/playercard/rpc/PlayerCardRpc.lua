module("modules.logic.playercard.rpc.PlayerCardRpc", package.seeall)

local var_0_0 = class("PlayerCardRpc", BaseRpc)

function var_0_0.sendGetPlayerCardInfoRequest(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = PlayerCardModule_pb.GetPlayerCardInfoRequest()

	return arg_1_0:sendMsg(var_1_0, arg_1_1, arg_1_2)
end

function var_0_0.onReceiveGetPlayerCardInfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	PlayerCardModel.instance:updateCardInfo(arg_2_2.playerCardInfo)
end

function var_0_0.onReceivePlayerCardInfoPush(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 ~= 0 then
		return
	end

	PlayerCardModel.instance:updateCardInfo(arg_3_2.playerCardInfo)
end

function var_0_0.sendGetOtherPlayerCardInfoRequest(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = PlayerCardModule_pb.GetOtherPlayerCardInfoRequest()

	var_4_0.userId = arg_4_1

	return arg_4_0:sendMsg(var_4_0, arg_4_2, arg_4_3)
end

function var_0_0.onReceiveGetOtherPlayerCardInfoReply(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 ~= 0 then
		return
	end

	PlayerCardModel.instance:updateCardInfo(arg_5_2.playerCardInfo, arg_5_2.playerInfo)
end

function var_0_0.sendSetPlayerCardShowSettingRequest(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = PlayerCardModule_pb.SetPlayerCardShowSettingRequest()

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		table.insert(var_6_0.showSettings, iter_6_1)
	end

	return arg_6_0:sendMsg(var_6_0, arg_6_2, arg_6_3)
end

function var_0_0.onReceiveSetPlayerCardShowSettingReply(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 ~= 0 then
		return
	end

	PlayerCardModel.instance:updateSetting(arg_7_2.showSettings)
end

function var_0_0.sendSetPlayerCardHeroCoverRequest(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = PlayerCardModule_pb.SetPlayerCardHeroCoverRequest()

	var_8_0.heroCover = arg_8_1

	return arg_8_0:sendMsg(var_8_0, arg_8_2, arg_8_3)
end

function var_0_0.onReceiveSetPlayerCardHeroCoverReply(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 ~= 0 then
		return
	end

	PlayerCardModel.instance:updateHeroCover(arg_9_2.heroCover)
end

function var_0_0.sendSetPlayerCardThemeRequest(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = PlayerCardModule_pb.SetPlayerCardThemeRequest()

	var_10_0.themeId = arg_10_1

	return arg_10_0:sendMsg(var_10_0, arg_10_2, arg_10_3)
end

function var_0_0.onReceiveSetPlayerCardThemeReply(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 ~= 0 then
		return
	end

	PlayerCardModel.instance:updateThemeId(arg_11_2.themeId)
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.ChangeSkin, arg_11_2.themeId)
end

function var_0_0.sendSetPlayerCardShowAchievementRequest(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = PlayerCardModule_pb.SetPlayerCardShowAchievementRequest()

	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		var_12_0.ids:append(iter_12_1)
	end

	var_12_0.groupId = arg_12_2

	return arg_12_0:sendMsg(var_12_0, arg_12_3, arg_12_4)
end

function var_0_0.onReceiveSetPlayerCardShowAchievementReply(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 ~= 0 then
		return
	end

	GameFacade.showToast(ToastEnum.AchievementSaveSucc)
	PlayerCardController.instance:statSetAchievement()
	AchievementController.instance:dispatchEvent(AchievementEvent.AchievementSaveSucc)
end

function var_0_0.sendSetPlayerCardProgressSettingRequest(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = PlayerCardModule_pb.SetPlayerCardProgressSettingRequest()

	var_14_0.progressSetting = arg_14_1

	return arg_14_0:sendMsg(var_14_0, arg_14_2, arg_14_3)
end

function var_0_0.onReceiveSetPlayerCardProgressSettingReply(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 ~= 0 then
		return
	end

	PlayerCardModel.instance:updateProgressSetting(arg_15_2.progressSetting)
	PlayerCardController.instance:statSetProgress()
end

function var_0_0.sendSetPlayerCardBaseInfoSettingRequest(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = PlayerCardModule_pb.SetPlayerCardBaseSettingRequest()

	var_16_0.baseSetting = arg_16_1

	return arg_16_0:sendMsg(var_16_0, arg_16_2, arg_16_3)
end

function var_0_0.onReceiveSetPlayerCardBaseSettingReply(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 ~= 0 then
		return
	end

	PlayerCardModel.instance:updateBaseInfoSetting(arg_17_2.baseSetting)
	PlayerCardController.instance:statSetBaseInfo()
end

function var_0_0.sendSetPlayerCardCritterRequest(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = PlayerCardModule_pb.SetPlayerCardCritterRequest()

	var_18_0.critterUid = tonumber(arg_18_1)

	return arg_18_0:sendMsg(var_18_0, arg_18_2, arg_18_3)
end

function var_0_0.onReceiveSetPlayerCardCritterReply(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_1 ~= 0 then
		return
	end

	local var_19_0 = CritterModel.instance:getCritterMOByUid(arg_19_2.critterUid)

	PlayerCardModel.instance:setSelectCritterUid(arg_19_2.critterUid)
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.SelectCritter, {
		uid = arg_19_2.critterUid
	})
end

var_0_0.instance = var_0_0.New()

return var_0_0
