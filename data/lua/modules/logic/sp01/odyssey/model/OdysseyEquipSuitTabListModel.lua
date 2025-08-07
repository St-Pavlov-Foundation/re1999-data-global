module("modules.logic.sp01.odyssey.model.OdysseyEquipSuitTabListModel", package.seeall)

local var_0_0 = class("OdysseyEquipSuitTabListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.initList(arg_3_0)
	local var_3_0 = OdysseyConfig.instance:getEquipSuitConfigList()
	local var_3_1 = {}
	local var_3_2 = OdysseyEquipSuitMo.New()

	var_3_2:init(nil, nil, OdysseyEnum.EquipSuitType.All)
	table.insert(var_3_1, var_3_2)

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		if OdysseyItemModel.instance:haveSuitItem(iter_3_1.id) then
			local var_3_3 = OdysseyEquipSuitMo.New()

			var_3_3:init(iter_3_1.id, iter_3_1, OdysseyEnum.EquipSuitType.SingleType)
			table.insert(var_3_1, var_3_3)
		end
	end

	arg_3_0:setList(var_3_1)
end

function var_0_0.clearSelect(arg_4_0)
	local var_4_0 = arg_4_0:getSelect()
	local var_4_1 = arg_4_0._scrollViews[1]

	if var_4_0 then
		var_4_1:selectCell(var_4_0.id, false)
	end
end

function var_0_0.getSelect(arg_5_0)
	local var_5_0 = arg_5_0._scrollViews[1]

	if var_5_0 then
		return (var_5_0:getFirstSelect())
	end
end

function var_0_0.selectAllTag(arg_6_0, arg_6_1)
	arg_6_0:clearSelect()

	local var_6_0 = arg_6_0._scrollViews[1]

	if var_6_0 then
		var_6_0:selectCell(1, true)

		if arg_6_1 then
			local var_6_1 = arg_6_0:getByIndex(1)

			OdysseyController.instance:dispatchEvent(OdysseyEvent.OnEquipSuitSelect, var_6_1)
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
