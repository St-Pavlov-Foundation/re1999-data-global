module("modules.logic.signin.view.SignInDetailViewContainer", package.seeall)

slot0 = class("SignInDetailViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TabViewGroup.New(1, "#go_btns"))
	table.insert(slot1, SignInDetailView.New())

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot2 = NavigateButtonsView.New({
			false,
			false,
			false
		})

		slot2:setOverrideClose(slot0.overrideOnCloseClick, slot0)

		return {
			slot2
		}
	end
end

function slot0.overrideOnCloseClick(slot0)
	SignInController.instance:dispatchEvent(SignInEvent.CloseSignInDetailView)
end

return slot0
