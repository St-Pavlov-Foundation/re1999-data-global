module("modules.logic.sp01.odyssey.model.OdysseyEquipInfoTeamListModel", package.seeall)

local var_0_0 = class("OdysseyEquipInfoTeamListModel", EquipInfoBaseListModel)

function var_0_0.setSeatLevel(arg_1_0, arg_1_1)
	arg_1_0._seatLevel = arg_1_1
end

function var_0_0.getSeatLevel(arg_2_0)
	return arg_2_0._seatLevel
end

function var_0_0.onOpen(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.viewParam = arg_3_1
	arg_3_0.sortBy = EquipInfoBaseListModel.SortBy.Level

	arg_3_0:initTeamEquipList(arg_3_1, arg_3_2)

	arg_3_0.curGroupMO = arg_3_1.heroGroupMo or HeroGroupModel.instance:getCurGroupMO()
	arg_3_0.posIndex = arg_3_1.posIndex

	local var_3_0 = arg_3_1.equipMo or arg_3_0.equipMoList and arg_3_0.equipMoList[1]

	arg_3_0:setCurrentSelectEquipMo(var_3_0)
	arg_3_0:initInTeamEquipUidToHero()
end

function var_0_0.initTeamEquipList(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1.equipMo and arg_4_1.equipMo.equipType == EquipEnum.ClientEquipType.TrialHero then
		arg_4_0.equipMoList = {
			arg_4_1.equipMo
		}
	else
		arg_4_0:initEquipList(arg_4_2)
	end
end

function var_0_0.initEquipList(arg_5_0, arg_5_1)
	local var_5_0 = {}

	if arg_5_0.viewParam.fromView == EquipEnum.FromViewEnum.FromCachotHeroGroupFightView then
		local var_5_1 = V1a6_CachotModel.instance:getTeamInfo()

		for iter_5_0, iter_5_1 in ipairs(var_5_1.equipUids) do
			table.insert(var_5_0, EquipModel.instance:getEquip(iter_5_1))
		end
	else
		var_5_0 = EquipModel.instance:getEquips()
	end

	arg_5_0.equipMoList = {}

	local var_5_2 = arg_5_1:isFiltering()

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
		for iter_5_2, iter_5_3 in ipairs(var_5_0) do
			if EquipHelper.isNormalEquip(iter_5_3.config) then
				if var_5_2 then
					if arg_5_1:checkIsIncludeTag(iter_5_3.config) then
						table.insert(arg_5_0.equipMoList, iter_5_3)
					end
				else
					table.insert(arg_5_0.equipMoList, iter_5_3)
				end
			end
		end
	end

	arg_5_0:resortEquip()
end

function var_0_0.initInTeamEquipUidToHero(arg_6_0)
	arg_6_0.equipUidToHeroMo = {}

	local var_6_0 = arg_6_0.curGroupMO.heroList

	for iter_6_0, iter_6_1 in pairs(arg_6_0.curGroupMO.equips) do
		local var_6_1 = var_6_0[iter_6_0 + 1]

		if tonumber(var_6_1) < 0 then
			arg_6_0.equipUidToHeroMo[iter_6_1.equipUid[1]] = HeroGroupTrialModel.instance:getById(var_6_1)
		else
			arg_6_0.equipUidToHeroMo[iter_6_1.equipUid[1]] = HeroModel.instance:getById(var_6_1)
		end
	end
end

function var_0_0.getGroupCurrentPosEquip(arg_7_0, arg_7_1)
	return arg_7_0.curGroupMO:getPosEquips(arg_7_1 or arg_7_0.posIndex).equipUid
end

function var_0_0.getCurrentPosIndex(arg_8_0)
	return arg_8_0.posIndex
end

function var_0_0.getRequestData(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = {
		arg_9_2
	}

	return arg_9_0.curGroupMO.groupId, arg_9_1, var_9_0
end

function var_0_0.getHeroMoByEquipUid(arg_10_0, arg_10_1)
	return arg_10_0.equipUidToHeroMo and arg_10_0.equipUidToHeroMo[arg_10_1]
end

function var_0_0.clear(arg_11_0)
	arg_11_0:onInit()

	arg_11_0.selectedEquipMo = nil
	arg_11_0.curGroupMO = nil
	arg_11_0.posIndex = nil
	arg_11_0.equipUidToHeroMo = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
