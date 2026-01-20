-- chunkname: @modules/logic/scene/fight/comp/FightSceneEntityMgr.lua

module("modules.logic.scene.fight.comp.FightSceneEntityMgr", package.seeall)

local FightSceneEntityMgr = class("FightSceneEntityMgr", BaseSceneUnitMgr)

function FightSceneEntityMgr:ctor(scene)
	self._remainCount = 0

	FightSceneEntityMgr.super.ctor(self, scene)

	self.enableSpineRotate = true
	self._forward = Vector3.New(0, 0, 0)
	self._containerGO = gohelper.findChild(self:getCurScene():getSceneContainerGO(), "Entitys")
end

function FightSceneEntityMgr:getEntityContainer()
	return self._containerGO
end

function FightSceneEntityMgr:onScenePrepared(sceneId, levelId)
	self:removeAllUnits()

	local speed = FightModel.instance:getSpeed()
	local sceneEntityGO1 = gohelper.create3d(self._containerGO, "SceneEntityMy")
	local sceneEntityGO2 = gohelper.create3d(self._containerGO, "SceneEntityEnemy")

	self._sceneEntityMySide = MonoHelper.addLuaComOnceToGo(sceneEntityGO1, FightEntityScene, FightEntityScene.MySideId)
	self._sceneEntityEnemySide = MonoHelper.addLuaComOnceToGo(sceneEntityGO2, FightEntityScene, FightEntityScene.EnemySideId)

	self._sceneEntityMySide:setSpeed(speed)
	self._sceneEntityEnemySide:setSpeed(speed)
	self:addUnit(self._sceneEntityMySide)
	self:addUnit(self._sceneEntityEnemySide)
	self:addASFDUnit()
	self:addVorpalithUnit()

	local mySide = FightDataHelper.entityMgr:getMyNormalList()
	local enemySide = FightDataHelper.entityMgr:getEnemyNormalList()
	local mySideSub = FightDataHelper.entityMgr:getMySubList()

	table.sort(mySideSub, FightEntityDataHelper.sortSubEntityList)

	local mySideSp = FightDataHelper.entityMgr:getSpList(FightEnum.EntitySide.MySide)
	local enemySideSp = FightDataHelper.entityMgr:getSpList(FightEnum.EntitySide.EnemySide)
	local mySideSubCount = #mySideSub > 1 and 1 or #mySideSub

	self._remainCount = #mySide + #enemySide + mySideSubCount + #mySideSp + #enemySideSp

	if self._remainCount == 0 then
		self:dispatchEvent(FightSceneEvent.OnAllEntityLoaded)
	else
		for _, mySideMO in ipairs(mySide) do
			self:buildSpine(mySideMO, FightEnum.EntityCreateStage.Init)
		end

		for _, enemySideMO in ipairs(enemySide) do
			self:buildSpine(enemySideMO, FightEnum.EntityCreateStage.Init)
		end

		if FightEntitySub.Online then
			for _, mySubMO in ipairs(mySideSub) do
				self:buildSubSpine(mySubMO, FightEnum.EntityCreateStage.Init)

				break
			end
		else
			self._remainCount = self._remainCount - mySideSubCount
		end

		for _, mySideSpMO in ipairs(mySideSp) do
			self:buildSpine(mySideSpMO, FightEnum.EntityCreateStage.Init)
		end

		for _, enemySideSpMO in ipairs(enemySideSp) do
			self:buildSpine(enemySideSpMO, FightEnum.EntityCreateStage.Init)
		end

		local assistBoss = FightDataHelper.entityMgr:getAssistBoss()

		if assistBoss then
			self:buildSpine(assistBoss, FightEnum.EntityCreateStage.Init)
		end

		local spFightEntities = FightDataHelper.entityMgr:getSpFightEntities(FightEnum.EntitySide.MySide)

		for i, entityData in ipairs(spFightEntities) do
			self:buildSpine(entityData, FightEnum.EntityCreateStage.Init)
		end

		spFightEntities = FightDataHelper.entityMgr:getSpFightEntities(FightEnum.EntitySide.EnemySide)

		for i, entityData in ipairs(spFightEntities) do
			self:buildSpine(entityData, FightEnum.EntityCreateStage.Init)
		end
	end

	self._up = nil
	self._up = CameraMgr.instance:getUnitCameraTrs().up

	FightController.instance:registerCallback(FightEvent.OnUpdateSpeed, self._onUpdateSpeed, self)

	local transformListener = ZProj.TransformListener.Get(CameraMgr.instance:getUnitCameraGO())

	transformListener:AddPositionCallback(self._adjustSpinesLookRotation, self)
	transformListener:AddRotationCallback(self._adjustSpinesLookRotation, self)
