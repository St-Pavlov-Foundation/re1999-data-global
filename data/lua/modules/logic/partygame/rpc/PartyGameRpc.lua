-- chunkname: @modules/logic/partygame/rpc/PartyGameRpc.lua

module("modules.logic.partygame.rpc.PartyGameRpc", package.seeall)

local PartyGameRpc = class("PartyGameRpc", BaseRpc)
local PartyGame_Runtime_Utils_KcpSocketUtil = PartyGame.Runtime.Utils.KcpSocketUtil
local partyGameMgrCs = PartyGame.Runtime.GameLogic.GameMgr

function PartyGameRpc:setUpKcpRpcCallBack()
	if self._hasSetUpLuaCallBack then
		return
	end

	self._hasSetUpLuaCallBack = true

	partyGameMgrCs.Instance:SetKcpRpcCallBack(self.handleServerMsg, self)
end

function PartyGameRpc:onInit()
	return
end

function PartyGameRpc:reInit()
	self:onInit()
end

function PartyGameRpc:handleServerMsg(name, msg, ...)
	if name ~= nil and self[name] ~= nil then
		callWithCatch(self[name], self, msg, ...)
	else
		logError(name .. "找不到对应处理逻辑")
	end
end

function PartyGameRpc:sendEnterPartyRequest(uid, name)
	local msg = PartyGameProto.EnterPartyRequest.New()

	msg.Uid = uid
	msg.Name = name

	self:sendKcpMsg(msg)
end

function PartyGameRpc:sendNewGameRequest(gameId)
	local msg = PartyGameProto.NewGameRequest.New()

	msg.GameId = gameId

	logNormal("PartyGame msg-> PartyGameRpc: sendNewGameRequest gameId:" .. gameId)
	self:sendKcpMsg(msg)
end

function PartyGameRpc:sendLoadGameFinishRequest(gameId)
	local msg = PartyGameProto.LoadGameFinishRequest.New()

	msg.GameId = gameId

	logNormal("PartyGame msg->PartyGameRpc: sendLoadGameFinishRequest:" .. tostring(gameId))
	self:sendKcpMsg(msg)
end

function PartyGameRpc:onReceiveMatchInfoPush(resultCode, msg)
	if msg == nil then
		return
	end

	local partyServer = msg.partyServer
	local token = msg.tokens

	if partyServer == nil or token == nil then
		return
	end

	PartyGameController.instance:setToken(token)

	local ip = SLFramework.UnityHelper.ParseDomainToIp(partyServer.outerIp)
	local port = partyServer.outerPort

	PartyGameController.instance:setFirstLogin(true)
	PartyGameController.instance:setPartyGameIsEnd(false)
	partyGameMgrCs.Instance:ConnectKcpSocket(ip, port)
	logNormal("PartyGame msg->PartyGameRpc:onReceiveMatchInfoPush send login req to partyServer, ip:" .. tostring(ip) .. ", port:" .. tostring(port))
end

function PartyGameRpc:loginKcpRequest()
	local req = {}

	req.account = LoginModel.instance.userName
	req.password = PartyGameController.instance:getToken()

	if PartyGameController.instance:getFirstLogin() then
		req.connectWay = 0
	else
		req.connectWay = 1
	end

	local systemCmd = LuaSocketMgr.instance:getSystemCmd()
	local loginReq = systemCmd.LoginRequest(req)

	logNormal("PartyGame msg->PartyGameRpc: loginKcpRequest: account:" .. tostring(req.account) .. ", token:" .. tostring(req.password) .. ", reconnected:" .. tostring(req.connectWay))
	PartyGame_Runtime_Utils_KcpSocketUtil.SendMessageBuff(PartyGameProto.KcpLoginCmd, loginReq)
end

