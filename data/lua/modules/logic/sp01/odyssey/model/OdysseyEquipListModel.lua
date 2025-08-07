module("modules.logic.sp01.odyssey.model.OdysseyEquipListModel", package.seeall)

local var_0_0 = class("OdysseyEquipListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._filterTag = nil
	arg_2_0._itemType = nil
end

function var_0_0.copyListFromEquipModel(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_1 = arg_3_1 or OdysseyEnum.ItemType.Equip

	local var_3_0 = OdysseyItemModel.instance:getItemMoList()
	local var_3_1 = arg_3_0:getCount()
	local var_3_2 = OdysseyHeroGroupModel.instance:getCurHeroGroup()
	local var_3_3 = arg_3_1 == OdysseyEnum.ItemType.Equip
	local var_3_4 = {}
	local var_3_5 = 0

	if var_3_0 and next(var_3_0) then
		for iter_3_0, iter_3_1 in ipairs(var_3_0) do
			if iter_3_1.config.type == arg_3_1 and (arg_3_2 == nil or arg_3_2 == iter_3_1.config.suitId) then
				table.insert(var_3_4, iter_3_1)

				var_3_5 = var_3_5 + 1
			end
		end
	end

	if var_3_1 > 0 and arg_3_1 == arg_3_0._itemType and arg_3_2 == arg_3_0._filterType and arg_3_4 and var_3_5 == var_3_1 then
		local var_3_6 = arg_3_0:getList()

		logNormal("奥德赛下半活动 道具列表延时排序")

		for iter_3_2, iter_3_3 in ipairs(var_3_6) do
			iter_3_3.isEquip = arg_3_3 == OdysseyEnum.BagType.FightPrepare and var_3_3 and var_3_2:isEquipUse(iter_3_3.uid)
		end

		arg_3_0:onModelUpdate()
	else
		logNormal("奥德赛下半活动 道具列表立刻排序")

		local var_3_7 = {}

		if var_3_4 and next(var_3_4) then
			for iter_3_4, iter_3_5 in ipairs(var_3_4) do
				local var_3_8 = OdysseyItemListMo.New()
				local var_3_9 = arg_3_3 == OdysseyEnum.BagType.FightPrepare and var_3_3 and var_3_2:isEquipUse(iter_3_5.uid)

				var_3_8:init(iter_3_5, arg_3_3, var_3_9)
				table.insert(var_3_7, var_3_8)
			end
		end

		table.sort(var_3_7, arg_3_0.sortMoList)
		arg_3_0:clear()
		arg_3_0:addList(var_3_7)
	end

	arg_3_0._itemType = arg_3_1
	arg_3_0._filterType = arg_3_2
end

function var_0_0.sortMoList(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.itemMo
	local var_4_1 = arg_4_1.itemMo

	if arg_4_0.isEquip ~= arg_4_1.isEquip then
		return arg_4_0.isEquip == true
	end

	if var_4_0.id == var_4_1.id then
		return var_4_0.uid > var_4_1.uid
	end

	local var_4_2 = var_4_0.config
	local var_4_3 = var_4_1.config

	if var_4_0.config.rare == var_4_1.config.rare then
		return var_4_0.id > var_4_1.id
	end

	return var_4_2.rare > var_4_3.rare
end

function var_0_0.clearSelect(arg_5_0)
	local var_5_0 = arg_5_0._scrollViews[1]

	if var_5_0 then
		local var_5_1 = var_5_0:getFirstSelect()

		if var_5_1 then
			var_5_0:selectCell(var_5_1.id, false)
		end
	end
end

function var_0_0.getSelectMo(arg_6_0)
	local var_6_0 = arg_6_0._scrollViews[1]

	if var_6_0 then
		return (var_6_0:getFirstSelect())
	end

	return nil
end

function var_0_0.setSelect(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._scrollViews[1]

	if var_7_0 then
		for iter_7_0, iter_7_1 in ipairs(arg_7_0._list) do
			if iter_7_1.itemMo.uid == arg_7_1 then
				var_7_0:selectCell(iter_7_1.id, true)
				OdysseyController.instance:dispatchEvent(OdysseyEvent.OnEquipItemSelect, iter_7_1)

				break
			end
		end
	end
end

function var_0_0.getFirstMo(arg_8_0)
	return arg_8_0:getByIndex(1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