end

function FightSceneEntityMgr:addVorpalithUnit()
	local vorpalithMo = FightDataHelper.entityMgr:getVorpalith()

	if not vorpalithMo then
		return
	end

	local speed = FightModel.instance:getSpeed()
	local entityGo = gohelper.create3d(self._containerGO, "Vorpalith")
	local vorpalithEntity = MonoHelper.addLuaComOnceToGo(entityGo, FightEntityVorpalith, vorpalithMo.id)

	vorpalithEntity:setSpeed(speed)
	self:addUnit(vorpalithEntity)
end

function FightSceneEntityMgr:createRouge2MusicEntity(entityMo)
	if not entityMo then
		return
	end

	local speed = FightModel.instance:getSpeed()
	local entityGo = gohelper.create3d(self._containerGO, "rouge2Music")
	local rouge2MusicEntity = MonoHelper.addLuaComOnceToGo(entityGo, FightEntityRouge2Music, entityMo.id)

	rouge2MusicEntity:setSpeed(speed)
	self:addUnit(rouge2MusicEntity)
end

function FightSceneEntityMgr:addASFDUnit()
	local speed = FightModel.instance:getSpeed()
	local mySideASFDEntityMo = FightDataHelper.entityMgr:getASFDEntityMo(FightEnum.EntitySide.MySide)

	if mySideASFDEntityMo then
		local entity = FightHelper.getEntity(mySideASFDEntityMo.id)

		if not entity then
			local myASFDEntityGo = gohelper.create3d(self._containerGO, "MyASFDEntityGo")

			entity = MonoHelper.addLuaComOnceToGo(myASFDEntityGo, FightEntityASFD, mySideASFDEntityMo.id)

			entity:setSpeed(speed)
			self:addUnit(entity)
		end
	end

	local enemySideASFDEntityMo = FightDataHelper.entityMgr:getASFDEntityMo(FightEnum.EntitySide.EnemySide)

	if enemySideASFDEntityMo then
		local entity = FightHelper.getEntity(enemySideASFDEntityMo.id)

		if not entity then
			local enemyASFDEntityGo = gohelper.create3d(self._containerGO, "EnemyASFDEntityGo")

			entity = MonoHelper.addLuaComOnceToGo(enemyASFDEntityGo, FightEntityASFD, enemySideASFDEntityMo.id)

			entity:setSpeed(speed)
			self:addUnit(entity)
		end
	end
end

function FightSceneEntityMgr:onSceneClose()
	FightSceneEntityMgr.super.onSceneClose(self)
	FightController.instance:unregisterCallback(FightEvent.OnUpdateSpeed, self._onUpdateSpeed, self)

	local transformListener = ZProj.TransformListener.Get(CameraMgr.instance:getUnitCameraGO())

	transformListener:RemovePositionCallback()
	transformListener:RemoveRotationCallback()

	if self._showSubWork then
		self._showSubWork:disposeSelf()

		self._showSubWork = nil
	end
end

function FightSceneEntityMgr:_adjustSpinesLookRotation()
	if not self.enableSpineRotate then
		return
	end

	local cameraPosX, cameraPosY, cameraPosZ = self:_getCameraPos()
	local mySide = self:getTagUnitDict(SceneTag.UnitPlayer)
	local enemySide = self:getTagUnitDict(SceneTag.UnitMonster)

	if mySide then
		for _, entity in pairs(mySide) do
			self:adjustSpineLookRotation(entity)
		end
	end

	if enemySide then
		for _, entity in pairs(enemySide) do
			self:adjustSpineLookRotation(entity)
		end
	end
end

function FightSceneEntityMgr:adjustSpineLookRotation(entity)
	if not self.enableSpineRotate then
		return
	end

	if entity and not gohelper.isNil(entity.go) then
		local entityTr = entity.go.transform
		local mainCameraTrs = CameraMgr.instance:getMainCameraTrs()

		transformhelper.setLocalRotation(entityTr, transformhelper.getLocalRotation(mainCameraTrs))
	end
end

