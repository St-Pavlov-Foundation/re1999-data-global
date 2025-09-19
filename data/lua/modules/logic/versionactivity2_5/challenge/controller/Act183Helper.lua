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

function var_0_0.isEpisodeHasRule(arg_5_0)
	local var_5_0 = Act183Config.instance:getEpisodeCo(arg_5_0)
	local var_5_1 = var_5_0 and var_5_0.ruleIcon

	return not string.nilorempty(var_5_1)
end

function var_0_0.setRuleIcon(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_2 then
		logError("图片组件为空")

		return
	end

	local var_6_0 = Act183Config.instance:getEpisodeCo(arg_6_0)
	local var_6_1 = var_6_0 and var_6_0.ruleIcon

	if string.nilorempty(var_6_1) then
		logError(string.format("关卡机制图标配置不存在: episodeId = %s", arg_6_0))

		return
	end

	UISpriteSetMgr.instance:setChallengeSprite(arg_6_2, var_6_1)
end

function var_0_0.setEpisodeIcon(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_2 then
		logError("图片组件为空")

		return
	end

	local var_7_0 = Act183Config.instance:getEpisodeCo(arg_7_0)
	local var_7_1 = var_7_0 and var_7_0.icon

	if string.nilorempty(var_7_1) then
		logError(string.format("关卡图标配置不存在: episodeId = %s", arg_7_0))

		return
	end

	local var_7_2 = var_7_1

	if var_7_0.type == Act183Enum.GroupType.Daily then
		var_7_2 = "daily/" .. var_7_2

		ZProj.UGUIHelper.SetGrayscale(arg_7_2.gameObject, arg_7_1 ~= Act183Enum.EpisodeStatus.Finished)
	elseif var_0_0.getEpisodeType(arg_7_0) ~= Act183Enum.EpisodeType.Boss then
		if arg_7_1 ~= Act183Enum.EpisodeStatus.Finished then
			var_7_2 = var_7_2 .. "_0"
		else
			var_7_2 = var_7_2 .. "_1"
		end
	elseif arg_7_1 == Act183Enum.EpisodeStatus.Locked then
		var_7_2 = var_7_2 .. "_0"
	else
		var_7_2 = var_7_2 .. "_1"
	end

	arg_7_2:LoadImage(ResUrl.getChallengeIcon(var_7_2), function(arg_8_0, arg_8_1)
		recthelper.setSize(arg_7_2.transform, arg_8_0, arg_8_1)
	end)
end

function var_0_0.setEpisodeReportIcon(arg_9_0, arg_9_1)
	if not arg_9_1 then
		logError("图片组件为空")

		return
	end

	local var_9_0 = Act183Config.instance:getEpisodeCo(arg_9_0)
	local var_9_1 = var_9_0 and var_9_0.reportIcon

	if string.nilorempty(var_9_1) then
		logError(string.format("通关记录界面图标配置不存在: episodeId = %s", arg_9_0))

		return
	end

	UISpriteSetMgr.instance:setChallengeSprite(arg_9_1, var_9_1)
end

function var_0_0.setSubEpisodeResultIcon(arg_10_0, arg_10_1)
	if not arg_10_1 then
		logError("图片组件为空")

		return
	end

	local var_10_0 = var_0_0.getEpisodeResultIcon(arg_10_0)

	if not var_10_0 then
		return
	end

	UISpriteSetMgr.instance:setChallengeSprite(arg_10_1, var_10_0)
end

function var_0_0.setBossEpisodeResultIcon(arg_11_0, arg_11_1)
	if not arg_11_1 then
		logError("图片组件为空")

		return
	end

	local var_11_0 = var_0_0.getEpisodeResultIcon(arg_11_0)

	if not var_11_0 then
		return
	end

	local var_11_1 = ResUrl.getChallengeIcon("result/" .. var_11_0)

	arg_11_1:LoadImage(var_11_1, function(arg_12_0, arg_12_1)
		recthelper.setSize(arg_11_1.transform, arg_12_0, arg_12_1)
	end)
end

function var_0_0.getEpisodeResultIcon(arg_13_0)
	local var_13_0 = Act183Config.instance:getEpisodeCo(arg_13_0)
	local var_13_1 = var_13_0 and var_13_0.resultIcon

	if string.nilorempty(var_13_1) then
		logError(string.format("结算界面图标配置不存在: episodeId = %s", arg_13_0))

		return
	end

	return var_13_1
end

function var_0_0.getRoundStage(arg_14_0)
	local var_14_0 = lua_challenge_const.configDict[Act183Enum.Const.RoundStage]
	local var_14_1 = var_14_0 and var_14_0.value2

	if string.nilorempty(var_14_1) then
		logError("缺少回合数挡位配置")

		return 1
	end

	local var_14_2 = string.splitToNumber(var_14_1, "#")

	for iter_14_0, iter_14_1 in ipairs(var_14_2) do
		if arg_14_0 <= iter_14_1 then
			return iter_14_0
		end
	end

	return #var_14_2 + 1
end

function var_0_0.getGroupEpisodeTaskProgress(arg_15_0, arg_15_1)
	local var_15_0 = Act183Config.instance:getAllOnlineGroupTasks(arg_15_0, arg_15_1)
	local var_15_1 = var_15_0 and #var_15_0 or 0
	local var_15_2 = 0

	if var_15_0 then
		for iter_15_0, iter_15_1 in ipairs(var_15_0) do
			if var_0_0.isTaskFinished(iter_15_1.id) then
				var_15_2 = var_15_2 + 1
			end
		end
	end

	return var_15_1, var_15_2
end

function var_0_0.getUnlockSupportHeroIds(arg_16_0, arg_16_1)
	local var_16_0 = {}
	local var_16_1 = Act183Config.instance:getActivityBadgeCos(arg_16_0)

	if var_16_1 then
		for iter_16_0, iter_16_1 in ipairs(var_16_1) do
			if arg_16_1 >= iter_16_1.num and iter_16_1.unlockSupport ~= 0 then
				table.insert(var_16_0, iter_16_1.unlockSupport)
			end
		end
	end

	return var_16_0
end

function var_0_0.isEpisodeCanUseBadge(arg_17_0)
	local var_17_0 = Act183Config.instance:getEpisodeCo(arg_17_0)

	if var_17_0 then
		return var_17_0.type == Act183Enum.GroupType.NormalMain
	end
end

function var_0_0.isEpisodeCanUseSupportHero(arg_18_0)
	local var_18_0 = Act183Config.instance:getEpisodeCo(arg_18_0)

	if var_18_0 then
		return var_18_0.type == Act183Enum.GroupType.NormalMain or var_18_0.type == Act183Enum.GroupType.Daily
	end
end

function var_0_0.generateDungeonViewParams(arg_19_0, arg_19_1)
	local var_19_0 = {}

	if arg_19_0 == Act183Enum.GroupType.Daily then
		table.insert(var_19_0, Act183Enum.GroupType.Daily)
	elseif arg_19_0 == Act183Enum.GroupType.NormalMain or arg_19_0 == Act183Enum.GroupType.HardMain then
		table.insert(var_19_0, Act183Enum.GroupType.NormalMain)
		table.insert(var_19_0, Act183Enum.GroupType.HardMain)
	end

	return {
		selectGroupId = arg_19_1,
		groupTypes = var_19_0
	}
end

function var_0_0.generateDungeonViewParams2(arg_20_0, arg_20_1)
	local var_20_0 = Act183Config.instance:getEpisodeCo(arg_20_0)
	local var_20_1 = var_20_0 and var_20_0.type
	local var_20_2 = var_20_0 and var_20_0.groupId
	local var_20_3 = var_0_0.generateDungeonViewParams(var_20_1, var_20_2)

	var_20_3.selectEpisodeId = arg_20_1 and var_20_0.episodeId

	return var_20_3
end

function var_0_0.generateDungeonViewParams3(arg_21_0, arg_21_1)
	local var_21_0 = Act183Config.instance:getEpisodeCosByGroupId(arg_21_0, arg_21_1)
	local var_21_1 = var_21_0 and var_21_0[1]
	local var_21_2 = var_21_1 and var_21_1.type
	local var_21_3 = var_21_1 and var_21_1.groupId

	return (var_0_0.generateDungeonViewParams(var_21_2, var_21_3))
end

function var_0_0.rpcInfosToList(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = {}

	for iter_22_0, iter_22_1 in ipairs(arg_22_0) do
		local var_22_1 = arg_22_1.New()

		var_22_1:init(iter_22_1, arg_22_2)
		table.insert(var_22_0, var_22_1)
	end

	return var_22_0
end

function var_0_0.listToMap(arg_23_0)
	local var_23_0 = {}

	if arg_23_0 then
		for iter_23_0, iter_23_1 in ipairs(arg_23_0) do
			var_23_0[iter_23_1] = iter_23_1
		end
	end

	return var_23_0
end

function var_0_0.generateStartDungeonParams(arg_24_0)
	local var_24_0 = {}

	if var_0_0.isEpisodeCanUseBadge(arg_24_0) then
		var_24_0.useBadgeNum = tostring(Act183Model.instance:getEpisodeReadyUseBadgeNum())
	end

	if var_0_0.getEpisodeType(arg_24_0) == Act183Enum.EpisodeType.Boss then
		local var_24_1 = Act183Model.instance:getRecordEpisodeSelectConditions()

		if var_24_1 and #var_24_1 > 0 then
			var_24_0.chooseConditions = var_24_1
		end
	end

	return (cjson.encode(var_24_0))
end

function var_0_0.getSelectConditionIdsInLocal(arg_25_0, arg_25_1)
	local var_25_0 = var_0_0._generateSaveSelectCollectionIdsKey(arg_25_0, arg_25_1)
	local var_25_1 = PlayerPrefsHelper.getString(var_25_0, "")

	return (string.splitToNumber(var_25_1, "#"))
end

function var_0_0.saveSelectConditionIdsInLocal(arg_26_0, arg_26_1, arg_26_2)
	if arg_26_2 then
		local var_26_0 = table.concat(arg_26_2, "#")
		local var_26_1 = var_0_0._generateSaveSelectCollectionIdsKey(arg_26_0, arg_26_1)

		PlayerPrefsHelper.setString(var_26_1, var_26_0)
	end
end

function var_0_0._generateSaveSelectCollectionIdsKey(arg_27_0, arg_27_1)
	return string.format("%s#%s#%s#%s", PlayerPrefsKey.Act183BossEpisodeSelectConditions, PlayerModel.instance:getMyUserId(), arg_27_0, arg_27_1)
end

function var_0_0.isHeroGroupPositionOpen(arg_28_0, arg_28_1)
	local var_28_0 = DungeonConfig.instance:getEpisodeCO(arg_28_0)
	local var_28_1 = var_28_0 and var_28_0.battleId or 0
	local var_28_2 = lua_battle.configDict[var_28_1]
	local var_28_3 = var_28_2 and var_28_2.roleNum or 0

	if var_28_3 <= 0 then
		logError(string.format("编队解锁位置数量错误 episodeId = %s, battleId = %s, roleNum = %s", arg_28_0, var_28_1, var_28_3))
	end

	return arg_28_1 > 0 and arg_28_1 <= var_28_3
end

function var_0_0.setTranPositionAndRotation(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = arg_29_2[arg_29_1]

	if not var_29_0 or #var_29_0 < 5 then
		logError(string.format("缺少坐标及旋转配置 episodeId = %s, order = %s", arg_29_0, arg_29_1))

		return
	end

	local var_29_1 = var_29_0[1]
	local var_29_2 = var_29_0[2]
	local var_29_3 = var_29_0[3]
	local var_29_4 = var_29_0[4]
	local var_29_5 = var_29_0[5]

	transformhelper.setLocalRotation(arg_29_3, var_29_3, var_29_4, var_29_5)
	recthelper.setAnchor(arg_29_3, var_29_1, var_29_2)
end

function var_0_0.isTaskFinished(arg_30_0)
	return var_0_0.isTaskHasGetReward(arg_30_0) or var_0_0.isTaskCanGetReward(arg_30_0)
end

function var_0_0.isTaskCanGetReward(arg_31_0)
	local var_31_0 = TaskModel.instance:getTaskById(arg_31_0)

	if var_31_0 then
		return var_31_0.finishCount == 0 and var_31_0.progress >= var_31_0.config.maxProgress
	end
end

function var_0_0.isTaskHasGetReward(arg_32_0)
	return TaskModel.instance:isTaskFinish(TaskEnum.TaskType.Activity183, arg_32_0)
end

function var_0_0.getLastEnterMainGroupTypeInLocal(arg_33_0, arg_33_1)
	local var_33_0 = var_0_0._generateSaveLastEnterMainGroupTypeKey(arg_33_0)

	return (tonumber(PlayerPrefsHelper.getNumber(var_33_0, tonumber(arg_33_1))))
end

function var_0_0.saveLastEnterMainGroupTypeInLocal(arg_34_0, arg_34_1)
	if arg_34_1 then
		local var_34_0 = var_0_0._generateSaveLastEnterMainGroupTypeKey(arg_34_0)

		PlayerPrefsHelper.setNumber(var_34_0, arg_34_1)
	end
end

function var_0_0._generateSaveLastEnterMainGroupTypeKey(arg_35_0)
	return string.format("%s#%s#%s", PlayerPrefsKey.Act183LastEnterMainGroupType, PlayerModel.instance:getMyUserId(), arg_35_0)
end

function var_0_0.getLastTotalBadgeNumInLocal(arg_36_0)
	local var_36_0 = var_0_0._generateSaveLastTotalBadgeNumInLocal(arg_36_0)

	return (tonumber(PlayerPrefsHelper.getNumber(var_36_0, 0)))
end

function var_0_0.saveLastTotalBadgeNumInLocal(arg_37_0, arg_37_1)
	if arg_37_0 and arg_37_1 then
		local var_37_0 = var_0_0._generateSaveLastTotalBadgeNumInLocal(arg_37_0)

		PlayerPrefsHelper.setNumber(var_37_0, arg_37_1)
	end
end

function var_0_0._generateSaveLastTotalBadgeNumInLocal(arg_38_0)
	return string.format("%s#%s#%s", PlayerPrefsKey.Act183LastTotalBadgeNum, PlayerModel.instance:getMyUserId(), arg_38_0)
end

function var_0_0.isGroupHasPlayUnlockAnim(arg_39_0, arg_39_1)
	local var_39_0 = var_0_0._generateHasPlayUnlockAnimGroupIdKey(arg_39_0, arg_39_1)

	return tonumber(PlayerPrefsHelper.getNumber(var_39_0, 0)) ~= 0
end

function var_0_0.savePlayUnlockAnimGroupIdInLocal(arg_40_0, arg_40_1)
	if arg_40_0 and arg_40_1 then
		local var_40_0 = var_0_0._generateHasPlayUnlockAnimGroupIdKey(arg_40_0, arg_40_1)

		PlayerPrefsHelper.setNumber(var_40_0, 1)
	end
end

function var_0_0._generateHasPlayUnlockAnimGroupIdKey(arg_41_0, arg_41_1)
	return string.format("%s#%s#%s#%s", PlayerPrefsKey.Act183HasPlayUnlockAnimGroupIds, PlayerModel.instance:getMyUserId(), arg_41_0, arg_41_1)
end

function var_0_0.isLastPassEpisodeInType(arg_42_0)
	if (arg_42_0 and arg_42_0:getStatus()) ~= Act183Enum.EpisodeStatus.Finished then
		return
	end

	local var_42_0 = arg_42_0:getGroupType()
	local var_42_1 = arg_42_0:getPassOrder()
	local var_42_2 = false

	if var_42_0 == Act183Enum.GroupType.Daily then
		var_42_2 = var_42_1 >= Act183Enum.MaxDailySubEpisodesNum
	else
		var_42_2 = var_42_1 >= Act183Enum.MaxMainSubEpisodesNum
	end

	return var_42_2
end

function var_0_0.isLastPassEpisodeInGroup(arg_43_0)
	if (arg_43_0 and arg_43_0:getStatus()) ~= Act183Enum.EpisodeStatus.Finished then
		return
	end

	local var_43_0 = arg_43_0:getGroupType()
	local var_43_1 = arg_43_0:getPassOrder()
	local var_43_2 = false

	if var_43_0 == Act183Enum.GroupType.Daily then
		var_43_2 = var_43_1 >= Act183Enum.MaxDailySubEpisodesNum
	else
		var_43_2 = var_43_1 >= Act183Enum.MaxMainSubEpisodesNum + Act183Enum.MainGroupBossEpisodeNum
	end

	return var_43_2
end

function var_0_0.getHasReadUnlockSupportHeroIdsInLocal(arg_44_0)
	local var_44_0 = var_0_0._generateSaveHasReadUnlockSupportHeroIdsKey(arg_44_0)
	local var_44_1 = PlayerPrefsHelper.getString(var_44_0, "")

	return (string.splitToNumber(var_44_1, "#"))
end

function var_0_0.saveHasReadUnlockSupportHeroIdsInLocal(arg_45_0, arg_45_1)
	if arg_45_1 then
		local var_45_0 = var_0_0._generateSaveHasReadUnlockSupportHeroIdsKey(arg_45_0)
		local var_45_1 = table.concat(arg_45_1, "#")

		PlayerPrefsHelper.setString(var_45_0, var_45_1)
	end
end

function var_0_0._generateSaveHasReadUnlockSupportHeroIdsKey(arg_46_0)
	return string.format("%s#%s#%s", PlayerPrefsKey.Act183HasReadUnlockSupportHeroIds, PlayerModel.instance:getMyUserId(), arg_46_0)
end

function var_0_0.getHasPlayRefreshAnimRuleIdsInLocal(arg_47_0)
	local var_47_0 = var_0_0._generateHasPlayRefreshAnimRuleIdsKey(arg_47_0)
	local var_47_1 = PlayerPrefsHelper.getString(var_47_0, "")

	return (string.split(var_47_1, "#"))
end

function var_0_0.saveHasPlayRefreshAnimRuleIdsInLocal(arg_48_0, arg_48_1)
	if arg_48_1 then
		local var_48_0 = var_0_0._generateHasPlayRefreshAnimRuleIdsKey(arg_48_0)
		local var_48_1 = table.concat(arg_48_1, "#")

		PlayerPrefsHelper.setString(var_48_0, var_48_1)
	end
end

function var_0_0._generateHasPlayRefreshAnimRuleIdsKey(arg_49_0)
	return string.format("%s#%s#%s", PlayerPrefsKey.Act183HasPlayRefreshAnimRuleIds, PlayerModel.instance:getMyUserId(), arg_49_0)
end

function var_0_0.getBadgeItemConfig()
	local var_50_0 = lua_challenge_const.configDict[Act183Enum.Const.BadgeItemId]
	local var_50_1 = var_50_0 and tonumber(var_50_0.value)

	if CurrencyConfig.instance:getCurrencyCo(var_50_1) then
		return MaterialEnum.MaterialType.Currency, var_50_1
	end
end

function var_0_0.getMaxBadgeNum()
	return tonumber(lua_challenge_const.configDict[Act183Enum.Const.MaxBadgeNum].value)
end

function var_0_0.isGetBadgeNumMax()
	local var_52_0 = Act183Model.instance:getBadgeNum()
	local var_52_1 = var_0_0.getMaxBadgeNum()

	if var_52_0 and var_52_1 then
		return var_52_1 <= var_52_0
	end
end

function var_0_0.getTaskCanGetBadgeNums(arg_53_0)
	local var_53_0 = 0

	if arg_53_0 then
		for iter_53_0, iter_53_1 in ipairs(arg_53_0) do
			local var_53_1 = TaskModel.instance:getTaskById(iter_53_1)
			local var_53_2 = var_53_1 and var_53_1.config

			var_53_0 = var_53_0 + (var_53_2 and var_53_2.badgeNum or 0)
		end
	end

	local var_53_3 = Act183Model.instance:getBadgeNum()
	local var_53_4 = var_0_0.getMaxBadgeNum() - var_53_3
	local var_53_5 = var_53_4 <= var_53_0 and var_53_4 or var_53_0

	return var_53_0, var_53_5
end

function var_0_0.showToastWhileGetTaskRewards(arg_54_0)
	local var_54_0, var_54_1 = var_0_0.getTaskCanGetBadgeNums(arg_54_0)
	local var_54_2 = var_0_0.isGetBadgeNumMax()

	if var_54_1 > 0 then
		GameFacade.showToast(ToastEnum.Act183GetBadgeNum, var_54_1)
	end

	if var_54_0 > 0 and var_54_2 then
		GameFacade.showToast(ToastEnum.Act183GetBadgeMax)
	end
end

function var_0_0.isOnlyCanUseLimitPlayerCloth(arg_55_0)
	local var_55_0 = var_0_0.getGroupType(arg_55_0)
	local var_55_1 = var_0_0.getLimitUsePlayerCloth()

	return var_55_0 ~= Act183Enum.GroupType.Daily and var_55_1 and var_55_1 ~= 0
end

function var_0_0.getLimitUsePlayerCloth()
	local var_56_0 = lua_challenge_const.configDict[Act183Enum.Const.PlayerClothIds]
	local var_56_1 = var_56_0 and var_56_0.value

	if var_56_1 then
		return tonumber(var_56_1)
	end
end

function var_0_0.getEpisodeClsKey(arg_57_0, arg_57_1)
	if not arg_57_0 or not arg_57_1 then
		logError(string.format("配置错误 groupType = %s, episodeType = %s", arg_57_0, arg_57_1))
	end

	return string.format("%s_%s", arg_57_0, arg_57_1)
end

function var_0_0.isTeamLeader(arg_58_0, arg_58_1)
	local var_58_0 = var_0_0.isEpisodeHasTeamLeader(arg_58_0)
	local var_58_1 = Act183Config.instance:getEpisodeLeaderPosition(arg_58_0)

	return var_58_0 and var_58_1 ~= 0 and arg_58_1 == var_58_1
end

function var_0_0.getEpisodeBattleNum(arg_59_0)
	local var_59_0 = DungeonConfig.instance:getEpisodeCO(arg_59_0)

	if not var_59_0 then
		logError(string.format("关卡配置不存在 episodeId = %s", arg_59_0))

		return ModuleEnum.MaxHeroCountInGroup
	end

	local var_59_1 = lua_battle.configDict[var_59_0.battleId]

	return var_59_1 and var_59_1.roleNum or ModuleEnum.MaxHeroCountInGroup
end

function var_0_0.isEpisodeHasTeamLeader(arg_60_0)
	local var_60_0 = Act183Config.instance:getEpisodeCo(arg_60_0)

	if not var_60_0 then
		return
	end

	return var_60_0 and not string.nilorempty(var_60_0.skillDesc)
end

function var_0_0.setEpisodeConditionStar(arg_61_0, arg_61_1, arg_61_2, arg_61_3)
	if not arg_61_0 then
		logError("图片组件为空")

		return
	end

	local var_61_0 = arg_61_1 and Act183Enum.ConditionStatus.Pass or Act183Enum.ConditionStatus.Unpass

	if arg_61_1 and arg_61_2 ~= nil then
		var_61_0 = arg_61_2 and Act183Enum.ConditionStatus.Pass_Select or Act183Enum.ConditionStatus.Pass_Unselect
	end

	local var_61_1 = Act183Enum.ConditionStarImgName[var_61_0]

	if string.nilorempty(var_61_1) then
		logError(string.format("星星图片不存在 isPass = %s, isSelect = %s, status = %s,", arg_61_1, arg_61_2, var_61_0))

		return
	end

	UISpriteSetMgr.instance:setChallengeSprite(arg_61_0, var_61_1, arg_61_3)
end

function var_0_0.getEpisodeSnapShotType(arg_62_0)
	local var_62_0 = var_0_0.getEpisodeBattleNum(arg_62_0)
	local var_62_1 = Act183Enum.BattleNumToSnapShotType[var_62_0]

	if not var_62_1 then
		logError(string.format("编队快照类型(Act183Enum.BattleNumToSnapShotType)不存在 episodeId = %s, maxBattleNum = %s", arg_62_0, var_62_0))

		return Act183Enum.BattleNumToSnapShotType.Default
	end

	return var_62_1
end

function var_0_0.isOpenCurrencyReplaceTipsViewInLocal()
	local var_63_0 = var_0_0._generateOpenCurrencyReplaceTipsViewKey()

	return not string.nilorempty(PlayerPrefsHelper.getString(var_63_0, ""))
end

function var_0_0.saveOpenCurrencyReplaceTipsViewInLocal()
	local var_64_0 = var_0_0._generateOpenCurrencyReplaceTipsViewKey()

	PlayerPrefsHelper.setString(var_64_0, "true")
end

function var_0_0._generateOpenCurrencyReplaceTipsViewKey()
	return string.format("%s#%s", PlayerPrefsKey.Act183OpenCurrencyReplaceTipsView, PlayerModel.instance:getMyUserId())
end

function var_0_0.generateBossRush_ChallengeCurrencyReplaceViewParams()
	local var_66_0 = {
		oldCurrencyId = CurrencyEnum.CurrencyType.BossRushStore,
		newCurrencyId = CurrencyEnum.CurrencyType.BossRushStore,
		oldCurrencyIconUrl = ResUrl.getCurrencyItemIcon(100606),
		oldCurrencyNum = tonumber(PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.V2a7_BossRushCurrencyNum))
	}

	var_66_0.replaceRate = 1
	var_66_0.desc = luaLang("v2a5_challenge_currencyreplacetipsview_desc1")

	return var_66_0
end

function var_0_0.calcEpisodeTotalConditionCount(arg_67_0)
	local var_67_0 = DungeonConfig.instance:getEpisodeAdvancedCondition(arg_67_0)
	local var_67_1 = 0

	if not string.nilorempty(var_67_0) then
		local var_67_2 = string.splitToNumber(var_67_0, "|")

		var_67_1 = var_67_2 and #var_67_2 or 0
	end

	local var_67_3 = DungeonConfig.instance:getEpisodeCondition(arg_67_0)
	local var_67_4 = 0

	if not string.nilorempty(var_67_3) then
		local var_67_5 = GameUtil.splitString2(var_67_3, false, "|", "#")

		var_67_4 = var_67_5 and #var_67_5 or 0
	end

	return var_67_1 + var_67_4, var_67_4, var_67_1
end

function var_0_0.getEpisodeConditionDescList(arg_68_0)
	local var_68_0 = {}

	table.insert(var_68_0, DungeonConfig.instance:getFirstEpisodeWinConditionText(arg_68_0))

	local var_68_1 = DungeonConfig.instance:getEpisodeAdvancedCondition(arg_68_0)

	if LuaUtil.isEmptyStr(var_68_1) == false then
		local var_68_2 = string.splitToNumber(var_68_1, "|")

		for iter_68_0, iter_68_1 in ipairs(var_68_2) do
			local var_68_3 = lua_condition.configDict[iter_68_1]

			table.insert(var_68_0, var_68_3.desc)
		end
	end

	return var_68_0
end

return var_0_0
