-- chunkname: @modules/logic/login/model/ServerListModel.lua

module("modules.logic.login.model.ServerListModel", package.seeall)

local ServerListModel = class("ServerListModel", ListScrollModel)

function ServerListModel:setServerList(zoneInfos)
	local moList = {}

	for _, zone in ipairs(zoneInfos) do
		local serverMO = ServerMO.New()

		serverMO:init(zone)
		table.insert(moList, serverMO)
	end

	self:setList(moList)
end

ServerListModel.instance = ServerListModel.New()

return ServerListModel
