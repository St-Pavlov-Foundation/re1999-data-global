module("modules.logic.survival.model.map.SurvivalPlayerMo", package.seeall)

local var_0_0 = pureTable("SurvivalPlayerMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = 0
	arg_1_0.dir = arg_1_1.position.dir
	arg_1_0.pos = SurvivalHexNode.New(arg_1_1.position.hex.q, arg_1_1.position.hex.r)
	arg_1_0.explored = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.explored) do
		SurvivalHelper.instance:addNodeToDict(arg_1_0.explored, iter_1_1)
	end

	arg_1_0.canExplored = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.canExplored) do
		SurvivalHelper.instance:addNodeToDict(arg_1_0.canExplored, iter_1_3)
	end
end

function var_0_0.getWorldPos(arg_2_0)
	return SurvivalHelper.instance:hexPointToWorldPoint(arg_2_0.pos.q, arg_2_0.pos.r)
end

function var_0_0.getResPath(arg_3_0)
	local var_3_0 = SurvivalEnum.ConstId.PlayerRes
	local var_3_1 = SurvivalShelterModel.instance:getWeekInfo()
	local var_3_2 = SurvivalMapModel.instance:getSceneMo():getBlockTypeByPos(arg_3_0.pos)

	if var_3_2 == SurvivalEnum.UnitSubType.Ice and var_3_1:getAttr(SurvivalEnum.AttrType.Vehicle_Ice) > 0 then
		var_3_0 = SurvivalEnum.ConstId.Vehicle_Ice
	elseif var_3_2 == SurvivalEnum.UnitSubType.Magma and var_3_1:getAttr(SurvivalEnum.AttrType.Vehicle_Magma) > 0 then
		var_3_0 = SurvivalEnum.ConstId.Vehicle_Magma
	elseif var_3_2 == SurvivalEnum.UnitSubType.Miasma and var_3_1:getAttr(SurvivalEnum.AttrType.Vehicle_Miasma) > 0 then
		var_3_0 = SurvivalEnum.ConstId.Vehicle_Miasma
	elseif var_3_2 == SurvivalEnum.UnitSubType.Morass and var_3_1:getAttr(SurvivalEnum.AttrType.Vehicle_Morass) > 0 then
		var_3_0 = SurvivalEnum.ConstId.Vehicle_Morass
	elseif var_3_2 == SurvivalEnum.UnitSubType.Water then
		if var_3_1:getAttr(SurvivalEnum.AttrType.Vehicle_Water) > 0 then
			var_3_0 = SurvivalEnum.ConstId.Vehicle_Water
		else
			var_3_0 = SurvivalEnum.ConstId.Vehicle_WaterNormal
		end
	end

	return SurvivalConfig.instance:getConstValue(var_3_0)
end

function var_0_0.isDefaultModel(arg_4_0)
	local var_4_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_4_1 = SurvivalMapModel.instance:getSceneMo():getBlockTypeByPos(arg_4_0.pos)

	if var_4_1 == SurvivalEnum.UnitSubType.Ice and var_4_0:getAttr(SurvivalEnum.AttrType.Vehicle_Ice) > 0 then
		return false
	elseif var_4_1 == SurvivalEnum.UnitSubType.Magma and var_4_0:getAttr(SurvivalEnum.AttrType.Vehicle_Magma) > 0 then
		return false
	elseif var_4_1 == SurvivalEnum.UnitSubType.Miasma and var_4_0:getAttr(SurvivalEnum.AttrType.Vehicle_Miasma) > 0 then
		return false
	elseif var_4_1 == SurvivalEnum.UnitSubType.Morass and var_4_0:getAttr(SurvivalEnum.AttrType.Vehicle_Morass) > 0 then
		return false
	elseif var_4_1 == SurvivalEnum.UnitSubType.Water then
		return false
	end

	return true
end

return var_0_0
