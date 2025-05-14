module("modules.logic.versionactivity1_8.dungeon.view.factory.repairgame.VersionActivity1_8FactoryRepairViewContainer", package.seeall)

local var_0_0 = class("VersionActivity1_8FactoryRepairViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = VersionActivity1_8FactoryRepairView.New()

	arg_1_0._gameMap = VersionActivity1_8FactoryRepairGameMap.New()

	local var_1_1 = VersionActivity1_8FactoryRepairPieceView.New()

	return {
		var_1_0,
		arg_1_0._gameMap,
		var_1_1,
		TabViewGroup.New(1, "#go_BackBtns")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	local var_2_0 = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		var_2_0
	}
end

function var_0_0.getPipes(arg_3_0)
	return arg_3_0._gameMap
end

function var_0_0.getPipesXYByPosition(arg_4_0, arg_4_1)
	return arg_4_0._gameMap:getXYByPosition(arg_4_1)
end

function var_0_0.onContainerInit(arg_5_0)
	VersionActivity1_8StatController.instance:startStat()
end

function var_0_0.onContainerClose(arg_6_0)
	VersionActivity1_8StatController.instance:statAbort()
end

return var_0_0
