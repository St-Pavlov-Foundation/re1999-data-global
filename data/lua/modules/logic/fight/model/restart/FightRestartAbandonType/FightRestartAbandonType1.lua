module("modules.logic.fight.model.restart.FightRestartAbandonType.FightRestartAbandonType1", package.seeall)

local var_0_0 = class("FightRestartAbandonType1", FightRestartAbandonTypeBase)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0:__onInit()

	arg_1_0._fight_work = arg_1_1
	arg_1_0._fightParam = arg_1_2
	arg_1_0._episode_config = arg_1_3
	arg_1_0._chapter_config = arg_1_4
end

function var_0_0.canRestart(arg_2_0)
	return (arg_2_0:episodeCostIsEnough())
end

function var_0_0.startAbandon(arg_3_0)
	DungeonFightController.instance:registerCallback(DungeonEvent.OnEndDungeonReply, arg_3_0._startRequestFight, arg_3_0)
	DungeonFightController.instance:sendEndFightRequest(true)
end

function var_0_0._startRequestFight(arg_4_0, arg_4_1)
	DungeonFightController.instance:unregisterCallback(DungeonEvent.OnEndDungeonReply, arg_4_0._startRequestFight, arg_4_0)

	if arg_4_1 ~= 0 then
		FightGameMgr.restartMgr:restartFightFail()

		return
	end

	arg_4_0._fight_work:onDone(true)
end

function var_0_0.releaseSelf(arg_5_0)
	DungeonFightController.instance:unregisterCallback(DungeonEvent.OnEndDungeonReply, arg_5_0._startRequestFight, arg_5_0)
	arg_5_0:__onDispose()
end

return var_0_0
