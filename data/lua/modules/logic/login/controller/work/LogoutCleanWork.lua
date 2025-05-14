module("modules.logic.login.controller.work.LogoutCleanWork", package.seeall)

local var_0_0 = class("LogoutCleanWork", BaseWork)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	if not var_0_0._tryFuncList_ then
		var_0_0._tryFuncList_ = {
			function()
				Activity114Model.instance:clearFlow()
			end,
			function()
				GuideStepController.instance:clearStep()
			end,
			function()
				UIBlockMgr.instance:endAll()
			end,
			function()
				UIBlockHelper.instance:clearAll()
			end,
			function()
				UIBlockMgrExtend.setNeedCircleMv(true)
			end,
			function()
				StoryController.instance:closeStoryView()
			end,
			function()
				ViewMgr.instance:closeAllViews()
			end,
			function()
				module_views_preloader.stopPreload()
			end,
			function()
				ModuleMgr.instance:reInit()
			end,
			function()
				GameSceneMgr.instance:closeScene(nil, nil, nil, true)
			end,
			function()
				SettingsVoicePackageController.instance:cancelDownload()
			end,
			function()
				VersionActivityBaseController.instance:clear()
			end,
			function()
				ActivityStageHelper.clear()
			end,
			function()
				PlayerModel.instance:logout()
			end,
			function()
				CommonDragHelper.instance:clear()
			end,
			function()
				RougeController.instance:clearAllData()
			end
		}
	end

	local var_2_0 = var_0_0._tryFuncList_
	local var_2_1 = xpcall
	local var_2_2 = __G__TRACKBACK__

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		var_2_1(iter_2_1, var_2_2, arg_2_0)
	end

	TaskDispatcher.runDelay(arg_2_0._delayDone, arg_2_0, 0.1)
end

function var_0_0.clearWork(arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._delayDone, arg_19_0)
end

function var_0_0._delayDone(arg_20_0)
	GameGCMgr.instance:dispatchEvent(GameGCEvent.FullGC, arg_20_0)
	arg_20_0:onDone(true)
end

return var_0_0
