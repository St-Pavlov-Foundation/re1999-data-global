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

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.exPointGo = arg_1_1

	gohelper.setActive(arg_1_0.exPointGo, true)

	arg_1_0.goFull = gohelper.findChild(arg_1_0.exPointGo, "full")
	arg_1_0.imageFull = arg_1_0.goFull:GetComponent(gohelper.Type_Image)

	arg_1_0:_initEffectNode()

	arg_1_0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_1_0.exPointGo)
	arg_1_0.animator = arg_1_0.exPointGo:GetComponent(gohelper.Type_Animator)
	arg_1_0.state = FightEnum.ExPointState.Empty

	arg_1_0:initHandle()
end

function var_0_0._initEffectNode(arg_2_0)
	arg_2_0.goEffectExPoint = gohelper.findChild(arg_2_0.exPointGo, "effectexpoint")
	arg_2_0.goEffectIn = gohelper.findChild(arg_2_0.goEffectExPoint, "in")
	arg_2_0.goEffectLoop = gohelper.findChild(arg_2_0.goEffectExPoint, "loop")
	arg_2_0.goEffectOut = gohelper.findChild(arg_2_0.goEffectExPoint, "out")
	arg_2_0.goEffectAll = gohelper.findChild(arg_2_0.goEffectExPoint, "all")
	arg_2_0.goEffectWithHolding = gohelper.findChild(arg_2_0.goEffectExPoint, "withholding")
	arg_2_0.goEffectLock = gohelper.findChild(arg_2_0.goEffectExPoint, "lock")
end

function var_0_0.resetToEmpty(arg_3_0)
	arg_3_0.animatorPlayer:Stop()

	arg_3_0.animator.enabled = false
	arg_3_0.imageFull.color = Color.white

	gohelper.setActive(arg_3_0.goFull, false)
	gohelper.setActive(arg_3_0.goEffectIn, false)
	gohelper.setActive(arg_3_0.goEffectLoop, false)
	gohelper.setActive(arg_3_0.goEffectOut, false)
	gohelper.setActive(arg_3_0.goEffectAll, false)
	gohelper.setActive(arg_3_0.goEffectWithHolding, false)
	gohelper.setActive(arg_3_0.goEffectLock, false)
end

function var_0_0.setIndex(arg_4_0, arg_4_1)
	arg_4_0.index = arg_4_1
end

function var_0_0.setMgr(arg_5_0, arg_5_1)
	arg_5_0.mgr = arg_5_1
end

function var_0_0.playAnimToLastFrame(arg_6_0, arg_6_1)
	arg_6_0.animator.enabled = true

	arg_6_0.animatorPlayer:Stop()
	arg_6_0.animator:Play(arg_6_1, 0, 1)
end

function var_0_0.initHandle(arg_7_0)
	arg_7_0.directSetStateHandleDict = {
		[FightEnum.ExPointState.Empty] = arg_7_0.directSetEmptyState,
		[FightEnum.ExPointState.Server] = arg_7_0.directSetServerState,
		[FightEnum.ExPointState.Client] = arg_7_0.directSetClientState,
		[FightEnum.ExPointState.ServerFull] = arg_7_0.directSetServerFullState,
		[FightEnum.ExPointState.UsingUnique] = arg_7_0.directSetUsingUniqueState,
		[FightEnum.ExPointState.Lock] = arg_7_0.directSetLockState,
		[FightEnum.ExPointState.Stored] = arg_7_0.directSetStoredState
	}
	arg_7_0.switchToStateHandleDict = {
		[FightEnum.ExPointState.Empty] = arg_7_0.switchToEmptyState,
		[FightEnum.ExPointState.Server] = arg_7_0.switchToServerState,
		[FightEnum.ExPointState.Client] = arg_7_0.switchToClientState,
		[FightEnum.ExPointState.ServerFull] = arg_7_0.switchToServerFullState,
		[FightEnum.ExPointState.UsingUnique] = arg_7_0.switchToUsingUniqueState,
		[FightEnum.ExPointState.Lock] = arg_7_0.switchToLockState,
		[FightEnum.ExPointState.Stored] = arg_7_0.switchToStoredState
	}
end

function var_0_0.updateExPoint(arg_8_0)
	local var_8_0 = arg_8_0.mgr:getPointCurState(arg_8_0.index)

	arg_8_0:directSetState(var_8_0)
