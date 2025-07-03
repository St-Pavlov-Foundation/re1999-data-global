module("modules.logic.fight.system.work.FightWorkEffectDice", package.seeall)

local var_0_0 = class("FightWorkEffectDice", FightEffectBase)
local var_0_1

function var_0_0.onStart(arg_1_0)
	if var_0_1 then
		table.insert(var_0_1, {
			arg_1_0.fightStepData,
			arg_1_0.actEffectData
		})
	else
		var_0_1 = {}

		table.insert(var_0_1, {
			arg_1_0.fightStepData,
			arg_1_0.actEffectData
		})
		TaskDispatcher.runDelay(arg_1_0._delayStart, arg_1_0, 0.01)
	end
end

function var_0_0._delayStart(arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnDiceEnd, arg_2_0._onDiceEnd, arg_2_0)
	arg_2_0:com_registTimer(arg_2_0._delayDone, 10)

	local var_2_0 = ViewName.FightDiceView
	local var_2_1 = FightModel.instance:getFightParam()
	local var_2_2 = DungeonConfig.instance:getEpisodeCO(var_2_1.episodeId)
	local var_2_3 = var_2_2 and var_2_2.type

	if Activity104Model.instance:isSeasonEpisodeType(var_2_3) then
		var_2_0 = ViewName.FightSeasonDiceView
	end

	ViewMgr.instance:openView(var_2_0, var_0_1)

	var_0_1 = nil
end

function var_0_0._delayDone(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0._onDiceEnd(arg_4_0)
	arg_4_0:onDone(true)
end

function var_0_0.clearWork(arg_5_0)
	FightController.instance:unregisterCallback(FightEvent.OnDiceEnd, arg_5_0._onDiceEnd, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._delayStart, arg_5_0)
end

return var_0_0
