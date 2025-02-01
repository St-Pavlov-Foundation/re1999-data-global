module("modules.logic.rouge.map.view.fightsucc.RougeFightSuccessViewContainer", package.seeall)

slot0 = class("RougeFightSuccessViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RougeFightSuccessView.New())

	return slot1
end

return slot0
