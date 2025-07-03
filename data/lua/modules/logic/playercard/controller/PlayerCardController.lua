module("modules.logic.playercard.controller.PlayerCardController", package.seeall)

local var_0_0 = class("PlayerCardController", BaseController)

function var_0_0.reInit(arg_1_0)
	arg_1_0.viewParam = nil
end

function var_0_0.openPlayerCardView(arg_2_0, arg_2_1)
	arg_2_0.viewParam = arg_2_1 or {}

	local var_2_0 = arg_2_1 and arg_2_1.userId or PlayerModel.instance:getMyUserId()
	local var_2_1 = PlayerModel.instance:isPlayerSelf(var_2_0)

	arg_2_0.viewParam.userId = var_2_0

	if var_2_1 then
		PlayerCardRpc.instance:sendGetPlayerCardInfoRequest(arg_2_0._openPlayerCardView, arg_2_0)
	else
		PlayerCardRpc.instance:sendGetOtherPlayerCardInfoRequest(var_2_0, arg_2_0._openPlayerCardView, arg_2_0)
	end
end

function var_0_0._openPlayerCardView(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_2 ~= 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.NewPlayerCardContentView, arg_3_0.viewParam)
end

function var_0_0.playChangeEffectAudio(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.ui_activity_1_5_wulu.play_ui_wulu_seal_cutting_eft)
end

function var_0_0.saveAchievement(arg_5_0)
	local var_5_0, var_5_1 = PlayerCardAchievementSelectListModel.instance:getSaveRequestParam()

	PlayerCardRpc.instance:sendSetPlayerCardShowAchievementRequest(var_5_0, var_5_1)
end

function var_0_0.statStart(arg_6_0)
	if not PlayerCardModel.instance:getCardInfo():isSelf() then
		return
	end

	arg_6_0.startTime = ServerTime.now()
end

function var_0_0.statEnd(arg_7_0)
	local var_7_0 = PlayerCardModel.instance:getCardInfo()

	if not var_7_0:isSelf() then
		return
	end

	local var_7_1 = var_7_0.heroCover
	local var_7_2, var_7_3, var_7_4, var_7_5 = arg_7_0:getStatHeroCover(var_7_1)
	local var_7_6, var_7_7, var_7_8 = arg_7_0:getStatAchievement()
	local var_7_9 = arg_7_0:getStatProgress()
	local var_7_10 = arg_7_0:getStatBaseInfo()
	local var_7_11, var_7_12 = arg_7_0:getStatCritter()
	local var_7_13 = arg_7_0:getSkinName()
	local var_7_14 = arg_7_0:getHeadName()

	StatController.instance:track(StatEnum.EventName.ExitPlayerCard, {
		[StatEnum.EventProperties.Time] = arg_7_0:getUseTime(),
		[StatEnum.EventProperties.HeroId] = var_7_2,
		[StatEnum.EventProperties.skinId] = var_7_3,
		[StatEnum.EventProperties.HeroName] = var_7_4,
		[StatEnum.EventProperties.skinName] = var_7_5,
		[StatEnum.EventProperties.DisplaySingleAchievementName] = var_7_6,
		[StatEnum.EventProperties.DisplayGroupAchievementName] = var_7_7,
		[StatEnum.EventProperties.MedalNum] = var_7_8,
		[StatEnum.EventProperties.GameProgress] = var_7_9,
		[StatEnum.EventProperties.BaseInfomation] = var_7_10,
		[StatEnum.EventProperties.CritterId] = var_7_11,
		[StatEnum.EventProperties.CritterName] = var_7_12,
		[StatEnum.EventProperties.PlayerCardSkinName] = var_7_13,
		[StatEnum.EventProperties.HeadName] = var_7_14
	})
end

function var_0_0.statSetHeroCover(arg_8_0, arg_8_1)
	local var_8_0, var_8_1, var_8_2, var_8_3 = arg_8_0:getStatHeroCover(arg_8_1)

	StatController.instance:track(StatEnum.EventName.PlaycardSetHeroCover, {
		[StatEnum.EventProperties.HeroId] = var_8_0,
		[StatEnum.EventProperties.skinId] = var_8_1,
		[StatEnum.EventProperties.HeroName] = var_8_2,
		[StatEnum.EventProperties.skinName] = var_8_3
	})
