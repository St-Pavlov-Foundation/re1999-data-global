module("modules.logic.versionactivity2_5.feilinshiduo.view.FeiLinShiDuoGameViewContainer", package.seeall)

slot0 = class("FeiLinShiDuoGameViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0.feiLinShiDuoSceneView = FeiLinShiDuoSceneView.New()
	slot0.feiLinShiDuoGameView = FeiLinShiDuoGameView.New()

	table.insert(slot1, slot0.feiLinShiDuoSceneView)
	table.insert(slot1, slot0.feiLinShiDuoGameView)
	table.insert(slot1, TabViewGroup.New(1, "#go_topleft"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			slot0.navigateView
		}
	end
end

function slot0.getSceneView(slot0)
	return slot0.feiLinShiDuoSceneView
end

function slot0.getGameView(slot0)
	return slot0.feiLinShiDuoGameView
end

function slot0.setOverrideCloseClick(slot0, slot1, slot2)
	slot0.navigateView:setOverrideClose(slot1, slot2)
end

return slot0
