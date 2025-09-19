module("modules.logic.survival.view.map.SurvivalLoadingView", package.seeall)

local var_0_0 = class("SurvivalLoadingView", BaseView)

function var_0_0.onOpen(arg_1_0)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_loading)
	TaskDispatcher.runDelay(arg_1_0.checkViewIsOpenFinish, arg_1_0, 2)
end

function var_0_0._onOpenView(arg_2_0, arg_2_1)
	if arg_2_1 == ViewName.SurvivalMapMainView or arg_2_1 == ViewName.SurvivalMainView or arg_2_1 == ViewName.SurvivalMapResultPanelView or arg_2_1 == arg_2_1 == ViewName.SurvivalMapResultView then
		TaskDispatcher.runDelay(arg_2_0.closeThis, arg_2_0, 0.2)
	end
end

function var_0_0.checkViewIsOpenFinish(arg_3_0)
	if ViewMgr.instance:isOpenFinish(ViewName.SurvivalMapMainView) or ViewMgr.instance:isOpenFinish(ViewName.SurvivalMainView) or ViewMgr.instance:isOpenFinish(ViewName.SurvivalMapResultPanelView) or ViewMgr.instance:isOpenFinish(ViewName.SurvivalMapResultView) then
		arg_3_0:closeThis()
	else
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_3_0._onOpenView, arg_3_0)
	end
end

function var_0_0.onClose(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.stop_ui_fuleyuan_tansuo_loading)
	TaskDispatcher.cancelTask(arg_4_0.checkViewIsOpenFinish, arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0.closeThis, arg_4_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_4_0._onOpenView, arg_4_0)
end

return var_0_0
