module("modules.logic.scene.fight.comp.FightSceneEntityMgr", package.seeall)

slot0 = class("FightSceneEntityMgr", BaseSceneUnitMgr)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)

	slot0.enableSpineRotate = true
	slot0._forward = Vector3.New(0, 0, 0)
	slot0._containerGO = gohelper.findChild(slot0:getCurScene():getSceneContainerGO(), "Entitys")
end

function slot0.getEntityContainer(slot0)
	return slot0._containerGO
end

function slot0.onScenePrepared(slot0, slot1, slot2)
	slot3 = FightModel.instance:getSpeed()
	slot0._sceneEntityMySide = MonoHelper.addLuaComOnceToGo(gohelper.create3d(slot0._containerGO, "SceneEntityMy"), FightEntityScene, FightEntityScene.MySideId)
	slot0._sceneEntityEnemySide = MonoHelper.addLuaComOnceToGo(gohelper.create3d(slot0._containerGO, "SceneEntityEnemy"), FightEntityScene, FightEntityScene.EnemySideId)

	slot0._sceneEntityMySide:setSpeed(slot3)
	slot0._sceneEntityEnemySide:setSpeed(slot3)
	slot0:addUnit(slot0._sceneEntityMySide)
	slot0:addUnit(slot0._sceneEntityEnemySide)

	slot8 = FightEntityModel.instance:getSubModel(FightEnum.EntitySide.MySide):getList()

	table.sort(slot8, FightEntityModel.sortSubEntityList)

	slot0._remainCount = #FightEntityModel.instance:getMySideList() + #FightEntityModel.instance:getEnemySideList() + (#slot8 > 1 and 1 or #slot8) + #FightEntityModel.instance:getSpModel(FightEnum.EntitySide.MySide):getList() + #FightEntityModel.instance:getSpModel(FightEnum.EntitySide.EnemySide):getList()

	if slot0._remainCount == 0 then
		slot0:dispatchEvent(FightSceneEvent.OnAllEntityLoaded)
	else
		for slot15, slot16 in ipairs(slot6) do
			slot0:buildSpine(slot16)
		end

		for slot15, slot16 in ipairs(slot7) do
			slot0:buildSpine(slot16)
		end

		if FightEntitySub.Online then
			for slot15, slot16 in ipairs(slot8) do
				slot0:buildSubSpine(slot16)

				break
			end
		else
			slot0._remainCount = slot0._remainCount - slot11
		end

		for slot15, slot16 in ipairs(slot9) do
			slot0:buildSpine(slot16)
		end

		for slot15, slot16 in ipairs(slot10) do
			slot0:buildSpine(slot16)
		end
	end

	slot0._up = nil
	slot0._up = CameraMgr.instance:getUnitCameraTrs().up

	FightController.instance:registerCallback(FightEvent.OnUpdateSpeed, slot0._onUpdateSpeed, slot0)

	slot12 = ZProj.TransformListener.Get(CameraMgr.instance:getUnitCameraGO())

	slot12:AddPositionCallback(slot0._adjustSpinesLookRotation, slot0)
	slot12:AddRotationCallback(slot0._adjustSpinesLookRotation, slot0)
end

function slot0.onSceneClose(slot0)
	uv0.super.onSceneClose(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnUpdateSpeed, slot0._onUpdateSpeed, slot0)

	slot1 = ZProj.TransformListener.Get(CameraMgr.instance:getUnitCameraGO())

	slot1:RemovePositionCallback()
	slot1:RemoveRotationCallback()

	if slot0._showSubWork then
		slot0._showSubWork:disposeSelf()

		slot0._showSubWork = nil
	end
end

function slot0._adjustSpinesLookRotation(slot0)
	if not slot0.enableSpineRotate then
		return
	end

	slot1, slot2, slot3 = slot0:_getCameraPos()
	slot5 = slot0:getTagUnitDict(SceneTag.UnitMonster)

	if slot0:getTagUnitDict(SceneTag.UnitPlayer) then
		for slot9, slot10 in pairs(slot4) do
			slot0:adjustSpineLookRotation(slot10)
		end
	end

	if slot5 then
		for slot9, slot10 in pairs(slot5) do
			slot0:adjustSpineLookRotation(slot10)
		end
	end
end

function slot0.adjustSpineLookRotation(slot0, slot1)
	if not slot0.enableSpineRotate then
		return
	end

	if slot1 and not gohelper.isNil(slot1.go) then
		transformhelper.setLocalRotation(slot1.go.transform, transformhelper.getLocalRotation(CameraMgr.instance:getMainCameraTrs()))
	end
end

function slot0._getCameraPos(slot0)
	if CameraMgr.instance:getSubCameraGO().activeInHierarchy then
		return transformhelper.getPos(CameraMgr.instance:getSubCameraTrs())
	end

	return transformhelper.getPos(CameraMgr.instance:getUnitCameraTrs())
end

