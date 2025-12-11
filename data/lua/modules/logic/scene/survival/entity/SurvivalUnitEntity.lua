module("modules.logic.scene.survival.entity.SurvivalUnitEntity", package.seeall)

local var_0_0 = class("SurvivalUnitEntity", LuaCompBase)
local var_0_1 = UnityEngine.Shader.PropertyToID("_AlphaThreshold")

function var_0_0.Create(arg_1_0, arg_1_1)
	local var_1_0 = gohelper.create3d(arg_1_1, string.format("%s_%s", arg_1_0.pos, SurvivalEnum.UnitTypeToName[arg_1_0.unitType]))

	if isDebugBuild then
		gohelper.create3d(var_1_0, string.format("id:%s cfgId:%s", arg_1_0.id, arg_1_0.cfgId))
	end

	return MonoHelper.addNoUpdateLuaComOnceToGo(var_1_0, var_0_0, arg_1_0)
end

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0.x = 0
	arg_2_0.y = 0
	arg_2_0.z = 0
	arg_2_0._finalAlpha = 1
	arg_2_0._unitMo = arg_2_1
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0.go = arg_3_1
	arg_3_0.trans = arg_3_1.transform
	arg_3_0._allEffects = {}
	arg_3_0._effectRoot = gohelper.create3d(arg_3_1, "Effect")
	arg_3_0._modelRoot = gohelper.create3d(arg_3_1, "Model")

	gohelper.setActive(arg_3_0._effectRoot, false)
	arg_3_0:_onFollowTaskUpdate()
	arg_3_0:onPrepairUnitMo()
	arg_3_0:setPosAndDir(arg_3_0._unitMo.pos, arg_3_0._unitMo.dir)

	arg_3_0._loader = PrefabInstantiate.Create(arg_3_0._modelRoot)

	local var_3_0 = arg_3_0:getResPath()

	if string.nilorempty(var_3_0) then
		return
	end

	arg_3_0._loader:startLoad(var_3_0, arg_3_0._onResLoadEnd, arg_3_0)
end

function var_0_0.getResPath(arg_4_0)
	return arg_4_0._unitMo:getSceneResPath()
end

function var_0_0.addEventListeners(arg_5_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapUnitPosChange, arg_5_0._checkIsTop, arg_5_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapUnitChange, arg_5_0._onUnitDataChange, arg_5_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnFollowTaskUpdate, arg_5_0._onFollowTaskUpdate, arg_5_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnSpBlockUpdate, arg_5_0._onSpBlockUpdate, arg_5_0)
end

function var_0_0.removeEventListeners(arg_6_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapUnitPosChange, arg_6_0._checkIsTop, arg_6_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapUnitChange, arg_6_0._onUnitDataChange, arg_6_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnFollowTaskUpdate, arg_6_0._onFollowTaskUpdate, arg_6_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnSpBlockUpdate, arg_6_0._onSpBlockUpdate, arg_6_0)
end

function var_0_0.onStart(arg_7_0)
	arg_7_0.go:GetComponent(typeof(SLFramework.LuaMonobehavier)).enabled = false

	arg_7_0:_checkIsTop(arg_7_0._unitMo.pos)
end

function var_0_0._onResLoadEnd(arg_8_0)
	local var_8_0 = arg_8_0._loader:getInstGO()
	local var_8_1 = var_8_0.transform

	arg_8_0._resGo = var_8_0
	arg_8_0._resTrans = var_8_1
	arg_8_0._renderers = var_8_1:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer), true)

	transformhelper.setLocalPos(var_8_1, 0, 0, 0)
	transformhelper.setLocalRotation(var_8_1, 0, 0, 0)
	transformhelper.setLocalScale(var_8_1, 1, 1, 1)

	arg_8_0._anim = gohelper.findChildAnim(var_8_0, "")

	if arg_8_0._curAnimName then
		arg_8_0:playAnim(arg_8_0._curAnimName)
	end

	arg_8_0:_checkIsTop(arg_8_0._unitMo.pos)
	arg_8_0:updateIsShow()
