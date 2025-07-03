module("modules.logic.versionactivity2_7.act191.model.Act191CollectionEditListModel", package.seeall)

local var_0_0 = class("Act191CollectionEditListModel", ListScrollModel)

function var_0_0.initData(arg_1_0, arg_1_1)
	arg_1_0.specialItem = arg_1_1

	local var_1_0 = {}
	local var_1_1 = Activity191Model.instance:getActInfo():getGameInfo()

	for iter_1_0, iter_1_1 in ipairs(var_1_1.warehouseInfo.item) do
		local var_1_2 = {
			uid = iter_1_1.uid,
			itemId = iter_1_1.itemId
		}
		local var_1_3, var_1_4 = var_1_1:isItemInTeam(var_1_2.uid)

		if var_1_3 then
			var_1_2.inTeam = var_1_2.uid == arg_1_0.specialItem and 2 or 1

			if var_1_4 and var_1_4 ~= 0 then
				var_1_2.heroId = var_1_4
			end
		else
			var_1_2.inTeam = 0
		end

		var_1_0[#var_1_0 + 1] = var_1_2
	end

	table.sort(var_1_0, function(arg_2_0, arg_2_1)
		return arg_2_0.inTeam > arg_2_1.inTeam
	end)
	arg_1_0:setList(var_1_0)

	if arg_1_0.specialItem and arg_1_0.specialItem ~= 0 then
		arg_1_0:selectItem(arg_1_0.specialItem, true)
	else
		Activity191Controller.instance:dispatchEvent(Activity191Event.OnClickCollectionGroupItem)
	end
end

function var_0_0.selectItem(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0:getList()

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		if iter_3_1.uid == arg_3_1 then
			arg_3_0:selectCell(iter_3_0, arg_3_2)

			break
		end
	end

	if not arg_3_2 then
		Activity191Controller.instance:dispatchEvent(Activity191Event.OnClickCollectionGroupItem)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
