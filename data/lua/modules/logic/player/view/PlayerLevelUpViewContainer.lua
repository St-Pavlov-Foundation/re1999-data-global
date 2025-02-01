module("modules.logic.player.view.PlayerLevelUpViewContainer", package.seeall)

slot0 = class("PlayerLevelUpViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		PlayerLevelUpView.New()
	}
end

return slot0
