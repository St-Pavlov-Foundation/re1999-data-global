module("modules.logic.login.controller.work.LogoutCleanWork", package.seeall)

slot0 = class("LogoutCleanWork", BaseWork)

function slot0.ctor(slot0)
end

function slot0.onStart(slot0, slot1)
	Activity114Model.instance:clearFlow()
	GuideStepController.instance:clearStep()
	UIBlockMgr.instance:endAll()
	UIBlockHelper.instance:clearAll()
	UIBlockMgrExtend.setNeedCircleMv(true)
	StoryController.instance:closeStoryView()
	ViewMgr.instance:closeAllViews()
	module_views_preloader.stopPreload()
	ModuleMgr.instance:reInit()
	GameSceneMgr.instance:closeScene(nil, , , true)
	SettingsVoicePackageController.instance:cancelDownload()
	VersionActivityBaseController.instance:clear()
	ActivityStageHelper.clear()
	PlayerModel.instance:logout()
	CommonDragHelper.instance:clear()
	TaskDispatcher.runDelay(slot0._delayDone, slot0, 0.1)
	RougeController.instance:clearAllData()
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
end

function slot0._delayDone(slot0)
	GameGCMgr.instance:dispatchEvent(GameGCEvent.FullGC, slot0)
	slot0:onDone(true)
end

return slot0
