module("modules.logic.versionactivity2_5.challenge.controller.Act183Helper", package.seeall)

slot0 = _M

function slot0.isDailyGroupEpisodeUnlock(slot0)
	if uv0.getDailyGroupEpisodeUnlockRemainTime(slot0) <= 0 then
		return true
	end
end

function slot0.getDailyGroupEpisodeUnlockRemainTime(slot0)
	if not lua_challenge_daily_unlock.configDict[slot0] then
		logError(string.format("获取日常关卡组解锁剩余时间失败! 失败原因:找不到关卡组解锁配置 groupId = %s", slot0))

		return 0
	end

	return ActivityModel.instance:getActStartTime(Act183Model.instance:getActivityId()) / 1000 + slot1.unlock - ServerTime.now()
end

function slot0.getEpisodeType(slot0)
	if Act183Config.instance:getEpisodeCo(slot0) and slot1.order and slot2 > 100 then
		return Act183Enum.EpisodeType.Boss
	end

	return Act183Enum.EpisodeType.Sub
end

function slot0.getGroupType(slot0)
	return Act183Config.instance:getEpisodeCo(slot0) and slot1.type
end

function slot0.setRuleIcon(slot0, slot1, slot2)
	if not slot2 then
		logError("图片组件为空")

		return
	end

	if string.nilorempty(Act183Config.instance:getEpisodeCo(slot0) and slot3.ruleIcon) then
		logError(string.format("关卡机制图标配置不存在: episodeId = %s, ruleIcon = %s", slot0, slot4))

		return
	end

	UISpriteSetMgr.instance:setChallengeSprite(slot2, slot4)
end

function slot0.setEpisodeIcon(slot0, slot1, slot2)
	if not slot2 then
		logError("图片组件为空")

		return
	end

	if string.nilorempty(Act183Config.instance:getEpisodeCo(slot0) and slot3.icon) then
		logError(string.format("关卡图标配置不存在: episodeId = %s", slot0))

		return
	end

	if slot3.type == Act183Enum.GroupType.Daily then
		slot5 = "daily/" .. slot4

		ZProj.UGUIHelper.SetGrayscale(slot2.gameObject, slot1 ~= Act183Enum.EpisodeStatus.Finished)
	else
		slot5 = uv0.getEpisodeType(slot0) ~= Act183Enum.EpisodeType.Boss and (slot1 ~= Act183Enum.EpisodeStatus.Finished and slot5 .. "_0" or slot5 .. "_1") or slot1 == Act183Enum.EpisodeStatus.Locked and slot5 .. "_0" or slot5 .. "_1"
	end

	slot2:LoadImage(ResUrl.getChallengeIcon(slot5), function (slot0, slot1)
		recthelper.setSize(uv0.transform, slot0, slot1)
	end)
end

function slot0.setEpisodeReportIcon(slot0, slot1)
	if not slot1 then
		logError("图片组件为空")

		return
	end

	if string.nilorempty(Act183Config.instance:getEpisodeCo(slot0) and slot2.reportIcon) then
		logError(string.format("通关记录界面图标配置不存在: episodeId = %s", slot0))

		return
	end

	UISpriteSetMgr.instance:setChallengeSprite(slot1, slot3)
end

function slot0.setSubEpisodeResultIcon(slot0, slot1)
	if not slot1 then
		logError("图片组件为空")

		return
	end

	if not uv0.getEpisodeResultIcon(slot0) then
		return
	end

	UISpriteSetMgr.instance:setChallengeSprite(slot1, slot2)
end

function slot0.setBossEpisodeResultIcon(slot0, slot1)
	if not slot1 then
		logError("图片组件为空")

		return
	end

	if not uv0.getEpisodeResultIcon(slot0) then
		return
	end

	slot1:LoadImage(ResUrl.getChallengeIcon("result/" .. slot2), function (slot0, slot1)
		recthelper.setSize(uv0.transform, slot0, slot1)
	end)
end

function slot0.getEpisodeResultIcon(slot0)
	if string.nilorempty(Act183Config.instance:getEpisodeCo(slot0) and slot1.resultIcon) then
		logError(string.format("结算界面图标配置不存在: episodeId = %s", slot0))

		return
	end

	return slot2
