module("modules.logic.versionactivity3_0.maLiAnNaAct201.model.mo.MaLiAnNaSoldierEntityMo", package.seeall)

local var_0_0 = class("MaLiAnNaSoldierEntityMo")

function var_0_0.create()
	return (var_0_0.New())
end

function var_0_0.ctor(arg_2_0)
	arg_2_0._id = 0
	arg_2_0._soliderId = -1
	arg_2_0._localPosX = 0
	arg_2_0._localPosY = 0
	arg_2_0._state = Activity201MaLiAnNaEnum.SoliderState.InSlot
	arg_2_0._config = nil
	arg_2_0._targetSlotId = nil
	arg_2_0._moveSlotPathPoint = {}
	arg_2_0._hp = 0
	arg_2_0._stateMachine = StateMachine.Create()

	arg_2_0._stateMachine:addState(Activity201MaLiAnNaEnum.SoliderState.Moving, arg_2_0._moveEnter, arg_2_0._moveUpdate, nil, arg_2_0)
	arg_2_0._stateMachine:addState(Activity201MaLiAnNaEnum.SoliderState.InSlot, arg_2_0._inSlotEnter, arg_2_0._inSlotUpdate, nil, arg_2_0)
	arg_2_0._stateMachine:addState(Activity201MaLiAnNaEnum.SoliderState.Attack, arg_2_0._attackEnter, arg_2_0._attackUpdate, nil, arg_2_0)
	arg_2_0._stateMachine:addState(Activity201MaLiAnNaEnum.SoliderState.Dead, arg_2_0._deadEnter, nil, nil, arg_2_0)
	arg_2_0._stateMachine:addState(Activity201MaLiAnNaEnum.SoliderState.AttackSlot, arg_2_0._attackSlotEnter, arg_2_0._attackSlotUpdate, nil, arg_2_0)
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._soliderId = arg_3_2
	arg_3_0._id = arg_3_1
	arg_3_0._config = Activity201MaLiAnNaConfig.instance:getSoldierById(arg_3_2)
	arg_3_0._hp = arg_3_0._config.hP
	arg_3_0._speed = arg_3_0._config.speed
	arg_3_0._moveDirX = 0
	arg_3_0._moveDirY = 0
	arg_3_0._camp = Activity201MaLiAnNaEnum.CampType.Player
	arg_3_0._dispatchGroupId = nil
	arg_3_0._attackTime = nil
	arg_3_0._soliderSkill = {}

	arg_3_0._stateMachine:setInitialState(Activity201MaLiAnNaEnum.SoliderState.InSlot)
	arg_3_0:initSkill()
end

function var_0_0.getId(arg_4_0)
	return arg_4_0._id
end

function var_0_0.getConfigId(arg_5_0)
	return arg_5_0._soliderId
end

function var_0_0.getConfig(arg_6_0)
	return arg_6_0._config
end

function var_0_0.getTargetSlotId(arg_7_0)
	return arg_7_0._targetSlotId
end

function var_0_0.setCamp(arg_8_0, arg_8_1)
	arg_8_0._camp = arg_8_1
end

function var_0_0.getCamp(arg_9_0)
	return arg_9_0._camp
end

function var_0_0.getHp(arg_10_0)
	return arg_10_0._hp
end

function var_0_0.getMoveDir(arg_11_0)
	return arg_11_0._moveDirX, arg_11_0._moveDirY
end

function var_0_0.isHero(arg_12_0)
	return arg_12_0._config.type == Activity201MaLiAnNaEnum.SoldierType.hero
end

function var_0_0.getLocalPos(arg_13_0)
	return arg_13_0._localPosX, arg_13_0._localPosY
end

