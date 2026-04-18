-- chunkname: @modules/logic/partygame/controller/PartyGameStatHelper.lua

module("modules.logic.partygame.controller.PartyGameStatHelper", package.seeall)

local PartyGameStatHelper = class("PartyGameStatHelper")

function PartyGameStatHelper:partyGamePing(area, ping)
	StatController.instance:track("party_game_ping", {
		[SDKDataTrackMgr.EventProperties.area] = tonumber(area) or -1,
		[SDKDataTrackMgr.EventProperties.ping] = tonumber(ping) or -1
	})
end

function PartyGameStatHelper:reqPartyGameInviteBuf(bNew)
	if not self._reqPartyGameInviteBuf then
		self._reqPartyGameInviteBuf = {}
	end

	if bNew then
		self._reqPartyGameInviteBuf.operation = ""
		self._reqPartyGameInviteBuf.targetRoleId = ""
		self._reqPartyGameInviteBuf.roomId = ""
		self._reqPartyGameInviteBuf.inviter_area = -1
		self._reqPartyGameInviteBuf.area = -1
	end

	return self._reqPartyGameInviteBuf
end

function PartyGameStatHelper:uploadPartyGameInvite()
	if not self._reqPartyGameInviteBuf then
		self._reqPartyGameInviteBuf = {}
	end

	local tbl = self._reqPartyGameInviteBuf
	local operation = tbl.operation
	local targetRoleId = tbl.targetRoleId
	local roomId = tbl.roomId
	local inviter_area = tbl.inviter_area
	local area = tbl.area

	if not string.nilorempty(operation) then
		self:partyGameInvite(operation, targetRoleId, roomId, inviter_area, area)
	end

	self:reqPartyGameInviteBuf(true)
end

function PartyGameStatHelper:ctor()
	return
end

function PartyGameStatHelper:partyGameMeme(id)
	StatController.instance:track(StatEnum.EventName.PartyGameMeme, {
		[StatEnum.EventProperties.PartyRoomId] = tostring(PartyGameRoomModel.instance:getRoomId()),
		[StatEnum.EventProperties.Members] = PartyGameRoomModel.instance:getPlayerNum(),
		[StatEnum.EventProperties.isOwner] = PartyGameRoomModel.instance:isRoomOwner(),
		[StatEnum.EventProperties.Meme] = id
	})
end

function PartyGameStatHelper:partyMatch(operation)
	local useTime = 0

	if operation ~= StatEnum.PartyGameEnum.StartMatch and PartyGameRoomModel.instance:getMatchTime() then
		useTime = ServerTime.now() - PartyGameRoomModel.instance:getMatchTime()
	end

	StatController.instance:track(StatEnum.EventName.PartyMatch, {
		[StatEnum.EventProperties.OperationType] = operation,
		[StatEnum.EventProperties.PartyRoomId] = tostring(PartyGameRoomModel.instance:getRoomId()),
		[StatEnum.EventProperties.Members] = PartyGameRoomModel.instance:getPlayerNum(),
		[StatEnum.EventProperties.isOwner] = PartyGameRoomModel.instance:isRoomOwner(),
		[StatEnum.EventProperties.UseTime] = useTime
	})
end

function PartyGameStatHelper:partyGameStart()
	local curGame = PartyGameController.instance:getCurPartyGame()

	if not curGame then
		return
	end

	StatController.instance:track(StatEnum.EventName.PartyGameStart, {
		[StatEnum.EventProperties.PartyGameId] = curGame:getGameId(),
		[StatEnum.EventProperties.Members] = PartyGameModel.instance:getPlayerCount(),
		[StatEnum.EventProperties.PartyGameRobots] = PartyGameModel.instance:getRobotCount()
	})
end

function PartyGameStatHelper:partyGameExit()
	local curGame = PartyGameController.instance:getCurPartyGame()

	if not curGame then
		return
	end

	StatController.instance:track(StatEnum.EventName.PartyGameExit, {
		[StatEnum.EventProperties.PartyGameId] = curGame:getGameId(),
		[StatEnum.EventProperties.Members] = PartyGameModel.instance:getPlayerCount(),
		[StatEnum.EventProperties.PartyGameRobots] = PartyGameModel.instance:getRobotCount()
	})
