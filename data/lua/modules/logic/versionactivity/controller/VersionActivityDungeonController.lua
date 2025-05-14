module("modules.logic.versionactivity.controller.VersionActivityDungeonController", package.seeall)

local var_0_0 = class("VersionActivityDungeonController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.openVersionActivityDungeonMapView(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	arg_3_0.rpcCallback = arg_3_3
	arg_3_0.rpcCallbackObj = arg_3_4
	arg_3_0.openViewParam = {
		chapterId = arg_3_1,
		episodeId = arg_3_2
	}

	if arg_3_5 then
		for iter_3_0, iter_3_1 in pairs(arg_3_5) do
			arg_3_0.openViewParam[iter_3_0] = iter_3_1
		end
	end

	Activity113Rpc.instance:sendGetAct113InfoRequest(VersionActivity1_6Enum.ActivityId.Reactivity, function()
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.ActivityDungeon
		}, arg_3_0._openVersionActivityDungeonMapView, arg_3_0)
	end)
end

function var_0_0._openVersionActivityDungeonMapView(arg_5_0)
	ViewMgr.instance:openView(ViewName.VersionActivityDungeonMapView, arg_5_0.openViewParam)

	if arg_5_0.rpcCallback then
		arg_5_0.rpcCallback(arg_5_0.rpcCallbackObj)
	end
end

function var_0_0.getEpisodeMapConfig(arg_6_0, arg_6_1)
	local var_6_0 = DungeonConfig.instance:getEpisodeCO(arg_6_1)

	if var_6_0.chapterId == VersionActivityEnum.DungeonChapterId.LeiMiTeBeiHard then
		local var_6_1 = DungeonConfig.instance:getEpisodeLevelIndexByEpisodeId(arg_6_1)
		local var_6_2 = DungeonConfig.instance:getChapterEpisodeCOList(VersionActivityEnum.DungeonChapterId.LeiMiTeBei)

		for iter_6_0, iter_6_1 in ipairs(var_6_2) do
			if var_6_1 == DungeonConfig.instance:getEpisodeLevelIndexByEpisodeId(iter_6_1.id) then
				var_6_0 = iter_6_1

				break
			end
		end
	else
		while var_6_0.chapterId ~= VersionActivityEnum.DungeonChapterId.LeiMiTeBei do
			var_6_0 = DungeonConfig.instance:getEpisodeCO(var_6_0.preEpisode)
		end
	end

	return DungeonConfig.instance:getChapterMapCfg(VersionActivityEnum.DungeonChapterId.LeiMiTeBei, var_6_0.preEpisode)
end

var_0_0.instance = var_0_0.New()

return var_0_0
