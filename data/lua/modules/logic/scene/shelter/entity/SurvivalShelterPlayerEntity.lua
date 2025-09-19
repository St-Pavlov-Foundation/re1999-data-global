module("modules.logic.scene.shelter.entity.SurvivalShelterPlayerEntity", package.seeall)

local var_0_0 = class("SurvivalShelterPlayerEntity", SurvivalShelterUnitEntity)

function var_0_0.Create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = SurvivalShelterModel.instance:getPlayerMo()
	local var_1_1 = gohelper.create3d(arg_1_2, tostring(var_1_0.pos))
	local var_1_2 = {
		unitType = arg_1_0,
		unitId = arg_1_1,
		playerMo = var_1_0
	}

	return MonoHelper.addNoUpdateLuaComOnceToGo(var_1_1, var_0_0, var_1_2)
end

function var_0_0.onCtor(arg_2_0, arg_2_1)
	arg_2_0._unitMo = arg_2_1.playerMo
end

function var_0_0.onInit(arg_3_0)
	arg_3_0:setPosAndDir(arg_3_0._unitMo.pos, arg_3_0._unitMo.dir)

	arg_3_0._loader = PrefabInstantiate.Create(arg_3_0.go)

	local var_3_0 = SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.PlayerRes)

	arg_3_0._loader:startLoad(var_3_0, arg_3_0._onResLoadEnd, arg_3_0)
	arg_3_0:playAnim("idle")
end

function var_0_0.addEventListeners(arg_4_0)
	arg_4_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnShelterMapPlayerPosChange, arg_4_0._onPlayerPosChange, arg_4_0)
end

function var_0_0.removeEventListeners(arg_5_0)
	arg_5_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnShelterMapPlayerPosChange, arg_5_0._onPlayerPosChange, arg_5_0)
end

function var_0_0._onPlayerPosChange(arg_6_0)
	arg_6_0:updateEntity()
end

