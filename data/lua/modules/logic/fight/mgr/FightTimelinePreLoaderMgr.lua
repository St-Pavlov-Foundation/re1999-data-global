-- chunkname: @modules/logic/fight/mgr/FightTimelinePreLoaderMgr.lua

module("modules.logic.fight.mgr.FightTimelinePreLoaderMgr", package.seeall)

local FightTimelinePreLoaderMgr = class("FightTimelinePreLoaderMgr", FightBaseClass)

function FightTimelinePreLoaderMgr:onConstructor()
	self.timelineDic = {}
end

function FightTimelinePreLoaderMgr:preLoadTimeline(timelineName, entityData)
	local work = self:registPreLoadTimelineWork(timelineName, entityData)

	work:start()
end

function FightTimelinePreLoaderMgr:registPreLoadTimelineWork(timelineName, entityData)
	local work = self:com_registWork(FightWorkTimelinePreLoadItem, timelineName, entityData)

	return work
end

function FightTimelinePreLoaderMgr:onDestructor()
	return
end

return FightTimelinePreLoaderMgr
