module("modules.logic.versionactivity2_2.lopera.view.LoperaGameResultViewContainer", package.seeall)

slot0 = class("LoperaGameResultViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0._resultView = LoperaGameResultView.New()

	table.insert(slot1, slot0._resultView)

	return slot1
end

return slot0
