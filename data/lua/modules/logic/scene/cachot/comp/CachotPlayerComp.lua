module("modules.logic.scene.cachot.comp.CachotPlayerComp", package.seeall)

slot0 = class("CachotPlayerComp", BaseSceneComp)
slot1 = 0.05
slot2 = 0.1
slot3 = 0.02
slot4 = 0.3
slot5 = 1

function slot0.init(slot0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.PlayerMove, slot0.onPlayerMove, slot0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.PlayerStopMove, slot0.onStopMove, slot0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.PlayerMoveTo, slot0.moveToPos, slot0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.RoomChangeAnimEnd, slot0._resetPlayerPos, slot0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.RoomChangeBegin, slot0._clearAsset, slot0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.BeginTriggerEvent, slot0._beginTriggerEvent, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, slot0._onCloseViewFinish, slot0)
	slot0._levelComp:registerCallback(CommonSceneLevelComp.OnLevelLoaded, slot0.onSceneLevelLoaded, slot0)

	if slot0._levelComp:getSceneGo() then
		slot0:onSceneLevelLoaded()
	end
end

function slot0.onSceneStart(slot0, slot1, slot2)
	slot0._scene = slot0:getCurScene()
	slot0._roomComp = slot0._scene.room
	slot0._levelComp = slot0._scene.level
	slot0._preloadComp = slot0._scene.preloader
end

function slot0.onSceneLevelLoaded(slot0)
	slot2 = lua_scene_level.configDict[slot0:getCurScene():getCurLevelId()]
	slot0._sceneGo = slot0._levelComp:getSceneGo()
	slot8 = UnityEngine.Animator
	slot3 = slot0._sceneGo:GetComponent(typeof(slot8))
	slot3.enabled = false

	for slot8 = 0, slot3.runtimeAnimatorController.animationClips.Length - 1 do
		if slot4[slot8].name:find("_role_middle$") then
			slot0._playerAnim = slot4[slot8]
		elseif slot9:find("_role_left$") then
			slot0._playerAnimLeft = slot4[slot8]
		elseif slot9:find("_role_right$") then
			slot0._playerAnimRight = slot4[slot8]
		else
			slot0._sceneAnim = slot4[slot8]
		end
	end

	slot0._playerSpeed = tonumber(V1a6_CachotConfig.instance:getConstConfig(V1a6_CachotEnum.Const.MoveSpeed).value) or 3
	slot0._animLen = slot0._playerAnim.length
	slot0._animLeftLen = slot0._playerAnimLeft.length
	slot0._animRightLen = slot0._playerAnimRight.length

	slot0:_setAnimValForce(slot0:_getDefaultVal(slot2) - slot0._animLeftLen)

	slot0._playerGo = gohelper.findChild(slot0._sceneGo, "Obj-Plant/role/body")
	slot0._player = CachotPlayer.Create(slot0._playerGo)

	slot0._player:setDir(false)

	if ViewMgr.instance:isOpen(ViewName.LoadingView) or ViewMgr.instance:isOpen(ViewName.V1a6_CachotLoadingView) or ViewMgr.instance:isOpen(ViewName.V1a6_CachotLayerChangeView) then
		slot0._player:setActive(false)
	else
		slot0._player:setActive(true)
		slot0._player:playEnterAnim(not V1a6_CachotModel.instance:isInRogue())
	end

	if not V1a6_CachotModel.instance:isInRogue() then
		slot0._doorEffect = CachotDoorEffect.Create(slot0._preloadComp:getResInst(CachotScenePreloader.DoorEffectPath, gohelper.findChild(slot0._sceneGo, "Obj-Plant/all/diffuse/near_b/effects/trigger/effect_door")))
	end

	TaskDispatcher.runRepeat(slot0._cameraFollow, slot0, 0, -1)
end

function slot0._getDefaultVal(slot0, slot1)
	if V1a6_CachotModel.instance:getRogueInfo() and lua_rogue_room.configDict[slot2.room].type == 0 then
		return tonumber(lua_rogue_const.configDict[V1a6_CachotEnum.Const.FirstRoomValue].value)
	end

	return tonumber(slot1.cardCamera) or 0
end

