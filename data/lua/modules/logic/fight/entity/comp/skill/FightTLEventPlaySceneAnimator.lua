module("modules.logic.fight.entity.comp.skill.FightTLEventPlaySceneAnimator", package.seeall)

slot0 = class("FightTLEventPlaySceneAnimator")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	if GameSceneMgr.instance:getCurScene() and gohelper.findChildComponent(slot6.level:getSceneGo(), slot3[1], typeof(UnityEngine.Animator)) then
		slot8.speed = FightModel.instance:getSpeed()

		if slot3[3] == "1" then
			SLFramework.AnimatorPlayer.Get(slot8.gameObject):Play(slot3[2], nil, )
		else
			slot8:Play(slot5, 0, 0)
		end
	end
end

function slot0.handleSkillEventEnd(slot0)
end

function slot0.reset(slot0)
end

function slot0.dispose(slot0)
end

return slot0
