module("modules.logic.versionactivity1_3.va3chess.view.Va3ChessGameRewardView", package.seeall)

slot0 = class("Va3ChessGameRewardView", BaseView)

function slot0.onClose(slot0)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RewardIsClose)
end

return slot0
