module("modules.logic.fight.system.work.FightWorkChangeWaveView", package.seeall)

local var_0_0 = class("FightWorkChangeWaveView", BaseWork)

function var_0_0.onStart(arg_1_0)
	if FightReplayModel.instance:isReplay() then
		arg_1_0:onDone(true)
	else
		local var_1_0 = FightModel.instance:getFightParam()

		if var_1_0 then
			local var_1_1 = false
			local var_1_2 = var_1_0.episodeId

			if var_1_2 == 1310102 or var_1_2 == 1310111 then
				var_1_1 = true
			end

			local var_1_3 = var_1_0.battleId

			if var_1_3 == 9130101 or var_1_3 == 9130107 then
				var_1_1 = true
			end

			if var_1_1 then
				ViewMgr.instance:openView(ViewName.FightWaveChangeView)
				TaskDispatcher.runDelay(arg_1_0._done, arg_1_0, 1)

				return
			end
		end

		arg_1_0:onDone(true)
	end
end

function var_0_0._done(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	ViewMgr.instance:closeView(ViewName.FightWaveChangeView)
	TaskDispatcher.cancelTask(arg_3_0._done, arg_3_0)
end

return var_0_0
