module("modules.logic.rouge.map.model.mapmodel.RougeLayerMapModel", package.seeall)

local var_0_0 = class("RougeLayerMapModel")

function var_0_0.initMap(arg_1_0, arg_1_1)
	arg_1_0.layerId = arg_1_1.layerId
	arg_1_0.layerCo = lua_rouge_layer.configDict[arg_1_0.layerId]
	arg_1_0.curEpisodeId = RougeMapHelper.getEpisodeIndex(arg_1_1.curStage)
	arg_1_0.curNodeId = arg_1_1.curNode

	arg_1_0:initNodeInfo(arg_1_1.nodeInfo)
	arg_1_0:initLayerChoiceInfo(arg_1_1.layerChoiceInfo)
end

function var_0_0.updateMapInfo(arg_2_0, arg_2_1)
	arg_2_0.curEpisodeId = RougeMapHelper.getEpisodeIndex(arg_2_1.curStage)
	arg_2_0.curNodeId = arg_2_1.curNode

	arg_2_0:updateNodeInfo(arg_2_1.nodeInfo)
	arg_2_0:updateLayerChoiceInfo(arg_2_1.layerChoiceInfo)
end

function var_0_0.updateSimpleMapInfo(arg_3_0, arg_3_1)
	arg_3_0:updateMapInfo(arg_3_1)
end

function var_0_0.initNodeInfo(arg_4_0, arg_4_1)
	arg_4_0.episodeList = {}
	arg_4_0.nodeDict = {}

	local var_4_0 = 0
	local var_4_1 = 0
	local var_4_2 = 0

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		local var_4_3 = RougeMapHelper.getEpisodeIndex(iter_4_1.stage)

		if var_4_1 < var_4_3 then
			var_4_1 = var_4_3
		end

		if var_4_2 < iter_4_1.nodeId then
			var_4_2 = iter_4_1.nodeId
		end

		local var_4_4 = arg_4_0.episodeList[var_4_3]

		if not var_4_4 then
			var_4_4 = RougeEpisodeMO.New()

			var_4_4:init(var_4_3)
			table.insert(arg_4_0.episodeList, var_4_4)

			var_4_0 = 0
		end

		var_4_0 = var_4_0 + 1

		local var_4_5 = RougeNodeInfoMO.New()

		var_4_5:init(iter_4_1)
		var_4_4:addNode(var_4_5)

		arg_4_0.nodeDict[var_4_5.nodeId] = var_4_5
	end

	local var_4_6 = var_4_1 + 1

	arg_4_0.endNodeId = var_4_2 + 1

	local var_4_7 = {}
	local var_4_8 = arg_4_0.episodeList[var_4_1]

	for iter_4_2, iter_4_3 in ipairs(var_4_8:getNodeMoList()) do
		table.insert(var_4_7, iter_4_3.nodeId)
	end

	local var_4_9 = RougeEpisodeMO.New()

	var_4_9:init(var_4_6)
	var_4_9:setIsEnd(true)

	local var_4_10 = RougeNodeInfoMO.New()

	var_4_9:addNode(var_4_10)
	var_4_10:initEnd(arg_4_0.layerId, var_4_6, arg_4_0.endNodeId, var_4_7)
	table.insert(arg_4_0.episodeList, var_4_9)

	arg_4_0.nodeDict[arg_4_0.endNodeId] = var_4_10

	for iter_4_4, iter_4_5 in ipairs(arg_4_0.episodeList) do
		iter_4_5:sortNode()
		iter_4_5:updateNodeArriveStatus()
	end

	arg_4_0:initNodeFogInfo()
end

function var_0_0.updateNodeInfo(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		local var_5_0 = arg_5_0.nodeDict[iter_5_1.nodeId]

		if not var_5_0 then
			logError("update node info fail, not found nodeId : " .. tostring(iter_5_1.nodeId))
		else
			var_5_0:updateInfo(iter_5_1)
		end
	end

	local var_5_1 = arg_5_0:getNode(arg_5_0.endNodeId)

	if var_5_1 then
		var_5_1.fog = var_5_1:checkIsEndFog()
	end

	for iter_5_2, iter_5_3 in ipairs(arg_5_0.episodeList) do
		iter_5_3:sortNode()
		iter_5_3:updateNodeArriveStatus()
	end

	arg_5_0:initNodeFogInfo()
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onNodeArriveStatusChange)
end

function var_0_0.getEpisodeList(arg_6_0)
	return arg_6_0.episodeList
end

function var_0_0.getCurEpisodeId(arg_7_0)
	return arg_7_0.curEpisodeId
end

function var_0_0.getCurNode(arg_8_0)
	return arg_8_0:getNode(arg_8_0.curNodeId)
end

function var_0_0.getNodeDict(arg_9_0)
	return arg_9_0.nodeDict
end

function var_0_0.getNode(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.nodeDict[arg_10_1]

	if not var_10_0 then
		logError("not found nodeId : " .. tostring(arg_10_1))

		return nil
	end

	return var_10_0
end

function var_0_0.getEndNodeId(arg_11_0)
	return arg_11_0.endNodeId
end

function var_0_0.initNodeFogInfo(arg_12_0)
	arg_12_0._fogNodeList = {}
	arg_12_0._holeNodeList = {}
	arg_12_0._fogNodeMap = {}
	arg_12_0._holeNodeMap = {}

	local var_12_0 = false

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.episodeList or {}) do
		local var_12_1 = iter_12_1:getNodeMoList()
		local var_12_2 = {}

		for iter_12_2, iter_12_3 in ipairs(var_12_1 or {}) do
			if iter_12_3.fog then
				var_12_0 = true
				arg_12_0._fogNodeMap[iter_12_3.nodeId] = iter_12_3

				table.insert(arg_12_0._fogNodeList, iter_12_3)
			else
				table.insert(var_12_2, iter_12_3)
			end
		end

		for iter_12_4, iter_12_5 in ipairs(var_12_2) do
			if var_12_0 then
				arg_12_0._holeNodeMap[iter_12_5.nodeId] = iter_12_5

				table.insert(arg_12_0._holeNodeList, iter_12_5)
			end
		end
	end
end

function var_0_0.getFogNodeList(arg_13_0)
	return arg_13_0._fogNodeList
end

function var_0_0.getHoleNodeList(arg_14_0)
	return arg_14_0._holeNodeList
end

function var_0_0.isHoleNode(arg_15_0, arg_15_1)
	return arg_15_0._holeNodeMap and arg_15_0._holeNodeMap[arg_15_1] ~= nil
end

function var_0_0.initLayerChoiceInfo(arg_16_0, arg_16_1)
	arg_16_0.layerChoiceInfo = RougeLayerChoiceInfoMO.New()

	arg_16_0.layerChoiceInfo:init(arg_16_1)
end

function var_0_0.updateLayerChoiceInfo(arg_17_0, arg_17_1)
	if not arg_17_0.layerChoiceInfo then
		arg_17_0.layerChoiceInfo = RougeLayerChoiceInfoMO.New()
	end

	arg_17_0.layerChoiceInfo:init(arg_17_1)
end

function var_0_0.getLayerChoiceInfo(arg_18_0, arg_18_1)
	if arg_18_0.layerId == arg_18_1 then
		return arg_18_0.layerChoiceInfo
	end
end

function var_0_0.clear(arg_19_0)
	arg_19_0.episodeList = nil
	arg_19_0.nodeDict = nil
	arg_19_0.layerId = nil
	arg_19_0.layerCo = nil
	arg_19_0.curEpisodeId = nil
	arg_19_0.curNodeId = nil
end

return var_0_0
