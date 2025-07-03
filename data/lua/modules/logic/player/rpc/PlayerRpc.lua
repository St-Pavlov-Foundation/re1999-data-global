module("modules.logic.player.rpc.PlayerRpc", package.seeall)

local var_0_0 = class("PlayerRpc", BaseRpc)

function var_0_0.sendGetPlayerInfoRequest(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = PlayerModule_pb.GetPlayerInfoRequest()

	return arg_1_0:sendMsg(var_1_0, arg_1_1, arg_1_2)
end

function var_0_0.onReceiveGetPlayerInfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		local var_2_0 = arg_2_2.playerInfo

		PlayerModel.instance:setMainThumbnail(arg_2_2.mainThumbnail)
		PlayerModel.instance:GMSetMainThumbnail()
		PlayerModel.instance:setCanRename(arg_2_2.canRename)
		PlayerModel.instance:setExtraRename(arg_2_2.extRename)
		PlayerModel.instance:setPlayerinfo(var_2_0)
		CrashSightAgent.SetUserId(var_2_0.userId)
		PlayerPrefsHelper.setNumber(PlayerPrefsKey.PlayerLevel, var_2_0.level)
		PlayerPrefsHelper.setString(PlayerPrefsKey.PlayerUid, tostring(var_2_0.userId))

		local var_2_1 = arg_2_2.openinfos

		OpenModel.instance:setOpenInfo(var_2_1)
		OpenController.instance:dispatchEvent(OpenEvent.GetOpenInfoSuccess)
	end
end

function var_0_0.sendCreatePlayerRequest(arg_3_0, arg_3_1)
	local var_3_0 = PlayerModule_pb.CreatePlayerRequest()

	var_3_0.name = arg_3_1

	arg_3_0:sendMsg(var_3_0)
end

function var_0_0.onReceiveCreatePlayerReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		local var_4_0 = arg_4_2.playerInfo

		PlayerModel.instance:setPlayerinfo(var_4_0)
		CrashSightAgent.SetUserId(var_4_0.userId)
		PlayerPrefsHelper.setString(PlayerPrefsKey.PlayerUid, tostring(var_4_0.userId))
	end
end

function var_0_0.sendRenameRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = PlayerModule_pb.RenameRequest()

	var_5_0.name = arg_5_1

	if arg_5_2 ~= nil then
		var_5_0.guideId = arg_5_2
	end

	if arg_5_3 ~= nil then
		var_5_0.stepId = arg_5_3
	end

	arg_5_0._name = arg_5_1

	arg_5_0:sendMsg(var_5_0)
end

function var_0_0.onReceiveRenameReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		PlayerModel.instance:setPlayerName(arg_6_0._name)
		PlayerModel.instance:setCanRename(arg_6_2.canRename)
		PlayerModel.instance:setExtraRename(arg_6_2.extRename)
	else
		PlayerController.instance:dispatchEvent(PlayerEvent.RenameReplyFail)
	end
end

function var_0_0.sendSetSignatureRequest(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = PlayerModule_pb.SetSignatureRequest()

	var_7_0.signature = arg_7_1
	arg_7_0._signature = arg_7_1

	arg_7_0:sendMsg(var_7_0, arg_7_2, arg_7_3)
end

function var_0_0.onReceiveSetSignatureReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == 0 then
		PlayerModel.instance:setPlayerSignature(arg_8_0._signature)
	end
end

function var_0_0.sendSetBirthdayRequest(arg_9_0, arg_9_1)
	local var_9_0 = PlayerModule_pb.SetBirthdayRequest()

	var_9_0.birthday = arg_9_1
	arg_9_0._birthday = arg_9_1

	arg_9_0:sendMsg(var_9_0)
end

function var_0_0.onReceiveSetBirthdayReply(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 == 0 then
		PlayerModel.instance:setPlayerBirthday(arg_10_0._birthday)
	end
end

function var_0_0.sendSetPortraitRequest(arg_11_0, arg_11_1)
	local var_11_0 = PlayerModule_pb.SetPortraitRequest()

	var_11_0.portrait = arg_11_1
	arg_11_0._portrait = arg_11_1

	arg_11_0:sendMsg(var_11_0)
end

function var_0_0.onReceiveSetPortraitReply(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 == 0 then
		PlayerModel.instance:setPlayerPortrait(arg_12_0._portrait)
	end
end

function var_0_0.onReceivePlayerInfoPush(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 == 0 then
		SocialModel.instance:clearSelfPlayerMO()
		DungeonModel.instance:startCheckUnlockChapter()

		local var_13_0 = PlayerModel.instance:getPlayerLevel()
		local var_13_1 = arg_13_2.playerInfo

		PlayerModel.instance:setPlayerinfo(var_13_1)

		if var_13_0 ~= PlayerModel.instance:getPlayerLevel() then
			local var_13_2 = PlayerModel.instance:getPlayerLevel()

			DungeonModel.instance:endCheckUnlockChapter()

			if SDKMediaEventEnum.PlayerLevelUpMediaEvent[var_13_2] then
				SDKDataTrackMgr.instance:trackMediaEvent(SDKMediaEventEnum.PlayerLevelUpMediaEvent[var_13_2])
			end

			SDKChannelEventModel.instance:playerLevelUp(var_13_2)
		end
	end
end

function var_0_0.sendSetShowHeroUniqueIdsRequest(arg_14_0, arg_14_1)
	local var_14_0 = PlayerModule_pb.SetShowHeroUniqueIdsRequest()

	for iter_14_0 = 1, #arg_14_1 do
		table.insert(var_14_0.showHeroUniqueIds, arg_14_1[iter_14_0])
	end

	arg_14_0:sendMsg(var_14_0)
end

function var_0_0.onReceiveSetShowHeroUniqueIdsReply(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 == 0 then
		PlayerModel.instance:setShowHeroUniqueIds()
	end
end

function var_0_0.sendGetSimplePropertyRequest(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = PlayerModule_pb.GetSimplePropertyRequest()

	return arg_16_0:sendMsg(var_16_0, arg_16_1, arg_16_2)
end

function var_0_0.onReceiveGetSimplePropertyReply(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 ~= 0 then
		return
	end

	local var_17_0 = arg_17_2.simpleProperties

	PlayerModel.instance:updateSimpleProperties(var_17_0)
	HelpModel.instance:updateShowedHelpId()
end

function var_0_0.sendSetSimplePropertyRequest(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = PlayerModule_pb.SetSimplePropertyRequest()

	var_18_0.id = arg_18_1
	var_18_0.property = arg_18_2

	arg_18_0:sendMsg(var_18_0)
end

function var_0_0.onReceiveSetSimplePropertyReply(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_1 ~= 0 then
		return
	end
end

function var_0_0.onReceiveSimplePropertyPush(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_1 ~= 0 then
		return
	end

	local var_20_0 = arg_20_2.simpleProperty

	PlayerModel.instance:updateSimpleProperty(var_20_0)

	if var_20_0.id == PlayerEnum.SimpleProperty.ShowHelpIds then
		HelpModel.instance:updateShowedHelpId()
	end

	PlayerController.instance:dispatchEvent(PlayerEvent.UpdateSimpleProperty, var_20_0.id)
end

function var_0_0.sendGetClothInfoRequest(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = PlayerModule_pb.GetClothInfoRequest()

	return arg_21_0:sendMsg(var_21_0, arg_21_1, arg_21_2)
end

function var_0_0.onReceiveGetClothInfoReply(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_1 ~= 0 then
		return
	end

	PlayerClothModel.instance:onGetInfo(arg_22_2.clothInfos.clothes)
end

function var_0_0.onReceiveClothUpdatePush(arg_23_0, arg_23_1, arg_23_2)
	PlayerClothModel.instance:onPushInfo(arg_23_2.updateInfos.clothes)
end

function var_0_0.onReceiveServerResultCodePush(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_1 ~= 0 then
		return
	end

	local var_24_0 = arg_24_2.resultCode or 0

	if var_24_0 ~= 0 then
		GameFacade.showToast(var_24_0)
	end
end

function var_0_0.sendGetOtherPlayerInfoRequest(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = PlayerModule_pb.GetOtherPlayerInfoRequest()

	var_25_0.userId = arg_25_1

	arg_25_0:sendMsg(var_25_0, arg_25_2, arg_25_3)
end

function var_0_0.onReceiveGetOtherPlayerInfoReply(arg_26_0, arg_26_1, arg_26_2)
	if arg_26_1 ~= 0 then
		return
	end
end

function var_0_0.sendUseCdKeyRequset(arg_27_0, arg_27_1)
	local var_27_0 = PlayerModule_pb.UseCdKeyRequset()

	var_27_0.giftCode = arg_27_1

	arg_27_0:sendMsg(var_27_0)
end

function var_0_0.onReceiveUseCdKeyReply(arg_28_0, arg_28_1)
	if arg_28_1 == 0 then
		SettingsController.instance:dispatchEvent(SettingsEvent.OnUseCdkReplay)
	end
end

function var_0_0.sendSetPlayerBgRequest(arg_29_0, arg_29_1)
	local var_29_0 = PlayerModule_pb.SetPlayerBgRequest()

	var_29_0.bgId = arg_29_1

	arg_29_0:sendMsg(var_29_0)
end

function var_0_0.onReceiveSetPlayerBgReply(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_1 == 0 then
		-- block empty
	end
end

function var_0_0.sendMarkMainThumbnailRequest(arg_31_0)
	local var_31_0 = PlayerModule_pb.MarkMainThumbnailRequest()

	arg_31_0:sendMsg(var_31_0)
end

function var_0_0.onReceiveMarkMainThumbnailReply(arg_32_0, arg_32_1, arg_32_2)
	if arg_32_1 ~= 0 then
		return
	end

	PlayerModel.instance:setMainThumbnail(true)
end

function var_0_0.sendGetAssistBonusRequest(arg_33_0)
	local var_33_0 = PlayerModule_pb.GetAssistBonusRequest()

	arg_33_0:sendMsg(var_33_0)
end

function var_0_0.onReceiveGetAssistBonusReply(arg_34_0, arg_34_1, arg_34_2)
	if arg_34_1 ~= 0 then
		return
	end

	PlayerModel.instance:updateAssistRewardCountData(arg_34_2.assistBonus, arg_34_2.hasReceiveAssistBonus)
end

function var_0_0.sendReceiveAssistBonusRequest(arg_35_0)
	local var_35_0 = PlayerModule_pb.ReceiveAssistBonusRequest()

	arg_35_0:sendMsg(var_35_0)
end

function var_0_0.onReceiveReceiveAssistBonusReply(arg_36_0, arg_36_1, arg_36_2)
	if arg_36_1 ~= 0 then
		return
	end

	PlayerModel.instance:updateAssistRewardCountData(arg_36_2.assistBonus, arg_36_2.hasReceiveAssistBonus)
end

function var_0_0.sendSetMainSceneSkinRequest(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	local var_37_0 = PlayerModule_pb.SetMainSceneSkinRequest()

	var_37_0.itemId = arg_37_1

	return arg_37_0:sendMsg(var_37_0, arg_37_2, arg_37_3)
end

function var_0_0.onReceiveSetMainSceneSkinReply(arg_38_0, arg_38_1, arg_38_2)
	if arg_38_1 ~= 0 then
		return
	end

	local var_38_0 = arg_38_2.itemId
end

var_0_0.instance = var_0_0.New()

return var_0_0
