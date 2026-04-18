-- chunkname: @modules/logic/partygamelobby/model/PartyGameLobbyModel.lua

module("modules.logic.partygamelobby.model.PartyGameLobbyModel", package.seeall)

local PartyGameLobbyModel = class("PartyGameLobbyModel", BaseModel)

function PartyGameLobbyModel:onInit()
	return
end

function PartyGameLobbyModel:reInit()
	return
end

PartyGameLobbyModel.instance = PartyGameLobbyModel.New()

return PartyGameLobbyModel
