module("modules.logic.guide.controller.action.impl.WaitGuideActionFightEndPause", package.seeall)

local var_0_0 = class("WaitGuideActionFightEndPause", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	arg_1_0._needSuccess = arg_1_0.actionParam == "1"

	if arg_1_0.actionParam and string.find(arg_1_0.actionParam, ",") then
		local var_1_0 = string.splitToNumber(arg_1_0.actionParam, ",")

		arg_1_0._needSuccess = var_1_0[1]
		arg_1_0._episodeId = var_1_0[2]
	end

	FightController.instance:registerCallback(FightEvent.OnGuideFightEndPause, arg_1_0._onGuideFightEndPause, arg_1_0)
end

function var_0_0._onGuideFightEndPause(arg_2_0, arg_2_1)
	local var_2_0 = FightModel.instance:getRecordMO()

	if arg_2_0._episodeId then
		local var_2_1 = FightModel.instance:getFightParam()

		if arg_2_0._episodeId == var_2_1.episodeId then
			if arg_2_0._needSuccess then
				if var_2_0.fightResult == FightEnum.FightResult.Succ then
					arg_2_1.OnGuideFightEndPause = true

					FightController.instance:unregisterCallback(FightEvent.OnGuideFightEndPause, arg_2_0._onGuideFightEndPause, arg_2_0)
					arg_2_0:onDone(true)
				end
			else
				arg_2_1.OnGuideFightEndPause = true

				FightController.instance:unregisterCallback(FightEvent.OnGuideFightEndPause, arg_2_0._onGuideFightEndPause, arg_2_0)
				arg_2_0:onDone(true)
			end
		end
	elseif arg_2_0._needSuccess then
		if var_2_0.fightResult == FightEnum.FightResult.Succ then
			arg_2_1.OnGuideFightEndPause = true

			FightController.instance:unregisterCallback(FightEvent.OnGuideFightEndPause, arg_2_0._onGuideFightEndPause, arg_2_0)
			arg_2_0:onDone(true)
		end
	else
		arg_2_1.OnGuideFightEndPause = true

		FightController.instance:unregisterCallback(FightEvent.OnGuideFightEndPause, arg_2_0._onGuideFightEndPause, arg_2_0)
		arg_2_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnGuideFightEndPause, arg_3_0._onGuideFightEndPause, arg_3_0)
end

return var_0_0
