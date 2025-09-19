module("modules.logic.scene.survival.entity.SurvivalPlayerEntity", package.seeall)

local var_0_0 = class("SurvivalPlayerEntity", SurvivalUnitEntity)

function var_0_0.Create(arg_1_0, arg_1_1)
	local var_1_0 = gohelper.create3d(arg_1_1, tostring(arg_1_0.pos))

	return MonoHelper.addNoUpdateLuaComOnceToGo(var_1_0, var_0_0, arg_1_0)
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, arg_2_1)
	arg_2_0:onWarmingAttrUpdate()
	gohelper.setActive(arg_2_0._effectRoot, true)
end

function var_0_0.addEventListeners(arg_3_0)
	var_0_0.super.addEventListeners(arg_3_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnAttrUpdate, arg_3_0._onAttrUpdate, arg_3_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapCircleUpdate, arg_3_0._checkIsInCircle, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	var_0_0.super.removeEventListeners(arg_4_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnAttrUpdate, arg_4_0._onAttrUpdate, arg_4_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapCircleUpdate, arg_4_0._checkIsInCircle, arg_4_0)
end

function var_0_0._onAttrUpdate(arg_5_0, arg_5_1)
	if arg_5_1 == SurvivalEnum.AttrType.NoWarming then
		arg_5_0:onWarmingAttrUpdate()
	end
end

function var_0_0.onMoveBegin(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_move)
end

function var_0_0.onMoveEnd(arg_7_0)
	return
end

function var_0_0._onResLoadEnd(arg_8_0)
	var_0_0.super._onResLoadEnd(arg_8_0)
	arg_8_0:onWarmingAttrUpdate()
end

function var_0_0.onWarmingAttrUpdate(arg_9_0)
	if not arg_9_0._resGo then
		return
	end

	local var_9_0 = SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.NoWarming) == 1 and 0.6 or 1

	if var_9_0 == arg_9_0._finalAlpha then
		return
	end

	arg_9_0._finalAlpha = var_9_0

	if not arg_9_0._tweenModelShowId and arg_9_0._resGo and arg_9_0._curShowRes then
		if arg_9_0._finalAlpha == 1 then
			arg_9_0:onTweenEnd()
		else
			arg_9_0:initMats()
			arg_9_0:onTween(1 - arg_9_0._finalAlpha)
		end
	end
end

function var_0_0.onPosChange(arg_10_0, arg_10_1)
	arg_10_0._unitMo.pos = arg_10_1

	local var_10_0 = SurvivalMapModel.instance:getSceneMo():getListByPos(arg_10_1)

	arg_10_0:setIsInTop(not var_10_0 or #var_10_0 == 0)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapPlayerPosChange)

	local var_10_1 = SurvivalMapModel.instance:getShowTargetPos()

	if var_10_1 then
		if var_10_1 == arg_10_1 then
			SurvivalMapModel.instance:setShowTarget()
		else
			local var_10_2 = SurvivalMapModel.instance:getCurMapCo().walkables
			local var_10_3 = SurvivalAStarFindPath.instance:findPath(arg_10_1, var_10_1, var_10_2)

			if not var_10_3 then
				SurvivalMapModel.instance:setShowTarget()

				return
			end

			table.insert(var_10_3, 1, arg_10_1)
			SurvivalMapHelper.instance:getScene().path:setPathListShow(var_10_3)
		end
	end

	arg_10_0:_checkIsInCircle()
end

function var_0_0._checkIsInCircle(arg_11_0)
	return
end

function var_0_0._checkIsTop(arg_12_0, arg_12_1)
	if arg_12_1 == arg_12_0._unitMo.pos then
		local var_12_0 = SurvivalMapModel.instance:getSceneMo():getListByPos(arg_12_1)

		arg_12_0:setIsInTop(not var_12_0 or #var_12_0 == 0)
	end
end

function var_0_0.transferTo(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	arg_13_0._targetPos = arg_13_1
	arg_13_0._callback = arg_13_3
	arg_13_0._callObj = arg_13_4

	if arg_13_0._unitMo.dir ~= arg_13_2 then
		arg_13_0._unitMo.dir = arg_13_2

		transformhelper.setLocalRotation(arg_13_0._modelRoot.transform, 0, arg_13_2 * 60, 0)
	end

	SurvivalController.instance:dispatchEvent(SurvivalEvent.TweenCameraFocus, Vector3(arg_13_0.x, arg_13_0.y, arg_13_0.z), 0.2)
	arg_13_0:addEffect(SurvivalEnum.UnitEffectPath.Transfer1)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_transmit)
	TaskDispatcher.runDelay(arg_13_0._tweenToTarget, arg_13_0, SurvivalEnum.UnitEffectTime[SurvivalEnum.UnitEffectPath.Transfer1])
end

function var_0_0._tweenToTarget(arg_14_0)
	arg_14_0:removeEffect(SurvivalEnum.UnitEffectPath.Transfer1)

	local var_14_0, var_14_1, var_14_2 = SurvivalHelper.instance:hexPointToWorldPoint(arg_14_0._targetPos.q, arg_14_0._targetPos.r)

	SurvivalController.instance:dispatchEvent(SurvivalEvent.TweenCameraFocus, Vector3(var_14_0, var_14_1, var_14_2), 0.3)
	TaskDispatcher.runDelay(arg_14_0._delayTransfer2, arg_14_0, 0.3)
end

function var_0_0._delayTransfer2(arg_15_0)
	arg_15_0:addEffect(SurvivalEnum.UnitEffectPath.Transfer2)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_transmit_2)
	arg_15_0:onPosChange(arg_15_0._targetPos)

	local var_15_0, var_15_1, var_15_2 = SurvivalHelper.instance:hexPointToWorldPoint(arg_15_0._targetPos.q, arg_15_0._targetPos.r)

	transformhelper.setLocalPos(arg_15_0.trans, var_15_0, var_15_1, var_15_2)

	arg_15_0.x = var_15_0
	arg_15_0.y = var_15_1
	arg_15_0.z = var_15_2

	TaskDispatcher.runDelay(arg_15_0._delayFinish, arg_15_0, SurvivalEnum.UnitEffectTime[SurvivalEnum.UnitEffectPath.Transfer2])
end

function var_0_0._delayFinish(arg_16_0)
	arg_16_0:removeEffect(SurvivalEnum.UnitEffectPath.Transfer2)

	arg_16_0._targetPos = nil
	arg_16_0._tweenId = nil

	local var_16_0 = arg_16_0._callback
	local var_16_1 = arg_16_0._callObj

	arg_16_0._callback = nil
	arg_16_0._callObj = nil

	if var_16_0 then
		var_16_0(var_16_1)
	end

	if not arg_16_0._tweenModelShowId then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.UpdateUnitIsShow, arg_16_0._unitMo.id)
	end
