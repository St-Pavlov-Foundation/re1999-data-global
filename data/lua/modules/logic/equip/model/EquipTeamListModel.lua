module("modules.logic.equip.model.EquipTeamListModel", package.seeall)

local var_0_0 = class("EquipTeamListModel", ListScrollModel)
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3

function var_0_0.onInit(arg_1_0)
	arg_1_0._levelAscend = false
	arg_1_0._qualityAscend = false
	arg_1_0._timeAscend = false
	arg_1_0._btnTag = var_0_1
	arg_1_0.isDown = false
end

function var_0_0.getHero(arg_2_0)
	return arg_2_0._heroMO
end

function var_0_0.getRequestData(arg_3_0, arg_3_1)
	return arg_3_0:_getRequestData(arg_3_0._posIndex, arg_3_1)
end

function var_0_0.getRequestDataByTargetUid(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0:getEquipTeamPos(arg_4_1)

	if var_4_0 then
		return arg_4_0:_getRequestData(var_4_0, arg_4_2)
	end
end

function var_0_0._getRequestData(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = {
		arg_5_2
	}

	return arg_5_0._curGroupMO.groupId, arg_5_1, var_5_0
end

function var_0_0.openTeamEquip(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0._curGroupMO = arg_6_3 or HeroGroupModel.instance:getCurGroupMO()
	arg_6_0._posIndex = arg_6_1
	arg_6_0._heroMO = arg_6_2
end

function var_0_0.getCurPosIndex(arg_7_0)
	return arg_7_0._posIndex
end

function var_0_0.initInTeamEquips(arg_8_0)
	arg_8_0._allInTeamEquips = {}

	local var_8_0 = arg_8_0._curGroupMO:getAllPosEquips()

	for iter_8_0, iter_8_1 in pairs(var_8_0) do
		for iter_8_2, iter_8_3 in pairs(iter_8_1.equipUid) do
			arg_8_0._allInTeamEquips[iter_8_3] = iter_8_0
		end
	end
end

function var_0_0.getEquipTeamPos(arg_9_0, arg_9_1)
	return arg_9_0._allInTeamEquips[arg_9_1]
end

function var_0_0.equipInTeam(arg_10_0, arg_10_1)
	return arg_10_0._allInTeamEquips[arg_10_1] ~= nil
end

function var_0_0.getTeamEquip(arg_11_0, arg_11_1)
	arg_11_1 = arg_11_1 or arg_11_0._posIndex

	return arg_11_0._curGroupMO:getPosEquips(arg_11_1).equipUid
end

function var_0_0.getCurGroupMo(arg_12_0)
	return arg_12_0._curGroupMO
end

function var_0_0.getBtnTag(arg_13_0)
	return arg_13_0._btnTag
end

function var_0_0.getRankState(arg_14_0)
	return arg_14_0._levelAscend and 1 or -1, arg_14_0._qualityAscend and 1 or -1, arg_14_0._timeAscend and 1 or -1
end

function var_0_0._sortByInTeam(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0:equipInTeam(arg_15_1.uid)

	if var_15_0 == arg_15_0:equipInTeam(arg_15_2.uid) then
		return nil
	end

	if var_15_0 then
		return true
	end

	return false
end

function var_0_0.setEquipList(arg_16_0, arg_16_1)
	if arg_16_1 then
		arg_16_0:initInTeamEquips()
	end

	arg_16_0._equipList = {}

	local var_16_0 = EquipModel.instance:getEquips()

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		local var_16_1 = EquipConfig.instance:getEquipCo(iter_16_1.equipId)

		if var_16_1 and var_16_1.isExpEquip ~= 1 and not EquipHelper.isRefineUniversalMaterials(iter_16_1.equipId) then
			table.insert(arg_16_0._equipList, iter_16_1)
		end
	end

	if arg_16_0._btnTag == var_0_1 then
		arg_16_0:_sortByLevel()
	elseif arg_16_0._btnTag == var_0_2 then
		arg_16_0:_sortByQuality()
	elseif arg_16_0._btnTag == var_0_3 then
		arg_16_0:_sortByTime()
	end

	arg_16_0:setList(arg_16_0._equipList)
end

function var_0_0.sortByLevel(arg_17_0)
	arg_17_0._qualityAscend = false
	arg_17_0._timeAscend = false

	if arg_17_0._btnTag == var_0_1 then
		arg_17_0._levelAscend = not arg_17_0._levelAscend
	else
		arg_17_0._btnTag = var_0_1
	end

	arg_17_0:_sortByLevel()
	arg_17_0:setList(arg_17_0._equipList)
end

function var_0_0._sortByLevelFunc(arg_18_0, arg_18_1)
	local var_18_0 = var_0_0.instance:_sortByInTeam(arg_18_0, arg_18_1)

	if var_18_0 ~= nil then
		return var_18_0
	end

	if arg_18_0.level ~= arg_18_1.level then
		if var_0_0.instance._levelAscend then
			return arg_18_0.level < arg_18_1.level
		else
			return arg_18_0.level > arg_18_1.level
		end
	elseif arg_18_0.config.rare ~= arg_18_1.config.rare then
		return arg_18_0.config.rare > arg_18_1.config.rare
	else
		return arg_18_0.id > arg_18_1.id
	end
end

function var_0_0._sortByLevel(arg_19_0)
	table.sort(arg_19_0._equipList, var_0_0._sortByLevelFunc)
end

function var_0_0.sortByQuality(arg_20_0)
	arg_20_0._levelAscend = false
	arg_20_0._timeAscend = false

	if arg_20_0._btnTag == var_0_2 then
		arg_20_0._qualityAscend = not arg_20_0._qualityAscend
	else
		arg_20_0._btnTag = var_0_2
	end

	arg_20_0:_sortByQuality()
	arg_20_0:setList(arg_20_0._equipList)
end

function var_0_0._sortByQualityFunc(arg_21_0, arg_21_1)
	local var_21_0 = var_0_0.instance:_sortByInTeam(arg_21_0, arg_21_1)

	if var_21_0 ~= nil then
		return var_21_0
	end

	if arg_21_0.config.rare ~= arg_21_1.config.rare then
		if var_0_0.instance._qualityAscend then
			return arg_21_0.config.rare < arg_21_1.config.rare
		else
			return arg_21_0.config.rare > arg_21_1.config.rare
		end
	elseif arg_21_0.level ~= arg_21_1.level then
		return arg_21_0.level > arg_21_1.level
	else
		return arg_21_0.id > arg_21_1.id
	end
end

function var_0_0._sortByQuality(arg_22_0)
	table.sort(arg_22_0._equipList, var_0_0._sortByQualityFunc)
end

function var_0_0.sortByTime(arg_23_0)
	arg_23_0._levelAscend = false
	arg_23_0._qualityAscend = false

	if arg_23_0._btnTag == var_0_3 then
		arg_23_0._timeAscend = not arg_23_0._timeAscend
	else
		arg_23_0._btnTag = var_0_3
	end

	arg_23_0:_sortByTime()
	arg_23_0:setList(arg_23_0._equipList)
end

function var_0_0._sortByTimeFunc(arg_24_0, arg_24_1)
	local var_24_0 = var_0_0.instance:_sortByInTeam(arg_24_0, arg_24_1)

	if var_24_0 ~= nil then
		return var_24_0
	end

	if arg_24_0.id ~= arg_24_1.id then
		if var_0_0.instance._timeAscend then
			return arg_24_0.id < arg_24_1.id
		else
			return arg_24_0.id > arg_24_1.id
		end
	elseif arg_24_0.level ~= arg_24_1.level then
		return arg_24_0.level > arg_24_1.level
	else
		return arg_24_0.config.rare > arg_24_1.config.rare
	end
end

function var_0_0._sortByTime(arg_25_0)
	table.sort(arg_25_0._equipList, var_0_0._sortByTimeFunc)
end

function var_0_0.clearEquipList(arg_26_0)
	arg_26_0._equipList = nil

	arg_26_0:clear()
end

function var_0_0.getEquipList(arg_27_0)
	return arg_27_0._equipList
end

var_0_0.instance = var_0_0.New()

return var_0_0
