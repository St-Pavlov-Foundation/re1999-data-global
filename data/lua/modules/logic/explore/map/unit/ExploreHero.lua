module("modules.logic.explore.map.unit.ExploreHero", package.seeall)

slot0 = class("ExploreHero", Explore3DRoleBase)

function slot0.onInit(slot0)
	slot0._hangPoints = {}
	slot0._baton = UnityEngine.GameObject.New("baton")

	gohelper.setActive(slot0._baton, false)

	slot0._batonLoader = PrefabInstantiate.Create(slot0._baton)

	slot0._batonLoader:startLoad("explore/roles/prefabs/zhihuibang.prefab", slot0._onBatonLoadEnd, slot0)
	uv0.super.onInit(slot0)
end

function slot0._onBatonLoadEnd(slot0)
	slot0._batonEffectLoader = PrefabInstantiate.Create(slot0._batonLoader:getInstGO().transform:Find("zhihuibang/Point001").gameObject)

	slot0._batonEffectLoader:startLoad(ResUrl.getExploreEffectPath("open_chest"))
end

function slot0.onDestroy(slot0)
	if slot0._batonLoader then
		slot0._batonLoader:dispose()

		slot0._batonLoader = nil
	end

	if slot0._batonEffectLoader then
		slot0._batonEffectLoader:dispose()

		slot0._batonEffectLoader = nil
	end

	gohelper.destroy(slot0._baton)

	slot0._hangPoints = nil

	uv0.super.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._onFrame, slot0)
end

function slot0.setHeroStatus(slot0, slot1, ...)
	if slot0._hangPoints[ExploreAnimEnum.UseBatonAnim[slot1]] then
		slot0._baton.transform:SetParent(slot3, false)
		gohelper.setActive(slot0._baton, true)
	else
		gohelper.setActive(slot0._baton, false)
	end

	uv0.super.setHeroStatus(slot0, slot1, ...)
	ExploreController.instance:dispatchEvent(ExploreEvent.HeroStatuStart, slot1)
end

function slot0.delaySetNormalStatus(slot0, ...)
	ExploreController.instance:dispatchEvent(ExploreEvent.HeroStatuEnd, slot0._curStatus)
	gohelper.setActive(slot0._baton, false)

	if not ExploreModel.instance.isRoleInitDone then
		ExploreModel.instance.isRoleInitDone = true

		ExploreController.instance:dispatchEvent(ExploreEvent.HeroResInitDone)
	end

	uv0.super.delaySetNormalStatus(slot0, ...)
end

function slot0.setResPath(slot0, slot1)
	if slot1 and slot0._resPath ~= slot1 then
		slot0._resPath = slot1
		slot0._assetId = ResMgr.getAbAsset(slot0._resPath, slot0._onResLoaded, slot0, slot0._assetId)
	elseif slot1 and slot0._resPath == slot1 and slot0._displayGo == nil then
		slot0._assetId = ResMgr.getAbAsset(slot0._resPath, slot0._onResLoaded, slot0, slot0._assetId)
	else
		slot0:onResLoaded()
	end
end

function slot0.onResLoaded(slot0)
	slot0._hangPoints = {}

	for slot4, slot5 in pairs(ExploreAnimEnum.RoleHangPointPath) do
		slot0._hangPoints[slot4] = slot0._displayTr:Find(slot5)
	end

	if ExploreModel.instance.isFirstEnterMap == ExploreEnum.EnterMode.First then
		slot0:setActive(false)
	else
		slot0.dir = ExploreMapModel.instance:getHeroDir()

		slot0:setRotate(0, slot0.dir, 0)
	end

	if ExploreMapModel.instance:getNode(ExploreHelper.getKey(slot0.nodePos)) and slot0.position.y ~= slot1.height then
		slot0.position.y = slot1.height

		transformhelper.setPos(slot0.trans, slot0.position.x, slot1.height, slot0.position.z)
		ExploreController.instance:dispatchEvent(ExploreEvent.OnCharacterPosChange, slot0.position)
	end

	if slot0._waitAssetLoaded then
		slot0._waitAssetLoaded = nil

		slot0:onRoleFirstEnter()
	end
end

