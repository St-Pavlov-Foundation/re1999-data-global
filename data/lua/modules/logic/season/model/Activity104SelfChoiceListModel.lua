module("modules.logic.season.model.Activity104SelfChoiceListModel", package.seeall)

local var_0_0 = class("Activity104SelfChoiceListModel", ListScrollModel)

function var_0_0.clear(arg_1_0)
	var_0_0.super.clear(arg_1_0)

	arg_1_0.activityId = nil
	arg_1_0.costItemUid = nil
	arg_1_0.curSelectedItemId = nil
	arg_1_0.targetRare = nil
	arg_1_0.tagModel = nil
end

function var_0_0.initDatas(arg_2_0, arg_2_1, arg_2_2)
	logNormal("Activity104SelfChoiceListModel initDatas")
	arg_2_0:clear()

	arg_2_0.activityId = arg_2_1
	arg_2_0.costItemUid = arg_2_2
	arg_2_0.curSelectedItemId = nil

	local var_2_0 = Activity104Model.instance:getAllItemMo(arg_2_0.activityId)
	local var_2_1 = SeasonConfig.instance:getSeasonEquipCo(var_2_0[arg_2_0.costItemUid].itemId)

	arg_2_0.itemId = var_2_1.equipId
	arg_2_0.targetRare = var_2_1.rare

	arg_2_0:initList()
end

function var_0_0.initList(arg_3_0)
	arg_3_0.curSelectedItemId = nil

	local var_3_0 = SeasonConfig.instance:getEquipCoByCondition(var_0_0.filterSameRare)
	local var_3_1 = {}

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		local var_3_2 = Activity104SelfChoiceMo.New()

		var_3_2:init(iter_3_1)
		table.insert(var_3_1, var_3_2)

		if not arg_3_0.curSelectedItemId then
			arg_3_0.curSelectedItemId = iter_3_1.equipId
		end
	end

	arg_3_0:setList(var_3_1)
	Activity104Controller.instance:dispatchEvent(Activity104Event.SelectSelfChoiceCard, arg_3_0.curSelectedItemId)
end

function var_0_0.filterSameRare(arg_4_0)
	if arg_4_0.rare == var_0_0.instance.targetRare and not SeasonConfig.instance:getEquipIsOptional(arg_4_0.equipId) and not SeasonEquipMetaUtils.isBanActivity(arg_4_0, var_0_0.instance.activityId) and var_0_0.instance:isCardCanShowByTag(arg_4_0.tag) then
		return true
	end

	return false
end

function var_0_0.setSelectEquip(arg_5_0, arg_5_1)
	arg_5_0.curSelectedItemId = arg_5_1

	Activity104Controller.instance:dispatchEvent(Activity104Event.SelectSelfChoiceCard, arg_5_1)
	arg_5_0:onModelUpdate()
end

function var_0_0.initSubModel(arg_6_0)
	arg_6_0.tagModel = Activity104EquipTagModel.New()

	arg_6_0.tagModel:init(arg_6_0.activityId)
end

function var_0_0.isCardCanShowByTag(arg_7_0, arg_7_1)
	return arg_7_0:getTagModel():isCardNeedShow(arg_7_1)
end

function var_0_0.getTagModel(arg_8_0)
	if not arg_8_0.tagModel then
		arg_8_0:initSubModel()
	end

	return arg_8_0.tagModel
end

var_0_0.instance = var_0_0.New()

return var_0_0
