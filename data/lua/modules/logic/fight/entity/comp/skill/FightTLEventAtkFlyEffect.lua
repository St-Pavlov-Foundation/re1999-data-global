module("modules.logic.fight.entity.comp.skill.FightTLEventAtkFlyEffect", package.seeall)

local var_0_0 = class("FightTLEventAtkFlyEffect", FightTimelineTrackItem)
local var_0_1 = {
	[-666] = true,
	[FightEnum.EffectType.MISS] = true,
	[FightEnum.EffectType.DAMAGE] = true,
	[FightEnum.EffectType.CRIT] = true,
	[FightEnum.EffectType.COLDSATURDAYHURT] = true
}

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._attacker = FightHelper.getEntity(arg_1_1.fromId)

	if arg_1_0._attacker.skill:flyEffectNeedFilter(arg_1_3[1], arg_1_1) then
		return
	end

	arg_1_0._paramsArr = arg_1_3
	arg_1_0._effectName = arg_1_3[1]
	arg_1_0.fightStepData = arg_1_1
	arg_1_0._duration = arg_1_2
	arg_1_0._releaseTime = tonumber(arg_1_3[22])
	arg_1_0._tokenRelease = not string.nilorempty(arg_1_0._paramsArr[23])

	if string.nilorempty(arg_1_0._effectName) then
		logError("atk effect name is nil")

		return
	end

	local var_1_0 = string.nilorempty(arg_1_3[2]) and 2 or tonumber(arg_1_3[2])
	local var_1_1 = 0
	local var_1_2 = 0
	local var_1_3 = 0

	if arg_1_3[4] then
		local var_1_4 = string.split(arg_1_3[4], ",")

		var_1_1 = var_1_4[1] and tonumber(var_1_4[1]) or var_1_1
		var_1_2 = var_1_4[2] and tonumber(var_1_4[2]) or var_1_2
		var_1_3 = var_1_4[3] and tonumber(var_1_4[3]) or var_1_3
	end

	if not string.nilorempty(arg_1_3[21]) then
		local var_1_5 = GameUtil.splitString2(arg_1_3[21], true, "#", ",")

		if #var_1_5 > 0 then
			local var_1_6 = var_1_5[math.random(1, #var_1_5)]

			var_1_1 = var_1_6[1] or var_1_1
			var_1_2 = var_1_6[2] or var_1_2
			var_1_3 = var_1_6[3] or var_1_3
		end
	end

	local var_1_7 = 0
	local var_1_8 = 0
	local var_1_9 = 0

	if arg_1_3[5] then
		local var_1_10 = string.split(arg_1_3[5], ",")

		var_1_7 = var_1_10[1] and tonumber(var_1_10[1]) or var_1_7
		var_1_8 = var_1_10[2] and tonumber(var_1_10[2]) or var_1_8
		var_1_9 = var_1_10[3] and tonumber(var_1_10[3]) or var_1_9
	end

	arg_1_0._easeFunc = arg_1_3[6]
	arg_1_0._parabolaHeight = tonumber(arg_1_3[7])
	arg_1_0._bezierParam = arg_1_3[8]
	arg_1_0._curveParam = arg_1_3[9]
	arg_1_0._previousFrame = arg_1_3[10] and tonumber(arg_1_3[10]) or 0
	arg_1_0._afterFrame = arg_1_3[11] and tonumber(arg_1_3[11]) or 0
	arg_1_0._withRotation = arg_1_3[12] and tonumber(arg_1_3[12]) or 1
	arg_1_0._tCurveParam = arg_1_3[13]
	arg_1_0._alwayForceLookForward = arg_1_3[14] and tonumber(arg_1_3[14])
	arg_1_0._act_on_index_entity = arg_1_3[15] and tonumber(arg_1_3[15])
	arg_1_0._onlyActOnToId = arg_1_3[19] == "1"
	arg_1_0._actSide = nil

	if not string.nilorempty(arg_1_3[20]) then
		local var_1_11 = arg_1_3[20]

		if var_1_11 == "1" then
			arg_1_0._actSide = FightEnum.EntitySide.EnemySide
		elseif var_1_11 == "2" then
			arg_1_0._actSide = FightEnum.EntitySide.MySide
		end
	end

	if arg_1_0._act_on_index_entity then
		arg_1_0._actEffect_list = FightHelper.dealDirectActEffectData(arg_1_0.fightStepData.actEffect, arg_1_0._act_on_index_entity, var_0_1)
	else
		arg_1_0._actEffect_list = arg_1_0.fightStepData.actEffect
	end

	if string.nilorempty(arg_1_3[16]) then
		arg_1_0._act_entity_finished = nil
	else
		arg_1_0._act_entity_finished = {}
	end

	arg_1_0._attacker = FightHelper.getEntity(arg_1_1.fromId)

	if not arg_1_0._attacker:isMySide() then
		var_1_1 = -var_1_1
	end

	local var_1_12, var_1_13, var_1_14 = transformhelper.getPos(arg_1_0._attacker.go.transform)

	if arg_1_3[17] == "1" then
		local var_1_15 = FightHelper.getEntity(arg_1_1.toId)

		var_1_12, var_1_13, var_1_14 = transformhelper.getPos(var_1_15.go.transform)
	elseif arg_1_3[17] == "2" then
		var_1_12, var_1_13, var_1_14 = FightHelper.getProcessEntityStancePos(arg_1_0._attacker:getMO())
	elseif arg_1_3[17] == "3" then
		local var_1_16 = FightHelper.getEntity(arg_1_1.toId)

		if var_1_16 then
			var_1_12, var_1_13, var_1_14 = FightHelper.getEntityWorldCenterPos(var_1_16)
		end
	end

	local var_1_17 = var_1_12 + var_1_1
	local var_1_18 = var_1_13 + var_1_2
	local var_1_19 = var_1_14 + var_1_3

	if arg_1_3[3] == "1" then
		local var_1_20 = string.split(arg_1_3[4], ",")

		var_1_17 = var_1_20[1] and tonumber(var_1_20[1]) or 0

		if not arg_1_0._attacker:isMySide() then
			var_1_17 = -var_1_17
		end

		var_1_18 = var_1_20[2] and tonumber(var_1_20[2]) or 0
		var_1_19 = var_1_20[3] and tonumber(var_1_20[3]) or 0
	end

	if var_1_0 == 1 then
		arg_1_0:_flyEffectSingle(var_1_17, var_1_18, var_1_19, var_1_7, var_1_8, var_1_9)
	elseif var_1_0 == 2 then
		arg_1_0:_flyEffectTarget(var_1_17, var_1_18, var_1_19, var_1_7, var_1_8, var_1_9, FightHelper.getEntityWorldCenterPos)
	elseif var_1_0 == 3 then
		arg_1_0:_flyEffectTarget(var_1_17, var_1_18, var_1_19, var_1_7, var_1_8, var_1_9, false)
	elseif var_1_0 == 4 then
		arg_1_0:_flyEffectSingle(var_1_17, var_1_18, var_1_19, var_1_7, var_1_8, var_1_9, true)
	elseif var_1_0 == 5 then
		local var_1_21, var_1_22, var_1_23 = FightHelper.getProcessEntitySpinePos(arg_1_0._attacker)

		var_1_7 = var_1_7 + var_1_21

		if not arg_1_0._attacker:isMySide() then
			var_1_7 = -var_1_7
		end

		var_1_8 = var_1_8 + var_1_22
		var_1_9 = var_1_9 + var_1_23

		arg_1_0:_flyEffectSingle(var_1_17, var_1_18, var_1_19, var_1_7, var_1_8, var_1_9)
	elseif var_1_0 == 6 then
		arg_1_0:_flyEffectAbsolutely(var_1_17, var_1_18, var_1_19, var_1_7, var_1_8, var_1_9)
	else
		arg_1_0:_flyEffectTarget(var_1_17, var_1_18, var_1_19, var_1_7, var_1_8, var_1_9, FightHelper.getEntityHangPointPos, arg_1_3[2])
	end

	local var_1_24 = arg_1_0._duration * FightModel.instance:getSpeed()

	arg_1_0._totalFrame = arg_1_0.binder:GetFrameFloatByTime(var_1_24) - arg_1_0._previousFrame - arg_1_0._afterFrame
	arg_1_0._startFrame = arg_1_0.binder.CurFrameFloat + 1

	arg_1_0:_startFly()
end

function var_0_0.onTrackEnd(arg_2_0)
	if arg_2_0._paramsArr and arg_2_0._paramsArr[18] ~= "1" then
		arg_2_0:_removeEffect()
		arg_2_0:_removeMover()
	end
end

function var_0_0._flyEffectAbsolutely(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6, arg_3_7)
	if arg_3_0._attacker:isEnemySide() then
		arg_3_4 = -arg_3_4
	end

	arg_3_0:_addFlyEffect(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6)
end

function var_0_0._flyEffectSingle(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6, arg_4_7)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0._actEffect_list) do
		local var_4_0 = var_0_1[iter_4_1.effectType]

		if not var_4_0 and iter_4_1.effectType ~= FightEnum.EffectType.EXPOINTCHANGE and iter_4_1.effectType ~= FightEnum.EffectType.FIGHTSTEP and arg_4_0._act_entity_finished and not arg_4_0._act_entity_finished[iter_4_1.targetId] then
			var_4_0 = true
		end

		local var_4_1 = FightHelper.getEntity(iter_4_1.targetId)

		if arg_4_7 then
			local var_4_2 = FightHelper.getEntity(arg_4_0.fightStepData.fromId)

			if var_4_2 and var_4_1 and var_4_2:getSide() == var_4_1:getSide() then
				var_4_0 = false
			end
		end

		if arg_4_0._onlyActOnToId and iter_4_1.targetId ~= arg_4_0.fightStepData.toId then
			var_4_0 = false
		end

		if arg_4_0._actSide and var_4_1 and arg_4_0._actSide ~= var_4_1:getSide() then
			var_4_0 = false
		end

		if var_4_0 and var_4_1 then
			arg_4_4 = var_4_1:isMySide() and -arg_4_4 or arg_4_4

			arg_4_0:_addFlyEffect(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)

			if arg_4_0._act_entity_finished then
				arg_4_0._act_entity_finished[var_4_1.id] = true
			end

			break
		end
	end
end

function var_0_0._flyEffectTarget(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6, arg_5_7, arg_5_8)
	local var_5_0 = arg_5_0._actEffect_list

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		local var_5_1 = var_0_1[iter_5_1.effectType]

		if not var_5_1 and arg_5_0._act_entity_finished and not arg_5_0._act_entity_finished[iter_5_1.targetId] then
			var_5_1 = true
		end

		if arg_5_0._onlyActOnToId and iter_5_1.targetId ~= arg_5_0.fightStepData.toId then
			var_5_1 = false
		end

		local var_5_2 = FightHelper.getEntity(iter_5_1.targetId)

		if arg_5_0._actSide and var_5_2 and arg_5_0._actSide ~= var_5_2:getSide() then
			var_5_1 = false
		end

		if var_5_1 then
			if var_5_2 then
				local var_5_3, var_5_4, var_5_5 = (arg_5_7 or FightHelper.getEntityWorldBottomPos)(var_5_2, arg_5_8)
				local var_5_6 = var_5_3 + (var_5_2:isMySide() and -arg_5_4 or arg_5_4)
				local var_5_7 = var_5_4 + arg_5_5
				local var_5_8 = var_5_5 + arg_5_6

				arg_5_0:_addFlyEffect(arg_5_1, arg_5_2, arg_5_3, var_5_6, var_5_7, var_5_8)

				if arg_5_0._act_entity_finished then
					arg_5_0._act_entity_finished[var_5_2.id] = true
				end
			else
				logNormal("fly effect to defender fail, entity not exist: " .. iter_5_1.targetId)
			end
		end
	end
end

function var_0_0._addFlyEffect(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6)
	local var_6_0 = arg_6_0._attacker.effect:addGlobalEffect(arg_6_0._effectName, nil, arg_6_0._releaseTime)

	if arg_6_0._tokenRelease then
		arg_6_0._attacker.effect:addTokenRelease(arg_6_0._paramsArr[23], var_6_0)
	end

	var_6_0:setWorldPos(arg_6_1, arg_6_2, arg_6_3)

	arg_6_0._flyParamDict = arg_6_0._flyParamDict or {}

	local var_6_1 = {
		startX = arg_6_1,
		startY = arg_6_2,
		startZ = arg_6_3,
		endX = arg_6_4,
		endY = arg_6_5,
		endZ = arg_6_6
	}

	arg_6_0._flyParamDict[var_6_0.uniqueId] = var_6_1
	arg_6_0._attackEffectWrapList = arg_6_0._attackEffectWrapList or {}

	table.insert(arg_6_0._attackEffectWrapList, var_6_0)
	FightRenderOrderMgr.instance:onAddEffectWrap(arg_6_0._attacker.id, var_6_0)
end

function var_0_0._startFly(arg_7_0)
	if not arg_7_0._attackEffectWrapList then
		return
	end

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._attackEffectWrapList) do
		local var_7_0 = arg_7_0._flyParamDict[iter_7_1.uniqueId]

		if var_7_0 then
			local var_7_1 = var_7_0.startX
			local var_7_2 = var_7_0.startY
			local var_7_3 = var_7_0.startZ
			local var_7_4 = var_7_0.endX
			local var_7_5 = var_7_0.endY
			local var_7_6 = var_7_0.endZ

			iter_7_1:setWorldPos(var_7_1, var_7_2, var_7_3)

			if arg_7_0._parabolaHeight then
				arg_7_0:_setParabolaMove(iter_7_1, var_7_1, var_7_2, var_7_3, var_7_4, var_7_5, var_7_6)
			elseif not string.nilorempty(arg_7_0._bezierParam) then
				arg_7_0:_setBezierMove(iter_7_1, var_7_1, var_7_2, var_7_3, var_7_4, var_7_5, var_7_6)
			elseif not string.nilorempty(arg_7_0._curveParam) then
				arg_7_0:_setCurveMove(iter_7_1, var_7_1, var_7_2, var_7_3, var_7_4, var_7_5, var_7_6)
			else
				arg_7_0:_setEaseMove(iter_7_1, var_7_1, var_7_2, var_7_3, var_7_4, var_7_5, var_7_6)
			end
		end
	end
