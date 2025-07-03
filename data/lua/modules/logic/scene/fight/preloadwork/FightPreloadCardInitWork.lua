module("modules.logic.scene.fight.preloadwork.FightPreloadCardInitWork", package.seeall)

local var_0_0 = class("FightPreloadCardInitWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	if ViewMgr.instance:isOpenFinish(ViewName.FightView) then
		arg_1_0:_updateCards()
	else
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_1_0._onOpenViewFinish, arg_1_0)
	end
end

function var_0_0._onOpenViewFinish(arg_2_0, arg_2_1)
	if arg_2_1 == ViewName.FightView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_2_0._onOpenViewFinish, arg_2_0)
		arg_2_0:_updateCards()
	end
end

function var_0_0._updateCards(arg_3_0)
	local var_3_0 = FightDataHelper.handCardMgr.handCard

	FightController.instance:dispatchEvent(FightEvent.UpdateHandCards, var_3_0)

	local var_3_1 = ViewMgr.instance:getContainer(ViewName.FightView)
	local var_3_2 = gohelper.findChild(var_3_1.viewGO, "root/handcards/handcards")

	gohelper.setActive(var_3_2, true)

	local var_3_3 = gohelper.onceAddComponent(var_3_2, gohelper.Type_CanvasGroup)

	if var_3_3 then
		var_3_3.alpha = 0
	end

	TaskDispatcher.runDelay(arg_3_0._delayDone, arg_3_0, 0.01)
end

function var_0_0._delayDone(arg_4_0)
	arg_4_0:onDone(true)
end

function var_0_0.clearWork(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._delayDone, arg_5_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_5_0._onOpenViewFinish, arg_5_0)
end

return var_0_0
