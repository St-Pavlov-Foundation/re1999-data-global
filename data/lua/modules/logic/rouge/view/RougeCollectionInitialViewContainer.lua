module("modules.logic.rouge.view.RougeCollectionInitialViewContainer", package.seeall)

slot0 = class("RougeCollectionInitialViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0._collectionInitialView = RougeCollectionInitialView.New()

	return {
		TabViewGroup.New(1, "#go_topleft"),
		TabViewGroup.New(2, "#go_rougemapdetailcontainer"),
		slot0._collectionInitialView
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			slot0._navigateButtonView
		}
	elseif slot1 == 2 then
		return {
			RougeCollectionDetailBtnComp.New()
		}
	end
end

function slot0.setActiveBlock(slot0, slot1)
	slot0._collectionInitialView:setActiveBlock(slot1)
end

function slot0.getScrollViewGo(slot0)
	return slot0._collectionInitialView:getScrollViewGo()
end

return slot0
