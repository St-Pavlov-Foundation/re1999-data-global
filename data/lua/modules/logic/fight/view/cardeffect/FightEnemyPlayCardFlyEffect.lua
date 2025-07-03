module("modules.logic.fight.view.cardeffect.FightEnemyPlayCardFlyEffect", package.seeall)

local var_0_0 = class("FightEnemyPlayCardFlyEffect", BaseWork)
local var_0_1 = 1
local var_0_2 = var_0_1 * 0.033

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	local var_1_0 = FightDataHelper.roundMgr:getRoundData()

	if not var_1_0 then
		arg_1_0:onDone(true)

		return
	end

	arg_1_0._flow = FlowSequence.New()

	local var_1_1 = FlowParallel.New()

	arg_1_0._flow:addWork(var_1_1)

	local var_1_2 = var_1_0:getAIUseCardMOList()

	for iter_1_0 = 1, arg_1_1.enemyNowActPoint do
		local var_1_3 = var_1_2[iter_1_0]
		local var_1_4 = FightHelper.getEntity(var_1_3.uid)
		local var_1_5 = var_1_4 and var_1_4.nameUI
		local var_1_6 = var_1_5 and var_1_5:getOpCtrl():getSkillOpGO(var_1_3)
		local var_1_7 = gohelper.findChild(arg_1_1.viewGO, "root/enemycards/item" .. iter_1_0)
		local var_1_8 = gohelper.findChild(var_1_7, "op")
		local var_1_9 = recthelper.rectToRelativeAnchorPos(var_1_6.transform.position, var_1_7.transform)
		local var_1_10 = FlowSequence.New()

		if iter_1_0 > 1 then
			var_1_10:addWork(WorkWaitSeconds.New((iter_1_0 - 1) * var_0_2 * 4))
		end

		var_1_10:addWork(TweenWork.New({
			type = "DOAnchorPos",
			tr = var_1_8.transform,
			tox = var_1_9.x,
			toy = var_1_9.y,
			t = var_0_2 * 8
		}))
		var_1_10:addWork(FunctionWork.New(function()
			gohelper.setActive(var_1_6, true)
			gohelper.setActive(var_1_8, false)
			recthelper.setAnchor(var_1_8.transform, 0, 0)

			if not gohelper.isNil(var_1_6) and var_1_5 then
				var_1_5:getOpCtrl():onFlyEnd(MonoHelper.getLuaComFromGo(var_1_6, FightOpItem))
			end
		end))
		var_1_1:addWork(var_1_10)
	end

	arg_1_0._flow:addWork(FunctionWork.New(function()
		gohelper.setActive(gohelper.findChild(arg_1_1.viewGO, "root/enemycards"), false)
	end))
	arg_1_0._flow:registerDoneListener(arg_1_0._onDone, arg_1_0)
	arg_1_0._flow:start()
	TaskDispatcher.runDelay(arg_1_0._delayDone, arg_1_0, 3)
end

function var_0_0.clearWork(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._delayDone, arg_4_0)

	if arg_4_0._flow then
		arg_4_0._flow:destroy()

		arg_4_0._flow = nil
	end
end

function var_0_0._onDone(arg_5_0)
	arg_5_0:onDone(true)
end

function var_0_0._delayDone(arg_6_0)
	arg_6_0:onDone(true)
end

return var_0_0
