module("modules.logic.main.view.MainViewContainer", package.seeall)

slot0 = class("MainViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0._mainHeroNoInteractive = MainHeroNoInteractive.New()
	slot0._mainHeroView = MainHeroView.New()
	slot0._mainActivityEnterView = MainActivityEnterView.New()

	return {
		MainView.New(),
		slot0._mainHeroNoInteractive,
		slot0._mainHeroView,
		MainHeroMipView.New(),
		slot0._mainActivityEnterView,
		MainActExtraDisplay.New(),
		TabViewGroup.New(1, "#go_righttop"),
		MainViewCamera.New(),
		MainActivityCenterView.New(),
		MainNoticeRequestView.New()
	}
end

function slot0.getNoInteractiveComp(slot0)
	return slot0._mainHeroNoInteractive
end

function slot0.getMainHeroView(slot0)
	return slot0._mainHeroView
end

function slot0.getMainActivityEnterView(slot0)
	return slot0._mainActivityEnterView
end

function slot0.buildTabViews(slot0, slot1)
	slot2 = CurrencyEnum.CurrencyType

	return {
		CurrencyView.New({
			slot2.Diamond,
			slot2.FreeDiamondCoupon,
			slot2.Gold
		})
	}
end

function slot0.onContainerOpenFinish(slot0)
	slot0:forceRefreshMainSceneYearAnimation()
end

function slot0.forceRefreshMainSceneYearAnimation(slot0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Main then
		GameSceneMgr.instance:getCurScene().yearAnimation:forcePlayAni()
	end
end

function slot0._checkSceneVisible(slot0, slot1)
	if ViewMgr.instance:isOpen(ViewName.SummonView) then
		TaskDispatcher.cancelTask(slot0._checkSceneVisible, slot0)

		return
	end

	if GameSceneMgr.instance:getCurScene() and slot2:getSceneContainerGO() and not slot3.activeSelf then
		TaskDispatcher.cancelTask(slot0._checkSceneVisible, slot0)

		slot4 = nil

		if slot0._isVisible then
			slot5 = GameGlobalMgr.instance:getFullViewState()

			slot5:forceSceneCameraActive(true)
			logError(string.format("MainViewContainer _checkSceneVisible isVisible:%s,viewName:%s,names:%s", slot0._isVisible, slot1, slot5:getOpenFullViewNames()))
		end
	end
end

function slot0._onCloseFullView(slot0, slot1)
	if slot0._isVisible then
		TaskDispatcher.cancelTask(slot0._checkSceneVisible, slot0)
		TaskDispatcher.runRepeat(slot0._checkSceneVisible, slot0, 0, 3)
		slot0:_checkSceneVisible(slot1)
	end
end

function slot0.onContainerOpen(slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseFullView, slot0._onCloseFullView, slot0, LuaEventSystem.Low)
end

function slot0.onContainerClose(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseFullView, slot0._onCloseFullView, slot0)
	TaskDispatcher.cancelTask(slot0._checkSceneVisible, slot0)
end

return slot0
