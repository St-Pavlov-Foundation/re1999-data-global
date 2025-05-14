module("modules.logic.fight.system.work.FightWorkDialogueBeforeRoundStart", package.seeall)

local var_0_0 = class("FightWorkDialogueBeforeRoundStart", FightWorkItem)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0:com_registWorkDoneFlowSequence()

	var_1_0:addWork(Work2FightWork.New(FightWorkNormalDialog, FightViewDialog.Type.HaveBuffAndHaveDamageSkill_onlyCheckOnce))
	var_1_0:start()
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
