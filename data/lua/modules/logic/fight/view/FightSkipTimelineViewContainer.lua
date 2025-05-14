module("modules.logic.fight.view.FightSkipTimelineViewContainer", package.seeall)

local var_0_0 = class("FightSkipTimelineViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		FightSkipTimelineView.New()
	}
end

return var_0_0
