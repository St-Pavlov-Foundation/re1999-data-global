module("modules.logic.versionactivity2_5.challenge.view.result.Act183SettlementBossEpisodeHeroComp", package.seeall)

local var_0_0 = class("Act183SettlementBossEpisodeHeroComp", Act183SettlementSubEpisodeHeroComp)

var_0_0.TeamLeaderPosition = {
	1,
	1,
	1,
	1,
	1
}

local var_0_1 = 1

function var_0_0.refreshHeroPosition(arg_1_0, arg_1_1, arg_1_2)
	transformhelper.setLocalScale(arg_1_1.transform, var_0_1, var_0_1, var_0_1)
end

return var_0_0