end

function var_0_0._setEaseMove(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6, arg_8_7)
	if arg_8_0._withRotation == 1 then
		arg_8_0:_calcRotation(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6, arg_8_7)
	end

	local var_8_0 = MonoHelper.addLuaComOnceToGo(arg_8_1.containerGO, UnitMoverEase)

	MonoHelper.addLuaComOnceToGo(arg_8_1.containerGO, UnitMoverHandler)
	var_8_0:setEaseType(EaseType.Str2Type(arg_8_0._easeFunc))
	var_8_0:simpleMove(arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6, arg_8_7, arg_8_0._duration)

	if arg_8_0._previousFrame > 0 or arg_8_0._afterFrame > 0 then
		var_8_0:setGetTimeFunction(arg_8_0.getTimeFunction, arg_8_0)
	end

	arg_8_0._mover = var_8_0
end

function var_0_0._setParabolaMove(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6, arg_9_7)
	local var_9_0 = MonoHelper.addLuaComOnceToGo(arg_9_1.containerGO, UnitMoverParabola)

	MonoHelper.addLuaComOnceToGo(arg_9_1.containerGO, UnitMoverHandler)
	var_9_0:simpleMove(arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6, arg_9_7, arg_9_0._duration, arg_9_0._parabolaHeight)

	if arg_9_0._withRotation == 1 then
		var_9_0:registerCallback(UnitMoveEvent.PosChanged, arg_9_0._onPosChange, arg_9_0)

		arg_9_0._moverParamDict = arg_9_0._moverParamDict or {}

		local var_9_1 = {
			mover = var_9_0,
			effectWrap = arg_9_1,
			startX = arg_9_2,
			startY = arg_9_3,
			startZ = arg_9_4
		}

		arg_9_0._moverParamDict[var_9_0] = var_9_1
	end

	if arg_9_0._previousFrame > 0 or arg_9_0._afterFrame > 0 then
		var_9_0:setGetFrameFunction(arg_9_0.getFrameFunction, arg_9_0)
	end

	arg_9_0._mover = var_9_0
