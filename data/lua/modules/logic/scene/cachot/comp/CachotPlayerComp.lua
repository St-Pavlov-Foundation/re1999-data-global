module("modules.logic.scene.cachot.comp.CachotPlayerComp", package.seeall)

local var_0_0 = class("CachotPlayerComp", BaseSceneComp)
local var_0_1 = 0.05
local var_0_2 = 0.1
local var_0_3 = 0.02
local var_0_4 = 0.3
local var_0_5 = 1

function var_0_0.init(arg_1_0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.PlayerMove, arg_1_0.onPlayerMove, arg_1_0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.PlayerStopMove, arg_1_0.onStopMove, arg_1_0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.PlayerMoveTo, arg_1_0.moveToPos, arg_1_0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.RoomChangeAnimEnd, arg_1_0._resetPlayerPos, arg_1_0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.RoomChangeBegin, arg_1_0._clearAsset, arg_1_0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.BeginTriggerEvent, arg_1_0._beginTriggerEvent, arg_1_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_1_0._onCloseViewFinish, arg_1_0)
	arg_1_0._levelComp:registerCallback(CommonSceneLevelComp.OnLevelLoaded, arg_1_0.onSceneLevelLoaded, arg_1_0)

	if arg_1_0._levelComp:getSceneGo() then
		arg_1_0:onSceneLevelLoaded()
	end
end

