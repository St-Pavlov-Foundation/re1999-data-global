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

function var_0_0.getResPath(arg_3_0)
	return arg_3_0._unitMo:getResPath()
end

function var_0_0.addEventListeners(arg_4_0)
	var_0_0.super.addEventListeners(arg_4_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnAttrUpdate, arg_4_0._onAttrUpdate, arg_4_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapCircleUpdate, arg_4_0._checkIsInCircle, arg_4_0)
end

function var_0_0.removeEventListeners(arg_5_0)
	var_0_0.super.removeEventListeners(arg_5_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnAttrUpdate, arg_5_0._onAttrUpdate, arg_5_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapCircleUpdate, arg_5_0._checkIsInCircle, arg_5_0)
end

function var_0_0._onAttrUpdate(arg_6_0, arg_6_1)
	if arg_6_1 == SurvivalEnum.AttrType.NoWarning then
		arg_6_0:onWarmingAttrUpdate()
	elseif arg_6_1 == SurvivalEnum.AttrType.Vehicle_Miasma or arg_6_1 == SurvivalEnum.AttrType.Vehicle_Morass or arg_6_1 == SurvivalEnum.AttrType.Vehicle_Magma or arg_6_1 == SurvivalEnum.AttrType.Vehicle_Ice or arg_6_1 == SurvivalEnum.AttrType.Vehicle_Water then
		arg_6_0:_checkModelPath()
	end
end

function var_0_0.onMoveBegin(arg_7_0)
	if arg_7_0._unitMo:isDefaultModel() then
		AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_move)
	elseif SurvivalMapModel.instance:getSceneMo():getBlockTypeByPos(arg_7_0._unitMo.pos) == SurvivalEnum.UnitSubType.Water then
		AudioMgr.instance:trigger(AudioEnum3_1.Survival.PlayerMoveByWater)
	else
		AudioMgr.instance:trigger(AudioEnum3_1.Survival.PlayerMoveByCar)
	end
end

function var_0_0.onModelChange(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum3_1.Survival.PlayerChangeModel)
end

function var_0_0.onMoveEnd(arg_9_0)
	return
end

function var_0_0._onResLoadEnd(arg_10_0)
	var_0_0.super._onResLoadEnd(arg_10_0)
	arg_10_0:onWarmingAttrUpdate()

	if SurvivalMapModel.instance:getSceneMo():isHaveIceEvent() then
		arg_10_0:playAnim("down_idle")
	end
end

function var_0_0.onWarmingAttrUpdate(arg_11_0)
	if not arg_11_0._resGo then
		return
	end

	local var_11_0 = SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.NoWarning) == 1 and SurvivalConst.PlayerClipRate or 1

	if var_11_0 == arg_11_0._finalAlpha then
		return
	end

	arg_11_0._finalAlpha = var_11_0

	if not arg_11_0._tweenModelShowId and arg_11_0._resGo and arg_11_0._curShowRes then
		if arg_11_0._finalAlpha == 1 then
			arg_11_0:onTweenEnd()
		else
			arg_11_0:initMats()
			arg_11_0:onTween(1 - arg_11_0._finalAlpha)
		end
	end
end

function var_0_0.onPosChange(arg_12_0, arg_12_1)
	arg_12_0._unitMo.pos = arg_12_1

	arg_12_0:_checkIsTop(arg_12_1)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapPlayerPosChange)

	local var_12_0 = SurvivalMapModel.instance:getShowTargetPos()

	if var_12_0 then
		if var_12_0 == arg_12_1 then
			SurvivalMapModel.instance:setShowTarget()
		else
			local var_12_1 = SurvivalMapModel.instance:getCurMapCo().walkables
			local var_12_2 = SurvivalAStarFindPath.instance:findPath(arg_12_1, var_12_0, var_12_1)

			if not var_12_2 then
				SurvivalMapModel.instance:setShowTarget()

				return
			end

			table.insert(var_12_2, 1, arg_12_1)
			SurvivalMapHelper.instance:getScene().path:setPathListShow(var_12_2)
		end
	end

	arg_12_0:_checkIsInCircle()
	arg_12_0:_checkModelPath()
end

function var_0_0._checkIsInCircle(arg_13_0)
	return
