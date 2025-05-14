module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.controller.VersionActivity1_2DungeonController", package.seeall)

local var_0_0 = class("VersionActivity1_2DungeonController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	return
end

function var_0_0.setDungeonSelectedEpisodeId(arg_5_0, arg_5_1)
	arg_5_0.dungeonSelectedEpisodeId = arg_5_1
end

function var_0_0.getDungeonSelectedEpisodeId(arg_6_0)
	return arg_6_0.dungeonSelectedEpisodeId
end

function var_0_0.getEpisodeMapConfig(arg_7_0, arg_7_1)
	local var_7_0 = DungeonConfig.instance:getEpisodeCO(arg_7_1)
	local var_7_1 = VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal1

	while var_7_0.chapterId ~= var_7_1 do
		var_7_0 = DungeonConfig.instance:getEpisodeCO(var_7_0.preEpisode)
	end

	return DungeonConfig.instance:getChapterMapCfg(var_7_1, var_7_0.preEpisode)
end

function var_0_0._onFinishStory(arg_8_0)
	arg_8_0:openDungeonView(arg_8_0._enterChapterId, arg_8_0._enterEpisodeId, arg_8_0._showMapLevelView, arg_8_0._focusCamp)
end

function var_0_0.openDungeonView(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	if not VersionActivityBaseController.instance:isPlayedActivityVideo(VersionActivity1_2Enum.ActivityId.Dungeon) then
		local var_9_0 = ActivityConfig.instance:getActivityCo(VersionActivity1_2Enum.ActivityId.Dungeon)
		local var_9_1 = var_9_0 and var_9_0.storyId

		if var_9_1 and var_9_1 ~= 0 then
			arg_9_0._enterChapterId = arg_9_1
			arg_9_0._enterEpisodeId = arg_9_2
			arg_9_0._showMapLevelView = arg_9_3
			arg_9_0._focusCamp = arg_9_4

			StoryController.instance:playStory(var_9_1, nil, arg_9_0._onFinishStory, arg_9_0)

			return
		end
	end

	Activity113Rpc.instance:sendGetAct113InfoRequest(VersionActivity1_7Enum.ActivityId.Reactivity, function()
		ViewMgr.instance:openView(ViewName.VersionActivity1_2DungeonView, {
			chapterId = arg_9_1,
			episodeId = arg_9_2,
			showMapLevelView = arg_9_3,
			focusCamp = arg_9_4,
			jumpParam = arg_9_5
		})
	end)
end

function var_0_0._getDefaultFocusEpisode(arg_11_0, arg_11_1)
	local var_11_0 = DungeonConfig.instance:getChapterEpisodeCOList(arg_11_1)
	local var_11_1 = true
	local var_11_2

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		if not DungeonModel.instance:hasPassLevel(iter_11_1.id) then
			var_11_1 = false
		end

		if DungeonModel.instance:isUnlock(iter_11_1) and DungeonModel.instance:isFinishElementList(iter_11_1) then
			var_11_2 = iter_11_1.id
		end
	end

	if var_11_1 then
		local var_11_3 = VersionActivity1_2DungeonMapEpisodeBaseView.getlastBattleEpisodeId(arg_11_1)

		if var_11_3 > 0 then
			return var_11_3
		end
	end

	return var_11_2 or var_11_0[1].id
end

function var_0_0.getNowEpisodeId(arg_12_0)
	local var_12_0 = DungeonConfig.instance:getChapterEpisodeCOList(VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal1)
	local var_12_1 = var_12_0[1].id

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		if DungeonModel.instance:isUnlock(iter_12_1) and DungeonModel.instance:isFinishElementList(iter_12_1) then
			var_12_1 = iter_12_1.id
		end
	end

	return var_12_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
