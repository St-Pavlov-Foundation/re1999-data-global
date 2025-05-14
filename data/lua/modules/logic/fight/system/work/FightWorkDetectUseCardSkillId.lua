module("modules.logic.fight.system.work.FightWorkDetectUseCardSkillId", package.seeall)

local var_0_0 = class("FightWorkDetectUseCardSkillId", FightWorkItem)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0:com_registWorkDoneFlowSequence()

	var_1_0:addWork(Work2FightWork.New(FightWorkNormalDialog, FightViewDialog.Type.DetectHaveCardAfterEndOperation))
	var_1_0:start()
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
