module("modules.logic.fight.view.cardeffect.FightEnemyPlayCardInEffect", package.seeall)

local var_0_0 = class("FightEnemyPlayCardInEffect", BaseWork)
local var_0_1 = Color.white

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	for iter_1_0 = 1, arg_1_1.enemyNowActPoint do
		local var_1_0 = gohelper.findChild(arg_1_1.viewGO, string.format("root/enemycards/item%d/op", iter_1_0))

		gohelper.setActive(var_1_0, true)

		local var_1_1 = gohelper.findChild(arg_1_1.viewGO, string.format("root/enemycards/item%d/empty", iter_1_0))

		gohelper.setActive(var_1_1, true)

		gohelper.onceAddComponent(var_1_1, gohelper.Type_Image).color = var_0_1
	end

	TaskDispatcher.runDelay(arg_1_0._delayDone, arg_1_0, 0.34)
end

function var_0_0.clearWork(arg_2_0)
	TaskDispatcher.cancelTask(arg_2_0._delayDone, arg_2_0)
end

function var_0_0._delayDone(arg_3_0)
	arg_3_0:onDone(true)
end

return var_0_0
