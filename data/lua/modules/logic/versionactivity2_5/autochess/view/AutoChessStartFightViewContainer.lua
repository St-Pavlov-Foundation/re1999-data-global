module("modules.logic.versionactivity2_5.autochess.view.AutoChessStartFightViewContainer", package.seeall)

slot0 = class("AutoChessStartFightViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, AutoChessStartFightView.New())

	return slot1
end

return slot0
