module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameOpenEffectViewContainer", package.seeall)

slot0 = class("AiZiLaGameOpenEffectViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0._gameEffectView = AiZiLaGameOpenEffectView.New()

	table.insert(slot1, slot0._gameEffectView)

	return slot1
end

function slot0.playViewAnimator(slot0, slot1)
	slot0._gameEffectView:playViewAnimator(slot1)
end

function slot0.startViewOpenBlock(slot0)
end

function slot0.startViewCloseBlock(slot0)
end

return slot0