function slot0.onRoleFirstEnter(slot0)
	if not slot0._displayTr then
		slot0._waitAssetLoaded = true

		return
	end

	slot0:setActive(true)

	if ExploreModel.instance:hasUseItemOrUnit() then
		ExploreModel.instance.isRoleInitDone = true

		ExploreController.instance:dispatchEvent(ExploreEvent.HeroResInitDone)

		return
	end

	slot0.dir = ExploreMapModel.instance:getHeroDir()
	slot6 = 0

	slot0:setRotate(0, slot0.dir, slot6)

	slot1 = false

	for slot6, slot7 in pairs(ExploreController.instance:getMap():getUnitByPos(slot0.nodePos)) do
		if slot7:getUnitType() == ExploreEnum.ItemType.Spike then
			slot1 = true

			break
		end
	end

	if slot1 then
		return
	end

	if ExploreModel.instance.isFirstEnterMap ~= ExploreEnum.EnterMode.First then
		ExploreModel.instance.isRoleInitDone = true

		ExploreController.instance:dispatchEvent(ExploreEvent.HeroResInitDone)
		ExploreController.instance:dispatchEvent(ExploreEvent.HeroFirstAnimEnd)

		return
	end

	slot0:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.Entry, true, true)
	ExploreController.instance:dispatchEvent(ExploreEvent.HeroFirstAnimEnd)
end

function slot0.onUpdateExploreInfo(slot0)
	slot0.go:SetActive(true)

	slot1, slot2 = ExploreMapModel.instance:getHeroPos()

	slot0:setTilemapPos(Vector2(slot1, slot2))
end

function slot0.setMap(slot0, slot1)
	slot0._exploreMap = slot1
end

function slot0.getHangTrans(slot0, slot1)
	return slot0._hangPoints[slot1]
end

function slot0.onStartMove(slot0, slot1, slot2)
	ExploreController.instance:dispatchEvent(ExploreEvent.OnCharacterStartMove, slot0.nodePos, slot0._nextNodePos)
end

function slot0.setPos(slot0, slot1, slot2, slot3)
	uv0.super.setPos(slot0, slot1, true)

	slot4 = slot0:getPos()

	if ExploreController.instance:getMap():getNowStatus() == ExploreEnum.MapStatus.MoveUnit or slot3 then
		slot4 = slot0._displayTr.position
	end

	ExploreController.instance:dispatchEvent(ExploreEvent.OnCharacterPosChange, slot4)
end

function slot0.moveTo(slot0, slot1, slot2, slot3)
	if ExploreModel.instance:isHeroInControl() then
		if ExploreHelper.isPosEqual(slot0.nodePos, slot1) then
			ExploreController.instance:dispatchEvent(ExploreEvent.OnClickHero)
		end

		uv0.super.moveTo(slot0, slot1, slot2, slot3)
	end
end

function slot0.moveToTar(slot0, slot1)
	if ExploreModel.instance:isHeroInControl() then
		slot0._tarUnitMO = slot1

		slot0:_startMove(slot1:getTriggerPos())
	end
end

function slot0.clearTarget(slot0)
	slot0._tarUnitMO = nil
end

function slot0.onEndMove(slot0)
	uv0.super.onEndMove(slot0)

	if slot0._tarUnitMO then
		if ExploreHelper.getDistance(slot0._tarUnitMO.nodePos, slot0.nodePos) > 1 then
			-- Nothing
		elseif slot0._tarUnitMO.enterTriggerType == false and slot0._tarUnitMO.triggerByClick ~= false and slot0._tarUnitMO:canTrigger(slot0.nodePos) then
			if ExploreBackpackModel.instance:getById(ExploreModel.instance:getUseItemUid()) and slot2.itemEffect == ExploreEnum.ItemEffect.Active and slot0._tarUnitMO.type ~= ExploreEnum.ItemType.Rune then
				ToastController.instance:showToast(ExploreConstValue.Toast.CantTrigger)
			else
				ExploreController.instance:dispatchEvent(ExploreEvent.TryTriggerUnit, slot0._tarUnitMO.id)
			end
		end
	end

	ExploreController.instance:dispatchEvent(ExploreEvent.OnHeroMoveEnd, slot0.nodePos)

	slot0._tarUnitMO = nil
end

function slot0.setTilemapPos(slot0, slot1)
	slot0:setPosByNode(slot1)
	slot0:sendMoveRequest(slot0.nodePos)
end

