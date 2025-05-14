module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.controller.VersionActivity1_3DungeonController", package.seeall)

local var_0_0 = class("VersionActivity1_3DungeonController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.directFocusDaily = false
	arg_2_0.dailyFromEpisodeId = nil
end

function var_0_0.openVersionActivityDungeonMapView(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	arg_3_0.openViewParam = {
		chapterId = arg_3_1,
		episodeId = arg_3_2
	}

	if arg_3_5 then
		for iter_3_0, iter_3_1 in pairs(arg_3_5) do
			arg_3_0.openViewParam[iter_3_0] = iter_3_1
		end
	end

	Activity113Rpc.instance:sendGetAct113InfoRequest(VersionActivity1_3Enum.ActivityId.Dungeon)

	if #TaskModel.instance:getTaskMoList(TaskEnum.TaskType.ActivityDungeon, VersionActivity1_3Enum.ActivityId.Dungeon) > 0 and Activity126Model.instance.isInit then
		ViewMgr.instance:openView(ViewName.VersionActivity1_3DungeonMapView, arg_3_0.openViewParam)

		if arg_3_3 then
			arg_3_3()
		end

		return
	end

	if ActivityModel.instance:isActOnLine(VersionActivity1_3Enum.ActivityId.Act310) then
		Activity126Rpc.instance:sendGet126InfosRequest(VersionActivity1_3Enum.ActivityId.Act310)
	end

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, function()
		ViewMgr.instance:openView(ViewName.VersionActivity1_3DungeonMapView, arg_3_0.openViewParam)

		if arg_3_3 then
			arg_3_3()
		end
	end)
end

function var_0_0.getEpisodeMapConfig(arg_5_0, arg_5_1)
	local var_5_0 = DungeonConfig.instance:getEpisodeCO(arg_5_1)

	if var_5_0.chapterId == VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBeiHard then
		local var_5_1 = DungeonConfig.instance:getEpisodeLevelIndexByEpisodeId(arg_5_1)
		local var_5_2 = DungeonConfig.instance:getChapterEpisodeCOList(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei)

		for iter_5_0, iter_5_1 in ipairs(var_5_2) do
			if var_5_1 == DungeonConfig.instance:getEpisodeLevelIndexByEpisodeId(iter_5_1.id) then
				var_5_0 = iter_5_1

				break
			end
		end
	else
		while var_5_0.chapterId ~= VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei do
			var_5_0 = DungeonConfig.instance:getEpisodeCO(var_5_0.preEpisode)
		end
	end

	return DungeonConfig.instance:getChapterMapCfg(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei, var_5_0.preEpisode)
end

function var_0_0.isDayTime(arg_6_0, arg_6_1)
	if DungeonConfig.instance:getEpisodeCO(arg_6_1).chapterId == VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBeiHard then
		arg_6_1 = arg_6_1 - 10000
	end

	return arg_6_1 < VersionActivity1_3DungeonEnum.DailyEpisodeId or arg_6_1 == VersionActivity1_3DungeonEnum.ExtraEpisodeId
end

function var_0_0.openDungeonChangeView(arg_7_0, arg_7_1)
	ViewMgr.instance:openView(ViewName.VersionActivity1_3DungeonChangeView, arg_7_1)
end

function var_0_0.getEpisodeIndex(arg_8_0, arg_8_1)
	local var_8_0 = DungeonConfig.instance:getEpisodeCO(arg_8_1)

	if var_8_0.chapterId == VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBeiHard then
		arg_8_1 = arg_8_1 - 10000
		var_8_0 = DungeonConfig.instance:getEpisodeCO(arg_8_1)
	elseif var_8_0.chapterId == VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei3 then
		var_8_0 = DungeonConfig.instance:getEpisodeCO(var_8_0.preEpisode)
	elseif var_8_0.chapterId == VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei4 then
		var_8_0 = DungeonConfig.instance:getEpisodeCO(var_8_0.preEpisode)
		var_8_0 = DungeonConfig.instance:getEpisodeCO(var_8_0.preEpisode)
	end

	return DungeonConfig.instance:getChapterEpisodeIndexWithSP(var_8_0.chapterId, var_8_0.id)
end

var_0_0.instance = var_0_0.New()

return var_0_0
