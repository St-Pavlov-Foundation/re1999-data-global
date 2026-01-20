-- chunkname: @modules/logic/rouge2/map/model/rpcmo/Rouge2_EpisodeMO.lua

module("modules.logic.rouge2.map.model.rpcmo.Rouge2_EpisodeMO", package.seeall)

local Rouge2_EpisodeMO = pureTable("Rouge2_EpisodeMO")

function Rouge2_EpisodeMO:init(id)
	self.id = id
	self.nodeMoList = {}
	self.isEnd = false
end

function Rouge2_EpisodeMO:setIsEnd(isEnd)
	self.isEnd = isEnd
end

function Rouge2_EpisodeMO:addNode(nodeMo)
	table.insert(self.nodeMoList, nodeMo)
end

function Rouge2_EpisodeMO:getNodeMoList()
	return self.nodeMoList
end

function Rouge2_EpisodeMO:updateNodeArriveStatus()
	local curNode = Rouge2_MapModel.instance:getCurNode()

	if self.id == 1 then
		local isArrived = self.nodeMoList[1] ~= curNode

		self.nodeMoList[1].arriveStatus = isArrived and Rouge2_MapEnum.Arrive.Arrived or Rouge2_MapEnum.Arrive.ArrivingFinish

		return
	end

	local arrivedNode = self:getArrivedNode()

	if arrivedNode then
		for _, nodeMo in ipairs(self.nodeMoList) do
			if nodeMo ~= arrivedNode then
				nodeMo.arriveStatus = Rouge2_MapEnum.Arrive.CantArrive
			elseif curNode ~= nodeMo then
				nodeMo.arriveStatus = Rouge2_MapEnum.Arrive.Arrived
			elseif nodeMo:getEventState() == Rouge2_MapEnum.EventState.Finish then
				nodeMo.arriveStatus = Rouge2_MapEnum.Arrive.ArrivingFinish
			else
				nodeMo.arriveStatus = Rouge2_MapEnum.Arrive.ArrivingNotFinish
			end
		end

		return
	end

	for _, nodeMo in ipairs(self.nodeMoList) do
		local preNodeList = nodeMo.preNodeList

		if self:checkPreNodeHadStartOrArrivingFinish(preNodeList) then
			nodeMo.arriveStatus = Rouge2_MapEnum.Arrive.CanArrive
		elseif self:checkPreNodeEveryIsCantArrive(preNodeList) then
			nodeMo.arriveStatus = Rouge2_MapEnum.Arrive.CantArrive
		else
			nodeMo.arriveStatus = Rouge2_MapEnum.Arrive.NotArrive
		end
	end
end

function Rouge2_EpisodeMO:checkPreNodeHadStartOrArrivingFinish(preNodeList)
	if not preNodeList then
		return false
	end

	for _, preNodeId in ipairs(preNodeList) do
		local preNode = Rouge2_MapModel.instance:getNode(preNodeId)

		if preNode.arriveStatus == Rouge2_MapEnum.Arrive.ArrivingFinish then
			return true
		end
	end
end

function Rouge2_EpisodeMO:checkPreNodeEveryIsCantArrive(preNodeList)
	if not preNodeList then
		return true
	end

	for _, preNodeId in ipairs(preNodeList) do
		local preNode = Rouge2_MapModel.instance:getNode(preNodeId)

		if preNode.arriveStatus ~= Rouge2_MapEnum.Arrive.CantArrive then
			return false
		end
	end

	return true
end

function Rouge2_EpisodeMO:getArrivedNode()
	if self.id > Rouge2_MapModel.instance:getCurEpisodeId() then
		return nil
	end

	for _, nodeMo in ipairs(self.nodeMoList) do
		if nodeMo.pathWay then
			return nodeMo
		end
	end
end

function Rouge2_EpisodeMO:sortNode()
	table.sort(self.nodeMoList, Rouge2_EpisodeMO._sortFunc)

	for index, nodeMo in ipairs(self.nodeMoList) do
		nodeMo:setIndex(index)
	end
end

function Rouge2_EpisodeMO._sortFunc(a, b)
	return a.nodeId < b.nodeId
end

return Rouge2_EpisodeMO
