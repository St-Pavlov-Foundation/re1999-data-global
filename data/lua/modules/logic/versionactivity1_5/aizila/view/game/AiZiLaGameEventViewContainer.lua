module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameEventViewContainer", package.seeall)

slot0 = class("AiZiLaGameEventViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0._gameEventview = AiZiLaGameEventView.New()

	table.insert(slot1, slot0._gameEventview)

	return slot1
end

function slot0.playViewAnimator(slot0, slot1)
	slot0._gameEventview:playViewAnimator(slot1)
end

return slot0
