module("modules.logic.survival.model.shelter.SurvivalShelterMapCo", package.seeall)

local var_0_0 = pureTable("SurvivalShelterMapCo")
local var_0_1 = math.sqrt(3)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.allBlocks = {}
	arg_1_0.allBlockPaths = arg_1_1[2]
	arg_1_0.walkables = {}
	arg_1_0.allBuildings = {}
	arg_1_0.buildingDict = {}
	arg_1_0.allBuildingPaths = arg_1_1[4]

	for iter_1_0, iter_1_1 in ipairs(arg_1_1[1]) do
		local var_1_0 = SurvivalBlockCo.New()

		var_1_0:init(iter_1_1, arg_1_0.allBlockPaths)
		table.insert(arg_1_0.allBlocks, var_1_0)

		if var_1_0.walkable then
			SurvivalHelper.instance:addNodeToDict(arg_1_0.walkables, var_1_0.pos)
		end

		arg_1_0.minX, arg_1_0.maxX, arg_1_0.minY, arg_1_0.maxY = var_1_0:getRange(arg_1_0.minX, arg_1_0.maxX, arg_1_0.minY, arg_1_0.maxY)
	end

	if not arg_1_0.minX then
		arg_1_0.minX, arg_1_0.maxX, arg_1_0.minY, arg_1_0.maxY = 0, 0, 0, 0
	end

	arg_1_0.minX = arg_1_0.minX * var_0_1 / 2
	arg_1_0.maxX = arg_1_0.maxX * var_0_1 / 2
	arg_1_0.minY = arg_1_0.minY * 3 / 4
	arg_1_0.maxY = arg_1_0.maxY * 3 / 4

	for iter_1_2, iter_1_3 in ipairs(arg_1_1[3]) do
		local var_1_1 = SurvivalShelterBuildingCo.New()

		var_1_1:init(iter_1_3, arg_1_0.allBuildingPaths)
		table.insert(arg_1_0.allBuildings, var_1_1)

		arg_1_0.buildingDict[var_1_1.id] = var_1_1
	end
end

function var_0_0.getBuildingById(arg_2_0, arg_2_1)
	return arg_2_0.buildingDict[arg_2_1]
end

function var_0_0.getMainBuild(arg_3_0)
	if arg_3_0.buildingDict == nil then
		return nil
	end

	for iter_3_0, iter_3_1 in pairs(arg_3_0.buildingDict) do
		if iter_3_1 then
			local var_3_0 = lua_survival_building.configDict[iter_3_1.cfgId]

			if var_3_0 then
				for iter_3_2, iter_3_3 in pairs(var_3_0) do
					if iter_3_3 and iter_3_3.type == SurvivalEnum.BuildingType.Base then
						return iter_3_1
					end
				end
			end
		end
	end

	return nil
end

return var_0_0
