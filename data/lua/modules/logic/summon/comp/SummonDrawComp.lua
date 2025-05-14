module("modules.logic.summon.comp.SummonDrawComp", package.seeall)

local var_0_0 = class("SummonDrawComp", LuaCompBase)

var_0_0.RareColor = {
	[2] = Vector4(0.8666666666666667, 0.8666666666666667, 0.8666666666666667, 1),
	[3] = Vector4(0.9763822004027117, 0.82616955418691, 1.3041188830553703, 1),
	[4] = Vector4(1.7411015986799718, 1.567903010329608, 1.0391915301021821, 1),
	[5] = Vector4(2.1185473757902837, 1.3088407871374528, 0.4325829720200056, 1)
}
var_0_0.Settings = {
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
var_0_0.StepAudio = {
	AudioEnum.Summon.play_ui_callfor_cordage01,
	AudioEnum.Summon.play_ui_callfor_cordage02,
	AudioEnum.Summon.play_ui_callfor_cordage03
}
var_0_0.StepCount = 3
var_0_0.WaterInLeft = 1
var_0_0.WaterInRight = 2

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._rootGO = gohelper.findChild(arg_1_1, "anim")
	arg_1_0._rootTf = arg_1_0._rootGO.transform
	arg_1_0._wheelGO = gohelper.findChild(arg_1_1, "anim/StandStill/Obj-Plant/s06_Obj_d")
	arg_1_0._wheelMirrorGO = gohelper.findChild(arg_1_1, "anim/StandStill/Obj-Plant/s06_Obj_d/s06_Obj_d (1)")
	arg_1_0._waterGO = gohelper.findChild(arg_1_1, "anim/StandStill/Ground/s06_ground_a")
	arg_1_0._ropeGO = gohelper.findChild(arg_1_1, "anim/StandStill/Obj-Plant/s06_Obj_c002")
	arg_1_0._ropeGlowGO = gohelper.findChild(arg_1_1, "anim/StandStill/Obj-Plant/s06_Obj_c002/lineglow")
	arg_1_0._lightGO = gohelper.findChild(arg_1_1, "anim/Directional Light")
	arg_1_0._lightGlowGO = gohelper.findChild(arg_1_1, "anim/SceneEffect/light_glow")
	arg_1_0._lineGlowGO = gohelper.findChild(arg_1_1, "anim/StandStill/Obj-Plant/s06_Obj_c002/lineglow/lineglow")
	arg_1_0._spotLightGO = gohelper.findChild(arg_1_1, "anim/Spot Light")
	arg_1_0._gachaEffectRootGO = gohelper.findChild(arg_1_1, "anim/GachaEffect")
	arg_1_0._wheelEffectRootGO = gohelper.findChild(arg_1_1, "anim/WheelEffect/root")
	arg_1_0._ropeAnim = arg_1_0._ropeGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._ropeAnim.enabled = false
	arg_1_0._wheelEffectRootTf = arg_1_0._wheelEffectRootGO.transform
	arg_1_0._canDraw = true
	arg_1_0._finished = true
	arg_1_0._turning = false
	arg_1_0._updateDragAngle = 0
	arg_1_0._prevAngle = 0
	arg_1_0._angle = 0
	arg_1_0._speed = 0
	arg_1_0._attenuation = var_0_0.Settings.attenuation
	arg_1_0._accelaration = var_0_0.Settings.accelaration
	arg_1_0._finishSpeed = -100
	arg_1_0._playerTurnDegree = var_0_0.Settings.playerTurnDegree
	arg_1_0._autoTurnDegree = var_0_0.Settings.autoTurnDegree
	arg_1_0._minFinishSpeed = var_0_0.Settings.minFinishSpeed
	arg_1_0._stopFinishThreshold = 5
	arg_1_0._currentDrawStep = 0
	arg_1_0._maxWaterEffect = 0.1
	arg_1_0._startAttachEffectDegree = 10
	arg_1_0._stepEffectWraps = {}
	arg_1_0._stepEffectRunning = {}
	arg_1_0._waterEffectLWrap = nil
	arg_1_0._waterEffectRWrap = nil
	arg_1_0._waterEffectRunning = false
	arg_1_0._waterEffectRunningPos = 0
	arg_1_0._waterDelayCheckTime = 0.3
	arg_1_0._wheelLightWrap = nil
	arg_1_0._curAnimSpeed = 1
	arg_1_0._ropeAnimName = nil
	arg_1_0._canTrigger = true

	arg_1_0:onCreate()
end

function var_0_0.onCreate(arg_2_0)
	arg_2_0._wheelMeshRenderer = arg_2_0._wheelGO:GetComponent(typeof(UnityEngine.MeshRenderer))
	arg_2_0._wheelMaterialPropertyBlock = UnityEngine.MaterialPropertyBlock.New()
	arg_2_0._wheelMirrorMeshRenderer = arg_2_0._wheelMirrorGO:GetComponent(typeof(UnityEngine.MeshRenderer))
	arg_2_0._wheelMirrorMaterialPropertyBlock = UnityEngine.MaterialPropertyBlock.New()
	arg_2_0._waterMeshRenderer = arg_2_0._waterGO:GetComponent(typeof(UnityEngine.MeshRenderer))
	arg_2_0._waterMaterialPropertyBlock = UnityEngine.MaterialPropertyBlock.New()
	arg_2_0._ropeMeshRenderer = arg_2_0._ropeGO:GetComponent(typeof(UnityEngine.MeshRenderer))
	arg_2_0._ropeMaterialPropertyBlock = UnityEngine.MaterialPropertyBlock.New()
	arg_2_0._light = arg_2_0._lightGO:GetComponent(typeof(UnityEngine.Light))
	arg_2_0._lightGlowMeshRenderer = arg_2_0._lightGlowGO:GetComponent(typeof(UnityEngine.MeshRenderer))
	arg_2_0._lightGlowMaterialPropertyBlock = UnityEngine.MaterialPropertyBlock.New()
	arg_2_0._lineGlowMeshRenderer = arg_2_0._lineGlowGO:GetComponent(typeof(UnityEngine.MeshRenderer))
	arg_2_0._lineGlowMaterialPropertyBlock = UnityEngine.MaterialPropertyBlock.New()
	arg_2_0._spotLight = arg_2_0._spotLightGO:GetComponent(typeof(UnityEngine.Light))
end

function var_0_0.onUpdate(arg_3_0)
	arg_3_0:updateForDraw()
	arg_3_0:updateForAnimStep()
	arg_3_0:updateForWater()
	arg_3_0:updateForAnimSpeed()
	arg_3_0:updateForAttenuation()
	arg_3_0:updateForAudioLoop()
end

function var_0_0.updateForDraw(arg_4_0)
	if arg_4_0._finished then
		return
	end

	if arg_4_0._canDraw then
		if arg_4_0._updateDragAngle > 0 and arg_4_0._speed < 0 or arg_4_0._updateDragAngle < 0 and arg_4_0._speed > 0 then
			arg_4_0._speed = arg_4_0._accelaration * arg_4_0._updateDragAngle
		else
			arg_4_0._speed = arg_4_0._speed + arg_4_0._accelaration * arg_4_0._updateDragAngle
		end

		arg_4_0._updateDragAngle = 0
	else
		local var_4_0 = (arg_4_0._angle - arg_4_0._playerTurnDegree) / arg_4_0._autoTurnDegree

		arg_4_0._speed = arg_4_0._finishSpeed * (1 - var_4_0 * var_4_0)

		if math.abs(arg_4_0._speed) < math.max(5, arg_4_0._finishSpeed) then
			arg_4_0:_completeDraw()
		end
	end

	arg_4_0:_addAngle(arg_4_0._speed * Time.deltaTime)
	arg_4_0:_setSpeedEffect(arg_4_0._speed, Time.deltaTime)

	if math.abs(arg_4_0._speed) > 100 then
		if arg_4_0._canTrigger then
			arg_4_0._canTrigger = false
		end
	else
		arg_4_0._canTrigger = true
	end
end

function var_0_0.updateForAnimStep(arg_5_0)
	local var_5_0 = arg_5_0._playerTurnDegree

	if arg_5_0._canDraw then
		local var_5_1 = arg_5_0._ropeAnimName
		local var_5_2 = arg_5_0._angle / var_5_0
		local var_5_3 = 0

		arg_5_0._ropeAnimName = nil

		if arg_5_0._angle >= arg_5_0._startAttachEffectDegree then
			if var_5_2 < var_0_0.Settings.manualStepDegree[1] then
				var_5_3 = 1
			elseif var_5_2 < var_0_0.Settings.manualStepDegree[2] then
				var_5_3 = 2
				arg_5_0._ropeAnimName = "xian1"
			else
				var_5_3 = 3
				arg_5_0._ropeAnimName = "xian2"
			end
		end

		if var_5_3 ~= arg_5_0._currentDrawStep then
			arg_5_0._currentDrawStep = var_5_3

			arg_5_0:_setCurGachaEffect()
		end

		if var_5_1 ~= arg_5_0._ropeAnimName then
			if arg_5_0._ropeAnimName then
				arg_5_0._ropeAnim.enabled = true

				arg_5_0._ropeAnim:Play(arg_5_0._ropeAnimName, 0, 0)
			else
				arg_5_0._ropeAnim.enabled = false
			end
		end
	end
end

function var_0_0.updateForWater(arg_6_0)
	if arg_6_0._waterEffectLWrap and arg_6_0._waterEffectRWrap then
		local var_6_0 = math.abs(arg_6_0._speed) >= var_0_0.Settings.waterShowSpeed

		if var_6_0 then
			local var_6_1 = arg_6_0._speed > 0 and var_0_0.WaterInLeft or var_0_0.WaterInRight

			if var_6_1 == var_0_0.WaterInLeft and arg_6_0._waterEffectRunningPos ~= var_0_0.WaterInLeft then
				arg_6_0._waterEffectLWrap:stopParticle()
				arg_6_0._waterEffectRWrap:startParticle()

				arg_6_0._waterEffectRunningPos = var_0_0.WaterInLeft
				arg_6_0._lastWaterTime = Time.time

				AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_callfor_spray)
			elseif var_6_1 == var_0_0.WaterInRight and arg_6_0._waterEffectRunningPos ~= var_0_0.WaterInRight then
				arg_6_0._waterEffectRWrap:stopParticle()
				arg_6_0._waterEffectLWrap:startParticle()

				arg_6_0._waterEffectRunningPos = var_0_0.WaterInRight
				arg_6_0._lastWaterTime = Time.time

				AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_callfor_spray)
			end

			arg_6_0._waterEffectRunning = true
		elseif not var_6_0 and arg_6_0._waterEffectRunning then
			local var_6_2 = Time.time

			if arg_6_0._lastWaterTime and var_6_2 - arg_6_0._lastWaterTime >= arg_6_0._waterDelayCheckTime then
				arg_6_0._waterEffectLWrap:stopParticle()
				arg_6_0._waterEffectRWrap:stopParticle()

				arg_6_0._waterEffectRunning = false
				arg_6_0._waterEffectRunningPos = 0

				AudioMgr.instance:trigger(AudioEnum.Summon.stop_ui_callfor_spray)
			end
		end
	end
