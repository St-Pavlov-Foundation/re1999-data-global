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

function var_0_0.getGroupEpisodeTaskProgress(arg_14_0, arg_14_1)
	local var_14_0 = Act183Config.instance:getAllOnlineGroupTasks(arg_14_0, arg_14_1)
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

function var_0_0.generateDungeonViewParams3(arg_20_0, arg_20_1)
	local var_20_0 = Act183Config.instance:getEpisodeCosByGroupId(arg_20_0, arg_20_1)
	local var_20_1 = var_20_0 and var_20_0[1]
	local var_20_2 = var_20_1 and var_20_1.type
	local var_20_3 = var_20_1 and var_20_1.groupId

	return (var_0_0.generateDungeonViewParams(var_20_2, var_20_3))
end

function var_0_0.rpcInfosToList(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in ipairs(arg_21_0) do
		local var_21_1 = arg_21_1.New()

		var_21_1:init(iter_21_1, arg_21_2)
		table.insert(var_21_0, var_21_1)
	end

	return var_21_0
end

function var_0_0.listToMap(arg_22_0)
	local var_22_0 = {}

	if arg_22_0 then
		for iter_22_0, iter_22_1 in ipairs(arg_22_0) do
			var_22_0[iter_22_1] = iter_22_1
		end
	end

	return var_22_0
end

function var_0_0.generateStartDungeonParams(arg_23_0)
	local var_23_0 = {}

	if var_0_0.isEpisodeCanUseBadge(arg_23_0) then
		var_23_0.useBadgeNum = tostring(Act183Model.instance:getEpisodeReadyUseBadgeNum())
	end

	if var_0_0.getEpisodeType(arg_23_0) == Act183Enum.EpisodeType.Boss then
		local var_23_1 = Act183Model.instance:getRecordEpisodeSelectConditions()

		if var_23_1 and #var_23_1 > 0 then
			var_23_0.chooseConditions = var_23_1
		end
	end

	return (cjson.encode(var_23_0))
end

function var_0_0.getSelectConditionIdsInLocal(arg_24_0, arg_24_1)
	local var_24_0 = var_0_0._generateSaveSelectCollectionIdsKey(arg_24_0, arg_24_1)
	local var_24_1 = PlayerPrefsHelper.getString(var_24_0, "")

	return (string.splitToNumber(var_24_1, "#"))
end

function var_0_0.saveSelectConditionIdsInLocal(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_2 then
		local var_25_0 = table.concat(arg_25_2, "#")
		local var_25_1 = var_0_0._generateSaveSelectCollectionIdsKey(arg_25_0, arg_25_1)

		PlayerPrefsHelper.setString(var_25_1, var_25_0)
	end
end

function var_0_0._generateSaveSelectCollectionIdsKey(arg_26_0, arg_26_1)
	return string.format("%s#%s#%s#%s", PlayerPrefsKey.Act183BossEpisodeSelectConditions, PlayerModel.instance:getMyUserId(), arg_26_0, arg_26_1)
end

function var_0_0.isHeroGroupPositionOpen(arg_27_0, arg_27_1)
	local var_27_0 = DungeonConfig.instance:getEpisodeCO(arg_27_0)
	local var_27_1 = var_27_0 and var_27_0.battleId or 0
	local var_27_2 = lua_battle.configDict[var_27_1]
	local var_27_3 = var_27_2 and var_27_2.roleNum or 0

	if var_27_3 <= 0 then
		logError(string.format("编队解锁位置数量错误 episodeId = %s, battleId = %s, roleNum = %s", arg_27_0, var_27_1, var_27_3))
	end

	return arg_27_1 > 0 and arg_27_1 <= var_27_3
end

function var_0_0.setTranPositionAndRotation(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = arg_28_2[arg_28_1]

	if not var_28_0 or #var_28_0 < 5 then
		logError(string.format("缺少坐标及旋转配置 episodeId = %s, order = %s", arg_28_0, arg_28_1))

		return
	end

	local var_28_1 = var_28_0[1]
	local var_28_2 = var_28_0[2]
	local var_28_3 = var_28_0[3]
	local var_28_4 = var_28_0[4]
	local var_28_5 = var_28_0[5]

	transformhelper.setLocalRotation(arg_28_3, var_28_3, var_28_4, var_28_5)
	recthelper.setAnchor(arg_28_3, var_28_1, var_28_2)
end

function var_0_0.isTaskFinished(arg_29_0)
	return var_0_0.isTaskHasGetReward(arg_29_0) or var_0_0.isTaskCanGetReward(arg_29_0)
end

function var_0_0.isTaskCanGetReward(arg_30_0)
	local var_30_0 = TaskModel.instance:getTaskById(arg_30_0)

	if var_30_0 then
		return var_30_0.finishCount == 0 and var_30_0.progress >= var_30_0.config.maxProgress
	end
end

function var_0_0.isTaskHasGetReward(arg_31_0)
	return TaskModel.instance:isTaskFinish(TaskEnum.TaskType.Activity183, arg_31_0)
end

function var_0_0.getLastEnterMainGroupTypeInLocal(arg_32_0, arg_32_1)
	local var_32_0 = var_0_0._generateSaveLastEnterMainGroupTypeKey(arg_32_0)

	return (tonumber(PlayerPrefsHelper.getNumber(var_32_0, tonumber(arg_32_1))))
end

function var_0_0.saveLastEnterMainGroupTypeInLocal(arg_33_0, arg_33_1)
	if arg_33_1 then
		local var_33_0 = var_0_0._generateSaveLastEnterMainGroupTypeKey(arg_33_0)

		PlayerPrefsHelper.setNumber(var_33_0, arg_33_1)
	end
end

function var_0_0._generateSaveLastEnterMainGroupTypeKey(arg_34_0)
	return string.format("%s#%s#%s", PlayerPrefsKey.Act183LastEnterMainGroupType, PlayerModel.instance:getMyUserId(), arg_34_0)
end

function var_0_0.getLastTotalBadgeNumInLocal(arg_35_0)
	local var_35_0 = var_0_0._generateSaveLastTotalBadgeNumInLocal(arg_35_0)

	return (tonumber(PlayerPrefsHelper.getNumber(var_35_0, 0)))
end

function var_0_0.saveLastTotalBadgeNumInLocal(arg_36_0, arg_36_1)
	if arg_36_0 and arg_36_1 then
		local var_36_0 = var_0_0._generateSaveLastTotalBadgeNumInLocal(arg_36_0)

		PlayerPrefsHelper.setNumber(var_36_0, arg_36_1)
	end
end

function var_0_0._generateSaveLastTotalBadgeNumInLocal(arg_37_0)
	return string.format("%s#%s#%s", PlayerPrefsKey.Act183LastTotalBadgeNum, PlayerModel.instance:getMyUserId(), arg_37_0)
end

function var_0_0.getUnlockGroupIdsInLocal(arg_38_0)
	local var_38_0 = var_0_0._generateHasPlayUnlockAnimGroupIdsKey(arg_38_0)
	local var_38_1 = PlayerPrefsHelper.getString(var_38_0, "")

	return (string.splitToNumber(var_38_1, "#"))
end

function var_0_0.saveUnlockGroupIdsInLocal(arg_39_0, arg_39_1)
	if arg_39_0 and arg_39_1 then
		local var_39_0 = var_0_0._generateHasPlayUnlockAnimGroupIdsKey(arg_39_0)
		local var_39_1 = table.concat(arg_39_1, "#")

		PlayerPrefsHelper.setString(var_39_0, var_39_1)
	end
end

function var_0_0._generateHasPlayUnlockAnimGroupIdsKey(arg_40_0)
	return string.format("%s#%s#%s", PlayerPrefsKey.Act183HasPlayUnlockAnimGroupIds, PlayerModel.instance:getMyUserId(), arg_40_0)
end

function var_0_0.isLastPassEpisodeInType(arg_41_0)
	if (arg_41_0 and arg_41_0:getStatus()) ~= Act183Enum.EpisodeStatus.Finished then
		return
	end

	local var_41_0 = arg_41_0:getGroupType()
	local var_41_1 = arg_41_0:getPassOrder()
	local var_41_2 = false

	if var_41_0 == Act183Enum.GroupType.Daily then
		var_41_2 = var_41_1 >= Act183Enum.MaxDailySubEpisodesNum
	else
		var_41_2 = var_41_1 >= Act183Enum.MaxMainSubEpisodesNum
	end

	return var_41_2
end

function var_0_0.isLastPassEpisodeInGroup(arg_42_0)
	if (arg_42_0 and arg_42_0:getStatus()) ~= Act183Enum.EpisodeStatus.Finished then
		return
	end

	local var_42_0 = arg_42_0:getGroupType()
	local var_42_1 = arg_42_0:getPassOrder()
	local var_42_2 = false

	if var_42_0 == Act183Enum.GroupType.Daily then
		var_42_2 = var_42_1 >= Act183Enum.MaxDailySubEpisodesNum
	else
		var_42_2 = var_42_1 >= Act183Enum.MaxMainSubEpisodesNum + Act183Enum.MainGroupBossEpisodeNum
	end

	return var_42_2
end

function var_0_0.getHasReadUnlockSupportHeroIdsInLocal(arg_43_0)
	local var_43_0 = var_0_0._generateSaveHasReadUnlockSupportHeroIdsKey(arg_43_0)
	local var_43_1 = PlayerPrefsHelper.getString(var_43_0, "")

	return (string.splitToNumber(var_43_1, "#"))
end

function var_0_0.saveHasReadUnlockSupportHeroIdsInLocal(arg_44_0, arg_44_1)
	if arg_44_1 then
		local var_44_0 = var_0_0._generateSaveHasReadUnlockSupportHeroIdsKey(arg_44_0)
		local var_44_1 = table.concat(arg_44_1, "#")

		PlayerPrefsHelper.setString(var_44_0, var_44_1)
	end
end

function var_0_0._generateSaveHasReadUnlockSupportHeroIdsKey(arg_45_0)
	return string.format("%s#%s#%s", PlayerPrefsKey.Act183HasReadUnlockSupportHeroIds, PlayerModel.instance:getMyUserId(), arg_45_0)
end

function var_0_0.getHasPlayRefreshAnimRuleIdsInLocal(arg_46_0)
	local var_46_0 = var_0_0._generateHasPlayRefreshAnimRuleIdsKey(arg_46_0)
	local var_46_1 = PlayerPrefsHelper.getString(var_46_0, "")

	return (string.split(var_46_1, "#"))
end

function var_0_0.saveHasPlayRefreshAnimRuleIdsInLocal(arg_47_0, arg_47_1)
	if arg_47_1 then
		local var_47_0 = var_0_0._generateHasPlayRefreshAnimRuleIdsKey(arg_47_0)
		local var_47_1 = table.concat(arg_47_1, "#")

		PlayerPrefsHelper.setString(var_47_0, var_47_1)
	end
end

function var_0_0._generateHasPlayRefreshAnimRuleIdsKey(arg_48_0)
	return string.format("%s#%s#%s", PlayerPrefsKey.Act183HasPlayRefreshAnimRuleIds, PlayerModel.instance:getMyUserId(), arg_48_0)
end

function var_0_0.getBadgeItemConfig()
	local var_49_0 = lua_challenge_const.configDict[Act183Enum.Const.BadgeItemId]
	local var_49_1 = var_49_0 and tonumber(var_49_0.value)

	if CurrencyConfig.instance:getCurrencyCo(var_49_1) then
		return MaterialEnum.MaterialType.Currency, var_49_1
	end
end

function var_0_0.getMaxBadgeNum()
	return tonumber(lua_challenge_const.configDict[Act183Enum.Const.MaxBadgeNum].value)
end

function var_0_0.isGetBadgeNumMax()
	local var_51_0 = Act183Model.instance:getBadgeNum()
	local var_51_1 = var_0_0.getMaxBadgeNum()

	if var_51_0 and var_51_1 then
		return var_51_1 <= var_51_0
	end
end

function var_0_0.getTaskCanGetBadgeNums(arg_52_0)
	local var_52_0 = 0

	if arg_52_0 then
		for iter_52_0, iter_52_1 in ipairs(arg_52_0) do
			local var_52_1 = TaskModel.instance:getTaskById(iter_52_1)
			local var_52_2 = var_52_1 and var_52_1.config

			var_52_0 = var_52_0 + (var_52_2 and var_52_2.badgeNum or 0)
		end
	end

	local var_52_3 = Act183Model.instance:getBadgeNum()
	local var_52_4 = var_0_0.getMaxBadgeNum() - var_52_3
	local var_52_5 = var_52_4 <= var_52_0 and var_52_4 or var_52_0

	return var_52_0, var_52_5
end

function var_0_0.showToastWhileGetTaskRewards(arg_53_0)
	local var_53_0, var_53_1 = var_0_0.getTaskCanGetBadgeNums(arg_53_0)
	local var_53_2 = var_0_0.isGetBadgeNumMax()

	if var_53_1 > 0 then
		GameFacade.showToast(ToastEnum.Act183GetBadgeNum, var_53_1)
	end

	if var_53_0 > 0 and var_53_2 then
		GameFacade.showToast(ToastEnum.Act183GetBadgeMax)
	end
end

function var_0_0.isOnlyCanUseLimitPlayerCloth(arg_54_0)
	local var_54_0 = var_0_0.getGroupType(arg_54_0)
	local var_54_1 = var_0_0.getLimitUsePlayerCloth()

	return var_54_0 ~= Act183Enum.GroupType.Daily and var_54_1 and var_54_1 ~= 0
end

function var_0_0.getLimitUsePlayerCloth()
	local var_55_0 = lua_challenge_const.configDict[Act183Enum.Const.PlayerClothIds]
	local var_55_1 = var_55_0 and var_55_0.value

	if var_55_1 then
		return tonumber(var_55_1)
	end
end

function var_0_0.getEpisodeClsKey(arg_56_0, arg_56_1)
	if not arg_56_0 or not arg_56_1 then
		logError(string.format("配置错误 groupType = %s, episodeType = %s", arg_56_0, arg_56_1))
	end

	return string.format("%s_%s", arg_56_0, arg_56_1)
end

function var_0_0.isTeamLeader(arg_57_0, arg_57_1)
	local var_57_0 = var_0_0.isEpisodeHasTeamLeader(arg_57_0)
	local var_57_1 = Act183Config.instance:getEpisodeLeaderPosition(arg_57_0)

	return var_57_0 and var_57_1 ~= 0 and arg_57_1 == var_57_1
end

function var_0_0.getEpisodeBattleNum(arg_58_0)
	local var_58_0 = DungeonConfig.instance:getEpisodeCO(arg_58_0)

	if not var_58_0 then
		logError(string.format("关卡配置不存在 episodeId = %s", arg_58_0))

		return ModuleEnum.MaxHeroCountInGroup
	end

	local var_58_1 = lua_battle.configDict[var_58_0.battleId]

	return var_58_1 and var_58_1.roleNum or ModuleEnum.MaxHeroCountInGroup
end

function var_0_0.isEpisodeHasTeamLeader(arg_59_0)
	local var_59_0 = Act183Config.instance:getEpisodeCo(arg_59_0)

	if not var_59_0 then
		return
	end

	return var_59_0 and not string.nilorempty(var_59_0.skillDesc)
end

function var_0_0.setEpisodeConditionStar(arg_60_0, arg_60_1, arg_60_2, arg_60_3)
	if not arg_60_0 then
		logError("图片组件为空")

		return
	end

	local var_60_0 = arg_60_1 and Act183Enum.ConditionStatus.Pass or Act183Enum.ConditionStatus.Unpass

	if arg_60_1 and arg_60_2 ~= nil then
		var_60_0 = arg_60_2 and Act183Enum.ConditionStatus.Pass_Select or Act183Enum.ConditionStatus.Pass_Unselect
	end

	local var_60_1 = Act183Enum.ConditionStarImgName[var_60_0]

	if string.nilorempty(var_60_1) then
		logError(string.format("星星图片不存在 isPass = %s, isSelect = %s, status = %s,", arg_60_1, arg_60_2, var_60_0))

		return
	end

	UISpriteSetMgr.instance:setChallengeSprite(arg_60_0, var_60_1, arg_60_3)
end

function var_0_0.getEpisodeSnapShotType(arg_61_0)
	local var_61_0 = var_0_0.getEpisodeBattleNum(arg_61_0)
	local var_61_1 = Act183Enum.BattleNumToSnapShotType[var_61_0]

	if not var_61_1 then
		logError(string.format("编队快照类型(Act183Enum.BattleNumToSnapShotType)不存在 episodeId = %s, maxBattleNum = %s", arg_61_0, var_61_0))

		return Act183Enum.BattleNumToSnapShotType.Default
	end

	return var_61_1
end

function var_0_0.isOpenCurrencyReplaceTipsViewInLocal()
	local var_62_0 = var_0_0._generateOpenCurrencyReplaceTipsViewKey()

	return not string.nilorempty(PlayerPrefsHelper.getString(var_62_0, ""))
end

function var_0_0.saveOpenCurrencyReplaceTipsViewInLocal()
	local var_63_0 = var_0_0._generateOpenCurrencyReplaceTipsViewKey()

	PlayerPrefsHelper.setString(var_63_0, "true")
end

function var_0_0._generateOpenCurrencyReplaceTipsViewKey()
	return string.format("%s#%s", PlayerPrefsKey.Act183OpenCurrencyReplaceTipsView, PlayerModel.instance:getMyUserId())
end

function var_0_0.generateBossRush_ChallengeCurrencyReplaceViewParams()
	local var_65_0 = {
		oldCurrencyId = CurrencyEnum.CurrencyType.BossRushStore,
		newCurrencyId = CurrencyEnum.CurrencyType.BossRushStore,
		oldCurrencyIconUrl = ResUrl.getCurrencyItemIcon(100606),
		oldCurrencyNum = tonumber(PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.V2a7_BossRushCurrencyNum))
	}

	var_65_0.replaceRate = 1
	var_65_0.desc = luaLang("v2a5_challenge_currencyreplacetipsview_desc1")

	return var_65_0
end

function var_0_0.calcEpisodeTotalConditionCount(arg_66_0)
	local var_66_0 = DungeonConfig.instance:getEpisodeAdvancedCondition(arg_66_0)
	local var_66_1 = 0

	if not string.nilorempty(var_66_0) then
		local var_66_2 = string.splitToNumber(var_66_0, "|")

		var_66_1 = var_66_2 and #var_66_2 or 0
	end

	local var_66_3 = DungeonConfig.instance:getEpisodeCondition(arg_66_0)
	local var_66_4 = 0

	if not string.nilorempty(var_66_3) then
		local var_66_5 = GameUtil.splitString2(var_66_3, false, "|", "#")

		var_66_4 = var_66_5 and #var_66_5 or 0
	end

	return var_66_1 + var_66_4, var_66_4, var_66_1
end

return var_0_0
