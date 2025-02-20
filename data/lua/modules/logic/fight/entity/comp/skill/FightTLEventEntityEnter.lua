module("modules.logic.fight.entity.comp.skill.FightTLEventEntityEnter", package.seeall)

slot0 = class("FightTLEventEntityEnter")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	slot6 = GameSceneMgr.instance:getCurScene().entityMgr
	slot7 = slot1.fromId

	if slot3[1] == "2" then
		slot7 = slot1.toId
	end

	slot8 = FightDataHelper.entityMgr:getById(slot7)

	if slot1.customType == "change_hero" then
		FightEntityModel.instance:getSubModel(slot8.side):remove(slot8)
		FightEntityModel.instance:getModel(slot8.side):addAtLast(slot8)

		slot8.position = slot1.toPosition
	end

	slot0._newEntity = slot6:buildSpine(slot8)
	slot0._work = FightWorkStartBornNormal.New(slot0._newEntity, false)

	slot0._work:registerDoneListener(slot0._onEntityBornDone, slot0)
	slot0._work:onStart()

	if slot0._newEntity:isMySide() then
		FightAudioMgr.instance:playHeroVoiceRandom(slot8.modelId, CharacterEnum.VoiceType.EnterFight)
	end
end

function slot0._onEntityBornDone(slot0)
	slot0._work:unregisterDoneListener(slot0._onEntityBornDone, slot0)
	FightController.instance:dispatchEvent(FightEvent.OnChangeEntity, slot0._newEntity)
end

function slot0.reset(slot0)
	slot0:dispose()
end

function slot0.dispose(slot0)
	if slot0._work then
		slot0._work:unregisterDoneListener(slot0._onEntityBornDone, slot0)
		slot0._work:onStop()

		slot0._work = nil
	end
end

function slot0.onSkillEnd(slot0)
end

return slot0