function FightSceneEntityMgr:_getCameraPos()
	local subCameraGO = CameraMgr.instance:getSubCameraGO()

	if subCameraGO.activeInHierarchy then
		return transformhelper.getPos(CameraMgr.instance:getSubCameraTrs())
	end

	return transformhelper.getPos(CameraMgr.instance:getUnitCameraTrs())
end

function FightSceneEntityMgr:_onUpdateSpeed()
	local speed = FightModel.instance:getSpeed()

	for _, entity in pairs(self:getTagUnitDict(SceneTag.UnitPlayer)) do
		entity:setSpeed(speed)
	end

	for _, entity in pairs(self:getTagUnitDict(SceneTag.UnitMonster)) do
		entity:setSpeed(speed)
	end

	for _, entity in pairs(self:getTagUnitDict(SceneTag.UnitNpc)) do
		entity:setSpeed(speed)
	end

	self._sceneEntityMySide:setSpeed(speed)
	self._sceneEntityEnemySide:setSpeed(speed)
end

function FightSceneEntityMgr:compareUpdate(fight, changeWave)
	self._existBuffUidDict = {}

	local mySideMOList = FightDataHelper.entityMgr:getMyNormalList()

	for _, entityMO in ipairs(mySideMOList) do
		self._existBuffUidDict[entityMO.id] = {}

		for _, buffMO in pairs(entityMO:getBuffDic()) do
			self._existBuffUidDict[entityMO.id][buffMO.id] = buffMO
		end
	end

	self._myStancePos2EntityId = {}
	self._enemyStancePos2EntityId = {}

	for _, entity in pairs(self:getTagUnitDict(SceneTag.UnitPlayer)) do
		self._myStancePos2EntityId[entity:getMO().position] = entity.id
	end

	for _, entity in pairs(self:getTagUnitDict(SceneTag.UnitMonster)) do
		self._enemyStancePos2EntityId[entity:getMO().position] = entity.id
	end

	FightModel.instance:updateFight(fight, changeWave)
	self:_rebuildEntity(SceneTag.UnitPlayer, self._myStancePos2EntityId)
	self:_rebuildEntity(SceneTag.UnitMonster, self._enemyStancePos2EntityId)

	mySideMOList = FightDataHelper.entityMgr:getMyNormalList()

	for _, afterEntityMO in ipairs(mySideMOList) do
		local existBuffUidDict = self._existBuffUidDict[afterEntityMO.id]
		local entity = FightHelper.getEntity(afterEntityMO.id)

		if entity and existBuffUidDict then
			for buffUid, buffMO in pairs(existBuffUidDict) do
				if not afterEntityMO:getBuffMO(buffUid) then
					entity.buff:delBuff(buffMO.uid)
				end
			end

			for _, buffMO in ipairs(afterEntityMO:getBuffList()) do
				if not existBuffUidDict[buffMO.id] then
					entity.buff:addBuff(buffMO, true)
				end
			end
		end
	end
end

function FightSceneEntityMgr:changeWave(fight)
	self:compareUpdate(fight, true)
end

function FightSceneEntityMgr:_rebuildEntity(tag, oldStancePos2EntityId)
	for standPos, entityId in pairs(oldStancePos2EntityId) do
		local entityMO = FightDataHelper.entityMgr:getById(entityId)

		if not entityMO or entityMO.position ~= standPos then
			self:removeUnit(tag, entityId)
		end

		if entityMO and not self:getUnit(tag, entityMO.id) then
			if FightDataHelper.entityMgr:isSub(entityId) then
				if FightEntitySub.Online and entityMO.side == FightEnum.EntitySide.MySide then
					self:buildSubSpine(entityMO)
				end
			else
				self:buildSpine(entityMO)
			end
		end
	end

	local side = tag == SceneTag.UnitPlayer and FightEnum.EntitySide.MySide or FightEnum.EntitySide.EnemySide
	local moList = {}

	if side == FightEnum.EntitySide.EnemySide then
		tabletool.addValues(moList, FightDataHelper.entityMgr:getEnemyNormalList())
		tabletool.addValues(moList, FightDataHelper.entityMgr:getEnemySpList())
	else
		moList = FightDataHelper.entityMgr:getNormalList(side)
	end

	for _, entityMO in ipairs(moList) do
		if not self:getUnit(tag, entityMO.id) then
			self:buildSpine(entityMO)
		end
	end

	if FightEntitySub.Online and side == FightEnum.EntitySide.MySide then
		local subMOList = FightDataHelper.entityMgr:getMySubList()
		local hasExist = false

		for _, entityMO in ipairs(subMOList) do
			if self:getUnit(tag, entityMO.id) and self:getEntityByPosId(tag, entityMO.position) then
				hasExist = true
			end
		end

		if not hasExist and subMOList and #subMOList > 0 then
			self:buildSubSpine(subMOList[1])
		end
	end
