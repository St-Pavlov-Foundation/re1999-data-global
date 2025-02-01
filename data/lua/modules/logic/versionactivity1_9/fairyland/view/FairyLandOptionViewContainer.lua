module("modules.logic.versionactivity1_9.fairyland.view.FairyLandOptionViewContainer", package.seeall)

slot0 = class("FairyLandOptionViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, FairyLandOptionView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_LeftTop"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		slot0.navigateView:setOverrideClose(slot0.overrideCloseFunc, slot0)

		return {
			slot0.navigateView
		}
	end
end

function slot0.overrideCloseFunc(slot0)
	slot0:closeThis()
	ViewMgr.instance:closeView(ViewName.FairyLandView)
end

return slot0
