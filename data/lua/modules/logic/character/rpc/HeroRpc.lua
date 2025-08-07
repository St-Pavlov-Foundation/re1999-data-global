module("modules.logic.character.rpc.HeroRpc", package.seeall)

local var_0_0 = class("HeroRpc", BaseRpc)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:set_onReceiveHeroGainPushOnce(nil, nil)
end

function var_0_0.sendHeroInfoListRequest(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = HeroModule_pb.HeroInfoListRequest()

	return arg_3_0:sendMsg(var_3_0, arg_3_1, arg_3_2)
end

function var_0_0.onReceiveHeroInfoListReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		HeroModel.instance:onGetHeroList(arg_4_2.heros)
		HeroModel.instance:onGetSkinList(arg_4_2.allHeroSkin)
		HeroModel.instance:setTouchHeadNumber(arg_4_2.touchCountLeft)
		SignInModel.instance:setHeroBirthdayInfos(arg_4_2.birthdayInfos)
		CharacterController.instance:dispatchEvent(CharacterEvent.HeroInfoListReply)
	end
end

function var_0_0.sendHeroLevelUpRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = HeroModule_pb.HeroLevelUpRequest()

	var_5_0.heroId = arg_5_1
	var_5_0.expectLevel = arg_5_2

	arg_5_0:sendMsg(var_5_0, arg_5_3, arg_5_4)
end

function var_0_0.onReceiveHeroLevelUpReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		CharacterModel.instance:setFakeLevel()
		CharacterController.instance:dispatchEvent(CharacterEvent.successHeroLevelUp)
		RedDotController.instance:dispatchEvent(RedDotEvent.RefreshClientCharacterDot)
	else
		CharacterController.instance:dispatchEvent(CharacterEvent.levelUpAttribute)
	end
end

function var_0_0.onReceiveHeroLevelUpUpdatePush(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == 0 then
		HeroModel.instance:setHeroLevel(arg_7_2.heroId, arg_7_2.newLevel)
		HeroModel.instance:setHeroRank(arg_7_2.heroId, arg_7_2.newRank)
		CharacterController.instance:dispatchEvent(CharacterEvent.successHeroLevelUp)
		RedDotController.instance:dispatchEvent(RedDotEvent.RefreshClientCharacterDot)
	else
		CharacterController.instance:dispatchEvent(CharacterEvent.levelUpAttribute)
	end
end

function var_0_0.sendHeroRankUpRequest(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = HeroModule_pb.HeroRankUpRequest()

	var_8_0.heroId = arg_8_1

	arg_8_0:sendMsg(var_8_0, arg_8_2, arg_8_3)
end

function var_0_0.onReceiveHeroRankUpReply(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == 0 then
		CharacterController.instance:dispatchEvent(CharacterEvent.successHeroRankUp)
		RedDotController.instance:dispatchEvent(RedDotEvent.RefreshClientCharacterDot)

		local var_9_0 = {
			heroId = arg_9_2.heroId,
			newRank = arg_9_2.newRank
		}

		var_9_0.isRank = true

		PopupController.instance:addPopupView(PopupEnum.PriorityType.GainCharacterView, ViewName.CharacterGetView, var_9_0)

		if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) and arg_9_2.newRank == CharacterEnum.TalentRank then
			CharacterController.instance:stateTalent(arg_9_2.heroId)
		end

		SDKChannelEventModel.instance:heroRankUp(arg_9_2.newRank)
	end
end

function var_0_0.onReceiveHeroSkinGainPush(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 ~= 0 then
		return
	end

	if not CharacterEnum.SkinOpen then
		return
	end

	local var_10_0 = {
		skinId = arg_10_2.skinId,
		firstGain = arg_10_2.firstGain
	}

	if not var_10_0.firstGain then
		arg_10_0:_showTipsGainSkinRedundantly(arg_10_2.skinId)
	end

	HeroModel.instance:onGainSkinList(arg_10_2.skinId)

	if arg_10_2.getApproach == MaterialEnum.GetApproach.Task or arg_10_2.getApproach == MaterialEnum.GetApproach.TaskAct then
		TaskController.instance:getRewardByLine(arg_10_2.getApproach, ViewName.CharacterSkinGainView, var_10_0)
	elseif arg_10_2.getApproach == MaterialEnum.GetApproach.AutoChessRankReward then
		AutoChessController.instance:addPopupView(ViewName.CharacterSkinGainView, var_10_0)
	elseif arg_10_2.getApproach ~= MaterialEnum.GetApproach.NoviceStageReward then
		PopupController.instance:addPopupView(PopupEnum.PriorityType.GainSkinView, ViewName.CharacterSkinGainView, var_10_0)
	else
		TaskModel.instance:setTaskNoviceStageHeroParam(var_10_0)
	end
end

function var_0_0._showTipsGainSkinRedundantly(arg_11_0, arg_11_1)
	local var_11_0 = lua_skin.configDict[arg_11_1]
	local var_11_1 = var_11_0.compensate
	local var_11_2 = {
		var_11_0.characterSkin,
		[2] = "",
		[3] = ""
	}
	local var_11_3 = ToastEnum.GainSkinRedundantly

	if not string.nilorempty(var_11_1) then
		local var_11_4 = string.splitToNumber(var_11_1, "#")
		local var_11_5 = var_11_4[1]
		local var_11_6 = var_11_4[2]
		local var_11_7 = var_11_4[3]
		local var_11_8 = ItemConfig.instance:getItemConfig(var_11_5, var_11_6)

		var_11_2[2] = var_11_8.name
		var_11_2[3] = var_11_7

		local var_11_9 = ResUrl.getCurrencyItemIcon(var_11_8.icon)

		GameFacade.showIconToastWithTableParam(var_11_3, var_11_9, var_11_2)
	else
		GameFacade.showToastWithTableParam(var_11_3, var_11_2)
	end
end

function var_0_0.set_onReceiveHeroGainPushOnce(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0._heroGainPushOnceCb = arg_12_1
	arg_12_0._heroGainPushOnceCbObj = arg_12_2
end

function var_0_0.onReceiveHeroGainPush(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0._heroGainPushOnceCb

	if var_13_0 then
		local var_13_1 = arg_13_0._heroGainPushOnceCbObj

		arg_13_0:set_onReceiveHeroGainPushOnce(nil, nil)
		var_13_0(var_13_1, arg_13_1, arg_13_2)

		return
	end

	if arg_13_1 ~= 0 then
		arg_13_0._onReceiveHeroGainPushMsg = nil

		return
	end

	arg_13_0:_onReceiveHeroGainPush(arg_13_2)
end

function var_0_0._onReceiveHeroGainPush(arg_14_0, arg_14_1)
	local var_14_0 = {
		heroId = arg_14_1.heroId,
		duplicateCount = arg_14_1.duplicateCount or 0
	}
	local var_14_1 = CharacterModel.instance:getGainHeroViewShowState()
	local var_14_2 = CharacterModel.instance:getGainHeroViewShowNewState()

	if not var_14_1 then
		if var_14_2 and arg_14_1.duplicateCount > 0 then
			return
		end

		PopupController.instance:addPopupView(PopupEnum.PriorityType.GainCharacterView, ViewName.CharacterGetView, var_14_0)
	end
end

function var_0_0.sendHeroTalentUpRequest(arg_15_0, arg_15_1)
	local var_15_0 = HeroModule_pb.HeroTalentUpRequest()

	var_15_0.heroId = arg_15_1

	arg_15_0:sendMsg(var_15_0)
end

function var_0_0.onReceiveHeroTalentUpReply(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 == 0 then
		CharacterController.instance:dispatchEvent(CharacterEvent.successHeroTalentUp)
		RedDotController.instance:dispatchEvent(RedDotEvent.RefreshClientCharacterDot)
	end
end

function var_0_0.onReceiveHeroUpdatePush(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 == 0 then
		HeroModel.instance:onSetHeroChange(arg_17_2.heroUpdates)
		CharacterController.instance:dispatchEvent(CharacterEvent.HeroUpdatePush)
		RedDotController.instance:dispatchEvent(RedDotEvent.RefreshClientCharacterDot)
	end
end

function var_0_0.sendHeroUpgradeSkillRequest(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = HeroModule_pb.HeroUpgradeSkillRequest()

	var_18_0.heroId = arg_18_1
	var_18_0.type = arg_18_2
	var_18_0.consume = arg_18_3

	arg_18_0:sendMsg(var_18_0)
end

function var_0_0.onReceiveHeroUpgradeSkillReply(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_1 == 0 then
		CharacterController.instance:dispatchEvent(CharacterEvent.successHeroExSkillUp)
	end
end

function var_0_0.sendItemUnlockRequest(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = HeroModule_pb.ItemUnlockRequest()

	var_20_0.heroId = arg_20_1
	var_20_0.itemId = arg_20_2

	arg_20_0:sendMsg(var_20_0)
end

function var_0_0.onReceiveItemUnlockReply(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_1 == 0 then
		CharacterController.instance:dispatchEvent(CharacterEvent.HeroDataAddUnlockItem, arg_21_2.heroId, arg_21_2.itemId)
	else
		CharacterController.instance:dispatchEvent(CharacterEvent.HeroDataAddUnlockItemFail)
	end
end

function var_0_0.sendUnMarkIsNewRequest(arg_22_0, arg_22_1)
	local var_22_0 = HeroModule_pb.UnMarkIsNewRequest()

	var_22_0.heroId = arg_22_1

	arg_22_0:sendMsg(var_22_0)
end

function var_0_0.onReceiveUnMarkIsNewReply(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_1 == 0 then
		logNormal("更新角色" .. tostring(arg_23_2.heroId) .. tostring("新旧标记成功！"))
	end
end

function var_0_0.sendUnlockVoiceRequest(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = HeroModule_pb.UnlockVoiceRequest()

	var_24_0.heroId = arg_24_1
	var_24_0.voiceId = arg_24_2

	arg_24_0:sendMsg(var_24_0)
end

function var_0_0.onReceiveUnlockVoiceReply(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_1 == 0 then
		CharacterController.instance:dispatchEvent(CharacterEvent.HeroDataAddVoice)
	end
end

function var_0_0.sendUseSkinRequest(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = HeroModule_pb.UseSkinRequest()

	var_26_0.heroId = arg_26_1
	var_26_0.skinId = arg_26_2

	arg_26_0:sendMsg(var_26_0)
end

function var_0_0.onReceiveUseSkinReply(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_1 ~= 0 then
		return
	end

	CharacterController.instance:dispatchEvent(CharacterEvent.successDressUpSkin, {
		heroId = arg_27_2.heroId,
		skinId = arg_27_2.skinId
	})
end

function var_0_0.sendTouchHeadRequest(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = HeroModule_pb.HeroTouchRequest()

	var_28_0.heroId = arg_28_1

	arg_28_0:sendMsg(var_28_0, arg_28_2, arg_28_3)
end

function var_0_0.onReceiveHeroTouchReply(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_1 == 0 then
		local var_29_0 = arg_29_2.touchCountLeft
		local var_29_1 = arg_29_2.success

		HeroModel.instance:setTouchHeadNumber(var_29_0)
		MainController.instance:dispatchEvent(MainEvent.OnReceiveAddFaithEvent, var_29_1)
	end
end

var_0_0.CubePut = "putCubeInfo"
var_0_0.CubeGet = "getCubeInfo"

function var_0_0.PutTalentCubeRequest(arg_30_0, arg_30_1, arg_30_2, arg_30_3, arg_30_4, arg_30_5, arg_30_6)
	local var_30_0 = HeroModule_pb.PutTalentCubeRequest()
	local var_30_1 = arg_30_2 == HeroResonanceEnum.PutCube and var_0_0.CubePut or var_0_0.CubeGet

	var_30_0.heroId = arg_30_1
	var_30_0[var_30_1].cubeId = arg_30_3
	var_30_0[var_30_1].direction = arg_30_4
	var_30_0[var_30_1].posX = arg_30_5
	var_30_0[var_30_1].posY = arg_30_6
	var_30_0.templateId = HeroModel.instance:getCurTemplateId(arg_30_1)

	arg_30_0:sendMsg(var_30_0)
end

function var_0_0.onReceivePutTalentCubeReply(arg_31_0, arg_31_1, arg_31_2)
	if arg_31_1 == 0 then
		CharacterController.instance:dispatchEvent(CharacterEvent.OnPutTalentCubeReply)
		CharacterController.instance:dispatchEvent(CharacterEvent.RefreshCubeList)
	end
end

function var_0_0.RenameTalentTemplateRequest(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	local var_32_0 = HeroModule_pb.RenameTalentTemplateRequest()

	var_32_0.heroId = arg_32_1
	var_32_0.templateId = arg_32_2
	var_32_0.name = arg_32_3

	arg_32_0:sendMsg(var_32_0)
end

function var_0_0.onReceiveRenameTalentTemplateReply(arg_33_0, arg_33_1, arg_33_2)
	if arg_33_1 == 0 then
		CharacterController.instance:dispatchEvent(CharacterEvent.RenameTalentTemplateReply)
	end
end

function var_0_0.UseTalentTemplateRequest(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = HeroModule_pb.UseTalentTemplateRequest()

	var_34_0.heroId = arg_34_1
	var_34_0.templateId = arg_34_2

	arg_34_0:sendMsg(var_34_0)
end

function var_0_0.onReceiveUseTalentTemplateReply(arg_35_0, arg_35_1, arg_35_2)
	if arg_35_1 == 0 then
		CharacterController.instance:dispatchEvent(CharacterEvent.UseTalentTemplateReply)
		CharacterController.instance:dispatchEvent(CharacterEvent.RefreshCubeList)
	end
end

function var_0_0.TakeoffAllTalentCubeRequest(arg_36_0, arg_36_1)
	local var_36_0 = HeroModule_pb.TakeoffAllTalentCubeRequest()

	var_36_0.heroId = arg_36_1
	var_36_0.templateId = HeroModel.instance:getCurTemplateId(arg_36_1)

	arg_36_0:sendMsg(var_36_0)
end

function var_0_0.onReceiveTakeoffAllTalentCubeReply(arg_37_0, arg_37_1, arg_37_2)
	if arg_37_1 == 0 then
		HeroModel.instance:takeoffAllTalentCube(arg_37_2.heroId)
		CharacterController.instance:dispatchEvent(CharacterEvent.RefreshCubeList, arg_37_2.heroId)
	end
end

function var_0_0.PutTalentSchemeRequest(arg_38_0, arg_38_1, arg_38_2, arg_38_3, arg_38_4)
	local var_38_0 = HeroModule_pb.PutTalentSchemeRequest()

	var_38_0.heroId = arg_38_1
	var_38_0.talentId = arg_38_2
	var_38_0.talentMould = arg_38_3
	var_38_0.starMould = arg_38_4
	var_38_0.templateId = HeroModel.instance:getCurTemplateId(arg_38_1)

	arg_38_0:sendMsg(var_38_0)
end

function var_0_0.setPutTalentCubeBatchRequest(arg_39_0, arg_39_1, arg_39_2, arg_39_3, arg_39_4)
	local var_39_0 = HeroModule_pb.PutTalentCubeBatchRequest()

	var_39_0.heroId = arg_39_1
	var_39_0.templateId = arg_39_3
	var_39_0.style = arg_39_4

	for iter_39_0, iter_39_1 in pairs(arg_39_2) do
		local var_39_1 = var_39_0.putCubeInfo:add()

		var_39_1.cubeId = iter_39_1.cubeId
		var_39_1.direction = iter_39_1.direction
		var_39_1.posX = iter_39_1.posX
		var_39_1.posY = iter_39_1.posY
	end

	arg_39_0:sendMsg(var_39_0)
end

function var_0_0.onReceivePutTalentCubeBatchReply(arg_40_0, arg_40_1, arg_40_2)
	if arg_40_1 == 0 then
		HeroResonanceController.instance:dispatchEvent(HeroResonanceEvent.UseShareCode, arg_40_2)
	end
end

function var_0_0.onReceivePutTalentSchemeReply(arg_41_0, arg_41_1, arg_41_2)
	if arg_41_1 == 0 then
		CharacterController.instance:dispatchEvent(CharacterEvent.OnPutTalentCubeReply)
		CharacterController.instance:dispatchEvent(CharacterEvent.RefreshCubeList)
	end
end

function var_0_0.setHeroDefaultEquipRequest(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = HeroModule_pb.HeroDefaultEquipRequest()

	var_42_0.heroId = arg_42_1
	var_42_0.defaultEquipUid = arg_42_2

	arg_42_0:sendMsg(var_42_0)

	local var_42_1 = HeroGroupModel.instance:getList()
	local var_42_2 = HeroModel.instance:getByHeroId(arg_42_1).uid

	for iter_42_0, iter_42_1 in ipairs(var_42_1) do
		local var_42_3 = iter_42_1:_getHeroListBackup()

		for iter_42_2, iter_42_3 in ipairs(var_42_3) do
			if iter_42_3 == var_42_2 then
				HeroGroupRpc.instance:sendSetHeroGroupEquipRequest(iter_42_1.groupId, iter_42_2 - 1, {
					arg_42_2
				})
			end
		end
	end
end

function var_0_0.onReceiveHeroDefaultEquipReply(arg_43_0, arg_43_1, arg_43_2)
	if arg_43_1 == 0 then
		local var_43_0 = arg_43_2.defaultEquipUid

		CharacterController.instance:dispatchEvent(CharacterEvent.successSetDefaultEquip, var_43_0)
	end
end

function var_0_0.setUnlockTalentStyleRequest(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0 = HeroModule_pb.UnlockTalentStyleRequest()

	var_44_0.heroId = arg_44_1
	var_44_0.style = arg_44_2

	arg_44_0:sendMsg(var_44_0)
end

function var_0_0.onReceiveUnlockTalentStyleReply(arg_45_0, arg_45_1, arg_45_2)
	if arg_45_1 == 0 then
		CharacterController.instance:dispatchEvent(CharacterEvent.onUnlockTalentStyleReply, arg_45_2)
	end
end

function var_0_0.setUseTalentStyleRequest(arg_46_0, arg_46_1, arg_46_2, arg_46_3)
	local var_46_0 = HeroModule_pb.UseTalentStyleRequest()

	var_46_0.heroId = arg_46_1
	var_46_0.templateId = arg_46_2
	var_46_0.style = arg_46_3

	arg_46_0:sendMsg(var_46_0)
end

function var_0_0.onReceiveUseTalentStyleReply(arg_47_0, arg_47_1, arg_47_2)
	if arg_47_1 == 0 then
		CharacterController.instance:dispatchEvent(CharacterEvent.onUseTalentStyleReply, arg_47_2)
	end
end

function var_0_0.setTalentStyleReadRequest(arg_48_0, arg_48_1)
	local var_48_0 = HeroModule_pb.TalentStyleReadRequest()

	var_48_0.heroId = arg_48_1

	arg_48_0:sendMsg(var_48_0)
end

function var_0_0.onReceiveTalentStyleReadReply(arg_49_0, arg_49_1, arg_49_2)
	if arg_49_1 == 0 then
		CharacterController.instance:dispatchEvent(CharacterEvent.onTalentStyleRead, arg_49_2.heroId)
	end
end

function var_0_0.setHeroTalentStyleStatRequest(arg_50_0, arg_50_1)
	local var_50_0 = HeroModule_pb.HeroTalentStyleStatRequest()

	var_50_0.heroId = arg_50_1

	arg_50_0:sendMsg(var_50_0)
end

function var_0_0.onReceiveHeroTalentStyleStatReply(arg_51_0, arg_51_1, arg_51_2)
	if arg_51_1 == 0 then
		TalentStyleModel.instance:setHeroTalentStyleStatInfo(arg_51_2)
		CharacterController.instance:dispatchEvent(CharacterEvent.onHeroTalentStyleStatReply, arg_51_2)
	end
end

function var_0_0.setMarkHeroFavorRequest(arg_52_0, arg_52_1, arg_52_2)
	local var_52_0 = HeroModule_pb.MarkHeroFavorRequest()

	var_52_0.heroId = arg_52_1
	var_52_0.isFavor = arg_52_2

	arg_52_0:sendMsg(var_52_0)
end

function var_0_0.onReceiveMarkHeroFavorReply(arg_53_0, arg_53_1, arg_53_2)
	if arg_53_1 ~= 0 then
		return
	end

	HeroModel.instance:setHeroFavorState(arg_53_2.heroId, arg_53_2.isFavor)

	if arg_53_2.isFavor then
		GameFacade.showToast(ToastEnum.HeroFavorMarked)
	end

	CharacterController.instance:dispatchEvent(CharacterEvent.OnMarkFavorSuccess, arg_53_2.heroId)
end

function var_0_0.setDestinyLevelUpRequest(arg_54_0, arg_54_1, arg_54_2)
	local var_54_0 = HeroModule_pb.DestinyLevelUpRequest()

	var_54_0.heroId = arg_54_1
	var_54_0.level = arg_54_2

	arg_54_0:sendMsg(var_54_0)
end

function var_0_0.onReceiveDestinyLevelUpReply(arg_55_0, arg_55_1, arg_55_2)
	if arg_55_1 ~= 0 then
		return
	end

	CharacterDestinyController.instance:onLevelUpReply(arg_55_2.heroId, arg_55_2.level)
end

function var_0_0.setDestinyRankUpRequest(arg_56_0, arg_56_1)
	local var_56_0 = HeroModule_pb.DestinyRankUpRequest()

	var_56_0.heroId = arg_56_1

	arg_56_0:sendMsg(var_56_0)
end

function var_0_0.onReceiveDestinyRankUpReply(arg_57_0, arg_57_1, arg_57_2)
	if arg_57_1 ~= 0 then
		return
	end

	CharacterDestinyController.instance:onRankUpReply(arg_57_2.heroId)
end

function var_0_0.setDestinyStoneUnlockRequest(arg_58_0, arg_58_1, arg_58_2)
	local var_58_0 = HeroModule_pb.DestinyStoneUnlockRequest()

	var_58_0.heroId = arg_58_1
	var_58_0.stoneId = arg_58_2

	arg_58_0:sendMsg(var_58_0)
end

function var_0_0.onReceiveDestinyStoneUnlockReply(arg_59_0, arg_59_1, arg_59_2)
	if arg_59_1 ~= 0 then
		return
	end

	CharacterDestinyController.instance:onUnlockStoneReply(arg_59_2.heroId, arg_59_2.stoneId)
end

function var_0_0.setDestinyStoneUseRequest(arg_60_0, arg_60_1, arg_60_2)
	local var_60_0 = HeroModule_pb.DestinyStoneUseRequest()

	var_60_0.heroId = arg_60_1
	var_60_0.stoneId = arg_60_2

	arg_60_0:sendMsg(var_60_0)
end

function var_0_0.onReceiveDestinyStoneUseReply(arg_61_0, arg_61_1, arg_61_2)
	if arg_61_1 ~= 0 then
		return
	end

	CharacterDestinyController.instance:onUseStoneReply(arg_61_2.heroId, arg_61_2.stoneId)
end

function var_0_0.setHeroRedDotReadRequest(arg_62_0, arg_62_1, arg_62_2)
	local var_62_0 = HeroModule_pb.HeroRedDotReadRequest()

	var_62_0.heroId = arg_62_1
	var_62_0.redDotType = arg_62_2

	arg_62_0:sendMsg(var_62_0)
end

function var_0_0.onReceiveHeroRedDotReadReply(arg_63_0, arg_63_1, arg_63_2)
	if arg_63_1 ~= 0 then
		return
	end

	CharacterDestinyController.instance:onHeroRedDotReadReply(arg_63_2.heroId, arg_63_2.redDot)
end

function var_0_0.setChoiceHero3124TalentTreeRequest(arg_64_0, arg_64_1, arg_64_2, arg_64_3)
	local var_64_0 = HeroModule_pb.ChoiceHero3124TalentTreeRequest()

	var_64_0.heroId = arg_64_1
	var_64_0.subId = arg_64_2
	var_64_0.level = arg_64_3

	arg_64_0:sendMsg(var_64_0)
end

function var_0_0.onReceiveChoiceHero3124TalentTreeReply(arg_65_0, arg_65_1, arg_65_2)
	if arg_65_1 ~= 0 then
		return
	end

	CharacterController.instance:dispatchEvent(CharacterEvent.onChoiceHero3124TalentTreeReply, arg_65_2.extraStr)
	CharacterController.instance:dispatchEvent(CharacterEvent.onRefreshCharacterSkill)
end

function var_0_0.setCancelHero3124TalentTreeRequest(arg_66_0, arg_66_1, arg_66_2, arg_66_3)
	local var_66_0 = HeroModule_pb.CancelHero3124TalentTreeRequest()

	var_66_0.heroId = arg_66_1
	var_66_0.subId = arg_66_2
	var_66_0.level = arg_66_3

	arg_66_0:sendMsg(var_66_0)
end

function var_0_0.onReceiveCancelHero3124TalentTreeReply(arg_67_0, arg_67_1, arg_67_2)
	if arg_67_1 ~= 0 then
		return
	end

	CharacterController.instance:dispatchEvent(CharacterEvent.onCancelHero3124TalentTreeReply, arg_67_2.extraStr)
	CharacterController.instance:dispatchEvent(CharacterEvent.onRefreshCharacterSkill)
end

function var_0_0.setResetHero3124TalentTreeRequest(arg_68_0, arg_68_1)
	local var_68_0 = HeroModule_pb.ResetHero3124TalentTreeRequest()

	var_68_0.heroId = arg_68_1

	arg_68_0:sendMsg(var_68_0)
end

function var_0_0.onReceiveResetHero3124TalentTreeReply(arg_69_0, arg_69_1, arg_69_2)
	if arg_69_1 ~= 0 then
		return
	end

	CharacterController.instance:dispatchEvent(CharacterEvent.onResetHero3124TalentTreeReply, arg_69_2.extraStr)
	CharacterController.instance:dispatchEvent(CharacterEvent.onRefreshCharacterSkill)
end

function var_0_0.setChoiceHero3123WeaponRequest(arg_70_0, arg_70_1, arg_70_2, arg_70_3)
	local var_70_0 = HeroModule_pb.ChoiceHero3123WeaponRequest()

	var_70_0.heroId = arg_70_1
	var_70_0.mainId = arg_70_2
	var_70_0.subId = arg_70_3

	arg_70_0:sendMsg(var_70_0)
end

function var_0_0.onReceiveChoiceHero3123WeaponReply(arg_71_0, arg_71_1, arg_71_2)
	if arg_71_1 ~= 0 then
		return
	end

	CharacterController.instance:dispatchEvent(CharacterEvent.onChoiceHero3123WeaponReply, arg_71_2.heroId, arg_71_2.mainId, arg_71_2.subId)
	CharacterController.instance:dispatchEvent(CharacterEvent.onRefreshCharacterSkill)
end

var_0_0.instance = var_0_0.New()

return var_0_0