end

function FightSceneEntityMgr:getEntity(id)
	local tagEntitys = self:getTagUnitDict(SceneTag.UnitPlayer)
	local player = tagEntitys and tagEntitys[id]

	if player then
		return player
	end

	tagEntitys = self:getTagUnitDict(SceneTag.UnitMonster)

	local monster = tagEntitys and tagEntitys[id]

	if monster then
		return monster
	end

	tagEntitys = self:getTagUnitDict(SceneTag.UnitNpc)

	return tagEntitys and tagEntitys[id]
end

function FightSceneEntityMgr:getEntityByPosId(tag, posId)
	local tagEntitys = self:getTagUnitDict(tag)

	if tagEntitys then
		for _, entity in pairs(tagEntitys) do
			if entity:getMO().position == posId then
				return entity
			end
		end
	end
end

function FightSceneEntityMgr:getSpineClass(entityMo)
	local assembledMonsterConfig = lua_fight_assembled_monster.configDict[entityMo.skin]

	if assembledMonsterConfig then
		if assembledMonsterConfig.part == 1 then
			return FightEntityAssembledMonsterMain
		else
			return FightEntityAssembledMonsterSub
		end
	end

	local modelCo = lua_fight_sp_500m_model.configDict[entityMo.modelId]

	if modelCo then
		return FightEntityMonster_500M
	end

	local isMySide = entityMo.side == FightEnum.EntitySide.MySide
	local cls = isMySide and FightEntityPlayer or FightEntityMonster

	return cls
end

function FightSceneEntityMgr:buildSpine(entityMO, createStage)
	if entityMO:isRouge2Music() then
		return self:createRouge2MusicEntity(entityMO, createStage)
	end

	local cls = self:getSpineClass(entityMO)
	local lookDir = FightHelper.getEntitySpineLookDir(entityMO)
	local EntityGOName = entityMO:getIdName()
	local entityGO = gohelper.create3d(self._containerGO, EntityGOName)
	local fightEntity = MonoHelper.addLuaComOnceToGo(entityGO, cls, entityMO.id)

	self:addUnit(fightEntity)
	fightEntity:resetEntity()
	fightEntity:loadSpine(self._onSpineLoaded, self)
	fightEntity.spine:changeLookDir(lookDir)
	fightEntity:setCreateStage(createStage)

	if fightEntity.nameUI then
		fightEntity.nameUI:load(ResUrl.getSceneUIPrefab("fight", "fightname"))
	end

	fightEntity:setSpeed(FightModel.instance:getSpeed())

	return fightEntity
end

function FightSceneEntityMgr:buildSubSpine(entityMO, createStage)
	if not FightEntitySub.Online then
		logError("替补不上线，该方法不应该被调用")
	end

	if entityMO.side == FightEnum.EntitySide.MySide then
		local skinCO = FightConfig.instance:getSkinCO(entityMO.skin)

		if skinCO and not string.nilorempty(skinCO.alternateSpine) then
			local lookDir = FightHelper.getEntitySpineLookDir(entityMO)
			local EntityGOName = entityMO:getIdName()
			local entityGO = gohelper.create3d(self._containerGO, EntityGOName)
			local fightEntity = MonoHelper.addLuaComOnceToGo(entityGO, FightEntitySub, entityMO.id)

			self:addUnit(fightEntity)
			fightEntity:resetEntity()
			fightEntity:loadSpine(self._onSpineLoaded, self)
			fightEntity.spine:changeLookDir(lookDir)
			fightEntity:setSpeed(FightModel.instance:getSpeed())
			fightEntity:setCreateStage(createStage)

			return fightEntity
		else
			logError("can't build sub spine, skin alternateSpine not exist: " .. (entityMO.skin or entityMO.modelId))
			self:_onSpineLoaded()
		end
	else
		logError("can't build enemy sub spine")
	end
end