function var_0_0.onPosChange(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._unitMo:setPosAndDir(arg_7_1, arg_7_2)
end

function var_0_0.setPosAndDir(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0:onPosChange(arg_8_1, arg_8_2)

	local var_8_0, var_8_1, var_8_2 = SurvivalHelper.instance:hexPointToWorldPoint(arg_8_1.q, arg_8_1.r)

	transformhelper.setLocalPos(arg_8_0.trans, var_8_0, var_8_1, var_8_2)
	transformhelper.setLocalRotation(arg_8_0.trans, 0, arg_8_2 * 60, 0)
end

function var_0_0.getWorldPos(arg_9_0)
	return transformhelper.getLocalPos(arg_9_0.trans)
end

function var_0_0.getPos(arg_10_0)
	local var_10_0, var_10_1, var_10_2 = arg_10_0:getWorldPos()
	local var_10_3, var_10_4, var_10_5 = SurvivalHelper.instance:worldPointToHex(var_10_0, var_10_1, var_10_2)

	if not arg_10_0._playerPos then
		arg_10_0._playerPos = SurvivalHexNode.New(var_10_3, var_10_4, var_10_5)
	end

	arg_10_0._playerPos:set(var_10_3, var_10_4, var_10_5)

	return arg_10_0._playerPos
end

function var_0_0.moveToByPosList(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	if not arg_11_1 or not next(arg_11_1) then
		arg_11_0:stopMove()

		if arg_11_2 then
			arg_11_2(arg_11_3, arg_11_4)
		end

		return
	end

	local var_11_0 = arg_11_0:getPos()

	if tabletool.indexOf(arg_11_1, var_11_0) then
		arg_11_0:stopMove()

		if arg_11_2 then
			arg_11_2(arg_11_3, arg_11_4)
		end

		return
	end

	local var_11_1 = SurvivalConfig.instance:getShelterMapCo().walkables
	local var_11_2 = SurvivalAStarFindPath.instance:findNearestPath(var_11_0, arg_11_1, var_11_1, true)

	if var_11_2 then
		arg_11_0:moveToByPath(var_11_2, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	else
		arg_11_0:stopMove()

		if arg_11_2 then
			arg_11_2(arg_11_3, arg_11_4)
		end
	end
end

function var_0_0.moveToByPos(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5)
	local var_12_0 = arg_12_0:getPos()

	if var_12_0 == arg_12_1 then
		arg_12_0:stopMove()

		if arg_12_2 then
			arg_12_2(arg_12_3, arg_12_4)
		end

		return
	end

	local var_12_1 = SurvivalConfig.instance:getShelterMapCo().walkables
	local var_12_2 = SurvivalAStarFindPath.instance:findPath(var_12_0, arg_12_1, var_12_1, true)

	if var_12_2 then
		arg_12_0:moveToByPath(var_12_2, arg_12_2, arg_12_3, arg_12_4, arg_12_5)
	else
		arg_12_0:stopMove()

		if arg_12_2 then
			arg_12_2(arg_12_3, arg_12_4)
		end
	end
end

function var_0_0.moveToByPath(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
	arg_13_0:stopMove()

	arg_13_0._path = arg_13_1
	arg_13_0._pathcallback = arg_13_2
	arg_13_0._pathcallObj = arg_13_3
	arg_13_0._pathcallParam = arg_13_4

	SurvivalMapHelper.instance:getScene().path:showPath(arg_13_0._path)

	if arg_13_5 then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.CameraFollowerTarget, arg_13_0.go)
	end

	arg_13_0:_moveToNext()
end

function var_0_0._moveToNext(arg_14_0)
	if not arg_14_0._path or #arg_14_0._path == 0 then
		arg_14_0._callback = arg_14_0._pathcallback
		arg_14_0._callObj = arg_14_0._pathcallObj
		arg_14_0._callParam = arg_14_0._pathcallParam
		arg_14_0._pathcallback = nil
		arg_14_0._pathcallObj = nil
		arg_14_0._pathcallParam = nil

		arg_14_0:_endMove(true)

		return
	end

	local var_14_0 = table.remove(arg_14_0._path, 1)
	local var_14_1 = SurvivalHelper.instance:getDir(arg_14_0:getPos(), var_14_0)

	arg_14_0:moveTo(var_14_0, var_14_1, arg_14_0._moveToNext, arg_14_0)
end

function var_0_0.moveTo(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	arg_15_0._targetPos = arg_15_1
	arg_15_0._callback = arg_15_3
	arg_15_0._callObj = arg_15_4

	if arg_15_0._unitMo.dir ~= arg_15_2 then
		arg_15_0._tweenId = ZProj.TweenHelper.DOLocalRotate(arg_15_0.trans, 0, arg_15_2 * 60, 0, 0.05, arg_15_0._beginMove, arg_15_0)
	else
		arg_15_0:_beginMove()
	end

	arg_15_0:onPosChange(arg_15_0._targetPos, arg_15_2)
end

function var_0_0._beginMove(arg_16_0)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_move)
	arg_16_0:playAnim("run")

	local var_16_0, var_16_1, var_16_2 = SurvivalHelper.instance:hexPointToWorldPoint(arg_16_0._targetPos.q, arg_16_0._targetPos.r)
	local var_16_3, var_16_4, var_16_5 = arg_16_0:getWorldPos()
	local var_16_6 = math.sqrt((var_16_3 - var_16_0)^2 + (var_16_5 - var_16_2)^2) / 2.3

	arg_16_0._tweenId = ZProj.TweenHelper.DOLocalMove(arg_16_0.trans, var_16_0, var_16_1, var_16_2, var_16_6, arg_16_0._endMove, arg_16_0, nil, EaseType.Linear)
end

function var_0_0._endMove(arg_17_0, arg_17_1)
	arg_17_0:playAnim("idle")

	arg_17_0._targetPos = nil

	if arg_17_0._tweenId then
		ZProj.TweenHelper.KillById(arg_17_0._tweenId)

		arg_17_0._tweenId = nil
	end

	local var_17_0 = arg_17_0._callback
	local var_17_1 = arg_17_0._callObj
	local var_17_2 = arg_17_0._callParam

	arg_17_0._callback = nil
	arg_17_0._callObj = nil
	arg_17_0._callParam = nil

	if var_17_0 then
		var_17_0(var_17_1, var_17_2)
	end

	if arg_17_1 then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.CameraFollowerTarget)
		SurvivalMapHelper.instance:getScene().path:hidePath()
	end

	arg_17_0:updateEntity()
end

function var_0_0.stopMove(arg_18_0)
	arg_18_0:playAnim("idle")

	arg_18_0._targetPos = nil

	if arg_18_0._tweenId then
		ZProj.TweenHelper.KillById(arg_18_0._tweenId)

		arg_18_0._tweenId = nil
	end

	arg_18_0._callback = nil
	arg_18_0._callObj = nil
	arg_18_0._callParam = nil
	arg_18_0._pathcallback = nil
	arg_18_0._pathcallObj = nil
	arg_18_0._pathcallParam = nil

	SurvivalMapHelper.instance:getScene().path:hidePath()
end

function var_0_0.playAnim(arg_19_0, arg_19_1)
	arg_19_0._curAnimName = arg_19_1

	if arg_19_0._anim and arg_19_0._anim.isActiveAndEnabled then
		arg_19_0._anim:Play(arg_19_1, 0, 0)
	end
end

function var_0_0._onResLoadEnd(arg_20_0)
	local var_20_0 = arg_20_0._loader:getInstGO()
	local var_20_1 = var_20_0.transform

	arg_20_0.goModel = var_20_0

	transformhelper.setLocalPos(var_20_1, 0, 0, 0)
	transformhelper.setLocalRotation(var_20_1, 0, 0, 0)
	transformhelper.setLocalScale(var_20_1, 1, 1, 1)

	arg_20_0._anim = gohelper.findChildAnim(var_20_0, "")

	if arg_20_0._curAnimName then
		arg_20_0:playAnim(arg_20_0._curAnimName)
	end

	arg_20_0:onLoadedEnd()
end

function var_0_0.isIdle(arg_21_0)
	return arg_21_0._curAnimName == "idle" and not arg_21_0._targetPos and (not arg_21_0._path or #arg_21_0._path == 0)
end

function var_0_0.canShow(arg_22_0)
	if not arg_22_0:isIdle() then
		return true
	end

	local var_22_0 = SurvivalMapHelper.instance:getAllShelterEntity()

	if var_22_0 then
		for iter_22_0, iter_22_1 in pairs(var_22_0) do
			if iter_22_0 ~= SurvivalEnum.ShelterUnitType.Player then
				for iter_22_2, iter_22_3 in pairs(iter_22_1) do
					if iter_22_3:isVisible() and iter_22_3:isInPlayerPos() then
						return false
					end
				end
			end
		end
	end

	return true
end

function var_0_0.isInPos(arg_23_0, arg_23_1)
	if not arg_23_0:isIdle() then
		return false
	end

	return arg_23_1 == arg_23_0:getPos()
end

function var_0_0.isInPosList(arg_24_0, arg_24_1)
	if not arg_24_1 then
		return false
	end

	if not arg_24_0:isIdle() then
		return false
	end

	local var_24_0 = arg_24_0:getPos()

	return SurvivalHelper.instance:isHaveNode(arg_24_1, var_24_0)
end

function var_0_0.onUpdateEntity(arg_25_0)
	return
end

function var_0_0.needUI(arg_26_0)
	return true
end

function var_0_0.onClickPlayer(arg_27_0)
	if not arg_27_0:isIdle() then
		arg_27_0:focusEntity()

		return
	end

	local var_27_0 = SurvivalMapHelper.instance:getAllShelterEntity()

	if var_27_0 then
		for iter_27_0, iter_27_1 in pairs(var_27_0) do
			if iter_27_0 ~= SurvivalEnum.ShelterUnitType.Player then
				for iter_27_2, iter_27_3 in pairs(iter_27_1) do
					if iter_27_3:isInPlayerPos() then
						SurvivalMapHelper.instance:gotoUnit(iter_27_0, iter_27_2)

						return
					end
				end
			end
		end
	end

	arg_27_0:focusEntity()
end

return var_0_0
