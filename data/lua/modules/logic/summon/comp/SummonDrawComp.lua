module("modules.logic.summon.comp.SummonDrawComp", package.seeall)

slot0 = class("SummonDrawComp", LuaCompBase)
slot0.RareColor = {
	[2] = Vector4(0.8666666666666667, 0.8666666666666667, 0.8666666666666667, 1),
	[3] = Vector4(0.9763822004027117, 0.82616955418691, 1.3041188830553703, 1),
	[4] = Vector4(1.7411015986799718, 1.567903010329608, 1.0391915301021821, 1),
	[5] = Vector4(2.1185473757902837, 1.3088407871374528, 0.4325829720200056, 1)
}
slot0.Settings = {
	attenuation = 300000,
	minFinishSpeed = 3000,
	waterShowSpeed = 100,
	speedUpRate = 2,
	autoTurnDegree = 0,
	accelaration = 55,
	playerTurnDegree = 380,
	manualStepDegree = {
		0.5,
		0.7
	}
}
slot0.StepAudio = {
	AudioEnum.Summon.play_ui_callfor_cordage01,
	AudioEnum.Summon.play_ui_callfor_cordage02,
	AudioEnum.Summon.play_ui_callfor_cordage03
}
slot0.StepCount = 3
slot0.WaterInLeft = 1
slot0.WaterInRight = 2

function slot0.ctor(slot0, slot1)
	slot0._rootGO = gohelper.findChild(slot1, "anim")
	slot0._rootTf = slot0._rootGO.transform
	slot0._wheelGO = gohelper.findChild(slot1, "anim/StandStill/Obj-Plant/s06_Obj_d")
	slot0._wheelMirrorGO = gohelper.findChild(slot1, "anim/StandStill/Obj-Plant/s06_Obj_d/s06_Obj_d (1)")
	slot0._waterGO = gohelper.findChild(slot1, "anim/StandStill/Ground/s06_ground_a")
	slot0._ropeGO = gohelper.findChild(slot1, "anim/StandStill/Obj-Plant/s06_Obj_c002")
	slot0._ropeGlowGO = gohelper.findChild(slot1, "anim/StandStill/Obj-Plant/s06_Obj_c002/lineglow")
	slot0._lightGO = gohelper.findChild(slot1, "anim/Directional Light")
	slot0._lightGlowGO = gohelper.findChild(slot1, "anim/SceneEffect/light_glow")
	slot0._lineGlowGO = gohelper.findChild(slot1, "anim/StandStill/Obj-Plant/s06_Obj_c002/lineglow/lineglow")
	slot0._spotLightGO = gohelper.findChild(slot1, "anim/Spot Light")
	slot0._gachaEffectRootGO = gohelper.findChild(slot1, "anim/GachaEffect")
	slot0._wheelEffectRootGO = gohelper.findChild(slot1, "anim/WheelEffect/root")
	slot0._ropeAnim = slot0._ropeGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._ropeAnim.enabled = false
	slot0._wheelEffectRootTf = slot0._wheelEffectRootGO.transform
	slot0._canDraw = true
	slot0._finished = true
	slot0._turning = false
	slot0._updateDragAngle = 0
	slot0._prevAngle = 0
	slot0._angle = 0
	slot0._speed = 0
	slot0._attenuation = uv0.Settings.attenuation
	slot0._accelaration = uv0.Settings.accelaration
	slot0._finishSpeed = -100
	slot0._playerTurnDegree = uv0.Settings.playerTurnDegree
	slot0._autoTurnDegree = uv0.Settings.autoTurnDegree
	slot0._minFinishSpeed = uv0.Settings.minFinishSpeed
	slot0._stopFinishThreshold = 5
	slot0._currentDrawStep = 0
	slot0._maxWaterEffect = 0.1
	slot0._startAttachEffectDegree = 10
	slot0._stepEffectWraps = {}
	slot0._stepEffectRunning = {}
	slot0._waterEffectLWrap = nil
	slot0._waterEffectRWrap = nil
	slot0._waterEffectRunning = false
	slot0._waterEffectRunningPos = 0
	slot0._waterDelayCheckTime = 0.3
	slot0._wheelLightWrap = nil
	slot0._curAnimSpeed = 1
	slot0._ropeAnimName = nil
	slot0._canTrigger = true

	slot0:onCreate()
