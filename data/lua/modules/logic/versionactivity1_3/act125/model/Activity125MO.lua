-- chunkname: @modules/logic/versionactivity1_3/act125/model/Activity125MO.lua

module("modules.logic.versionactivity1_3.act125.model.Activity125MO", package.seeall)

local Activity125MO = pureTable("Activity125MO")

function Activity125MO:ctor()
	self._userId = PlayerModel.instance:getMyUserId()
	self._episdoeInfos = {}
	self._oldDict = {}
end

function Activity125MO:setInfo(info)
	self._episdoeInfos = {}
	self.id = info.activityId

	self:initConfig()
	self:updateInfo(info.act125Episodes)
end

function Activity125MO:initConfig()
	if self.config then
		return
	end

	self.config = Activity125Config.instance:getAct125Config(self.id)
	self._episodeList = {}

	if self.config then
		for k, v in pairs(self.config) do
			table.insert(self._episodeList, v)
		end

		table.sort(self._episodeList, SortUtil.keyLower("id"))
	end
end

function Activity125MO:updateInfo(episodeList)
	if episodeList then
		for i = 1, #episodeList do
			local episode = episodeList[i]

			self._episdoeInfos[episode.id] = episode.state
		end
	end

	local reddotid = ActivityConfig.instance:getActivityCo(self.id).redDotId

	RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
		[tonumber(reddotid)] = true
	})
end

function Activity125MO:isEpisodeFinished(episodeId)
	if not episodeId then
		return false
	end

	return self._episdoeInfos and self._episdoeInfos[episodeId] == 1
end

function Activity125MO:getEpisodeConfig(episodeId)
	return self.config[episodeId]
end

function Activity125MO:isEpisodeUnLock(episodeId)
	local episodeCfg = self:getEpisodeConfig(episodeId)
	local preEpisodeId = episodeCfg.preId
	local isPreEpisodeFinished = true

	if preEpisodeId and preEpisodeId > 0 then
		isPreEpisodeFinished = self._episdoeInfos[preEpisodeId] == 1 or self:checkLocalIsPlay(preEpisodeId) and self._episdoeInfos[preEpisodeId] == 0
	end

	return isPreEpisodeFinished and self._episdoeInfos[episodeId] ~= nil
end

function Activity125MO:isEpisodeDayOpen(episodeId, real)
	local result = false
	local actMO = ActivityModel.instance:getActMO(self.id)
	local episodeCfg = self:getEpisodeConfig(episodeId)
	local openDay = episodeCfg.openDay
	local remainDay = 0
	local remainTime = 0

	if actMO and openDay then
		local openTime = actMO:getRealStartTimeStamp() + (openDay - 1) * TimeUtil.OneDaySecond
		local time = ServerTime.now()

		remainTime = openTime - ServerTime.now()

		if remainTime < 0 then
			result = true
		else
			remainDay = math.floor(remainTime / TimeUtil.OneDaySecond)
		end
	end

	return result, remainDay, remainTime
end

function Activity125MO:isEpisodeReallyOpen(episodeId)
	local isEpisodeUnLock = self:isEpisodeUnLock(episodeId)
	local isOpenDay = self:isEpisodeDayOpen(episodeId)
	local episodeCfg = self:getEpisodeConfig(episodeId)
	local preEpisodeId = episodeCfg and episodeCfg.preId or nil

	if preEpisodeId and preEpisodeId > 0 and not self:isEpisodeFinished(preEpisodeId) then
		return false
	end

	return isEpisodeUnLock and isOpenDay
end

function Activity125MO:getLastEpisode()
	for i = #self._episodeList, 1, -1 do
		local value = self._episodeList[i]

		if self:isEpisodeReallyOpen(value.id) then
			return value.id
		end
	end

	local lastEpisode = self._episodeList[1]

	return lastEpisode and lastEpisode.id
end

