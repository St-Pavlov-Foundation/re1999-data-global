module("modules.logic.rouge.view.RougeCollectionTipViewContainer", package.seeall)

slot0 = class("RougeCollectionTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		RougeCollectionTipView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
end

return slot0