end

function slot0.onCreate(slot0)
	slot0._wheelMeshRenderer = slot0._wheelGO:GetComponent(typeof(UnityEngine.MeshRenderer))
	slot0._wheelMaterialPropertyBlock = UnityEngine.MaterialPropertyBlock.New()
	slot0._wheelMirrorMeshRenderer = slot0._wheelMirrorGO:GetComponent(typeof(UnityEngine.MeshRenderer))
	slot0._wheelMirrorMaterialPropertyBlock = UnityEngine.MaterialPropertyBlock.New()
	slot0._waterMeshRenderer = slot0._waterGO:GetComponent(typeof(UnityEngine.MeshRenderer))
	slot0._waterMaterialPropertyBlock = UnityEngine.MaterialPropertyBlock.New()
	slot0._ropeMeshRenderer = slot0._ropeGO:GetComponent(typeof(UnityEngine.MeshRenderer))
	slot0._ropeMaterialPropertyBlock = UnityEngine.MaterialPropertyBlock.New()
	slot0._light = slot0._lightGO:GetComponent(typeof(UnityEngine.Light))
	slot0._lightGlowMeshRenderer = slot0._lightGlowGO:GetComponent(typeof(UnityEngine.MeshRenderer))
	slot0._lightGlowMaterialPropertyBlock = UnityEngine.MaterialPropertyBlock.New()
	slot0._lineGlowMeshRenderer = slot0._lineGlowGO:GetComponent(typeof(UnityEngine.MeshRenderer))
	slot0._lineGlowMaterialPropertyBlock = UnityEngine.MaterialPropertyBlock.New()
	slot0._spotLight = slot0._spotLightGO:GetComponent(typeof(UnityEngine.Light))
end

function slot0.onUpdate(slot0)
	slot0:updateForDraw()
	slot0:updateForAnimStep()
	slot0:updateForWater()
	slot0:updateForAnimSpeed()
	slot0:updateForAttenuation()
	slot0:updateForAudioLoop()
end

function slot0.updateForDraw(slot0)
	if slot0._finished then
		return
	end

	if slot0._canDraw then
		if slot0._updateDragAngle > 0 and slot0._speed < 0 or slot0._updateDragAngle < 0 and slot0._speed > 0 then
			slot0._speed = slot0._accelaration * slot0._updateDragAngle
		else
			slot0._speed = slot0._speed + slot0._accelaration * slot0._updateDragAngle
		end

		slot0._updateDragAngle = 0
	else
		slot1 = (slot0._angle - slot0._playerTurnDegree) / slot0._autoTurnDegree
		slot0._speed = slot0._finishSpeed * (1 - slot1 * slot1)

		if math.abs(slot0._speed) < math.max(5, slot0._finishSpeed) then
			slot0:_completeDraw()
		end
	end

	slot0:_addAngle(slot0._speed * Time.deltaTime)
	slot0:_setSpeedEffect(slot0._speed, Time.deltaTime)

	if math.abs(slot0._speed) > 100 then
		if slot0._canTrigger then
			slot0._canTrigger = false
		end
	else
		slot0._canTrigger = true
	end
end

function slot0.updateForAnimStep(slot0)
	if slot0._canDraw then
		slot2 = slot0._ropeAnimName
		slot4 = 0
		slot0._ropeAnimName = nil

		if slot0._startAttachEffectDegree <= slot0._angle then
			if slot0._angle / slot0._playerTurnDegree < uv0.Settings.manualStepDegree[1] then
				slot4 = 1
			elseif slot3 < uv0.Settings.manualStepDegree[2] then
				slot4 = 2
				slot0._ropeAnimName = "xian1"
			else
				slot4 = 3
				slot0._ropeAnimName = "xian2"
			end
		end

		if slot4 ~= slot0._currentDrawStep then
			slot0._currentDrawStep = slot4

			slot0:_setCurGachaEffect()
		end

		if slot2 ~= slot0._ropeAnimName then
			if slot0._ropeAnimName then
				slot0._ropeAnim.enabled = true

				slot0._ropeAnim:Play(slot0._ropeAnimName, 0, 0)
			else
				slot0._ropeAnim.enabled = false
			end
		end
	end
