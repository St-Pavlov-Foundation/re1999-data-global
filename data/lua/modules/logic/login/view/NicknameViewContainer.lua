module("modules.logic.login.view.NicknameViewContainer", package.seeall)

slot0 = class("NicknameViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		NicknameView.New()
	}
end

return slot0
