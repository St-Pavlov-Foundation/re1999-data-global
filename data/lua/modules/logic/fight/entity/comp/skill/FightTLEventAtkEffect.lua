module("modules.logic.fight.entity.comp.skill.FightTLEventAtkEffect", package.seeall)

local var_0_0 = class("FightTLEventAtkEffect", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if not FightHelper.detectTimelinePlayEffectCondition(arg_1_1, arg_1_3[10]) then
		return
	end

	arg_1_0._attacker = FightHelper.getEntity(arg_1_1.fromId)

	if arg_1_0._attacker.skill and arg_1_0._attacker.skill:atkEffectNeedFilter(arg_1_3[1], arg_1_1) then
		return
	end

	arg_1_0.fightStepData = arg_1_1
	arg_1_0.duration = arg_1_2
	arg_1_0.paramsArr = arg_1_3
	arg_1_0.release_time = not string.nilorempty(arg_1_3[9]) and arg_1_3[9] ~= "0" and tonumber(arg_1_3[9])

	local var_1_0 = arg_1_3[6]

	if var_1_0 == "1" then
		arg_1_0._targetEntity = arg_1_0._attacker
	elseif not string.nilorempty(var_1_0) then
		local var_1_1 = GameSceneMgr.instance:getCurScene().entityMgr
		local var_1_2 = arg_1_1.stepUid .. "_" .. var_1_0
		local var_1_3 = var_1_1:getUnit(SceneTag.UnitNpc, var_1_2)

		if var_1_3 then
			arg_1_0._targetEntity = var_1_3
		else
			arg_1_0.load_entity_id = var_1_2

			FightController.instance:registerCallback(FightEvent.OnSpineLoaded, arg_1_0._onSpineLoaded, arg_1_0)

			return
		end
	else
		arg_1_0._targetEntity = arg_1_0._attacker
	end

	arg_1_0:_bootLogic(arg_1_1, arg_1_2, arg_1_3)

	if not string.nilorempty(arg_1_3[11]) then
		AudioMgr.instance:trigger(tonumber(arg_1_3[11]))
	end
end

function var_0_0._bootLogic(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0._effectName = arg_2_3[1]

	if not string.nilorempty(arg_2_3[12]) then
		local var_2_0 = arg_2_0._attacker:getMO()
		local var_2_1 = var_2_0 and var_2_0.skin

		if var_2_1 then
			local var_2_2 = string.split(arg_2_3[12], "|")

			for iter_2_0, iter_2_1 in ipairs(var_2_2) do
				local var_2_3 = string.split(iter_2_1, "#")

				if tonumber(var_2_3[1]) == var_2_1 then
					arg_2_0._effectName = var_2_3[2]

					break
				end
			end
		end
	end

	arg_2_0._hangPoint = arg_2_3[2]
	arg_2_0._offsetX, arg_2_0._offsetY, arg_2_0._offsetZ = 0, 0, 0

	if arg_2_3[3] then
		local var_2_4 = string.split(arg_2_3[3], ",")

		arg_2_0._offsetX = var_2_4[1] and tonumber(var_2_4[1]) or arg_2_0._offsetX
		arg_2_0._offsetY = var_2_4[2] and tonumber(var_2_4[2]) or arg_2_0._offsetY
		arg_2_0._offsetZ = var_2_4[3] and tonumber(var_2_4[3]) or arg_2_0._offsetZ
	end

	local var_2_5 = tonumber(arg_2_3[4]) or -1

	arg_2_0._notHangCenter = arg_2_3[5]

	local var_2_6 = arg_2_3[6]
	local var_2_7 = arg_2_3[7] == "1"
	local var_2_8 = arg_2_3[8] == "1"

	if arg_2_0._targetEntity and not arg_2_0._targetEntity:isMySide() then
		arg_2_0._offsetX = -arg_2_0._offsetX
	end

	if string.nilorempty(arg_2_0._effectName) then
		logError("atk effect name is nil,攻击特效配了空，")
	else
		arg_2_0._effectWrap = arg_2_0:_createEffect(arg_2_0._effectName, arg_2_0._hangPoint)

		if arg_2_0._effectWrap then
			arg_2_0:_setRenderOrder(arg_2_0._effectWrap, var_2_5)

			if string.nilorempty(arg_2_0._hangPoint) and var_2_7 then
				TaskDispatcher.runRepeat(arg_2_0._onFrameUpdateEffectPos, arg_2_0, 0.01)
			end

			if var_2_8 then
				TaskDispatcher.runRepeat(arg_2_0._onFrameUpdateEffectRotation, arg_2_0, 0.01)
			end

			if not string.nilorempty(arg_2_3[13]) then
				local var_2_9 = string.split(arg_2_3[13], "#")
				local var_2_10 = var_2_9[1]
				local var_2_11 = var_2_9[2]
				local var_2_12 = var_2_10 + var_2_11
				local var_2_13 = FightHelper.getEntity(arg_2_1.fromId)
				local var_2_14 = FightHelper.getEntity(arg_2_1.toId)

				if var_2_13 and var_2_14 then
					local var_2_15, var_2_16, var_2_17 = transformhelper.getLocalPos(var_2_13.go.transform)
					local var_2_18, var_2_19, var_2_20 = transformhelper.getLocalPos(var_2_14.go.transform)
					local var_2_21 = (math.abs(var_2_15 - var_2_18) + var_2_11) / var_2_12

					if arg_2_0._effectWrap.containerTr then
						local var_2_22, var_2_23, var_2_24 = transformhelper.getLocalPos(arg_2_0._effectWrap.containerTr)
						local var_2_25, var_2_26, var_2_27 = transformhelper.getLocalScale(arg_2_0._effectWrap.containerTr)

						transformhelper.setLocalScale(arg_2_0._effectWrap.containerTr, var_2_21, var_2_26, var_2_27)
						transformhelper.setLocalPos(arg_2_0._effectWrap.containerTr, var_2_22, var_2_23, var_2_24)
					end
				end
			end
		end
	end
end

function var_0_0.onTrackEnd(arg_3_0)
	arg_3_0:_removeEffect()
end

function var_0_0._createEffect(arg_4_0)
	local var_4_0

	if not string.nilorempty(arg_4_0._hangPoint) then
		local var_4_1 = {
			x = arg_4_0._offsetX,
			y = arg_4_0._offsetY,
			z = arg_4_0._offsetZ
		}

		var_4_0 = arg_4_0._targetEntity.effect:addHangEffect(arg_4_0._effectName, arg_4_0._hangPoint, nil, arg_4_0.release_time, var_4_1)

		var_4_0:setLocalPos(arg_4_0._offsetX, arg_4_0._offsetY, arg_4_0._offsetZ)
	else
		var_4_0 = arg_4_0._targetEntity.effect:addGlobalEffect(arg_4_0._effectName, nil, arg_4_0.release_time)

		local var_4_2, var_4_3, var_4_4 = arg_4_0:_getTargetPosXYZ()

		var_4_0:setWorldPos(var_4_2 + arg_4_0._offsetX, var_4_3 + arg_4_0._offsetY, var_4_4 + arg_4_0._offsetZ)
	end

	if arg_4_0.paramsArr[1] == "v2a2_tsnn/tsnn_unique_08_s5" or arg_4_0.paramsArr[1] == "v2a2_tsnn/tsnn_unique_09_s6" then
		TaskDispatcher.runRepeat(function()
			var_4_0:setLocalPos(0, 0, 0)
		end, arg_4_0, 0.01, 5)
	end

	return var_4_0
end

function var_0_0._getTargetPosXYZ(arg_6_0)
	local var_6_0
	local var_6_1
	local var_6_2

	if arg_6_0._notHangCenter == "0" then
		var_6_0, var_6_1, var_6_2 = FightHelper.getEntityWorldBottomPos(arg_6_0._targetEntity)
	elseif arg_6_0._notHangCenter == "1" then
		var_6_0, var_6_1, var_6_2 = FightHelper.getEntityWorldCenterPos(arg_6_0._targetEntity)
	elseif arg_6_0._notHangCenter == "2" then
		var_6_0, var_6_1, var_6_2 = FightHelper.getEntityWorldTopPos(arg_6_0._targetEntity)
	elseif arg_6_0._notHangCenter == "3" then
		var_6_0, var_6_1, var_6_2 = transformhelper.getPos(arg_6_0._targetEntity.go.transform)
	elseif arg_6_0._notHangCenter == "4" then
		local var_6_3 = FightDataHelper.entityMgr:getById(arg_6_0._targetEntity.id)

		var_6_0, var_6_1, var_6_2 = FightHelper.getEntityStandPos(var_6_3)
	else
		local var_6_4 = not string.nilorempty(arg_6_0._notHangCenter) and arg_6_0._targetEntity:getHangPoint(arg_6_0._notHangCenter)

		if var_6_4 then
			local var_6_5 = var_6_4.transform.position

			var_6_0, var_6_1, var_6_2 = var_6_5.x, var_6_5.y, var_6_5.z
		else
			var_6_0, var_6_1, var_6_2 = transformhelper.getPos(arg_6_0._targetEntity.go.transform)
		end
	end

	return var_6_0, var_6_1, var_6_2
end

function var_0_0._setRenderOrder(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_2 == -1 then
		FightRenderOrderMgr.instance:onAddEffectWrap(arg_7_0._attacker.id, arg_7_1)
	else
		FightRenderOrderMgr.instance:setEffectOrder(arg_7_1, arg_7_2)
	end
end

function var_0_0._onFrameUpdateEffectPos(arg_8_0)
	if not arg_8_0._targetEntity then
		return
	end

	if gohelper.isNil(arg_8_0._targetEntity.go) then
		return
	end

	if arg_8_0._effectWrap then
		local var_8_0, var_8_1, var_8_2 = arg_8_0:_getTargetPosXYZ()

		arg_8_0._effectWrap:setWorldPos(var_8_0 + arg_8_0._offsetX, var_8_1 + arg_8_0._offsetY, var_8_2 + arg_8_0._offsetZ)
	end
end

function var_0_0._onFrameUpdateEffectRotation(arg_9_0)
	if not arg_9_0._targetEntity then
		return
	end

	if gohelper.isNil(arg_9_0._targetEntity.go) then
		return
	end

	if arg_9_0._effectWrap and not gohelper.isNil(arg_9_0._effectWrap.containerTr) then
		transformhelper.setRotation(arg_9_0._effectWrap.containerTr, 0, 0, 0, 1)
	end
end

function var_0_0._onSpineLoaded(arg_10_0, arg_10_1)
	if arg_10_1 and arg_10_1.unitSpawn and arg_10_1.unitSpawn.id == arg_10_0.load_entity_id then
		arg_10_0._targetEntity = arg_10_1.unitSpawn

		FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, arg_10_0._onSpineLoaded, arg_10_0)
		arg_10_0:_bootLogic(arg_10_0.fightStepData, arg_10_0.duration, arg_10_0.paramsArr)
	end
end

function var_0_0.onDestructor(arg_11_0)
	arg_11_0:_removeEffect()
	TaskDispatcher.cancelTask(arg_11_0._onFrameUpdateEffectPos, arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._onFrameUpdateEffectRotation, arg_11_0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, arg_11_0._onSpineLoaded, arg_11_0)
end

function var_0_0._removeEffect(arg_12_0)
	if arg_12_0._effectWrap and not arg_12_0.release_time then
		FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_12_0._targetEntity.id, arg_12_0._effectWrap)
		arg_12_0._targetEntity.effect:removeEffect(arg_12_0._effectWrap)

		arg_12_0._effectWrap = nil
	end

	arg_12_0._targetEntity = nil
end

return var_0_0