function slot0.sendMoveRequest(slot0, slot1)
end

function slot0.onMoveTick(slot0)
	slot0:_moving()
end

function slot0.updateSceneY(slot0, slot1)
	uv0.super.updateSceneY(slot0, slot1)
	ExploreController.instance:dispatchEvent(ExploreEvent.OnCharacterPosChange, slot0:getPos())
end

function slot0._checkAndPutoffPot(slot0)
	if ExploreModel.instance:getCarryUnit() then
		slot2 = slot0.nodePos
		slot3 = ExploreHelper.dirToXY(slot0.dir)

		if not ExploreMapModel.instance:getNode(ExploreHelper.getKey({
			x = slot2.x - slot3.x,
			y = slot2.y - slot3.y
		})) or not slot6:isWalkable(nil, true) then
			ToastController.instance:showToast(ExploreConstValue.Toast.ExploreCantPlacePot)

			return
		end

		slot7 = true

		for slot12, slot13 in pairs(ExploreController.instance:getMap():getUnitByPos(slot2)) do
			if slot13:isEnter() and not slot13.mo.canUseItem then
				slot7 = false

				break
			end
		end

		if not slot7 then
			ToastController.instance:showToast(ExploreConstValue.Toast.ExploreCantPlacePot)

			return
		end

		ExploreRpc.instance:sendExploreInteractRequest(slot1.id, 0, slot4.x .. "#" .. slot4.y)

		return true
	end

	return false
end

function slot0._startMove(slot0, slot1, slot2, slot3)
	slot0._gotoCallback = slot2
	slot0._gotoCallbackObj = slot3
	slot0._endPos = slot1

	if not slot0.nodePos or ExploreHelper.isPosEqual(slot4, slot0._endPos) and not slot0._isMoving then
		if slot0:_checkAndPutoffPot() then
			return
		end

		slot0:_onEndMoveCallback()

		return
	end

	if isDebugBuild and not slot0:isMoving() and UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftShift) and UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) and ExploreMapModel.instance:getNode(ExploreHelper.getKey(slot1)) and slot5:isWalkable() then
		slot0:_onEndMoveCallback()
		GMRpc.instance:sendGMRequest("set explore pos " .. ExploreModel.instance:getMapId() .. "#" .. slot1.x .. "#" .. slot1.y)
		slot0:setPosByNode(slot1)
		ExploreMapModel.instance:updatHeroPos(slot1.x, slot1.y, 0)
		ExploreModel.instance:setHeroControl(true)

		return
	end

	if slot0.nodePos and slot1 then
		slot8 = ExploreMapModel.instance:getNode(ExploreHelper.getKey(slot1))

		if not ExploreMapModel.instance:getNode(ExploreHelper.getKey(slot0.nodePos)) or not slot8 or slot6.height ~= slot8.height then
			return
		end
	end

	slot0._pathArray = slot0._exploreMap:startFindPath(slot4, slot0._endPos, slot0._nextNodePos)

	if #slot0._pathArray == 0 then
		if not slot0:isMoving() then
			slot0:_onEndMoveCallback()
		elseif slot0._runStartTime <= slot0._runTotalTime / 2 then
			slot0:onCheckDir(slot0._nextNodePos, slot0.nodePos)

			slot0._oldWorldPos = slot0._nextWorldPos
			slot0._nextWorldPos = slot0._oldWorldPos
			slot0._runStartTime = slot0._runTotalTime - slot0._runStartTime
			slot0._nextNodePos = slot0.nodePos
		else
			slot0:stopMoving()
		end

		return
	end

	slot6 = slot0._pathArray[1]
	slot7 = true

	if (slot0._tarUnitMO and ExploreHelper.getDistance(slot0._tarUnitMO.nodePos, slot6) <= 1 or slot0._endPos.x == slot6.x and slot0._endPos.y == slot6.y) == false then
		slot0:stopMoving()

		return
	end

	slot0._walkDistance = slot5

	slot0:_startMove2()
	slot0:onStartMove()
end

function slot0.onNodeChange(slot0, slot1, slot2)
	ExploreController.instance:dispatchEvent(ExploreEvent.OnCharacterNodeChange, slot2, slot1, slot0._nextNodePos)

	if slot0:isMoving() then
		slot0:checkMoveAudio()
	end
end