function slot0._clearAsset(slot0)
	slot0._sceneAnim = nil
	slot0._playerAnim = nil
	slot0._playerAnimLeft = nil
	slot0._playerAnimRight = nil
	slot0._sceneGo = nil

	TaskDispatcher.cancelTask(slot0._cameraFollow, slot0)

	slot0._targetTr = nil

	TaskDispatcher.cancelTask(slot0._everyFrameMove, slot0)
	V1a6_CachotRoomModel.instance:setNearEventMo(nil)
end

function slot0.onPlayerMove(slot0, slot1)
	if V1a6_CachotRoomModel.instance.isLockPlayerMove then
		return false
	end

	if not slot0._player or not slot0._player:isCanMove() then
		return
	end

	if not slot0._sceneAnim then
		return
	end

	if slot0._targetTr then
		slot0._targetTr = nil

		TaskDispatcher.cancelTask(slot0._everyFrameMove, slot0)
	end

	slot0._playerVal = slot0._playerVal + slot1 * UnityEngine.Time.deltaTime * slot0._playerSpeed
	slot0._playerVal = Mathf.Clamp(slot0._playerVal, -slot0._animLeftLen, slot0._animLen + slot0._animRightLen)

	slot0:_setPlayerDir(slot1 > 0)
	slot0._player:setIsMove(true)
	slot0:_movePlayer()
end

function slot0._movePlayer(slot0)
	if slot0._playerVal < 0 then
		slot0._playerAnimLeft:SampleAnimation(slot0._sceneGo, slot0._animLeftLen + slot0._playerVal)
	elseif slot0._animLen < slot0._playerVal then
		slot0._playerAnimRight:SampleAnimation(slot0._sceneGo, slot0._playerVal - slot0._animLen)
		slot0:_checkStartGame()
	else
		slot0._playerAnim:SampleAnimation(slot0._sceneGo, slot0._playerVal)
	end

	if V1a6_CachotModel.instance:isInRogue() then
		slot0:_checkNearEvent()
	elseif slot0._doorEffect then
		slot0._doorEffect:setIsInDoor(slot0._playerVal > slot0._animLen + 0.5 * slot0._animRightLen)
	end
end

function slot0._checkStartGame(slot0)
	if V1a6_CachotModel.instance:isInRogue() then
		return
	end

	if slot0._playerVal == slot0._animLen + slot0._animRightLen then
		ViewMgr.instance:closeView(ViewName.V1a6_CachotMainView)
		slot0._player:showEffect(V1a6_CachotEnum.PlayerEffect.RoleTransEffect)
		slot0._player:setActive(false)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_entrance_teleport)
		TaskDispatcher.runDelay(slot0._onEffectFinish, slot0, 0.6)
	end
end

function slot0._onEffectFinish(slot0)
	TaskDispatcher.cancelTask(slot0._onEffectFinish, slot0)
	V1a6_CachotController.instance:openV1a6_CachotDifficultyView()
	slot0._doorEffect:hideEffect()
	slot0._player:hideEffect(V1a6_CachotEnum.PlayerEffect.RoleTransEffect)
end

function slot0.moveToPos(slot0, slot1)
	if not slot0._player or not slot0._player:isCanMove() then
		return
	end

	if V1a6_CachotRoomModel.instance.isLockPlayerMove then
		return false
	end

	if math.abs(slot1.position.x - slot0._player:getPos().x) < uv0 then
		return
	end

	slot0._targetTr = slot1

	slot0:_setPlayerDir(slot2.x < slot3.x)
	slot0._player:setIsMove(true)
	TaskDispatcher.runRepeat(slot0._everyFrameMove, slot0, 0, -1)
end

function slot0._cameraFollow(slot0)
	if not slot0._sceneAnim then
		return
	end

	if math.abs(slot0._playerVal - slot0._cameraVal) < uv0 then
		return
	end

	slot2 = nil
	slot2 = slot0._cameraVal <= slot0._playerVal and 1 or -1

	if uv2 < slot1 * uv1 then
		slot3 = uv2
	end

	slot0._cameraVal = slot3 * slot2 + slot0._cameraVal
	slot0._cameraVal = Mathf.Clamp(slot0._cameraVal, 0, slot0._animLen)

	slot0._sceneAnim:SampleAnimation(slot0._sceneGo, slot0._cameraVal)
end