end

function var_0_0.updateForAudioLoop(arg_7_0)
	if arg_7_0._finished then
		return
	end

	local var_7_0 = math.abs(arg_7_0._speed)

	if not arg_7_0._audioLoopRunning and var_7_0 > 0 then
		arg_7_0._audioLoopRunning = true

		AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_callfor_waterwheelloop)
	elseif arg_7_0._audioLoopRunning and var_7_0 <= 0.01 then
		arg_7_0._audioLoopRunning = false

		AudioMgr.instance:trigger(AudioEnum.Summon.stop_ui_callfor_waterwheelloop)
		AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_callfor_waterwheelstop)
	end
end

function var_0_0.updateForAnimSpeed(arg_8_0)
	if arg_8_0._angle ~= arg_8_0._lastFrameAngle then
		arg_8_0:_refreshAttachEffectSpeed()

		arg_8_0._lastFrameAngle = arg_8_0._angle
	end
end

function var_0_0.updateForAttenuation(arg_9_0)
	if arg_9_0._canDraw then
		if arg_9_0._speed > 0 then
			arg_9_0._speed = math.max(0, arg_9_0._speed - arg_9_0._attenuation * Time.deltaTime)

			if arg_9_0._angle <= 0 then
				arg_9_0._speed = 0
			end
		else
			arg_9_0._speed = math.min(0, arg_9_0._speed + arg_9_0._attenuation * Time.deltaTime)
		end
	end
