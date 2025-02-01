module("modules.logic.versionactivity1_4.puzzle.view.Role37PuzzleResultViewContainer", package.seeall)

slot0 = class("Role37PuzzleResultViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Role37PuzzleResultView.New())

	return slot1
end

function slot0.onContainerClickModalMask(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	slot0:closeThis()
end

return slot0
