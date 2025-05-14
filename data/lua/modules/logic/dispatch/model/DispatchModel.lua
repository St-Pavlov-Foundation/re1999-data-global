module("modules.logic.dispatch.model.DispatchModel", package.seeall)

local var_0_0 = class("DispatchModel", BaseModel)

local function var_0_1(arg_1_0)
	arg_1_0 = arg_1_0 or {}

	local var_1_0 = {
		elementId = arg_1_0.elementId,
		dispatchId = arg_1_0.dispatchId,
		endTime = arg_1_0.endTime
	}
	local var_1_1 = {}

	if arg_1_0.heroIds then
		for iter_1_0, iter_1_1 in ipairs(arg_1_0.heroIds) do
			var_1_1[#var_1_1 + 1] = iter_1_1
		end
	end

	var_1_0.heroIdList = var_1_1

	return var_1_0
end

function var_0_0.onInit(arg_2_0)
	arg_2_0.dispatchedHeroDict = {}
	arg_2_0.needCheckDispatchInfoList = {}
end

function var_0_0.reInit(arg_3_0)
	arg_3_0:onInit()
end

function var_0_0.initDispatchInfos(arg_4_0, arg_4_1)
	arg_4_0:clear()

	if not arg_4_1 then
		return
	end

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		local var_4_0 = DispatchInfoMo.New()
		local var_4_1 = var_0_1(iter_4_1)

		var_4_0:init(var_4_1)
		arg_4_0:addAtLast(var_4_0)

		if var_4_0:isRunning() then
			for iter_4_2, iter_4_3 in ipairs(var_4_0.heroIdList) do
				arg_4_0.dispatchedHeroDict[iter_4_3] = true
			end

			table.insert(arg_4_0.needCheckDispatchInfoList, var_4_0)
		end
	end
end

function var_0_0.addDispatch(arg_5_0, arg_5_1)
	if not arg_5_1 then
		return
	end

	local var_5_0 = var_0_1(arg_5_1)
	local var_5_1 = var_5_0.elementId
	local var_5_2 = arg_5_0:getDispatchMo(var_5_1)

	if var_5_2 then
		var_5_2:updateMO(var_5_0)
	else
		var_5_2 = DispatchInfoMo.New()

		var_5_2:init(var_5_0)
		arg_5_0:addAtLast(var_5_2)
	end

	if var_5_2:isRunning() then
		for iter_5_0, iter_5_1 in ipairs(var_5_0.heroIdList) do
			arg_5_0.dispatchedHeroDict[iter_5_1] = true
		end

		table.insert(arg_5_0.needCheckDispatchInfoList, var_5_2)
	end

	local var_5_3 = var_5_0.dispatchId

	DispatchController.instance:dispatchEvent(DispatchEvent.AddDispatchInfo, var_5_3)
end

function var_0_0.removeDispatch(arg_6_0, arg_6_1)
	if not arg_6_1 then
		return
	end

	local var_6_0 = arg_6_1.elementId
	local var_6_1 = arg_6_0:getDispatchMo(var_6_0)

	if var_6_1 then
		for iter_6_0, iter_6_1 in ipairs(var_6_1.heroIdList) do
			arg_6_0.dispatchedHeroDict[iter_6_1] = nil
		end

		tabletool.removeValue(arg_6_0.needCheckDispatchInfoList, var_6_1)
		arg_6_0:remove(var_6_1)
	end

	local var_6_2 = var_6_1.dispatchId

	DispatchController.instance:dispatchEvent(DispatchEvent.RemoveDispatchInfo, var_6_2)
end

function var_0_0.getDispatchMo(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0

	if not arg_7_1 then
		return var_7_0
	end

	local var_7_1 = arg_7_0:getById(arg_7_1)

	if var_7_1 then
		local var_7_2 = var_7_1:getDispatchId()

		if not arg_7_2 or arg_7_2 == var_7_2 then
			var_7_0 = var_7_1
		else
			logError(string.format("DispatchModel.getDispatchMo error, dispatchId not equal,%s %s", arg_7_2, var_7_2))
		end
	end

	return var_7_0
end

function var_0_0.getDispatchMoByDispatchId(arg_8_0, arg_8_1)
	return
end

function var_0_0.getDispatchStatus(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0:getDispatchMo(arg_9_1, arg_9_2)
	local var_9_1 = DispatchEnum.DispatchStatus.NotDispatch

	if var_9_0 then
		var_9_1 = var_9_0:isFinish() and DispatchEnum.DispatchStatus.Finished or DispatchEnum.DispatchStatus.Dispatching
	end

	return var_9_1
end

function var_0_0.getDispatchTime(arg_10_0, arg_10_1)
	local var_10_0 = string.format("%02d : %02d : %02d", 0, 0, 0)
	local var_10_1 = DungeonConfig.instance:getElementDispatchId(arg_10_1)

	if arg_10_1 and var_10_1 then
		local var_10_2 = arg_10_0:getDispatchMo(arg_10_1, var_10_1)

		if var_10_2 then
			var_10_0 = var_10_2:getRemainTimeStr()
		end
	end

	return var_10_0
end

function var_0_0.isDispatched(arg_11_0, arg_11_1)
	return arg_11_0.dispatchedHeroDict and arg_11_0.dispatchedHeroDict[arg_11_1]
end

function var_0_0.checkDispatchFinish(arg_12_0)
	local var_12_0 = arg_12_0.needCheckDispatchInfoList and #arg_12_0.needCheckDispatchInfoList or 0

	if var_12_0 <= 0 then
		return
	end

	local var_12_1 = false

	for iter_12_0 = var_12_0, 1, -1 do
		local var_12_2 = arg_12_0.needCheckDispatchInfoList[iter_12_0]

		if var_12_2:isFinish() then
			var_12_1 = true

			for iter_12_1, iter_12_2 in ipairs(var_12_2.heroIdList) do
				arg_12_0.dispatchedHeroDict[iter_12_2] = nil
			end

			table.remove(arg_12_0.needCheckDispatchInfoList, iter_12_0)
		end
	end

	if var_12_1 then
		DispatchController.instance:dispatchEvent(DispatchEvent.OnDispatchFinish)
		RedDotRpc.instance:sendGetRedDotInfosRequest({
			RedDotEnum.DotNode.V1a8FactoryMapDispatchFinish
		})
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
