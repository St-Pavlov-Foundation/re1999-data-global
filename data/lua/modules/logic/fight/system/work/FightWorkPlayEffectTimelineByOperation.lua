-- chunkname: @modules/logic/fight/system/work/FightWorkPlayEffectTimelineByOperation.lua

module("modules.logic.fight.system.work.FightWorkPlayEffectTimelineByOperation", package.seeall)

local FightWorkPlayEffectTimelineByOperation = class("FightWorkPlayEffectTimelineByOperation", FightWorkItem)

function FightWorkPlayEffectTimelineByOperation:onConstructor(actEffectData, param, originFightStepData, timelineDic, timelineOriginDic)
	self.actEffectData = actEffectData
	self.param = param
	self.originFightStepData = originFightStepData
	self.SAFETIME = 300
	self.timelineDic = timelineDic
	self.timelineOriginDic = timelineOriginDic
end

function FightWorkPlayEffectTimelineByOperation:onStart()
	return
end

function FightWorkPlayEffectTimelineByOperation.sortTimelineDic(item1, item2)
	return item1.count < item2.count
end

function FightWorkPlayEffectTimelineByOperation:playTimeline()
	if self.played then
		return
	end

	self.played = true

	local fightStepData = {
		actId = 0,
		actEffect = {
			self.actEffectData
		},
		fromId = self.originFightStepData.fromId,
		toId = self.actEffectData.targetId,
		actType = FightEnum.ActType.SKILL,
		stepUid = FightTLEventEntityVisible.latestStepUid or 0
	}
	local count = self.param.count or 0

	count = count + 1
	self.param.count = count

	local list = {}

	for k, v in pairs(self.timelineDic) do
		table.insert(list, {
			count = k,
			timelineList = v
		})
	end

	table.sort(list, FightWorkPlayEffectTimelineByOperation.sortTimelineDic)

	local timelineName

	for i, v in ipairs(list) do
		if count <= v.count then
			local timelineList = v.timelineList

			if #timelineList == 0 then
				timelineList = FightDataUtil.coverData(self.timelineOriginDic[v.count], self.timelineDic[v.count])
			end

			local random = math.random(1, #timelineList)

			timelineName = timelineList[random]

			table.remove(timelineList, random)

			break
		end
	end

	if not timelineName then
		self:onDone(true)

		return
	end

	local entity = FightHelper.getEntity("0")

	if not entity then
		self:onDone(true)

		return
	end

	self.fightStepData = fightStepData
	fightStepData.playerOperationCountForPlayEffectTimeline = count
	fightStepData.maxPlayerOperationCountForPlayEffectTimeline = self.originFightStepData.maxPlayerOperationCountForPlayEffectTimeline
	self.originFightStepData.playerOperationCountForPlayEffectTimeline = count

	local work = entity.skill:registTimelineWork(timelineName, fightStepData)

	work.skipAfterTimelineFunc = true
	work.CALLBACK_EVEN_IF_UNFINISHED = true

	work:registFinishCallback(self.onTimelineFinish, self)
	work:start()
end

function FightWorkPlayEffectTimelineByOperation:onTimelineFinish()
	self:onDone(true)
end

function FightWorkPlayEffectTimelineByOperation:onDestructor()
	local skillMgr = FightSkillMgr.instance

	skillMgr._playingSkillCount = skillMgr._playingSkillCount - 1

	if skillMgr._playingSkillCount < 0 then
		skillMgr._playingSkillCount = 0
	end

	skillMgr._playingEntityId2StepData["0"] = nil
end

return FightWorkPlayEffectTimelineByOperation
