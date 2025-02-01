module("modules.logic.login.controller.work.LoginPreLoadWork", package.seeall)

slot0 = class("LoginPreLoadWork", BaseWork)
slot1 = {
	"ui/viewres/scene/loadingview.prefab",
	"ui/viewres/scene/loadingblackview.prefab",
	"ui/viewres/scene/loadingheadsetview.prefab"
}

function slot0.onStart(slot0, slot1)
	if not slot0._loader then
		UIBlockMgr.instance:startBlock(UIBlockKey.Loading)

		slot0._loader = MultiAbLoader.New()

		slot0._loader:setPathList(uv0)
		slot0._loader:startLoad(slot0._onLoaded, slot0)
	else
		slot0:_done()
	end
end

function slot0._onLoaded(slot0)
	UIBlockMgr.instance:endBlock(UIBlockKey.Loading)
	slot0:_done()
end

function slot0._isFirstGuide(slot0)
	return not (GuideModel.instance:isGuideFinish(101) or GuideController.instance:isForbidGuides())
end

function slot0._done(slot0)
	gohelper.setActive(gohelper.find("UIRoot/OriginBg"), false)
	ViewMgr.instance:closeView(ViewName.LoginView)

	if slot0:_isFirstGuide() then
		GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.LoadingHeadsetView)
	end

	GameSceneMgr.instance:dispatchEvent(SceneEventName.OpenLoading, SceneType.Main)
	slot0:onDone(true)
end

return slot0
