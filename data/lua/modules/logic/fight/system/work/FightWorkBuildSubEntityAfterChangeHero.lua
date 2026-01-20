-- chunkname: @modules/logic/fight/system/work/FightWorkBuildSubEntityAfterChangeHero.lua

module("modules.logic.fight.system.work.FightWorkBuildSubEntityAfterChangeHero", package.seeall)

local FightWorkBuildSubEntityAfterChangeHero = class("FightWorkBuildSubEntityAfterChangeHero", FightWorkItem)

function FightWorkBuildSubEntityAfterChangeHero:onConstructor()
	self.SAFETIME = 10
end

function FightWorkBuildSubEntityAfterChangeHero:onStart()
	local entity = FightHelper.getSubEntity(FightEnum.EntitySide.MySide)

	if not entity then
		local subList = FightDataHelper.entityMgr:getMySubList()

		table.sort(subList, FightEntityDataHelper.sortSubEntityList)

		local nextSubEntityMO = subList[1]

		if nextSubEntityMO then
			self._entityMgr = GameSceneMgr.instance:getCurScene().entityMgr
			self._entityId = nextSubEntityMO.id

			self:com_registFightEvent(FightEvent.OnSpineLoaded, self._onNextSubSpineLoaded)
			self._entityMgr:buildSubSpine(nextSubEntityMO)

			return
		end
	end

	self:onDone(true)
end

function FightWorkBuildSubEntityAfterChangeHero:_onNextSubSpineLoaded(unitSpine)
	if unitSpine.unitSpawn.id == self._entityId then
		self:com_registTimer(self.finishWork, 5)

		local sub_entity = self._entityMgr:getEntity(self._entityId)
		local work = self:com_registWork(Work2FightWork, FightWorkStartBornNormal, sub_entity, true)

		work:registFinishCallback(self.finishWork, self)
		work:start()
	end
end

function FightWorkBuildSubEntityAfterChangeHero:clearWork()
	return
end

return FightWorkBuildSubEntityAfterChangeHero