end

function slot0.updateForWater(slot0)
	if slot0._waterEffectLWrap and slot0._waterEffectRWrap then
		if uv0.Settings.waterShowSpeed <= math.abs(slot0._speed) then
			if (slot0._speed > 0 and uv0.WaterInLeft or uv0.WaterInRight) == uv0.WaterInLeft and slot0._waterEffectRunningPos ~= uv0.WaterInLeft then
				slot0._waterEffectLWrap:stopParticle()
				slot0._waterEffectRWrap:startParticle()

				slot0._waterEffectRunningPos = uv0.WaterInLeft
				slot0._lastWaterTime = Time.time

				AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_callfor_spray)
			elseif slot3 == uv0.WaterInRight and slot0._waterEffectRunningPos ~= uv0.WaterInRight then
				slot0._waterEffectRWrap:stopParticle()
				slot0._waterEffectLWrap:startParticle()

				slot0._waterEffectRunningPos = uv0.WaterInRight
				slot0._lastWaterTime = Time.time

				AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_callfor_spray)
			end

			slot0._waterEffectRunning = true
		elseif not slot2 and slot0._waterEffectRunning then
			if slot0._lastWaterTime and slot0._waterDelayCheckTime <= Time.time - slot0._lastWaterTime then
				slot0._waterEffectLWrap:stopParticle()
				slot0._waterEffectRWrap:stopParticle()

				slot0._waterEffectRunning = false
				slot0._waterEffectRunningPos = 0

				AudioMgr.instance:trigger(AudioEnum.Summon.stop_ui_callfor_spray)
			end
		end
	end
end

function slot0.updateForAudioLoop(slot0)
	if slot0._finished then
		return
	end

	if not slot0._audioLoopRunning and math.abs(slot0._speed) > 0 then
		slot0._audioLoopRunning = true

		AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_callfor_waterwheelloop)
	elseif slot0._audioLoopRunning and slot1 <= 0.01 then
		slot0._audioLoopRunning = false

		AudioMgr.instance:trigger(AudioEnum.Summon.stop_ui_callfor_waterwheelloop)
		AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_callfor_waterwheelstop)
	end
end

function slot0.updateForAnimSpeed(slot0)
	if slot0._angle ~= slot0._lastFrameAngle then
		slot0:_refreshAttachEffectSpeed()

		slot0._lastFrameAngle = slot0._angle
	end
end

function slot0.updateForAttenuation(slot0)
	if slot0._canDraw then
		if slot0._speed > 0 then
			slot0._speed = math.max(0, slot0._speed - slot0._attenuation * Time.deltaTime)

			if slot0._angle <= 0 then
				slot0._speed = 0
			end
		else
			slot0._speed = math.min(0, slot0._speed + slot0._attenuation * Time.deltaTime)
		end
	end
end

function slot0._refreshAttachEffectSpeed(slot0)
	if slot0._angle / slot0._playerTurnDegree > 0 and slot2 <= 1 then
		slot0._curAnimSpeed = Mathf.Lerp(1, uv0.Settings.speedUpRate, slot2)
	else
		slot0._curAnimSpeed = 1
	end

	for slot6, slot7 in pairs(slot0._stepEffectWraps) do
		if slot7:getIsActive() then
			if (uv0.Settings.manualStepDegree[slot6] or 1) - (uv0.Settings.manualStepDegree[slot6 - 1] or 0) >= 0 then
				slot8 = (slot2 - slot9) / (slot8 - slot9)
			end

			slot7:setSpeed(Mathf.Lerp(1, uv0.Settings.speedUpRate, slot8))
		end
	end
