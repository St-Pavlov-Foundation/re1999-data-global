module("modules.logic.explore.model.ExploreBackpackModel", package.seeall)

local var_0_0 = class("ExploreBackpackModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clearData()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clearData()
end

function var_0_0.clearData(arg_3_0)
	arg_3_0.stackableDic = {}

	arg_3_0:clear()
end

function var_0_0.refresh(arg_4_0)
	arg_4_0:clear()

	local var_4_0 = BackpackModel.instance:getBackpackList()

	BackpackModel.instance:setBackpackItemList(var_4_0)

	local var_4_1 = {}

	for iter_4_0, iter_4_1 in pairs(BackpackModel.instance:getBackpackItemList()) do
		if iter_4_1.subType == 15 then
			table.insert(var_4_1, iter_4_1)
		end
	end

	arg_4_0:setList(var_4_1)

	return var_4_1
end

function var_0_0.updateItems(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_2 or not arg_5_0.stackableDic then
		arg_5_0:clear()

		arg_5_0.stackableDic = {}
	end

	local var_5_0 = false
	local var_5_1 = arg_5_0:getList()

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		local var_5_2 = arg_5_0:getById(iter_5_1.uid)
		local var_5_3 = ExploreConfig.instance:isStackableItem(iter_5_1.itemId)

		if var_5_3 then
			var_5_2 = arg_5_0.stackableDic[iter_5_1.itemId]
		end

		if not var_5_2 then
			if iter_5_1.quantity > 0 then
				local var_5_4 = ExploreBackpackItemMO.New()

				var_5_4:init(iter_5_1)

				var_5_4.quantity = iter_5_1.quantity

				table.insert(var_5_1, var_5_4)

				arg_5_0.stackableDic[var_5_4.itemId] = var_5_4
			end
		else
			if var_5_3 then
				var_5_2:updateStackable(iter_5_1)
			else
				var_5_2.quantity = iter_5_1.quantity
				var_5_2.status = iter_5_1.status
			end

			if var_5_2.quantity == 0 then
				arg_5_0:removeItem(var_5_2)
			end

			if var_5_2.itemEffect == ExploreEnum.ItemEffect.Active then
				var_5_0 = true
			end
		end

		ExploreSimpleModel.instance:setShowBag()
	end

	local var_5_5 = ExploreController.instance:getMap()

	if var_5_0 and var_5_5 then
		var_5_5:checkAllRuneTrigger()
	end

	arg_5_0:setList(var_5_1)
	ExploreController.instance:dispatchEvent(ExploreEvent.OnItemChange, arg_5_0._mo)
end

function var_0_0.getItemMoByEffect(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:getList()

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		if iter_6_1.itemEffect == arg_6_1 then
			return iter_6_1
		end
	end
end

function var_0_0.addItem(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0:addAtLast({
		type = arg_7_1,
		id = arg_7_2,
		num = arg_7_3
	})
	ExploreController.instance:dispatchEvent(ExploreEvent.OnItemChange, arg_7_0._mo)
end

function var_0_0.removeItem(arg_8_0, arg_8_1)
	arg_8_0.stackableDic[arg_8_1.itemId] = nil

	arg_8_0:remove(arg_8_1)
	ExploreController.instance:dispatchEvent(ExploreEvent.OnItemChange, arg_8_0._mo)
end

function var_0_0.getItem(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getList()

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		if iter_9_1.itemId == arg_9_1 then
			return iter_9_1
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
