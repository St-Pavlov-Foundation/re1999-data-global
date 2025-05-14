module("modules.logic.fight.model.FightViewTechniqueModel", package.seeall)

local var_0_0 = class("FightViewTechniqueModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._all = nil
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._all = nil
end

function var_0_0.initFromSimpleProperty(arg_3_0)
	if arg_3_0._all then
		return
	end

	arg_3_0._all = BaseModel.New()

	local var_3_0 = PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.FightTechnique)
	local var_3_1 = FightStrUtil.instance:getSplitString2Cache(var_3_0 or "", true, "|", "#")

	if not var_3_1 then
		return
	end

	local var_3_2 = {}

	for iter_3_0, iter_3_1 in ipairs(var_3_1) do
		for iter_3_2, iter_3_3 in ipairs(iter_3_1) do
			if lua_fight_technique.configDict[iter_3_3] then
				local var_3_3 = {
					id = iter_3_3
				}

				arg_3_0._all:addAtLast(var_3_3)

				if iter_3_0 == 2 then
					table.insert(var_3_2, var_3_3)
				end
			end
		end
	end

	arg_3_0:addList(var_3_2)
end

function var_0_0.addUnread(arg_4_0, arg_4_1)
	if arg_4_0._all:getById(arg_4_1) then
		return
	end

	local var_4_0 = {
		id = arg_4_1
	}

	arg_4_0._all:addAtLast(var_4_0)
	arg_4_0:addAtLast(var_4_0)

	return var_4_0
end

function var_0_0.markRead(arg_5_0, arg_5_1)
	if not arg_5_0._all:getById(arg_5_1) or not arg_5_0:getById(arg_5_1) then
		return
	end

	local var_5_0 = arg_5_0:getById(arg_5_1)

	arg_5_0:remove(var_5_0)

	return var_5_0
end

function var_0_0.getPropertyStr(arg_6_0)
	local var_6_0 = {}
	local var_6_1 = {}
	local var_6_2 = arg_6_0._all:getList()

	for iter_6_0, iter_6_1 in ipairs(var_6_2) do
		if arg_6_0:getById(iter_6_1.id) then
			table.insert(var_6_1, iter_6_1.id)
		else
			table.insert(var_6_0, iter_6_1.id)
		end
	end

	return string.format("%s|%s", table.concat(var_6_0, "#"), table.concat(var_6_1, "#"))
end

function var_0_0.getAll(arg_7_0)
	if arg_7_0._all then
		return arg_7_0._all:getList()
	end
end

function var_0_0.isUnlock(arg_8_0, arg_8_1)
	if arg_8_0._all then
		for iter_8_0, iter_8_1 in ipairs(arg_8_0._all:getList()) do
			if iter_8_1.id == arg_8_1 then
				return true
			end
		end
	end

	return nil
end

function var_0_0.readTechnique(arg_9_0, arg_9_1)
	if arg_9_1 and arg_9_0:markRead(arg_9_1) then
		local var_9_0 = arg_9_0:getPropertyStr()

		PlayerRpc.instance:sendSetSimplePropertyRequest(PlayerEnum.SimpleProperty.FightTechnique, var_9_0)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