end

function var_0_0.setPosAndDir(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._unitMo.dir = arg_9_2

	arg_9_0:onPosChange(arg_9_1)

	local var_9_0, var_9_1, var_9_2 = SurvivalHelper.instance:hexPointToWorldPoint(arg_9_1.q, arg_9_1.r)

	transformhelper.setLocalPos(arg_9_0.trans, var_9_0, var_9_1, var_9_2)
	transformhelper.setLocalRotation(arg_9_0._modelRoot.transform, 0, arg_9_2 * 60, 0)

	arg_9_0.x = var_9_0
	arg_9_0.y = var_9_1
	arg_9_0.z = var_9_2
end

function var_0_0.tryRemove(arg_10_0, arg_10_1)
	arg_10_0._isRemove = true

	SurvivalMapHelper.instance:removeEntity(arg_10_0._unitMo.id)

	if not arg_10_0._curShowRes then
		TaskDispatcher.runDelay(arg_10_0._delayDestroy, arg_10_0, 0.1)
	elseif arg_10_1 then
		arg_10_0:playAnim("die")
		TaskDispatcher.runDelay(arg_10_0._delayDestroy, arg_10_0, 2)
	else
		arg_10_0:setIsInTop(false)
		TaskDispatcher.runDelay(arg_10_0._delayDestroy, arg_10_0, 0.5)
	end
end

function var_0_0._delayDestroy(arg_11_0)
	gohelper.destroy(arg_11_0.go)
	arg_11_0:onDestroy()
end

function var_0_0.tornadoTransfer(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if arg_12_0._tweenId then
		ZProj.TweenHelper.KillById(arg_12_0._tweenId)
	end

	arg_12_0._callback = arg_12_3
	arg_12_0._callObj = arg_12_4
	arg_12_0._targetPos = arg_12_1

	arg_12_0:beginTornadoTransfer()

	if not arg_12_0.isShow then
		arg_12_0:setPosAndDir(arg_12_0._unitMo.pos, arg_12_2)
		TaskDispatcher.runDelay(arg_12_0.onTornadoTransferDone, arg_12_0, SurvivalConst.TornadoTransferTime)
	else
		arg_12_0._tweenId = ZProj.TweenHelper.DOLocalMoveY(arg_12_0.trans, SurvivalConst.TornadoTransferHeight, SurvivalConst.TornadoTransferTime, arg_12_0.onTornadoTransferDone, arg_12_0, nil, EaseType.OutCirc)
	end
end

function var_0_0.beginTornadoTransfer(arg_13_0)
	return
end

function var_0_0.onTornadoTransferDone(arg_14_0)
	arg_14_0:setPosAndDir(arg_14_0._targetPos, arg_14_0._unitMo.dir)

	arg_14_0._targetPos = nil

	arg_14_0:_doCallback()

	if not arg_14_0._tweenModelShowId then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.UpdateUnitIsShow, arg_14_0._unitMo.id)
	end

	arg_14_0:onMoveEnd()
end

function var_0_0.swapPos(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	arg_15_0:transferTo(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
end

function var_0_0.summonPos(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	arg_16_0:transferTo(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
end

function var_0_0.transferTo(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	arg_17_0._targetPos = arg_17_1
	arg_17_0._callback = arg_17_3
	arg_17_0._callObj = arg_17_4

	if arg_17_0._unitMo.dir ~= arg_17_2 then
		arg_17_0._unitMo.dir = arg_17_2

		transformhelper.setLocalRotation(arg_17_0._modelRoot.transform, 0, arg_17_2 * 60, 0)
	end

	arg_17_0:addEffect(SurvivalConst.UnitEffectPath.Transfer1)
	TaskDispatcher.runDelay(arg_17_0._tweenToTarget, arg_17_0, SurvivalConst.UnitEffectTime[SurvivalConst.UnitEffectPath.Transfer1])
end

function var_0_0._tweenToTarget(arg_18_0)
	arg_18_0:removeEffect(SurvivalConst.UnitEffectPath.Transfer1)
	TaskDispatcher.runDelay(arg_18_0._delayTransfer2, arg_18_0, 0.3)
end

function var_0_0._delayTransfer2(arg_19_0)
	arg_19_0:addEffect(SurvivalConst.UnitEffectPath.Transfer2)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_transmit_2)
	arg_19_0:onPosChange(arg_19_0._targetPos)

	local var_19_0, var_19_1, var_19_2 = SurvivalHelper.instance:hexPointToWorldPoint(arg_19_0._targetPos.q, arg_19_0._targetPos.r)

	transformhelper.setLocalPos(arg_19_0.trans, var_19_0, var_19_1, var_19_2)

	arg_19_0.x = var_19_0
	arg_19_0.y = var_19_1
	arg_19_0.z = var_19_2

	TaskDispatcher.runDelay(arg_19_0._delayFinish, arg_19_0, SurvivalConst.UnitEffectTime[SurvivalConst.UnitEffectPath.Transfer2])
end

function var_0_0._delayFinish(arg_20_0)
	arg_20_0:removeEffect(SurvivalConst.UnitEffectPath.Transfer2)

	arg_20_0._targetPos = nil
	arg_20_0._tweenId = nil

	arg_20_0:_doCallback()

	if not arg_20_0._tweenModelShowId then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.UpdateUnitIsShow, arg_20_0._unitMo.id)
	end
end

function var_0_0.moveTo(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	if arg_21_0._tweenId then
		ZProj.TweenHelper.KillById(arg_21_0._tweenId)
	end

	if arg_21_0._callback then
		arg_21_0._callback(arg_21_0._callObj)
	end

	if arg_21_0._targetPos then
		arg_21_0:setPosAndDir(arg_21_0._targetPos, arg_21_0._unitMo.dir)
	end

	arg_21_0._targetPos = arg_21_1
	arg_21_0._callback = arg_21_3
	arg_21_0._callObj = arg_21_4

	if arg_21_0._unitMo.dir ~= arg_21_2 then
		arg_21_0._unitMo.dir = arg_21_2
		arg_21_0._tweenId = ZProj.TweenHelper.DOLocalRotate(arg_21_0._modelRoot.transform, 0, arg_21_2 * 60, 0, SurvivalConst.TurnDirSpeed, arg_21_0._beginMove, arg_21_0)
	else
		arg_21_0:_beginMove()
	end
end

function var_0_0.onMoveBegin(arg_22_0)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnUnitBeginMove, arg_22_0._unitMo.id)
end

function var_0_0._beginMove(arg_23_0)
	arg_23_0:onMoveBegin()
	arg_23_0:playAnim("run")

	local var_23_0, var_23_1, var_23_2 = SurvivalHelper.instance:hexPointToWorldPoint(arg_23_0._targetPos.q, arg_23_0._targetPos.r)

	arg_23_0._tweenId = ZProj.TweenHelper.DOLocalMove(arg_23_0.trans, (var_23_0 + arg_23_0.x) / 2, (var_23_1 + arg_23_0.y) / 2, (var_23_2 + arg_23_0.z) / 2, SurvivalConst.PlayerMoveSpeed / 2, arg_23_0._beginMoveHalf, arg_23_0, nil, EaseType.Linear)
end

function var_0_0._beginMoveHalf(arg_24_0)
	arg_24_0:onPosChange(arg_24_0._targetPos)

	local var_24_0, var_24_1, var_24_2 = SurvivalHelper.instance:hexPointToWorldPoint(arg_24_0._targetPos.q, arg_24_0._targetPos.r)

	arg_24_0._tweenId = ZProj.TweenHelper.DOLocalMove(arg_24_0.trans, var_24_0, var_24_1, var_24_2, SurvivalConst.PlayerMoveSpeed / 2, arg_24_0._endMove, arg_24_0, nil, EaseType.Linear)
	arg_24_0.x = var_24_0
	arg_24_0.y = var_24_1
	arg_24_0.z = var_24_2
end

function var_0_0._onSpBlockUpdate(arg_25_0, arg_25_1)
	if arg_25_1 == arg_25_0._unitMo.pos then
		arg_25_0:_checkModelPath()
	end
end

function var_0_0.onPosChange(arg_26_0, arg_26_1)
	SurvivalMapModel.instance:getSceneMo():onUnitUpdatePos(arg_26_0._unitMo, arg_26_1)
	arg_26_0:sortSceneModel()
	arg_26_0:_checkModelPath()
end

function var_0_0._checkIsTop(arg_27_0, arg_27_1)
	if arg_27_1 == arg_27_0._unitMo.pos then
		arg_27_0:sortSceneModel()
	end
end

function var_0_0.sortSceneModel(arg_28_0)
	if arg_28_0._isRemove then
		return
	end

	local var_28_0 = SurvivalMapModel.instance:getSceneMo():isInTop(arg_28_0._unitMo)

	arg_28_0:setIsInTop(var_28_0)
end

function var_0_0.setIsInTop(arg_29_0, arg_29_1)
	if arg_29_0._isTop == nil then
		arg_29_0._isTop = true
	end

	if arg_29_0._isTop ~= arg_29_1 then
		arg_29_0._isTop = arg_29_1

		arg_29_0:updateIsShow()
	end
end

function var_0_0._checkModelPath(arg_30_0)
	if not arg_30_0._loader then
		return
	end

	local var_30_0 = arg_30_0:getResPath()

	if var_30_0 ~= arg_30_0._loader:getPath() then
		if arg_30_0._tweenModelShowId then
			ZProj.TweenHelper.KillById(arg_30_0._tweenModelShowId, true)

			arg_30_0._tweenModelShowId = nil
		end

		arg_30_0._curShowRes = nil
		arg_30_0._shareMats = nil
		arg_30_0._matInsts = nil
		arg_30_0._finalAlpha = 1

		arg_30_0._loader:dispose()

		if not string.nilorempty(var_30_0) then
			arg_30_0._loader:startLoad(var_30_0, arg_30_0._onResLoadEnd, arg_30_0)
		end

		arg_30_0:onModelChange()
		SurvivalMapHelper.instance:getScene().pointEffect:addAutoDisposeEffect(SurvivalPointEffectComp.ResPaths.changeModel, arg_30_0.trans.position, 2)
	end
end

function var_0_0.onModelChange(arg_31_0)
	return
end

function var_0_0._onUnitDataChange(arg_32_0, arg_32_1)
	if arg_32_1 == arg_32_0._unitMo.id then
		local var_32_0 = arg_32_0:getResPath()

		if arg_32_0._loader:getPath() ~= var_32_0 then
			arg_32_0._curShowRes = nil
			arg_32_0._shareMats = nil
			arg_32_0._matInsts = nil
			arg_32_0._finalAlpha = 1

			arg_32_0._loader:dispose()

			if not string.nilorempty(var_32_0) then
				arg_32_0._loader:startLoad(var_32_0, arg_32_0._onResLoadEnd, arg_32_0)
			end
		else
			arg_32_0:updateIsShow()
		end

		arg_32_0:onPrepairUnitMo()
	end
end

function var_0_0.onPrepairUnitMo(arg_33_0)
	arg_33_0:removeEffect(SurvivalConst.UnitEffectPath.UnitType42)
	arg_33_0:removeEffect(SurvivalConst.UnitEffectPath.UnitType44)
	arg_33_0:removeEffect(SurvivalConst.UnitEffectPath.FollowUnit)

	local var_33_0 = arg_33_0._unitMo.co and arg_33_0._unitMo.co.subType

	if var_33_0 == 42 then
		arg_33_0:addEffect(SurvivalConst.UnitEffectPath.UnitType42)
	elseif var_33_0 == 44 then
		arg_33_0:addEffect(SurvivalConst.UnitEffectPath.UnitType44)
	end

	if tabletool.indexOf(SurvivalConfig.instance:getHighValueUnitSubTypes(), var_33_0) then
		arg_33_0:addEffect(SurvivalConst.UnitEffectPath.FollowUnit)
	end
end

function var_0_0._onFollowTaskUpdate(arg_34_0)
	return
end

function var_0_0.updateIsShow(arg_35_0)
	arg_35_0.isShow = arg_35_0._isTop and arg_35_0._unitMo.visionVal ~= 8

	if not arg_35_0._resGo then
		return
	end

	local var_35_0 = false

	if arg_35_0._curShowRes == nil then
		arg_35_0._curShowRes = true
		var_35_0 = true
	end

	if arg_35_0._unitMo.id ~= 0 then
		gohelper.setActive(arg_35_0._effectRoot, arg_35_0.isShow)
	end

	if arg_35_0._curShowRes ~= arg_35_0.isShow then
		transformhelper.setLocalPos(arg_35_0._resTrans, 0, 0, 0)

		arg_35_0._curShowRes = arg_35_0.isShow

		if not arg_35_0.isShow then
			arg_35_0:initMats()

			if var_35_0 then
				arg_35_0:onTween(1)
				arg_35_0:onTweenEnd()
			else
				if arg_35_0._tweenModelShowId then
					ZProj.TweenHelper.KillById(arg_35_0._tweenModelShowId)
				end

				arg_35_0._tweenModelShowId = ZProj.TweenHelper.DOTweenFloat(arg_35_0._nowClipValue or 1 - arg_35_0._finalAlpha, 1, SurvivalConst.ModelClipTime, arg_35_0.onTween, arg_35_0.onTweenEnd, arg_35_0, nil, EaseType.Linear)
			end
		else
			SurvivalController.instance:dispatchEvent(SurvivalEvent.UpdateUnitIsShow, arg_35_0._unitMo.id)

			if var_35_0 then
				arg_35_0:onTweenEnd()
			else
				if arg_35_0._tweenModelShowId then
					ZProj.TweenHelper.KillById(arg_35_0._tweenModelShowId)
				end

				arg_35_0._tweenModelShowId = ZProj.TweenHelper.DOTweenFloat(arg_35_0._nowClipValue or 1, 1 - arg_35_0._finalAlpha, SurvivalConst.ModelClipTime, arg_35_0.onTween, arg_35_0.onTweenEnd, arg_35_0, nil, EaseType.Linear)
			end
		end
	end
end

function var_0_0.onTween(arg_36_0, arg_36_1)
	arg_36_0._nowClipValue = arg_36_1

	for iter_36_0, iter_36_1 in pairs(arg_36_0._matInsts) do
		iter_36_1:SetFloat(var_0_1, arg_36_1)
	end
end

function var_0_0.onTweenEnd(arg_37_0)
	arg_37_0._tweenModelShowId = nil

	if arg_37_0._curShowRes then
		if arg_37_0._finalAlpha == 1 then
			for iter_37_0 = 0, arg_37_0._renderers.Length - 1 do
				local var_37_0 = arg_37_0._renderers[iter_37_0]

				if not tolua.isnull(var_37_0) then
					var_37_0.material = arg_37_0._shareMats[iter_37_0]
				end
			end
		end
	else
		transformhelper.setLocalPos(arg_37_0._resTrans, 0, -10, 0)

		if not arg_37_0._tweenId then
			SurvivalController.instance:dispatchEvent(SurvivalEvent.UpdateUnitIsShow, arg_37_0._unitMo.id)
		end
	end
end

function var_0_0.initMats(arg_38_0)
	if not arg_38_0._shareMats then
		arg_38_0._shareMats = arg_38_0:getUserDataTb_()
		arg_38_0._matInsts = arg_38_0:getUserDataTb_()

		for iter_38_0 = 0, arg_38_0._renderers.Length - 1 do
			arg_38_0._shareMats[iter_38_0] = arg_38_0._renderers[iter_38_0].sharedMaterial
			arg_38_0._matInsts[iter_38_0] = arg_38_0._renderers[iter_38_0].material

			arg_38_0._matInsts[iter_38_0]:EnableKeyword("_SCREENCOORD")
			arg_38_0._matInsts[iter_38_0]:SetFloat(var_0_1, 0)
		end
	end

	for iter_38_1 = 0, arg_38_0._renderers.Length - 1 do
		local var_38_0 = arg_38_0._renderers[iter_38_1]

		if not tolua.isnull(var_38_0) then
			var_38_0.material = arg_38_0._matInsts[iter_38_1]
		end
	end
end

function var_0_0._endMove(arg_39_0)
	arg_39_0:playAnim("idle")

	arg_39_0._targetPos = nil
	arg_39_0._tweenId = nil

	arg_39_0:_doCallback()

	if not arg_39_0._tweenModelShowId then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.UpdateUnitIsShow, arg_39_0._unitMo.id)
	end

	arg_39_0:onMoveEnd()
end

function var_0_0._doCallback(arg_40_0)
	local var_40_0 = arg_40_0._callback
	local var_40_1 = arg_40_0._callObj

	arg_40_0._callback = nil
	arg_40_0._callObj = nil

	if var_40_0 then
		var_40_0(var_40_1)
	end
end

function var_0_0.onMoveEnd(arg_41_0)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnUnitEndMove, arg_41_0._unitMo.id)
end

function var_0_0.playAnim(arg_42_0, arg_42_1)
	arg_42_0._curAnimName = arg_42_1

	if arg_42_0._anim and not tolua.isnull(arg_42_0._anim) and arg_42_0._anim.isActiveAndEnabled then
		arg_42_0._anim:Play(arg_42_1, 0, 0)
	end
end

function var_0_0.addEffect(arg_43_0, arg_43_1)
	if not arg_43_0._allEffects or arg_43_0._allEffects[arg_43_1] then
		return
	end

	if gohelper.isNil(arg_43_0._effectRoot) then
		logError("SurvivalUnitEntity._effectRoot is nil")

		return
	end

	local var_43_0 = gohelper.create3d(arg_43_0._effectRoot, "effect")
	local var_43_1 = PrefabInstantiate.Create(var_43_0)

	var_43_1:startLoad(arg_43_1)

	arg_43_0._allEffects[arg_43_1] = var_43_1
end

function var_0_0.removeEffect(arg_44_0, arg_44_1)
	if not arg_44_0._allEffects or not arg_44_0._allEffects[arg_44_1] then
		return
	end

	arg_44_0._allEffects[arg_44_1]:dispose()
	gohelper.destroy(arg_44_0._allEffects[arg_44_1]._containerGO)

	arg_44_0._allEffects[arg_44_1] = nil
end

function var_0_0.onDestroy(arg_45_0)
	if arg_45_0._allEffects then
		for iter_45_0, iter_45_1 in pairs(arg_45_0._allEffects) do
			iter_45_1:dispose()
		end
	end

	if arg_45_0._loader then
		arg_45_0._loader:dispose()

		arg_45_0._loader = nil
	end

	TaskDispatcher.cancelTask(arg_45_0.onTornadoTransferDone, arg_45_0)
	TaskDispatcher.cancelTask(arg_45_0._delayDestroy, arg_45_0)

	if arg_45_0._tweenModelShowId then
		ZProj.TweenHelper.KillById(arg_45_0._tweenModelShowId)

		arg_45_0._tweenModelShowId = nil
	end

	arg_45_0._targetPos = nil
	arg_45_0._callback = nil
	arg_45_0._callObj = nil

	if arg_45_0._tweenId then
		ZProj.TweenHelper.KillById(arg_45_0._tweenId)

		arg_45_0._tweenId = nil
	end
end

return var_0_0
