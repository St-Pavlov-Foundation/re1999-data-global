module("modules.logic.fight.entity.comp.skill.FightTLEventUniqueCameraNew", package.seeall)

slot0 = class("FightTLEventUniqueCameraNew")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	slot0._fightStepMO = slot1
	slot0._attacker = FightHelper.getEntity(slot1.fromId)
	slot0._cameraResName = slot3[1]

	if not string.nilorempty(slot3[2]) and slot3[2] ~= "0" and FightHelper.detectTimelinePlayEffectCondition(slot1, slot3[2]) and not string.nilorempty(slot3[3]) then
		slot0._cameraResName = slot3[3]
	end

	if not string.nilorempty(slot0._cameraResName) then
		slot0._loader = MultiAbLoader.New()

		slot0._loader:addPath(FightHelper.getCameraAniPath(slot0._cameraResName))
		slot0._loader:startLoad(slot0._onLoaded, slot0)
	end

	FightController.instance:registerCallback(FightEvent.ParallelPlayNextSkillDoneThis, slot0._parallelSkillDoneThis, slot0)
end

function slot0.handleSkillEventEnd(slot0)
	slot0:_onFinish()
end

function slot0._onLoaded(slot0, slot1)
	slot0._fightStepMO.hasPlayTimelineCamera = true
	slot2 = GameSceneMgr.instance:getCurScene().camera
	slot3 = slot2:getCurVirtualCamera(1)
	slot4 = slot2:getCurVirtualCamera(2)
	slot5 = ZProj.VirtualCameraWrap.Get(slot3.gameObject).body
	slot6 = ZProj.VirtualCameraWrap.Get(slot4.gameObject).body
	slot9 = gohelper.findChild(slot3.transform.parent.gameObject, "Follower" .. string.sub(slot3.name, string.len(slot3.name)))
	slot10 = gohelper.findChild(slot4.transform.parent.gameObject, "Follower" .. string.sub(slot4.name, string.len(slot4.name)))
	slot11 = slot3.transform.parent.gameObject
	slot12 = slot4.transform.parent.gameObject
	slot13 = nil

	if slot0._fightStepMO.isParallelStep or GameSceneMgr.instance:getCurScene().cardCamera:isPlaying() then
		GameSceneMgr.instance:getCurScene().camera:enablePostProcessSmooth(true)

		slot13 = {
			{
				body = slot5,
				follower = slot9,
				vcam = slot11,
				params = slot0:_getVirtualCameraParams(slot5, slot9, slot11)
			},
			{
				body = slot6,
				follower = slot10,
				vcam = slot12,
				params = slot0:_getVirtualCameraParams(slot6, slot10, slot12)
			}
		}

		slot2:switchNextVirtualCamera()
	end

	slot0._animatorInst = slot0._loader:getFirstAssetItem():GetResource(ResUrl.getCameraAnim(slot0._cameraResName))
	slot0._animComp = CameraMgr.instance:getCameraRootAnimator()
	slot0._animComp.enabled = true
	slot0._animComp.runtimeAnimatorController = nil
	slot0._animComp.runtimeAnimatorController = slot0._animatorInst
	slot0._animComp.speed = FightModel.instance:getSpeed()

	slot0._animComp:SetBool("isRight", slot0._attacker and slot0._attacker:isMySide() or false)

	if slot0._attacker and slot0._attacker:getMO() and slot0._attacker:getMO().position then
		slot0._animComp:SetInteger("pos", slot15 > 4 and 4 or slot15)
	end

	FightController.instance:registerCallback(FightEvent.OnUpdateSpeed, slot0._onUpdateSpeed, slot0)

	slot0._animationIndex = 1
	slot0._animationName = slot0._animComp:GetCurrentAnimatorStateInfo(0) and slot16.shortNameHash

	if slot0._fightStepMO.isParallelStep or slot14:isPlaying() then
		if slot14:isPlaying() then
			slot14:stop()
		end

		slot0._defaultVirtualCameraParams = {
			{
				body = slot5,
				follower = slot9,
				vcam = slot11,
				params = slot0:_getDefaultVirtualCameraParams(slot5, slot9, slot11)
			},
			{
				body = slot6,
				follower = slot10,
				vcam = slot12,
				params = slot0:_getDefaultVirtualCameraParams(slot6, slot10, slot12)
			}
		}

		slot0:_setVirtualCameraParam(slot13)
		TaskDispatcher.runDelay(slot0._delaySetDefaultVirtualCameraParam, slot0, 1)
	end
end

function slot0._getVirtualCameraParams(slot0, slot1, slot2, slot3)
	return {
		pathOffset = slot1.m_PathOffset,
		pathPosition = slot1.m_PathPosition,
		xDamping = slot1.m_XDamping,
		yDamping = slot1.m_YDamping,
		zDamping = slot1.m_ZDamping,
		followerPos = slot2.transform.localPosition,
		vcamPos = slot3.transform.localPosition
	}
end

function slot0._getDefaultVirtualCameraParams(slot0, slot1, slot2, slot3)
	slot4 = Vector3.zero

	return {
		zDamping = 0.5,
		xDamping = 0.5,
		yDamping = 0.5,
		pathPosition = 1,
		pathOffset = slot4,
		followerPos = slot2.transform.localPosition,
		vcamPos = slot4
	}
end

function slot0._delaySetDefaultVirtualCameraParam(slot0)
	slot0:_setVirtualCameraParam(slot0._defaultVirtualCameraParams)
end

function slot0._setVirtualCameraParam(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot6.body.m_PathOffset = slot6.params.pathOffset
		slot6.body.m_PathPosition = slot6.params.pathPosition
		slot6.body.m_XDamping = slot6.params.xDamping
		slot6.body.m_YDamping = slot6.params.yDamping
		slot6.body.m_ZDamping = slot6.params.zDamping
		slot6.follower.transform.localPosition = slot6.params.followerPos
		slot6.vcam.transform.localPosition = slot6.params.vcamPos
	end
end

function slot0._onUpdateSpeed(slot0)
	if slot0._animComp then
		slot0._animComp.speed = FightModel.instance:getSpeed()
	end
end

function slot0._parallelSkillDoneThis(slot0, slot1)
	TaskDispatcher.cancelTask(slot0._delaySetDefaultVirtualCameraParam, slot0)

	slot0._animComp = nil
end

function slot0._onFinish(slot0)
	slot0:_clear()
end

function slot0.reset(slot0)
	slot0:_clear()
end

function slot0.dispose(slot0)
	slot0:_clear()
end

function slot0._clear(slot0)
	if slot0._defaultVirtualCameraParams then
		for slot4, slot5 in ipairs(slot0._defaultVirtualCameraParams) do
			slot5.body = nil
			slot5.params = nil
		end

		slot0._defaultVirtualCameraParams = nil
	end

	TaskDispatcher.cancelTask(slot0._delaySetDefaultVirtualCameraParam, slot0)
	FightController.instance:unregisterCallback(FightEvent.ParallelPlayNextSkillDoneThis, slot0._parallelSkillDoneThis, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnUpdateSpeed, slot0._onUpdateSpeed, slot0)

	if slot0._animComp and slot0._animComp.runtimeAnimatorController == slot0._animatorInst then
		slot0._animComp.runtimeAnimatorController = nil
		slot0._animComp.enabled = false
	end

	if slot0._loader then
		slot0._loader:dispose()
	end

	slot0._loader = nil
	slot0._animComp = nil
	slot0._animatorInst = nil
end

return slot0