function slot0._onUpdateSpeed(slot0)
	slot5 = SceneTag.UnitPlayer

	for slot5, slot6 in pairs(slot0:getTagUnitDict(slot5)) do
		slot6:setSpeed(FightModel.instance:getSpeed())
	end

	slot5 = SceneTag.UnitMonster

	for slot5, slot6 in pairs(slot0:getTagUnitDict(slot5)) do
		slot6:setSpeed(slot1)
	end

	slot5 = SceneTag.UnitNpc

	for slot5, slot6 in pairs(slot0:getTagUnitDict(slot5)) do
		slot6:setSpeed(slot1)
	end

	slot0._sceneEntityMySide:setSpeed(slot1)
	slot0._sceneEntityEnemySide:setSpeed(slot1)
end

function slot0.compareUpdate(slot0, slot1, slot2)
	slot0._existBuffUidDict = {}

	for slot7, slot8 in ipairs(FightEntityModel.instance:getMySideList()) do
		slot0._existBuffUidDict[slot8.id] = {}

		for slot13, slot14 in ipairs(slot8.buffModel:getList()) do
			slot0._existBuffUidDict[slot8.id][slot14.id] = slot14
		end
	end

	slot0._myStancePos2EntityId = {}
	slot0._enemyStancePos2EntityId = {}
	slot7 = SceneTag.UnitPlayer

	for slot7, slot8 in pairs(slot0:getTagUnitDict(slot7)) do
		slot0._myStancePos2EntityId[slot8:getMO().position] = slot8.id
	end

	slot7 = SceneTag.UnitMonster

	for slot7, slot8 in pairs(slot0:getTagUnitDict(slot7)) do
		slot0._enemyStancePos2EntityId[slot8:getMO().position] = slot8.id
	end

	FightModel.instance:updateFight(slot1, slot2)
	slot0:_rebuildEntity(SceneTag.UnitPlayer, slot0._myStancePos2EntityId)

	slot7 = slot0._enemyStancePos2EntityId

	slot0:_rebuildEntity(SceneTag.UnitMonster, slot7)

	for slot7, slot8 in ipairs(FightEntityModel.instance:getMySideList()) do
		slot9 = slot0._existBuffUidDict[slot8.id]
		slot10 = slot8.buffModel

		if FightHelper.getEntity(slot8.id) and slot9 then
			for slot15, slot16 in pairs(slot9) do
				if not slot10:getById(slot15) then
					slot11.buff:delBuff(slot16)
				end
			end

			for slot15, slot16 in ipairs(slot10:getList()) do
				if not slot9[slot16.id] then
					slot11.buff:addBuff(slot16, true)
				end
			end
		end
	end
end

function slot0.changeWave(slot0, slot1)
	slot0:compareUpdate(slot1, true)
end

function slot0._rebuildEntity(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot2) do
		if not FightEntityModel.instance:getById(slot7) or slot8.position ~= slot6 then
			slot0:removeUnit(slot1, slot7)
		end

		if slot8 and not slot0:getUnit(slot1, slot8.id) then
			if FightEntityModel.instance:isSub(slot7) then
				if FightEntitySub.Online and slot8.side == FightEnum.EntitySide.MySide then
					slot0:buildSubSpine(slot8)
				end
			else
				slot0:buildSpine(slot8)
			end
		end
	end

	slot3 = slot1 == SceneTag.UnitPlayer and FightEnum.EntitySide.MySide or FightEnum.EntitySide.EnemySide

	for slot8, slot9 in ipairs(FightEntityModel.instance:getModel(slot3):getList()) do
		if not slot0:getUnit(slot1, slot9.id) then
			slot0:buildSpine(slot9)
		end
	end

	if FightEntitySub.Online and slot3 == FightEnum.EntitySide.MySide then
		slot6 = false

		for slot10, slot11 in ipairs(FightEntityModel.instance:getSubModel(slot3):getList()) do
			if slot0:getUnit(slot1, slot11.id) and slot0:getEntityByPosId(slot1, slot11.position) then
				slot6 = true
			end
		end

		if not slot6 and slot5 and #slot5 > 0 then
			slot0:buildSubSpine(slot5[1])
		end
	end

	for slot9, slot10 in ipairs(FightEntityModel.instance:getSpModel(slot3):getList()) do
		if not slot0:getUnit(slot1, slot10.id) then
			slot0:buildSpine(slot10)
		end
	end
end

function slot0.getEntity(slot0, slot1)
	if slot0:getTagUnitDict(SceneTag.UnitPlayer) and slot2[slot1] then
		return slot3
	end

	if slot0:getTagUnitDict(SceneTag.UnitMonster) and slot2[slot1] then
		return slot4
	end

	return slot0:getTagUnitDict(SceneTag.UnitNpc) and slot2[slot1]
end

function slot0.getEntityByPosId(slot0, slot1, slot2)
	if slot0:getTagUnitDict(slot1) then
		for slot7, slot8 in pairs(slot3) do
			if slot8:getMO().position == slot2 then
				return slot8
			end
		end
	end
end

