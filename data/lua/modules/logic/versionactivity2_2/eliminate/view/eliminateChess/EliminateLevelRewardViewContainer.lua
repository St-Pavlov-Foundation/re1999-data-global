module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateLevelRewardViewContainer", package.seeall)

slot0 = class("EliminateLevelRewardViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, EliminateLevelRewardView.New())

	return slot1
end

return slot0