function var_0_0.setLocalPos(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0._localPosX, arg_14_0._localPosY = arg_14_1, arg_14_2
end

function var_0_0.setDispatchGroupId(arg_15_0, arg_15_1)
	arg_15_0._dispatchGroupId = arg_15_1
end

function var_0_0.getDispatchGroupId(arg_16_0)
	return arg_16_0._dispatchGroupId
end

function var_0_0.getMoveSlotPathPoint(arg_17_0)
	return arg_17_0._moveSlotPathPoint
end

function var_0_0.getCurMoveIndex(arg_18_0)
	return arg_18_0._targetIndex
end

function var_0_0.getDisPatchList(arg_19_0)
	return
end

function var_0_0.setMovePointPath(arg_20_0, arg_20_1)
	if arg_20_1 == nil then
		return
	end

	if arg_20_0._moveSlotPathPoint ~= nil then
		tabletool.clear(arg_20_0._moveSlotPathPoint)
		tabletool.addValues(arg_20_0._moveSlotPathPoint, arg_20_1)
	end

	arg_20_0._targetSlotId = arg_20_1[#arg_20_1]

	local var_20_0 = arg_20_1[1]
	local var_20_1 = Activity201MaLiAnNaGameModel.instance:getSlotById(var_20_0)

	if var_20_1 then
		local var_20_2, var_20_3 = var_20_1:getBasePosXY()

		arg_20_0:setLocalPos(var_20_2, var_20_3)
	end

	arg_20_0:_setDisPatchDir()
end

function var_0_0._setDisPatchDir(arg_21_0)
	arg_21_0._targetIndex = 2

	arg_21_0:updateDir(arg_21_0._targetIndex)
end

function var_0_0.changeState(arg_22_0, arg_22_1)
	arg_22_0._state = arg_22_1

	arg_22_0._stateMachine:transitionTo(arg_22_1)
end

function var_0_0.getCurState(arg_23_0)
	return arg_23_0._state
end

function var_0_0.isDead(arg_24_0)
	return arg_24_0._state == Activity201MaLiAnNaEnum.SoliderState.Dead or arg_24_0._hp <= 0
end

function var_0_0.update(arg_25_0, arg_25_1)
	if arg_25_0._isReset then
		return
	end

	if arg_25_0._stateMachine then
		arg_25_0._stateMachine:update(arg_25_1)
	end
end

function var_0_0.updateHp(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0._hp = math.max(0, arg_26_0._hp + arg_26_1)

	if arg_26_0:isHero() and arg_26_1 ~= 0 then
		Activity201MaLiAnNaGameController.instance:dispatchEvent(Activity201MaLiAnNaEvent.SoliderHpChange, arg_26_0:getId(), arg_26_1)
	end

	if arg_26_0._hp <= 0 and arg_26_2 then
		arg_26_0:changeState(Activity201MaLiAnNaEnum.SoliderState.Dead)
	end
end

function var_0_0.getMovePointIndex(arg_27_0)
	if arg_27_0._moveSlotPathPoint then
		local var_27_0 = #arg_27_0._moveSlotPathPoint
		local var_27_1 = arg_27_0._moveSlotPathPoint[arg_27_0._targetIndex]

		if var_27_1 then
			local var_27_2 = Activity201MaLiAnNaGameModel.instance:getSlotById(var_27_1)
			local var_27_3, var_27_4 = var_27_2:getBasePosXY()
			local var_27_5, var_27_6, var_27_7, var_27_8 = var_27_2:getSlotConstValue()
			local var_27_9

			if MathUtil.isPointInCircleRange(arg_27_0._localPosX, arg_27_0._localPosY, var_27_6, var_27_3, var_27_4) then
				var_27_9 = arg_27_0._targetIndex
			end

			if MathUtil.hasPassedPoint(arg_27_0._localPosX, arg_27_0._localPosY, var_27_3, var_27_4, arg_27_0._moveDirX, arg_27_0._moveDirY) then
				var_27_9 = arg_27_0._targetIndex

				arg_27_0:setLocalPos(var_27_3, var_27_4)
				arg_27_0:updateDir(var_27_9 + 1)
			end

			return var_27_9
		end
	end

	return nil
end

function var_0_0.updateDir(arg_28_0, arg_28_1)
	if arg_28_1 > #arg_28_0._moveSlotPathPoint then
		return
	end

	local var_28_0, var_28_1 = arg_28_0:getLocalPos()

	if arg_28_1 > 1 then
		local var_28_2 = arg_28_0._moveSlotPathPoint[arg_28_1 - 1]

		var_28_0, var_28_1 = Activity201MaLiAnNaGameModel.instance:getSlotById(var_28_2):getBasePosXY()
	end

	if arg_28_0._moveSlotPathPoint and arg_28_0._moveSlotPathPoint[arg_28_1] then
		local var_28_3, var_28_4 = Activity201MaLiAnNaGameModel.instance:getSlotById(arg_28_0._moveSlotPathPoint[arg_28_1]):getBasePosXY()

		arg_28_0._moveDirX, arg_28_0._moveDirY = MathUtil.vec2_normalize(var_28_3 - var_28_0, var_28_4 - var_28_1)
	end

	arg_28_0._targetIndex = arg_28_1
end

function var_0_0._isNeedEnterSlot(arg_29_0)
	local var_29_0 = arg_29_0:getMovePointIndex()

	if var_29_0 then
		local var_29_1 = #arg_29_0._moveSlotPathPoint
		local var_29_2 = arg_29_0._moveSlotPathPoint[var_29_0]
		local var_29_3 = Activity201MaLiAnNaGameModel.instance:getSlotById(var_29_2)
		local var_29_4 = false

		if var_29_2 == arg_29_0._targetSlotId or var_29_3 and var_29_3:getSlotCamp() ~= arg_29_0._camp then
			var_29_4 = true
		end

		return var_29_4, var_29_2, var_29_1 ~= var_29_0
	end

	return false, nil, false
end

function var_0_0._moveEnter(arg_30_0)
	arg_30_0:changeRecordSoliderState(false)
end

function var_0_0.isMoveEnd(arg_31_0)
	local var_31_0 = #arg_31_0._moveSlotPathPoint

	return arg_31_0._targetIndex == var_31_0
end

function var_0_0._moveUpdate(arg_32_0, arg_32_1)
	arg_32_0:skillUpdate(arg_32_1)

	local var_32_0, var_32_1, var_32_2 = arg_32_0:_isNeedEnterSlot()

	if arg_32_0:isHero() and var_32_2 then
		local var_32_3 = Activity201MaLiAnNaGameModel.instance:getSlotById(var_32_1)

		if var_32_3 and var_32_3:getSlotCamp() ~= arg_32_0._camp then
			var_32_2 = false
		end
	end

	MaliAnNaSoliderEntityMgr.instance:setHideEntity(arg_32_0, not var_32_2)

	if var_32_0 then
		Activity201MaLiAnNaGameController.instance:soliderEnterSlot(arg_32_0, var_32_1)

		return
	end

	local var_32_4 = arg_32_0._speed * arg_32_1

	arg_32_0:setLocalPos(arg_32_0._localPosX + arg_32_0._moveDirX * var_32_4, arg_32_0._localPosY + arg_32_0._moveDirY * var_32_4)
end

function var_0_0._inSlotEnter(arg_33_0)
	if arg_33_0._targetSlotId ~= nil then
		-- block empty
	end

	Activity201MaLiAnNaGameModel.instance:removeDisPatchSolider(arg_33_0:getId())
	MaliAnNaSoliderEntityMgr.instance:recycleEntity(arg_33_0)
end

function var_0_0._inSlotUpdate(arg_34_0, arg_34_1)
	arg_34_0:skillUpdate(arg_34_1)
end

function var_0_0._attackEnter(arg_35_0)
	arg_35_0._attackTime = Activity201MaLiAnNaEnum.attackTime
end

function var_0_0._attackUpdate(arg_36_0, arg_36_1)
	arg_36_0:skillUpdate(arg_36_1)

	if arg_36_0._attackTime == nil then
		return
	end

	arg_36_0._attackTime = arg_36_0._attackTime - arg_36_1

	if arg_36_0._attackTime <= 0 then
		arg_36_0:updateHp(0, true)

		if arg_36_0._hp and arg_36_0._hp > 0 then
			arg_36_0:changeState(Activity201MaLiAnNaEnum.SoliderState.Moving)
		end

		AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.stop_ui_lushang_warring_loop)

		arg_36_0._attackTime = nil
	end
end

function var_0_0._deadEnter(arg_37_0)
	Activity201MaLiAnNaGameController.instance:soliderDead(arg_37_0)
end

function var_0_0._attackSlotEnter(arg_38_0)
	arg_38_0._attackSlotTime = Activity201MaLiAnNaEnum.attackSlotTime
end

function var_0_0._attackSlotUpdate(arg_39_0, arg_39_1)
	arg_39_0:skillUpdate(arg_39_1)

	if arg_39_0._attackSlotTime == nil then
		return
	end

	arg_39_0._attackSlotTime = arg_39_0._attackSlotTime - arg_39_1

	if arg_39_0._attackSlotTime <= 0 then
		arg_39_0:updateHp(0, true)

		if arg_39_0._hp and arg_39_0._hp > 0 then
			arg_39_0:changeState(Activity201MaLiAnNaEnum.SoliderState.Moving)
		end

		arg_39_0._attackSlotTime = nil
	end
end

function var_0_0.initSkill(arg_40_0)
	if arg_40_0._soliderSkill == nil then
		arg_40_0._soliderSkill = {}
	end

	local var_40_0 = arg_40_0._config.passiveSkill

	if var_40_0 ~= 0 then
		local var_40_1 = MaLiAnNaSkillUtils.instance.createSkill(var_40_0)

		var_40_1:setUseSoliderId(arg_40_0:getId())
		table.insert(arg_40_0._soliderSkill, var_40_1)
	end
end

function var_0_0.skillUpdate(arg_41_0, arg_41_1)
	if arg_41_0._soliderSkill == nil then
		return
	end

	for iter_41_0 = 1, #arg_41_0._soliderSkill do
		local var_41_0 = arg_41_0._soliderSkill[iter_41_0]

		if var_41_0 then
			var_41_0:update(arg_41_1)
		end
	end
end

function var_0_0.getSkillSpeedUp(arg_42_0)
	if arg_42_0._soliderSkill == nil or #arg_42_0._soliderSkill <= 0 then
		return 0
	end

	for iter_42_0 = 1, #arg_42_0._soliderSkill do
		local var_42_0 = arg_42_0._soliderSkill[iter_42_0]

		if var_42_0:getSkillActionType() == Activity201MaLiAnNaEnum.SkillAction.upSlotGenerateSoliderSpeed then
			local var_42_1 = var_42_0:getEffect()

			return tonumber(var_42_1[2])
		end
	end

	return 0
end

function var_0_0.getEnterSlotSkillValue(arg_43_0)
	if arg_43_0._soliderSkill == nil or #arg_43_0._soliderSkill <= 0 then
		return nil, nil
	end

	for iter_43_0 = 1, #arg_43_0._soliderSkill do
		local var_43_0 = arg_43_0._soliderSkill[iter_43_0]

		if var_43_0:getSkillActionType() == Activity201MaLiAnNaEnum.SkillAction.enterSlotAddSolider then
			local var_43_1 = var_43_0:getEffect()

			return arg_43_0._camp, tonumber(var_43_1[2])
		end
	end

	return nil, nil
end

function var_0_0.setCurViewPos(arg_44_0, arg_44_1, arg_44_2)
	arg_44_0._viewPosX = arg_44_1
	arg_44_0._viewPosY = arg_44_2
end

function var_0_0.getCurViewPos(arg_45_0)
	return arg_45_0._viewPosX, arg_45_0._viewPosY
end

function var_0_0.getBulletPos(arg_46_0)
	if arg_46_0._state == Activity201MaLiAnNaEnum.SoliderState.InSlot then
		return arg_46_0:getCurViewPos()
	end

	local var_46_0, var_46_1 = arg_46_0:getLocalPos()

	return var_46_0, var_46_1 + 40
end

function var_0_0.setRecordSolider(arg_47_0, arg_47_1)
	if arg_47_0._exSoliderMoList == nil then
		arg_47_0._exSoliderMoList = {}
	end

	table.insert(arg_47_0._exSoliderMoList, arg_47_1)
end

function var_0_0.changeRecordSoliderState(arg_48_0, arg_48_1)
	if arg_48_0._exSoliderMoList == nil then
		return
	end

	local var_48_0 = arg_48_1 and Activity201MaLiAnNaEnum.SoliderState.StopMove or Activity201MaLiAnNaEnum.SoliderState.Moving

	for iter_48_0 = 1, #arg_48_0._exSoliderMoList do
		local var_48_1 = arg_48_0._exSoliderMoList[iter_48_0]

		if not var_48_1:isDead() then
			var_48_1:changeState(var_48_0)
		end
	end

	if not arg_48_1 then
		tabletool.clear(arg_48_0._exSoliderMoList)
	end
end

function var_0_0.reset(arg_49_0)
	arg_49_0._soliderId = nil
	arg_49_0._id = nil
	arg_49_0._config = nil
	arg_49_0._hp = nil
	arg_49_0._speed = nil
	arg_49_0._moveDirX = nil
	arg_49_0._moveDirY = nil
	arg_49_0._camp = nil
	arg_49_0._dispatchGroupId = nil
	arg_49_0._attackTime = nil
	arg_49_0._soliderSkill = nil
end

function var_0_0.clear(arg_50_0)
	arg_50_0:reset()

	if arg_50_0._stateMachine ~= nil then
		arg_50_0._stateMachine:onDestroy()

		arg_50_0._stateMachine = nil
	end
end

function var_0_0.getSmallIcon(arg_51_0)
	local var_51_0 = ""
	local var_51_1 = arg_51_0._config.icon

	if arg_51_0:isHero() and var_51_1 == 312601 then
		local var_51_2 = ResUrl.getHeadIconSmall(var_51_1)
	end

	return (ResUrl.monsterHeadIcon(var_51_1))
end

function var_0_0.dump(arg_52_0)
	local var_52_0 = (((("" .. "士兵ID:" .. tostring(arg_52_0._id) .. "\n") .. "士兵配置ID:" .. tostring(arg_52_0._soliderId) .. "\n") .. "士兵位置X:" .. tostring(arg_52_0._localPosX) .. "\n") .. "士兵位置Y:" .. tostring(arg_52_0._localPosY) .. "\n") .. "士兵状态:" .. tostring(arg_52_0._state) .. "\n"

	logNormal("MaLiAnNaSoldierEntityMo->:", var_52_0)
end

return var_0_0