function FightSceneEntityMgr:_onSpineLoaded(unitSpine, entity)
	if entity:getTag() ~= SceneTag.UnitNpc then
		self._remainCount = self._remainCount - 1

		if self._remainCount == 0 then
			self:dispatchEvent(FightSceneEvent.OnAllEntityLoaded)
		end
	end

	if unitSpine then
		local mat = unitSpine.unitSpawn.spineRenderer:getReplaceMat()

		self:adjustSpineLookRotation(unitSpine.unitSpawn)
		FightGameMgr.bloomMgr:addEntity(entity)
		FightMsgMgr.sendMsg(FightMsgId.SpineLoadFinish, unitSpine)
		FightController.instance:dispatchEvent(FightEvent.OnSpineLoaded, unitSpine)
		FightController.instance:dispatchEvent(FightEvent.OnSpineMaterialChange, entity.id, mat)
	end
end

function FightSceneEntityMgr:showSubEntity()
	if self._showSubWork then
		self._showSubWork:disposeSelf()
	end

	self._showSubWork = FightWorkBuildSubEntityAfterChangeHero.New()

	self._showSubWork:start()
end

function FightSceneEntityMgr:buildTempSpineByName(spineName, specificId, specificSide, mirror, skin, param)
	local id = tostring(specificId)

	id = string.nilorempty(id) and spineName or id

	if self:getEntity(id) then
		id = id .. "_1"
	end

	local entityGO = gohelper.create3d(self._containerGO, id)
	local entity = MonoHelper.addLuaComOnceToGo(entityGO, FightEntityTemp, id)

	if param and param.ingoreRainEffect then
		entity.ingoreRainEffect = true
	end

	local lookDir = mirror and specificSide and FightHelper.getSpineLookDir(specificSide) or SpineLookDir.Left

	entity.spine:changeLookDir(lookDir)
	entity:setSide(specificSide)

	entity.needLookCamera = false

	self:addUnit(entity)

	if skin then
		entity:loadSpineBySkin(skin, self._onTempSpineLoaded, self)
	else
		entity:loadSpine(spineName, self._onTempSpineLoaded, self)
	end

	entity:setSpeed(FightModel.instance:getSpeed())

	return entity
end

function FightSceneEntityMgr:buildTempSpine(spinePath, entityId, side, layer, cls, containerName)
	local goName = containerName

	if not goName then
		local array = FightStrUtil.split(spinePath, "/")

		goName = array[#array]
	end

	local entityGO = gohelper.create3d(self._containerGO, goName)
	local entity = MonoHelper.addLuaComOnceToGo(entityGO, cls or FightEntityTemp, entityId)

	entity.needLookCamera = false

	if layer then
		entity.spine:setLayer(layer, true)
	end

	local lookDir = side == FightEnum.EntitySide.MySide and SpineLookDir.Left or SpineLookDir.Right

	entity.spine:changeLookDir(lookDir)
	entity:setSide(side)
	self:addUnit(entity)
	entity:loadSpineBySpinePath(spinePath, self._onTempSpineLoaded, self)
	entity:setSpeed(FightModel.instance:getSpeed())

	return entity
end

function FightSceneEntityMgr:_onTempSpineLoaded(unitSpine, entity)
	if unitSpine then
		FightGameMgr.bloomMgr:addEntity(entity)
		FightMsgMgr.sendMsg(FightMsgId.SpineLoadFinish, unitSpine)
		FightController.instance:dispatchEvent(FightEvent.OnSpineLoaded, unitSpine)
	end
end

function FightSceneEntityMgr:buildTempSceneEntity(name)
	local id = "Temp_" .. name
	local sceneEntityGO = gohelper.create3d(self._containerGO, id)
	local entity = MonoHelper.addLuaComOnceToGo(sceneEntityGO, FightEntityScene, id)

	entity:setSpeed(FightModel.instance:getSpeed())
	self:addUnit(entity)

	return entity
end

function FightSceneEntityMgr:destroyUnit(unit)
	if unit.IS_REMOVED then
		return
	end

	unit.IS_REMOVED = true

	if FightSkillMgr.instance:isEntityPlayingTimeline(unit.id) then
		FightSkillMgr.instance:afterTimeline(unit)
	end

	FightController.instance:dispatchEvent(FightEvent.BeforeDestroyEntity, unit)
	FightSceneEntityMgr.super.destroyUnit(self, unit)
end

return FightSceneEntityMgr
