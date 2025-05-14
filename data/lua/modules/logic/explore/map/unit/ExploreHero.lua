module("modules.logic.explore.map.unit.ExploreHero", package.seeall)

local var_0_0 = class("ExploreHero", Explore3DRoleBase)

function var_0_0.onInit(arg_1_0)
	arg_1_0._hangPoints = {}
	arg_1_0._baton = UnityEngine.GameObject.New("baton")

	gohelper.setActive(arg_1_0._baton, false)

	arg_1_0._batonLoader = PrefabInstantiate.Create(arg_1_0._baton)

	arg_1_0._batonLoader:startLoad("explore/roles/prefabs/zhihuibang.prefab", arg_1_0._onBatonLoadEnd, arg_1_0)
	var_0_0.super.onInit(arg_1_0)
end

function var_0_0._onBatonLoadEnd(arg_2_0)
	local var_2_0 = arg_2_0._batonLoader:getInstGO()

	arg_2_0._batonEffectLoader = PrefabInstantiate.Create(var_2_0.transform:Find("zhihuibang/Point001").gameObject)

	arg_2_0._batonEffectLoader:startLoad(ResUrl.getExploreEffectPath("open_chest"))
end

function var_0_0.onDestroy(arg_3_0)
	if arg_3_0._batonLoader then
		arg_3_0._batonLoader:dispose()

		arg_3_0._batonLoader = nil
	end

	if arg_3_0._batonEffectLoader then
		arg_3_0._batonEffectLoader:dispose()

		arg_3_0._batonEffectLoader = nil
	end

	gohelper.destroy(arg_3_0._baton)

	arg_3_0._hangPoints = nil

	var_0_0.super.onDestroy(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._onFrame, arg_3_0)
end

function var_0_0.setHeroStatus(arg_4_0, arg_4_1, ...)
	local var_4_0 = ExploreAnimEnum.UseBatonAnim[arg_4_1]
	local var_4_1 = arg_4_0._hangPoints[var_4_0]

	if var_4_1 then
		arg_4_0._baton.transform:SetParent(var_4_1, false)
		gohelper.setActive(arg_4_0._baton, true)
	else
		gohelper.setActive(arg_4_0._baton, false)
	end

	var_0_0.super.setHeroStatus(arg_4_0, arg_4_1, ...)
	ExploreController.instance:dispatchEvent(ExploreEvent.HeroStatuStart, arg_4_1)
end

function var_0_0.delaySetNormalStatus(arg_5_0, ...)
	ExploreController.instance:dispatchEvent(ExploreEvent.HeroStatuEnd, arg_5_0._curStatus)
	gohelper.setActive(arg_5_0._baton, false)

	if not ExploreModel.instance.isRoleInitDone then
		ExploreModel.instance.isRoleInitDone = true

		ExploreController.instance:dispatchEvent(ExploreEvent.HeroResInitDone)
	end

	var_0_0.super.delaySetNormalStatus(arg_5_0, ...)
end

function var_0_0.setResPath(arg_6_0, arg_6_1)
	if arg_6_1 and arg_6_0._resPath ~= arg_6_1 then
		arg_6_0._resPath = arg_6_1
		arg_6_0._assetId = ResMgr.getAbAsset(arg_6_0._resPath, arg_6_0._onResLoaded, arg_6_0, arg_6_0._assetId)
	elseif arg_6_1 and arg_6_0._resPath == arg_6_1 and arg_6_0._displayGo == nil then
		arg_6_0._assetId = ResMgr.getAbAsset(arg_6_0._resPath, arg_6_0._onResLoaded, arg_6_0, arg_6_0._assetId)
	else
		arg_6_0:onResLoaded()
	end
end

