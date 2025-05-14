module("modules.logic.versionactivity1_3.va3chess.view.Va3ChessGameRewardView", package.seeall)

local var_0_0 = class("Va3ChessGameRewardView", BaseView)

function var_0_0.onClose(arg_1_0)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RewardIsClose)
end

return var_0_0
