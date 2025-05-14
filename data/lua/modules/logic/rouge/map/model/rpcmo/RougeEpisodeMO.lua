module("modules.logic.rouge.map.model.rpcmo.RougeEpisodeMO", package.seeall)

local var_0_0 = pureTable("RougeEpisodeMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.nodeMoList = {}
	arg_1_0.isEnd = false
end

function var_0_0.setIsEnd(arg_2_0, arg_2_1)
	arg_2_0.isEnd = arg_2_1
end

function var_0_0.addNode(arg_3_0, arg_3_1)
	table.insert(arg_3_0.nodeMoList, arg_3_1)
end

function var_0_0.getNodeMoList(arg_4_0)
	return arg_4_0.nodeMoList
end

function var_0_0.updateNodeArriveStatus(arg_5_0)
	local var_5_0 = RougeMapModel.instance:getCurNode()

	if arg_5_0.id == 1 then
		local var_5_1 = arg_5_0.nodeMoList[1] ~= var_5_0

		arg_5_0.nodeMoList[1].arriveStatus = var_5_1 and RougeMapEnum.Arrive.Arrived or RougeMapEnum.Arrive.ArrivingFinish

		return
	end

	local var_5_2 = arg_5_0:getArrivedNode()

	if var_5_2 then
		for iter_5_0, iter_5_1 in ipairs(arg_5_0.nodeMoList) do
			if iter_5_1 ~= var_5_2 then
				iter_5_1.arriveStatus = RougeMapEnum.Arrive.CantArrive
			elseif var_5_0 ~= iter_5_1 then
				iter_5_1.arriveStatus = RougeMapEnum.Arrive.Arrived
			elseif iter_5_1:getEventState() == RougeMapEnum.EventState.Finish then
				iter_5_1.arriveStatus = RougeMapEnum.Arrive.ArrivingFinish
			else
				iter_5_1.arriveStatus = RougeMapEnum.Arrive.ArrivingNotFinish
			end
		end

		return
	end

	for iter_5_2, iter_5_3 in ipairs(arg_5_0.nodeMoList) do
		local var_5_3 = iter_5_3.preNodeList

		if arg_5_0:checkPreNodeHadStartOrArrivingFinish(var_5_3) then
			iter_5_3.arriveStatus = RougeMapEnum.Arrive.CanArrive
		elseif arg_5_0:checkPreNodeEveryIsCantArrive(var_5_3) then
			iter_5_3.arriveStatus = RougeMapEnum.Arrive.CantArrive
		else
			iter_5_3.arriveStatus = RougeMapEnum.Arrive.NotArrive
		end
	end
end

function var_0_0.checkPreNodeHadStartOrArrivingFinish(arg_6_0, arg_6_1)
	if not arg_6_1 then
		return false
	end

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		if RougeMapModel.instance:getNode(iter_6_1).arriveStatus == RougeMapEnum.Arrive.ArrivingFinish then
			return true
		end
	end
end

function var_0_0.checkPreNodeEveryIsCantArrive(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return true
	end

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		if RougeMapModel.instance:getNode(iter_7_1).arriveStatus ~= RougeMapEnum.Arrive.CantArrive then
			return false
		end
	end

	return true
end

function var_0_0.getArrivedNode(arg_8_0)
	if arg_8_0.id > RougeMapModel.instance:getCurEpisodeId() then
		return nil
	end

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.nodeMoList) do
		if iter_8_1.pathWay then
			return iter_8_1
		end
	end
end

function var_0_0.sortNode(arg_9_0)
	table.sort(arg_9_0.nodeMoList, var_0_0._sortFunc)

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.nodeMoList) do
		iter_9_1:setIndex(iter_9_0)
	end
end

function var_0_0._sortFunc(arg_10_0, arg_10_1)
	return arg_10_0.nodeId < arg_10_1.nodeId
end

return var_0_0
