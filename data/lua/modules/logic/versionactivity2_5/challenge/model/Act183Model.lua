module("modules.logic.versionactivity2_5.challenge.model.Act183Model", package.seeall)

local var_0_0 = class("Act183Model", BaseModel)

function var_0_0.reInit(arg_1_0)
	arg_1_0._activityId = nil
	arg_1_0._actInfo = nil
	arg_1_0._readyUseBadgeNum = nil
	arg_1_0._selectConditions = nil
	arg_1_0._recordRepressEpisodeId = nil

	arg_1_0:clearBattleFinishedInfo()

	arg_1_0._unfinishTaskMap = nil
	arg_1_0._initDone = false
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._activityId = arg_2_1
	arg_2_0._actInfo = Act183InfoMO.New()

	arg_2_0._actInfo:init(arg_2_2)

	arg_2_0._initDone = true
end

function var_0_0.isInitDone(arg_3_0)
	return arg_3_0._initDone
end

function var_0_0.getActInfo(arg_4_0)
	return arg_4_0._actInfo
end

function var_0_0.getGroupEpisodeMo(arg_5_0, arg_5_1)
	return arg_5_0._actInfo and arg_5_0._actInfo:getGroupEpisodeMo(arg_5_1)
end

function var_0_0.getEpisodeMo(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0:getGroupEpisodeMo(arg_6_1)

	if var_6_0 then
		return var_6_0:getEpisodeMo(arg_6_2)
	end
end

function var_0_0.getEpisodeMoById(arg_7_0, arg_7_1)
	local var_7_0 = Act183Config.instance:getEpisodeCo(arg_7_1)

	if var_7_0 then
		return arg_7_0:getEpisodeMo(var_7_0.groupId, arg_7_1)
	end
end

function var_0_0.setActivityId(arg_8_0, arg_8_1)
	if arg_8_1 then
		arg_8_0._activityId = arg_8_1
	end
end

function var_0_0.getActivityId(arg_9_0)
	return arg_9_0._activityId
end

function var_0_0.getBadgeNum(arg_10_0)
	if not arg_10_0._actInfo then
		logError("活动数据不存在")

		return
	end

	return (arg_10_0._actInfo:getBadgeNum())
end

function var_0_0.recordEpisodeReadyUseBadgeNum(arg_11_0, arg_11_1)
	arg_11_0._readyUseBadgeNum = arg_11_1 or 0
end

function var_0_0.getEpisodeReadyUseBadgeNum(arg_12_0)
	return arg_12_0._readyUseBadgeNum or 0
end

function var_0_0.clearEpisodeReadyUseBadgeNum(arg_13_0)
	arg_13_0._readyUseBadgeNum = nil
end

function var_0_0.getUnlockSupportHeros(arg_14_0)
	return arg_14_0._actInfo and arg_14_0._actInfo:getUnlockSupportHeros()
end

function var_0_0.recordBattleFinishedInfo(arg_15_0, arg_15_1)
	arg_15_0:clearBattleFinishedInfo()

	arg_15_0._battleFinishedInfo = arg_15_1

	if arg_15_0._actInfo and arg_15_0._battleFinishedInfo then
		arg_15_0:recordNewFinishEpisodeId()
		arg_15_0:recordNewFinishGroupId()
		arg_15_0:recordNewUnlockHardMainGroup()
	end
end

function var_0_0.getBattleFinishedInfo(arg_16_0)
	return arg_16_0._battleFinishedInfo
end

function var_0_0.clearBattleFinishedInfo(arg_17_0)
	arg_17_0._battleFinishedInfo = nil
	arg_17_0._newFinishEpisodeId = nil
	arg_17_0._newFinishGroupId = nil
	arg_17_0._isHardMainGroupNewUnlock = false
end

function var_0_0.isHeroRepressInEpisode(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = Act183Config.instance:getEpisodeCo(arg_18_1)
	local var_18_1 = var_18_0 and var_18_0.groupId
	local var_18_2 = arg_18_0:getGroupEpisodeMo(var_18_1)

	return var_18_2 and var_18_2:isHeroRepress(arg_18_2)
end

function var_0_0.isHeroRepressInPreEpisode(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = Act183Config.instance:getEpisodeCo(arg_19_1)
	local var_19_1 = var_19_0 and var_19_0.groupId
	local var_19_2 = arg_19_0:getGroupEpisodeMo(var_19_1)

	return var_19_2 and var_19_2:isHeroRepressInPreEpisode(arg_19_1, arg_19_2)
end

function var_0_0.recordEpisodeSelectConditions(arg_20_0, arg_20_1)
	arg_20_0._selectConditions = {}

	for iter_20_0, iter_20_1 in pairs(arg_20_1) do
		if iter_20_1 == true then
			table.insert(arg_20_0._selectConditions, iter_20_0)
		end
	end
end

function var_0_0.getRecordEpisodeSelectConditions(arg_21_0)
	return arg_21_0._selectConditions
end

function var_0_0.recordNewFinishEpisodeId(arg_22_0)
	if arg_22_0._battleFinishedInfo.win then
		local var_22_0 = arg_22_0._battleFinishedInfo.episodeMo
		local var_22_1 = var_22_0:getEpisodeId()

		if arg_22_0:getEpisodeMoById(var_22_1):getStatus() ~= var_22_0:getStatus() then
			arg_22_0._newFinishEpisodeId = var_22_1
		end
	end
end

function var_0_0.recordNewFinishGroupId(arg_23_0)
	local var_23_0 = arg_23_0._battleFinishedInfo.win
	local var_23_1 = arg_23_0._battleFinishedInfo.groupFinished

	if var_23_0 and var_23_1 then
		local var_23_2 = arg_23_0._battleFinishedInfo.episodeMo
		local var_23_3 = var_23_2:getGroupId()
		local var_23_4 = var_23_2:getPassOrder()
		local var_23_5 = arg_23_0:getGroupEpisodeMo(var_23_3)
		local var_23_6 = var_23_5 and var_23_5:isGroupFinished()
		local var_23_7 = var_23_5 and var_23_5:getEpisodeCount() or 0

		if not var_23_6 and var_23_7 <= var_23_4 then
			arg_23_0._newFinishGroupId = var_23_3
		end
	end
end

function var_0_0.recordNewUnlockHardMainGroup(arg_24_0)
	if arg_24_0._newFinishGroupId then
		local var_24_0 = arg_24_0:getGroupEpisodeMo(arg_24_0._newFinishGroupId)

		if (var_24_0 and var_24_0:getGroupType()) == Act183Enum.GroupType.NormalMain and not var_24_0:isHasFinished() then
			arg_24_0._isHardMainGroupNewUnlock = true
		end
	end
end

function var_0_0.getNewFinishEpisodeId(arg_25_0)
	return arg_25_0._newFinishEpisodeId
end

function var_0_0.isEpisodeNewUnlock(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0:getEpisodeMoById(arg_26_1)

	if (var_26_0 and var_26_0:getStatus()) ~= Act183Enum.EpisodeStatus.Unlocked then
		return
	end

	if not arg_26_0._battleFinishedInfo then
		return
	end

	local var_26_1 = var_26_0:getPreEpisodeIds()

	if var_26_1 then
		local var_26_2 = arg_26_0._battleFinishedInfo.episodeMo
		local var_26_3 = var_26_2 and var_26_2:getEpisodeId()

		return tabletool.indexOf(var_26_1, var_26_3) ~= nil
	end
end

function var_0_0.getNewFinishGroupId(arg_27_0)
	return arg_27_0._newFinishGroupId
end

function var_0_0.isHardMainGroupNewUnlock(arg_28_0)
	return arg_28_0._isHardMainGroupNewUnlock
end

function var_0_0.initTaskStatusMap(arg_29_0)
	if arg_29_0._initUnfinishTaskMapDone then
		return
	end

	arg_29_0._unfinishTaskMap = {}

	local var_29_0 = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.Activity183, arg_29_0._activityId)

	if var_29_0 then
		for iter_29_0, iter_29_1 in ipairs(var_29_0) do
			local var_29_1 = iter_29_1.config
			local var_29_2 = var_29_1 and var_29_1.groupId

			arg_29_0._unfinishTaskMap[var_29_2] = arg_29_0._unfinishTaskMap[var_29_2] or {}

			if not Act183Helper.isTaskFinished(var_29_1.id) then
				table.insert(arg_29_0._unfinishTaskMap[var_29_2], var_29_1.id)
			end
		end
	end

	arg_29_0._initUnfinishTaskMapDone = true
end

function var_0_0.getUnfinishTaskMap(arg_30_0)
	return arg_30_0._unfinishTaskMap
end

function var_0_0.recordLastRepressEpisodeId(arg_31_0, arg_31_1)
	arg_31_0._recordRepressEpisodeId = arg_31_1
end

function var_0_0.getRecordLastRepressEpisodeId(arg_32_0)
	return arg_32_0._recordRepressEpisodeId
end

function var_0_0.clearRecordLastRepressEpisodeId(arg_33_0)
	arg_33_0._recordRepressEpisodeId = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