end

function var_0_0._setBezierMove(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6, arg_10_7)
	if arg_10_0._withRotation == 1 then
		arg_10_0:_calcRotation(arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6, arg_10_7)
	end

	local var_10_0 = MonoHelper.addLuaComOnceToGo(arg_10_1.containerGO, UnitMoverBezier)

	MonoHelper.addLuaComOnceToGo(arg_10_1.containerGO, UnitMoverHandler)
	var_10_0:setBezierParam(arg_10_0._bezierParam)

	if not string.nilorempty(arg_10_0._easeFunc) then
		var_10_0:setEaseType(EaseType.Str2Type(arg_10_0._easeFunc))
	else
		var_10_0:setEaseType(nil)
	end

	var_10_0:simpleMove(arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6, arg_10_7, arg_10_0._duration)

	if arg_10_0._withRotation == 1 then
		-- block empty
	end

	if arg_10_0._alwayForceLookForward then
		var_10_0:registerCallback(UnitMoveEvent.PosChanged, arg_10_0._onAlwayForceLookForward, arg_10_0)

		arg_10_0._moverParamDict = arg_10_0._moverParamDict or {}

		local var_10_1 = {
			mover = var_10_0,
			effectWrap = arg_10_1,
			startX = arg_10_2,
			startY = arg_10_3,
			startZ = arg_10_4
		}

		arg_10_0._moverParamDict[var_10_0] = var_10_1
	end

	if arg_10_0._previousFrame > 0 or arg_10_0._afterFrame > 0 then
		var_10_0:setGetTimeFunction(arg_10_0.getTimeFunction, arg_10_0)
	end

	arg_10_0._mover = var_10_0
