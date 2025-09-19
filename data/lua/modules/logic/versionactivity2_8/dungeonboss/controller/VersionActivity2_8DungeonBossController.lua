module("modules.logic.versionactivity2_8.dungeonboss.controller.VersionActivity2_8DungeonBossController", package.seeall)

local var_0_0 = class("VersionActivity2_8DungeonBossController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	TaskDispatcher.cancelTask(arg_2_0._delayFinishElement, arg_2_0)
	TaskDispatcher.cancelTask(arg_2_0._delayCheckBassActReddot, arg_2_0)

	arg_2_0._needFinishElement = nil
end

function var_0_0.addConstEvents(arg_3_0)
	DungeonController.instance:registerCallback(DungeonMapElementEvent.OnElementAdd, arg_3_0._onElementAdd, arg_3_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_3_0._onOpenView, arg_3_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_3_0._onCloseViewFinish, arg_3_0)
	DungeonController.instance:registerCallback(DungeonEvent.OnUpdateDungeonInfo, arg_3_0._onUpdateDungeonInfo, arg_3_0)
end

function var_0_0._onElementAdd(arg_4_0, arg_4_1)
	if arg_4_1 == VersionActivity2_8BossEnum.ElementId and not DungeonMapModel.instance:elementIsFinished(arg_4_1) and DungeonModel.instance:chapterIsPass(DungeonEnum.ChapterId.BossStory) then
		arg_4_0._needFinishElement = true

		if ViewMgr.instance:isOpen(ViewName.VersionActivity2_8BossStoryLoadingView) then
			return
		end

		arg_4_0:_startDelayFinishElement(1)
	end
end

function var_0_0._onUpdateDungeonInfo(arg_5_0, arg_5_1)
	if arg_5_1 and arg_5_1.chapterId == DungeonEnum.ChapterId.BossAct then
		arg_5_0:checkBossActReddot()
	end
end

function var_0_0.forceFinishElement(arg_6_0)
	arg_6_0:_startDelayFinishElement(1)
end

function var_0_0._startDelayFinishElement(arg_7_0, arg_7_1)
	UIBlockHelper.instance:startBlock("VersionActivity2_8DungeonBossController:_delayFinishElement", arg_7_1)
	TaskDispatcher.runDelay(arg_7_0._delayFinishElement, arg_7_0, arg_7_1)
end

function var_0_0._delayFinishElement(arg_8_0)
	DungeonRpc.instance:sendMapElementRequest(VersionActivity2_8BossEnum.ElementId, nil, arg_8_0._onMapElementFinish, arg_8_0)
end

function var_0_0._onCloseViewFinish(arg_9_0, arg_9_1)
	if arg_9_1 == ViewName.VersionActivity2_8BossStoryLoadingView and arg_9_0._needFinishElement then
		arg_9_0._needFinishElement = false

		arg_9_0:_startDelayFinishElement(1)
	end
end

function var_0_0._onMapElementFinish(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_2 ~= 0 then
		return
	end

	DungeonController.instance:dispatchEvent(DungeonEvent.EndShowRewardView)
end

function var_0_0._onOpenView(arg_11_0, arg_11_1)
	if arg_11_1 == ViewName.MainView then
		arg_11_0:checkBossActReddot()
	end
end

function var_0_0.openVersionActivity2_8BossStoryEyeView(arg_12_0, arg_12_1, arg_12_2)
	ViewMgr.instance:openView(ViewName.VersionActivity2_8BossStoryEyeView, arg_12_1, arg_12_2)
end

function var_0_0.openVersionActivity2_8BossStoryEnterView(arg_13_0, arg_13_1, arg_13_2)
	ViewMgr.instance:openView(ViewName.VersionActivity2_8BossStoryEnterView, arg_13_1, arg_13_2)

	return ViewName.VersionActivity2_8BossStoryEnterView
end

function var_0_0.checkBossActReddot(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._delayCheckBassActReddot, arg_14_0)

	if not (ActivityHelper.getActivityStatus(VersionActivity2_8Enum.ActivityId.DungeonBoss) == ActivityEnum.ActivityStatus.Normal) then
		return
	end

	local var_14_0 = ActivityModel.instance:getActStartTime(VersionActivity2_8Enum.ActivityId.DungeonBoss) / 1000
	local var_14_1 = ActivityModel.instance:getActEndTime(VersionActivity2_8Enum.ActivityId.DungeonBoss) / 1000
	local var_14_2 = 0
	local var_14_3 = var_14_2 + tonumber(lua_boss_fight_mode_const.configDict[1].value)
	local var_14_4 = var_14_2 + tonumber(lua_boss_fight_mode_const.configDict[2].value)
	local var_14_5 = {
		var_14_2,
		var_14_0 + var_14_3 * TimeUtil.OneDaySecond,
		var_14_0 + var_14_4 * TimeUtil.OneDaySecond
	}
	local var_14_6 = DungeonConfig.instance:getChapterEpisodeCOList(VersionActivity2_8BossEnum.BossActChapterId)
	local var_14_7 = 0
	local var_14_8 = false

	for iter_14_0, iter_14_1 in ipairs(var_14_6) do
		local var_14_9 = var_14_5[iter_14_0]

		if var_14_9 <= ServerTime.now() then
			if not var_14_8 then
				var_14_8 = DungeonModel.instance:hasPassLevel(iter_14_1.preEpisode) and not DungeonModel.instance:hasPassLevel(iter_14_1.id)
			end
		else
			var_14_7 = var_14_9

			break
		end
	end

	local var_14_10 = {
		replaceAll = true,
		defineId = RedDotEnum.DotNode.V2a8DungeonBossAct,
		infos = {
			{
				id = 0,
				time = 0,
				value = var_14_8 and 1 or 0
			}
		}
	}
	local var_14_11 = {
		var_14_10
	}

	RedDotModel.instance:updateRedDotInfo(var_14_11)
	arg_14_0:_updateReddot(var_14_11)

	if var_14_7 > 0 then
		TaskDispatcher.runDelay(arg_14_0._delayCheckBassActReddot, arg_14_0, var_14_7 - ServerTime.now() + 1)
	end
end

function var_0_0._updateReddot(arg_15_0, arg_15_1)
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		local var_15_1 = RedDotModel.instance:_getAssociateRedDots(iter_15_1.defineId)

		for iter_15_2, iter_15_3 in pairs(var_15_1) do
			var_15_0[iter_15_3] = true
		end
	end

	RedDotController.instance:CheckExpireDot()
	RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, var_15_0)
	RedDotController.instance:dispatchEvent(RedDotEvent.RefreshClientCharacterDot)
end

function var_0_0._delayCheckBassActReddot(arg_16_0)
	arg_16_0:checkBossActReddot()
end

function var_0_0.hasOnceActionKey(arg_17_0, arg_17_1)
	local var_17_0 = var_0_0._getKey(arg_17_0, arg_17_1)

	return PlayerPrefsHelper.hasKey(var_17_0)
end

function var_0_0.setOnceActionKey(arg_18_0, arg_18_1)
	local var_18_0 = var_0_0._getKey(arg_18_0, arg_18_1)

	PlayerPrefsHelper.setNumber(var_18_0, 1)
end

function var_0_0.getPrefsString(arg_19_0, arg_19_1)
	local var_19_0 = var_0_0._getKey(arg_19_0, arg_19_0)

	return (PlayerPrefsHelper.getString(var_19_0, arg_19_1 or ""))
end

function var_0_0.setPrefsString(arg_20_0, arg_20_1)
	local var_20_0 = var_0_0._getKey(arg_20_0, arg_20_0)

	return PlayerPrefsHelper.setString(var_20_0, arg_20_1)
end

function var_0_0._getKey(arg_21_0, arg_21_1)
	return (string.format("%s%s_%s_%s", PlayerPrefsKey.V2a8DungeonBossOnceAnim, PlayerModel.instance:getPlayinfo().userId, arg_21_0, arg_21_1))
end

var_0_0.instance = var_0_0.New()

return var_0_0