end

function PartyGameStatHelper:partyGameEnd()
	local curGame = PartyGameController.instance:getCurPartyGame()

	if not curGame then
		return
	end

	local myUid = curGame:getMainPlayerUid()
	local mo = PartyGameModel.instance:getPlayerMoByUid(myUid)

	if not mo then
		return
	end

	local winTeam = curGame:getWinTeam()
	local myTeam = mo.tempType
	local isTeamType = curGame:isTeamType()
	local rank = curGame:getRank(myUid)
	local isWin = false

	if isTeamType then
		isWin = winTeam == myTeam
	else
		isWin = rank == 1
	end

	StatController.instance:track(StatEnum.EventName.PartyGameEnd, {
		[StatEnum.EventProperties.PartyGameId] = curGame:getGameId(),
		[StatEnum.EventProperties.Members] = PartyGameModel.instance:getPlayerCount(),
		[StatEnum.EventProperties.PartyGameRobots] = PartyGameModel.instance:getRobotCount(),
		[StatEnum.EventProperties.IsWin] = isWin,
		[StatEnum.EventProperties.IsTeamType] = isTeamType,
		[StatEnum.EventProperties.Result] = tostring(curGame:getPlayerScore(myUid)),
		[StatEnum.EventProperties.Rank] = rank,
		[StatEnum.EventProperties.PartySkinList] = tabletool.copy(mo.skinIds),
		[StatEnum.EventProperties.PartyHp] = mo.hp,
		[StatEnum.EventProperties.PartyCardList] = tabletool.copy(mo.cardIds)
	})
end

function PartyGameStatHelper:partySettle(isWin, rank, partyId)
	local curGame = PartyGameController.instance:getCurPartyGame()

	if not curGame then
		return
	end

	local myUid = curGame:getMainPlayerUid()
	local mo = PartyGameModel.instance:getPlayerMoByUid(myUid)

	if not mo then
		return
	end

	StatController.instance:track(StatEnum.EventName.PartySettle, {
		[StatEnum.EventProperties.PartyGameId] = curGame:getGameId(),
		[StatEnum.EventProperties.Members] = PartyGameModel.instance:getPlayerCount(),
		[StatEnum.EventProperties.PartyGameRobots] = PartyGameModel.instance:getRobotCount(),
		[StatEnum.EventProperties.IsWin] = isWin,
		[StatEnum.EventProperties.Rank] = rank,
		[StatEnum.EventProperties.PartyId] = partyId,
		[StatEnum.EventProperties.PartySkinList] = tabletool.copy(mo.skinIds),
		[StatEnum.EventProperties.PartyHp] = mo.hp,
		[StatEnum.EventProperties.PartyCardList] = tabletool.copy(mo.cardIds)
	})
end

function PartyGameStatHelper:logPartyFriendsInfo(map)
	if not map then
		return
	end

	local stateList = {}

	for i, v in pairs(map) do
		table.insert(stateList, v.state)
	end

	StatController.instance:track(StatEnum.EventName.PartyFriendsInfo, {
		[StatEnum.EventProperties.PartyFriendStateList] = stateList
	})
end

function PartyGameStatHelper:partyGameInvite(operation, targetRoleId, roomId, inviter_area, area)
	StatController.instance:track(StatEnum.EventName.PartyGameInvite, {
		[StatEnum.EventProperties.OperationType] = operation,
		[StatEnum.EventProperties.TargetRoleId] = tostring(targetRoleId),
		[StatEnum.EventProperties.PartyRoomId] = tostring(roomId),
		[SDKDataTrackMgr.EventProperties.inviter_area] = tonumber(inviter_area) or -1,
		[SDKDataTrackMgr.EventProperties.area] = tonumber(area) or -1
	})
end

function PartyGameStatHelper:partyGameReconnect()
	local curGame = PartyGameController.instance:getCurPartyGame()

	StatController.instance:track(StatEnum.EventName.PartyGameReconnect, {
		[StatEnum.EventProperties.PartyGameId] = curGame and curGame:getGameId() or 0
	})
end

PartyGameStatHelper.instance = PartyGameStatHelper.New()

return PartyGameStatHelper
