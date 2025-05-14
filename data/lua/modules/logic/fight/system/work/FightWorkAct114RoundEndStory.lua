module("modules.logic.fight.system.work.FightWorkAct114RoundEndStory", package.seeall)

local var_0_0 = class("FightWorkAct114RoundEndStory", BaseWork)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = FightModel.instance:getFightParam()

	if not var_1_0 or var_1_0.episodeId ~= Activity114Enum.episodeId then
		arg_1_0:onDone(true)

		return
	end

	if Activity114Model.instance:isEnd() then
		Activity114Controller.instance:registerCallback(Activity114Event.OnEventProcessEnd, arg_1_0.onProcessEnd, arg_1_0)
		Activity114Controller.instance:alertActivityEndMsgBox()

		return
	end

	local var_1_1 = FightModel.instance:getRecordMO()

	if not var_1_1 then
		arg_1_0:onDone(true)

		return
	end

	Activity114Controller.instance:registerCallback(Activity114Event.OnEventProcessEnd, arg_1_0.onProcessEnd, arg_1_0)

	local var_1_2 = var_1_1.fightResult == FightEnum.FightResult.Succ and Activity114Enum.Result.FightSucess or Activity114Enum.Result.Fail

	Activity114Controller.instance:dispatchEvent(Activity114Event.OnFightResult, var_1_2)
end

function var_0_0.onProcessEnd(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.onDestroy(arg_3_0)
	Activity114Controller.instance:unregisterCallback(Activity114Event.OnEventProcessEnd, arg_3_0.onProcessEnd, arg_3_0)
end

return var_0_0
