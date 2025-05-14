module("modules.logic.dungeon.controller.DungeonPuzzleChangeColorController", package.seeall)

local var_0_0 = class("DungeonPuzzleChangeColorController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.enterDecryptChangeColor(arg_3_0, arg_3_1)
	ViewMgr.instance:openView(ViewName.DungeonPuzzleChangeColorView, arg_3_1)
end

function var_0_0.openDecryptTipView(arg_4_0, arg_4_1)
	ViewMgr.instance:openView(ViewName.DecryptPropTipView, arg_4_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
