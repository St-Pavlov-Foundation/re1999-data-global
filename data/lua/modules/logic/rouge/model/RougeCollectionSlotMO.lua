module("modules.logic.rouge.model.RougeCollectionSlotMO", package.seeall)

local var_0_0 = pureTable("RougeCollectionSlotMO", RougeCollectionMO)
local var_0_1 = class("RougeCollectionSlotMO", RougeCollectionMO)

function var_0_1.init(arg_1_0, arg_1_1)
	var_0_1.super.init(arg_1_0, arg_1_1.item)
	arg_1_0:updateRotation(arg_1_1.rotation)
	arg_1_0:updateBaseEffects(arg_1_1.baseEffects)
	arg_1_0:updateEffectRelations(arg_1_1.relations)

	local var_1_0 = arg_1_1.pos and Vector2(tonumber(arg_1_1.pos.col), tonumber(arg_1_1.pos.row)) or Vector2(0, 0)

	arg_1_0:updateLeftTopPos(var_1_0)
	arg_1_0:updateAttrValues(arg_1_1.attr)
end

function var_0_1.updateInfo(arg_2_0, arg_2_1)
	arg_2_0:initBaseInfo(arg_2_1)
end

function var_0_1.getCenterSlotPos(arg_3_0)
	return arg_3_0.centerSlotPos
end

function var_0_1.getLeftTopPos(arg_4_0)
	return arg_4_0.pos or Vector2(0, 0)
end

function var_0_1.getRotation(arg_5_0)
	return arg_5_0.rotation or RougeEnum.CollectionRotation.Rotation_0
end

function var_0_1.updateLeftTopPos(arg_6_0, arg_6_1)
	arg_6_0.pos = arg_6_1 or Vector2.zero
	arg_6_0.centerSlotPos = RougeCollectionHelper.getCollectionCenterSlotPos(arg_6_0.cfgId, arg_6_0.rotation, arg_6_0.pos)
end

function var_0_1.updateRotation(arg_7_0, arg_7_1)
	arg_7_0.rotation = arg_7_1 or RougeEnum.CollectionRotation.Rotation_0

	if arg_7_0.centerSlotPos then
		local var_7_0 = RougeCollectionHelper.getCollectionTopLeftSlotPos(arg_7_0.cfgId, arg_7_0.centerSlotPos, arg_7_0.rotation)

		arg_7_0:updateLeftTopPos(var_7_0)
	end
end

function var_0_1.copyOtherMO(arg_8_0, arg_8_1)
	if not arg_8_1 then
		return
	end

	arg_8_0:copyOtherCollectionMO(arg_8_1)

	arg_8_0.centerSlotPos = arg_8_1.getCenterSlotPos and arg_8_1:getCenterSlotPos() or Vector2.zero
	arg_8_0.pos = arg_8_1.getLeftTopPos and arg_8_1:getLeftTopPos() or Vector2.zero
	arg_8_0.rotation = arg_8_1:getRotation()
end

function var_0_1.updateBaseEffects(arg_9_0, arg_9_1)
	arg_9_0.baseEffects = {}

	if arg_9_1 then
		for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
			table.insert(arg_9_0.baseEffects, iter_9_1)
		end
	end
end

function var_0_1.getBaseEffects(arg_10_0)
	return arg_10_0.baseEffects
end

function var_0_1.getBaseEffectCount(arg_11_0)
	return arg_11_0.baseEffects and #arg_11_0.baseEffects
end

function var_0_1.updateEffectRelations(arg_12_0, arg_12_1)
	arg_12_0.effectRelations = {}
	arg_12_0.effectRelationMap = {}

	if arg_12_1 then
		for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
			local var_12_0 = RougeCollectionRelationMO.New()

			var_12_0:init(iter_12_1)
			table.insert(arg_12_0.effectRelations, var_12_0)

			local var_12_1 = var_12_0.showType

			arg_12_0.effectRelationMap[var_12_1] = arg_12_0.effectRelationMap[var_12_1] or {}

			table.insert(arg_12_0.effectRelationMap[var_12_1], var_12_0)
		end
	end
end

function var_0_1.getEffectShowTypeRelations(arg_13_0, arg_13_1)
	return arg_13_0.effectRelationMap and arg_13_0.effectRelationMap[arg_13_1]
end

function var_0_1.isEffectActive(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getEffectShowTypeRelations(arg_14_1)

	if var_14_0 then
		for iter_14_0, iter_14_1 in ipairs(var_14_0) do
			local var_14_1 = tabletool.indexOf(arg_14_0.baseEffects, iter_14_1.effectIndex)

			if var_14_1 and var_14_1 > 0 then
				return true
			end
		end
	end

	return false
end

function var_0_1.reset(arg_15_0)
	arg_15_0.id = 0
	arg_15_0.rotation = RougeEnum.CollectionRotation.Rotation_0
end

return var_0_1
