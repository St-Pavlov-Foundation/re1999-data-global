module("modules.logic.necrologiststory.model.NecrologistStoryGameBaseMO", package.seeall)

local var_0_0 = class("NecrologistStoryGameBaseMO")

function var_0_0.ctor(arg_1_0)
	arg_1_0.id = nil
	arg_1_0.data = nil
	arg_1_0.dataIsDirty = false
	arg_1_0.isAutoSave = true
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1
	arg_2_0.plotInfoDict = {}

	arg_2_0:onInit()
end

function var_0_0.updateInfo(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.info

	arg_3_0.data = string.nilorempty(var_3_0) and {} or cjson.decode(var_3_0)
	arg_3_0.plotInfoDict = {}

	for iter_3_0 = 1, #arg_3_1.plotInfos do
		local var_3_1 = arg_3_1.plotInfos[iter_3_0]

		arg_3_0:updatePlotInfo(var_3_1)
	end

	arg_3_0:onUpdateData()

	arg_3_0.dataIsDirty = false
end

function var_0_0.getPlotInfo(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0.plotInfoDict[arg_4_1]

	if not var_4_0 and arg_4_2 then
		var_4_0 = NecrologistStoryPlotMO.New()

		var_4_0:init(arg_4_1)

		arg_4_0.plotInfoDict[arg_4_1] = var_4_0
	end

	return var_4_0
end

function var_0_0.updatePlotInfo(arg_5_0, arg_5_1)
	arg_5_0:getPlotInfo(arg_5_1.id, true):updateInfo(arg_5_1)
end

function var_0_0.getData(arg_6_0)
	return arg_6_0.data
end

function var_0_0.saveData(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_0.dataIsDirty then
		if arg_7_1 then
			arg_7_1(arg_7_2)
		end

		return
	end

	arg_7_0:onSaveData()
	NecrologistStoryRpc.instance:sendUpdateNecrologistStoryRequest(arg_7_0.id, arg_7_0, arg_7_1, arg_7_2)
end

function var_0_0.setDataDirty(arg_8_0)
	arg_8_0.dataIsDirty = true

	if arg_8_0.isAutoSave then
		arg_8_0:saveData()
	end
end

function var_0_0.getStoryState(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getPlotInfo(arg_9_1)
	local var_9_1 = var_9_0 and var_9_0:getState()

	if var_9_1 == nil then
		local var_9_2 = NecrologistStoryV3A1Config.instance:getStoryConfig(arg_9_1)

		if var_9_2.preId == 0 then
			var_9_1 = NecrologistStoryEnum.StoryState.Normal
		else
			local var_9_3 = arg_9_0:getPlotInfo(var_9_2.preId)

			if (var_9_3 and var_9_3:getState()) == NecrologistStoryEnum.StoryState.Finish then
				var_9_1 = NecrologistStoryEnum.StoryState.Normal
			else
				var_9_1 = NecrologistStoryEnum.StoryState.Lock
			end
		end
	end

	return var_9_1
end

function var_0_0.isStoryFinish(arg_10_0, arg_10_1)
	return arg_10_0:getStoryState(arg_10_1) == NecrologistStoryEnum.StoryState.Finish
end

function var_0_0.setStoryState(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0:getStoryState(arg_11_1) == arg_11_2 then
		return
	end

	arg_11_0:getPlotInfo(arg_11_1, true):setState(arg_11_2)
	arg_11_0:onStoryStateChange(arg_11_1, arg_11_2)

	if arg_11_2 == NecrologistStoryEnum.StoryState.Finish then
		HeroStoryRpc.instance:sendHeroStoryPlotFinishRequest(arg_11_1)
	end

	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnStoryStateChange, arg_11_1)
	arg_11_0:setDataDirty()
end

function var_0_0.getPlotSituationTab(arg_12_0)
	local var_12_0 = {}

	setmetatable(var_12_0, {
		__index = function(arg_13_0, arg_13_1)
			return 0
		end
	})

	for iter_12_0, iter_12_1 in pairs(arg_12_0.plotInfoDict) do
		for iter_12_2, iter_12_3 in pairs(iter_12_1:getSituationValueTab()) do
			var_12_0[iter_12_2] = var_12_0[iter_12_2] + iter_12_3
		end
	end

	return var_12_0
end

function var_0_0.setPlotSituationTab(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0:getPlotInfo(arg_14_1, true):setSituationValueTab(arg_14_2)
	arg_14_0:setDataDirty()
end

function var_0_0.toString(arg_15_0)
	return (cjson.encode(arg_15_0.data))
end

function var_0_0.onInit(arg_16_0)
	return
end

function var_0_0.onUpdateData(arg_17_0)
	return
end

function var_0_0.onSaveData(arg_18_0)
	return
end

function var_0_0.onStoryStateChange(arg_19_0, arg_19_1, arg_19_2)
	return
end

function var_0_0.setNecrologistStoryRequest(arg_20_0, arg_20_1)
	arg_20_1.info = arg_20_0:toString()

	for iter_20_0, iter_20_1 in pairs(arg_20_0.plotInfoDict) do
		table.insert(arg_20_1.plotInfos, iter_20_1:getSaveData())
	end
end

return var_0_0
