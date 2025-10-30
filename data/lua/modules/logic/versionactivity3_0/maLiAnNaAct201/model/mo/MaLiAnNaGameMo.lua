module("modules.logic.versionactivity3_0.maLiAnNaAct201.model.mo.MaLiAnNaGameMo", package.seeall)

local var_0_0 = class("MaLiAnNaGameMo", MaLiAnNaLaLevelMo)

function var_0_0.create(arg_1_0)
	local var_1_0 = var_0_0.New()

	var_1_0.id = arg_1_0

	return var_1_0
end

function var_0_0._initSlot(arg_2_0, arg_2_1)
	if arg_2_1.slots ~= nil then
		for iter_2_0, iter_2_1 in pairs(arg_2_1.slots) do
			local var_2_0 = MaLiAnNaGameSlotMo.create(iter_2_1)

			arg_2_0.slots[iter_2_1.id] = var_2_0
		end
	end
end

function var_0_0._initRoad(arg_3_0, arg_3_1)
	if arg_3_1.roads ~= nil then
		for iter_3_0, iter_3_1 in pairs(arg_3_1.roads) do
			local var_3_0 = MaLiAnNaLaLevelMoRoad.create(iter_3_1.id, iter_3_1._roadType)

			var_3_0:updatePos(iter_3_1.beginPosX, iter_3_1.beginPosY, iter_3_1.endPosX, iter_3_1.endPosY)
			var_3_0:updateSlot(iter_3_1._beginSlotId, iter_3_1._endSlotId)
			table.insert(arg_3_0.roads, var_3_0)
		end
	end

	arg_3_0:_initRoadGraph()
end

function var_0_0.update(arg_4_0, arg_4_1)
	if arg_4_0.slots ~= nil then
		for iter_4_0, iter_4_1 in pairs(arg_4_0.slots) do
			if iter_4_1 ~= nil then
				iter_4_1:update(arg_4_1)
			end
		end
	end
end

function var_0_0._initRoadGraph(arg_5_0)
	if arg_5_0._roadGraph == nil then
		arg_5_0._roadGraph = {}
	end

	for iter_5_0 = 1, #arg_5_0.roads do
		local var_5_0 = arg_5_0.roads[iter_5_0]

		if var_5_0._beginSlotId ~= 0 and var_5_0._endSlotId ~= 0 then
			if arg_5_0._roadGraph[var_5_0._beginSlotId] == nil then
				arg_5_0._roadGraph[var_5_0._beginSlotId] = {}
			end

			if arg_5_0._roadGraph[var_5_0._endSlotId] == nil then
				arg_5_0._roadGraph[var_5_0._endSlotId] = {}
			end

			table.insert(arg_5_0._roadGraph[var_5_0._beginSlotId], var_5_0._endSlotId)
			table.insert(arg_5_0._roadGraph[var_5_0._endSlotId], var_5_0._beginSlotId)
		end
	end
end

function var_0_0.getRoadGraph(arg_6_0)
	return arg_6_0._roadGraph
end

function var_0_0.getAllSlot(arg_7_0)
	return arg_7_0.slots
end

function var_0_0.getAllRoad(arg_8_0)
	return arg_8_0.roads
end

function var_0_0.getSlotById(arg_9_0, arg_9_1)
	if arg_9_0.slots == nil then
		return nil
	end

	return arg_9_0.slots[arg_9_1]
end

function var_0_0.getSlotByConfigId(arg_10_0, arg_10_1)
	if arg_10_0.slots == nil then
		return nil
	end

	for iter_10_0, iter_10_1 in pairs(arg_10_0.slots) do
		if iter_10_1.configId == arg_10_1 then
			return iter_10_1
		end
	end

	return nil
end

function var_0_0.haveRoad(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0.roads == nil then
		return false
	end

	for iter_11_0, iter_11_1 in pairs(arg_11_0.roads) do
		if iter_11_1:haveSlot(arg_11_1, arg_11_2) then
			return true
		end
	end

	return false
end

function var_0_0.destroy(arg_12_0)
	if arg_12_0.slots ~= nil then
		for iter_12_0, iter_12_1 in pairs(arg_12_0.slots) do
			if iter_12_1 then
				iter_12_1:destroy()
			end
		end

		arg_12_0.slots = nil
	end
end

return var_0_0
