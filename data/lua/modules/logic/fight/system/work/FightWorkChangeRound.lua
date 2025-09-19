module("modules.logic.fight.system.work.FightWorkChangeRound", package.seeall)

local var_0_0 = class("FightWorkChangeRound", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	if FightModel.instance:getVersion() < 3 then
		arg_1_0:onDone(true)

		return
	end

	FightModel.instance._curRoundId = (FightModel.instance._curRoundId or 1) + 1

	FightController.instance:dispatchEvent(FightEvent.ChangeRound)

	local var_1_0 = FightDataHelper.entityMgr:getMySubList()

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		iter_1_1.subCd = 0

		FightController.instance:dispatchEvent(FightEvent.ChangeEntitySubCd, iter_1_1.uid)
	end

	local var_1_1 = arg_1_0:com_registWorkDoneFlowSequence()

	var_1_1:registWork(Work2FightWork, FightWorkFbStory, FightWorkFbStory.Type_ChangeRound, FightModel.instance._curRoundId)
	var_1_1:start()
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
