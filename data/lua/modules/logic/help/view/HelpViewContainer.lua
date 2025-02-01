module("modules.logic.help.view.HelpViewContainer", package.seeall)

slot0 = class("HelpViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		HelpView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function slot0.buildTabViews(slot0, slot1)
	slot0._navigateButtonsView = NavigateButtonsView.New({
		false,
		false,
		false
	})

	return {
		slot0._navigateButtonsView
	}
end

function slot0.setBtnShow(slot0, slot1)
	if slot0._navigateButtonsView then
		slot0._navigateButtonsView:setParam({
			slot1,
			false,
			false
		})
	end
end

return slot0