function slot0.buildSpine(slot0, slot1)
	slot3 = slot1.side == FightEnum.EntitySide.MySide and FightEntityPlayer or FightEntityMonster

	if lua_fight_assembled_monster.configDict[slot1.skin] then
		slot3 = (slot4.part ~= 1 or FightEntityAssembledMonsterMain) and FightEntityAssembledMonsterSub
	end

	slot8 = MonoHelper.addLuaComOnceToGo(gohelper.create3d(slot0._containerGO, slot1:getIdName()), slot3, slot1.id)

	slot0:addUnit(slot8)
	slot8:resetEntity()
	slot8:loadSpine(slot0._onSpineLoaded, slot0)
	slot8.spine:changeLookDir(FightHelper.getEntitySpineLookDir(slot1))
	slot8.nameUI:load(ResUrl.getSceneUIPrefab("fight", "fightname"))
	slot8:setSpeed(FightModel.instance:getSpeed())

	return slot8
end

function slot0.buildSubSpine(slot0, slot1)
	if not FightEntitySub.Online then
		logError("替补不上线，该方法不应该被调用")
	end

	if slot1.side == FightEnum.EntitySide.MySide then
		if FightConfig.instance:getSkinCO(slot1.skin) and not string.nilorempty(slot2.alternateSpine) then
			slot6 = MonoHelper.addLuaComOnceToGo(gohelper.create3d(slot0._containerGO, slot1:getIdName()), FightEntitySub, slot1.id)

			slot0:addUnit(slot6)
			slot6:resetEntity()
			slot6:loadSpine(slot0._onSpineLoaded, slot0)
			slot6.spine:changeLookDir(FightHelper.getEntitySpineLookDir(slot1))
			slot6:setSpeed(FightModel.instance:getSpeed())

			return slot6
		else
			logError("can't build sub spine, skin alternateSpine not exist: " .. (slot1.skin or slot1.modelId))
			slot0:_onSpineLoaded()
		end
	else
		logError("can't build enemy sub spine")
	end
end

function slot0._onSpineLoaded(slot0, slot1, slot2)
	if slot2:getTag() ~= SceneTag.UnitNpc then
		slot0._remainCount = slot0._remainCount - 1

		if slot0._remainCount == 0 then
			slot0:dispatchEvent(FightSceneEvent.OnAllEntityLoaded)
		end
	end

	if slot1 then
		slot0:adjustSpineLookRotation(slot1.unitSpawn)
		GameSceneMgr.instance:getCurScene().bloom:addEntity(slot2)
		FightController.instance:dispatchEvent(FightEvent.OnSpineLoaded, slot1)
		FightController.instance:dispatchEvent(FightEvent.OnSpineMaterialChange, slot2.id, slot1.unitSpawn.spineRenderer:getReplaceMat())
	end
end

function slot0.showSubEntity(slot0)
	if slot0._showSubWork then
		slot0._showSubWork:disposeSelf()
	end

	slot0._showSubWork = FightWorkBuildSubEntityAfterChangeHero.New()

	slot0._showSubWork:start()
end

function slot0.buildTempSpineByName(slot0, slot1, slot2, slot3, slot4, slot5)
	if string.nilorempty(tostring(slot2)) then
		slot6 = slot1 or slot6
	end

	if slot0:getEntity(slot6) then
		slot6 = slot6 .. "_1"
	end

	slot8 = MonoHelper.addLuaComOnceToGo(gohelper.create3d(slot0._containerGO, slot6), FightEntityTemp, slot6)

	slot8.spine:changeLookDir(slot4 and slot3 and FightHelper.getSpineLookDir(slot3) or SpineLookDir.Left)
	slot8:setSide(slot3)

	slot8.needLookCamera = false

	slot0:addUnit(slot8)

	if slot5 then
		slot8:loadSpineBySkin(slot5, slot0._onTempSpineLoaded, slot0)
	else
		slot8:loadSpine(slot1, slot0._onTempSpineLoaded, slot0)
	end

	slot8:setSpeed(FightModel.instance:getSpeed())

	return slot8
end

function slot0._onTempSpineLoaded(slot0, slot1, slot2)
	if slot1 then
		GameSceneMgr.instance:getCurScene().bloom:addEntity(slot2)
		FightController.instance:dispatchEvent(FightEvent.OnSpineLoaded, slot1)
	end
end

function slot0.buildTempSceneEntity(slot0, slot1)
	slot2 = "Temp_" .. slot1
	slot4 = MonoHelper.addLuaComOnceToGo(gohelper.create3d(slot0._containerGO, slot2), FightEntityScene, slot2)

	slot4:setSpeed(FightModel.instance:getSpeed())
	slot0:addUnit(slot4)

	return slot4
end

function slot0.destroyUnit(slot0, slot1)
	if FightSkillMgr.instance:isEntityPlayingTimeline(slot1.id) then
		FightSkillMgr.instance:afterTimeline(slot1)
	end

	FightController.instance:dispatchEvent(FightEvent.BeforeDestroyEntity, slot1)
	uv0.super.destroyUnit(slot0, slot1)
end

return slot0
