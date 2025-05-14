module("modules.logic.room.model.interact.RoomInteractBuildingMO", package.seeall)

local var_0_0 = pureTable("RoomInteractBuildingMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.buildingUId
	arg_1_0.buildingMO = arg_1_1
	arg_1_0._interactHeroIdList = {}
	arg_1_0._interactHeroIdMap = {}
	arg_1_0.config = RoomConfig.instance:getInteractBuildingConfig(arg_1_1.buildingId)
end

function var_0_0.clear(arg_2_0)
	if #arg_2_0._interactHeroIdList > 0 then
		for iter_2_0 = #arg_2_0._interactHeroIdList, 1, -1 do
			arg_2_0._interactHeroIdMap[arg_2_0._interactHeroIdList[iter_2_0]] = false

			table.remove(arg_2_0._interactHeroIdList, iter_2_0)
		end
	end
end

function var_0_0.addHeroId(arg_3_0, arg_3_1)
	if not arg_3_0._interactHeroIdMap[arg_3_1] then
		arg_3_0._interactHeroIdMap[arg_3_1] = true

		table.insert(arg_3_0._interactHeroIdList, arg_3_1)
	end
end

function var_0_0.removeHeroId(arg_4_0, arg_4_1)
	if arg_4_0._interactHeroIdMap[arg_4_1] then
		arg_4_0._interactHeroIdMap[arg_4_1] = false

		tabletool.removeValue(arg_4_0._interactHeroIdList, arg_4_1)
	end
end

function var_0_0.getHeroIdList(arg_5_0)
	return arg_5_0._interactHeroIdList
end

function var_0_0.getHeroCount(arg_6_0)
	return #arg_6_0._interactHeroIdList
end

function var_0_0.isHeroMax(arg_7_0)
	if arg_7_0:getHeroCount() >= arg_7_0:getHeroMax() then
		return true
	end

	return false
end

function var_0_0.getHeroMax(arg_8_0)
	if arg_8_0.config then
		return arg_8_0.config.heroCount
	end

	return 1
end

function var_0_0.isFindPath(arg_9_0)
	if arg_9_0.config and arg_9_0.config.interactType == 1 then
		return true
	end

	return false
end

function var_0_0.isHasHeroId(arg_10_0, arg_10_1)
	if arg_10_0._interactHeroIdMap[arg_10_1] then
		return true
	end

	return false
end

function var_0_0.checkHeroIdList(arg_11_0)
	if not arg_11_0._interactHeroIdList then
		return
	end

	local var_11_0 = RoomCharacterModel.instance

	for iter_11_0 = #arg_11_0._interactHeroIdList, 1, -1 do
		local var_11_1 = arg_11_0._interactHeroIdList[iter_11_0]

		if var_11_0:getCharacterMOById(var_11_1) == nil then
			table.remove(arg_11_0._interactHeroIdList, iter_11_0)

			arg_11_0._interactHeroIdMap[var_11_1] = false
		end
	end
end

return var_0_0
