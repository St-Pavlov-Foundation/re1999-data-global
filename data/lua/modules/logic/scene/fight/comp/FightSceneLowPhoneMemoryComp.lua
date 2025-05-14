module("modules.logic.scene.fight.comp.FightSceneLowPhoneMemoryComp", package.seeall)

local var_0_0 = class("FightSceneLowPhoneMemoryComp", BaseSceneComp)

function var_0_0.onScenePrepared(arg_1_0, arg_1_1, arg_1_2)
	FightController.instance:registerCallback(FightEvent.OnRoundSequenceFinish, arg_1_0._onRoundEnd, arg_1_0)
end

function var_0_0._onRoundEnd(arg_2_0)
	logNormal("clear no use effect")
	FightHelper.clearNoUseEffect()
end

function var_0_0.onSceneClose(arg_3_0, arg_3_1, arg_3_2)
	FightController.instance:unregisterCallback(FightEvent.OnRoundSequenceFinish, arg_3_0._onRoundEnd, arg_3_0)
end

return var_0_0