end

function var_0_0._refreshAttachEffectSpeed(arg_10_0)
	local var_10_0 = arg_10_0._playerTurnDegree
	local var_10_1 = arg_10_0._angle / var_10_0

	if var_10_1 > 0 and var_10_1 <= 1 then
		arg_10_0._curAnimSpeed = Mathf.Lerp(1, var_0_0.Settings.speedUpRate, var_10_1)
	else
		arg_10_0._curAnimSpeed = 1
	end

	for iter_10_0, iter_10_1 in pairs(arg_10_0._stepEffectWraps) do
		if iter_10_1:getIsActive() then
			local var_10_2 = var_0_0.Settings.manualStepDegree[iter_10_0] or 1
			local var_10_3 = var_0_0.Settings.manualStepDegree[iter_10_0 - 1] or 0

			if var_10_2 - var_10_3 >= 0 then
				var_10_2 = (var_10_1 - var_10_3) / (var_10_2 - var_10_3)
			end

			local var_10_4 = Mathf.Lerp(1, var_0_0.Settings.speedUpRate, var_10_2)

			iter_10_1:setSpeed(var_10_4)
		end
	end
end

function var_0_0._addAngle(arg_11_0, arg_11_1)
	if arg_11_0._finished then
		return
	end

	arg_11_0._angle = math.max(0, math.min(arg_11_0._playerTurnDegree + arg_11_0._autoTurnDegree, arg_11_0._angle - arg_11_1))

	arg_11_0:_setAngleEffect(arg_11_0._angle)

	if arg_11_0._angle >= arg_11_0._playerTurnDegree + arg_11_0._autoTurnDegree then
		arg_11_0:_completeDraw()

		arg_11_0._canDraw = false
		arg_11_0._turning = false
	elseif arg_11_0._canDraw and arg_11_0._angle >= arg_11_0._playerTurnDegree then
		arg_11_0._canDraw = false
		arg_11_0._turning = false
		arg_11_0._speed = math.min(arg_11_0._speed, arg_11_0._minFinishSpeed)
		arg_11_0._finishSpeed = arg_11_0._speed
	end

	local var_11_0 = 1 - arg_11_0._angle / (arg_11_0._playerTurnDegree + arg_11_0._autoTurnDegree)
	local var_11_1 = math.max(0, var_11_0 * var_11_0)

	arg_11_0:setEffect(var_11_1)
