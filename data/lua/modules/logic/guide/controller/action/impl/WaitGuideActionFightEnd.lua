module("modules.logic.guide.controller.action.impl.WaitGuideActionFightEnd", package.seeall)

local var_0_0 = class("WaitGuideActionFightEnd", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	if string.find(arg_1_0.actionParam, ",") then
		arg_1_0._episodeIdList = string.splitToNumber(arg_1_0.actionParam, ",")
	else
		arg_1_0._episodeId = tonumber(arg_1_0.actionParam)
	end

	FightController.instance:registerCallback(FightEvent.PushEndFight, arg_1_0._endFight, arg_1_0)
end

function var_0_0._endFight(arg_2_0)
	if arg_2_0._episodeId then
		local var_2_0 = DungeonModel.instance:getEpisodeInfo(arg_2_0._episodeId)

		if var_2_0 and var_2_0.star > DungeonEnum.StarType.None then
			arg_2_0:onDone(true)
		end
	elseif arg_2_0._episodeIdList then
		for iter_2_0, iter_2_1 in ipairs(arg_2_0._episodeIdList) do
			local var_2_1 = DungeonModel.instance:getEpisodeInfo(iter_2_1)

			if var_2_1 and var_2_1.star > DungeonEnum.StarType.None then
				arg_2_0:onDone(true)
			end
		end
	else
		arg_2_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.PushEndFight, arg_3_0._endFight, arg_3_0)
end

return var_0_0
