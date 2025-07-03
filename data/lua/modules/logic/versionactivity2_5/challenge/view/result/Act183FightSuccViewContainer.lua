module("modules.logic.versionactivity2_5.challenge.view.result.Act183FightSuccViewContainer", package.seeall)

local var_0_0 = class("Act183FightSuccViewContainer", FightSuccViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0.fightSuccActView = FightSuccActView.New()

	local var_1_0 = {
		Act183FightSuccView.New(),
		arg_1_0.fightSuccActView
	}

	if isDebugBuild and GMBattleModel.instance.enableGMFightRecord then
		table.insert(var_1_0, FightGMRecordView.New())
	end

	return var_1_0
end

return var_0_0
