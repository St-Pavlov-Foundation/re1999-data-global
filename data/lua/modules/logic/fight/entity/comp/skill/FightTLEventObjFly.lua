module("modules.logic.fight.entity.comp.skill.FightTLEventObjFly", package.seeall)

local var_0_0 = class("FightTLEventObjFly", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.fly_obj = nil
	arg_1_0.entityMgr = GameSceneMgr.instance:getCurScene().entityMgr
	arg_1_0.from_entity = arg_1_0.entityMgr:getEntity(arg_1_1.fromId)
	arg_1_0.to_entity = arg_1_0.entityMgr:getEntity(arg_1_1.toId)
	arg_1_0.params_arr = arg_1_3
	arg_1_0._duration = arg_1_2

	local var_1_0 = tonumber(arg_1_3[1])

	if var_1_0 == 1 then
		-- block empty
	elseif var_1_0 == 2 and arg_1_0.from_entity and arg_1_0.from_entity:isMySide() then
		arg_1_0.fly_obj = arg_1_0.entityMgr:getEntity(arg_1_1.fromId).spine:getSpineGO()
		arg_1_0._attacker = FightHelper.getEntity(FightEntityScene.MySideId)

		arg_1_0.timelineItem.workTimelineItem:_cancelSideRenderOrder()
	end

	if not arg_1_0.fly_obj then
		return
	end

	arg_1_0:calFly(arg_1_1, arg_1_3)
end

function var_0_0.calFly(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.fightStepData = arg_2_1

	local var_2_0 = 0
	local var_2_1 = 0
	local var_2_2 = 0

	if arg_2_2[3] then
		local var_2_3 = string.split(arg_2_2[3], ",")

		var_2_0 = var_2_3[1] and tonumber(var_2_3[1]) or var_2_0
		var_2_1 = var_2_3[2] and tonumber(var_2_3[2]) or var_2_1
		var_2_2 = var_2_3[3] and tonumber(var_2_3[3]) or var_2_2
	end

	local var_2_4 = 0
	local var_2_5 = 0
	local var_2_6 = 0

	if arg_2_2[4] then
		local var_2_7 = string.split(arg_2_2[4], ",")

		var_2_4 = var_2_7[1] and tonumber(var_2_7[1]) or var_2_4
		var_2_5 = var_2_7[2] and tonumber(var_2_7[2]) or var_2_5
		var_2_6 = var_2_7[3] and tonumber(var_2_7[3]) or var_2_6
	end

	arg_2_0._easeFunc = arg_2_2[5]
	arg_2_0._y_offset_cruve = arg_2_2[6]
	arg_2_0._x_move_cruve = arg_2_2[7]
	arg_2_0._y_move_cruve = arg_2_2[8]
	arg_2_0._z_move_cruve = arg_2_2[9]
	arg_2_0._withRotation = arg_2_2[10] and tonumber(arg_2_2[10]) or 0

	if arg_2_0.from_entity and not arg_2_0.from_entity:isMySide() then
		var_2_0 = -var_2_0
	end

	local var_2_8, var_2_9, var_2_10 = transformhelper.getPos(arg_2_0.fly_obj.transform)
	local var_2_11 = var_2_8 + var_2_0
	local var_2_12 = var_2_9 + var_2_1
	local var_2_13 = var_2_10 + var_2_2
	local var_2_14 = string.nilorempty(arg_2_2[2]) and 2 or tonumber(arg_2_2[2])
	local var_2_15
	local var_2_16
	local var_2_17

	if arg_2_1.forcePosX then
		var_2_15, var_2_16, var_2_17 = arg_2_1.forcePosX, arg_2_1.forcePosY, arg_2_1.forcePosZ
	else
		var_2_15, var_2_16, var_2_17 = arg_2_0:calEndPos(var_2_14, var_2_4, var_2_5, var_2_6)
	end

	local var_2_18 = arg_2_0._duration * FightModel.instance:getSpeed()

	arg_2_0._totalFrame = arg_2_0.binder:GetFrameFloatByTime(var_2_18)
	arg_2_0._startFrame = arg_2_0.binder.CurFrameFloat + 1

	arg_2_0:_startFly(var_2_11, var_2_12, var_2_13, var_2_15, var_2_16, var_2_17)
end

function var_0_0._startFly(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6)
	arg_3_0:_setCurveMove(arg_3_0.fly_obj, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6)
end

function var_0_0._setCurveMove(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6, arg_4_7)
	if arg_4_0._withRotation == 1 then
		arg_4_0:_calcRotation(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6, arg_4_7)
	end

	arg_4_0.UnitMoverCurve_comp = MonoHelper.getLuaComFromGo(arg_4_1, UnitMoverCurve)
	arg_4_0.UnitMoverHandler_comp = MonoHelper.getLuaComFromGo(arg_4_1, UnitMoverHandler)

	local var_4_0 = MonoHelper.addLuaComOnceToGo(arg_4_1, UnitMoverCurve)
	local var_4_1 = MonoHelper.addLuaComOnceToGo(arg_4_1, UnitMoverHandler)

	var_4_1:init(arg_4_1)
	var_4_1:addEventListeners()
	var_4_0:setXMoveCruve(arg_4_0._x_move_cruve)
	var_4_0:setYMoveCruve(arg_4_0._y_move_cruve)
	var_4_0:setZMoveCruve(arg_4_0._z_move_cruve)
	var_4_0:setCurveParam(arg_4_0._y_offset_cruve)

	if not string.nilorempty(arg_4_0._easeFunc) then
		var_4_0:setEaseType(EaseType.Str2Type(arg_4_0._easeFunc))
	else
		var_4_0:setEaseType(nil)
	end

	var_4_0:simpleMove(arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6, arg_4_7, arg_4_0._duration)
end

function var_0_0._onPosChange(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._moverParamDict and arg_5_0._moverParamDict[arg_5_1]

	if var_5_0 then
		local var_5_1, var_5_2, var_5_3 = arg_5_1:getPos()
		local var_5_4 = var_5_0.target_obj
		local var_5_5 = var_5_0.startPosX
		local var_5_6 = var_5_0.startPosY
		local var_5_7 = var_5_0.startPosZ

		arg_5_0:_calcRotation(var_5_4, var_5_5, var_5_6, var_5_7, var_5_1, var_5_2, var_5_3)

		var_5_0.startPosX = var_5_1
		var_5_0.startPosY = var_5_2
		var_5_0.startPosZ = var_5_3
	end
end

function var_0_0._calcRotation(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6, arg_6_7)
	local var_6_0 = FightHelper.getEffectLookDir(arg_6_0.from_entity:getSide())
	local var_6_1 = Quaternion.LookRotation(Vector3.New(arg_6_5 - arg_6_2, arg_6_6 - arg_6_3, arg_6_7 - arg_6_4), Vector3.up)
	local var_6_2 = Quaternion.AngleAxis(var_6_0, Vector3.up)
	local var_6_3 = Quaternion.AngleAxis(90, Vector3.up)

	arg_6_1.transform.rotation = var_6_1 * var_6_2 * var_6_3
end

function var_0_0.calEndPos(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if arg_7_1 == 1 then
		return arg_7_2, arg_7_3, arg_7_4
	elseif arg_7_1 == 2 then
		return arg_7_0:_flyEffectTarget(arg_7_2, arg_7_3, arg_7_4, FightHelper.getEntityWorldCenterPos)
	elseif arg_7_1 == 3 then
		return arg_7_0:_flyEffectTarget(arg_7_2, arg_7_3, arg_7_4, false)
	else
		return arg_7_0:_flyEffectTarget(arg_7_2, arg_7_3, arg_7_4, FightHelper.getEntityHangPointPos, arg_7_0.params_arr[2])
	end
end

function var_0_0._flyEffectTarget(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	if arg_8_0.to_entity then
		local var_8_0, var_8_1, var_8_2 = (arg_8_4 or FightHelper.getEntityWorldBottomPos)(arg_8_0.to_entity, arg_8_5)
		local var_8_3 = var_8_0 + (arg_8_0.to_entity:isMySide() and -arg_8_1 or arg_8_1)
		local var_8_4 = var_8_1 + arg_8_2
		local var_8_5 = var_8_2 + arg_8_3

		return var_8_3, var_8_4, var_8_5
	end

	return arg_8_1, arg_8_2, arg_8_3
end

function var_0_0.onDestructor(arg_9_0)
	if not gohelper.isNil(arg_9_0.fly_obj) then
		if not arg_9_0.UnitMoverHandler_comp then
			MonoHelper.removeLuaComFromGo(arg_9_0.fly_obj, UnitMoverHandler)

			arg_9_0.UnitMoverHandler_comp = nil
		end

		if not arg_9_0.UnitMoverCurve_comp then
			MonoHelper.removeLuaComFromGo(arg_9_0.fly_obj, UnitMoverCurve)

			arg_9_0.UnitMoverCurve_comp = nil
		end
	end
end

return var_0_0
