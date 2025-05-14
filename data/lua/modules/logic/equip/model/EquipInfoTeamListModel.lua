module("modules.logic.equip.model.EquipInfoTeamListModel", package.seeall)

local var_0_0 = class("EquipInfoTeamListModel", EquipInfoBaseListModel)

function var_0_0.onOpen(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.heroMo = arg_1_1.heroMo

	arg_1_0:initTeamEquipList(arg_1_1, arg_1_2)

	arg_1_0.curGroupMO = arg_1_1.heroGroupMo or HeroGroupModel.instance:getCurGroupMO()
	arg_1_0.maxHeroNum = arg_1_1.maxHeroNum
	arg_1_0.posIndex = arg_1_1.posIndex

	if arg_1_1 and arg_1_1.heroMo and arg_1_1.heroMo:isOtherPlayerHero() then
		arg_1_0.otherPlayerHeroMo = arg_1_1.heroMo
	end

	local var_1_0 = arg_1_1.equipMo or arg_1_0.equipMoList and arg_1_0.equipMoList[1]

	arg_1_0:setCurrentSelectEquipMo(var_1_0)
	arg_1_0:initInTeamEquipUidToHero()
end

function var_0_0.initTeamEquipList(arg_2_0, arg_2_1, arg_2_2)
	if (arg_2_1.equipMo and arg_2_1.equipMo.equipType) == EquipEnum.ClientEquipType.TrialHero then
		arg_2_0.equipMoList = {
			arg_2_1.equipMo
		}
	else
		arg_2_0:initEquipList(arg_2_2)
	end
end

function var_0_0.initEquipList(arg_3_0, arg_3_1)
	arg_3_0.equipMoList = {}

	local var_3_0 = arg_3_1:isFiltering()

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
		for iter_3_0, iter_3_1 in ipairs(EquipModel.instance:getEquips()) do
			if EquipHelper.isNormalEquip(iter_3_1.config) then
				if var_3_0 then
					if arg_3_1:checkIsIncludeTag(iter_3_1.config) then
						table.insert(arg_3_0.equipMoList, iter_3_1)
					end
				else
					table.insert(arg_3_0.equipMoList, iter_3_1)
				end
			end
		end
	end

	for iter_3_2, iter_3_3 in ipairs(HeroGroupTrialModel.instance:getTrialEquipList()) do
		if var_3_0 then
			if arg_3_1:checkIsIncludeTag(iter_3_3.config) then
				table.insert(arg_3_0.equipMoList, iter_3_3)
			end
		else
			table.insert(arg_3_0.equipMoList, iter_3_3)
		end
	end

	arg_3_0:resortEquip()
end

function var_0_0.initInTeamEquipUidToHero(arg_4_0)
	arg_4_0.equipUidToHeroMo = {}

	local var_4_0 = arg_4_0.curGroupMO.heroList

	for iter_4_0, iter_4_1 in pairs(arg_4_0.curGroupMO.equips) do
		if not arg_4_0.maxHeroNum or iter_4_0 + 1 <= arg_4_0.maxHeroNum then
			local var_4_1 = var_4_0[iter_4_0 + 1]

			if var_4_1 and tonumber(var_4_1) < 0 then
				arg_4_0.equipUidToHeroMo[iter_4_1.equipUid[1]] = HeroGroupTrialModel.instance:getById(var_4_1)
			elseif arg_4_0.otherPlayerHeroMo and arg_4_0.otherPlayerHeroMo.uid == var_4_1 then
				arg_4_0.equipUidToHeroMo[iter_4_1.equipUid[1]] = arg_4_0.otherPlayerHeroMo
			else
				arg_4_0.equipUidToHeroMo[iter_4_1.equipUid[1]] = HeroModel.instance:getById(var_4_1)
			end
		end
	end
end

function var_0_0.getGroupCurrentPosEquip(arg_5_0, arg_5_1)
	return arg_5_0.curGroupMO:getPosEquips(arg_5_1 or arg_5_0.posIndex).equipUid
end

function var_0_0.getCurrentPosIndex(arg_6_0)
	return arg_6_0.posIndex
end

function var_0_0.getRequestData(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = {
		arg_7_2
	}

	return arg_7_0.curGroupMO.groupId, arg_7_1, var_7_0
end

function var_0_0.getHeroMoByEquipUid(arg_8_0, arg_8_1)
	return arg_8_0.equipUidToHeroMo and arg_8_0.equipUidToHeroMo[arg_8_1]
end

function var_0_0.clear(arg_9_0)
	arg_9_0:onInit()

	arg_9_0.selectedEquipMo = nil
	arg_9_0.curGroupMO = nil
	arg_9_0.posIndex = nil
	arg_9_0.equipUidToHeroMo = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
