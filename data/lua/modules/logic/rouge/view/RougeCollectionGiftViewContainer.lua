module("modules.logic.rouge.view.RougeCollectionGiftViewContainer", package.seeall)

slot0 = class("RougeCollectionGiftViewContainer", BaseViewContainer)
slot1 = 1

function slot0.buildViews(slot0)
	slot0._collectionGiftView = RougeCollectionGiftView.New()

	return {
		slot0._collectionGiftView,
		TabViewGroup.New(uv0, "#go_topleft")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == uv0 then
		return {
			NavigateButtonsView.New({
				true,
				false,
				false
			})
		}
	end
end

function slot0.getScrollRect(slot0)
	return slot0._collectionGiftView:getScrollRect()
end

function slot0.getScrollViewGo(slot0)
	return slot0._collectionGiftView:getScrollViewGo()
end

function slot0.setActiveBlock(slot0, slot1)
	slot0._collectionInitialView:setActiveBlock(slot1)
end

return slot0