end

function var_0_0._checkIsTop(arg_14_0, arg_14_1)
	if arg_14_1 == arg_14_0._unitMo.pos then
		local var_14_0 = SurvivalMapModel.instance:getSceneMo():getListByPos(arg_14_1)
		local var_14_1 = true

		if var_14_0 then
			for iter_14_0, iter_14_1 in ipairs(var_14_0) do
				if not string.nilorempty(iter_14_1:getResPath()) and iter_14_1.co and iter_14_1.co.subType ~= SurvivalEnum.UnitSubType.BlockEvent then
					var_14_1 = false

					break
				end
			end
		end

		arg_14_0:setIsInTop(var_14_1)
	end
end

function var_0_0.transferTo(arg_15_0, ...)
	var_0_0.super.transferTo(arg_15_0, ...)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.TweenCameraFocus, Vector3(arg_15_0.x, arg_15_0.y, arg_15_0.z), 0.2)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_transmit)
end

function var_0_0._tweenToTarget(arg_16_0, ...)
	var_0_0.super._tweenToTarget(arg_16_0, ...)

	local var_16_0, var_16_1, var_16_2 = SurvivalHelper.instance:hexPointToWorldPoint(arg_16_0._targetPos.q, arg_16_0._targetPos.r)

	SurvivalController.instance:dispatchEvent(SurvivalEvent.TweenCameraFocus, Vector3(var_16_0, var_16_1, var_16_2), 0.3)
end

function var_0_0.swapPos(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	arg_17_0:transferTo(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
end

function var_0_0.flyTo(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	arg_18_0._targetPos = arg_18_1
	arg_18_0._callback = arg_18_3
	arg_18_0._callObj = arg_18_4

	if arg_18_0._unitMo.dir ~= arg_18_2 then
		arg_18_0._unitMo.dir = arg_18_2

		transformhelper.setLocalRotation(arg_18_0._modelRoot.transform, 0, arg_18_2 * 60, 0)
	end

	arg_18_0:playAnim("run")
	arg_18_0:addEffect(SurvivalConst.UnitEffectPath.Fly)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_move_fast)

	local var_18_0 = SurvivalHelper.instance:getDistance(arg_18_1, arg_18_0._unitMo.pos) * SurvivalConst.UnitEffectTime[SurvivalConst.UnitEffectPath.Fly]
	local var_18_1, var_18_2, var_18_3 = SurvivalHelper.instance:hexPointToWorldPoint(arg_18_0._targetPos.q, arg_18_0._targetPos.r)

	arg_18_0._tweenId = ZProj.TweenHelper.DOLocalMove(arg_18_0.trans, var_18_1, var_18_2, var_18_3, var_18_0, arg_18_0._flyEnd, arg_18_0, nil, EaseType.Linear)
	arg_18_0.x = var_18_1
	arg_18_0.y = var_18_2
	arg_18_0.z = var_18_3
end

function var_0_0._flyEnd(arg_19_0)
	arg_19_0:removeEffect(SurvivalConst.UnitEffectPath.Fly)
	arg_19_0:onPosChange(arg_19_0._targetPos)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.stop_ui_fuleyuan_tansuo_move_fast)
	arg_19_0:playAnim("idle")

	arg_19_0._targetPos = nil
	arg_19_0._tweenId = nil

	arg_19_0:_doCallback()

	if not arg_19_0._tweenModelShowId then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.UpdateUnitIsShow, arg_19_0._unitMo.id)
	end
end

function var_0_0.beginTornadoTransfer(arg_20_0)
	var_0_0.super.beginTornadoTransfer(arg_20_0)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnPlayerTornadoTransferBegin)
end

function var_0_0.onTornadoTransferDone(arg_21_0)
	var_0_0.super.onTornadoTransferDone(arg_21_0)
	SurvivalMapHelper.instance:tweenToHeroPosIfNeed()
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnPlayerTornadoTransferEnd)
end

function var_0_0.onDestroy(arg_22_0)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.stop_ui_fuleyuan_tansuo_move_fast)
	TaskDispatcher.cancelTask(arg_22_0._tweenToTarget, arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._delayTransfer2, arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._delayFinish, arg_22_0)
end

return var_0_0