end

function slot0.getRoundStage(slot0)
	if string.nilorempty(lua_challenge_const.configDict[Act183Enum.Const.RoundStage] and slot1.value2) then
		logError("缺少回合数挡位配置")

		return 1
	end

	for slot7, slot8 in ipairs(string.splitToNumber(slot2, "#")) do
		if slot0 <= slot8 then
			return slot7
		end
	end

	return #slot3 + 1
end

function slot0.getGroupEpisodeTaskProgress(slot0)
	slot2 = Act183Config.instance:getAllOnlineGroupTasks(slot0) and #slot1 or 0
	slot3 = 0

	if slot1 then
		for slot7, slot8 in ipairs(slot1) do
			if uv0.isTaskFinished(slot8.id) then
				slot3 = slot3 + 1
			end
		end
	end

	return slot2, slot3
end

function slot0.getUnlockSupportHeroIds(slot0, slot1)
	slot2 = {}

	if Act183Config.instance:getActivityBadgeCos(slot0) then
		for slot7, slot8 in ipairs(slot3) do
			if slot8.num <= slot1 and slot8.unlockSupport ~= 0 then
				table.insert(slot2, slot8.unlockSupport)
			end
		end
	end

	return slot2
end

function slot0.isEpisodeCanUseBadge(slot0)
	if Act183Config.instance:getEpisodeCo(slot0) then
		return slot1.type == Act183Enum.GroupType.NormalMain
	end
end

function slot0.isEpisodeCanUseSupportHero(slot0)
	if Act183Config.instance:getEpisodeCo(slot0) then
		return slot1.type == Act183Enum.GroupType.NormalMain or slot1.type == Act183Enum.GroupType.Daily
	end
end

function slot0.generateDungeonViewParams(slot0, slot1)
	if slot0 == Act183Enum.GroupType.Daily then
		table.insert({}, Act183Enum.GroupType.Daily)
	elseif slot0 == Act183Enum.GroupType.NormalMain or slot0 == Act183Enum.GroupType.HardMain then
		table.insert(slot2, Act183Enum.GroupType.NormalMain)
		table.insert(slot2, Act183Enum.GroupType.HardMain)
	end

	return {
		selectGroupId = slot1,
		groupTypes = slot2
	}
end

function slot0.generateDungeonViewParams2(slot0, slot1)
	slot5 = uv0.generateDungeonViewParams(Act183Config.instance:getEpisodeCo(slot0) and slot2.type, slot2 and slot2.groupId)
	slot5.selectEpisodeId = slot1 and slot2.episodeId

	return slot5
end

function slot0.rpcInfosToList(slot0, slot1, slot2)
	slot3 = {}

	for slot7, slot8 in ipairs(slot0) do
		slot9 = slot1.New()

		slot9:init(slot8, slot2)
		table.insert(slot3, slot9)
	end

	return slot3
end

function slot0.listToMap(slot0)
	slot1 = {}

	if slot0 then
		for slot5, slot6 in ipairs(slot0) do
			slot1[slot6] = slot6
		end
	end

	return slot1
end

function slot0.generateStartDungeonParams(slot0)
	if uv0.isEpisodeCanUseBadge(slot0) then
		-- Nothing
	end

	if uv0.getEpisodeType(slot0) == Act183Enum.EpisodeType.Boss and Act183Model.instance:getRecordEpisodeSelectConditions() and #slot3 > 0 then
		slot1.chooseConditions = slot3
	end

	return cjson.encode({
		useBadgeNum = tostring(Act183Model.instance:getEpisodeReadyUseBadgeNum())
	})
end

function slot0.getSelectConditionIdsInLocal(slot0, slot1)
	return string.splitToNumber(PlayerPrefsHelper.getString(uv0._generateSaveSelectCollectionIdsKey(slot0, slot1), ""), "#")
end

function slot0.saveSelectConditionIdsInLocal(slot0, slot1, slot2)
	if slot2 then
		PlayerPrefsHelper.setString(uv0._generateSaveSelectCollectionIdsKey(slot0, slot1), table.concat(slot2, "#"))
	end
