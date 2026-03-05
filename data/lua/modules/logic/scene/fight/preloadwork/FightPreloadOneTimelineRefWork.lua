-- chunkname: @modules/logic/scene/fight/preloadwork/FightPreloadOneTimelineRefWork.lua

module("modules.logic.scene.fight.preloadwork.FightPreloadOneTimelineRefWork", package.seeall)

local FightPreloadOneTimelineRefWork = class("FightPreloadOneTimelineRefWork", BaseWork)

function FightPreloadOneTimelineRefWork:ctor(timelineName, skinId, timelineItem)
	if string.nilorempty(timelineName) then
		logError(string.format("预加载timeline资源失败，timelineName : ", timelineName))

		return
	end

	self.skinId = skinId
	self.timelineName = timelineName
	self.assetUrl = FightHelper.getRolesTimelinePath(self.timelineName)
	self.timelineUrl = ResUrl.getSkillTimeline(self.timelineName)
	self.timelineItem = timelineItem
end

function FightPreloadOneTimelineRefWork:onStart()
	if string.nilorempty(self.assetUrl) then
		return self:onDone(true)
	end

	logNormal("加载timeline 资源 .. " .. tostring(self.timelineName))
	TaskDispatcher.runDelay(self._delayDone, self, 3)

	self.timelineLoader = MultiAbLoader.New()

	self.timelineLoader:addPath(self.assetUrl)
	self.timelineLoader:startLoad(self.onLoadTimelineDone, self)
end

function FightPreloadOneTimelineRefWork:onLoadTimelineDone()
	local assetItem = self.timelineLoader:getFirstAssetItem()

	if not assetItem then
		logError(string.format("预加载timeline资源失败，timelineName : ", self.timelineName))

		return self:onDone(true)
	end

	self.timelineItem:setTimelineAssetItem(assetItem)
	logNormal("加载timeline资源成功")

	local refResList = FightPreloadHelper.getTimelineRefRes(assetItem, self.timelineUrl, self.skinId)

	if not refResList then
		return self:onDone(true)
	end

	if #refResList < 1 then
		return self:onDone(true)
	end

	logNormal("开始加载timeline引用的资源")

	self.resLoader = MultiAbLoader.New()

	for _, res in ipairs(refResList) do
		self.resLoader:addPath(res)
	end

	self.resLoader:startLoad(self.onLoadTimelineResDone, self)
end

function FightPreloadOneTimelineRefWork:onLoadTimelineResDone()
	logNormal("timeline引用的资源加载完成")

	return self:onDone(true)
end

function FightPreloadOneTimelineRefWork:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)

	if self.timelineLoader then
		self.timelineLoader:dispose()

		self.timelineLoader = nil
	end

	if self.resLoader then
		self.resLoader:dispose()

		self.resLoader = nil
	end
end

function FightPreloadOneTimelineRefWork:_delayDone()
	self:onDone(true)
end

return FightPreloadOneTimelineRefWork
