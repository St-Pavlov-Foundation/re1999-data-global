module("modules.logic.sp01.assassin2.story.dungeon.VersionActivity2_9FightSuccViewContainer", package.seeall)

local var_0_0 = class("VersionActivity2_9FightSuccViewContainer", FightSuccViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0.fightSuccActView = FightSuccActView.New()

	local var_1_0 = {
		VersionActivity2_9FightSuccView.New(),
		arg_1_0.fightSuccActView
	}

	if isDebugBuild and GMBattleModel.instance.enableGMFightRecord then
		table.insert(var_1_0, FightGMRecordView.New())
	end

	return var_1_0
end

return var_0_0