function slot0._everyFrameMove(slot0)
	if math.abs(slot0._targetTr.position.x - slot0._player:getPos().x) < uv0 then
		slot0._targetTr = nil

		TaskDispatcher.cancelTask(slot0._everyFrameMove, slot0)
		slot0:onStopMove()

		return
	end

	slot0._playerVal = slot0._playerVal + UnityEngine.Time.deltaTime * slot0._playerSpeed * (slot1.x < slot2.x and 1 or -1)
	slot0._playerVal = Mathf.Clamp(slot0._playerVal, -slot0._animLeftLen, slot0._animLen + slot0._animRightLen)

	slot0:_movePlayer()
end

function slot0._checkNearEvent(slot0)
	slot3 = nil

	if V1a6_CachotRoomModel.instance:getNearEventMo() and math.abs(slot0._levelComp:getEventTr(slot2.index).position.x - slot0._player:getPos().x) <= uv0 then
		return
	end

	for slot8, slot9 in pairs(V1a6_CachotRoomModel.instance:getRoomEventMos()) do
		if math.abs(slot0._levelComp:getEventTr(slot9.index).position.x - slot1.x) <= uv0 then
			slot3 = slot9

			break
		end
	end

	V1a6_CachotRoomModel.instance:setNearEventMo(slot3)
end

function slot0._setPlayerDir(slot0, slot1)
	slot0._player:setDir(not slot1)
end

function slot0._beginTriggerEvent(slot0)
	slot0:onStopMove()

	slot0._targetTr = nil

	TaskDispatcher.cancelTask(slot0._everyFrameMove, slot0)
	slot0._player:playTriggerAnim()
end

function slot0.onStopMove(slot0)
	slot0._player:setIsMove(false)
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.V1a6_CachotDifficultyView then
		if slot0._player then
			slot0._player:setActive(true)
		end

		slot0:_resetPlayerPos()
	elseif (slot1 == ViewName.LoadingView or slot1 == ViewName.V1a6_CachotLoadingView or slot1 == ViewName.V1a6_CachotLayerChangeView) and slot0._player then
		slot0._player:setActive(true)
		slot0._player:playEnterAnim(not V1a6_CachotModel.instance:isInRogue())
	end
end

function slot0._resetPlayerPos(slot0)
	slot0:_setAnimValForce(slot0:_getDefaultVal(lua_scene_level.configDict[slot0:getCurScene():getCurLevelId()]) - slot0._animLeftLen)
	slot0._player:hideEffect(V1a6_CachotEnum.PlayerEffect.RoleTransEffect)
	slot0:_movePlayer()
end

function slot0._setAnimValForce(slot0, slot1)
	slot0._playerVal = slot1
	slot0._cameraVal = Mathf.Clamp(slot1, 0, slot0._animLen)

	if slot1 < 0 then
		slot0._sceneAnim:SampleAnimation(slot0._sceneGo, 0)
		slot0._playerAnimLeft:SampleAnimation(slot0._sceneGo, slot0._animLeftLen + slot1)
	elseif slot0._animLen < slot1 then
		slot0._sceneAnim:SampleAnimation(slot0._sceneGo, 1)
		slot0._playerAnimRight:SampleAnimation(slot0._sceneGo, slot1 - slot0._animLen)
	else
		slot0._playerAnim:SampleAnimation(slot0._sceneGo, slot1)
		slot0._sceneAnim:SampleAnimation(slot0._sceneGo, slot1)
	end
end

function slot0.onSceneClose(slot0)
	V1a6_CachotRoomModel.instance:setNearEventMo(nil)
	TaskDispatcher.cancelTask(slot0._everyFrameMove, slot0)
	TaskDispatcher.cancelTask(slot0._cameraFollow, slot0)
	TaskDispatcher.cancelTask(slot0._onEffectFinish, slot0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.PlayerMove, slot0.onPlayerMove, slot0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.PlayerStopMove, slot0.onStopMove, slot0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.PlayerMoveTo, slot0.moveToPos, slot0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.RoomChangeAnimEnd, slot0._resetPlayerPos, slot0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.RoomChangeBegin, slot0._clearAsset, slot0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.BeginTriggerEvent, slot0._beginTriggerEvent, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, slot0._onCloseViewFinish, slot0)
	slot0._levelComp:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, slot0.onSceneLevelLoaded, slot0)

	if slot0._player then
		slot0._player:dispose()

		slot0._player = nil
	end

	if slot0._doorEffect then
		slot0._doorEffect:dispose()

		slot0._doorEffect = nil
	end

	gohelper.destroy(slot0._playerGo)

	slot0._playerGo = nil
	slot0._targetTr = nil
	slot0._scene = nil
end

return slot0
