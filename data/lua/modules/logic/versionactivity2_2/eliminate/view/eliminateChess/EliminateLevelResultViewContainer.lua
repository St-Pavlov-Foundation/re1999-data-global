module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateLevelResultViewContainer", package.seeall)

slot0 = class("EliminateLevelResultViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, EliminateLevelResultView.New())

	return slot1
end

return slot0
