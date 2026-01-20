-- chunkname: @modules/logic/versionactivity3_2/cruise/model/Activity217Model.lua

module("modules.logic.versionactivity3_2.cruise.model.Activity217Model", package.seeall)

local Activity217Model = class("Activity217Model", BaseModel)

function Activity217Model:onInit()
	self:reInit()
end

function Activity217Model:reInit()
	self._actInfos = {}
end

function Activity217Model:setAct217Info(info)
	local actId = info and info.activityId or VersionActivity3_2Enum.ActivityId.CruiseTripleDrop

	if not self._actInfos[actId] then
		self._actInfos[actId] = Activity217InfoMO.New()
	end

	self._actInfos[actId]:init(info)
end

function Activity217Model:updateAct217Info(info)
	self:setAct217Info(info)
end

function Activity217Model:updateExpEpisodeCount(count, actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseTripleDrop

	if not self._actInfos[actId] then
		return
	end

	self._actInfos[actId]:updateExpEpisodeCount(count)
end

function Activity217Model:updateCoinEpisodeCount(count, actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseTripleDrop

	if not self._actInfos[actId] then
		return
	end

	self._actInfos[actId]:updateCoinEpisodeCount(count)
end

function Activity217Model:getExpEpisodeCount(actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseTripleDrop

	if not self._actInfos[actId] then
		return 0
	end

	local controlCo = Activity217Config.instance:getControlCO(Activity217Enum.ActType.MultiExp, actId)

	return controlCo and controlCo.limit - self._actInfos[actId].expEpisodeCount or 0
end

function Activity217Model:getCoinEpisodeCount(actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseTripleDrop

	if not self._actInfos[actId] then
		return 0
	end

	local controlCo = Activity217Config.instance:getControlCO(Activity217Enum.ActType.MultiCoin, actId)

	return controlCo and controlCo.limit - self._actInfos[actId].coinEpisodeCount or 0
end

function Activity217Model:getShowTripleByChapter(chapterId, actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseTripleDrop

	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]

	if not actInfoMo or not actInfoMo:isOnline() or not actInfoMo:isOpen() or actInfoMo:isExpired() then
		return false
	end

	local controlCos = Activity217Config.instance:getControlCos(actId)
	local isExpChapter = chapterId == DungeonEnum.ChapterId.ResourceExp

	if isExpChapter then
		local expCount = Activity217Model.instance:getExpEpisodeCount(actId)

		return true, expCount, controlCos[Activity217Enum.ActType.MultiExp].limit
	end

	local isCoinChapter = chapterId == DungeonEnum.ChapterId.ResourceGold

	if isCoinChapter then
		local coinCount = Activity217Model.instance:getCoinEpisodeCount()

		return true, coinCount, controlCos[Activity217Enum.ActType.MultiCoin].limit
	end

	return false
end

Activity217Model.instance = Activity217Model.New()

return Activity217Model