function var_0_0.onSceneStart(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._scene = arg_2_0:getCurScene()
	arg_2_0._roomComp = arg_2_0._scene.room
	arg_2_0._levelComp = arg_2_0._scene.level
	arg_2_0._preloadComp = arg_2_0._scene.preloader
end

function var_0_0.onSceneLevelLoaded(arg_3_0)
	local var_3_0 = arg_3_0:getCurScene():getCurLevelId()
	local var_3_1 = lua_scene_level.configDict[var_3_0]

	arg_3_0._sceneGo = arg_3_0._levelComp:getSceneGo()

	local var_3_2 = arg_3_0._sceneGo:GetComponent(typeof(UnityEngine.Animator))

	var_3_2.enabled = false

	local var_3_3 = var_3_2.runtimeAnimatorController.animationClips

	for iter_3_0 = 0, var_3_3.Length - 1 do
		local var_3_4 = var_3_3[iter_3_0].name

		if var_3_4:find("_role_middle$") then
			arg_3_0._playerAnim = var_3_3[iter_3_0]
		elseif var_3_4:find("_role_left$") then
			arg_3_0._playerAnimLeft = var_3_3[iter_3_0]
		elseif var_3_4:find("_role_right$") then
			arg_3_0._playerAnimRight = var_3_3[iter_3_0]
		else
			arg_3_0._sceneAnim = var_3_3[iter_3_0]
		end
	end

	arg_3_0._playerSpeed = tonumber(V1a6_CachotConfig.instance:getConstConfig(V1a6_CachotEnum.Const.MoveSpeed).value) or 3
	arg_3_0._animLen = arg_3_0._playerAnim.length
	arg_3_0._animLeftLen = arg_3_0._playerAnimLeft.length
	arg_3_0._animRightLen = arg_3_0._playerAnimRight.length

	local var_3_5 = arg_3_0:_getDefaultVal(var_3_1) - arg_3_0._animLeftLen

	arg_3_0:_setAnimValForce(var_3_5)

	arg_3_0._playerGo = gohelper.findChild(arg_3_0._sceneGo, "Obj-Plant/role/body")
	arg_3_0._player = CachotPlayer.Create(arg_3_0._playerGo)

	arg_3_0._player:setDir(false)

	if ViewMgr.instance:isOpen(ViewName.LoadingView) or ViewMgr.instance:isOpen(ViewName.V1a6_CachotLoadingView) or ViewMgr.instance:isOpen(ViewName.V1a6_CachotLayerChangeView) then
		arg_3_0._player:setActive(false)
	else
		arg_3_0._player:setActive(true)
		arg_3_0._player:playEnterAnim(not V1a6_CachotModel.instance:isInRogue())
	end

	if not V1a6_CachotModel.instance:isInRogue() then
		local var_3_6 = gohelper.findChild(arg_3_0._sceneGo, "Obj-Plant/all/diffuse/near_b/effects/trigger/effect_door")

		arg_3_0._doorEffect = CachotDoorEffect.Create(arg_3_0._preloadComp:getResInst(CachotScenePreloader.DoorEffectPath, var_3_6))
	end

	TaskDispatcher.runRepeat(arg_3_0._cameraFollow, arg_3_0, 0, -1)
end

function var_0_0._getDefaultVal(arg_4_0, arg_4_1)
	local var_4_0 = V1a6_CachotModel.instance:getRogueInfo()

	if var_4_0 and lua_rogue_room.configDict[var_4_0.room].type == 0 then
		return tonumber(lua_rogue_const.configDict[V1a6_CachotEnum.Const.FirstRoomValue].value)
	end

	return tonumber(arg_4_1.cardCamera) or 0
end

function var_0_0._clearAsset(arg_5_0)
	arg_5_0._sceneAnim = nil
	arg_5_0._playerAnim = nil
	arg_5_0._playerAnimLeft = nil
	arg_5_0._playerAnimRight = nil
	arg_5_0._sceneGo = nil

	TaskDispatcher.cancelTask(arg_5_0._cameraFollow, arg_5_0)

	arg_5_0._targetTr = nil

	TaskDispatcher.cancelTask(arg_5_0._everyFrameMove, arg_5_0)
	V1a6_CachotRoomModel.instance:setNearEventMo(nil)
end

function var_0_0.onPlayerMove(arg_6_0, arg_6_1)
	if V1a6_CachotRoomModel.instance.isLockPlayerMove then
		return false
	end

	if not arg_6_0._player or not arg_6_0._player:isCanMove() then
		return
	end

	if not arg_6_0._sceneAnim then
		return
	end

	if arg_6_0._targetTr then
		arg_6_0._targetTr = nil

		TaskDispatcher.cancelTask(arg_6_0._everyFrameMove, arg_6_0)
	end

	arg_6_0._playerVal = arg_6_0._playerVal + arg_6_1 * UnityEngine.Time.deltaTime * arg_6_0._playerSpeed
	arg_6_0._playerVal = Mathf.Clamp(arg_6_0._playerVal, -arg_6_0._animLeftLen, arg_6_0._animLen + arg_6_0._animRightLen)

	arg_6_0:_setPlayerDir(arg_6_1 > 0)
	arg_6_0._player:setIsMove(true)
	arg_6_0:_movePlayer()
end

function var_0_0._movePlayer(arg_7_0)
	if arg_7_0._playerVal < 0 then
		arg_7_0._playerAnimLeft:SampleAnimation(arg_7_0._sceneGo, arg_7_0._animLeftLen + arg_7_0._playerVal)
	elseif arg_7_0._playerVal > arg_7_0._animLen then
		arg_7_0._playerAnimRight:SampleAnimation(arg_7_0._sceneGo, arg_7_0._playerVal - arg_7_0._animLen)
		arg_7_0:_checkStartGame()
	else
		arg_7_0._playerAnim:SampleAnimation(arg_7_0._sceneGo, arg_7_0._playerVal)
	end

	if V1a6_CachotModel.instance:isInRogue() then
		arg_7_0:_checkNearEvent()
	elseif arg_7_0._doorEffect then
		arg_7_0._doorEffect:setIsInDoor(arg_7_0._playerVal > arg_7_0._animLen + 0.5 * arg_7_0._animRightLen)
	end
end

function var_0_0._checkStartGame(arg_8_0)
	if V1a6_CachotModel.instance:isInRogue() then
		return
	end

	if arg_8_0._playerVal == arg_8_0._animLen + arg_8_0._animRightLen then
		ViewMgr.instance:closeView(ViewName.V1a6_CachotMainView)
		arg_8_0._player:showEffect(V1a6_CachotEnum.PlayerEffect.RoleTransEffect)
		arg_8_0._player:setActive(false)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_entrance_teleport)
		TaskDispatcher.runDelay(arg_8_0._onEffectFinish, arg_8_0, 0.6)
	end