end

function var_0_0._setCurveMove(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6, arg_11_7)
	if arg_11_0._withRotation == 1 then
		arg_11_0:_calcRotation(arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6, arg_11_7)
	end

	local var_11_0 = MonoHelper.addLuaComOnceToGo(arg_11_1.containerGO, UnitMoverCurve)

	MonoHelper.addLuaComOnceToGo(arg_11_1.containerGO, UnitMoverHandler)
	var_11_0:setCurveParam(arg_11_0._curveParam)
	var_11_0:setTCurveParam(arg_11_0._tCurveParam)

	if not string.nilorempty(arg_11_0._easeFunc) then
		var_11_0:setEaseType(EaseType.Str2Type(arg_11_0._easeFunc))
	else
		var_11_0:setEaseType(nil)
	end

	var_11_0:simpleMove(arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6, arg_11_7, arg_11_0._duration)

	if arg_11_0._withRotation == 1 then
		-- block empty
	end

	if arg_11_0._alwayForceLookForward then
		var_11_0:registerCallback(UnitMoveEvent.PosChanged, arg_11_0._onAlwayForceLookForward, arg_11_0)

		arg_11_0._moverParamDict = arg_11_0._moverParamDict or {}

		local var_11_1 = {
			mover = var_11_0,
			effectWrap = arg_11_1,
			startX = arg_11_2,
			startY = arg_11_3,
			startZ = arg_11_4
		}

		arg_11_0._moverParamDict[var_11_0] = var_11_1
	end

	if arg_11_0._previousFrame > 0 or arg_11_0._afterFrame > 0 then
		var_11_0:setGetTimeFunction(arg_11_0.getTimeFunction, arg_11_0)
	end

	arg_11_0._mover = var_11_0