function PartyGameRpc:loginKcpResponse(bytes)
	local systemCmd = LuaSocketMgr.instance:getSystemCmd()
	local bi = 1
	local bi_1, reason = systemCmd.ReadString(bytes, bi)
	local _, userId = systemCmd.ReadLong(bytes, bi_1)

	logNormal("PartyGame msg->用户登录返回：reason:" .. reason .. " , userId: " .. userId)

	if not string.nilorempty(reason) then
		if isDebugBuild and PartyGameEnum.PartyGameConfigData.DebugLockStep then
			ToastController.instance:showToastWithString("登录失败:" .. userId .. "reason: " .. reason)
		end

		PartyGameController.instance:exitPartyGame()
	else
		if isDebugBuild and PartyGameEnum.PartyGameConfigData.DebugLockStep then
			ToastController.instance:showToastWithString("登录成功:" .. userId)
		end

		PartyGameLobbyController.instance:clearSuccessMatchInfo()

		if not PartyGameController.instance:getFirstLogin() then
			PartyGame.Runtime.Utils.KcpSocketUtil.RequsetGetLostPackets()
		end

		if not PartyGameController.instance:getCurPartyGame() then
			PartyGameController.instance:endMatch()
			PartyGameController.instance:enterParty()
		end
	end

	PartyGameController.instance:setFirstLogin(false)
end

function PartyGameRpc:TransToGamePush(msg)
	logNormal("PartyGameRpc->:TransToGamePush")
	PartyGameController.instance:dispatchEvent(PartyGameEvent.transToGamePush, msg)

	if PartyGameController.instance:getCurPartyGame() == nil then
		PartyGameController.instance:transToGamePush(msg)

		return
	end

	PopupController.instance:clear()
	PartyGameModel.instance:setCacheNeedTranGameMsg(msg)

	if ViewMgr.instance:isOpenFinish(ViewName.PartyGameRewardView) then
		PartyGameController.instance:dispatchEvent(PartyGameEvent.CacheNeedTranGame)
	else
		PartyGameController.instance:exitGame()
	end
end

function PartyGameRpc:GameStartPush(msg)
	logNormal("PartyGame msg->PartyGameRpc->:GameStartPush")
	PartyGameController.instance:gameStartPush(msg)
end

function PartyGameRpc:GameEndPush(msg)
	PartyGameController.instance:gameEndResult(msg)
end

function PartyGameRpc:ReadyPlayerNumPush(msg)
	PartyGameModel.instance.curLoadedPlayerCount = msg.ReadyNum

	PartyGameController.instance:dispatchEvent(PartyGameEvent.readyPlayerNumPush)
end

function PartyGameRpc:PartyEndPush(rank, reward, exReward)
	PartyGameController.instance:setPartyGameIsEnd(true)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.PartyGameResultView, {
		Rank = rank,
		Rewards = reward,
		ExReward = exReward
	})
end

function PartyGameRpc:BattleCardRewardListPush(msg)
	logNormal("PartyGame msg->BattleCardRewardListPush->")
	PartyGameController.instance:openBattleCardReward(msg)
end

function PartyGameRpc:sendSelectCardRewardRequest(selectIds)
	logNormal("PartyGame msg->PartyGame msg->sendSelectCardRewardRequest -> " .. table.concat(selectIds, ", "))

	local msg = PartyGameProto.SelectCardRewardRequest.New()

	for i = 1, #selectIds do
		msg.CardIds:Add(selectIds[i])
	end

	self:sendKcpMsg(msg)
end

function PartyGameRpc:SelectCardRewardReply(resultCode)
	if resultCode ~= 0 then
		logError("选择奖励卡失败，错误码：" .. tostring(resultCode))
	end

	PartyGameController.instance:dispatchEvent(PartyGameEvent.RewardSelectFinish, resultCode == 0)
end

function PartyGameRpc:KcpLogout()
	logError("PartyGame msg->PartyGameRpc: KcpLogout")
	PartyGameController.instance.exitGame()
end

PartyGameRpc.instance = PartyGameRpc.New()

return PartyGameRpc
