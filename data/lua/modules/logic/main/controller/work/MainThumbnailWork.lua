module("modules.logic.main.controller.work.MainThumbnailWork", package.seeall)

local var_0_0 = class("MainThumbnailWork", BaseWork)

function var_0_0._checkShow()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.MainThumbnail) then
		return false
	end

	if PlayerModel.instance:getMainThumbnail() then
		return false
	end

	if GuideModel.instance:isDoingClickGuide() and not GuideController.instance:isForbidGuides() then
		return false
	end

	return true
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	if not var_0_0._checkShow() then
		arg_2_0:onDone(true)

		return
	end

	if ViewMgr.instance:isOpenFinish(ViewName.MainView) then
		arg_2_0:_startMainThumbnailView()

		return
	end

	TaskDispatcher.cancelTask(arg_2_0._overtimeHandler, arg_2_0)
	TaskDispatcher.runDelay(arg_2_0._overtimeHandler, arg_2_0, 3)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_2_0._onOpenViewFinsh, arg_2_0)
end

function var_0_0._overtimeHandler(arg_3_0)
	arg_3_0:_startMainThumbnailView()
end

function var_0_0._onOpenViewFinsh(arg_4_0, arg_4_1)
	if arg_4_1 == ViewName.MainView then
		arg_4_0:_startMainThumbnailView()
	end
end

function var_0_0._startMainThumbnailView(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._overtimeHandler, arg_5_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_5_0._onOpenViewFinsh, arg_5_0)
	MainController.instance:dispatchEvent(MainEvent.OnShowMainThumbnailView)
	MainController.instance:registerCallback(MainEvent.OnMainThumbnailGreetingFinish, arg_5_0._onMainThumbnailGreetingFinish, arg_5_0)
	MainController.instance:openMainThumbnailView({
		needPlayGreeting = true
	})
end

function var_0_0._onMainThumbnailGreetingFinish(arg_6_0)
	arg_6_0:onDone(true)
end

function var_0_0.clearWork(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._overtimeHandler, arg_7_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_7_0._onOpenViewFinsh, arg_7_0)
	MainController.instance:unregisterCallback(MainEvent.OnMainThumbnailGreetingFinish, arg_7_0._onMainThumbnailGreetingFinish, arg_7_0)
end

return var_0_0
