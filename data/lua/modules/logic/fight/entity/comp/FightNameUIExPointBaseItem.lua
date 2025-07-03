module("modules.logic.fight.entity.comp.FightNameUIExPointBaseItem", package.seeall)

local var_0_0 = class("FightNameUIExPointBaseItem", UserDataDispose)

var_0_0.AnimName = {
	LockClose = "lock_close",
	Lost = "fightname_expoint_out",
	Add = "fightname_expoint_in",
	Loop = "fightname_expoint_loop",
	Explosion = "fightname_expoint_all",
	LockOpen = "lock_open",
	StoredAdd = "overflow_open",
	StoredLost = "overflow_close",
	Client = "fightname_expoint_flash",
	UsingSkillExplosion = "withholding_open"
}
var_0_0.AnimNameDuration = {
	[var_0_0.AnimName.Add] = 0.5
}
var_0_0.ExPointType = {
	Extra = 2,
	Normal = 1
}

function var_0_0.getType(arg_1_0)
	return var_0_0.ExPointType.Normal
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0:__onInit()

	arg_2_0.exPointGo = arg_2_1

	gohelper.setActive(arg_2_0.exPointGo, true)

	arg_2_0.goFull = gohelper.findChild(arg_2_0.exPointGo, "full")
	arg_2_0.imageFull = arg_2_0.goFull:GetComponent(gohelper.Type_Image)

	arg_2_0:_initEffectNode()

	arg_2_0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_2_0.exPointGo)
	arg_2_0.animator = arg_2_0.exPointGo:GetComponent(gohelper.Type_Animator)
	arg_2_0.state = FightEnum.ExPointState.Empty

	arg_2_0:initHandle()
end

function var_0_0._initEffectNode(arg_3_0)
	arg_3_0.goEffectExPoint = gohelper.findChild(arg_3_0.exPointGo, "effectexpoint")
	arg_3_0.goEffectIn = gohelper.findChild(arg_3_0.goEffectExPoint, "in")
	arg_3_0.goEffectLoop = gohelper.findChild(arg_3_0.goEffectExPoint, "loop")
	arg_3_0.goEffectOut = gohelper.findChild(arg_3_0.goEffectExPoint, "out")
	arg_3_0.goEffectAll = gohelper.findChild(arg_3_0.goEffectExPoint, "all")
	arg_3_0.goEffectWithHolding = gohelper.findChild(arg_3_0.goEffectExPoint, "withholding")
	arg_3_0.goEffectLock = gohelper.findChild(arg_3_0.goEffectExPoint, "lock")
end

function var_0_0.resetToEmpty(arg_4_0)
	arg_4_0.animatorPlayer:Stop()

	arg_4_0.animator.enabled = false
	arg_4_0.imageFull.color = Color.white

	gohelper.setActive(arg_4_0.goFull, false)
	gohelper.setActive(arg_4_0.goEffectIn, false)
	gohelper.setActive(arg_4_0.goEffectLoop, false)
	gohelper.setActive(arg_4_0.goEffectOut, false)
	gohelper.setActive(arg_4_0.goEffectAll, false)
	gohelper.setActive(arg_4_0.goEffectWithHolding, false)
	gohelper.setActive(arg_4_0.goEffectLock, false)
end

function var_0_0.setIndex(arg_5_0, arg_5_1)
	arg_5_0.index = arg_5_1
end

function var_0_0.setMgr(arg_6_0, arg_6_1)
	arg_6_0.mgr = arg_6_1
end

function var_0_0.playAnimToLastFrame(arg_7_0, arg_7_1)
	arg_7_0.animator.enabled = true

	arg_7_0.animatorPlayer:Stop()
	arg_7_0.animator:Play(arg_7_1, 0, 1)
end

function var_0_0.initHandle(arg_8_0)
	arg_8_0.directSetStateHandleDict = {
		[FightEnum.ExPointState.Empty] = arg_8_0.directSetEmptyState,
		[FightEnum.ExPointState.Server] = arg_8_0.directSetServerState,
		[FightEnum.ExPointState.Client] = arg_8_0.directSetClientState,
		[FightEnum.ExPointState.ServerFull] = arg_8_0.directSetServerFullState,
		[FightEnum.ExPointState.UsingUnique] = arg_8_0.directSetUsingUniqueState,
		[FightEnum.ExPointState.Lock] = arg_8_0.directSetLockState,
		[FightEnum.ExPointState.Stored] = arg_8_0.directSetStoredState
	}
	arg_8_0.switchToStateHandleDict = {
		[FightEnum.ExPointState.Empty] = arg_8_0.switchToEmptyState,
		[FightEnum.ExPointState.Server] = arg_8_0.switchToServerState,
		[FightEnum.ExPointState.Client] = arg_8_0.switchToClientState,
		[FightEnum.ExPointState.ServerFull] = arg_8_0.switchToServerFullState,
		[FightEnum.ExPointState.UsingUnique] = arg_8_0.switchToUsingUniqueState,
		[FightEnum.ExPointState.Lock] = arg_8_0.switchToLockState,
		[FightEnum.ExPointState.Stored] = arg_8_0.switchToStoredState
	}
