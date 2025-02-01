module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameEventResultContainer", package.seeall)

slot0 = class("AiZiLaGameEventResultContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, AiZiLaGameEventResult.New())

	return slot1
end

return slot0
