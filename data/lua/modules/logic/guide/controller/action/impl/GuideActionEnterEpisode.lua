module("modules.logic.guide.controller.action.impl.GuideActionEnterEpisode", package.seeall)

local var_0_0 = class("GuideActionEnterEpisode", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	local var_1_0 = string.splitToNumber(arg_1_0.actionParam, "#")
	local var_1_1 = var_1_0[1]
	local var_1_2 = var_1_0[2]
	local var_1_3 = var_1_1 and lua_episode.configDict[var_1_1]

	if var_1_3 then
		if DungeonConfig.instance:getChapterCO(var_1_3.chapterId).type == DungeonEnum.ChapterType.Newbie then
			DungeonFightController.instance:enterNewbieFight(var_1_3.chapterId, var_1_1)
		else
			DungeonFightController.instance:enterFight(var_1_3.chapterId, var_1_1, nil)
		end

		local var_1_4 = FightModel.instance:getFightParam()

		if var_1_2 == 0 then
			var_1_4:setShowSettlement(false)
		end

		arg_1_0:onDone(true)
	else
		logError("Guide episode id nil, guide_" .. arg_1_0.guideId .. "_" .. arg_1_0.stepId)
		arg_1_0:onDone(false)
	end
end

return var_0_0
