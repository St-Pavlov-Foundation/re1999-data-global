module("modules.logic.fight.view.FightCardMixIntroduceViewContainer", package.seeall)

slot0 = class("FightCardMixIntroduceViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		FightCardMixIntroduceView.New()
	}
end

return slot0