function Activity125MO:getFirstRewardEpisode()
	for index, value in ipairs(self._episodeList) do
		if self:isEpisodeReallyOpen(value.id) then
			if self._episdoeInfos[value.id] == 0 then
				return value.id
			end
		else
			return value.preId
		end
	end

	local lastEpisode = self._episodeList[#self._episodeList]

	return lastEpisode and lastEpisode.id
end

function Activity125MO:setLocalIsPlay(id)
	local key = string.format("%s_%s_%s_%s", PlayerModel.instance:getPlayinfo().userId, PlayerPrefsKey.VersionActivityWarmUpView, self.id, id)

	PlayerPrefsHelper.setString(key, 1)
end

function Activity125MO:checkLocalIsPlay(id)
	local key = string.format("%s_%s_%s_%s", PlayerModel.instance:getPlayinfo().userId, PlayerPrefsKey.VersionActivityWarmUpView, self.id, id)
	local value = PlayerPrefsHelper.getString(key, "")

	if string.nilorempty(value) then
		return false
	end

	return true
end

function Activity125MO:setOldEpisode(id)
	self._oldDict[id] = true
end

function Activity125MO:checkIsOldEpisode(id)
	return self._oldDict[id]
end

function Activity125MO:getEpisodeCount()
	return #self._episodeList
end

function Activity125MO:getEpisodeList()
	return self._episodeList
end

function Activity125MO:setSelectEpisodeId(id)
	self._selectId = id
end

function Activity125MO:getSelectEpisodeId()
	if not self._selectId then
		self._selectId = self:getFirstRewardEpisode()
	end

	return self._selectId
end

function Activity125MO:isAllEpisodeFinish()
	for index, value in ipairs(self._episodeList) do
		local state = self._episdoeInfos[value.id]

		if not state or state == 0 then
			return false
		end
	end

	return true
end

function Activity125MO:isHasEpisodeCanReceiveReward(episodeId)
	if episodeId then
		return self._episdoeInfos[episodeId] == 0
	end

	for index, value in ipairs(self._episodeList) do
		local state = self._episdoeInfos[value.id]

		if state == 0 then
			return true
		end
	end

	return false
end

function Activity125MO:isFirstCheckEpisode(episodeId)
	local key = string.format("%s_%s_%s_%s", self._userId, PlayerPrefsKey.Activity125FirstCheckEpisode, self.id, episodeId)
	local isFirst = PlayerPrefsHelper.getNumber(key, 0)

	return isFirst == 0
end

function Activity125MO:setHasCheckEpisode(episodeId)
	local key = string.format("%s_%s_%s_%s", self._userId, PlayerPrefsKey.Activity125FirstCheckEpisode, self.id, episodeId)

	if self:isFirstCheckEpisode(episodeId) then
		PlayerPrefsHelper.setNumber(key, 1)
	end
end

function Activity125MO:hasEpisodeCanCheck()
	for _, value in ipairs(self._episodeList) do
		local episodeId = value.id

		if self:isEpisodeReallyOpen(episodeId) and self:isFirstCheckEpisode(episodeId) then
			return true
		end
	end

	return false
end

function Activity125MO:hasEpisodeCanGetReward()
	for _, value in ipairs(self._episodeList) do
		local state = self._episdoeInfos[value.id]
		local localIsPlay = self:checkLocalIsPlay(value.id)

		if state == 0 and localIsPlay then
			return true
		end
	end

	return false
end

function Activity125MO:getRLOC(episodeId)
	local isRecevied = self:isEpisodeFinished(episodeId)
	local localIsPlay = self:checkLocalIsPlay(episodeId)
	local isOld = self:checkIsOldEpisode(episodeId)
	local canGetReward = not isRecevied and localIsPlay

	return isRecevied, localIsPlay, isOld, canGetReward
end

function Activity125MO:hasRedDot()
	for _, value in ipairs(self._episodeList) do
		local episodeId = value.id

		if self:isEpisodeReallyOpen(episodeId) and self:isHasEpisodeCanReceiveReward(episodeId) then
			return true
		end
	end

	return false
end

return Activity125MO