end

function slot0._addAngle(slot0, slot1)
	if slot0._finished then
		return
	end

	slot0._angle = math.max(0, math.min(slot0._playerTurnDegree + slot0._autoTurnDegree, slot0._angle - slot1))

	slot0:_setAngleEffect(slot0._angle)

	if slot0._angle >= slot0._playerTurnDegree + slot0._autoTurnDegree then
		slot0:_completeDraw()

		slot0._canDraw = false
		slot0._turning = false
	elseif slot0._canDraw and slot0._playerTurnDegree <= slot0._angle then
		slot0._canDraw = false
		slot0._turning = false
		slot0._speed = math.min(slot0._speed, slot0._minFinishSpeed)
		slot0._finishSpeed = slot0._speed
	end

	slot2 = 1 - slot0._angle / (slot0._playerTurnDegree + slot0._autoTurnDegree)

	slot0:setEffect(math.max(0, slot2 * slot2))
end

function slot0._setAngleEffect(slot0, slot1)
	if slot0._wheelMeshRenderer and slot0._wheelMaterialPropertyBlock then
		slot2 = slot0._wheelMeshRenderer.material:GetVector("_Rotation")

		slot0._wheelMaterialPropertyBlock:SetVector("_Rotation", Vector4.New(slot2.x, slot2.y, slot1, slot2.w))
		slot0._wheelMeshRenderer:SetPropertyBlock(slot0._wheelMaterialPropertyBlock)
	end

	if slot0._wheelMirrorMeshRenderer and slot0._wheelMirrorMaterialPropertyBlock then
		slot2 = slot0._wheelMirrorMeshRenderer.material:GetVector("_Rotation")

		slot0._wheelMirrorMaterialPropertyBlock:SetVector("_Rotation", Vector4.New(slot2.x, slot2.y, slot1, slot2.w))
		slot0._wheelMirrorMeshRenderer:SetPropertyBlock(slot0._wheelMirrorMaterialPropertyBlock)
	end

	if slot0._wheelLightWrap and not gohelper.isNil(slot0._wheelEffectRootTf) then
		transformhelper.setLocalRotation(slot0._wheelEffectRootTf, 0, 0, -slot1)
	end
end

function slot0.setEffect(slot0, slot1)
	if slot0._ropeMeshRenderer and slot0._ropeMaterialPropertyBlock then
		slot2 = slot0._ropeMeshRenderer.material:GetVector("_EdgeWith")
		slot3 = 0
		slot4 = 0

		if slot1 > 0.75 then
			slot3 = 16 * (slot1 - 0.75)
		end

		if slot1 < 0.75 then
			slot4 = 1.5 * (0.75 - slot1)
		end

		slot0._ropeMaterialPropertyBlock:SetVector("_EdgeWith", Vector4.New(slot2.x, slot3, slot4, slot2.w))
		slot0._ropeMeshRenderer:SetPropertyBlock(slot0._ropeMaterialPropertyBlock)
	end

	if slot0._ropeGlowGO then
		slot2, slot3, slot4 = transformhelper.getLocalScale(slot0._ropeGlowGO.transform)
		slot5 = 0

		if slot1 < 0.75 then
			slot5 = 0.6666666666666666 * (0.75 - slot1)
		end

		transformhelper.setLocalScale(slot0._ropeGlowGO.transform, slot5, slot3, slot4)
	end

	if slot0._lightGlowGO then
		slot2 = 0

		if slot1 < 0.75 then
			slot2 = 32 * (0.75 - slot1)
		end

		gohelper.setActive(slot0._lightGlowGO, slot2 > 0)
		transformhelper.setLocalScale(slot0._lightGlowGO.transform, slot2, slot2, slot2)
	end

	if slot0._lightGlowMeshRenderer and slot0._lightGlowMaterialPropertyBlock then
		slot2 = slot0._lightGlowMeshRenderer.material:GetVector("_MainColor")
		slot3 = 0

		if slot1 < 0.75 then
			slot3 = 164 * (0.75 - slot1)
		end

		slot0._lightGlowMaterialPropertyBlock:SetVector("_MainColor", Vector4.New(slot2.x, slot2.y, slot2.z, slot3 / 255))
		slot0._lightGlowMeshRenderer:SetPropertyBlock(slot0._lightGlowMaterialPropertyBlock)
	end

	if slot0._rootGO then
		slot4, slot5 = transformhelper.getLocalPos(slot0._rootGO.transform)
		slot6, slot7, slot8 = transformhelper.getLocalRotation(slot0._rootGO.transform)

		transformhelper.setLocalPos(slot0._rootGO.transform, slot4, slot5, -6 * (1 - slot1))
		transformhelper.setLocalRotation(slot0._rootGO.transform, 1 - slot1, slot7, slot8)
	end

	if slot0._light then
		slot2 = slot0._light.color
		slot3 = 26 * (1 - slot1)
		slot0._light.color = Color(slot3 / 255, slot3 / 255, slot3 / 255, 0)
	end

	if not slot0._tweened and slot0._fake and slot0._rare == 5 and slot1 < 0.3 then
		slot0._tweened = true
		slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.3, slot0._tween, nil, slot0)
	end

	if slot0._spotLight then
		slot0._spotLight.range = 45 * (1 - slot1)
	end