function var_0_0.onResLoaded(arg_7_0)
	arg_7_0._hangPoints = {}

	for iter_7_0, iter_7_1 in pairs(ExploreAnimEnum.RoleHangPointPath) do
		arg_7_0._hangPoints[iter_7_0] = arg_7_0._displayTr:Find(iter_7_1)
	end

	if ExploreModel.instance.isFirstEnterMap == ExploreEnum.EnterMode.First then
		arg_7_0:setActive(false)
	else
		arg_7_0.dir = ExploreMapModel.instance:getHeroDir()

		arg_7_0:setRotate(0, arg_7_0.dir, 0)
	end

	local var_7_0 = ExploreMapModel.instance:getNode(ExploreHelper.getKey(arg_7_0.nodePos))

	if var_7_0 and arg_7_0.position.y ~= var_7_0.height then
		arg_7_0.position.y = var_7_0.height

		transformhelper.setPos(arg_7_0.trans, arg_7_0.position.x, var_7_0.height, arg_7_0.position.z)
		ExploreController.instance:dispatchEvent(ExploreEvent.OnCharacterPosChange, arg_7_0.position)
	end

	if arg_7_0._waitAssetLoaded then
		arg_7_0._waitAssetLoaded = nil

		arg_7_0:onRoleFirstEnter()
	end
end

function var_0_0.onRoleFirstEnter(arg_8_0)
	if not arg_8_0._displayTr then
		arg_8_0._waitAssetLoaded = true

		return
	end

	arg_8_0:setActive(true)

	if ExploreModel.instance:hasUseItemOrUnit() then
		ExploreModel.instance.isRoleInitDone = true

		ExploreController.instance:dispatchEvent(ExploreEvent.HeroResInitDone)

		return
	end

	arg_8_0.dir = ExploreMapModel.instance:getHeroDir()

	arg_8_0:setRotate(0, arg_8_0.dir, 0)

	local var_8_0 = false
	local var_8_1 = ExploreController.instance:getMap():getUnitByPos(arg_8_0.nodePos)

	for iter_8_0, iter_8_1 in pairs(var_8_1) do
		if iter_8_1:getUnitType() == ExploreEnum.ItemType.Spike then
			var_8_0 = true

			break
		end
	end

	if var_8_0 then
		return
	end

	if ExploreModel.instance.isFirstEnterMap ~= ExploreEnum.EnterMode.First then
		ExploreModel.instance.isRoleInitDone = true

		ExploreController.instance:dispatchEvent(ExploreEvent.HeroResInitDone)
		ExploreController.instance:dispatchEvent(ExploreEvent.HeroFirstAnimEnd)

		return
	end

	arg_8_0:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.Entry, true, true)
	ExploreController.instance:dispatchEvent(ExploreEvent.HeroFirstAnimEnd)
end

function var_0_0.onUpdateExploreInfo(arg_9_0)
	arg_9_0.go:SetActive(true)

	local var_9_0, var_9_1 = ExploreMapModel.instance:getHeroPos()

	arg_9_0:setTilemapPos(Vector2(var_9_0, var_9_1))
end

function var_0_0.setMap(arg_10_0, arg_10_1)
	arg_10_0._exploreMap = arg_10_1
end

function var_0_0.getHangTrans(arg_11_0, arg_11_1)
	return arg_11_0._hangPoints[arg_11_1]
end

function var_0_0.onStartMove(arg_12_0, arg_12_1, arg_12_2)
	ExploreController.instance:dispatchEvent(ExploreEvent.OnCharacterStartMove, arg_12_0.nodePos, arg_12_0._nextNodePos)
end

