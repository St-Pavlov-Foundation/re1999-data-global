module("modules.logic.rouge.map.model.rpcmo.RougeEpisodeMO", package.seeall)

slot0 = pureTable("RougeEpisodeMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1
	slot0.nodeMoList = {}
	slot0.isEnd = false
end

function slot0.setIsEnd(slot0, slot1)
	slot0.isEnd = slot1
end

function slot0.addNode(slot0, slot1)
	table.insert(slot0.nodeMoList, slot1)
end

function slot0.getNodeMoList(slot0)
	return slot0.nodeMoList
end

function slot0.updateNodeArriveStatus(slot0)
	if slot0.id == 1 then
		slot0.nodeMoList[1].arriveStatus = slot0.nodeMoList[1] ~= RougeMapModel.instance:getCurNode() and RougeMapEnum.Arrive.Arrived or RougeMapEnum.Arrive.ArrivingFinish

		return
	end

	if slot0:getArrivedNode() then
		for slot6, slot7 in ipairs(slot0.nodeMoList) do
			if slot7 ~= slot2 then
				slot7.arriveStatus = RougeMapEnum.Arrive.CantArrive
			elseif slot1 ~= slot7 then
				slot7.arriveStatus = RougeMapEnum.Arrive.Arrived
			elseif slot7:getEventState() == RougeMapEnum.EventState.Finish then
				slot7.arriveStatus = RougeMapEnum.Arrive.ArrivingFinish
			else
				slot7.arriveStatus = RougeMapEnum.Arrive.ArrivingNotFinish
			end
		end

		return
	end

	for slot6, slot7 in ipairs(slot0.nodeMoList) do
		if slot0:checkPreNodeHadStartOrArrivingFinish(slot7.preNodeList) then
			slot7.arriveStatus = RougeMapEnum.Arrive.CanArrive
		elseif slot0:checkPreNodeEveryIsCantArrive(slot8) then
			slot7.arriveStatus = RougeMapEnum.Arrive.CantArrive
		else
			slot7.arriveStatus = RougeMapEnum.Arrive.NotArrive
		end
	end
end

function slot0.checkPreNodeHadStartOrArrivingFinish(slot0, slot1)
	if not slot1 then
		return false
	end

	for slot5, slot6 in ipairs(slot1) do
		if RougeMapModel.instance:getNode(slot6).arriveStatus == RougeMapEnum.Arrive.ArrivingFinish then
			return true
		end
	end
end

function slot0.checkPreNodeEveryIsCantArrive(slot0, slot1)
	if not slot1 then
		return true
	end

	for slot5, slot6 in ipairs(slot1) do
		if RougeMapModel.instance:getNode(slot6).arriveStatus ~= RougeMapEnum.Arrive.CantArrive then
			return false
		end
	end

	return true
end

function slot0.getArrivedNode(slot0)
	if RougeMapModel.instance:getCurEpisodeId() < slot0.id then
		return nil
	end

	for slot4, slot5 in ipairs(slot0.nodeMoList) do
		if slot5.pathWay then
			return slot5
		end
	end
end

function slot0.sortNode(slot0)
	slot4 = uv0._sortFunc

	table.sort(slot0.nodeMoList, slot4)

	for slot4, slot5 in ipairs(slot0.nodeMoList) do
		slot5:setIndex(slot4)
	end
end

function slot0._sortFunc(slot0, slot1)
	return slot0.nodeId < slot1.nodeId
end

return slot0
