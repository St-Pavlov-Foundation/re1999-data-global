module("modules.logic.survival.model.map.Survival3DModelMO", package.seeall)

local var_0_0 = pureTable("Survival3DModelMO")

function var_0_0.setDataByUnitMo(arg_1_0, arg_1_1)
	arg_1_0.isSearch = arg_1_1.unitType == SurvivalEnum.UnitType.Search
	arg_1_0.curHeroPath = nil
	arg_1_0.curUnitPath = nil
	arg_1_0.isHandleHeroPath = true

	local var_1_0 = arg_1_1:getResPath()
	local var_1_1 = arg_1_1.co.camera
	local var_1_2 = next(arg_1_1.exPoints)

	arg_1_0:setData(var_1_0, var_1_1, var_1_2)
end

function var_0_0.setDataByEventID(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.curHeroPath = nil
	arg_2_0.curUnitPath = nil
	arg_2_0.isHandleHeroPath = false

	local var_2_0 = arg_2_2
	local var_2_1
	local var_2_2 = false

	if arg_2_1 then
		local var_2_3 = lua_survival_fight.configDict[arg_2_1] or SurvivalConfig.instance:getNpcConfig(arg_2_1, true)

		var_2_3 = var_2_3 or lua_survival_search.configDict[arg_2_1]
		var_2_3 = var_2_3 or lua_survival_mission.configDict[arg_2_1]

		if var_2_3 then
			var_2_0 = var_2_3.resource
			var_2_1 = var_2_3.camera
			var_2_2 = not string.nilorempty(var_2_3.grid)
		end
	end

	arg_2_0:setData(var_2_0, var_2_1, var_2_2)
end

function var_0_0.setData(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.unitPath = arg_3_1

	if arg_3_2 == 4 then
		arg_3_0.curHeroPath = "node6/role"
	elseif arg_3_0.unitPath and string.find(arg_3_0.unitPath, "^survival/buiding") then
		if arg_3_2 == 2 then
			arg_3_0.curUnitPath = "node4/buiding3"
		elseif arg_3_2 == 3 then
			arg_3_0.curUnitPath = "node5/buiding4"
		elseif arg_3_3 or arg_3_2 == 1 then
			arg_3_0.curUnitPath = "node3/buiding2"
		else
			arg_3_0.curUnitPath = "node2/buiding1"
			arg_3_0.curHeroPath = "node2/role"
		end
	else
		arg_3_0.curHeroPath = "node1/role"
		arg_3_0.curUnitPath = "node1/npc"
	end
end

return var_0_0