end

function var_0_0._onPosChange(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0._moverParamDict and arg_12_0._moverParamDict[arg_12_1]

	if var_12_0 then
		local var_12_1, var_12_2, var_12_3 = arg_12_1:getPos()
		local var_12_4 = var_12_0.effectWrap
		local var_12_5 = var_12_0.startX
		local var_12_6 = var_12_0.startY
		local var_12_7 = var_12_0.startZ

		arg_12_0:_calcRotation(var_12_4, var_12_5, var_12_6, var_12_7, var_12_1, var_12_2, var_12_3, arg_12_2)

		var_12_0.startX = var_12_1
		var_12_0.startY = var_12_2
		var_12_0.startZ = var_12_3
	end
end

function var_0_0._onAlwayForceLookForward(arg_13_0, arg_13_1)
	arg_13_0:_onPosChange(arg_13_1, arg_13_0._alwayForceLookForward)
end

function var_0_0._calcRotation(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5, arg_14_6, arg_14_7, arg_14_8)
	local var_14_0 = FightHelper.getEffectLookDir(arg_14_0._attacker:getSide())
	local var_14_1 = Quaternion.LookRotation(Vector3.New(arg_14_5 - arg_14_2, arg_14_6 - arg_14_3, arg_14_7 - arg_14_4), Vector3.up)
	local var_14_2 = Quaternion.AngleAxis(var_14_0, Vector3.up)
	local var_14_3 = Quaternion.AngleAxis(arg_14_8 or 90, Vector3.up)

	arg_14_1.containerTr.rotation = var_14_1 * var_14_2 * var_14_3
end

function var_0_0.getTimeFunction(arg_15_0)
	if not arg_15_0._attacker then
		return 1000
	end

	local var_15_0 = arg_15_0._attacker.skill:getCurFrameFloat()

	if not var_15_0 then
		return 1000
	end

	local var_15_1 = var_15_0 + 1 - arg_15_0._startFrame

	if var_15_1 <= arg_15_0._previousFrame then
		return 0
	end

	if arg_15_0._totalFrame <= 0 then
		return arg_15_0._duration
	end

	return (var_15_1 - arg_15_0._previousFrame) / arg_15_0._totalFrame * arg_15_0._duration
end

function var_0_0.getFrameFunction(arg_16_0)
	if not arg_16_0._attacker then
		return 1000, 1, 1
	end

	local var_16_0 = arg_16_0._attacker.skill:getCurFrameFloat()

	if not var_16_0 then
		return 1000, 1, 1
	end

	return var_16_0 + 1 - arg_16_0._startFrame, arg_16_0._previousFrame, arg_16_0._totalFrame
end

function var_0_0.onDestructor(arg_17_0)
	if arg_17_0._moverParamDict then
		for iter_17_0, iter_17_1 in pairs(arg_17_0._moverParamDict) do
			iter_17_0:unregisterCallback(UnitMoveEvent.PosChanged, arg_17_0._onPosChange, arg_17_0)
		end
	end

	arg_17_0._moverParamDict = nil

	arg_17_0:_removeEffect()
	arg_17_0:_removeMover()
end

function var_0_0._removeMover(arg_18_0)
	if arg_18_0._mover then
		if arg_18_0._mover.setGetTimeFunction then
			arg_18_0._mover:setGetTimeFunction(nil, nil)
		end

		if arg_18_0._mover.setGetFrameFunction then
			arg_18_0._mover:setGetFrameFunction(nil, nil)
		end

		arg_18_0._mover = nil
	end

	if arg_18_0._attackEffectWrapList then
		for iter_18_0, iter_18_1 in ipairs(arg_18_0._attackEffectWrapList) do
			MonoHelper.removeLuaComFromGo(iter_18_1.containerGO, UnitMoverEase)
			MonoHelper.removeLuaComFromGo(iter_18_1.containerGO, UnitMoverParabola)
			MonoHelper.removeLuaComFromGo(iter_18_1.containerGO, UnitMoverBezier)
			MonoHelper.removeLuaComFromGo(iter_18_1.containerGO, UnitMoverCurve)
			MonoHelper.removeLuaComFromGo(iter_18_1.containerGO, UnitMoverHandler)
		end
	end
end

function var_0_0._removeEffect(arg_19_0)
	local var_19_0 = true

	if arg_19_0._releaseTime then
		var_19_0 = false
	end

	if arg_19_0._tokenRelease then
		var_19_0 = false
	end

	if arg_19_0._attackEffectWrapList then
		for iter_19_0, iter_19_1 in ipairs(arg_19_0._attackEffectWrapList) do
			if var_19_0 then
				FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_19_0._attacker.id, iter_19_1)
				arg_19_0._attacker.effect:removeEffect(iter_19_1)
			end
		end

		arg_19_0._attackEffectWrapList = nil
	end

	arg_19_0._flyParamDict = nil
	arg_19_0._attacker = nil
end

return var_0_0
