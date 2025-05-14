module("modules.logic.fight.view.cardeffect.FightEnemyActPointBreakEffect", package.seeall)

local var_0_0 = class("FightEnemyActPointBreakEffect", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	if not arg_1_1.enemyHasDeadEntity or arg_1_1.enemyBreakActPoint == 0 then
		arg_1_0:onDone(true)

		return
	end

	local var_1_0 = arg_1_1.enemyNowActPoint + arg_1_1.enemyBreakActPoint

	for iter_1_0 = 1, var_1_0 do
		gohelper.setActive(gohelper.findChild(arg_1_1.viewGO, string.format("root/enemycards/item%d", iter_1_0)), true)
	end

	for iter_1_1 = arg_1_1.enemyNowActPoint + 1, var_1_0 do
		local var_1_1 = gohelper.findChild(arg_1_1.viewGO, string.format("root/enemycards/item%d/empty", iter_1_1))

		if var_1_1 then
			local var_1_2 = var_1_1:GetComponent(typeof(UnityEngine.Animation))

			if var_1_2 then
				var_1_2:Play()
			end
		end
	end

	TaskDispatcher.runDelay(arg_1_0._delayDone, arg_1_0, 0.8)
end

function var_0_0.clearWork(arg_2_0)
	TaskDispatcher.cancelTask(arg_2_0._delayDone, arg_2_0)
end

function var_0_0._delayDone(arg_3_0)
	local var_3_0 = arg_3_0.context
	local var_3_1 = var_3_0.enemyNowActPoint + var_3_0.enemyBreakActPoint

	for iter_3_0 = 1, var_3_1 do
		gohelper.setActive(gohelper.findChild(var_3_0.viewGO, string.format("root/enemycards/item%d", iter_3_0)), iter_3_0 <= var_3_0.enemyNowActPoint)
	end

	for iter_3_1 = var_3_0.enemyNowActPoint + 1, var_3_1 do
		local var_3_2 = gohelper.findChild(var_3_0.viewGO, string.format("root/enemycards/item%d/empty/die", iter_3_1))

		gohelper.setActive(var_3_2, false)

		local var_3_3 = gohelper.findChild(var_3_0.viewGO, string.format("root/enemycards/item%d/empty", iter_3_1))

		if var_3_3 then
			local var_3_4 = var_3_3:GetComponent(typeof(UnityEngine.Animation))

			if var_3_4 then
				var_3_4:Stop()
			end

			local var_3_5 = var_3_3:GetComponent(gohelper.Type_Image)

			if var_3_5 then
				var_3_5.color = Color.white
			end
		end
	end

	arg_3_0:onDone(true)
end

return var_0_0
