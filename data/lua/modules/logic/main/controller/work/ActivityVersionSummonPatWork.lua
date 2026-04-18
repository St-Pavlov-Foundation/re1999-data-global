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

function ActivityVersionSummonPatWork:onWork(refWorkContext)
	local actId = self._actId
	local config = ActivityConfig.instance:getActivityCo(actId)

	if ActivityType101Model.instance:isOpen(actId) then
		refWorkContext.bAutoWorkNext = false

		local str = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.ActivityVersionSummonPatShowAnim, "")
		local patFaceParam = config and config.patFaceParam and string.splitToNumber(config.patFaceParam, "#")

		if not patFaceParam or #patFaceParam < 1 then
			Activity101Rpc.instance:sendGet101InfosRequest(actId)

			return
		end

		if string.nilorempty(str) and ActivityType101Model.instance:isType101RewardCouldGetAnyOne(actId) then
			local heroId = patFaceParam[1]
			local config = HeroConfig.instance:getHeroCO(heroId)
			local limitedCO = lua_character_limited.configDict[config.mvskinId]

			ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._finishOpenAnimCallBack, self)
			ViewMgr.instance:openView(ViewName.LimitedRoleView, {
				limitedCO = limitedCO
			})
			self:_endBlock()
			UIBlockMgrExtend.setNeedCircleMv(false)
		else
			Activity101Rpc.instance:sendGet101InfosRequest(actId)
		end
	else
		refWorkContext.bAutoWorkNext = true
	end
end

function ActivityVersionSummonPatWork:_finishOpenAnimCallBack(viewName)
	if viewName == ViewName.LimitedRoleView then
		UIBlockMgrExtend.setNeedCircleMv(true)

		local config = ActivityConfig.instance:getActivityCo(self._actId)
		local patFaceParam = config and config.patFaceParam and string.splitToNumber(config.patFaceParam, "#")
		local str = GameBranchMgr.instance:VHyphenA() .. "#" .. (patFaceParam and patFaceParam[1])

		GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.ActivityVersionSummonPatShowAnim, str)
		Activity101Rpc.instance:sendGet101InfosRequest(self._actId)
	end
end

function ActivityVersionSummonPatWork:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._finishOpenAnimCallBack, self)
	ActivityVersionSummonPatWork.super.clearWork(self)
end

return ActivityVersionSummonPatWork
