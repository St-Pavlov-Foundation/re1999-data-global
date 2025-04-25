module("modules.logic.versionactivity2_5.act187.view.Activity187ViewContainer", package.seeall)

slot0 = class("Activity187ViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0._act187View = Activity187View.New()
	slot0._act187PaintView = Activity187PaintingView.New()

	table.insert(slot1, slot0._act187View)
	table.insert(slot1, slot0._act187PaintView)
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

		slot0.navigateView:setOverrideClose(slot0._overrideClose, slot0)

		return {
			slot0.navigateView
		}
	end
end

function slot0._overrideClose(slot0)
	slot0._act187View:onBtnEsc()
end

function slot0.setPaintingViewDisplay(slot0, slot1)
	slot0._act187View:setPaintingViewDisplay(slot1)
end

function slot0.isShowPaintView(slot0)
	return slot0._act187View.isShowPaintView
end

return slot0
