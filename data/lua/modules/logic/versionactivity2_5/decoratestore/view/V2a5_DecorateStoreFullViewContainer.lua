module("modules.logic.versionactivity2_5.decoratestore.view.V2a5_DecorateStoreFullViewContainer", package.seeall)

slot0 = class("V2a5_DecorateStoreFullViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, V2a5_DecorateStoreView.New())

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

return slot0
