module("modules.logic.login.controller.work.LogoutCleanWork", package.seeall)

slot0 = class("LogoutCleanWork", BaseWork)

function slot0.ctor(slot0)
end

function slot0.onStart(slot0, slot1)
	if not uv0._tryFuncList_ then
		uv0._tryFuncList_ = {
			function ()
				Activity114Model.instance:clearFlow()
			end,
			function ()
				GuideStepController.instance:clearStep()
			end,
			function ()
				UIBlockMgr.instance:endAll()
			end,
			function ()
				UIBlockHelper.instance:clearAll()
			end,
			function ()
				UIBlockMgrExtend.setNeedCircleMv(true)
			end,
			function ()
				StoryController.instance:closeStoryView()
			end,
			function ()
				ViewMgr.instance:closeAllViews()
			end,
			function ()
				module_views_preloader.stopPreload()
			end,
			function ()
				ModuleMgr.instance:reInit()
			end,
			function ()
				GameSceneMgr.instance:closeScene(nil, , , true)
			end,
			function ()
				SettingsVoicePackageController.instance:cancelDownload()
			end,
			function ()
				VersionActivityBaseController.instance:clear()
			end,
			function ()
				ActivityStageHelper.clear()
			end,
			function ()
				PlayerModel.instance:logout()
			end,
			function ()
				CommonDragHelper.instance:clear()
			end,
			function ()
				RougeController.instance:clearAllData()
			end
		}
	end

	for slot8, slot9 in ipairs(uv0._tryFuncList_) do
		xpcall(slot9, __G__TRACKBACK__, slot0)
	end

	TaskDispatcher.runDelay(slot0._delayDone, slot0, 0.1)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
end

function slot0._delayDone(slot0)
	GameGCMgr.instance:dispatchEvent(GameGCEvent.FullGC, slot0)
	slot0:onDone(true)
end

return slot0
