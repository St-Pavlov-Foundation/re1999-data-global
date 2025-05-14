module("modules.logic.versionactivity2_5.challenge.controller.Act183Helper", package.seeall)

local var_0_0 = _M

function var_0_0.isDailyGroupEpisodeUnlock(arg_1_0)
	if var_0_0.getDailyGroupEpisodeUnlockRemainTime(arg_1_0) <= 0 then
		return true
	end
end

function var_0_0.getDailyGroupEpisodeUnlockRemainTime(arg_2_0)
	local var_2_0 = lua_challenge_daily_unlock.configDict[arg_2_0]

	if not var_2_0 then
		logError(string.format("获取日常关卡组解锁剩余时间失败! 失败原因:找不到关卡组解锁配置 groupId = %s", arg_2_0))

		return 0
	end

	local var_2_1 = Act183Model.instance:getActivityId()

	return ActivityModel.instance:getActStartTime(var_2_1) / 1000 + var_2_0.unlock - ServerTime.now()
end

function var_0_0.getEpisodeType(arg_3_0)
	local var_3_0 = Act183Config.instance:getEpisodeCo(arg_3_0)
	local var_3_1 = var_3_0 and var_3_0.order

	if var_3_1 and var_3_1 > 100 then
		return Act183Enum.EpisodeType.Boss
	end

	return Act183Enum.EpisodeType.Sub
end

function var_0_0.getGroupType(arg_4_0)
	local var_4_0 = Act183Config.instance:getEpisodeCo(arg_4_0)

	return var_4_0 and var_4_0.type
end