function var_0_0.setPos(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	var_0_0.super.setPos(arg_13_0, arg_13_1, true)

	local var_13_0 = arg_13_0:getPos()

	if ExploreController.instance:getMap():getNowStatus() == ExploreEnum.MapStatus.MoveUnit or arg_13_3 then
		var_13_0 = arg_13_0._displayTr.position
	end

	ExploreController.instance:dispatchEvent(ExploreEvent.OnCharacterPosChange, var_13_0)
end

function var_0_0.moveTo(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if ExploreModel.instance:isHeroInControl() then
		if ExploreHelper.isPosEqual(arg_14_0.nodePos, arg_14_1) then
			ExploreController.instance:dispatchEvent(ExploreEvent.OnClickHero)
		end

		var_0_0.super.moveTo(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	end
end

function var_0_0.moveToTar(arg_15_0, arg_15_1)
	if ExploreModel.instance:isHeroInControl() then
		local var_15_0 = arg_15_1:getTriggerPos()

		arg_15_0._tarUnitMO = arg_15_1

		arg_15_0:_startMove(var_15_0)
	end
end

function var_0_0.clearTarget(arg_16_0)
	arg_16_0._tarUnitMO = nil
end

function var_0_0.onEndMove(arg_17_0)
	var_0_0.super.onEndMove(arg_17_0)

	if not arg_17_0._tarUnitMO or ExploreHelper.getDistance(arg_17_0._tarUnitMO.nodePos, arg_17_0.nodePos) > 1 then
		-- block empty
	elseif arg_17_0._tarUnitMO.enterTriggerType == false and arg_17_0._tarUnitMO.triggerByClick ~= false and arg_17_0._tarUnitMO:canTrigger(arg_17_0.nodePos) then
		local var_17_0 = ExploreModel.instance:getUseItemUid()
		local var_17_1 = ExploreBackpackModel.instance:getById(var_17_0)

		if var_17_1 and var_17_1.itemEffect == ExploreEnum.ItemEffect.Active and arg_17_0._tarUnitMO.type ~= ExploreEnum.ItemType.Rune then
			ToastController.instance:showToast(ExploreConstValue.Toast.CantTrigger)
		else
			ExploreController.instance:dispatchEvent(ExploreEvent.TryTriggerUnit, arg_17_0._tarUnitMO.id)
		end
	end

	ExploreController.instance:dispatchEvent(ExploreEvent.OnHeroMoveEnd, arg_17_0.nodePos)

	arg_17_0._tarUnitMO = nil
end

function var_0_0.setTilemapPos(arg_18_0, arg_18_1)
	arg_18_0:setPosByNode(arg_18_1)
	arg_18_0:sendMoveRequest(arg_18_0.nodePos)
end

function var_0_0.sendMoveRequest(arg_19_0, arg_19_1)
	return
end

function var_0_0.onMoveTick(arg_20_0)
	arg_20_0:_moving()
end

function var_0_0.updateSceneY(arg_21_0, arg_21_1)
	var_0_0.super.updateSceneY(arg_21_0, arg_21_1)

	local var_21_0 = arg_21_0:getPos()

	ExploreController.instance:dispatchEvent(ExploreEvent.OnCharacterPosChange, var_21_0)
end

function var_0_0._checkAndPutoffPot(arg_22_0)
	local var_22_0 = ExploreModel.instance:getCarryUnit()

	if var_22_0 then
		local var_22_1 = arg_22_0.nodePos
		local var_22_2 = ExploreHelper.dirToXY(arg_22_0.dir)
		local var_22_3 = {
			x = var_22_1.x - var_22_2.x,
			y = var_22_1.y - var_22_2.y
		}
		local var_22_4 = ExploreHelper.getKey(var_22_3)
		local var_22_5 = ExploreMapModel.instance:getNode(var_22_4)

		if not var_22_5 or not var_22_5:isWalkable(nil, true) then
			ToastController.instance:showToast(ExploreConstValue.Toast.ExploreCantPlacePot)

			return
		end

		local var_22_6 = true
		local var_22_7 = ExploreController.instance:getMap():getUnitByPos(var_22_1)

		for iter_22_0, iter_22_1 in pairs(var_22_7) do
			if iter_22_1:isEnter() and not iter_22_1.mo.canUseItem then
				var_22_6 = false

				break
			end
		end

		if not var_22_6 then
			ToastController.instance:showToast(ExploreConstValue.Toast.ExploreCantPlacePot)

			return
		end

		local var_22_8 = var_22_3.x .. "#" .. var_22_3.y

		ExploreRpc.instance:sendExploreInteractRequest(var_22_0.id, 0, var_22_8)

		return true
	end

	return false
end

function var_0_0._startMove(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	arg_23_0._gotoCallback = arg_23_2
	arg_23_0._gotoCallbackObj = arg_23_3
	arg_23_0._endPos = arg_23_1

	local var_23_0 = arg_23_0.nodePos

	if not var_23_0 or ExploreHelper.isPosEqual(var_23_0, arg_23_0._endPos) and not arg_23_0._isMoving then
		if arg_23_0:_checkAndPutoffPot() then
			return
		end

		arg_23_0:_onEndMoveCallback()

		return
	end

	if isDebugBuild and not arg_23_0:isMoving() and UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftShift) and UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) then
		local var_23_1 = ExploreMapModel.instance:getNode(ExploreHelper.getKey(arg_23_1))

		if var_23_1 and var_23_1:isWalkable() then
			arg_23_0:_onEndMoveCallback()
			GMRpc.instance:sendGMRequest("set explore pos " .. ExploreModel.instance:getMapId() .. "#" .. arg_23_1.x .. "#" .. arg_23_1.y)
			arg_23_0:setPosByNode(arg_23_1)
			ExploreMapModel.instance:updatHeroPos(arg_23_1.x, arg_23_1.y, 0)
			ExploreModel.instance:setHeroControl(true)

			return
		end
	end

	if arg_23_0.nodePos and arg_23_1 then
		local var_23_2 = ExploreHelper.getKey(arg_23_0.nodePos)
		local var_23_3 = ExploreMapModel.instance:getNode(var_23_2)
		local var_23_4 = ExploreHelper.getKey(arg_23_1)
		local var_23_5 = ExploreMapModel.instance:getNode(var_23_4)

		if not var_23_3 or not var_23_5 or var_23_3.height ~= var_23_5.height then
			return
		end
	end

	arg_23_0._pathArray = arg_23_0._exploreMap:startFindPath(var_23_0, arg_23_0._endPos, arg_23_0._nextNodePos)

	local var_23_6 = #arg_23_0._pathArray

	if var_23_6 == 0 then
		if not arg_23_0:isMoving() then
			arg_23_0:_onEndMoveCallback()
		elseif arg_23_0._runStartTime <= arg_23_0._runTotalTime / 2 then
			arg_23_0:onCheckDir(arg_23_0._nextNodePos, arg_23_0.nodePos)

			arg_23_0._nextWorldPos, arg_23_0._oldWorldPos = arg_23_0._oldWorldPos, arg_23_0._nextWorldPos
			arg_23_0._runStartTime = arg_23_0._runTotalTime - arg_23_0._runStartTime
			arg_23_0._nextNodePos = arg_23_0.nodePos
		else
			arg_23_0:stopMoving()
		end

		return
	end

	local var_23_7 = arg_23_0._pathArray[1]
	local var_23_8 = true

	if arg_23_0._tarUnitMO then
		var_23_8 = ExploreHelper.getDistance(arg_23_0._tarUnitMO.nodePos, var_23_7) <= 1
	else
		var_23_8 = arg_23_0._endPos.x == var_23_7.x and arg_23_0._endPos.y == var_23_7.y
	end

	if var_23_8 == false then
		arg_23_0:stopMoving()

		return
	end

	arg_23_0._walkDistance = var_23_6

	arg_23_0:_startMove2()
	arg_23_0:onStartMove()
end

function var_0_0.onNodeChange(arg_24_0, arg_24_1, arg_24_2)
	ExploreController.instance:dispatchEvent(ExploreEvent.OnCharacterNodeChange, arg_24_2, arg_24_1, arg_24_0._nextNodePos)

	if arg_24_0:isMoving() then
		arg_24_0:checkMoveAudio()
	end
end

function var_0_0.checkMoveAudio(arg_25_0)
	if not arg_25_0.nodePos then
		return
	end

	local var_25_0 = ExploreHelper.getKey(arg_25_0.nodePos)
	local var_25_1 = ExploreMapModel.instance:getNode(var_25_0)
	local var_25_2 = ExploreEnum.WalkAudioType.Normal

	if var_25_1.nodeType == ExploreEnum.NodeType.Ice then
		var_25_2 = ExploreEnum.WalkAudioType.Ice
	end

	if arg_25_0._playAudioType ~= var_25_2 then
		arg_25_0:stopMoveAudio()

		arg_25_0._playAudioType = var_25_2

		if arg_25_0._playAudioType == ExploreEnum.WalkAudioType.Ice then
			AudioMgr.instance:trigger(AudioEnum.Explore.HeroGlide)
		end

		if arg_25_0._playAudioType == ExploreEnum.WalkAudioType.Normal then
			AudioMgr.instance:trigger(AudioEnum.Explore.HeroWalk)
		end
	end
end

function var_0_0.stopMoveAudio(arg_26_0)
	if arg_26_0._playAudioType == ExploreEnum.WalkAudioType.Ice then
		AudioMgr.instance:trigger(AudioEnum.Explore.HeroGlideStop)
	end

	if arg_26_0._playAudioType == ExploreEnum.WalkAudioType.Normal then
		AudioMgr.instance:trigger(AudioEnum.Explore.HeroWalkStop)
	end
end

function var_0_0.setMoveState(arg_27_0, arg_27_1)
	var_0_0.super.setMoveState(arg_27_0, arg_27_1)

	if arg_27_1 == ExploreAnimEnum.RoleMoveState.Move then
		arg_27_0:checkMoveAudio()
	else
		arg_27_0:stopMoveAudio()

		arg_27_0._playAudioType = ExploreEnum.WalkAudioType.None
	end
end

function var_0_0._startMove2(arg_28_0)
	if arg_28_0._nextWorldPos then
		local var_28_0 = arg_28_0:getPos()
		local var_28_1 = ExploreHelper.tileToPos(arg_28_0._pathArray[#arg_28_0._pathArray])

		var_28_1.y = var_28_0.y

		local var_28_2 = var_28_1 - var_28_0

		var_28_2.y = 0

		local var_28_3 = var_28_2:Normalize()
		local var_28_4 = arg_28_0._nextWorldPos - var_28_0

		var_28_4.y = 0

		local var_28_5 = var_28_4:Normalize()

		if Mathf.Approximately(var_28_3.x, var_28_5.x) and Mathf.Approximately(var_28_3.z, var_28_5.z) or arg_28_0._runStartTime > arg_28_0._runTotalTime / 2 then
			-- block empty
		else
			arg_28_0:onCheckDir(arg_28_0._nextNodePos, arg_28_0.nodePos)

			arg_28_0._nextWorldPos, arg_28_0._oldWorldPos = arg_28_0._oldWorldPos, arg_28_0._nextWorldPos
			arg_28_0._runStartTime = arg_28_0._runTotalTime - arg_28_0._runStartTime
			arg_28_0._nextNodePos = arg_28_0.nodePos
		end
	end

	arg_28_0._isMoving = true

	TaskDispatcher.runRepeat(arg_28_0.onMoveTick, arg_28_0, 0)
	arg_28_0:onMoveTick()
end

function var_0_0._onFrame(arg_29_0)
	do return end

	local var_29_0 = ExploreController.instance:getMap()

	if not var_29_0 then
		return
	end

	if var_29_0:getNowStatus() ~= ExploreEnum.MapStatus.Normal then
		return
	end

	if arg_29_0:isMoving() then
		return
	end

	local var_29_1 = PCInputController.instance
	local var_29_2, var_29_3, var_29_4, var_29_5 = var_29_1:getThirdMoveKey()

	if var_29_1:getKeyPress(var_29_2) then
		local var_29_6 = arg_29_0:RealMoveDir(0)

		if var_29_6 == nil then
			return
		end

		arg_29_0:moveTo(Vector2(arg_29_0.nodePos.x + var_29_6.x, arg_29_0.nodePos.y + var_29_6.y))
	elseif var_29_1:getKeyPress(var_29_4) then
		local var_29_7 = arg_29_0:RealMoveDir(180)

		if var_29_7 == nil then
			return
		end

		arg_29_0:moveTo(Vector2(arg_29_0.nodePos.x + var_29_7.x, arg_29_0.nodePos.y + var_29_7.y))
	elseif var_29_1:getKeyPress(var_29_3) then
		local var_29_8 = arg_29_0:RealMoveDir(270)

		if var_29_8 == nil then
			return
		end

		arg_29_0:moveTo(Vector2(arg_29_0.nodePos.x + var_29_8.x, arg_29_0.nodePos.y + var_29_8.y))
	elseif var_29_1:getKeyPress(var_29_5) then
		local var_29_9 = arg_29_0:RealMoveDir(90)

		if var_29_9 == nil then
			return
		end

		arg_29_0:moveTo(Vector2(arg_29_0.nodePos.x + var_29_9.x, arg_29_0.nodePos.y + var_29_9.y))
	end
end

function var_0_0.RealMoveDir(arg_30_0, arg_30_1)
	local var_30_0 = ExploreMapModel.instance.nowMapRotate

	return ExploreHelper.dirToXY(arg_30_1 + var_30_0)
end

return var_0_0