end

function slot0._generateSaveSelectCollectionIdsKey(slot0, slot1)
	return string.format("%s#%s#%s#%s", PlayerPrefsKey.Act183BossEpisodeSelectConditions, PlayerModel.instance:getMyUserId(), slot0, slot1)
end

function slot0.isHeroGroupPositionOpen(slot0, slot1)
	if (lua_battle.configDict[DungeonConfig.instance:getEpisodeCO(slot0) and slot2.battleId or 0] and slot4.roleNum or 0) <= 0 then
		logError(string.format("编队解锁位置数量错误 episodeId = %s, battleId = %s, roleNum = %s", slot0, slot3, slot5))
	end

	return slot1 > 0 and slot1 <= slot5
end

function slot0.setTranPositionAndRotation(slot0, slot1, slot2, slot3)
	if not slot2[slot1] or #slot4 < 5 then
		logError(string.format("缺少坐标及旋转配置 episodeId = %s, order = %s", slot0, slot1))

		return
	end

	transformhelper.setLocalRotation(slot3, slot4[3], slot4[4], slot4[5])
	recthelper.setAnchor(slot3, slot4[1], slot4[2])
end

function slot0.isTaskFinished(slot0)
	return uv0.isTaskHasGetReward(slot0) or uv0.isTaskCanGetReward(slot0)
end

function slot0.isTaskCanGetReward(slot0)
	if TaskModel.instance:getTaskById(slot0) then
		return slot1.finishCount == 0 and slot1.config.maxProgress <= slot1.progress
	end
end

function slot0.isTaskHasGetReward(slot0)
	return TaskModel.instance:isTaskFinish(TaskEnum.TaskType.Activity183, slot0)
end

function slot0.getLastEnterMainGroupTypeInLocal(slot0, slot1)
	return tonumber(PlayerPrefsHelper.getNumber(uv0._generateSaveLastEnterMainGroupTypeKey(slot0), tonumber(slot1)))
end

function slot0.saveLastEnterMainGroupTypeInLocal(slot0, slot1)
	if slot1 then
		PlayerPrefsHelper.setNumber(uv0._generateSaveLastEnterMainGroupTypeKey(slot0), slot1)
	end
end

function slot0._generateSaveLastEnterMainGroupTypeKey(slot0)
	return string.format("%s#%s#%s", PlayerPrefsKey.Act183LastEnterMainGroupType, PlayerModel.instance:getMyUserId(), slot0)
end

function slot0.getLastTotalBadgeNumInLocal(slot0)
	return tonumber(PlayerPrefsHelper.getNumber(uv0._generateSaveLastTotalBadgeNumInLocal(slot0), 0))
end

function slot0.saveLastTotalBadgeNumInLocal(slot0, slot1)
	if slot0 and slot1 then
		PlayerPrefsHelper.setNumber(uv0._generateSaveLastTotalBadgeNumInLocal(slot0), slot1)
	end
end

function slot0._generateSaveLastTotalBadgeNumInLocal(slot0)
	return string.format("%s#%s#%s", PlayerPrefsKey.Act183LastTotalBadgeNum, PlayerModel.instance:getMyUserId(), slot0)
end

function slot0.getUnlockGroupIdsInLocal(slot0)
	return string.splitToNumber(PlayerPrefsHelper.getString(uv0._generateHasPlayUnlockAnimGroupIdsKey(slot0), ""), "#")
end

function slot0.saveUnlockGroupIdsInLocal(slot0, slot1)
	if slot0 and slot1 then
		PlayerPrefsHelper.setString(uv0._generateHasPlayUnlockAnimGroupIdsKey(slot0), table.concat(slot1, "#"))
	end
end

function slot0._generateHasPlayUnlockAnimGroupIdsKey(slot0)
	return string.format("%s#%s#%s", PlayerPrefsKey.Act183HasPlayUnlockAnimGroupIds, PlayerModel.instance:getMyUserId(), slot0)
end

