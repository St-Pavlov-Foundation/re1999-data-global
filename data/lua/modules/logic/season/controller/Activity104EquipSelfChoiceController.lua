module("modules.logic.season.controller.Activity104EquipSelfChoiceController", package.seeall)

local var_0_0 = class("Activity104EquipSelfChoiceController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.reInit(arg_3_0)
	return
end

function var_0_0.checkOpenParam(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = (Activity104Model.instance:getAllItemMo(arg_4_1) or {})[arg_4_2]

	if not var_4_0 then
		logNormal(string.format("ItemMO not found ! itemUid = [%s]", arg_4_2))

		return false
	elseif not SeasonConfig.instance:getEquipIsOptional(var_4_0.itemId) then
		logNormal(string.format("it't not optional card! itemUid = [%s], itemId = [%s]", arg_4_2, var_4_0.itemId))

		return false
	end

	return true
end

function var_0_0.onOpenView(arg_5_0, arg_5_1, arg_5_2)
	Activity104SelfChoiceListModel.instance:initDatas(arg_5_1, arg_5_2)
end

function var_0_0.onCloseView(arg_6_0)
	Activity104SelfChoiceListModel.instance:clear()
end

function var_0_0.changeSelectCard(arg_7_0, arg_7_1)
	Activity104SelfChoiceListModel.instance:setSelectEquip(arg_7_1)
end

function var_0_0.sendSelectCard(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = Activity104SelfChoiceListModel.instance.curSelectedItemId
	local var_8_1 = Activity104SelfChoiceListModel.instance.activityId
	local var_8_2 = Activity104SelfChoiceListModel.instance.costItemUid

	if var_8_0 ~= nil then
		Activity104Rpc.instance:sendOptionalActivity104EquipRequest(var_8_1, var_8_2, var_8_0, arg_8_1, arg_8_2)
	end
end

function var_0_0.setSelectTag(arg_9_0, arg_9_1)
	if arg_9_0:getFilterModel() then
		arg_9_0:getFilterModel():selectTagIndex(arg_9_1)
		Activity104SelfChoiceListModel.instance:initList()
	end
end

function var_0_0.getFilterModel(arg_10_0)
	return Activity104SelfChoiceListModel.instance:getTagModel()
end

var_0_0.instance = var_0_0.New()

return var_0_0