end

function var_0_0._setAngleEffect(arg_12_0, arg_12_1)
	if arg_12_0._wheelMeshRenderer and arg_12_0._wheelMaterialPropertyBlock then
		local var_12_0 = arg_12_0._wheelMeshRenderer.material:GetVector("_Rotation")

		arg_12_0._wheelMaterialPropertyBlock:SetVector("_Rotation", Vector4.New(var_12_0.x, var_12_0.y, arg_12_1, var_12_0.w))
		arg_12_0._wheelMeshRenderer:SetPropertyBlock(arg_12_0._wheelMaterialPropertyBlock)
	end

	if arg_12_0._wheelMirrorMeshRenderer and arg_12_0._wheelMirrorMaterialPropertyBlock then
		local var_12_1 = arg_12_0._wheelMirrorMeshRenderer.material:GetVector("_Rotation")

		arg_12_0._wheelMirrorMaterialPropertyBlock:SetVector("_Rotation", Vector4.New(var_12_1.x, var_12_1.y, arg_12_1, var_12_1.w))
		arg_12_0._wheelMirrorMeshRenderer:SetPropertyBlock(arg_12_0._wheelMirrorMaterialPropertyBlock)
	end

	if arg_12_0._wheelLightWrap and not gohelper.isNil(arg_12_0._wheelEffectRootTf) then
		transformhelper.setLocalRotation(arg_12_0._wheelEffectRootTf, 0, 0, -arg_12_1)
	end
end