end

function var_0_0.updateExPoint(arg_9_0)
	local var_9_0 = arg_9_0.mgr:getPointCurState(arg_9_0.index)

	arg_9_0:directSetState(var_9_0)
end

function var_0_0.switchToNextState(arg_10_0)
	if not arg_10_0.nextState then
		return
	end

	arg_10_0:stopSwitchToNextState()

	local var_10_0 = arg_10_0.nextState

	arg_10_0.nextState = nil

	arg_10_0:directSetState(var_10_0)
end

function var_0_0.setNextState(arg_11_0, arg_11_1)
	arg_11_0.nextState = arg_11_1

	arg_11_0:log("set next state : " .. arg_11_1)
end

function var_0_0.delaySwitchToNextState(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:stopSwitchToNextState()
	arg_12_0:setNextState(arg_12_1)
	TaskDispatcher.runDelay(arg_12_0.switchToNextState, arg_12_0, arg_12_2)
end

function var_0_0.stopSwitchToNextState(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0.switchToNextState, arg_13_0)
end

function var_0_0.log(arg_14_0, arg_14_1)
	return
end

function var_0_0.directSetState(arg_15_0, arg_15_1)
	arg_15_0:switchToNextState()
	arg_15_0:log("direct set state : " .. arg_15_1)

	local var_15_0 = arg_15_0.state

	arg_15_0.state = arg_15_1

	arg_15_0.directSetStateHandleDict[arg_15_0.state](arg_15_0, var_15_0)
end

function var_0_0.switchToState(arg_16_0, arg_16_1)
	arg_16_0:switchToNextState()
	arg_16_0:log("switch to state : " .. arg_16_1)

	local var_16_0 = arg_16_0.state

	arg_16_0.state = arg_16_1

	arg_16_0.switchToStateHandleDict[arg_16_0.state](arg_16_0, var_16_0)
end

function var_0_0.getCurState(arg_17_0)
	return arg_17_0.state
end

function var_0_0.playAnim(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	arg_18_0:setNextState(arg_18_4 or arg_18_0.mgr:getPointCurState(arg_18_0.index))

	arg_18_2 = arg_18_2 or arg_18_0.switchToNextState
	arg_18_3 = arg_18_3 or arg_18_0

	if arg_18_0.exPointGo.activeInHierarchy then
		arg_18_0.animator.enabled = true

		arg_18_0.animatorPlayer:Play(arg_18_1, arg_18_2, arg_18_3)
	else
		arg_18_0:switchToNextState()
	end
end

function var_0_0.playAnimNoCallback(arg_19_0, arg_19_1)
	if arg_19_0.exPointGo.activeInHierarchy then
		arg_19_0.animator.enabled = true

		arg_19_0.animatorPlayer:Play(arg_19_1)
	end
end

function var_0_0.playAddPointEffect(arg_20_0, arg_20_1, arg_20_2)
	arg_20_1 = arg_20_1 or FightEnum.ExPointState.Server

	gohelper.setActive(arg_20_0.goFull, true)

	if arg_20_2 then
		arg_20_0:setNextState(arg_20_1)
		arg_20_0:playAnimNoCallback(var_0_0.AnimName.Add)
		TaskDispatcher.runDelay(arg_20_0.switchToNextState, arg_20_0, arg_20_2)
	else
		arg_20_0:playAnim(var_0_0.AnimName.Add, arg_20_0.switchToNextState, arg_20_0, arg_20_1)
	end

	local var_20_0 = arg_20_0.mgr.entity

	if FightBuffHelper.checkPlayDuDuGuAddExPointEffect(var_20_0) then
		local var_20_1 = var_20_0:getMO().skin
		local var_20_2 = lua_fight_sp_effect_ddg.configDict[var_20_1]
		local var_20_3 = "v2a3_ddg/ddg_innate_03"
		local var_20_4 = ModuleEnum.SpineHangPointRoot

		if var_20_2 then
			var_20_3 = var_20_2.addExPointEffect
			var_20_4 = var_20_2.addExPointHang
		end

		var_20_0.uniqueEffect:addHangEffect(var_20_3, var_20_4, nil, 1):setLocalPos(0, 0, 0)
	end
end

function var_0_0.playRemoveStoredEffect(arg_21_0)
	gohelper.setActive(arg_21_0.goFull, true)
	arg_21_0:playAnim(var_0_0.AnimName.StoredLost)
end

function var_0_0.directSetEmptyState(arg_22_0, arg_22_1)
	arg_22_0:resetToEmpty()
end

function var_0_0.directSetServerState(arg_23_0, arg_23_1)
	arg_23_0:resetToEmpty()
	gohelper.setActive(arg_23_0.goFull, true)
end

function var_0_0.directSetClientState(arg_24_0, arg_24_1)
	arg_24_0:resetToEmpty()
	gohelper.setActive(arg_24_0.goFull, true)

	arg_24_0.animator.enabled = true

	arg_24_0.animatorPlayer:Play(var_0_0.AnimName.Client)
end

function var_0_0.directSetServerFullState(arg_25_0, arg_25_1)
	arg_25_0:resetToEmpty()
	gohelper.setActive(arg_25_0.goFull, true)
	arg_25_0:playAnimToLastFrame(var_0_0.AnimName.Loop)
end

function var_0_0.directSetUsingUniqueState(arg_26_0, arg_26_1)
	if arg_26_1 == arg_26_0.state then
		return
	end

	arg_26_0:resetToEmpty()

	arg_26_0.animator.enabled = true

	arg_26_0.animatorPlayer:Play(var_0_0.AnimName.UsingSkillExplosion)
end

function var_0_0.directSetLockState(arg_27_0, arg_27_1)
	arg_27_0:resetToEmpty()
	gohelper.setActive(arg_27_0.goFull, false)
	arg_27_0:playAnimToLastFrame(var_0_0.AnimName.LockOpen)
end

function var_0_0.directSetStoredState(arg_28_0, arg_28_1)
	arg_28_0:resetToEmpty()
	gohelper.setActive(arg_28_0.goFull, false)
	arg_28_0:playAnimToLastFrame(var_0_0.AnimName.StoredAdd)
end

function var_0_0.switchToEmptyState(arg_29_0, arg_29_1)
	arg_29_0:resetToEmpty()

	if arg_29_1 == FightEnum.ExPointState.Lock then
		arg_29_0.animator.enabled = true

		arg_29_0.animatorPlayer:Play(var_0_0.AnimName.LockClose)
	elseif arg_29_1 == FightEnum.ExPointState.Lock then
		arg_29_0.animator.enabled = true

		arg_29_0.animatorPlayer:Play(var_0_0.AnimName.Lost)
	end
end

function var_0_0.switchToServerState(arg_30_0, arg_30_1)
	arg_30_0:resetToEmpty()
	gohelper.setActive(arg_30_0.goFull, true)
end

function var_0_0.switchToClientState(arg_31_0, arg_31_1)
	arg_31_0:resetToEmpty()
	gohelper.setActive(arg_31_0.goFull, true)

	arg_31_0.animator.enabled = true

	arg_31_0.animatorPlayer:Play(var_0_0.AnimName.Client)
end

function var_0_0.switchToServerFullState(arg_32_0, arg_32_1)
	arg_32_0:resetToEmpty()
	gohelper.setActive(arg_32_0.goFull, true)

	arg_32_0.animator.enabled = true

	arg_32_0.animatorPlayer:Play(var_0_0.AnimName.Loop)
end

function var_0_0.switchToUsingUniqueState(arg_33_0, arg_33_1)
	if arg_33_1 == arg_33_0.state then
		return
	end

	arg_33_0:resetToEmpty()

	arg_33_0.animator.enabled = true

	arg_33_0.animatorPlayer:Play(var_0_0.AnimName.UsingSkillExplosion)
end

function var_0_0.switchToLockState(arg_34_0, arg_34_1)
	arg_34_0:resetToEmpty()
	gohelper.setActive(arg_34_0.goFull, false)

	arg_34_0.animator.enabled = true

	arg_34_0.animatorPlayer:Play(var_0_0.AnimName.LockOpen)
end

function var_0_0.switchToStoredState(arg_35_0, arg_35_1)
	if arg_35_1 == arg_35_0.state then
		return
	end

	arg_35_0:resetToEmpty()
	gohelper.setActive(arg_35_0.goFull, false)

	arg_35_0.animator.enabled = true

	arg_35_0.animatorPlayer:Play(var_0_0.AnimName.StoredAdd)
end

function var_0_0.recycle(arg_36_0, arg_36_1)
	gohelper.addChild(arg_36_1, arg_36_0.exPointGo)
end

function var_0_0.getPointGo(arg_37_0)
	return arg_37_0.exPointGo
end

function var_0_0.destroy(arg_38_0)
	arg_38_0:stopSwitchToNextState()
	arg_38_0.animatorPlayer:Stop()
	gohelper.destroy(arg_38_0.exPointGo)
	arg_38_0:__onDispose()
end

return var_0_0