end

function var_0_0._onEffectFinish(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._onEffectFinish, arg_9_0)
	V1a6_CachotController.instance:openV1a6_CachotDifficultyView()
	arg_9_0._doorEffect:hideEffect()
	arg_9_0._player:hideEffect(V1a6_CachotEnum.PlayerEffect.RoleTransEffect)
end

function var_0_0.moveToPos(arg_10_0, arg_10_1)
	if not arg_10_0._player or not arg_10_0._player:isCanMove() then
		return
	end

	if V1a6_CachotRoomModel.instance.isLockPlayerMove then
		return false
	end

	local var_10_0 = arg_10_0._player:getPos()
	local var_10_1 = arg_10_1.position

	if math.abs(var_10_1.x - var_10_0.x) < var_0_4 then
		return
	end

	arg_10_0._targetTr = arg_10_1

	arg_10_0:_setPlayerDir(var_10_1.x > var_10_0.x)
	arg_10_0._player:setIsMove(true)
	TaskDispatcher.runRepeat(arg_10_0._everyFrameMove, arg_10_0, 0, -1)
end

function var_0_0._cameraFollow(arg_11_0)
	if not arg_11_0._sceneAnim then
		return
	end

	local var_11_0 = math.abs(arg_11_0._playerVal - arg_11_0._cameraVal)

	if var_11_0 < var_0_3 then
		return
	end

	local var_11_1
	local var_11_2 = arg_11_0._playerVal >= arg_11_0._cameraVal and 1 or -1
	local var_11_3 = var_11_0 * var_0_1

	if var_11_3 > var_0_2 then
		var_11_3 = var_0_2
	end

	arg_11_0._cameraVal = var_11_3 * var_11_2 + arg_11_0._cameraVal
	arg_11_0._cameraVal = Mathf.Clamp(arg_11_0._cameraVal, 0, arg_11_0._animLen)

	arg_11_0._sceneAnim:SampleAnimation(arg_11_0._sceneGo, arg_11_0._cameraVal)
end

function var_0_0._everyFrameMove(arg_12_0)
	local var_12_0 = arg_12_0._player:getPos()
	local var_12_1 = arg_12_0._targetTr.position

	if math.abs(var_12_1.x - var_12_0.x) < var_0_4 then
		arg_12_0._targetTr = nil

		TaskDispatcher.cancelTask(arg_12_0._everyFrameMove, arg_12_0)
		arg_12_0:onStopMove()

		return
	end

	arg_12_0._playerVal = arg_12_0._playerVal + UnityEngine.Time.deltaTime * arg_12_0._playerSpeed * (var_12_1.x > var_12_0.x and 1 or -1)
	arg_12_0._playerVal = Mathf.Clamp(arg_12_0._playerVal, -arg_12_0._animLeftLen, arg_12_0._animLen + arg_12_0._animRightLen)

	arg_12_0:_movePlayer()
end

function var_0_0._checkNearEvent(arg_13_0)
	local var_13_0 = arg_13_0._player:getPos()
	local var_13_1 = V1a6_CachotRoomModel.instance:getNearEventMo()
	local var_13_2

	if var_13_1 then
		local var_13_3 = arg_13_0._levelComp:getEventTr(var_13_1.index)

		if math.abs(var_13_3.position.x - var_13_0.x) <= var_0_5 then
			return
		end
	end

	local var_13_4 = V1a6_CachotRoomModel.instance:getRoomEventMos()

	for iter_13_0, iter_13_1 in pairs(var_13_4) do
		local var_13_5 = arg_13_0._levelComp:getEventTr(iter_13_1.index)

		if math.abs(var_13_5.position.x - var_13_0.x) <= var_0_5 then
			var_13_2 = iter_13_1

			break
		end
	end

	V1a6_CachotRoomModel.instance:setNearEventMo(var_13_2)
end

function var_0_0._setPlayerDir(arg_14_0, arg_14_1)
	arg_14_0._player:setDir(not arg_14_1)
end