end

function var_0_0.flyTo(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	arg_17_0._targetPos = arg_17_1
	arg_17_0._callback = arg_17_3
	arg_17_0._callObj = arg_17_4

	if arg_17_0._unitMo.dir ~= arg_17_2 then
		arg_17_0._unitMo.dir = arg_17_2

		transformhelper.setLocalRotation(arg_17_0._modelRoot.transform, 0, arg_17_2 * 60, 0)
	end

	arg_17_0:playAnim("run")
	arg_17_0:addEffect(SurvivalEnum.UnitEffectPath.Fly)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_move_fast)

	local var_17_0 = SurvivalHelper.instance:getDistance(arg_17_1, arg_17_0._unitMo.pos) * SurvivalEnum.UnitEffectTime[SurvivalEnum.UnitEffectPath.Fly]
	local var_17_1, var_17_2, var_17_3 = SurvivalHelper.instance:hexPointToWorldPoint(arg_17_0._targetPos.q, arg_17_0._targetPos.r)

	arg_17_0._tweenId = ZProj.TweenHelper.DOLocalMove(arg_17_0.trans, var_17_1, var_17_2, var_17_3, var_17_0, arg_17_0._flyEnd, arg_17_0, nil, EaseType.Linear)
	arg_17_0.x = var_17_1
	arg_17_0.y = var_17_2
	arg_17_0.z = var_17_3
end

function var_0_0._flyEnd(arg_18_0)
	arg_18_0:removeEffect(SurvivalEnum.UnitEffectPath.Fly)
	arg_18_0:onPosChange(arg_18_0._targetPos)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.stop_ui_fuleyuan_tansuo_move_fast)
	arg_18_0:playAnim("idle")

	arg_18_0._targetPos = nil
	arg_18_0._tweenId = nil

	local var_18_0 = arg_18_0._callback
	local var_18_1 = arg_18_0._callObj

	arg_18_0._callback = nil
	arg_18_0._callObj = nil

	if var_18_0 then
		var_18_0(var_18_1)
	end

	if not arg_18_0._tweenModelShowId then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.UpdateUnitIsShow, arg_18_0._unitMo.id)
	end
end

function var_0_0.onDestroy(arg_19_0)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.stop_ui_fuleyuan_tansuo_move_fast)
	TaskDispatcher.cancelTask(arg_19_0._tweenToTarget, arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._delayTransfer2, arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._delayFinish, arg_19_0)
end

return var_0_0
