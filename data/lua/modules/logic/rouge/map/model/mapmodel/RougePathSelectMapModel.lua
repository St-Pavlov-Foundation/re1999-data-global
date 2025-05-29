module("modules.logic.rouge.map.model.mapmodel.RougePathSelectMapModel", package.seeall)

local var_0_0 = class("RougePathSelectMapModel")

function var_0_0.initMap(arg_1_0, arg_1_1)
	arg_1_0.layerId = arg_1_1.layerId
	arg_1_0.layerCo = lua_rouge_layer.configDict[arg_1_0.layerId]
	arg_1_0.middleLayerId = arg_1_1.middleLayerId
	arg_1_0.middleLayerCo = lua_rouge_middle_layer.configDict[arg_1_0.middleLayerId]

	arg_1_0:initPieceInfo(arg_1_1.pieceInfo)
	arg_1_0:initNextLayerList()
	arg_1_0:initPathSelectCo()
	arg_1_0:initLayerChoiceInfo(arg_1_1.layerChoiceInfo)
end

function var_0_0.initPieceInfo(arg_2_0, arg_2_1)
	arg_2_0.pieceDict = {}
	arg_2_0.pieceList = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_0 = RougePieceInfoMO.New()

		var_2_0:init(iter_2_1)

		arg_2_0.pieceDict[var_2_0.index] = var_2_0

		table.insert(arg_2_0.pieceList, var_2_0)
	end
end

function var_0_0.initPathSelectCo(arg_3_0)
	local var_3_0 = RougeMapConfig.instance:getPathSelectList(arg_3_0.middleLayerId)

	if #var_3_0 == 1 then
		arg_3_0.pathSelectId = var_3_0[1]
		arg_3_0.pathSelectCo = lua_rouge_path_select.configDict[arg_3_0.pathSelectId]

		return
	end

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.allLayerList) do
		if arg_3_0.selectLayerId == iter_3_1 then
			arg_3_0.pathSelectId = var_3_0[iter_3_0]
			arg_3_0.pathSelectCo = lua_rouge_path_select.configDict[arg_3_0.pathSelectId]

			return
		end
	end

	logError("路线选择层 一个可以选择的路线都没找到, 间隙层id : " .. tostring(arg_3_0.middleLayerId))
end

function var_0_0.updateMapInfo(arg_4_0, arg_4_1)
	arg_4_0:initLayerChoiceInfo(arg_4_1.layerChoiceInfo)
end

function var_0_0.updateSimpleMapInfo(arg_5_0, arg_5_1)
	arg_5_0:updateMapInfo(arg_5_1)
end

function var_0_0.initNextLayerList(arg_6_0)
	local var_6_0 = RougeMapConfig.instance:getNextLayerList(arg_6_0.middleLayerId)

	if not var_6_0 then
		arg_6_0.nextLayerList = nil
		arg_6_0.selectLayerId = nil

		return
	end

	arg_6_0.nextLayerList = {}
	arg_6_0.allLayerList = {}

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		local var_6_1 = lua_rouge_layer.configDict[iter_6_1]

		if RougeMapUnlockHelper.checkIsUnlock(var_6_1.unlockType, var_6_1.unlockParam) then
			arg_6_0.selectLayerId = iter_6_1

			table.insert(arg_6_0.nextLayerList, iter_6_1)
		end

		table.insert(arg_6_0.allLayerList, iter_6_1)
	end
end

function var_0_0.updateSelectLayerId(arg_7_0, arg_7_1)
	if arg_7_0.selectLayerId == arg_7_1 then
		return
	end

	arg_7_0.selectLayerId = arg_7_1

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectLayerChange, arg_7_0.selectLayerId)
end

function var_0_0.getSelectLayerId(arg_8_0)
	return arg_8_0.selectLayerId
end

function var_0_0.getPieceList(arg_9_0)
	return arg_9_0.pieceList
end

function var_0_0.getNextLayerList(arg_10_0)
	return arg_10_0.nextLayerList
end

function var_0_0.initLayerChoiceInfo(arg_11_0, arg_11_1)
	arg_11_0._layerChoiceInfoMap = {}

	if arg_11_1 then
		arg_11_0._layerChoiceInfoMap = GameUtil.rpcInfosToMap(arg_11_1, RougeLayerChoiceInfoMO, "layerId")
	end
end

function var_0_0.getLayerChoiceInfo(arg_12_0, arg_12_1)
	return arg_12_0._layerChoiceInfoMap and arg_12_0._layerChoiceInfoMap[arg_12_1]
end

function var_0_0.clear(arg_13_0)
	arg_13_0.layerId = nil
	arg_13_0.layerCo = nil
	arg_13_0.middleLayerId = nil
	arg_13_0.middleCo = nil
	arg_13_0.pieceDict = nil
	arg_13_0.pieceList = nil
end

return var_0_0
