module("modules.logic.dungeon.controller.DungeonPuzzleCircuitController", package.seeall)

local var_0_0 = class("DungeonPuzzleCircuitController", BaseController)

function var_0_0.onInitFinish(arg_1_0)
	return
end

function var_0_0.addConstEvents(arg_2_0)
	return
end

function var_0_0.reInit(arg_3_0)
	return
end

function var_0_0.openGame(arg_4_0, arg_4_1)
	DungeonPuzzleCircuitModel.instance:initByElementCo(arg_4_1)
	ViewMgr.instance:openView(ViewName.DungeonPuzzleCircuitView)
end

var_0_0.instance = var_0_0.New()

return var_0_0
