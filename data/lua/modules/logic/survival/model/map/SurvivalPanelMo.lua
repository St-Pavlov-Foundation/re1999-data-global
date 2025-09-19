module("modules.logic.survival.model.map.SurvivalPanelMo", package.seeall)

local var_0_0 = pureTable("SurvivalPanelMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.uid = arg_1_1.uid
	arg_1_0.type = arg_1_1.type
	arg_1_0.unitId = arg_1_1.unitId
	arg_1_0.treeId = arg_1_1.treeId
	arg_1_0.dialogueId = arg_1_1.dialogueId
	arg_1_0.param = arg_1_1.param
	arg_1_0.status = arg_1_1.status
	arg_1_0.canSelectNum = arg_1_1.canSelectNum
	arg_1_0.items = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.items) do
		local var_1_0 = SurvivalBagItemMo.New()

		var_1_0:init(iter_1_1)

		if arg_1_0.type == SurvivalEnum.PanelType.Search then
			var_1_0.source = SurvivalEnum.ItemSource.Search
			arg_1_0.items[var_1_0.uid] = var_1_0
		elseif arg_1_0.type == SurvivalEnum.PanelType.DropSelect then
			var_1_0.source = SurvivalEnum.ItemSource.Drop
			arg_1_0.items[iter_1_0] = var_1_0
		else
			arg_1_0.items[iter_1_0] = var_1_0
		end
	end

	arg_1_0.shop = SurvivalShopMo.New()

	arg_1_0.shop:init(arg_1_1.shop)
end

function var_0_0.getSearchItems(arg_2_0)
	return arg_2_0.items
end

return var_0_0
