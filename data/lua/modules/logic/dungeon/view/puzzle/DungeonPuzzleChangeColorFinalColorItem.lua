module("modules.logic.dungeon.view.puzzle.DungeonPuzzleChangeColorFinalColorItem", package.seeall)

local var_0_0 = class("DungeonPuzzleChangeColorFinalColorItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.go = arg_1_1
	arg_1_0.id = arg_1_2
	arg_1_0._image = arg_1_1:GetComponent(gohelper.Type_Image)

	arg_1_0:setItem()
end

function var_0_0.setItem(arg_2_0)
	local var_2_0 = DungeonConfig.instance:getDecryptChangeColorColorCo(arg_2_0.id).colorvalue

	SLFramework.UGUI.GuiHelper.SetColor(arg_2_0._image, var_2_0)
end

function var_0_0.onDestroy(arg_3_0)
	gohelper.destroy(arg_3_0.go)
end

return var_0_0
