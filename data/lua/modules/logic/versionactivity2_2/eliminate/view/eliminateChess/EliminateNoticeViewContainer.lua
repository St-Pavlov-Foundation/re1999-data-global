module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateNoticeViewContainer", package.seeall)

slot0 = class("EliminateNoticeViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, EliminateNoticeView.New())

	return slot1
end

return slot0
