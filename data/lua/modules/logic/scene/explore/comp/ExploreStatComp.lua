module("modules.logic.scene.explore.comp.ExploreStatComp", package.seeall)

local var_0_0 = class("ExploreStatComp", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onScenePrepared(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._beginTime = UnityEngine.Time.realtimeSinceStartup
	arg_2_0._isExit = false

	local var_2_0 = ExploreConfig.instance:getMapIdConfig(ExploreModel.instance.mapId)

	arg_2_0._episodeId = var_2_0.episodeId
	arg_2_0._chapterId = var_2_0.chapterId
end

function var_0_0.onTriggerSpike(arg_3_0, arg_3_1)
	arg_3_0:_onExitStat("人物返回出生点", tostring(arg_3_1))
end

function var_0_0.onTriggerExit(arg_4_0, arg_4_1)
	arg_4_0._isExit = true

	arg_4_0:_onExitStat("成功", tostring(arg_4_1))
end

function var_0_0.onTriggerEggs(arg_5_0, arg_5_1, arg_5_2)
	StatController.instance:track(StatEnum.EventName.click_eggs_option, {
		[StatEnum.EventProperties.Dialogue_id] = arg_5_1,
		[StatEnum.EventProperties.eggs_name] = arg_5_2
	})
end

function var_0_0._onExitStat(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = UnityEngine.Time.realtimeSinceStartup - arg_6_0._beginTime
	local var_6_1 = tostring(arg_6_0._episodeId)
	local var_6_2 = ExploreModel.instance:getChallengeCount() + 1
	local var_6_3, var_6_4, var_6_5 = ExploreSimpleModel.instance:getCoinCountByMapId(ExploreModel.instance.mapId)
	local var_6_6 = arg_6_2 or "主动退出"
	local var_6_7 = ExploreHelper.getKeyXY(ExploreMapModel.instance:getHeroPos())
	local var_6_8 = {}
	local var_6_9 = ExploreSimpleModel.instance:getChapterMo(arg_6_0._chapterId)

	if var_6_9 then
		local var_6_10 = lua_explore_story.configDict[arg_6_0._chapterId]

		if var_6_10 then
			for iter_6_0 in pairs(var_6_9.archiveIds) do
				local var_6_11 = var_6_10[iter_6_0]

				table.insert(var_6_8, var_6_11.title)
			end
		end
	end

	StatController.instance:track(StatEnum.EventName.Exit_backroom, {
		[StatEnum.EventProperties.UseTime] = var_6_0,
		[StatEnum.EventProperties.EpisodeId] = var_6_1,
		[StatEnum.EventProperties.ChallengesNum] = var_6_2,
		[StatEnum.EventProperties.collected_treasure] = var_6_3,
		[StatEnum.EventProperties.collected_gold] = var_6_4,
		[StatEnum.EventProperties.collected_purplecoin] = var_6_5,
		[StatEnum.EventProperties.Result] = arg_6_1,
		[StatEnum.EventProperties.FailReason] = var_6_6,
		[StatEnum.EventProperties.coordinate] = var_6_7,
		[StatEnum.EventProperties.story_fragment_name] = var_6_8
	})
end

function var_0_0.onSceneClose(arg_7_0)
	if not arg_7_0._isExit then
		arg_7_0:_onExitStat("主动中断")
	end
end

return var_0_0