function slot0.checkMoveAudio(slot0)
	if not slot0.nodePos then
		return
	end

	slot3 = ExploreEnum.WalkAudioType.Normal

	if ExploreMapModel.instance:getNode(ExploreHelper.getKey(slot0.nodePos)).nodeType == ExploreEnum.NodeType.Ice then
		slot3 = ExploreEnum.WalkAudioType.Ice
	end

	if slot0._playAudioType ~= slot3 then
		slot0:stopMoveAudio()

		slot0._playAudioType = slot3

		if slot0._playAudioType == ExploreEnum.WalkAudioType.Ice then
			AudioMgr.instance:trigger(AudioEnum.Explore.HeroGlide)
		end

		if slot0._playAudioType == ExploreEnum.WalkAudioType.Normal then
			AudioMgr.instance:trigger(AudioEnum.Explore.HeroWalk)
		end
	end
end

function slot0.stopMoveAudio(slot0)
	if slot0._playAudioType == ExploreEnum.WalkAudioType.Ice then
		AudioMgr.instance:trigger(AudioEnum.Explore.HeroGlideStop)
	end

	if slot0._playAudioType == ExploreEnum.WalkAudioType.Normal then
		AudioMgr.instance:trigger(AudioEnum.Explore.HeroWalkStop)
	end
end

function slot0.setMoveState(slot0, slot1)
	uv0.super.setMoveState(slot0, slot1)

	if slot1 == ExploreAnimEnum.RoleMoveState.Move then
		slot0:checkMoveAudio()
	else
		slot0:stopMoveAudio()

		slot0._playAudioType = ExploreEnum.WalkAudioType.None
	end
end

function slot0._startMove2(slot0)
	if slot0._nextWorldPos then
		slot1 = slot0:getPos()
		slot2 = ExploreHelper.tileToPos(slot0._pathArray[#slot0._pathArray])
		slot2.y = slot1.y
		slot3 = slot2 - slot1
		slot3.y = 0
		slot5 = slot0._nextWorldPos - slot1
		slot5.y = 0

		if not Mathf.Approximately(slot3:Normalize().x, slot5:Normalize().x) or not Mathf.Approximately(slot4.z, slot6.z) then
			if slot0._runStartTime <= slot0._runTotalTime / 2 then
				slot0:onCheckDir(slot0._nextNodePos, slot0.nodePos)

				slot0._oldWorldPos = slot0._nextWorldPos
				slot0._nextWorldPos = slot0._oldWorldPos
				slot0._runStartTime = slot0._runTotalTime - slot0._runStartTime
				slot0._nextNodePos = slot0.nodePos
			end
		end
	end

	slot0._isMoving = true

	TaskDispatcher.runRepeat(slot0.onMoveTick, slot0, 0)
	slot0:onMoveTick()
end

function slot0._onFrame(slot0)
	return

	if not ExploreController.instance:getMap() then
		return
	end

	if slot1:getNowStatus() ~= ExploreEnum.MapStatus.Normal then
		return
	end

	if slot0:isMoving() then
		return
	end

	slot2 = PCInputController.instance
	slot3, slot4, slot5, slot6 = slot2:getThirdMoveKey()

	if slot2:getKeyPress(slot3) then
		if slot0:RealMoveDir(0) == nil then
			return
		end

		slot0:moveTo(Vector2(slot0.nodePos.x + slot7.x, slot0.nodePos.y + slot7.y))
	elseif slot2:getKeyPress(slot5) then
		if slot0:RealMoveDir(180) == nil then
			return
		end

		slot0:moveTo(Vector2(slot0.nodePos.x + slot7.x, slot0.nodePos.y + slot7.y))
	elseif slot2:getKeyPress(slot4) then
		if slot0:RealMoveDir(270) == nil then
			return
		end

		slot0:moveTo(Vector2(slot0.nodePos.x + slot7.x, slot0.nodePos.y + slot7.y))
	elseif slot2:getKeyPress(slot6) then
		if slot0:RealMoveDir(90) == nil then
			return
		end

		slot0:moveTo(Vector2(slot0.nodePos.x + slot7.x, slot0.nodePos.y + slot7.y))
	end
end

function slot0.RealMoveDir(slot0, slot1)
	return ExploreHelper.dirToXY(slot1 + ExploreMapModel.instance.nowMapRotate)
end

return slot0
