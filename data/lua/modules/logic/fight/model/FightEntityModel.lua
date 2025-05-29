module("modules.logic.fight.model.FightEntityModel", package.seeall)

local var_0_0 = class("FightEntityModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._mySideModel = BaseModel.New()
	arg_1_0._mySideSubModel = BaseModel.New()
	arg_1_0._mySideDeadModel = BaseModel.New()
	arg_1_0._mySideSpModel = BaseModel.New()
	arg_1_0._enemySideModel = FightEnemySideModel.New()
	arg_1_0._enemySideSubModel = BaseModel.New()
	arg_1_0._enemySideDeadModel = BaseModel.New()
	arg_1_0._enemySideSpModel = BaseModel.New()
end

function var_0_0.clear(arg_2_0)
	var_0_0.super.clear(arg_2_0)
	arg_2_0._mySideModel:clear()
	arg_2_0._mySideSubModel:clear()
	arg_2_0._mySideDeadModel:clear()
	arg_2_0._mySideSpModel:clear()
	arg_2_0._enemySideModel:clear()
	arg_2_0._enemySideSubModel:clear()
	arg_2_0._enemySideDeadModel:clear()
	arg_2_0._enemySideSpModel:clear()
end

function var_0_0.clearExistEntitys(arg_3_0)
	var_0_0.super.clear(arg_3_0)
	arg_3_0._mySideModel:clear()
	arg_3_0._mySideSubModel:clear()
	arg_3_0._mySideSpModel:clear()
	arg_3_0._enemySideModel:clear()
	arg_3_0._enemySideSubModel:clear()
	arg_3_0._enemySideSpModel:clear()
end

function var_0_0.clientTestSetEntity(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_1 == FightEnum.EntitySide.MySide then
		arg_4_0._mySideModel:setList(arg_4_2)
		arg_4_0._mySideSubModel:setList(arg_4_3)
	else
		arg_4_0._enemySideModel:setList(arg_4_2)
		arg_4_0._enemySideSubModel:setList(arg_4_3)
	end

	arg_4_0:addList(arg_4_2)
	arg_4_0:addList(arg_4_3)
end

function var_0_0.setMySide(arg_5_0, arg_5_1)
	arg_5_0:_setEntityMOList(arg_5_0._mySideModel, arg_5_1.entitys, FightEnum.EntitySide.MySide)
	arg_5_0:_setEntityMOList(arg_5_0._mySideSubModel, arg_5_1.subEntitys, FightEnum.EntitySide.MySide)
	arg_5_0:_setEntityMOList(arg_5_0._mySideSpModel, arg_5_1.spEntitys, FightEnum.EntitySide.MySide)
end

function var_0_0.setEnemySide(arg_6_0, arg_6_1)
	arg_6_0:_setEntityMOList(arg_6_0._enemySideModel, arg_6_1.entitys, FightEnum.EntitySide.EnemySide)
	arg_6_0:_setEntityMOList(arg_6_0._enemySideSubModel, arg_6_1.subEntitys, FightEnum.EntitySide.EnemySide)
	arg_6_0:_setEntityMOList(arg_6_0._enemySideSpModel, arg_6_1.spEntitys, FightEnum.EntitySide.EnemySide)
end

function var_0_0._setEntityMOList(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_1:getList()

	for iter_7_0, iter_7_1 in ipairs(arg_7_2) do
		local var_7_1 = var_7_0[iter_7_0]

		if not var_7_1 then
			var_7_1 = FightEntityMO.New()

			table.insert(var_7_0, var_7_1)
		end

		var_7_1:init(iter_7_1, arg_7_3)
	end

	for iter_7_2 = #arg_7_2 + 1, #var_7_0 do
		var_7_0[iter_7_2] = nil
	end

	arg_7_1:setList(var_7_0)
	arg_7_0:addList(arg_7_1:getList())

	for iter_7_3, iter_7_4 in ipairs(arg_7_2) do
		if iter_7_4.currentHp <= 0 then
			arg_7_0:onDead(iter_7_4.uid)
		end
	end
end

function var_0_0.onDead(arg_8_0, arg_8_1)
	arg_8_0:_checkDeadModel(arg_8_1, arg_8_0._mySideModel, arg_8_0._mySideDeadModel)
	arg_8_0:_checkDeadModel(arg_8_1, arg_8_0._mySideSpModel, arg_8_0._mySideDeadModel)
	arg_8_0:_checkDeadModel(arg_8_1, arg_8_0._enemySideModel, arg_8_0._enemySideDeadModel)
	arg_8_0:_checkDeadModel(arg_8_1, arg_8_0._enemySideSpModel, arg_8_0._enemySideDeadModel)
end

function var_0_0._checkDeadModel(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_2:getById(arg_9_1)

	if var_9_0 then
		arg_9_2:remove(var_9_0)

		if not arg_9_3:getById(arg_9_1) then
			arg_9_3:addAtLast(var_9_0)
		end

		arg_9_0:remove(var_9_0)
	end
end

function var_0_0.replaceEntityMO(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1.id
	local var_10_1 = arg_10_0:removeEntityById(var_10_0) or arg_10_0:getModel(arg_10_1.side)

	if not var_10_1 then
		return
	end

	var_10_1:addAtLast(arg_10_1)
	arg_10_0:addAtLast(arg_10_1)
	FightController.instance:dispatchEvent(FightEvent.ReplaceEntityMO, arg_10_1)
end

function var_0_0.addEntityMO(arg_11_0, arg_11_1)
	arg_11_0:removeEntityById(arg_11_1.id)

	local var_11_0 = arg_11_0:getModel(arg_11_1.side)

	if var_11_0 then
		var_11_0:addAtLast(arg_11_1)
		arg_11_0:addAtLast(arg_11_1)
	end
end

function var_0_0.removeEntityById(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._mySideModel:getById(arg_12_1)

	if var_12_0 then
		arg_12_0._mySideModel:remove(var_12_0)
		arg_12_0:remove(var_12_0)

		return arg_12_0._mySideModel
	end

	local var_12_1 = arg_12_0._mySideSubModel:getById(arg_12_1)

	if var_12_1 then
		arg_12_0._mySideSubModel:remove(var_12_1)
		arg_12_0:remove(var_12_1)

		return arg_12_0._mySideSubModel
	end

	local var_12_2 = arg_12_0._mySideSpModel:getById(arg_12_1)

	if var_12_2 then
		arg_12_0._mySideSpModel:remove(var_12_2)
		arg_12_0:remove(var_12_2)

		return arg_12_0._mySideSpModel
	end

	local var_12_3 = arg_12_0._enemySideModel:getById(arg_12_1)

	if var_12_3 then
		arg_12_0._enemySideModel:remove(var_12_3)
		arg_12_0:remove(var_12_3)

		return arg_12_0._enemySideModel
	end

	local var_12_4 = arg_12_0._enemySideSubModel:getById(arg_12_1)

	if var_12_4 then
		arg_12_0._enemySideSubModel:remove(var_12_4)
		arg_12_0:remove(var_12_4)

		return arg_12_0._enemySideSubModel
	end

	local var_12_5 = arg_12_0._enemySideSpModel:getById(arg_12_1)

	if var_12_5 then
		arg_12_0._enemySideSpModel:remove(var_12_5)
		arg_12_0:remove(var_12_5)

		return arg_12_0._enemySideSpModel
	end
end

function var_0_0.getModel(arg_13_0, arg_13_1)
	return arg_13_1 == FightEnum.EntitySide.MySide and arg_13_0._mySideModel or arg_13_0._enemySideModel
end

function var_0_0.getSubModel(arg_14_0, arg_14_1)
	return arg_14_1 == FightEnum.EntitySide.MySide and arg_14_0._mySideSubModel or arg_14_0._enemySideSubModel
end

function var_0_0.getSpModel(arg_15_0, arg_15_1)
	return arg_15_1 == FightEnum.EntitySide.MySide and arg_15_0._mySideSpModel or arg_15_0._enemySideSpModel
end

function var_0_0.getDeadModel(arg_16_0, arg_16_1)
	return arg_16_1 == FightEnum.EntitySide.MySide and arg_16_0._mySideDeadModel or arg_16_0._enemySideDeadModel
end

function var_0_0.getMySideModel(arg_17_0)
	return arg_17_0._mySideModel
end

function var_0_0.getEnemySideModel(arg_18_0)
	return arg_18_0._enemySideModel
end

function var_0_0.getMySideList(arg_19_0)
	return arg_19_0._mySideModel:getList()
end

function var_0_0.getEnemySideList(arg_20_0)
	return arg_20_0._enemySideModel:getList()
end

function var_0_0.getMySideDeadListLength(arg_21_0)
	return #arg_21_0._mySideDeadModel:getList()
end

function var_0_0.getByPosId(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0:getModel(arg_22_1):getList()

	for iter_22_0, iter_22_1 in ipairs(var_22_0) do
		if iter_22_1.position == arg_22_2 then
			return iter_22_1
		end
	end

	local var_22_1 = arg_22_0:getSubModel(arg_22_1):getList()

	for iter_22_2, iter_22_3 in ipairs(var_22_1) do
		if iter_22_3.position == arg_22_2 then
			return iter_22_3
		end
	end
end

function var_0_0.isSub(arg_23_0, arg_23_1)
	if arg_23_0._mySideSubModel:getById(arg_23_1) then
		return true
	end

	return arg_23_0._enemySideSubModel:getById(arg_23_1) and true or false
end

function var_0_0.getDeadById(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0._mySideDeadModel:getById(arg_24_1)

	if var_24_0 then
		return var_24_0
	end

	return (arg_24_0._enemySideDeadModel:getById(arg_24_1))
end

function var_0_0.addDeadUid(arg_25_0, arg_25_1)
	arg_25_0.deadUids = arg_25_0.deadUids or {}
	arg_25_0.deadUids[arg_25_1] = true
end

function var_0_0.isDeadUid(arg_26_0, arg_26_1)
	return arg_26_0.deadUids and arg_26_0.deadUids[arg_26_1]
end

function var_0_0.clearDeadUids(arg_27_0)
	arg_27_0.deadUids = {}
end

function var_0_0.sortSubEntityList(arg_28_0, arg_28_1)
	return arg_28_0.position > arg_28_1.position
end

var_0_0.instance = var_0_0.New()

var_0_0.instance:onInit()
setmetatable(var_0_0.instance, {
	__index = function(arg_29_0, arg_29_1)
		logError("FightEntityModel 已废弃。新的entity数据管理为 FightEntityDataMgr ,访问数据请用 FightDataHelper.entityMgr ,如果疑问或需要支持联系左皓文")

		return var_0_0[arg_29_1]
	end
})

return var_0_0
