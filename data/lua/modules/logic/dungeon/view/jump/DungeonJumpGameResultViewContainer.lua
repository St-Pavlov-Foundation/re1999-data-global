module("modules.logic.dungeon.view.jump.DungeonJumpGameResultViewContainer", package.seeall)

local var_0_0 = class("DungeonJumpGameResultViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		DungeonJumpGameResultView.New()
	}
end

return var_0_0
