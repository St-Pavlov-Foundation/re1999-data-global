module("modules.logic.herogrouppreset.model.HeroGroupPresetItemListModel", package.seeall)

local var_0_0 = class("HeroGroupPresetItemListModel", ListScrollModel)

var_0_0.instance = var_0_0.New()

function var_0_0.initList(arg_1_0, arg_1_1)
	arg_1_0._heroItem = arg_1_1
	arg_1_0._heroGroupNum = 0

	arg_1_0:clearInfo()
	arg_1_0:updateList()
end

function var_0_0.updateList(arg_2_0)
	local var_2_0 = arg_2_0:_getHeroGroupList(arg_2_0._heroItem)
	local var_2_1 = arg_2_0:_getSortList(var_2_0)

	arg_2_0:_sortList(var_2_0, var_2_1)

	arg_2_0._heroGroupNum = #var_2_0

	if #var_2_0 < HeroGroupPresetEnum.MaxNum then
		local var_2_2 = HeroGroupMO.New()

		var_2_2.__isAdd = true

		table.insert(var_2_0, var_2_2)
	end

	arg_2_0:setList(var_2_0)
end

function var_0_0._sortList(arg_3_0, arg_3_1, arg_3_2)
	table.sort(arg_3_1, function(arg_4_0, arg_4_1)
		return (tabletool.indexOf(arg_3_2, arg_4_0.id) or HeroGroupPresetEnum.MaxNum) < (tabletool.indexOf(arg_3_2, arg_4_1.id) or HeroGroupPresetEnum.MaxNum)
	end)
end

function var_0_0._getSortList(arg_5_0, arg_5_1)
	local var_5_0 = HeroGroupSnapshotModel.instance:getSortSubIds(arg_5_0._heroItem.id)

	if #var_5_0 ~= #arg_5_1 then
		for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
			if not tabletool.indexOf(var_5_0, iter_5_1.id) then
				table.insert(var_5_0, iter_5_1.id)
			end
		end
	end

	return var_5_0
end

function var_0_0._getHeroGroupList(arg_6_0, arg_6_1)
	return HeroGroupPresetController.instance:getHeroGroupCopyList(arg_6_0._heroItem.id) or HeroGroupPresetHeroGroupChangeController.instance:getHeroGroupList(arg_6_0._heroItem.id)
end

function var_0_0.getHeroNum(arg_7_0)
	return arg_7_0._heroItem.batNum + arg_7_0._heroItem.supNum
end

function var_0_0.getHeroGroupSnapshotType(arg_8_0)
	return arg_8_0._heroItem.id
end

function var_0_0.setHeroGroupSnapshotSubId(arg_9_0, arg_9_1)
	arg_9_0._subId = arg_9_1
end

function var_0_0.getHeroGroupSnapshotSubId(arg_10_0)
	return arg_10_0._subId
end

function var_0_0.setEditHeroGroupSnapshotSubId(arg_11_0, arg_11_1)
	arg_11_0._editHeroGroupSnapshotSubId = arg_11_1
end

function var_0_0.getEditHeroGroupSnapshotSubId(arg_12_0)
	return arg_12_0._editHeroGroupSnapshotSubId
end

function var_0_0.showDeleteBtn(arg_13_0)
	return arg_13_0._heroGroupNum > arg_13_0._heroItem.minNum
end

function var_0_0.setNewHeroGroupInfo(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0._newHeroGroupType = arg_14_1
	arg_14_0._newHeroGroupSubId = arg_14_2
end

function var_0_0.getNewHeroGroupInfo(arg_15_0)
	return arg_15_0._newHeroGroupType, arg_15_0._newHeroGroupSubId
end

function var_0_0.setTopHeroGroupId(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0._topHeroGroupId = arg_16_1
	arg_16_0._subId = arg_16_2
end

function var_0_0.getTopHeroGroupId(arg_17_0)
	return arg_17_0._topHeroGroupId, arg_17_0._subId
end

function var_0_0.getReplaceTeamSubId(arg_18_0, arg_18_1)
	if not arg_18_1 then
		return
	end

	local var_18_0 = arg_18_0:getList()

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		if arg_18_0:_isSameHeroGroup(arg_18_1, iter_18_1.heroList) then
			return iter_18_1.id
		end
	end

	return -1
end

function var_0_0._isSameHeroGroup(arg_19_0, arg_19_1, arg_19_2)
	if #arg_19_1 ~= #arg_19_2 then
		return
	end

	for iter_19_0, iter_19_1 in ipairs(arg_19_1) do
		if iter_19_1.heroUid ~= arg_19_2[iter_19_0] then
			return
		end
	end

	return true
end

function var_0_0.clearInfo(arg_20_0)
	arg_20_0:setNewHeroGroupInfo()
	arg_20_0:setTopHeroGroupId()
	arg_20_0:setEditHeroGroupSnapshotSubId()
end

return var_0_0