end

function var_0_0.switchToNextState(arg_9_0)
	if not arg_9_0.nextState then
		return
	end

	arg_9_0:stopSwitchToNextState()

	local var_9_0 = arg_9_0.nextState

	arg_9_0.nextState = nil

	arg_9_0:directSetState(var_9_0)
end

function var_0_0.setNextState(arg_10_0, arg_10_1)
	arg_10_0.nextState = arg_10_1

	arg_10_0:log("set next state : " .. arg_10_1)
end

function var_0_0.delaySwitchToNextState(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0:stopSwitchToNextState()
	arg_11_0:setNextState(arg_11_1)
	TaskDispatcher.runDelay(arg_11_0.switchToNextState, arg_11_0, arg_11_2)
end

function var_0_0.stopSwitchToNextState(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0.switchToNextState, arg_12_0)
end

function var_0_0.log(arg_13_0, arg_13_1)
	return
end

function var_0_0.directSetState(arg_14_0, arg_14_1)
	arg_14_0:switchToNextState()
	arg_14_0:log("direct set state : " .. arg_14_1)

	local var_14_0 = arg_14_0.state

	arg_14_0.state = arg_14_1

	arg_14_0.directSetStateHandleDict[arg_14_0.state](arg_14_0, var_14_0)
end

function var_0_0.switchToState(arg_15_0, arg_15_1)
	arg_15_0:switchToNextState()
	arg_15_0:log("switch to state : " .. arg_15_1)

	local var_15_0 = arg_15_0.state

	arg_15_0.state = arg_15_1

	arg_15_0.switchToStateHandleDict[arg_15_0.state](arg_15_0, var_15_0)
end

function var_0_0.getCurState(arg_16_0)
	return arg_16_0.state
end

function var_0_0.playAnim(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	arg_17_0:setNextState(arg_17_4 or arg_17_0.mgr:getPointCurState(arg_17_0.index))

	arg_17_2 = arg_17_2 or arg_17_0.switchToNextState
	arg_17_3 = arg_17_3 or arg_17_0

	if arg_17_0.exPointGo.activeInHierarchy then
		arg_17_0.animator.enabled = true

		arg_17_0.animatorPlayer:Play(arg_17_1, arg_17_2, arg_17_3)
	else
		arg_17_0:switchToNextState()
	end
end

function var_0_0.playAnimNoCallback(arg_18_0, arg_18_1)
	if arg_18_0.exPointGo.activeInHierarchy then
		arg_18_0.animator.enabled = true

		arg_18_0.animatorPlayer:Play(arg_18_1)
	end
end

function var_0_0.playAddPointEffect(arg_19_0, arg_19_1, arg_19_2)
	arg_19_1 = arg_19_1 or FightEnum.ExPointState.Server

	gohelper.setActive(arg_19_0.goFull, true)

	if arg_19_2 then
		arg_19_0:setNextState(arg_19_1)
		arg_19_0:playAnimNoCallback(var_0_0.AnimName.Add)
		TaskDispatcher.runDelay(arg_19_0.switchToNextState, arg_19_0, arg_19_2)
	else
		arg_19_0:playAnim(var_0_0.AnimName.Add, arg_19_0.switchToNextState, arg_19_0, arg_19_1)
	end

	local var_19_0 = arg_19_0.mgr.entity

	if FightBuffHelper.checkPlayDuDuGuAddExPointEffect(var_19_0) then
		local var_19_1 = var_19_0:getMO().skin
		local var_19_2 = lua_fight_sp_effect_ddg.configDict[var_19_1]
		local var_19_3 = "v2a3_ddg/ddg_innate_03"
		local var_19_4 = ModuleEnum.SpineHangPointRoot

		if var_19_2 then
			var_19_3 = var_19_2.addExPointEffect
			var_19_4 = var_19_2.addExPointHang
		end

		var_19_0.uniqueEffect:addHangEffect(var_19_3, var_19_4, nil, 1):setLocalPos(0, 0, 0)
	end
end

function var_0_0.playRemoveStoredEffect(arg_20_0)
	gohelper.setActive(arg_20_0.goFull, true)
	arg_20_0:playAnim(var_0_0.AnimName.StoredLost)
end

function var_0_0.directSetEmptyState(arg_21_0, arg_21_1)
	arg_21_0:resetToEmpty()
end

function var_0_0.directSetServerState(arg_22_0, arg_22_1)
	arg_22_0:resetToEmpty()
	gohelper.setActive(arg_22_0.goFull, true)
end

function var_0_0.directSetClientState(arg_23_0, arg_23_1)
	arg_23_0:resetToEmpty()
	gohelper.setActive(arg_23_0.goFull, true)

	arg_23_0.animator.enabled = true

	arg_23_0.animatorPlayer:Play(var_0_0.AnimName.Client)
end

function var_0_0.directSetServerFullState(arg_24_0, arg_24_1)
	arg_24_0:resetToEmpty()
	gohelper.setActive(arg_24_0.goFull, true)
	arg_24_0:playAnimToLastFrame(var_0_0.AnimName.Loop)
end

function var_0_0.directSetUsingUniqueState(arg_25_0, arg_25_1)
	if arg_25_1 == arg_25_0.state then
		return
	end

	arg_25_0:resetToEmpty()

	arg_25_0.animator.enabled = true

	arg_25_0.animatorPlayer:Play(var_0_0.AnimName.UsingSkillExplosion)
end

function var_0_0.directSetLockState(arg_26_0, arg_26_1)
	arg_26_0:resetToEmpty()
	gohelper.setActive(arg_26_0.goFull, false)
	arg_26_0:playAnimToLastFrame(var_0_0.AnimName.LockOpen)
end

function var_0_0.directSetStoredState(arg_27_0, arg_27_1)
	arg_27_0:resetToEmpty()
	gohelper.setActive(arg_27_0.goFull, false)
	arg_27_0:playAnimToLastFrame(var_0_0.AnimName.StoredAdd)
end

function var_0_0.switchToEmptyState(arg_28_0, arg_28_1)
	arg_28_0:resetToEmpty()

	if arg_28_1 == FightEnum.ExPointState.Lock then
		arg_28_0.animator.enabled = true

		arg_28_0.animatorPlayer:Play(var_0_0.AnimName.LockClose)
	elseif arg_28_1 == FightEnum.ExPointState.Lock then
		arg_28_0.animator.enabled = true

		arg_28_0.animatorPlayer:Play(var_0_0.AnimName.Lost)
	end
end

function var_0_0.switchToServerState(arg_29_0, arg_29_1)
	arg_29_0:resetToEmpty()
	gohelper.setActive(arg_29_0.goFull, true)
end

function var_0_0.switchToClientState(arg_30_0, arg_30_1)
	arg_30_0:resetToEmpty()
	gohelper.setActive(arg_30_0.goFull, true)

	arg_30_0.animator.enabled = true

	arg_30_0.animatorPlayer:Play(var_0_0.AnimName.Client)
end

function var_0_0.switchToServerFullState(arg_31_0, arg_31_1)
	arg_31_0:resetToEmpty()
	gohelper.setActive(arg_31_0.goFull, true)

	arg_31_0.animator.enabled = true

	arg_31_0.animatorPlayer:Play(var_0_0.AnimName.Loop)
end

function var_0_0.switchToUsingUniqueState(arg_32_0, arg_32_1)
	if arg_32_1 == arg_32_0.state then
		return
	end

	arg_32_0:resetToEmpty()

	arg_32_0.animator.enabled = true

	arg_32_0.animatorPlayer:Play(var_0_0.AnimName.UsingSkillExplosion)
end

function var_0_0.switchToLockState(arg_33_0, arg_33_1)
	arg_33_0:resetToEmpty()
	gohelper.setActive(arg_33_0.goFull, false)

	arg_33_0.animator.enabled = true

	arg_33_0.animatorPlayer:Play(var_0_0.AnimName.LockOpen)
end

function var_0_0.switchToStoredState(arg_34_0, arg_34_1)
	if arg_34_1 == arg_34_0.state then
		return
	end

	arg_34_0:resetToEmpty()
	gohelper.setActive(arg_34_0.goFull, false)

	arg_34_0.animator.enabled = true

	arg_34_0.animatorPlayer:Play(var_0_0.AnimName.StoredAdd)
end

function var_0_0.destroy(arg_35_0)
	arg_35_0:stopSwitchToNextState()
	arg_35_0.animatorPlayer:Stop()
	gohelper.destroy(arg_35_0.exPointGo)
	arg_35_0:__onDispose()
end

return var_0_0
