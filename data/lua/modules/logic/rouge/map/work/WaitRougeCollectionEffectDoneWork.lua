module("modules.logic.rouge.map.work.WaitRougeCollectionEffectDoneWork", package.seeall)

local var_0_0 = class("WaitRougeCollectionEffectDoneWork", BaseWork)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onStart(arg_2_0)
	if not RougeCollectionModel.instance:checkHasTmpTriggerEffectInfo() then
		return arg_2_0:onDone(true)
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_2_0._onCloseViewFinish, arg_2_0)
	RougePopController.instance:addPopViewWithViewName(ViewName.RougeCollectionChessView)
end

function var_0_0._onCloseViewFinish(arg_3_0, arg_3_1)
	if arg_3_1 == ViewName.RougeCollectionChessView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_3_0._onCloseViewFinish, arg_3_0)
		arg_3_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_4_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_4_0._onCloseViewFinish, arg_4_0)
end

return var_0_0