end

function slot0._setSpeedEffect(slot0, slot1, slot2)
	if slot0._waterMeshRenderer and slot0._waterMaterialPropertyBlock then
		slot3 = slot0._waterMeshRenderer.material:GetVector("_Radial")
		slot4 = slot3.w

		slot0._waterMaterialPropertyBlock:SetVector("_Radial", Vector4.New(slot3.x, slot3.y, slot3.z, math.min(math.abs(slot1 / 500) * slot0._maxWaterEffect, slot0._maxWaterEffect)))
		slot0._waterMeshRenderer:SetPropertyBlock(slot0._waterMaterialPropertyBlock)
	end
end

function slot0._setCurGachaEffect(slot0)
	slot1 = {}
	slot2 = false

	for slot7 = 1, uv0.StepCount do
		if slot0._stepEffectWraps[slot7] ~= nil then
			if not slot0._stepEffectRunning[slot7] and (slot7 <= slot0._currentDrawStep and slot0._startAttachEffectDegree <= slot0._angle) then
				slot8:setActive(true)
				slot8:setSpeed(slot0._curAnimSpeed)

				slot0._stepEffectRunning[slot7] = true
				slot2 = true
			elseif slot10 and not slot9 then
				slot8:setActive(false)

				slot0._stepEffectRunning[slot7] = false
				slot2 = true
			end
		end
	end

	if slot0._wheelLightWrap then
		slot0._wheelLightWrap:setActive(slot3)
	end

	if slot2 then
		slot0:_refreshAttachEffectSpeed()
		slot0:stopStepAudio()

		if uv0.StepAudio[slot0._currentDrawStep] then
			AudioMgr.instance:trigger(uv0.StepAudio[slot0._currentDrawStep])
		end
	end
end

function slot0._loadStepEffects(slot0)
	if not string.nilorempty(SummonEnum.SummonQualityDefine[slot0._rare]) then
		for slot5 = 1, uv0.StepCount do
			slot8 = nil

			if not string.nilorempty(SummonEnum.SummonPreloadPath[string.format("Scene%sStep%s", slot1, slot5)]) then
				slot8 = SummonEffectPool.getEffect(slot7, slot0._gachaEffectRootGO)
			end

			if slot8 ~= nil then
				slot0._stepEffectWraps[slot5] = slot8

				slot8:setActive(false)
			end
		end
	end
end