function var_0_0.setEffect(arg_13_0, arg_13_1)
	if arg_13_0._ropeMeshRenderer and arg_13_0._ropeMaterialPropertyBlock then
		local var_13_0 = arg_13_0._ropeMeshRenderer.material:GetVector("_EdgeWith")
		local var_13_1 = 0
		local var_13_2 = 0

		if arg_13_1 > 0.75 then
			var_13_1 = 16 * (arg_13_1 - 0.75)
		end

		if arg_13_1 < 0.75 then
			var_13_2 = 1.5 * (0.75 - arg_13_1)
		end

		arg_13_0._ropeMaterialPropertyBlock:SetVector("_EdgeWith", Vector4.New(var_13_0.x, var_13_1, var_13_2, var_13_0.w))
		arg_13_0._ropeMeshRenderer:SetPropertyBlock(arg_13_0._ropeMaterialPropertyBlock)
	end

	if arg_13_0._ropeGlowGO then
		local var_13_3, var_13_4, var_13_5 = transformhelper.getLocalScale(arg_13_0._ropeGlowGO.transform)
		local var_13_6 = 0

		if arg_13_1 < 0.75 then
			var_13_6 = 0.6666666666666666 * (0.75 - arg_13_1)
		end

		transformhelper.setLocalScale(arg_13_0._ropeGlowGO.transform, var_13_6, var_13_4, var_13_5)
	end

	if arg_13_0._lightGlowGO then
		local var_13_7 = 0

		if arg_13_1 < 0.75 then
			var_13_7 = 32 * (0.75 - arg_13_1)
		end

		gohelper.setActive(arg_13_0._lightGlowGO, var_13_7 > 0)
		transformhelper.setLocalScale(arg_13_0._lightGlowGO.transform, var_13_7, var_13_7, var_13_7)
	end

	if arg_13_0._lightGlowMeshRenderer and arg_13_0._lightGlowMaterialPropertyBlock then
		local var_13_8 = arg_13_0._lightGlowMeshRenderer.material:GetVector("_MainColor")
		local var_13_9 = 0

		if arg_13_1 < 0.75 then
			var_13_9 = 164 * (0.75 - arg_13_1)
		end

		arg_13_0._lightGlowMaterialPropertyBlock:SetVector("_MainColor", Vector4.New(var_13_8.x, var_13_8.y, var_13_8.z, var_13_9 / 255))
		arg_13_0._lightGlowMeshRenderer:SetPropertyBlock(arg_13_0._lightGlowMaterialPropertyBlock)
	end

	if arg_13_0._rootGO then
		local var_13_10 = -6 * (1 - arg_13_1)
		local var_13_11 = 1 - arg_13_1
		local var_13_12, var_13_13 = transformhelper.getLocalPos(arg_13_0._rootGO.transform)
		local var_13_14, var_13_15, var_13_16 = transformhelper.getLocalRotation(arg_13_0._rootGO.transform)

		transformhelper.setLocalPos(arg_13_0._rootGO.transform, var_13_12, var_13_13, var_13_10)
		transformhelper.setLocalRotation(arg_13_0._rootGO.transform, var_13_11, var_13_15, var_13_16)
	end

	if arg_13_0._light then
		local var_13_17 = arg_13_0._light.color
		local var_13_18 = 26 * (1 - arg_13_1)

		arg_13_0._light.color = Color(var_13_18 / 255, var_13_18 / 255, var_13_18 / 255, 0)
	end

	if not arg_13_0._tweened and arg_13_0._fake and arg_13_0._rare == 5 and arg_13_1 < 0.3 then
		arg_13_0._tweened = true
		arg_13_0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.3, arg_13_0._tween, nil, arg_13_0)
	end

	if arg_13_0._spotLight then
		arg_13_0._spotLight.range = 45 * (1 - arg_13_1)
	end
end

