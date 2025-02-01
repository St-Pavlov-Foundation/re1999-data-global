module("modules.logic.fight.entity.comp.skill.FightTLEventSetSceneObjVisible", package.seeall)

slot0 = class("FightTLEventSetSceneObjVisible")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	slot0._fightStepMO = slot1
	slot0._paramsArr = slot3

	if slot0._paramsArr[3] == "1" then
		return
	end

	slot0:_setVisible()
end

function slot0._setVisible(slot0)
	if slot0._paramsArr[4] == "1" then
		if FightHelper.getEntity(slot0._fightStepMO.fromId) and slot1.skinSpineEffect then
			if slot0._paramsArr[2] == "1" then
				slot1.skinSpineEffect:showEffects()
			else
				slot1.skinSpineEffect:hideEffects()
			end
		end

		return
	end

	if GameSceneMgr.instance:getCurScene() and slot1.level:getSceneGo() and gohelper.findChild(slot2, slot0._paramsArr[1]) then
		gohelper.setActive(slot3, slot0._paramsArr[2] == "1")
	end
end

function slot0.handleSkillEventEnd(slot0)
end

function slot0.onSkillEnd(slot0)
	if slot0._paramsArr and slot0._paramsArr[3] == "1" then
		slot0:_setVisible()
	end
end

function slot0.reset(slot0)
end

function slot0.dispose(slot0)
end

return slot0
