module("modules.logic.scene.cachot.entity.CachotPlayer", package.seeall)

slot0 = class("CachotPlayer", BaseUnitSpawn)
slot1 = {
	IdleToMove = "move2",
	MoveToIdle = "move2_2",
	Idle = "idle",
	MainSceneBorn = "born",
	RogueSceneBorn = "born2",
	TriggerIdle = "idle2",
	Move = "move2_1"
}
slot2 = {
	[slot1.Idle] = true,
	[slot1.Move] = true
}

function slot0.Create(slot0)
	return MonoHelper.addNoUpdateLuaComOnceToGo(slot0, uv0)
end

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0.trans = slot1.transform
	slot0._effectDict = {}
	slot0._effectContainer = gohelper.create3d(slot0.go, "Effect")

	slot0:loadSpine("roles/dilaoxiaoren/dilaoxiaoren.prefab")
end

function slot0.initComponents(slot0)
	slot0:addComp("spine", UnitSpine)
	slot0:addComp("spineRenderer", UnitSpineRenderer)
	slot0.spine:setLayer(UnityLayer.Scene)
end

function slot0.loadSpine(slot0, slot1)
	if slot0.spine then
		slot0.spine:setResPath(slot1, slot0._onSpineLoaded, slot0)
	end
end

function slot0._onSpineLoaded(slot0, slot1)
	if slot0.spineRenderer then
		slot0.spineRenderer:setSpine(slot1)
	end

	slot0.spine:addAnimEventCallback(slot0._onAnimEvent, slot0)
	slot0:playAnim(slot0._cacheAnimName or uv0.Idle)
	transformhelper.setLocalScale(slot1:getSpineTr(), 0.435, 0.435, 0.435)
	gohelper.setActive(slot0.spine:getSpineGO(), slot0._isActive)
end

function slot0.playAnim(slot0, slot1)
	slot0._cacheAnimName = slot1

	if slot0.spine:getSpineGO() then
		slot0.spine:play(slot1, uv0[slot1], not uv0[slot1])
	end
end

function slot0.playEnterAnim(slot0, slot1)
	if slot1 then
		slot0:playAnim(uv0.MainSceneBorn)
	else
		slot0:playAnim(uv0.RogueSceneBorn)
		slot0:showEffect(V1a6_CachotEnum.PlayerEffect.RoleBornEffect)
		TaskDispatcher.cancelTask(slot0._delayHideEffect, slot0)
		TaskDispatcher.runDelay(slot0._delayHideEffect, slot0, 1.5)
	end
end

function slot0._delayHideEffect(slot0)
	slot0:hideEffect(V1a6_CachotEnum.PlayerEffect.RoleBornEffect)
end

function slot0._onAnimEvent(slot0, slot1, slot2, slot3)
	if slot2 == SpineAnimEvent.ActionComplete then
		if slot1 == uv0.IdleToMove then
			slot0:playAnim(uv0.Move)
		else
			slot0:playAnim(uv0.Idle)
		end

		if slot1 == uv0.RogueSceneBorn then
			V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.CheckPlayStory)
		end
	end
end

function slot0.setIsMove(slot0, slot1, slot2)
	if not slot2 and slot0._isMoving == slot1 then
		return
	end

	slot0._isMoving = slot1

	if not slot0:isCanMove() then
		return
	end

	if slot0._cacheAnimName == uv0.Move and not slot0._isMoving then
		slot0:playAnim(uv0.MoveToIdle)
	elseif slot0._cacheAnimName == uv0.Idle and slot0._isMoving then
		slot0:playAnim(uv0.IdleToMove)
	else
		slot0:playAnim(slot0._isMoving and uv0.Move or uv0.Idle)
	end
end

function slot0.playTriggerAnim(slot0)
	slot0:playAnim(uv0.TriggerIdle)
end

function slot0.isCanMove(slot0)
	if not slot0.spine:getSpineGO() or not slot0.spine:getSpineGO().activeSelf then
		return
	end

	return slot0._cacheAnimName == uv0.Idle or slot0._cacheAnimName == uv0.Move or slot0._cacheAnimName == uv0.MoveToIdle or slot0._cacheAnimName == uv0.IdleToMove or not slot0._cacheAnimName
end

function slot0.setDir(slot0, slot1, slot2)
	if not slot2 and slot0._isLeft == slot1 then
		return
	end

	slot0._isLeft = slot1

	transformhelper.setLocalScale(slot0.trans, slot1 and 1 or -1, 1, 1)
end

function slot0.showEffect(slot0, slot1)
	if slot0._effectDict[slot1] then
		return
	end

	slot0._effectDict[slot1] = GameSceneMgr.instance:getCurScene().preloader:getResInst(CachotScenePreloader[slot1], slot0._effectContainer)
end

function slot0.hideEffect(slot0, slot1)
	if slot0._effectDict[slot1] then
		gohelper.destroy(slot0._effectDict[slot1])

		slot0._effectDict[slot1] = nil
	end
end

function slot0.setActive(slot0, slot1)
	slot0._isActive = slot1

	gohelper.setActive(slot0.spine:getSpineGO(), slot1)
end

function slot0.getPos(slot0)
	return slot0.trans.position
end

function slot0.dispose(slot0)
	TaskDispatcher.cancelTask(slot0._delayHideEffect, slot0)
	gohelper.destroy(slot0._effectContainer)

	slot0._effectContainer = nil
	slot0._effectDict = {}
end

return slot0
