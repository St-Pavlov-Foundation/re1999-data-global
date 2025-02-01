module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameResultViewContainer", package.seeall)

slot0 = class("AiZiLaGameResultViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0._resultView = AiZiLaGameResultView.New()

	table.insert(slot1, slot0._resultView)

	return slot1
end

return slot0
