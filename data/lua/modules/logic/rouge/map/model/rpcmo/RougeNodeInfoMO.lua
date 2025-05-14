module("modules.logic.rouge.map.model.rpcmo.RougeNodeInfoMO", package.seeall)

local var_0_0 = pureTable("RougeNodeInfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.layer = arg_1_1.layer
	arg_1_0.episodeId = RougeMapHelper.getEpisodeIndex(arg_1_1.stage)
	arg_1_0.nodeId = arg_1_1.nodeId
	arg_1_0.preNodeList = {}
	arg_1_0.nextNodeList = {}

	arg_1_0:updateIdList(arg_1_0.preNodeList, arg_1_1.lastNodeList)
	arg_1_0:updateIdList(arg_1_0.nextNodeList, arg_1_1.nextNodeList)
	arg_1_0:initEvent(arg_1_1)

	arg_1_0.pathWay = arg_1_1.pathWay
	arg_1_0.arriveStatus = RougeMapEnum.Arrive.CantArrive
	arg_1_0.interactive9drop = arg_1_1.interactive9drop
	arg_1_0.interactive10drop = arg_1_1.interactive10drop
	arg_1_0.interactive14drop = arg_1_1.interactive14drop
	arg_1_0.fog = arg_1_1.fog
end

function var_0_0.updateNodeType(arg_2_0)
	if not arg_2_0.eventId or arg_2_0.eventId == 0 then
		arg_2_0.nodeType = RougeMapEnum.NodeType.Start
	else
		arg_2_0.nodeType = RougeMapEnum.NodeType.Normal
	end
end

function var_0_0.updateIdList(arg_3_0, arg_3_1, arg_3_2)
	for iter_3_0, iter_3_1 in ipairs(arg_3_2) do
		table.insert(arg_3_1, iter_3_1)
	end
end

function var_0_0.setIndex(arg_4_0, arg_4_1)
	arg_4_0.index = arg_4_1
end

function var_0_0.initEnd(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_0.nodeType = RougeMapEnum.NodeType.End
	arg_5_0.layer = arg_5_1
	arg_5_0.episodeId = arg_5_2
	arg_5_0.nodeId = arg_5_3
	arg_5_0.preNodeList = arg_5_4
	arg_5_0.pathWay = false
	arg_5_0.arriveStatus = RougeMapEnum.Arrive.NotArrive
	arg_5_0.fog = arg_5_0:checkIsEndFog()
end

function var_0_0.checkIsEndFog(arg_6_0)
	if arg_6_0.preNodeList then
		for iter_6_0, iter_6_1 in ipairs(arg_6_0.preNodeList) do
			local var_6_0 = RougeMapModel.instance:getNode(iter_6_1)

			if var_6_0 and not var_6_0.fog then
				return false
			end
		end

		return true
	end
end

function var_0_0.setPos(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.x = arg_7_1
	arg_7_0.y = arg_7_2
	arg_7_0.z = arg_7_3
end

function var_0_0.getEpisodePos(arg_8_0)
	return arg_8_0.x, arg_8_0.y, arg_8_0.z
end

function var_0_0.updateInfo(arg_9_0, arg_9_1)
	arg_9_0.pathWay = arg_9_1.pathWay
	arg_9_0.fog = arg_9_1.fog

	tabletool.clear(arg_9_0.preNodeList)
	tabletool.clear(arg_9_0.nextNodeList)
	arg_9_0:updateIdList(arg_9_0.preNodeList, arg_9_1.lastNodeList)
	arg_9_0:updateIdList(arg_9_0.nextNodeList, arg_9_1.nextNodeList)

	if arg_9_0.eventId ~= arg_9_1.eventId then
		local var_9_0 = arg_9_0.eventId

		arg_9_0:initEvent(arg_9_1)
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onNodeEventChange, var_9_0, arg_9_0.eventId)
	elseif not arg_9_0:checkIsStart() then
		arg_9_0.eventMo:update(arg_9_0.eventCo, arg_9_1.eventData)
	end
end

function var_0_0.initEvent(arg_10_0, arg_10_1)
	arg_10_0.eventId = arg_10_1.eventId

	arg_10_0:updateNodeType()

	if not arg_10_0:checkIsStart() then
		arg_10_0.eventCo = RougeMapConfig.instance:getRougeEvent(arg_10_0.eventId)
		arg_10_0.eventMo = (RougeMapEnum.EventType2Cls[arg_10_0.eventCo.type] or RougeBaseEventMO).New()

		arg_10_0.eventMo:init(arg_10_0.eventCo, arg_10_1.eventData)
	end
end

function var_0_0.eventIsChange(arg_11_0)
	return arg_11_0.preEventId ~= nil
end

function var_0_0.checkIsStart(arg_12_0)
	return arg_12_0.nodeType == RougeMapEnum.NodeType.Start
end

function var_0_0.checkIsEnd(arg_13_0)
	return arg_13_0.nodeType == RougeMapEnum.NodeType.End
end

function var_0_0.checkIsNormal(arg_14_0)
	return arg_14_0.nodeType == RougeMapEnum.NodeType.Normal
end

function var_0_0.getEventCo(arg_15_0)
	return arg_15_0.eventCo
end

function var_0_0.getEventState(arg_16_0)
	return arg_16_0.eventMo and arg_16_0.eventMo.state
end

function var_0_0.isFinishEvent(arg_17_0)
	return arg_17_0:getEventState() == RougeMapEnum.EventState.Finish
end

function var_0_0.isStartedEvent(arg_18_0)
	return arg_18_0:getEventState() == RougeMapEnum.EventState.Start
end

function var_0_0.__tostring(arg_19_0)
	return string.format("nodeType : %s, layerId : %s, episodeId : %s, nodeId : %s, PreNode : %s, NextNode : %s, eventMo : %s, arriveStatus : %s", arg_19_0.nodeType, arg_19_0.layer, arg_19_0.episodeId, arg_19_0.nodeId, table.concat(arg_19_0.preNodeList, ";"), arg_19_0.nextNodeList and table.concat(arg_19_0.nextNodeList, ";") or "nil", tostring(arg_19_0.eventMo), arg_19_0.arriveStatus)
end

return var_0_0
