module("modules.logic.fight.model.data.FightDataModel", package.seeall)

local var_0_0 = class("FightDataModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.initDouQuQu(arg_3_0)
	arg_3_0.douQuQuMgr = FightDouQuQuDataMgr.New()

	return arg_3_0.douQuQuMgr
end

function var_0_0.initAiJiAoAutoSequenceForGM(arg_4_0)
	arg_4_0.aiJiAoAutoSequenceForGM = FightAiJiAoAutoSequenceForGM.New()

	return arg_4_0.aiJiAoAutoSequenceForGM
end

var_0_0.instance = var_0_0.New()

return var_0_0
