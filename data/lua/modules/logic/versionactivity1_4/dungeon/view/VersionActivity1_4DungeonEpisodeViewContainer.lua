module("modules.logic.versionactivity1_4.dungeon.view.VersionActivity1_4DungeonEpisodeViewContainer", package.seeall)

local var_0_0 = class("VersionActivity1_4DungeonEpisodeViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, VersionActivity1_4DungeonEpisodeView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_righttop"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = {
			CurrencyEnum.CurrencyType.Power
		}

		arg_2_0.currencyView = CurrencyView.New(var_2_0)

		return {
			arg_2_0.currencyView
		}
	end
end

return var_0_0
