module("modules.logic.explore.model.mo.unit.ExploreBaseUnitMO", package.seeall)

local var_0_0 = pureTable("ExploreBaseUnitMO")
local var_0_1 = {
	x = 0,
	y = 0
}

function var_0_0.init(arg_1_0, arg_1_1)
	local var_1_0

	if arg_1_0.nodePos and (arg_1_0.nodePos.x ~= arg_1_1[ExploreUnitMoFieldEnum.nodePos][1] or arg_1_0.nodePos.y ~= arg_1_1[ExploreUnitMoFieldEnum.nodePos][2]) then
		var_0_1.x = arg_1_0.nodePos.x
		var_0_1.y = arg_1_0.nodePos.y
		var_1_0 = var_0_1
	end

	arg_1_0.hasInteract = false

	for iter_1_0, iter_1_1 in pairs(ExploreUnitMoFieldEnum) do
		arg_1_0[iter_1_0] = arg_1_1[iter_1_1] or arg_1_1[iter_1_1] == nil and arg_1_0[iter_1_0]
	end

	arg_1_0.nodePos.x = arg_1_0.nodePos[1]
	arg_1_0.nodePos.y = arg_1_0.nodePos[2]
	arg_1_0.enterTriggerType = false
	arg_1_0.defaultWalkable = arg_1_0.defaultWalkable ~= false
	arg_1_0.triggerEffects = arg_1_0.triggerEffects or {}
	arg_1_0.doneEffects = arg_1_0.doneEffects or {}
	arg_1_0.unitDir = arg_1_0.unitDir or 0
	arg_1_0.specialDatas = arg_1_0.specialDatas or {
		1,
		1
	}
	arg_1_0.offsetSize = arg_1_0.offsetSize or {
		0,
		0,
		0,
		0
	}
	arg_1_0.resRotation = arg_1_0.resRotation or {
		0,
		0,
		0
	}
	arg_1_0.resPosition = arg_1_0.resPosition or {
		0,
		0,
		0
	}
	arg_1_0.customIconType = nil

	for iter_1_2, iter_1_3 in pairs(arg_1_0.triggerEffects) do
		if iter_1_3[1] == ExploreEnum.TriggerEvent.ChangeIcon then
			arg_1_0.customIconType = iter_1_3[2]
		end
	end

	arg_1_0:initTypeData()

	arg_1_0.triggerEffectsCount = #arg_1_0.triggerEffects + 1

	if ExploreModel.instance:hasInteractInfo(arg_1_0.id) == false then
		arg_1_0:setStatus(tonumber(arg_1_0.interact) or 0)
	else
		local var_1_1 = arg_1_0:getInteractInfoMO()

		arg_1_0.unitDir = var_1_1.dir
		arg_1_0.nodePos.x = var_1_1.posx
		arg_1_0.nodePos.y = var_1_1.posy
	end

	if arg_1_0._hasInit ~= true then
		arg_1_0:buildTriggerExData()
	end

	arg_1_0._hasInit = true

	if var_1_0 then
		arg_1_0:_updateNodeOpenKey(var_1_0, arg_1_0.nodePos)
	end
end

function var_0_0.initTypeData(arg_2_0)
	return
end

function var_0_0.updateNO(arg_3_0)
	return
end

function var_0_0.activeStateChange(arg_4_0, arg_4_1)
	if not arg_4_0._countSource then
		return
	end

	for iter_4_0, iter_4_1 in pairs(arg_4_0._countSource) do
		if arg_4_1 then
			ExploreCounterModel.instance:add(iter_4_1, arg_4_0.id)
		else
			ExploreCounterModel.instance:reduce(iter_4_1, arg_4_0.id)
		end
	end
end

function var_0_0.buildTriggerExData(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.triggerEffects) do
		if iter_5_1[1] == ExploreEnum.TriggerEvent.Counter then
			if not arg_5_0._countSource then
				arg_5_0._countSource = {}
			end

			local var_5_0 = tostring(iter_5_1[2])
			local var_5_1 = string.splitToNumber(var_5_0, "#") or {}

			table.insert(arg_5_0._countSource, var_5_1[1])
			ExploreCounterModel.instance:addCountSource(var_5_1[1], arg_5_0.id)
		end
	end
end

function var_0_0.onEnterScene(arg_6_0)
	local var_6_0 = Vector2.New(arg_6_0.nodePos.x, arg_6_0.nodePos.y)

	arg_6_0:updatePos(var_6_0)
	ExploreMapModel.instance:addUnitMO(arg_6_0)
end

function var_0_0.onRemoveScene(arg_7_0)
	if arg_7_0:isWalkable() == false then
		local var_7_0 = ExploreHelper.getKey(arg_7_0.nodePos)

		ExploreMapModel.instance:updateNodeOpenKey(var_7_0, arg_7_0.id, true)
	end

	ExploreMapModel.instance:removeUnit(arg_7_0.id)
end

function var_0_0.getTriggerPos(arg_8_0)
	if arg_8_0.triggerDir == ExploreEnum.TriggerDir.Left then
		return {
			x = arg_8_0.nodePos.x - 1,
			y = arg_8_0.nodePos.y
		}
	elseif arg_8_0.triggerDir == ExploreEnum.TriggerDir.Right then
		return {
			x = arg_8_0.nodePos.x + 1,
			y = arg_8_0.nodePos.y
		}
	elseif arg_8_0.triggerDir == ExploreEnum.TriggerDir.Up then
		return {
			x = arg_8_0.nodePos.x,
			y = arg_8_0.nodePos.y + 1
		}
	elseif arg_8_0.triggerDir == ExploreEnum.TriggerDir.Down then
		return {
			x = arg_8_0.nodePos.x,
			y = arg_8_0.nodePos.y - 1
		}
	end

	return arg_8_0.nodePos
