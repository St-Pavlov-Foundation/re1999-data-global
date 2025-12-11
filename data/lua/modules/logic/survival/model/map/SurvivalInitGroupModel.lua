module("modules.logic.survival.model.map.SurvivalInitGroupModel", package.seeall)

local var_0_0 = class("SurvivalInitGroupModel", ListScrollModel)

function var_0_0.init(arg_1_0)
	arg_1_0.allSelectHeroMos = {}
	arg_1_0.assistHeroMo = nil
	arg_1_0.allSelectNpcs = {}
	arg_1_0.selectMapIndex = 0
	arg_1_0.curClickHeroIndex = 1

	local var_1_0 = SurvivalShelterModel.instance:getWeekInfo()

	if var_1_0 then
		local var_1_1 = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.SurvivalTeamSave, "")

		if not string.nilorempty(var_1_1) then
			local var_1_2 = GameUtil.splitString2(var_1_1)
			local var_1_3 = var_1_2[1] or {}
			local var_1_4 = var_1_2[2] or {}
			local var_1_5 = arg_1_0:getCarryHeroCount()
			local var_1_6 = arg_1_0:getCarryNPCCount()

			for iter_1_0, iter_1_1 in ipairs(var_1_3) do
				if var_1_5 <= 0 then
					break
				end

				local var_1_7 = HeroModel.instance:getById(iter_1_1)

				if var_1_7 and var_1_0:getHeroMo(var_1_7.heroId).health > 0 then
					table.insert(arg_1_0.allSelectHeroMos, var_1_7)

					var_1_5 = var_1_5 - 1
				end
			end

			for iter_1_2, iter_1_3 in ipairs(var_1_4) do
				if var_1_6 <= 0 then
					break
				end

				local var_1_8 = var_1_0.npcDict[tonumber(iter_1_3)]

				if var_1_8 then
					table.insert(arg_1_0.allSelectNpcs, var_1_8)

					var_1_6 = var_1_6 - 1
				end
			end
		end
	end
end

function var_0_0.initHeroList(arg_2_0)
	local var_2_0 = {}
	local var_2_1 = {}
	local var_2_2 = {}
	local var_2_3

	for iter_2_0 = 1, arg_2_0:getCarryHeroCount() do
		if arg_2_0.allSelectHeroMos[iter_2_0] and (not arg_2_0.assistHeroMo or arg_2_0.assistHeroMo.heroMO ~= arg_2_0.allSelectHeroMos[iter_2_0]) then
			table.insert(var_2_0, arg_2_0.allSelectHeroMos[iter_2_0])

			var_2_2[arg_2_0.allSelectHeroMos[iter_2_0].uid] = true
			var_2_3 = #var_2_0
		end
	end

	local var_2_4 = SurvivalShelterModel.instance:getWeekInfo()

	for iter_2_1, iter_2_2 in ipairs(CharacterBackpackCardListModel.instance:getCharacterCardList()) do
		if not var_2_2[iter_2_2.uid] then
			var_2_2[iter_2_2.uid] = true

			if var_2_4:getHeroMo(iter_2_2.heroId).health == 0 then
				table.insert(var_2_1, iter_2_2)
			else
				table.insert(var_2_0, iter_2_2)
			end
		end
	end

	tabletool.addValues(var_2_0, var_2_1)
	arg_2_0:setList(var_2_0)

	if var_2_3 then
		arg_2_0:selectCell(var_2_3, true)
	end

	arg_2_0.defaultIndex = var_2_3
end

function var_0_0.getMoIndex(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in pairs(arg_3_0.allSelectHeroMos) do
		if iter_3_1 == arg_3_1 then
			return iter_3_0
		end
	end

	return -1
end

function var_0_0.trySetHeroMo(arg_4_0, arg_4_1)
	if arg_4_1 then
		for iter_4_0, iter_4_1 in pairs(arg_4_0.allSelectHeroMos) do
			if iter_4_1 and iter_4_1.heroId == arg_4_1.heroId then
				arg_4_0.allSelectHeroMos[iter_4_0] = nil

				if arg_4_0.assistHeroMo and iter_4_1 == arg_4_0.assistHeroMo.heroMO then
					arg_4_0.assistHeroMo = nil
				end
			end
		end
	end

	arg_4_0.allSelectHeroMos[arg_4_0.curClickHeroIndex] = arg_4_1
end

function var_0_0.tryAddHeroMo(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.allSelectHeroMos) do
		if arg_5_1 == iter_5_1 then
			return false
		end

		if iter_5_1 and iter_5_1.heroId == arg_5_1.heroId then
			arg_5_0.allSelectHeroMos[iter_5_0] = nil

			if arg_5_0.assistHeroMo and iter_5_1 == arg_5_0.assistHeroMo.heroMO then
				arg_5_0.assistHeroMo = nil
			end
		end
	end

	for iter_5_2 = 1, arg_5_0:getCarryHeroCount() do
		if not arg_5_0.allSelectHeroMos[iter_5_2] then
			arg_5_0.allSelectHeroMos[iter_5_2] = arg_5_1

			return iter_5_2
		end
	end
end

function var_0_0.getCarryHeroCount(arg_6_0)
	return SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.ExploreRoleNum)
end

function var_0_0.getCarryNPCCount(arg_7_0)
	return SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.ExploreNpcNum)
end

function var_0_0.getCarryHeroMax(arg_8_0)
	return tonumber((SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.CarryHeroMax))) or 0
end

function var_0_0.getCarryNPCMax(arg_9_0)
	return tonumber((SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.CarryNpcMax))) or 0
end

function var_0_0.hasAssistHeroMo(arg_10_0)
	return arg_10_0.assistHeroMo ~= nil
end

function var_0_0.addAssistHeroMo(arg_11_0, arg_11_1)
	arg_11_0.assistHeroMo = arg_11_1

	for iter_11_0, iter_11_1 in pairs(arg_11_0.allSelectHeroMos) do
		if iter_11_1 and iter_11_1.heroId == arg_11_1.heroMO.heroId then
			arg_11_0.allSelectHeroMos[iter_11_0] = arg_11_1.heroMO

			return
		end
	end

	for iter_11_2 = 1, arg_11_0:getCarryHeroCount() do
		if not arg_11_0.allSelectHeroMos[iter_11_2] then
			arg_11_0.allSelectHeroMos[iter_11_2] = arg_11_1.heroMO

			return
		end
	end
end

function var_0_0.removeAssistMo(arg_12_0)
	if not arg_12_0.assistHeroMo then
		return
	end

	for iter_12_0, iter_12_1 in pairs(arg_12_0.allSelectHeroMos) do
		if iter_12_1 and iter_12_1.heroId == arg_12_0.assistHeroMo.heroId then
			arg_12_0.allSelectHeroMos[iter_12_0] = nil

			break
		end
	end

	arg_12_0.assistHeroMo = nil
end

function var_0_0.isHeroFull(arg_13_0)
	return tabletool.len(arg_13_0.allSelectHeroMos) == arg_13_0:getCarryHeroCount()
end

return var_0_0
