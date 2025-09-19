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

	local var_3_0 = arg_3_0._unitMo:getResPath()

	if string.nilorempty(var_3_0) then
		return
	end

	arg_3_0._loader:startLoad(var_3_0, arg_3_0._onResLoadEnd, arg_3_0)
end

function var_0_0.addEventListeners(arg_4_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapUnitPosChange, arg_4_0._checkIsTop, arg_4_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapUnitChange, arg_4_0._onUnitDataChange, arg_4_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnFollowTaskUpdate, arg_4_0._onFollowTaskUpdate, arg_4_0)
end

function var_0_0.removeEventListeners(arg_5_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapUnitPosChange, arg_5_0._checkIsTop, arg_5_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapUnitChange, arg_5_0._onUnitDataChange, arg_5_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnFollowTaskUpdate, arg_5_0._onFollowTaskUpdate, arg_5_0)
end

function var_0_0.onStart(arg_6_0)
	arg_6_0.go:GetComponent(typeof(SLFramework.LuaMonobehavier)).enabled = false
end

function var_0_0._onResLoadEnd(arg_7_0)
	local var_7_0 = arg_7_0._loader:getInstGO()
	local var_7_1 = var_7_0.transform

	arg_7_0._resGo = var_7_0
	arg_7_0._resTrans = var_7_1
	arg_7_0._renderers = var_7_1:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer), true)

	transformhelper.setLocalPos(var_7_1, 0, 0, 0)
	transformhelper.setLocalRotation(var_7_1, 0, 0, 0)
	transformhelper.setLocalScale(var_7_1, 1, 1, 1)

	arg_7_0._anim = gohelper.findChildAnim(var_7_0, "")

	if arg_7_0._curAnimName then
		arg_7_0:playAnim(arg_7_0._curAnimName)
	end

	arg_7_0:_checkIsTop(arg_7_0._unitMo.pos)
	arg_7_0:updateIsShow()
end

