-- chunkname: @modules/logic/main/controller/work/ActivityVersionSummonPatWork.lua

module("modules.logic.main.controller.work.ActivityVersionSummonPatWork", package.seeall)

local ActivityVersionSummonPatWork = class("ActivityVersionSummonPatWork", ActivityRoleSignWorkBase)

function ActivityVersionSummonPatWork:onGetViewNames()
	return {
		ViewName.VersionSummonPanel_Part1,
		ViewName.VersionSummonPanel_Part2
	}
end

function ActivityVersionSummonPatWork:onGetActIds()
	return ActivityType101Config.instance:getVersionSummonActIdList()
end

return ActivityVersionSummonPatWork
