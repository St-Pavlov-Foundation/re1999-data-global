module("modules.logic.versionactivity1_3.chess.view.game.Activity1_3ChessResultContainer", package.seeall)

slot0 = class("Activity1_3ChessResultContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0._resultview = Activity1_3ChessResultView.New()
	slot1[#slot1 + 1] = slot0._resultview

	return slot1
end

function slot0.onContainerClickModalMask(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	slot0:closeThis()
end

return slot0