function var_0_0.setPosAndDir(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._unitMo.dir = arg_8_2

	arg_8_0:onPosChange(arg_8_1)

	local var_8_0, var_8_1, var_8_2 = SurvivalHelper.instance:hexPointToWorldPoint(arg_8_1.q, arg_8_1.r)

	transformhelper.setLocalPos(arg_8_0.trans, var_8_0, var_8_1, var_8_2)
	transformhelper.setLocalRotation(arg_8_0._modelRoot.transform, 0, arg_8_2 * 60, 0)

	arg_8_0.x = var_8_0
	arg_8_0.y = var_8_1
	arg_8_0.z = var_8_2
end

function var_0_0.tryRemove(arg_9_0, arg_9_1)
	arg_9_0._isRemove = true

	SurvivalMapHelper.instance:removeEntity(arg_9_0._unitMo.id)

	if not arg_9_0._curShowRes then
		TaskDispatcher.runDelay(arg_9_0._delayDestroy, arg_9_0, 0.1)
	elseif arg_9_1 then
		arg_9_0:playAnim("die")
		TaskDispatcher.runDelay(arg_9_0._delayDestroy, arg_9_0, 2)
	else
		arg_9_0:setIsInTop(false)
		TaskDispatcher.runDelay(arg_9_0._delayDestroy, arg_9_0, 0.5)
	end
end

function var_0_0._delayDestroy(arg_10_0)
	gohelper.destroy(arg_10_0.go)
	arg_10_0:onDestroy()
end

function var_0_0.moveTo(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if arg_11_0._tweenId then
		ZProj.TweenHelper.KillById(arg_11_0._tweenId)
	end

	if arg_11_0._callback then
		arg_11_0._callback(arg_11_0._callObj)
	end

	if arg_11_0._targetPos then
		arg_11_0:setPosAndDir(arg_11_0._targetPos, arg_11_0._unitMo.dir)
	end

	arg_11_0._targetPos = arg_11_1
	arg_11_0._callback = arg_11_3
	arg_11_0._callObj = arg_11_4

	if arg_11_0._unitMo.dir ~= arg_11_2 then
		arg_11_0._unitMo.dir = arg_11_2
		arg_11_0._tweenId = ZProj.TweenHelper.DOLocalRotate(arg_11_0._modelRoot.transform, 0, arg_11_2 * 60, 0, 0.15, arg_11_0._beginMove, arg_11_0)
	else
		arg_11_0:_beginMove()
	end
end

function var_0_0.onMoveBegin(arg_12_0)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnUnitBeginMove, arg_12_0._unitMo.id)
end

function var_0_0._beginMove(arg_13_0)
	arg_13_0:onMoveBegin()
	arg_13_0:playAnim("run")

	local var_13_0, var_13_1, var_13_2 = SurvivalHelper.instance:hexPointToWorldPoint(arg_13_0._targetPos.q, arg_13_0._targetPos.r)

	arg_13_0._tweenId = ZProj.TweenHelper.DOLocalMove(arg_13_0.trans, (var_13_0 + arg_13_0.x) / 2, (var_13_1 + arg_13_0.y) / 2, (var_13_2 + arg_13_0.z) / 2, SurvivalEnum.MoveSpeed / 2, arg_13_0._beginMoveHalf, arg_13_0, nil, EaseType.Linear)
end

function var_0_0._beginMoveHalf(arg_14_0)
	arg_14_0:onPosChange(arg_14_0._targetPos)

	local var_14_0, var_14_1, var_14_2 = SurvivalHelper.instance:hexPointToWorldPoint(arg_14_0._targetPos.q, arg_14_0._targetPos.r)

	arg_14_0._tweenId = ZProj.TweenHelper.DOLocalMove(arg_14_0.trans, var_14_0, var_14_1, var_14_2, SurvivalEnum.MoveSpeed / 2, arg_14_0._endMove, arg_14_0, nil, EaseType.Linear)
	arg_14_0.x = var_14_0
	arg_14_0.y = var_14_1
	arg_14_0.z = var_14_2
end

function var_0_0.onPosChange(arg_15_0, arg_15_1)
	SurvivalMapModel.instance:getSceneMo():onUnitUpdatePos(arg_15_0._unitMo, arg_15_1)
	arg_15_0:sortSceneModel()
end

function var_0_0._checkIsTop(arg_16_0, arg_16_1)
	if arg_16_1 == arg_16_0._unitMo.pos then
		arg_16_0:sortSceneModel()
	end
end

function var_0_0.sortSceneModel(arg_17_0)
	if arg_17_0._isRemove then
		return
	end

	local var_17_0 = SurvivalMapModel.instance:getSceneMo():isInTop(arg_17_0._unitMo)

	arg_17_0:setIsInTop(var_17_0)
end

function var_0_0.setIsInTop(arg_18_0, arg_18_1)
	if arg_18_0._isTop == nil then
		arg_18_0._isTop = true
	end

	if arg_18_0._isTop ~= arg_18_1 then
		arg_18_0._isTop = arg_18_1

		arg_18_0:updateIsShow()
	end
end

function var_0_0._onUnitDataChange(arg_19_0, arg_19_1)
	if arg_19_1 == arg_19_0._unitMo.id then
		local var_19_0 = arg_19_0._unitMo:getResPath()

		if arg_19_0._loader:getPath() ~= var_19_0 then
			arg_19_0._curShowRes = nil
			arg_19_0._shareMats = nil
			arg_19_0._matInsts = nil

			arg_19_0._loader:dispose()

			if not string.nilorempty(var_19_0) then
				arg_19_0._loader:startLoad(var_19_0, arg_19_0._onResLoadEnd, arg_19_0)
			end
		else
			arg_19_0:updateIsShow()
		end

		arg_19_0:onPrepairUnitMo()
	end
end

function var_0_0.onPrepairUnitMo(arg_20_0)
	arg_20_0:removeEffect(SurvivalEnum.UnitEffectPath.UnitType42)
	arg_20_0:removeEffect(SurvivalEnum.UnitEffectPath.UnitType44)
	arg_20_0:removeEffect(SurvivalEnum.UnitEffectPath.FollowUnit)

	local var_20_0 = arg_20_0._unitMo.co and arg_20_0._unitMo.co.subType

	if var_20_0 == 42 then
		arg_20_0:addEffect(SurvivalEnum.UnitEffectPath.UnitType42)
	elseif var_20_0 == 44 then
		arg_20_0:addEffect(SurvivalEnum.UnitEffectPath.UnitType44)
	end

	if tabletool.indexOf(SurvivalConfig.instance:getHighValueUnitSubTypes(), var_20_0) then
		arg_20_0:addEffect(SurvivalEnum.UnitEffectPath.FollowUnit)
	end
end

function var_0_0._onFollowTaskUpdate(arg_21_0)
	return
end

function var_0_0.updateIsShow(arg_22_0)
	arg_22_0.isShow = arg_22_0._isTop and arg_22_0._unitMo.visionVal ~= 8

	if not arg_22_0._resGo then
		return
	end

	local var_22_0 = false

	if arg_22_0._curShowRes == nil then
		arg_22_0._curShowRes = true
		var_22_0 = true
	end

	if arg_22_0._unitMo.id ~= 0 then
		gohelper.setActive(arg_22_0._effectRoot, arg_22_0.isShow)
	end

	if arg_22_0._curShowRes ~= arg_22_0.isShow then
		transformhelper.setLocalPos(arg_22_0._resTrans, 0, 0, 0)

		arg_22_0._curShowRes = arg_22_0.isShow

		if not arg_22_0.isShow then
			arg_22_0:initMats()

			for iter_22_0 = 0, arg_22_0._renderers.Length - 1 do
				local var_22_1 = arg_22_0._renderers[iter_22_0]

				if not tolua.isnull(var_22_1) then
					var_22_1.material = arg_22_0._matInsts[iter_22_0]
				end
			end

			if var_22_0 then
				arg_22_0:onTween(1)
				arg_22_0:onTweenEnd()
			else
				if arg_22_0._tweenModelShowId then
					ZProj.TweenHelper.KillById(arg_22_0._tweenModelShowId)
				end

				arg_22_0._tweenModelShowId = ZProj.TweenHelper.DOTweenFloat(arg_22_0._nowClipValue or 1 - arg_22_0._finalAlpha, 1, 0.4, arg_22_0.onTween, arg_22_0.onTweenEnd, arg_22_0, nil, EaseType.Linear)
			end
		else
			SurvivalController.instance:dispatchEvent(SurvivalEvent.UpdateUnitIsShow, arg_22_0._unitMo.id)

			if var_22_0 then
				arg_22_0:onTweenEnd()
			else
				if arg_22_0._tweenModelShowId then
					ZProj.TweenHelper.KillById(arg_22_0._tweenModelShowId)
				end

				arg_22_0._tweenModelShowId = ZProj.TweenHelper.DOTweenFloat(arg_22_0._nowClipValue or 1, 1 - arg_22_0._finalAlpha, 0.4, arg_22_0.onTween, arg_22_0.onTweenEnd, arg_22_0, nil, EaseType.Linear)
			end
		end
	end
end

function var_0_0.onTween(arg_23_0, arg_23_1)
	arg_23_0._nowClipValue = arg_23_1

	for iter_23_0 = 0, #arg_23_0._matInsts do
		arg_23_0._matInsts[iter_23_0]:SetFloat(var_0_1, arg_23_1)
	end
end

function var_0_0.onTweenEnd(arg_24_0)
	arg_24_0._tweenModelShowId = nil

	if arg_24_0._curShowRes then
		if arg_24_0._finalAlpha == 1 then
			for iter_24_0 = 0, arg_24_0._renderers.Length - 1 do
				local var_24_0 = arg_24_0._renderers[iter_24_0]

				if not tolua.isnull(var_24_0) then
					var_24_0.material = arg_24_0._shareMats[iter_24_0]
				end
			end
		end
	else
		transformhelper.setLocalPos(arg_24_0._resTrans, 0, -10, 0)

		if not arg_24_0._tweenId then
			SurvivalController.instance:dispatchEvent(SurvivalEvent.UpdateUnitIsShow, arg_24_0._unitMo.id)
		end
	end
end

function var_0_0.initMats(arg_25_0)
	if not arg_25_0._shareMats then
		arg_25_0._shareMats = arg_25_0:getUserDataTb_()
		arg_25_0._matInsts = arg_25_0:getUserDataTb_()

		for iter_25_0 = 0, arg_25_0._renderers.Length - 1 do
			arg_25_0._shareMats[iter_25_0] = arg_25_0._renderers[iter_25_0].sharedMaterial
			arg_25_0._matInsts[iter_25_0] = arg_25_0._renderers[iter_25_0].material

			arg_25_0._matInsts[iter_25_0]:EnableKeyword("_SCREENCOORD")
			arg_25_0._matInsts[iter_25_0]:SetFloat(var_0_1, 0)
		end
	end
end

function var_0_0._endMove(arg_26_0)
	arg_26_0:playAnim("idle")

	arg_26_0._targetPos = nil
	arg_26_0._tweenId = nil

	local var_26_0 = arg_26_0._callback
	local var_26_1 = arg_26_0._callObj

	arg_26_0._callback = nil
	arg_26_0._callObj = nil

	if var_26_0 then
		var_26_0(var_26_1)
	end

	if not arg_26_0._tweenModelShowId then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.UpdateUnitIsShow, arg_26_0._unitMo.id)
	end

	arg_26_0:onMoveEnd()
