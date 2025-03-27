module("modules.logic.versionactivity2_4.pinball.view.PinballCityViewContainer", package.seeall)

slot0 = class("PinballCityViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0._mapViewScene = PinballCitySceneView.New()

	return {
		slot0._mapViewScene,
		PinballCityView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end
end

function slot0.setVisibleInternal(slot0, slot1)
	if slot0._mapViewScene then
		slot0._mapViewScene:setSceneVisible(slot1)
	end

	uv0.super.setVisibleInternal(slot0, slot1)
end

return slot0