function var_0_0._beginTriggerEvent(arg_15_0)
	arg_15_0:onStopMove()

	arg_15_0._targetTr = nil

	TaskDispatcher.cancelTask(arg_15_0._everyFrameMove, arg_15_0)
	arg_15_0._player:playTriggerAnim()
end

function var_0_0.onStopMove(arg_16_0)
	arg_16_0._player:setIsMove(false)
end

function var_0_0._onCloseViewFinish(arg_17_0, arg_17_1)
	if arg_17_1 == ViewName.V1a6_CachotDifficultyView then
		if arg_17_0._player then
			arg_17_0._player:setActive(true)
		end

		arg_17_0:_resetPlayerPos()
	elseif (arg_17_1 == ViewName.LoadingView or arg_17_1 == ViewName.V1a6_CachotLoadingView or arg_17_1 == ViewName.V1a6_CachotLayerChangeView) and arg_17_0._player then
		arg_17_0._player:setActive(true)
		arg_17_0._player:playEnterAnim(not V1a6_CachotModel.instance:isInRogue())
	end
end

function var_0_0._resetPlayerPos(arg_18_0)
	local var_18_0 = arg_18_0:getCurScene():getCurLevelId()
	local var_18_1 = lua_scene_level.configDict[var_18_0]
	local var_18_2 = arg_18_0:_getDefaultVal(var_18_1) - arg_18_0._animLeftLen

	arg_18_0:_setAnimValForce(var_18_2)
	arg_18_0._player:hideEffect(V1a6_CachotEnum.PlayerEffect.RoleTransEffect)
	arg_18_0:_movePlayer()
end

function var_0_0._setAnimValForce(arg_19_0, arg_19_1)
	arg_19_0._playerVal = arg_19_1
	arg_19_0._cameraVal = Mathf.Clamp(arg_19_1, 0, arg_19_0._animLen)

	if arg_19_1 < 0 then
		arg_19_0._sceneAnim:SampleAnimation(arg_19_0._sceneGo, 0)
		arg_19_0._playerAnimLeft:SampleAnimation(arg_19_0._sceneGo, arg_19_0._animLeftLen + arg_19_1)
	elseif arg_19_1 > arg_19_0._animLen then
		arg_19_0._sceneAnim:SampleAnimation(arg_19_0._sceneGo, 1)
		arg_19_0._playerAnimRight:SampleAnimation(arg_19_0._sceneGo, arg_19_1 - arg_19_0._animLen)
	else
		arg_19_0._playerAnim:SampleAnimation(arg_19_0._sceneGo, arg_19_1)
		arg_19_0._sceneAnim:SampleAnimation(arg_19_0._sceneGo, arg_19_1)
	end
end

function var_0_0.onSceneClose(arg_20_0)
	V1a6_CachotRoomModel.instance:setNearEventMo(nil)
	TaskDispatcher.cancelTask(arg_20_0._everyFrameMove, arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0._cameraFollow, arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0._onEffectFinish, arg_20_0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.PlayerMove, arg_20_0.onPlayerMove, arg_20_0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.PlayerStopMove, arg_20_0.onStopMove, arg_20_0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.PlayerMoveTo, arg_20_0.moveToPos, arg_20_0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.RoomChangeAnimEnd, arg_20_0._resetPlayerPos, arg_20_0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.RoomChangeBegin, arg_20_0._clearAsset, arg_20_0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.BeginTriggerEvent, arg_20_0._beginTriggerEvent, arg_20_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_20_0._onCloseViewFinish, arg_20_0)
	arg_20_0._levelComp:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, arg_20_0.onSceneLevelLoaded, arg_20_0)

	if arg_20_0._player then
		arg_20_0._player:dispose()

		arg_20_0._player = nil
	end

	if arg_20_0._doorEffect then
		arg_20_0._doorEffect:dispose()

		arg_20_0._doorEffect = nil
	end

	gohelper.destroy(arg_20_0._playerGo)

	arg_20_0._playerGo = nil
	arg_20_0._targetTr = nil
	arg_20_0._scene = nil
end

return var_0_0
