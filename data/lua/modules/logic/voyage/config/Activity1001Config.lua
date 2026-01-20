-- chunkname: @modules/logic/voyage/config/Activity1001Config.lua

module("modules.logic.voyage.config.Activity1001Config", package.seeall)

local Activity1001Config = class("Activity1001Config", BaseConfig)

function Activity1001Config:ctor(activityId)
	self.__activityId = activityId
end

function Activity1001Config:checkActivityId(activityId)
	return self.__activityId == activityId
end

function Activity1001Config:getActivityId()
	return self.__activityId
end

function Activity1001Config:reqConfigNames()
	return {
		"activity1001",
		"activity1001_ext",
		"mail"
	}
end

local function getCOFromExt(activityId, id, isTry)
	if not isTry then
		return lua_activity1001_ext.configDict[activityId][id]
	end

	local dict = lua_activity1001_ext.configDict[activityId]

	return dict and dict[id] or nil
end

local function getCO(activityId, id)
	return lua_activity1001.configDict[activityId][id]
end

function Activity1001Config:getCO(id)
	return getCOFromExt(self.__activityId, id, true) or getCO(self.__activityId, id)
end

function Activity1001Config:getRewardStr(id)
	local co = self:getCO(id)

	if co.mailId then
		local mailco = lua_mail.configDict[co.mailId]

		return mailco.attachment
	else
		return co.rewards
	end
end

function Activity1001Config:getTitle()
	local dict = lua_activity1001_ext.configDict[self.__activityId]

	for _, v in pairs(dict) do
		if not string.nilorempty(v.title) then
			return v.title
		end
	end

	return ""
end

function Activity1001Config:_createOrGetShowTaskList()
	if self.__taskList then
		return self.__taskList
	end

	local res = {}

	for _, v in ipairs(lua_activity1001.configList) do
		if v.activityId == self.__activityId then
			table.insert(res, v)
		end
	end

	for _, v in ipairs(lua_activity1001_ext.configList) do
		if v.activityId == self.__activityId then
			table.insert(res, v)
		end
	end

	table.sort(res, function(a, b)
		if a.sort ~= b.sort then
			return a.sort < b.sort
		end

		return a.id < b.id
	end)

	self.__taskList = res

	return res
end

return Activity1001Config
