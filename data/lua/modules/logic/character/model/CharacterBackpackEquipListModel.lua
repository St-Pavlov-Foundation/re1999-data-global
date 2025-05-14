module("modules.logic.character.model.CharacterBackpackEquipListModel", package.seeall)

local var_0_0 = class("CharacterBackpackEquipListModel", ListScrollModel)

function var_0_0.init(arg_1_0)
	arg_1_0._levelAscend = false
	arg_1_0._qualityAscend = false
	arg_1_0._timeAscend = false
	arg_1_0._btnTag = 1
end

function var_0_0.getBtnTag(arg_2_0)
	return arg_2_0._btnTag
end

function var_0_0.getRankState(arg_3_0)
	return arg_3_0._levelAscend and 1 or -1, arg_3_0._qualityAscend and 1 or -1, arg_3_0._timeAscend and 1 or -1
end

function var_0_0.updateModel(arg_4_0)
	arg_4_0._equipList = arg_4_0._equipList or {}

	arg_4_0:setList(arg_4_0._equipList)
end

function var_0_0.getCount(arg_5_0)
	return arg_5_0._equipList and #arg_5_0._equipList or 0
end

function var_0_0.setEquipList(arg_6_0)
	arg_6_0._equipList = {}

	local var_6_0 = EquipModel.instance:getEquips()

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		if iter_6_1.config then
			table.insert(arg_6_0._equipList, iter_6_1)
		end
	end

	arg_6_0:sortEquipList()
	arg_6_0:setList(arg_6_0._equipList)
end

function var_0_0.setEquipListNew(arg_7_0, arg_7_1)
	arg_7_0._equipList = arg_7_1

	arg_7_0:sortEquipList()
	arg_7_0:setList(arg_7_0._equipList)
end

function var_0_0.sortEquipList(arg_8_0)
	if arg_8_0._btnTag == 1 then
		arg_8_0:_sortByLevel()
	elseif arg_8_0._btnTag == 2 then
		arg_8_0:_sortByQuality()
	elseif arg_8_0._btnTag == 3 then
		arg_8_0:_sortByTime()
	end
end

function var_0_0.sortByLevel(arg_9_0)
	arg_9_0._qualityAscend = false
	arg_9_0._timeAscend = false

	if arg_9_0._btnTag == 1 then
		arg_9_0._levelAscend = not arg_9_0._levelAscend
	else
		arg_9_0._btnTag = 1
	end

	arg_9_0:_sortByLevel()
	arg_9_0:setList(arg_9_0._equipList)
end

function var_0_0._sortByLevel(arg_10_0)
	table.sort(arg_10_0._equipList, EquipHelper.sortByLevelFunc)
end

function var_0_0.sortByQuality(arg_11_0)
	arg_11_0._levelAscend = false
	arg_11_0._timeAscend = false

	if arg_11_0._btnTag == 2 then
		arg_11_0._qualityAscend = not arg_11_0._qualityAscend
	else
		arg_11_0._btnTag = 2
	end

	arg_11_0:_sortByQuality()
	arg_11_0:setList(arg_11_0._equipList)
end

function var_0_0._sortByQuality(arg_12_0)
	table.sort(arg_12_0._equipList, EquipHelper.sortByQualityFunc)
end

function var_0_0.sortByTime(arg_13_0)
	arg_13_0._levelAscend = false
	arg_13_0._qualityAscend = false

	if arg_13_0._btnTag == 3 then
		arg_13_0._timeAscend = not arg_13_0._timeAscend
	else
		arg_13_0._btnTag = 3
	end

	arg_13_0:_sortByTime()
	arg_13_0:setList(arg_13_0._equipList)
end

function var_0_0._sortByTime(arg_14_0)
	table.sort(arg_14_0._equipList, EquipHelper.sortByTimeFunc)
end

function var_0_0._getEquipList(arg_15_0)
	return arg_15_0._equipList
end

function var_0_0.openEquipView(arg_16_0)
	arg_16_0:init()

	arg_16_0.equipUidToHeroMo = {}

	local var_16_0 = HeroGroupModel.instance:getCurGroupMO()
	local var_16_1 = var_16_0:getAllPosEquips()
	local var_16_2 = var_16_0.heroList

	for iter_16_0, iter_16_1 in pairs(var_16_1) do
		arg_16_0.equipUidToHeroMo[iter_16_1.equipUid[1]] = HeroModel.instance:getById(var_16_2[iter_16_0 + 1])
	end
end

function var_0_0.getHeroMoByEquipUid(arg_17_0, arg_17_1)
	return arg_17_0.equipUidToHeroMo and arg_17_0.equipUidToHeroMo[arg_17_1]
end

function var_0_0.clearEquipList(arg_18_0)
	arg_18_0._equipList = nil
	arg_18_0.equipUidToHeroMo = nil

	arg_18_0:clear()
end

var_0_0.instance = var_0_0.New()

return var_0_0
