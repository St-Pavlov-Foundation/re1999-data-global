module("modules.logic.login.view.NicknameConfirmViewContainer", package.seeall)

slot0 = class("NicknameConfirmViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		NickNameConfirmView.New()
	}
end

return slot0
