module("modules.logic.toughbattle.view.ToughBattleMapViewContainer", package.seeall)

slot0 = class("ToughBattleMapViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0._mapScene = ToughBattleMapScene.New()

	return {
		slot0._mapScene,
		ToughBattleMapView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function slot0.buildTabViews(slot0, slot1)
	slot0.navigateView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		slot0.navigateView
	}
end

function slot0.setVisibleInternal(slot0, slot1)
	uv0.super.setVisibleInternal(slot0, slot1)

	if slot0._mapScene then
		slot0._mapScene:setSceneVisible(slot1)
	end
end

function slot0.playCloseTransition(slot0)
	slot0:_cancelBlock()
	slot0:_stopOpenCloseAnim()
	slot0:startViewCloseBlock()

	if not gohelper.isNil(slot0:__getAnimatorPlayer()) then
		slot1:Play("close", slot0.onPlayCloseTransitionFinish, slot0)
	end

	TaskDispatcher.runDelay(slot0.onPlayCloseTransitionFinish, slot0, 2)
end

return slot0