function slot0._loadWaterEffect(slot0)
	if string.nilorempty(SummonEnum.SummonQualityDefine[slot0._rare]) then
		return
	end

	if not slot0._waterEffectLWrap then
		slot0._waterEffectLWrap = SummonEffectPool.getEffect(SummonEnum.SummonPreloadPath.SceneRollWaterL, slot0._gachaEffectRootGO)

		slot0._waterEffectLWrap:stopParticle()
	end

	if not slot0._waterEffectRWrap then
		slot0._waterEffectRWrap = SummonEffectPool.getEffect(SummonEnum.SummonPreloadPath.SceneRollWaterR, slot0._gachaEffectRootGO)

		slot0._waterEffectRWrap:stopParticle()
	end
end

function slot0._loadWheelEffect(slot0)
	if string.nilorempty(SummonEnum.SummonQualityDefine[slot0._rare]) then
		return
	end

	if not slot0._wheelLightWrap then
		if not string.nilorempty(SummonEnum.SummonPreloadPath[string.format("Scene%sWheel", slot1)]) then
			slot0._wheelLightWrap = SummonEffectPool.getEffect(slot3, slot0._wheelEffectRootGO)

			slot0._wheelLightWrap:setActive(false)
		else
			logError("can't find keyName = [" .. tostring(slot2) .. "] in path")
		end
	end
end

function slot0.onDestroy(slot0)
	slot0:stopAudio()
	slot0:recycleEffects()

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	slot0._wheelGO = nil
	slot0._wheelMirrorGO = nil
	slot0._waterGO = nil
	slot0._wheelMeshRenderer = nil
	slot0._wheelMirrorMeshRenderer = nil
	slot0._waterMeshRenderer = nil
	slot0._ropeMeshRenderer = nil
	slot0._lightGlowMeshRenderer = nil
	slot0._lineGlowMeshRenderer = nil

	if slot0._wheelMaterialPropertyBlock then
		slot0._wheelMaterialPropertyBlock:Clear()

		slot0._wheelMaterialPropertyBlock = nil
	end

	if slot0._wheelMirrorMaterialPropertyBlock then
		slot0._wheelMirrorMaterialPropertyBlock:Clear()

		slot0._wheelMirrorMaterialPropertyBlock = nil
	end

	if slot0._waterMaterialPropertyBlock then
		slot0._waterMaterialPropertyBlock:Clear()

		slot0._waterMaterialPropertyBlock = nil
	end

	if slot0._ropeMaterialPropertyBlock then
		slot0._ropeMaterialPropertyBlock:Clear()

		slot0._ropeMaterialPropertyBlock = nil
	end

	if slot0._lightGlowMaterialPropertyBlock then
		slot0._lightGlowMaterialPropertyBlock:Clear()

		slot0._lightGlowMaterialPropertyBlock = nil
	end

	if slot0._lineGlowMaterialPropertyBlock then
		slot0._lineGlowMaterialPropertyBlock:Clear()

		slot0._lineGlowMaterialPropertyBlock = nil
	end
end

function slot0.resetDraw(slot0, slot1)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	slot0._currentDrawStep = 0
	slot0._tweened = false
	slot0._prevAngle = 0
	slot0._angle = 0
	slot0._speed = 0
	slot0._updateDragAngle = 0
	slot0._finished = false
	slot0._turning = false
	slot0._canDraw = true
	slot0._canTrigger = true
	slot0._curAnimSpeed = 1
	slot0._rare = slot1
	slot0._fake = math.random(0, 100) < 50
	slot2 = uv0.RareColor[slot0._rare] or uv0.RareColor[2]

	if slot0._rare == 5 and slot0._fake then
		slot2 = uv0.RareColor[4]
	end

	if slot0._lineGlowMeshRenderer and slot0._lineGlowMaterialPropertyBlock then
		slot0._lineGlowMaterialPropertyBlock:SetVector("_MainColor", slot2)
		slot0._lineGlowMeshRenderer:SetPropertyBlock(slot0._lineGlowMaterialPropertyBlock)
	end

	if slot0._ropeMeshRenderer and slot0._ropeMaterialPropertyBlock then
		slot0._ropeMaterialPropertyBlock:SetVector("_AddCol", slot2)
		slot0._ropeMeshRenderer:SetPropertyBlock(slot0._ropeMaterialPropertyBlock)
	end

	slot0._ropeAnim.enabled = false
	slot0._ropeAnimName = nil

	slot0:recycleEffects()
	slot0:_loadWaterEffect()
	slot0:_loadWheelEffect()
	slot0:_loadStepEffects()
