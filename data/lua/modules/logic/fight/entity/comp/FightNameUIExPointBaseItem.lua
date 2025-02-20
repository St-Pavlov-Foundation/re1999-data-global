module("modules.logic.fight.entity.comp.FightNameUIExPointBaseItem", package.seeall)

slot0 = class("FightNameUIExPointBaseItem", UserDataDispose)
slot0.AnimName = {
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
slot0.AnimNameDuration = {
	[slot0.AnimName.Add] = 0.5
}

function slot0.init(slot0, slot1)
	slot0:__onInit()

	slot0.exPointGo = slot1

	gohelper.setActive(slot0.exPointGo, true)

	slot0.goFull = gohelper.findChild(slot0.exPointGo, "full")
	slot0.imageFull = slot0.goFull:GetComponent(gohelper.Type_Image)

	slot0:_initEffectNode()

	slot0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0.exPointGo)
	slot0.animator = slot0.exPointGo:GetComponent(gohelper.Type_Animator)
	slot0.state = FightEnum.ExPointState.Empty

	slot0:initHandle()
end

function slot0._initEffectNode(slot0)
	slot0.goEffectExPoint = gohelper.findChild(slot0.exPointGo, "effectexpoint")
	slot0.goEffectIn = gohelper.findChild(slot0.goEffectExPoint, "in")
	slot0.goEffectLoop = gohelper.findChild(slot0.goEffectExPoint, "loop")
	slot0.goEffectOut = gohelper.findChild(slot0.goEffectExPoint, "out")
	slot0.goEffectAll = gohelper.findChild(slot0.goEffectExPoint, "all")
	slot0.goEffectWithHolding = gohelper.findChild(slot0.goEffectExPoint, "withholding")
	slot0.goEffectLock = gohelper.findChild(slot0.goEffectExPoint, "lock")
end

function slot0.resetToEmpty(slot0)
	slot0.animatorPlayer:Stop()

	slot0.animator.enabled = false
	slot0.imageFull.color = Color.white

	gohelper.setActive(slot0.goFull, false)
	gohelper.setActive(slot0.goEffectIn, false)
	gohelper.setActive(slot0.goEffectLoop, false)
	gohelper.setActive(slot0.goEffectOut, false)
	gohelper.setActive(slot0.goEffectAll, false)
	gohelper.setActive(slot0.goEffectWithHolding, false)
	gohelper.setActive(slot0.goEffectLock, false)
end

function slot0.setIndex(slot0, slot1)
	slot0.index = slot1
end

function slot0.setMgr(slot0, slot1)
	slot0.mgr = slot1
end

function slot0.playAnimToLastFrame(slot0, slot1)
	slot0.animator.enabled = true

	slot0.animatorPlayer:Stop()
	slot0.animator:Play(slot1, 0, 1)
end

function slot0.initHandle(slot0)
	slot0.directSetStateHandleDict = {
		[FightEnum.ExPointState.Empty] = slot0.directSetEmptyState,
		[FightEnum.ExPointState.Server] = slot0.directSetServerState,
		[FightEnum.ExPointState.Client] = slot0.directSetClientState,
		[FightEnum.ExPointState.ServerFull] = slot0.directSetServerFullState,
		[FightEnum.ExPointState.UsingUnique] = slot0.directSetUsingUniqueState,
		[FightEnum.ExPointState.Lock] = slot0.directSetLockState,
		[FightEnum.ExPointState.Stored] = slot0.directSetStoredState
	}
	slot0.switchToStateHandleDict = {
		[FightEnum.ExPointState.Empty] = slot0.switchToEmptyState,
		[FightEnum.ExPointState.Server] = slot0.switchToServerState,
		[FightEnum.ExPointState.Client] = slot0.switchToClientState,
		[FightEnum.ExPointState.ServerFull] = slot0.switchToServerFullState,
		[FightEnum.ExPointState.UsingUnique] = slot0.switchToUsingUniqueState,
		[FightEnum.ExPointState.Lock] = slot0.switchToLockState,
		[FightEnum.ExPointState.Stored] = slot0.switchToStoredState
	}
end

function slot0.updateExPoint(slot0)
	slot0:directSetState(slot0.mgr:getPointCurState(slot0.index))
end

function slot0.switchToNextState(slot0)
	if not slot0.nextState then
		return
	end

	slot0:stopSwitchToNextState()

	slot0.nextState = nil

	slot0:directSetState(slot0.nextState)
end

function slot0.setNextState(slot0, slot1)
	slot0.nextState = slot1

	slot0:log("set next state : " .. slot1)
end

function slot0.delaySwitchToNextState(slot0, slot1, slot2)
	slot0:stopSwitchToNextState()
	slot0:setNextState(slot1)
	TaskDispatcher.runDelay(slot0.switchToNextState, slot0, slot2)
end

function slot0.stopSwitchToNextState(slot0)
	TaskDispatcher.cancelTask(slot0.switchToNextState, slot0)
end

function slot0.log(slot0, slot1)
end

function slot0.directSetState(slot0, slot1)
	slot0:switchToNextState()
	slot0:log("direct set state : " .. slot1)

	slot0.state = slot1

	slot0.directSetStateHandleDict[slot0.state](slot0, slot0.state)
end

function slot0.switchToState(slot0, slot1)
	slot0:switchToNextState()
	slot0:log("switch to state : " .. slot1)

	slot0.state = slot1

	slot0.switchToStateHandleDict[slot0.state](slot0, slot0.state)
end