end

function var_0_0.canTrigger(arg_9_0, arg_9_1)
	if arg_9_0.triggerDir == ExploreEnum.TriggerDir.Left then
		return arg_9_1.x == arg_9_0.nodePos.x - 1 and arg_9_1.y == arg_9_0.nodePos.y
	elseif arg_9_0.triggerDir == ExploreEnum.TriggerDir.Right then
		return arg_9_1.x == arg_9_0.nodePos.x + 1 and arg_9_1.y == arg_9_0.nodePos.y
	elseif arg_9_0.triggerDir == ExploreEnum.TriggerDir.Up then
		return arg_9_1.x == arg_9_0.nodePos.x and arg_9_1.y == arg_9_0.nodePos.y + 1
	elseif arg_9_0.triggerDir == ExploreEnum.TriggerDir.Down then
		return arg_9_1.x == arg_9_0.nodePos.x and arg_9_1.y == arg_9_0.nodePos.y - 1
	end

	return true
end

function var_0_0.updatePos(arg_10_0, arg_10_1)
	arg_10_0.nodeKey = ExploreHelper.getKey(arg_10_1)

	arg_10_0:_updateNodeOpenKey(arg_10_0.nodePos, arg_10_1)
	arg_10_0:onPosChange(arg_10_0.nodePos, arg_10_1)

	arg_10_0.nodePos.x = arg_10_1.x
	arg_10_0.nodePos.y = arg_10_1.y
end

function var_0_0.removeFromNode(arg_11_0)
	arg_11_0:_updateNodeOpenKey(arg_11_0.nodePos)
	arg_11_0:onPosChange(arg_11_0.nodePos)
end

function var_0_0.setNodeOpenKey(arg_12_0, arg_12_1)
	ExploreMapModel.instance:updateNodeOpenKey(arg_12_0.nodeKey, arg_12_0.id, arg_12_1, true)
end

function var_0_0._updateNodeOpenKey(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_0:isWalkable() == false then
		if arg_13_1 then
			for iter_13_0 = arg_13_0.offsetSize[1], arg_13_0.offsetSize[3] do
				for iter_13_1 = arg_13_0.offsetSize[2], arg_13_0.offsetSize[4] do
					local var_13_0 = ExploreHelper.getKeyXY(arg_13_1.x + iter_13_0, arg_13_1.y + iter_13_1)

					ExploreMapModel.instance:updateNodeOpenKey(var_13_0, arg_13_0.id, true)
				end
			end
		end

		if arg_13_2 then
			for iter_13_2 = arg_13_0.offsetSize[1], arg_13_0.offsetSize[3] do
				for iter_13_3 = arg_13_0.offsetSize[2], arg_13_0.offsetSize[4] do
					local var_13_1 = ExploreHelper.getKeyXY(arg_13_2.x + iter_13_2, arg_13_2.y + iter_13_3)

					ExploreMapModel.instance:updateNodeOpenKey(var_13_1, arg_13_0.id, false)
				end
			end
		end
	end
end

function var_0_0.getConfigId(arg_14_0)
	return arg_14_0.config.configId
end

function var_0_0.isWalkable(arg_15_0)
	return arg_15_0.defaultWalkable
end

function var_0_0.setStatus(arg_16_0, arg_16_1)
	arg_16_0:getInteractInfoMO():updateStatus(arg_16_1)
end

function var_0_0.getStatus(arg_17_0)
	return arg_17_0:getInteractInfoMO().status
end

function var_0_0.isEnter(arg_18_0)
	return arg_18_0:getInteractInfoMO():getBitByIndex(ExploreEnum.InteractIndex.IsEnter) == 1
end

function var_0_0.setEnter(arg_19_0, arg_19_1)
	if arg_19_1 then
		arg_19_0:onEnterScene()
	else
		arg_19_0:onRemoveScene()
	end

	return arg_19_0:getInteractInfoMO():setBitByIndex(ExploreEnum.InteractIndex.IsEnter, arg_19_1 and 1 or 0)
end

function var_0_0.isInteractEnabled(arg_20_0)
	return arg_20_0:getInteractInfoMO():getBitByIndex(ExploreEnum.InteractIndex.InteractEnabled) == 1
end

function var_0_0.getInteractInfoMO(arg_21_0)
	return ExploreModel.instance:getInteractInfo(arg_21_0.id)
end

function var_0_0.isInteractDone(arg_22_0)
	return true
end

function var_0_0.isInteractActiveState(arg_23_0)
	return arg_23_0:getInteractInfoMO():getBitByIndex(ExploreEnum.InteractIndex.ActiveState) == 1
end

function var_0_0.isInteractFinishState(arg_24_0)
	return arg_24_0:getInteractInfoMO():getBitByIndex(ExploreEnum.InteractIndex.IsFinish) == 1
end

function var_0_0.onPosChange(arg_25_0, arg_25_1, arg_25_2)
	return
end

local var_0_2 = {}

function var_0_0.getUnitClass(arg_26_0)
	local var_26_0 = ExploreEnum.ItemTypeToName[arg_26_0.type]

	if not var_0_2[var_26_0] then
		local var_26_1 = _G[string.format("Explore%sUnit", var_26_0)] or _G[string.format("Explore%s", var_26_0)] or ExploreBaseMoveUnit

		var_0_2[var_26_0] = var_26_1
	end

	return var_0_2[var_26_0]
end

return var_0_0
