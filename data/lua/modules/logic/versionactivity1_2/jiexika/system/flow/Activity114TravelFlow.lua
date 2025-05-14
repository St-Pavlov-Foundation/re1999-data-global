module("modules.logic.versionactivity1_2.jiexika.system.flow.Activity114TravelFlow", package.seeall)

local var_0_0 = class("Activity114TravelFlow", Activity114BaseFlow)

function var_0_0.addSkipWork(arg_1_0)
	if Activity114Model.instance.serverData.battleEventId > 0 then
		arg_1_0.context.result = Activity114Enum.Result.Fail

		arg_1_0:addWork(Activity114FightResultWork.New())
		arg_1_0:addWork(Activity114OpenAttrViewWork.New())

		return
	end

	var_0_0.super.addSkipWork(arg_1_0)
end

function var_0_0.addEventWork(arg_2_0)
	arg_2_0:addWork(Activity114CheckWork.New())
	arg_2_0:addWork(Activity114CheckOrAnswerWork.New())
end

return var_0_0
