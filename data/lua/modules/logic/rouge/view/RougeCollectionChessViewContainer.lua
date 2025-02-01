module("modules.logic.rouge.view.RougeCollectionChessViewContainer", package.seeall)

slot0 = class("RougeCollectionChessViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0._poolComp = RougeCollectionChessPoolComp.New()

	return {
		TabViewGroup.New(1, "#go_left/#go_btns"),
		TabViewGroup.New(2, "#go_rougemapdetailcontainer"),
		slot0._poolComp,
		RougeCollectionEffectActiveComp.New(),
		RougeCollectionEffectTriggerComp.New(),
		RougeCollectionChessView.New(),
		RougeCollectionChessSlotComp.New(),
		RougeCollectionChessBagComp.New(),
		RougeCollectionChessInteractComp.New(),
		RougeCollectionChessPlaceComp.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			true
		})

		slot0._navigateButtonView:setHelpId(HelpEnum.HelpId.RougeCollectionChessViewHelp)

		return {
			slot0._navigateButtonView
		}
	elseif slot1 == 2 then
		return {
			RougeCollectionDetailBtnComp.New()
		}
	end
end

function slot0.getRougePoolComp(slot0)
	return slot0._poolComp
end

return slot0