end

function slot0.skip(slot0)
	slot0:setEffect(1)

	if slot0._finished then
		return
	end

	slot0._currentDrawStep = 0
	slot0._tweened = false
	slot0._prevAngle = 0
	slot0._speed = 0
	slot0._updateDragAngle = 0
	slot0._finished = false
	slot0._turning = false
	slot0._canDraw = true
	slot0._canTrigger = true
	slot0._curAnimSpeed = 1
	slot0._ropeAnim.enabled = false
	slot0._ropeAnimName = nil

	slot0:stopAudio()
	slot0:recycleEffects()
end

function slot0.recycleEffects(slot0)
	if slot0._waterEffectLWrap ~= nil then
		SummonEffectPool.returnEffect(slot0._waterEffectLWrap)

		slot0._waterEffectLWrap = nil
	end

	if slot0._waterEffectRWrap ~= nil then
		SummonEffectPool.returnEffect(slot0._waterEffectRWrap)

		slot0._waterEffectRWrap = nil
	end

	slot0._waterEffectRunning = false
	slot0._waterEffectRunningPos = 0

	if slot0._wheelLightWrap ~= nil then
		SummonEffectPool.returnEffect(slot0._wheelLightWrap)

		slot0._wheelLightWrap = nil
	end

	for slot4, slot5 in pairs(slot0._stepEffectWraps) do
		SummonEffectPool.returnEffect(slot5)

		slot0._stepEffectWraps[slot4] = nil
	end

	for slot4 = 1, uv0.StepCount do
		slot0._stepEffectRunning[slot4] = false
	end
end

function slot0.stopStepAudio(slot0)
	AudioMgr.instance:trigger(AudioEnum.Summon.stop_ui_callfor_cordage01)
	AudioMgr.instance:trigger(AudioEnum.Summon.stop_ui_callfor_cordage02)
	AudioMgr.instance:trigger(AudioEnum.Summon.stop_ui_callfor_cordage03)
end

function slot0.stopAudio(slot0)
	slot0._audioLoopRunning = false

	AudioMgr.instance:trigger(AudioEnum.Summon.stop_ui_callfor_waterwheelloop)
	AudioMgr.instance:trigger(AudioEnum.Summon.stop_ui_callfor_spray)
	slot0:stopStepAudio()
end

function slot0._tween(slot0, slot1)
	if slot0._lineGlowMeshRenderer and slot0._lineGlowMaterialPropertyBlock then
		slot0._lineGlowMaterialPropertyBlock:SetVector("_MainColor", uv0.RareColor[4] * (1 - slot1) + uv0.RareColor[5] * slot1)
		slot0._lineGlowMeshRenderer:SetPropertyBlock(slot0._lineGlowMaterialPropertyBlock)
	end
end

function slot0.startTurn(slot0)
	if not slot0._canDraw then
		return
	end

	slot0._turning = true
	slot0._speed = 0
end

function slot0.updateAngle(slot0, slot1)
	if not slot0._canDraw then
		return
	end

	slot0._turning = true
	slot0._updateDragAngle = slot0._updateDragAngle + slot1
end

function slot0.endTurn(slot0)
	if not slot0._canDraw then
		return
	end

	slot0._turning = false
end

function slot0.getStepEffectContainer(slot0)
	return slot0._gachaEffectRootGO
end

function slot0._completeDraw(slot0)
	if slot0._finished then
		return
	end

	slot0._finished = true

	slot0:stopAudio()
	slot0:recycleEffects()
	SummonController.instance:dispatchEvent(SummonEvent.onSummonDraw)
end

return slot0
