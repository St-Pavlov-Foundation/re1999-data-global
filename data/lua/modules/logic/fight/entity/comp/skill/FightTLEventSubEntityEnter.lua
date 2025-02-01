module("modules.logic.fight.entity.comp.skill.FightTLEventSubEntityEnter", package.seeall)

slot0 = class("FightTLEventSubEntityEnter")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return
	end

	if FightEntityModel.instance:getSubModel(FightEnum.EntitySide.MySide):getList()[1] then
		slot0.nextSubEntityMO = slot5

		FightController.instance:registerCallback(FightEvent.OnSpineLoaded, slot0._onSubSpineLoaded, slot0)

		slot0._nextSubEntity = GameSceneMgr.instance:getCurScene().entityMgr:buildSubSpine(slot5)
	end
end

function slot0._onSubSpineLoaded(slot0, slot1)
	if slot1.unitSpawn.id == slot0.nextSubEntityMO.id then
		FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, slot0._onSubSpineLoaded, slot0)

		slot0._nextSubBornFlow = FlowSequence.New()

		slot0._nextSubBornFlow:addWork(FightWorkStartBornNormal.New(GameSceneMgr.instance:getCurScene().entityMgr:getEntity(slot0.nextSubEntityMO.id), true))
		slot0._nextSubBornFlow:start()
	end
end

function slot0.reset(slot0)
	slot0:dispose()
end

function slot0.dispose(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, slot0._onSubSpineLoaded, slot0)

	if slot0._nextSubBornFlow then
		slot0._nextSubBornFlow:stop()

		slot0._nextSubBornFlow = nil
	end
end

function slot0.onSkillEnd(slot0)
end

return slot0
