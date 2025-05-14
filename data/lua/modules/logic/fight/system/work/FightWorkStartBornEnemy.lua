module("modules.logic.fight.system.work.FightWorkStartBornEnemy", package.seeall)

local var_0_0 = class("FightWorkStartBornEnemy", BaseWork)
local var_0_1 = 10

function var_0_0.onStart(arg_1_0)
	if FightWorkAppearTimeline.hasAppearTimeline() then
		arg_1_0:onDone(true)

		return
	end

	arg_1_0._flowParallel = FlowParallel.New()

	local var_1_0 = FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide, false)

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		if not arg_1_0.context.oldEntityIdDict or not arg_1_0.context.oldEntityIdDict[iter_1_1.id] then
			local var_1_1 = true
			local var_1_2 = iter_1_1:getMO()

			if FightMsgMgr.sendMsg(FightMsgId.IsEvolutionSkin, var_1_2.skin) then
				var_1_1 = false
			end

			if var_1_1 then
				arg_1_0._flowParallel:addWork(FightWorkStartBornNormal.New(iter_1_1, false))
			else
				FightController.instance:dispatchEvent(FightEvent.OnStartFightPlayBornNormal, iter_1_1.id)
			end
		end
	end

	TaskDispatcher.runDelay(arg_1_0._onBornTimeout, arg_1_0, var_0_1)
	arg_1_0._flowParallel:registerDoneListener(arg_1_0._onEnemyBornDone, arg_1_0)
	arg_1_0._flowParallel:start()
end

function var_0_0._onEnemyBornDone(arg_2_0)
	arg_2_0._flowParallel:unregisterDoneListener(arg_2_0._onEnemyBornDone, arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0._onBornTimeout(arg_3_0)
	logError("播放出生效果时间超过" .. var_0_1 .. "秒")
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	if arg_4_0._flowParallel then
		arg_4_0._flowParallel:stop()
		arg_4_0._flowParallel:unregisterDoneListener(arg_4_0._onEnemyBornDone, arg_4_0)
	end

	TaskDispatcher.cancelTask(arg_4_0._onBornTimeout, arg_4_0)
end

return var_0_0