end

function var_0_0.getStatHeroCover(arg_9_0, arg_9_1)
	local var_9_0 = string.splitToNumber(arg_9_1, "#")
	local var_9_1 = var_9_0[1]
	local var_9_2 = var_9_0[2]
	local var_9_3 = ""
	local var_9_4 = ""

	if not string.nilorempty(var_9_1) then
		var_9_3 = HeroConfig.instance:getHeroCO(var_9_1).name
	end

	if not string.nilorempty(var_9_2) then
		var_9_4 = SkinConfig.instance:getSkinCo(var_9_2).name
	end

	return var_9_1, var_9_2, var_9_3, var_9_4
end

function var_0_0.statSetAchievement(arg_10_0)
	local var_10_0, var_10_1, var_10_2 = arg_10_0:getStatAchievement()

	StatController.instance:track(StatEnum.EventName.PlaycardDisplayMedal, {
		[StatEnum.EventProperties.DisplaySingleAchievementName] = var_10_0,
		[StatEnum.EventProperties.DisplayGroupAchievementName] = var_10_1,
		[StatEnum.EventProperties.MedalNum] = var_10_2
	})
end

function var_0_0.getStatAchievement(arg_11_0)
	local var_11_0 = PlayerCardModel.instance:getShowAchievement()

	if not var_11_0 or string.nilorempty(var_11_0) then
		return nil, nil, nil
	end

	local var_11_1, var_11_2 = AchievementUtils.decodeShowStr(var_11_0)
	local var_11_3 = arg_11_0:getAchievementNameListByTaskId(var_11_1)
	local var_11_4 = arg_11_0:getGroupNameListByTaskId(var_11_2)
	local var_11_5 = PlayerCardModel.instance:getCardInfo().achievementCount

	return var_11_3, var_11_4, var_11_5
end

function var_0_0.statSetProgress(arg_12_0)
	local var_12_0 = arg_12_0:getStatProgress()

	StatController.instance:track(StatEnum.EventName.PlaycardSetGameProgress, {
		[StatEnum.EventProperties.GameProgress] = var_12_0
	})
end

function var_0_0.getStatProgress(arg_13_0)
	local var_13_0 = {}
	local var_13_1 = PlayerCardModel.instance:getCardInfo()
	local var_13_2 = var_13_1:getProgressSetting()

	if var_13_2 and #var_13_2 > 0 then
		for iter_13_0, iter_13_1 in ipairs(var_13_2) do
			local var_13_3 = iter_13_1[2]
			local var_13_4 = PlayerCardConfig.instance:getCardProgressById(var_13_3).name
			local var_13_5 = var_13_1:getProgressByIndex(var_13_3)

			table.insert(var_13_0, var_13_4)
			table.insert(var_13_0, var_13_5)
		end
	end

	return var_13_0
end

function var_0_0.getStatBaseInfo(arg_14_0)
	local var_14_0 = {}
	local var_14_1 = PlayerCardModel.instance:getCardInfo()
	local var_14_2 = PlayerCardConfig.instance:getCardBaseInfoById(1).name
	local var_14_3 = var_14_1:getBaseInfoByIndex(1)

	table.insert(var_14_0, var_14_2)
	table.insert(var_14_0, var_14_3)

	local var_14_4 = var_14_1:getBaseInfoSetting()

	if var_14_4 and #var_14_4 > 0 then
		for iter_14_0, iter_14_1 in ipairs(var_14_4) do
			local var_14_5 = iter_14_1[2]
			local var_14_6 = PlayerCardConfig.instance:getCardBaseInfoById(var_14_5).name
			local var_14_7 = var_14_1:getBaseInfoByIndex(var_14_5)

			table.insert(var_14_0, var_14_6)
			table.insert(var_14_0, var_14_7)
		end
	end

	return var_14_0
end

function var_0_0.statSetBaseInfo(arg_15_0)
	local var_15_0 = arg_15_0:getStatBaseInfo()

	StatController.instance:track(StatEnum.EventName.PlaycardSetBasicInfomation, {
		[StatEnum.EventProperties.BaseInfomation] = var_15_0
	})