function slot0.isLastPassEpisodeInType(slot0)
	if (slot0 and slot0:getStatus()) ~= Act183Enum.EpisodeStatus.Finished then
		return
	end

	slot3 = slot0:getPassOrder()
	slot4 = false

	return slot0:getGroupType() == Act183Enum.GroupType.Daily and Act183Enum.MaxDailySubEpisodesNum <= slot3 or Act183Enum.MaxMainSubEpisodesNum <= slot3
end

function slot0.getHasReadUnlockSupportHeroIdsInLocal(slot0)
	return string.splitToNumber(PlayerPrefsHelper.getString(uv0._generateSaveHasReadUnlockSupportHeroIdsKey(slot0), ""), "#")
end

function slot0.saveHasReadUnlockSupportHeroIdsInLocal(slot0, slot1)
	if slot1 then
		PlayerPrefsHelper.setString(uv0._generateSaveHasReadUnlockSupportHeroIdsKey(slot0), table.concat(slot1, "#"))
	end
end

function slot0._generateSaveHasReadUnlockSupportHeroIdsKey(slot0)
	return string.format("%s#%s#%s", PlayerPrefsKey.Act183HasReadUnlockSupportHeroIds, PlayerModel.instance:getMyUserId(), slot0)
end

function slot0.getHasPlayRefreshAnimRuleIdsInLocal(slot0)
	return string.split(PlayerPrefsHelper.getString(uv0._generateHasPlayRefreshAnimRuleIdsKey(slot0), ""), "#")
end

function slot0.saveHasPlayRefreshAnimRuleIdsInLocal(slot0, slot1)
	if slot1 then
		PlayerPrefsHelper.setString(uv0._generateHasPlayRefreshAnimRuleIdsKey(slot0), table.concat(slot1, "#"))
	end
end

function slot0._generateHasPlayRefreshAnimRuleIdsKey(slot0)
	return string.format("%s#%s#%s", PlayerPrefsKey.Act183HasPlayRefreshAnimRuleIds, PlayerModel.instance:getMyUserId(), slot0)
end

function slot0.getBadgeItemConfig()
	if CurrencyConfig.instance:getCurrencyCo(lua_challenge_const.configDict[Act183Enum.Const.BadgeItemId] and tonumber(slot0.value)) then
		return MaterialEnum.MaterialType.Currency, slot1
	end
end

function slot0.getMaxBadgeNum()
	return tonumber(lua_challenge_const.configDict[Act183Enum.Const.MaxBadgeNum].value)
end

function slot0.isGetBadgeNumMax()
	slot1 = uv0.getMaxBadgeNum()

	if Act183Model.instance:getBadgeNum() and slot1 then
		return slot1 <= slot0
	end
end

function slot0.getTaskCanGetBadgeNums(slot0)
	slot1 = 0

	if slot0 then
		for slot5, slot6 in ipairs(slot0) do
			slot8 = TaskModel.instance:getTaskById(slot6) and slot7.config
			slot1 = slot1 + (slot8 and slot8.badgeNum or 0)
		end
	end

	return slot1, slot1 >= uv0.getMaxBadgeNum() - Act183Model.instance:getBadgeNum() and slot4 or slot1
end

function slot0.showToastWhileCanTaskRewards(slot0)
	slot1, slot2 = uv0.getTaskCanGetBadgeNums(slot0)
	slot3 = uv0.isGetBadgeNumMax()

	if slot2 > 0 then
		GameFacade.showToast(ToastEnum.Act183GetBadgeNum, slot2)
	end

	if slot1 > 0 and slot3 then
		GameFacade.showToast(ToastEnum.Act183GetBadgeMax)
	end
end

function slot0.isOnlyCanUseLimitPlayerCloth(slot0)
	slot2 = uv0.getLimitUsePlayerCloth()

	return uv0.getGroupType(slot0) ~= Act183Enum.GroupType.Daily and slot2 and slot2 ~= 0
end

function slot0.getLimitUsePlayerCloth()
	if lua_challenge_const.configDict[Act183Enum.Const.PlayerClothIds] and slot0.value then
		return tonumber(slot1)
	end
end

return slot0
