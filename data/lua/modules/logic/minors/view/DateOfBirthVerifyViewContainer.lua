module("modules.logic.minors.view.DateOfBirthVerifyViewContainer", package.seeall)

slot0 = class("DateOfBirthVerifyViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		DateOfBirthVerifyView.New()
	}
end

return slot0
