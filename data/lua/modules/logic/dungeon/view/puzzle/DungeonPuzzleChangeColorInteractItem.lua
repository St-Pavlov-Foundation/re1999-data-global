module("modules.logic.dungeon.view.puzzle.DungeonPuzzleChangeColorInteractItem", package.seeall)

local var_0_0 = class("DungeonPuzzleChangeColorInteractItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.go = arg_1_1
	arg_1_0.id = arg_1_2
	arg_1_0._click = gohelper.getClickWithAudio(arg_1_0.go)

	arg_1_0._click:AddClickListener(arg_1_0._onItemClick, arg_1_0)

	arg_1_0._txtDesc = gohelper.findChildText(arg_1_0.go, "desc")

	arg_1_0:setItem()
end

function var_0_0.setItem(arg_2_0)
	local var_2_0 = DungeonConfig.instance:getDecryptChangeColorInteractCo(arg_2_0.id)

	arg_2_0._txtDesc.text = var_2_0.desc
end

function var_0_0._onItemClick(arg_3_0)
	DungeonPuzzleChangeColorController.instance:dispatchEvent(DungeonPuzzleEvent.InteractClick, arg_3_0.id)
end

function var_0_0.onDestroy(arg_4_0)
	arg_4_0._click:RemoveClickListener()
	gohelper.destroy(arg_4_0.go)
end

return var_0_0