function var_0_0.setRuleIcon(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_2 then
		logError("图片组件为空")

		return
	end

	local var_5_0 = Act183Config.instance:getEpisodeCo(arg_5_0)
	local var_5_1 = var_5_0 and var_5_0.ruleIcon

	if string.nilorempty(var_5_1) then
		logError(string.format("关卡机制图标配置不存在: episodeId = %s, ruleIcon = %s", arg_5_0, var_5_1))

		return
	end

	UISpriteSetMgr.instance:setChallengeSprite(arg_5_2, var_5_1)
end

function var_0_0.setEpisodeIcon(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_2 then
		logError("图片组件为空")

		return
	end

	local var_6_0 = Act183Config.instance:getEpisodeCo(arg_6_0)
	local var_6_1 = var_6_0 and var_6_0.icon

	if string.nilorempty(var_6_1) then
		logError(string.format("关卡图标配置不存在: episodeId = %s", arg_6_0))

		return
	end

	local var_6_2 = var_6_1

	if var_6_0.type == Act183Enum.GroupType.Daily then
		var_6_2 = "daily/" .. var_6_2

		ZProj.UGUIHelper.SetGrayscale(arg_6_2.gameObject, arg_6_1 ~= Act183Enum.EpisodeStatus.Finished)
	elseif var_0_0.getEpisodeType(arg_6_0) ~= Act183Enum.EpisodeType.Boss then
		if arg_6_1 ~= Act183Enum.EpisodeStatus.Finished then
			var_6_2 = var_6_2 .. "_0"
		else
			var_6_2 = var_6_2 .. "_1"
		end
	elseif arg_6_1 == Act183Enum.EpisodeStatus.Locked then
		var_6_2 = var_6_2 .. "_0"
	else
		var_6_2 = var_6_2 .. "_1"
	end

	arg_6_2:LoadImage(ResUrl.getChallengeIcon(var_6_2), function(arg_7_0, arg_7_1)
		recthelper.setSize(arg_6_2.transform, arg_7_0, arg_7_1)
	end)
end

function var_0_0.setEpisodeReportIcon(arg_8_0, arg_8_1)
	if not arg_8_1 then
		logError("图片组件为空")

		return
	end

	local var_8_0 = Act183Config.instance:getEpisodeCo(arg_8_0)
	local var_8_1 = var_8_0 and var_8_0.reportIcon

	if string.nilorempty(var_8_1) then
		logError(string.format("通关记录界面图标配置不存在: episodeId = %s", arg_8_0))

		return
	end

	UISpriteSetMgr.instance:setChallengeSprite(arg_8_1, var_8_1)
end

function var_0_0.setSubEpisodeResultIcon(arg_9_0, arg_9_1)
	if not arg_9_1 then
		logError("图片组件为空")

		return
	end

	local var_9_0 = var_0_0.getEpisodeResultIcon(arg_9_0)

	if not var_9_0 then
		return
	end

	UISpriteSetMgr.instance:setChallengeSprite(arg_9_1, var_9_0)
end

function var_0_0.setBossEpisodeResultIcon(arg_10_0, arg_10_1)
	if not arg_10_1 then
		logError("图片组件为空")

		return
	end

	local var_10_0 = var_0_0.getEpisodeResultIcon(arg_10_0)

	if not var_10_0 then
		return
	end

	local var_10_1 = ResUrl.getChallengeIcon("result/" .. var_10_0)

	arg_10_1:LoadImage(var_10_1, function(arg_11_0, arg_11_1)
		recthelper.setSize(arg_10_1.transform, arg_11_0, arg_11_1)
	end)
end

function var_0_0.getEpisodeResultIcon(arg_12_0)
	local var_12_0 = Act183Config.instance:getEpisodeCo(arg_12_0)
	local var_12_1 = var_12_0 and var_12_0.resultIcon

	if string.nilorempty(var_12_1) then
		logError(string.format("结算界面图标配置不存在: episodeId = %s", arg_12_0))

		return
	end

	return var_12_1
end

function var_0_0.getRoundStage(arg_13_0)
	local var_13_0 = lua_challenge_const.configDict[Act183Enum.Const.RoundStage]
	local var_13_1 = var_13_0 and var_13_0.value2

	if string.nilorempty(var_13_1) then
		logError("缺少回合数挡位配置")

		return 1
	end

	local var_13_2 = string.splitToNumber(var_13_1, "#")

	for iter_13_0, iter_13_1 in ipairs(var_13_2) do
		if arg_13_0 <= iter_13_1 then
			return iter_13_0
		end
	end

	return #var_13_2 + 1
end

function var_0_0.getGroupEpisodeTaskProgress(arg_14_0)
	local var_14_0 = Act183Config.instance:getAllOnlineGroupTasks(arg_14_0)
	local var_14_1 = var_14_0 and #var_14_0 or 0
	local var_14_2 = 0

	if var_14_0 then
		for iter_14_0, iter_14_1 in ipairs(var_14_0) do
			if var_0_0.isTaskFinished(iter_14_1.id) then
				var_14_2 = var_14_2 + 1
			end
		end
	end

	return var_14_1, var_14_2
end

function var_0_0.getUnlockSupportHeroIds(arg_15_0, arg_15_1)
	local var_15_0 = {}
	local var_15_1 = Act183Config.instance:getActivityBadgeCos(arg_15_0)

	if var_15_1 then
		for iter_15_0, iter_15_1 in ipairs(var_15_1) do
			if arg_15_1 >= iter_15_1.num and iter_15_1.unlockSupport ~= 0 then
				table.insert(var_15_0, iter_15_1.unlockSupport)
			end
		end
	end

	return var_15_0
end

function var_0_0.isEpisodeCanUseBadge(arg_16_0)
	local var_16_0 = Act183Config.instance:getEpisodeCo(arg_16_0)

	if var_16_0 then
		return var_16_0.type == Act183Enum.GroupType.NormalMain
	end
end

function var_0_0.isEpisodeCanUseSupportHero(arg_17_0)
	local var_17_0 = Act183Config.instance:getEpisodeCo(arg_17_0)

	if var_17_0 then
		return var_17_0.type == Act183Enum.GroupType.NormalMain or var_17_0.type == Act183Enum.GroupType.Daily
	end
end

function var_0_0.generateDungeonViewParams(arg_18_0, arg_18_1)
	local var_18_0 = {}

	if arg_18_0 == Act183Enum.GroupType.Daily then
		table.insert(var_18_0, Act183Enum.GroupType.Daily)
	elseif arg_18_0 == Act183Enum.GroupType.NormalMain or arg_18_0 == Act183Enum.GroupType.HardMain then
		table.insert(var_18_0, Act183Enum.GroupType.NormalMain)
		table.insert(var_18_0, Act183Enum.GroupType.HardMain)
	end

	return {
		selectGroupId = arg_18_1,
		groupTypes = var_18_0
	}
end

function var_0_0.generateDungeonViewParams2(arg_19_0, arg_19_1)
	local var_19_0 = Act183Config.instance:getEpisodeCo(arg_19_0)
	local var_19_1 = var_19_0 and var_19_0.type
	local var_19_2 = var_19_0 and var_19_0.groupId
	local var_19_3 = var_0_0.generateDungeonViewParams(var_19_1, var_19_2)

	var_19_3.selectEpisodeId = arg_19_1 and var_19_0.episodeId

	return var_19_3
end

function var_0_0.rpcInfosToList(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = {}

	for iter_20_0, iter_20_1 in ipairs(arg_20_0) do
		local var_20_1 = arg_20_1.New()

		var_20_1:init(iter_20_1, arg_20_2)
		table.insert(var_20_0, var_20_1)
	end

	return var_20_0
end

function var_0_0.listToMap(arg_21_0)
	local var_21_0 = {}

	if arg_21_0 then
		for iter_21_0, iter_21_1 in ipairs(arg_21_0) do
			var_21_0[iter_21_1] = iter_21_1
		end
	end

	return var_21_0
end

function var_0_0.generateStartDungeonParams(arg_22_0)
	local var_22_0 = {}

	if var_0_0.isEpisodeCanUseBadge(arg_22_0) then
		var_22_0.useBadgeNum = tostring(Act183Model.instance:getEpisodeReadyUseBadgeNum())
	end

	if var_0_0.getEpisodeType(arg_22_0) == Act183Enum.EpisodeType.Boss then
		local var_22_1 = Act183Model.instance:getRecordEpisodeSelectConditions()

		if var_22_1 and #var_22_1 > 0 then
			var_22_0.chooseConditions = var_22_1
		end
	end

	return (cjson.encode(var_22_0))
end

function var_0_0.getSelectConditionIdsInLocal(arg_23_0, arg_23_1)
	local var_23_0 = var_0_0._generateSaveSelectCollectionIdsKey(arg_23_0, arg_23_1)
	local var_23_1 = PlayerPrefsHelper.getString(var_23_0, "")

	return (string.splitToNumber(var_23_1, "#"))
end

function var_0_0.saveSelectConditionIdsInLocal(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_2 then
		local var_24_0 = table.concat(arg_24_2, "#")
		local var_24_1 = var_0_0._generateSaveSelectCollectionIdsKey(arg_24_0, arg_24_1)

		PlayerPrefsHelper.setString(var_24_1, var_24_0)
	end
end

function var_0_0._generateSaveSelectCollectionIdsKey(arg_25_0, arg_25_1)
	return string.format("%s#%s#%s#%s", PlayerPrefsKey.Act183BossEpisodeSelectConditions, PlayerModel.instance:getMyUserId(), arg_25_0, arg_25_1)
end

function var_0_0.isHeroGroupPositionOpen(arg_26_0, arg_26_1)
	local var_26_0 = DungeonConfig.instance:getEpisodeCO(arg_26_0)
	local var_26_1 = var_26_0 and var_26_0.battleId or 0
	local var_26_2 = lua_battle.configDict[var_26_1]
	local var_26_3 = var_26_2 and var_26_2.roleNum or 0

	if var_26_3 <= 0 then
		logError(string.format("编队解锁位置数量错误 episodeId = %s, battleId = %s, roleNum = %s", arg_26_0, var_26_1, var_26_3))
	end

	return arg_26_1 > 0 and arg_26_1 <= var_26_3
end

function var_0_0.setTranPositionAndRotation(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = arg_27_2[arg_27_1]

	if not var_27_0 or #var_27_0 < 5 then
		logError(string.format("缺少坐标及旋转配置 episodeId = %s, order = %s", arg_27_0, arg_27_1))

		return
	end

	local var_27_1 = var_27_0[1]
	local var_27_2 = var_27_0[2]
	local var_27_3 = var_27_0[3]
	local var_27_4 = var_27_0[4]
	local var_27_5 = var_27_0[5]

	transformhelper.setLocalRotation(arg_27_3, var_27_3, var_27_4, var_27_5)
	recthelper.setAnchor(arg_27_3, var_27_1, var_27_2)
end

function var_0_0.isTaskFinished(arg_28_0)
	return var_0_0.isTaskHasGetReward(arg_28_0) or var_0_0.isTaskCanGetReward(arg_28_0)
end

function var_0_0.isTaskCanGetReward(arg_29_0)
	local var_29_0 = TaskModel.instance:getTaskById(arg_29_0)

	if var_29_0 then
		return var_29_0.finishCount == 0 and var_29_0.progress >= var_29_0.config.maxProgress
	end
end

function var_0_0.isTaskHasGetReward(arg_30_0)
	return TaskModel.instance:isTaskFinish(TaskEnum.TaskType.Activity183, arg_30_0)
end

function var_0_0.getLastEnterMainGroupTypeInLocal(arg_31_0, arg_31_1)
	local var_31_0 = var_0_0._generateSaveLastEnterMainGroupTypeKey(arg_31_0)

	return (tonumber(PlayerPrefsHelper.getNumber(var_31_0, tonumber(arg_31_1))))
end

function var_0_0.saveLastEnterMainGroupTypeInLocal(arg_32_0, arg_32_1)
	if arg_32_1 then
		local var_32_0 = var_0_0._generateSaveLastEnterMainGroupTypeKey(arg_32_0)

		PlayerPrefsHelper.setNumber(var_32_0, arg_32_1)
	end
end

function var_0_0._generateSaveLastEnterMainGroupTypeKey(arg_33_0)
	return string.format("%s#%s#%s", PlayerPrefsKey.Act183LastEnterMainGroupType, PlayerModel.instance:getMyUserId(), arg_33_0)
end

function var_0_0.getLastTotalBadgeNumInLocal(arg_34_0)
	local var_34_0 = var_0_0._generateSaveLastTotalBadgeNumInLocal(arg_34_0)

	return (tonumber(PlayerPrefsHelper.getNumber(var_34_0, 0)))
end

function var_0_0.saveLastTotalBadgeNumInLocal(arg_35_0, arg_35_1)
	if arg_35_0 and arg_35_1 then
		local var_35_0 = var_0_0._generateSaveLastTotalBadgeNumInLocal(arg_35_0)

		PlayerPrefsHelper.setNumber(var_35_0, arg_35_1)
	end
end

function var_0_0._generateSaveLastTotalBadgeNumInLocal(arg_36_0)
	return string.format("%s#%s#%s", PlayerPrefsKey.Act183LastTotalBadgeNum, PlayerModel.instance:getMyUserId(), arg_36_0)
end

function var_0_0.getUnlockGroupIdsInLocal(arg_37_0)
	local var_37_0 = var_0_0._generateHasPlayUnlockAnimGroupIdsKey(arg_37_0)
	local var_37_1 = PlayerPrefsHelper.getString(var_37_0, "")

	return (string.splitToNumber(var_37_1, "#"))
end

function var_0_0.saveUnlockGroupIdsInLocal(arg_38_0, arg_38_1)
	if arg_38_0 and arg_38_1 then
		local var_38_0 = var_0_0._generateHasPlayUnlockAnimGroupIdsKey(arg_38_0)
		local var_38_1 = table.concat(arg_38_1, "#")

		PlayerPrefsHelper.setString(var_38_0, var_38_1)
	end
end

function var_0_0._generateHasPlayUnlockAnimGroupIdsKey(arg_39_0)
	return string.format("%s#%s#%s", PlayerPrefsKey.Act183HasPlayUnlockAnimGroupIds, PlayerModel.instance:getMyUserId(), arg_39_0)
end

function var_0_0.isLastPassEpisodeInType(arg_40_0)
	if (arg_40_0 and arg_40_0:getStatus()) ~= Act183Enum.EpisodeStatus.Finished then
		return
	end

	local var_40_0 = arg_40_0:getGroupType()
	local var_40_1 = arg_40_0:getPassOrder()
	local var_40_2 = false

	if var_40_0 == Act183Enum.GroupType.Daily then
		var_40_2 = var_40_1 >= Act183Enum.MaxDailySubEpisodesNum
	else
		var_40_2 = var_40_1 >= Act183Enum.MaxMainSubEpisodesNum
	end

	return var_40_2
end

function var_0_0.getHasReadUnlockSupportHeroIdsInLocal(arg_41_0)
	local var_41_0 = var_0_0._generateSaveHasReadUnlockSupportHeroIdsKey(arg_41_0)
	local var_41_1 = PlayerPrefsHelper.getString(var_41_0, "")

	return (string.splitToNumber(var_41_1, "#"))
end

function var_0_0.saveHasReadUnlockSupportHeroIdsInLocal(arg_42_0, arg_42_1)
	if arg_42_1 then
		local var_42_0 = var_0_0._generateSaveHasReadUnlockSupportHeroIdsKey(arg_42_0)
		local var_42_1 = table.concat(arg_42_1, "#")

		PlayerPrefsHelper.setString(var_42_0, var_42_1)
	end
end

function var_0_0._generateSaveHasReadUnlockSupportHeroIdsKey(arg_43_0)
	return string.format("%s#%s#%s", PlayerPrefsKey.Act183HasReadUnlockSupportHeroIds, PlayerModel.instance:getMyUserId(), arg_43_0)
end

function var_0_0.getHasPlayRefreshAnimRuleIdsInLocal(arg_44_0)
	local var_44_0 = var_0_0._generateHasPlayRefreshAnimRuleIdsKey(arg_44_0)
	local var_44_1 = PlayerPrefsHelper.getString(var_44_0, "")

	return (string.split(var_44_1, "#"))
end

function var_0_0.saveHasPlayRefreshAnimRuleIdsInLocal(arg_45_0, arg_45_1)
	if arg_45_1 then
		local var_45_0 = var_0_0._generateHasPlayRefreshAnimRuleIdsKey(arg_45_0)
		local var_45_1 = table.concat(arg_45_1, "#")

		PlayerPrefsHelper.setString(var_45_0, var_45_1)
	end
end

function var_0_0._generateHasPlayRefreshAnimRuleIdsKey(arg_46_0)
	return string.format("%s#%s#%s", PlayerPrefsKey.Act183HasPlayRefreshAnimRuleIds, PlayerModel.instance:getMyUserId(), arg_46_0)
end

function var_0_0.getBadgeItemConfig()
	local var_47_0 = lua_challenge_const.configDict[Act183Enum.Const.BadgeItemId]
	local var_47_1 = var_47_0 and tonumber(var_47_0.value)

	if CurrencyConfig.instance:getCurrencyCo(var_47_1) then
		return MaterialEnum.MaterialType.Currency, var_47_1
	end
end

function var_0_0.getMaxBadgeNum()
	return tonumber(lua_challenge_const.configDict[Act183Enum.Const.MaxBadgeNum].value)
end

function var_0_0.isGetBadgeNumMax()
	local var_49_0 = Act183Model.instance:getBadgeNum()
	local var_49_1 = var_0_0.getMaxBadgeNum()

	if var_49_0 and var_49_1 then
		return var_49_1 <= var_49_0
	end
end

function var_0_0.getTaskCanGetBadgeNums(arg_50_0)
	local var_50_0 = 0

	if arg_50_0 then
		for iter_50_0, iter_50_1 in ipairs(arg_50_0) do
			local var_50_1 = TaskModel.instance:getTaskById(iter_50_1)
			local var_50_2 = var_50_1 and var_50_1.config

			var_50_0 = var_50_0 + (var_50_2 and var_50_2.badgeNum or 0)
		end
	end

	local var_50_3 = Act183Model.instance:getBadgeNum()
	local var_50_4 = var_0_0.getMaxBadgeNum() - var_50_3
	local var_50_5 = var_50_4 <= var_50_0 and var_50_4 or var_50_0

	return var_50_0, var_50_5
end

function var_0_0.showToastWhileCanTaskRewards(arg_51_0)
	local var_51_0, var_51_1 = var_0_0.getTaskCanGetBadgeNums(arg_51_0)
	local var_51_2 = var_0_0.isGetBadgeNumMax()

	if var_51_1 > 0 then
		GameFacade.showToast(ToastEnum.Act183GetBadgeNum, var_51_1)
	end

	if var_51_0 > 0 and var_51_2 then
		GameFacade.showToast(ToastEnum.Act183GetBadgeMax)
	end
end

function var_0_0.isOnlyCanUseLimitPlayerCloth(arg_52_0)
	local var_52_0 = var_0_0.getGroupType(arg_52_0)
	local var_52_1 = var_0_0.getLimitUsePlayerCloth()

	return var_52_0 ~= Act183Enum.GroupType.Daily and var_52_1 and var_52_1 ~= 0
end

function var_0_0.getLimitUsePlayerCloth()
	local var_53_0 = lua_challenge_const.configDict[Act183Enum.Const.PlayerClothIds]
	local var_53_1 = var_53_0 and var_53_0.value

	if var_53_1 then
		return tonumber(var_53_1)
	end
end

return var_0_0
