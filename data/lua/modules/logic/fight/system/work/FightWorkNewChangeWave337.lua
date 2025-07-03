module("modules.logic.fight.system.work.FightWorkNewChangeWave337", package.seeall)

local var_0_0 = class("FightWorkNewChangeWave337", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0:com_registWorkDoneFlowSequence()

	var_1_0:registWork(Work2FightWork, FightWorkStepChangeWave, arg_1_0.actEffectData.fight)
	var_1_0:registWork(Work2FightWork, FightWorkAppearTimeline)
	var_1_0:registWork(Work2FightWork, FightWorkStartBornEnemy)
	var_1_0:registWork(Work2FightWork, FightWorkFocusMonster)
	var_1_0:registWork(FightWorkFunction, arg_1_0.sendChangeWaveEvent, arg_1_0)
	var_1_0:start({})
end

function var_0_0.sendChangeWaveEvent(arg_2_0)
	FightController.instance:beginWave()
end

return var_0_0
