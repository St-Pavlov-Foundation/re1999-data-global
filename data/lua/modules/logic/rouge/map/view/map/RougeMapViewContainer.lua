module("modules.logic.rouge.map.view.map.RougeMapViewContainer", package.seeall)

slot0 = class("RougeMapViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RougeMapView.New())
	table.insert(slot1, RougeMapDragView.New())
	table.insert(slot1, RougeMapInputView.New())
	table.insert(slot1, RougeMapCoinView.New())
	table.insert(slot1, RougeMapNodeRightView.New())
	table.insert(slot1, RougeMapLayerRightView.New())
	table.insert(slot1, RougeMapLayerLineView.New())
	table.insert(slot1, RougeMapEntrustView.New())
	table.insert(slot1, RougeMapEliteFightView.New())
	table.insert(slot1, RougeMapVoiceView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_LeftTop"))
	table.insert(slot1, RougeBaseDLCViewComp.New())

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	slot0.navigateView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	slot0.navigateView:setHelpId(HelpEnum.HelpId.RougeMapViewHelp)
	slot0.navigateView:setOverrideClose(slot0._overrideClose, slot0)

	return {
		slot0.navigateView
	}
end

function slot0._overrideClose(slot0)
	RougeMapHelper.backToMainScene()
	RougeStatController.instance:statEnd(RougeStatController.EndResult.Close)
end

return slot0
