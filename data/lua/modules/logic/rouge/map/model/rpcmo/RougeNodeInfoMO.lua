module("modules.logic.rouge.map.model.rpcmo.RougeNodeInfoMO", package.seeall)

slot0 = pureTable("RougeNodeInfoMO")

function slot0.init(slot0, slot1)
	slot0.layer = slot1.layer
	slot0.episodeId = RougeMapHelper.getEpisodeIndex(slot1.stage)
	slot0.nodeId = slot1.nodeId
	slot0.preNodeList = {}
	slot0.nextNodeList = {}

	slot0:updateIdList(slot0.preNodeList, slot1.lastNodeList)
	slot0:updateIdList(slot0.nextNodeList, slot1.nextNodeList)
	slot0:initEvent(slot1)

	slot0.pathWay = slot1.pathWay
	slot0.arriveStatus = RougeMapEnum.Arrive.CantArrive
	slot0.interactive9drop = slot1.interactive9drop
	slot0.interactive10drop = slot1.interactive10drop
	slot0.interactive14drop = slot1.interactive14drop
	slot0.fog = slot1.fog
end

function slot0.updateNodeType(slot0)
	if not slot0.eventId or slot0.eventId == 0 then
		slot0.nodeType = RougeMapEnum.NodeType.Start
	else
		slot0.nodeType = RougeMapEnum.NodeType.Normal
	end
end

function slot0.updateIdList(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot2) do
		table.insert(slot1, slot7)
	end
end

function slot0.setIndex(slot0, slot1)
	slot0.index = slot1
end

function slot0.initEnd(slot0, slot1, slot2, slot3, slot4)
	slot0.nodeType = RougeMapEnum.NodeType.End
	slot0.layer = slot1
	slot0.episodeId = slot2
	slot0.nodeId = slot3
	slot0.preNodeList = slot4
	slot0.pathWay = false
	slot0.arriveStatus = RougeMapEnum.Arrive.NotArrive
	slot0.fog = slot0:checkIsEndFog()
end

function slot0.checkIsEndFog(slot0)
	if slot0.preNodeList then
		for slot4, slot5 in ipairs(slot0.preNodeList) do
			if RougeMapModel.instance:getNode(slot5) and not slot6.fog then
				return false
			end
		end

		return true
	end
end

function slot0.setPos(slot0, slot1, slot2, slot3)
	slot0.x = slot1
	slot0.y = slot2
	slot0.z = slot3
end

function slot0.getEpisodePos(slot0)
	return slot0.x, slot0.y, slot0.z
end

function slot0.updateInfo(slot0, slot1)
	slot0.pathWay = slot1.pathWay
	slot0.fog = slot1.fog

	tabletool.clear(slot0.preNodeList)
	tabletool.clear(slot0.nextNodeList)
	slot0:updateIdList(slot0.preNodeList, slot1.lastNodeList)
	slot0:updateIdList(slot0.nextNodeList, slot1.nextNodeList)

	if slot0.eventId ~= slot1.eventId then
		slot0:initEvent(slot1)
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onNodeEventChange, slot0.eventId, slot0.eventId)
	elseif not slot0:checkIsStart() then
		slot0.eventMo:update(slot0.eventCo, slot1.eventData)
	end
end

function slot0.initEvent(slot0, slot1)
	slot0.eventId = slot1.eventId

	slot0:updateNodeType()

	if not slot0:checkIsStart() then
		slot0.eventCo = RougeMapConfig.instance:getRougeEvent(slot0.eventId)
		slot0.eventMo = (RougeMapEnum.EventType2Cls[slot0.eventCo.type] or RougeBaseEventMO).New()

		slot0.eventMo:init(slot0.eventCo, slot1.eventData)
	end
end

function slot0.eventIsChange(slot0)
	return slot0.preEventId ~= nil
end

function slot0.checkIsStart(slot0)
	return slot0.nodeType == RougeMapEnum.NodeType.Start
end

function slot0.checkIsEnd(slot0)
	return slot0.nodeType == RougeMapEnum.NodeType.End
end

function slot0.checkIsNormal(slot0)
	return slot0.nodeType == RougeMapEnum.NodeType.Normal
end

function slot0.getEventCo(slot0)
	return slot0.eventCo
end

function slot0.getEventState(slot0)
	return slot0.eventMo and slot0.eventMo.state
end

function slot0.isFinishEvent(slot0)
	return slot0:getEventState() == RougeMapEnum.EventState.Finish
end

function slot0.isStartedEvent(slot0)
	return slot0:getEventState() == RougeMapEnum.EventState.Start
end

function slot0.__tostring(slot0)
	return string.format("nodeType : %s, layerId : %s, episodeId : %s, nodeId : %s, PreNode : %s, NextNode : %s, eventMo : %s, arriveStatus : %s", slot0.nodeType, slot0.layer, slot0.episodeId, slot0.nodeId, table.concat(slot0.preNodeList, ";"), slot0.nextNodeList and table.concat(slot0.nextNodeList, ";") or "nil", tostring(slot0.eventMo), slot0.arriveStatus)
end

return slot0