end

function var_0_0.onMoveEnd(arg_27_0)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnUnitEndMove, arg_27_0._unitMo.id)
end

function var_0_0.playAnim(arg_28_0, arg_28_1)
	arg_28_0._curAnimName = arg_28_1

	if arg_28_0._anim and arg_28_0._anim.isActiveAndEnabled then
		arg_28_0._anim:Play(arg_28_1, 0, 0)
	end
end

function var_0_0.addEffect(arg_29_0, arg_29_1)
	if not arg_29_0._allEffects or arg_29_0._allEffects[arg_29_1] then
		return
	end

	if gohelper.isNil(arg_29_0._effectRoot) then
		logError("SurvivalUnitEntity._effectRoot is nil")

		return
	end

	local var_29_0 = gohelper.create3d(arg_29_0._effectRoot, "effect")
	local var_29_1 = PrefabInstantiate.Create(var_29_0)

	var_29_1:startLoad(arg_29_1)

	arg_29_0._allEffects[arg_29_1] = var_29_1
end

function var_0_0.removeEffect(arg_30_0, arg_30_1)
	if not arg_30_0._allEffects or not arg_30_0._allEffects[arg_30_1] then
		return
	end

	arg_30_0._allEffects[arg_30_1]:dispose()
	gohelper.destroy(arg_30_0._allEffects[arg_30_1]._containerGO)

	arg_30_0._allEffects[arg_30_1] = nil
end

function var_0_0.onDestroy(arg_31_0)
	if arg_31_0._allEffects then
		for iter_31_0, iter_31_1 in pairs(arg_31_0._allEffects) do
			iter_31_1:dispose()
		end
	end

	if arg_31_0._loader then
		arg_31_0._loader:dispose()

		arg_31_0._loader = nil
	end

	TaskDispatcher.cancelTask(arg_31_0._delayDestroy, arg_31_0)

	if arg_31_0._tweenModelShowId then
		ZProj.TweenHelper.KillById(arg_31_0._tweenModelShowId)

		arg_31_0._tweenModelShowId = nil
	end

	arg_31_0._targetPos = nil
	arg_31_0._callback = nil
	arg_31_0._callObj = nil

	if arg_31_0._tweenId then
		ZProj.TweenHelper.KillById(arg_31_0._tweenId)

		arg_31_0._tweenId = nil
	end
end

return var_0_0