function var_0_0._setSpeedEffect(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0._waterMeshRenderer and arg_14_0._waterMaterialPropertyBlock then
		local var_14_0 = arg_14_0._waterMeshRenderer.material:GetVector("_Radial")
		local var_14_1 = var_14_0.w
		local var_14_2 = math.min(math.abs(arg_14_1 / 500) * arg_14_0._maxWaterEffect, arg_14_0._maxWaterEffect)

		arg_14_0._waterMaterialPropertyBlock:SetVector("_Radial", Vector4.New(var_14_0.x, var_14_0.y, var_14_0.z, var_14_2))
		arg_14_0._waterMeshRenderer:SetPropertyBlock(arg_14_0._waterMaterialPropertyBlock)
	end
end

function var_0_0._setCurGachaEffect(arg_15_0)
	local var_15_0 = {}
	local var_15_1 = false
	local var_15_2 = arg_15_0._angle >= arg_15_0._startAttachEffectDegree

	for iter_15_0 = 1, var_0_0.StepCount do
		local var_15_3 = arg_15_0._stepEffectWraps[iter_15_0]

		if var_15_3 ~= nil then
			local var_15_4 = iter_15_0 <= arg_15_0._currentDrawStep and var_15_2
			local var_15_5 = arg_15_0._stepEffectRunning[iter_15_0]

			if not var_15_5 and var_15_4 then
				var_15_3:setActive(true)
				var_15_3:setSpeed(arg_15_0._curAnimSpeed)

				arg_15_0._stepEffectRunning[iter_15_0] = true
				var_15_1 = true
			elseif var_15_5 and not var_15_4 then
				var_15_3:setActive(false)

				arg_15_0._stepEffectRunning[iter_15_0] = false
				var_15_1 = true
			end
		end
	end

	if arg_15_0._wheelLightWrap then
		arg_15_0._wheelLightWrap:setActive(var_15_2)
	end

	if var_15_1 then
		arg_15_0:_refreshAttachEffectSpeed()
		arg_15_0:stopStepAudio()

		if var_0_0.StepAudio[arg_15_0._currentDrawStep] then
			AudioMgr.instance:trigger(var_0_0.StepAudio[arg_15_0._currentDrawStep])
		end
	end
end

function var_0_0._loadStepEffects(arg_16_0)
	local var_16_0 = SummonEnum.SummonQualityDefine[arg_16_0._rare]

	if not string.nilorempty(var_16_0) then
		for iter_16_0 = 1, var_0_0.StepCount do
			local var_16_1 = string.format("Scene%sStep%s", var_16_0, iter_16_0)
			local var_16_2 = SummonEnum.SummonPreloadPath[var_16_1]
			local var_16_3

			if not string.nilorempty(var_16_2) then
				var_16_3 = SummonEffectPool.getEffect(var_16_2, arg_16_0._gachaEffectRootGO)
			end

			if var_16_3 ~= nil then
				arg_16_0._stepEffectWraps[iter_16_0] = var_16_3

				var_16_3:setActive(false)
			end
		end
	end
end

function var_0_0._loadWaterEffect(arg_17_0)
	local var_17_0 = SummonEnum.SummonQualityDefine[arg_17_0._rare]

	if string.nilorempty(var_17_0) then
		return
	end

	if not arg_17_0._waterEffectLWrap then
		local var_17_1 = SummonEnum.SummonPreloadPath.SceneRollWaterL

		arg_17_0._waterEffectLWrap = SummonEffectPool.getEffect(var_17_1, arg_17_0._gachaEffectRootGO)

		arg_17_0._waterEffectLWrap:stopParticle()
	end

	if not arg_17_0._waterEffectRWrap then
		local var_17_2 = SummonEnum.SummonPreloadPath.SceneRollWaterR

		arg_17_0._waterEffectRWrap = SummonEffectPool.getEffect(var_17_2, arg_17_0._gachaEffectRootGO)

		arg_17_0._waterEffectRWrap:stopParticle()
	end
end

function var_0_0._loadWheelEffect(arg_18_0)
	local var_18_0 = SummonEnum.SummonQualityDefine[arg_18_0._rare]

	if string.nilorempty(var_18_0) then
		return
	end

	if not arg_18_0._wheelLightWrap then
		local var_18_1 = string.format("Scene%sWheel", var_18_0)
		local var_18_2 = SummonEnum.SummonPreloadPath[var_18_1]

		if not string.nilorempty(var_18_2) then
			arg_18_0._wheelLightWrap = SummonEffectPool.getEffect(var_18_2, arg_18_0._wheelEffectRootGO)

			arg_18_0._wheelLightWrap:setActive(false)
		else
			logError("can't find keyName = [" .. tostring(var_18_1) .. "] in path")
		end
	end
end

function var_0_0.onDestroy(arg_19_0)
	arg_19_0:stopAudio()
	arg_19_0:recycleEffects()

	if arg_19_0._tweenId then
		ZProj.TweenHelper.KillById(arg_19_0._tweenId)

		arg_19_0._tweenId = nil
	end

	arg_19_0._wheelGO = nil
	arg_19_0._wheelMirrorGO = nil
	arg_19_0._waterGO = nil
	arg_19_0._wheelMeshRenderer = nil
	arg_19_0._wheelMirrorMeshRenderer = nil
	arg_19_0._waterMeshRenderer = nil
	arg_19_0._ropeMeshRenderer = nil
	arg_19_0._lightGlowMeshRenderer = nil
	arg_19_0._lineGlowMeshRenderer = nil

	if arg_19_0._wheelMaterialPropertyBlock then
		arg_19_0._wheelMaterialPropertyBlock:Clear()

		arg_19_0._wheelMaterialPropertyBlock = nil
	end

	if arg_19_0._wheelMirrorMaterialPropertyBlock then
		arg_19_0._wheelMirrorMaterialPropertyBlock:Clear()

		arg_19_0._wheelMirrorMaterialPropertyBlock = nil
	end

	if arg_19_0._waterMaterialPropertyBlock then
		arg_19_0._waterMaterialPropertyBlock:Clear()

		arg_19_0._waterMaterialPropertyBlock = nil
	end

	if arg_19_0._ropeMaterialPropertyBlock then
		arg_19_0._ropeMaterialPropertyBlock:Clear()

		arg_19_0._ropeMaterialPropertyBlock = nil
	end

	if arg_19_0._lightGlowMaterialPropertyBlock then
		arg_19_0._lightGlowMaterialPropertyBlock:Clear()

		arg_19_0._lightGlowMaterialPropertyBlock = nil
	end

	if arg_19_0._lineGlowMaterialPropertyBlock then
		arg_19_0._lineGlowMaterialPropertyBlock:Clear()

		arg_19_0._lineGlowMaterialPropertyBlock = nil
	end
end

function var_0_0.resetDraw(arg_20_0, arg_20_1)
	if arg_20_0._tweenId then
		ZProj.TweenHelper.KillById(arg_20_0._tweenId)

		arg_20_0._tweenId = nil
	end

	arg_20_0._currentDrawStep = 0
	arg_20_0._tweened = false
	arg_20_0._prevAngle = 0
	arg_20_0._angle = 0
	arg_20_0._speed = 0
	arg_20_0._updateDragAngle = 0
	arg_20_0._finished = false
	arg_20_0._turning = false
	arg_20_0._canDraw = true
	arg_20_0._canTrigger = true
	arg_20_0._curAnimSpeed = 1
	arg_20_0._rare = arg_20_1
	arg_20_0._fake = math.random(0, 100) < 50

	local var_20_0 = var_0_0.RareColor[arg_20_0._rare] or var_0_0.RareColor[2]

	if arg_20_0._rare == 5 and arg_20_0._fake then
		var_20_0 = var_0_0.RareColor[4]
	end

	if arg_20_0._lineGlowMeshRenderer and arg_20_0._lineGlowMaterialPropertyBlock then
		arg_20_0._lineGlowMaterialPropertyBlock:SetVector("_MainColor", var_20_0)
		arg_20_0._lineGlowMeshRenderer:SetPropertyBlock(arg_20_0._lineGlowMaterialPropertyBlock)
	end

	if arg_20_0._ropeMeshRenderer and arg_20_0._ropeMaterialPropertyBlock then
		arg_20_0._ropeMaterialPropertyBlock:SetVector("_AddCol", var_20_0)
		arg_20_0._ropeMeshRenderer:SetPropertyBlock(arg_20_0._ropeMaterialPropertyBlock)
	end

	arg_20_0._ropeAnim.enabled = false
	arg_20_0._ropeAnimName = nil

	arg_20_0:recycleEffects()
	arg_20_0:_loadWaterEffect()
	arg_20_0:_loadWheelEffect()
	arg_20_0:_loadStepEffects()
end

function var_0_0.skip(arg_21_0)
	arg_21_0:setEffect(1)

	if arg_21_0._finished then
		return
	end

	arg_21_0._currentDrawStep = 0
	arg_21_0._tweened = false
	arg_21_0._prevAngle = 0
	arg_21_0._speed = 0
	arg_21_0._updateDragAngle = 0
	arg_21_0._finished = false
	arg_21_0._turning = false
	arg_21_0._canDraw = true
	arg_21_0._canTrigger = true
	arg_21_0._curAnimSpeed = 1
	arg_21_0._ropeAnim.enabled = false
	arg_21_0._ropeAnimName = nil

	arg_21_0:stopAudio()
	arg_21_0:recycleEffects()
end

function var_0_0.recycleEffects(arg_22_0)
	if arg_22_0._waterEffectLWrap ~= nil then
		SummonEffectPool.returnEffect(arg_22_0._waterEffectLWrap)

		arg_22_0._waterEffectLWrap = nil
	end

	if arg_22_0._waterEffectRWrap ~= nil then
		SummonEffectPool.returnEffect(arg_22_0._waterEffectRWrap)

		arg_22_0._waterEffectRWrap = nil
	end

	arg_22_0._waterEffectRunning = false
	arg_22_0._waterEffectRunningPos = 0

	if arg_22_0._wheelLightWrap ~= nil then
		SummonEffectPool.returnEffect(arg_22_0._wheelLightWrap)

		arg_22_0._wheelLightWrap = nil
	end

	for iter_22_0, iter_22_1 in pairs(arg_22_0._stepEffectWraps) do
		SummonEffectPool.returnEffect(iter_22_1)

		arg_22_0._stepEffectWraps[iter_22_0] = nil
	end

	for iter_22_2 = 1, var_0_0.StepCount do
		arg_22_0._stepEffectRunning[iter_22_2] = false
	end
end

function var_0_0.stopStepAudio(arg_23_0)
	AudioMgr.instance:trigger(AudioEnum.Summon.stop_ui_callfor_cordage01)
	AudioMgr.instance:trigger(AudioEnum.Summon.stop_ui_callfor_cordage02)
	AudioMgr.instance:trigger(AudioEnum.Summon.stop_ui_callfor_cordage03)
end

function var_0_0.stopAudio(arg_24_0)
	arg_24_0._audioLoopRunning = false

	AudioMgr.instance:trigger(AudioEnum.Summon.stop_ui_callfor_waterwheelloop)
	AudioMgr.instance:trigger(AudioEnum.Summon.stop_ui_callfor_spray)
	arg_24_0:stopStepAudio()
end

function var_0_0._tween(arg_25_0, arg_25_1)
	if arg_25_0._lineGlowMeshRenderer and arg_25_0._lineGlowMaterialPropertyBlock then
		local var_25_0 = var_0_0.RareColor[4]
		local var_25_1 = var_0_0.RareColor[5]
		local var_25_2 = var_25_0 * (1 - arg_25_1) + var_25_1 * arg_25_1

		arg_25_0._lineGlowMaterialPropertyBlock:SetVector("_MainColor", var_25_2)
		arg_25_0._lineGlowMeshRenderer:SetPropertyBlock(arg_25_0._lineGlowMaterialPropertyBlock)
	end
end

function var_0_0.startTurn(arg_26_0)
	if not arg_26_0._canDraw then
		return
	end

	arg_26_0._turning = true
	arg_26_0._speed = 0
end

function var_0_0.updateAngle(arg_27_0, arg_27_1)
	if not arg_27_0._canDraw then
		return
	end

	arg_27_0._turning = true
	arg_27_0._updateDragAngle = arg_27_0._updateDragAngle + arg_27_1
end

function var_0_0.endTurn(arg_28_0)
	if not arg_28_0._canDraw then
		return
	end

	arg_28_0._turning = false
end

function var_0_0.getStepEffectContainer(arg_29_0)
	return arg_29_0._gachaEffectRootGO
end

function var_0_0._completeDraw(arg_30_0)
	if arg_30_0._finished then
		return
	end

	arg_30_0._finished = true

	arg_30_0:stopAudio()
	arg_30_0:recycleEffects()
	SummonController.instance:dispatchEvent(SummonEvent.onSummonDraw)
end

return var_0_0
