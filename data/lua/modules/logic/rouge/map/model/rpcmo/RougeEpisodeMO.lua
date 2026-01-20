-- chunkname: @modules/logic/rouge/map/model/rpcmo/RougeEpisodeMO.lua

module("modules.logic.rouge.map.model.rpcmo.RougeEpisodeMO", package.seeall)

local RougeEpisodeMO = pureTable("RougeEpisodeMO")

function RougeEpisodeMO:init(id)
	self.id = id
	self.nodeMoList = {}
	self.isEnd = false
end

function RougeEpisodeMO:setIsEnd(isEnd)
	self.isEnd = isEnd
end

function RougeEpisodeMO:addNode(nodeMo)
	table.insert(self.nodeMoList, nodeMo)
end

function RougeEpisodeMO:getNodeMoList()
	return self.nodeMoList
end

function RougeEpisodeMO:updateNodeArriveStatus()
	local curNode = RougeMapModel.instance:getCurNode()

	if self.id == 1 then
		local isArrived = self.nodeMoList[1] ~= curNode

		self.nodeMoList[1].arriveStatus = isArrived and RougeMapEnum.Arrive.Arrived or RougeMapEnum.Arrive.ArrivingFinish

		return
	end

	local arrivedNode = self:getArrivedNode()

	if arrivedNode then
		for _, nodeMo in ipairs(self.nodeMoList) do
			if nodeMo ~= arrivedNode then
				nodeMo.arriveStatus = RougeMapEnum.Arrive.CantArrive
			elseif curNode ~= nodeMo then
				nodeMo.arriveStatus = RougeMapEnum.Arrive.Arrived
			elseif nodeMo:getEventState() == RougeMapEnum.EventState.Finish then
				nodeMo.arriveStatus = RougeMapEnum.Arrive.ArrivingFinish
			else
				nodeMo.arriveStatus = RougeMapEnum.Arrive.ArrivingNotFinish
			end
		end

		return
	end

	for _, nodeMo in ipairs(self.nodeMoList) do
		local preNodeList = nodeMo.preNodeList

		if self:checkPreNodeHadStartOrArrivingFinish(preNodeList) then
			nodeMo.arriveStatus = RougeMapEnum.Arrive.CanArrive
		elseif self:checkPreNodeEveryIsCantArrive(preNodeList) then
			nodeMo.arriveStatus = RougeMapEnum.Arrive.CantArrive
		else
			nodeMo.arriveStatus = RougeMapEnum.Arrive.NotArrive
		end
	end
end

function RougeEpisodeMO:checkPreNodeHadStartOrArrivingFinish(preNodeList)
	if not preNodeList then
		return false
	end

	for _, preNodeId in ipairs(preNodeList) do
		local preNode = RougeMapModel.instance:getNode(preNodeId)

		if preNode.arriveStatus == RougeMapEnum.Arrive.ArrivingFinish then
			return true
		end
	end
end

function RougeEpisodeMO:checkPreNodeEveryIsCantArrive(preNodeList)
	if not preNodeList then
		return true
	end

	for _, preNodeId in ipairs(preNodeList) do
		local preNode = RougeMapModel.instance:getNode(preNodeId)

		if preNode.arriveStatus ~= RougeMapEnum.Arrive.CantArrive then
			return false
		end
	end

	return true
end

function RougeEpisodeMO:getArrivedNode()
	if self.id > RougeMapModel.instance:getCurEpisodeId() then
		return nil
	end

	for _, nodeMo in ipairs(self.nodeMoList) do
		if nodeMo.pathWay then
			return nodeMo
		end
	end
end

function RougeEpisodeMO:sortNode()
	table.sort(self.nodeMoList, RougeEpisodeMO._sortFunc)

	for index, nodeMo in ipairs(self.nodeMoList) do
		nodeMo:setIndex(index)
	end
end

function RougeEpisodeMO._sortFunc(a, b)
	return a.nodeId < b.nodeId
end

return RougeEpisodeMO
