-- chunkname: @modules/logic/survival/rpc/SurvivalInteriorRpc.lua

module("modules.logic.survival.rpc.SurvivalInteriorRpc", package.seeall)

local SurvivalInteriorRpc = class("SurvivalInteriorRpc", BaseRpc)

function SurvivalInteriorRpc:sendEnterSurvival(initGroupMo, callback, callobj)
	local req = SurvivalInteriorModule_pb.EnterSurvivalRequest()

	if initGroupMo then
		req.index = initGroupMo.selectMapIndex

		for i = 1, initGroupMo:getCarryHeroCount() do
			local heroMo = initGroupMo.allSelectHeroMos[i]

			if heroMo then
				table.insert(req.heroUid, heroMo.uid)
			end
		end

		for i = 1, initGroupMo:getCarryNPCCount() do
			local npcMo = initGroupMo.allSelectNpcs[i]

			if npcMo then
				table.insert(req.npcId, npcMo.id)
			end
		end
	end

	return self:sendMsg(req, callback, callobj)
end

function SurvivalInteriorRpc:onReceiveEnterSurvivalReply(resultCode, msg)
	if resultCode == 0 then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

		weekInfo.inSurvival = true

		SurvivalMapModel.instance:setSceneData(msg.scene)
	end
end

function SurvivalInteriorRpc:sendSurvivalSceneOperation(operationType, param, callback, callobj)
	local req = SurvivalInteriorModule_pb.SurvivalSceneOperationRequest()

	req.operationType = operationType
	req.param = param

	return self:sendMsg(req, callback, callobj)
end

function SurvivalInteriorRpc:onReceiveSurvivalSceneOperationReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function SurvivalInteriorRpc:onReceiveSurvivalSceneEndPush(resultCode, msg)
	if resultCode == 0 then
		SurvivalMapHelper.instance:addPushToFlow("SurvivalSceneEndPush", msg)
	end
end

function SurvivalInteriorRpc:onReceiveSurvivalDailyReportPush(resultCode, msg)
	if resultCode == 0 then
		SurvivalMapHelper.instance:addPushToFlow("SurvivalDailyReportPush", msg)
	end
end

function SurvivalInteriorRpc:sendSurvivalSceneOperationLog(callback, callobj)
	local req = SurvivalInteriorModule_pb.SurvivalSceneOperationLogRequest()

	return self:sendMsg(req, callback, callobj)
end

function SurvivalInteriorRpc:onReceiveSurvivalSceneOperationLogReply(resultCode, msg)
	if resultCode == 0 then
		local logDatas = {}

		for k, v in ipairs(msg.data) do
			local logMo = SurvivalLogMo.New()

			logMo:init(v, SurvivalConst.ItemRareColor2)
			table.insert(logDatas, logMo)
		end

		tabletool.revert(logDatas)
		ViewMgr.instance:openView(ViewName.SurvivalLogView, logDatas)
	end
end

function SurvivalInteriorRpc:onReceiveSurvivalSceneOperationLogPush(resultCode, msg)
	if resultCode == 0 then
		SurvivalMapHelper.instance:addPushToFlow("SurvivalSceneOperationLogPush", msg)
	end
end

function SurvivalInteriorRpc:sendSurvivalSceneGiveUp(callback, callobj)
	local req = SurvivalInteriorModule_pb.SurvivalSceneGiveUpRequest()

	return self:sendMsg(req, callback, callobj)
end

function SurvivalInteriorRpc:onReceiveSurvivalSceneGiveUpReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function SurvivalInteriorRpc:sendSurvivalUpdateClientDataRequest(data, callback, callobj)
	local req = SurvivalInteriorModule_pb.SurvivalUpdateClientDataRequest()

	req.data = data

	return self:sendMsg(req, callback, callobj)
end

function SurvivalInteriorRpc:onReceiveSurvivalUpdateClientDataReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function SurvivalInteriorRpc:sendSurvivalTaskFollowRequest(moduleId, taskId, follow, callback, callobj)
	local req = SurvivalInteriorModule_pb.SurvivalTaskFollowRequest()

	req.moduleId = moduleId
	req.taskId = taskId
	req.follow = follow

	return self:sendMsg(req, callback, callobj)
end

function SurvivalInteriorRpc:onReceiveSurvivalTaskFollowReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function SurvivalInteriorRpc:sendSurvivalUseItemRequest(itemUid, param, callback, callobj)
	local req = SurvivalInteriorModule_pb.SurvivalUseItemRequest()

	req.itemUid = itemUid
	req.param = param

	return self:sendMsg(req, callback, callobj)
end

function SurvivalInteriorRpc:onReceiveSurvivalUseItemReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function SurvivalInteriorRpc:onReceiveMsg(resultCode, cmd, recvProtoName, msg, downTag, socketId)
	SurvivalInteriorRpc.super.onReceiveMsg(self, resultCode, cmd, recvProtoName, msg, downTag, socketId)

	if resultCode == 0 and string.find(recvProtoName, "Reply$") then
		SurvivalMapHelper.instance:tryStartFlow(recvProtoName)
	end
end

SurvivalInteriorRpc.instance = SurvivalInteriorRpc.New()

return SurvivalInteriorRpc
