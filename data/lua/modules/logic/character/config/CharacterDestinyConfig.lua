module("modules.logic.character.config.CharacterDestinyConfig", package.seeall)

local var_0_0 = class("CharacterDestinyConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"character_destiny_facets_consume",
		"character_destiny_facets",
		"character_destiny_slots",
		"character_destiny"
	}
end

function var_0_0.onInit(arg_2_0)
	arg_2_0._consumeTable = nil
	arg_2_0._destinyFacetsTable = nil
	arg_2_0._slotTable = nil
	arg_2_0._destinyTable = nil
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "character_destiny_facets_consume" then
		arg_3_0._consumeDict = arg_3_2
	elseif arg_3_1 == "character_destiny_facets" then
		arg_3_0._destinyFacetsTable = arg_3_2
	elseif arg_3_1 == "character_destiny_slots" then
		arg_3_0._slotTable = arg_3_2
	elseif arg_3_1 == "character_destiny" then
		arg_3_0._destinyTable = arg_3_2
	end
end

function var_0_0.hasDestinyHero(arg_4_0, arg_4_1)
	if arg_4_0._destinyTable then
		return arg_4_0._destinyTable.configDict[arg_4_1]
	end
end

function var_0_0.getHeroDestiny(arg_5_0, arg_5_1)
	if arg_5_0._destinyTable then
		return arg_5_0._destinyTable.configDict[arg_5_1]
	end
end

function var_0_0.getSlotIdByHeroId(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._destinyTable.configDict[arg_6_1]

	return var_6_0 and var_6_0.slotsId
end

function var_0_0.getFacetIdsByHeroId(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._destinyTable.configDict[arg_7_1]
	local var_7_1 = var_7_0 and var_7_0.facetsId

	if not string.nilorempty(var_7_1) then
		return (string.splitToNumber(var_7_1, "#"))
	end
end

function var_0_0.getDestinySlotCosByHeroId(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getSlotIdByHeroId(arg_8_1)

	return arg_8_0._slotTable.configDict[var_8_0]
end

function var_0_0.getDestinySlotCo(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_0:getDestinySlotCosByHeroId(arg_9_1)

	if var_9_0 and var_9_0[arg_9_2] then
		return var_9_0[arg_9_2][arg_9_3]
	end
end

function var_0_0.getNextDestinySlotCo(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_2 == 0 then
		return arg_10_0:getDestinySlotCo(arg_10_1, 1, 1)
	end

	local var_10_0 = arg_10_0:getDestinySlotCo(arg_10_1, arg_10_2, arg_10_3 + 1)

	if not var_10_0 then
		return arg_10_0:getDestinySlotCo(arg_10_1, arg_10_2 + 1, 1)
	end

	return var_10_0
end

function var_0_0.getCurDestinySlotAddAttr(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = {}
	local var_11_1 = arg_11_0:getDestinySlotCosByHeroId(arg_11_1)

	if var_11_1 then
		for iter_11_0, iter_11_1 in ipairs(var_11_1) do
			if iter_11_0 < arg_11_2 then
				for iter_11_2, iter_11_3 in ipairs(iter_11_1) do
					local var_11_2 = GameUtil.splitString2(iter_11_3.effect, true)

					for iter_11_4, iter_11_5 in ipairs(var_11_2) do
						local var_11_3 = iter_11_5[1]
						local var_11_4 = iter_11_5[2]

						var_11_4 = HeroConfig.instance:getHeroAttributeCO(var_11_3).showType == 1 and var_11_4 * 0.1 or var_11_4
						var_11_0[var_11_3] = var_11_0[var_11_3] and var_11_0[var_11_3] + var_11_4 or var_11_4
					end
				end
			elseif iter_11_0 == arg_11_2 then
				for iter_11_6 = 1, arg_11_3 do
					local var_11_5 = iter_11_1[iter_11_6]

					if var_11_5 then
						local var_11_6 = GameUtil.splitString2(var_11_5.effect, true)

						for iter_11_7, iter_11_8 in ipairs(var_11_6) do
							local var_11_7 = iter_11_8[1]
							local var_11_8 = iter_11_8[2]

							var_11_8 = HeroConfig.instance:getHeroAttributeCO(var_11_7).showType == 1 and var_11_8 * 0.1 or var_11_8
							var_11_0[var_11_7] = var_11_0[var_11_7] and var_11_0[var_11_7] + var_11_8 or var_11_8
						end
					end
				end
			end
		end
	end

	return var_11_0
end

function var_0_0.getLockAttr(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = {}
	local var_12_1 = arg_12_0:getDestinySlotCosByHeroId(arg_12_1)

	if var_12_1 and arg_12_2 < #var_12_1 then
		for iter_12_0 = arg_12_2 + 1, #var_12_1 do
			for iter_12_1, iter_12_2 in ipairs(var_12_1[iter_12_0]) do
				local var_12_2 = GameUtil.splitString2(iter_12_2.effect, true)

				for iter_12_3, iter_12_4 in ipairs(var_12_2) do
					local var_12_3 = iter_12_4[1]
					local var_12_4 = iter_12_4[2]

					var_12_4 = HeroConfig.instance:getHeroAttributeCO(var_12_3).showType == 1 and var_12_4 * 0.1 or var_12_4

					if not var_12_0[iter_12_0] then
						var_12_0[iter_12_0] = {}
					end

					if var_12_0[iter_12_0][var_12_3] then
						var_12_0[iter_12_0][var_12_3] = var_12_0[iter_12_0][var_12_3] + var_12_4
					else
						var_12_0[iter_12_0][var_12_3] = var_12_4
					end
				end
			end
		end
	end

	return var_12_0
end

function var_0_0.getDestinyFacets(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0._destinyFacetsTable.configDict[arg_13_1]

	return var_13_0 and var_13_0[arg_13_2]
end

function var_0_0.getDestinyFacetCo(arg_14_0, arg_14_1)
	return arg_14_0._destinyFacetsTable.configDict[arg_14_1]
end

function var_0_0.getDestinyFacetConsumeCo(arg_15_0, arg_15_1)
	return arg_15_0._consumeDict.configDict[arg_15_1]
end

function var_0_0.getAllDestinyConfigList(arg_16_0)
	if not arg_16_0._destinyTable then
		return
	end

	return arg_16_0._destinyTable.configList
end

var_0_0.instance = var_0_0.New()

return var_0_0