end

function var_0_0.statSetCritter(arg_16_0)
	local var_16_0, var_16_1 = arg_16_0:getStatCritter()

	StatController.instance:track(StatEnum.EventName.PlaycardSetCritter, {
		[StatEnum.EventProperties.CritterId] = var_16_0,
		[StatEnum.EventProperties.CritterName] = var_16_1
	})
end

function var_0_0.getStatCritter(arg_17_0)
	local var_17_0 = PlayerCardModel.instance:getCritterOpen()
	local var_17_1 = ""
	local var_17_2

	if var_17_0 then
		local var_17_3, var_17_4 = PlayerCardModel.instance:getCardInfo():getCritter()

		if not string.nilorempty(var_17_3) then
			var_17_2 = CritterConfig.instance:getCritterName(var_17_3)
		end
	end

	return var_17_1, var_17_2
end

function var_0_0.getAchievementNameListByTaskId(arg_18_0, arg_18_1)
	local var_18_0 = {}
	local var_18_1 = {}

	if arg_18_1 and #arg_18_1 > 0 then
		for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
			local var_18_2 = AchievementConfig.instance:getTask(iter_18_1)

			if var_18_2 and not var_18_1[var_18_2.achievementId] then
				local var_18_3 = AchievementConfig.instance:getAchievement(var_18_2.achievementId)
				local var_18_4 = var_18_3 and var_18_3.name or ""

				table.insert(var_18_0, var_18_4)

				var_18_1[var_18_2.achievementId] = true
			end
		end
	end

	return var_18_0
end

function var_0_0.getUseTime(arg_19_0)
	local var_19_0 = 0

	if arg_19_0.startTime then
		var_19_0 = ServerTime.now() - arg_19_0.startTime
	end

	return var_19_0
end

function var_0_0.getGroupNameListByTaskId(arg_20_0, arg_20_1)
	local var_20_0 = {}
	local var_20_1 = {}

	if arg_20_1 and #arg_20_1 > 0 then
		for iter_20_0, iter_20_1 in ipairs(arg_20_1) do
			local var_20_2 = AchievementConfig.instance:getTask(iter_20_1)

			if var_20_2 then
				local var_20_3 = AchievementConfig.instance:getAchievement(var_20_2.achievementId)
				local var_20_4 = var_20_3 and var_20_3.groupId
				local var_20_5 = AchievementConfig.instance:getGroup(var_20_4)

				if var_20_5 and not var_20_1[var_20_4] then
					local var_20_6 = var_20_5 and var_20_5.name or ""

					table.insert(var_20_0, var_20_6)

					var_20_1[var_20_4] = true
				end
			end
		end
	end

	return var_20_0
end

function var_0_0.getSkinName(arg_21_0)
	local var_21_0 = PlayerCardModel.instance:getCardInfo():getThemeId()

	if var_21_0 ~= 0 then
		return ItemConfig.instance:getItemCo(var_21_0).name
	end

	return "默认"
end

function var_0_0.getHeadName(arg_22_0)
	local var_22_0 = PlayerModel.instance:getPlayinfo().portrait

	return lua_item.configDict[var_22_0].name
end

function var_0_0.ShowChangeBgSkin(arg_23_0, arg_23_1)
	local function var_23_0()
		PlayerCardRpc.instance:sendSetPlayerCardThemeRequest(arg_23_1)
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.PlayerCardChangeSkinTips, MsgBoxEnum.BoxType.Yes_No, var_23_0)
	arg_23_0:setBgSkinRed(arg_23_1, true)
	PlayerCardModel.instance:setShowRed()
end

function var_0_0.getBgSkinRed(arg_25_0, arg_25_1)
	local var_25_0 = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.PlayerCardNewBgSkinRed) .. arg_25_1

	return PlayerPrefsHelper.getNumber(var_25_0, 0)
end

function var_0_0.setBgSkinRed(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_2 and 1 or 0
	local var_26_1 = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.PlayerCardNewBgSkinRed) .. arg_26_1

	PlayerPrefsHelper.setNumber(var_26_1, var_26_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