function slot0.getCurState(slot0)
	return slot0.state
end

function slot0.playAnim(slot0, slot1, slot2, slot3, slot4)
	slot0:setNextState(slot4 or slot0.mgr:getPointCurState(slot0.index))

	if slot0.exPointGo.activeInHierarchy then
		slot0.animator.enabled = true

		slot0.animatorPlayer:Play(slot1, slot2 or slot0.switchToNextState, slot3 or slot0)
	else
		slot0:switchToNextState()
	end
end

function slot0.playAnimNoCallback(slot0, slot1)
	if slot0.exPointGo.activeInHierarchy then
		slot0.animator.enabled = true

		slot0.animatorPlayer:Play(slot1)
	end
end

function slot0.playAddPointEffect(slot0, slot1, slot2)
	gohelper.setActive(slot0.goFull, true)

	if slot2 then
		slot0:setNextState(slot1 or FightEnum.ExPointState.Server)
		slot0:playAnimNoCallback(uv0.AnimName.Add)
		TaskDispatcher.runDelay(slot0.switchToNextState, slot0, slot2)
	else
		slot0:playAnim(uv0.AnimName.Add, slot0.switchToNextState, slot0, slot1)
	end

	if FightBuffHelper.checkPlayDuDuGuAddExPointEffect(slot0.mgr.entity) then
		slot4 = slot3.effect:addHangEffect("v2a3_ddg/ddg_innate_03", ModuleEnum.SpineHangPointRoot, nil, 1)

		slot4:setLocalPos(0, 0, 0)
		FightRenderOrderMgr.instance:onAddEffectWrap(slot3.id, slot4)
	end
end

function slot0.playRemoveStoredEffect(slot0)
	gohelper.setActive(slot0.goFull, true)
	slot0:playAnim(uv0.AnimName.StoredLost)
end

function slot0.directSetEmptyState(slot0, slot1)
	slot0:resetToEmpty()
end

function slot0.directSetServerState(slot0, slot1)
	slot0:resetToEmpty()
	gohelper.setActive(slot0.goFull, true)
end

function slot0.directSetClientState(slot0, slot1)
	slot0:resetToEmpty()
	gohelper.setActive(slot0.goFull, true)

	slot0.animator.enabled = true

	slot0.animatorPlayer:Play(uv0.AnimName.Client)
end

function slot0.directSetServerFullState(slot0, slot1)
	slot0:resetToEmpty()
	gohelper.setActive(slot0.goFull, true)
	slot0:playAnimToLastFrame(uv0.AnimName.Loop)
end

function slot0.directSetUsingUniqueState(slot0, slot1)
	if slot1 == slot0.state then
		return
	end

	slot0:resetToEmpty()

	slot0.animator.enabled = true

	slot0.animatorPlayer:Play(uv0.AnimName.UsingSkillExplosion)
end

function slot0.directSetLockState(slot0, slot1)
	slot0:resetToEmpty()
	gohelper.setActive(slot0.goFull, false)
	slot0:playAnimToLastFrame(uv0.AnimName.LockOpen)
end

function slot0.directSetStoredState(slot0, slot1)
	slot0:resetToEmpty()
	gohelper.setActive(slot0.goFull, false)
	slot0:playAnimToLastFrame(uv0.AnimName.StoredAdd)
end

function slot0.switchToEmptyState(slot0, slot1)
	slot0:resetToEmpty()

	if slot1 == FightEnum.ExPointState.Lock then
		slot0.animator.enabled = true

		slot0.animatorPlayer:Play(uv0.AnimName.LockClose)
	elseif slot1 == FightEnum.ExPointState.Lock then
		slot0.animator.enabled = true

		slot0.animatorPlayer:Play(uv0.AnimName.Lost)
	end
end

function slot0.switchToServerState(slot0, slot1)
	slot0:resetToEmpty()
	gohelper.setActive(slot0.goFull, true)
end

function slot0.switchToClientState(slot0, slot1)
	slot0:resetToEmpty()
	gohelper.setActive(slot0.goFull, true)

	slot0.animator.enabled = true

	slot0.animatorPlayer:Play(uv0.AnimName.Client)
end

function slot0.switchToServerFullState(slot0, slot1)
	slot0:resetToEmpty()
	gohelper.setActive(slot0.goFull, true)

	slot0.animator.enabled = true

	slot0.animatorPlayer:Play(uv0.AnimName.Loop)
end

function slot0.switchToUsingUniqueState(slot0, slot1)
	if slot1 == slot0.state then
		return
	end

	slot0:resetToEmpty()

	slot0.animator.enabled = true

	slot0.animatorPlayer:Play(uv0.AnimName.UsingSkillExplosion)
end

function slot0.switchToLockState(slot0, slot1)
	slot0:resetToEmpty()
	gohelper.setActive(slot0.goFull, false)

	slot0.animator.enabled = true

	slot0.animatorPlayer:Play(uv0.AnimName.LockOpen)
end

function slot0.switchToStoredState(slot0, slot1)
	if slot1 == slot0.state then
		return
	end

	slot0:resetToEmpty()
	gohelper.setActive(slot0.goFull, false)

	slot0.animator.enabled = true

	slot0.animatorPlayer:Play(uv0.AnimName.StoredAdd)
end

function slot0.destroy(slot0)
	slot0:stopSwitchToNextState()
	slot0.animatorPlayer:Stop()
	gohelper.destroy(slot0.exPointGo)
	slot0:__onDispose()
end

return slot0
