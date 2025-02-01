module("modules.logic.fight.entity.comp.skill.FightTLEventCameraDistance", package.seeall)

slot0 = class("FightTLEventCameraDistance")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	slot6 = slot3[1]

	if slot3[2] == "1" then
		slot8 = GameSceneMgr.instance:getCurScene().camera:getDefaultCameraOffset()
		slot0._tween = ZProj.TweenHelper.DOLocalMove(CameraMgr.instance:getVirtualCameraGO().transform, slot8.x, slot8.y, slot8.z, slot2)
	elseif not string.nilorempty(slot6) then
		if string.splitToNumber(slot6, ",")[1] and slot8[2] and slot8[3] then
			slot0._tween = ZProj.TweenHelper.DOLocalMove(slot4.transform, slot8[1], slot8[2], slot8[3], slot2)
		else
			logError("相机统一距离参数错误（3个数字用逗号分隔）：" .. slot6)
		end
	else
		slot5:setSceneCameraOffset()
	end
end

function slot0._releaseTween(slot0)
	if slot0._tween then
		ZProj.TweenHelper.KillById(slot0._tween)

		slot0._tween = nil
	end
end

function slot0.handleSkillEventEnd(slot0)
end

function slot0.onSkillEnd(slot0)
	if slot0._tween then
		GameSceneMgr.instance:getCurScene().camera:setSceneCameraOffset()
	end

	slot0:_releaseTween()
end

function slot0.reset(slot0)
	slot0:_releaseTween()
end

function slot0.dispose(slot0)
end

return slot0
