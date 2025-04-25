module("modules.logic.fight.system.work.FightWorkBuildSubEntityAfterChangeHero", package.seeall)

slot0 = class("FightWorkBuildSubEntityAfterChangeHero", FightWorkItem)

function slot0.onConstructor(slot0)
	slot0.SAFETIME = 10
end

function slot0.onStart(slot0)
	if not FightHelper.getSubEntity(FightEnum.EntitySide.MySide) then
		slot2 = FightDataHelper.entityMgr:getMySubList()

		table.sort(slot2, FightEntityDataHelper.sortSubEntityList)

		if slot2[1] then
			slot0._entityMgr = GameSceneMgr.instance:getCurScene().entityMgr
			slot0._entityId = slot3.id

			slot0:com_registFightEvent(FightEvent.OnSpineLoaded, slot0._onNextSubSpineLoaded)
			slot0._entityMgr:buildSubSpine(slot3)

			return
		end
	end

	slot0:onDone(true)
end

function slot0._onNextSubSpineLoaded(slot0, slot1)
	if slot1.unitSpawn.id == slot0._entityId then
		slot0:com_registTimer(slot0.finishWork, 5)

		slot3 = slot0:com_registWork(Work2FightWork, FightWorkStartBornNormal, slot0._entityMgr:getEntity(slot0._entityId), true)

		slot3:registFinishCallback(slot0.finishWork, slot0)
		slot3:start()
	end
end

function slot0.clearWork(slot0)
end

return slot0
