-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/comp/ArcadeEntityMgr.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.comp.ArcadeEntityMgr", package.seeall)

local ArcadeEntityMgr = class("ArcadeEntityMgr", ArcadeBaseSceneComp)

function ArcadeEntityMgr:onInit()
	self:clearAllEntity(true)
	transformhelper.setLocalPos(self.trans, 0, 0, ArcadeGameEnum.Const.EntityZLevel)
end

function ArcadeEntityMgr:onPreGameStart()
	self:createCharacterEntity()
end

function ArcadeEntityMgr:createCharacterEntity()
	local characterMO = ArcadeGameModel.instance:getCharacterMO()
	local resPath = characterMO:getRes()

	self._scene.loader:loadRes(resPath, self._onLoadCharacterEntity, self)
end

function ArcadeEntityMgr:_onLoadCharacterEntity()
	local characterMO = ArcadeGameModel.instance:getCharacterMO()
	local loadingCharacterId = characterMO:getId()
	local resPath = characterMO and characterMO:getRes()
	local characterAssetRes = self._scene.loader:getResource(resPath)

	if characterAssetRes then
		local goCharacter = gohelper.clone(characterAssetRes, self.go, string.format("character-%s", loadingCharacterId))

		self._characterEntity = MonoHelper.addNoUpdateLuaComOnceToGo(goCharacter, ArcadeGameCharacterEntity, {
			id = loadingCharacterId
		})
	end

	ArcadeGameController.instance:dispatchEvent(ArcadeEvent.OnLoadFinishGameCharacter)
end

function ArcadeEntityMgr:clearAllEntity(includeCharacter)
	local curRoom = self._scene and self._scene.roomMgr:getCurRoom()

	if includeCharacter then
		if self._characterEntity then
			if curRoom then
				local mo = self._characterEntity:getMO()

				curRoom:removeEntityOccupyGrids(mo)
			end

			self._characterEntity:destroy()
		end

		self._characterEntity = nil
	end

	if self._entityDict then
		for _, dict in pairs(self._entityDict) do
			for _, entity in pairs(dict) do
				if curRoom then
					local mo = entity:getMO()

					curRoom:removeEntityOccupyGrids(mo)
				end

				entity:destroy()
			end
		end
	end

	self._entityDict = {}
end

function ArcadeEntityMgr:addEventListeners()
	return
end

function ArcadeEntityMgr:removeEventListeners()
	return
end

function ArcadeEntityMgr:addEntityByList(moList, canOverY, cb, cbObj)
	local curRoom = self._scene and self._scene.roomMgr:getCurRoom()

	if not moList or #moList <= 0 or not curRoom then
		ArcadeGameHelper.callCallbackFunc(cb, cbObj)

		return
	end

	local resDict = {}
	local resList = {}
	local loadDataList = {}

	for i, mo in ipairs(moList) do
		local res = mo:getRes()

		if res and not resDict[res] then
			resDict[res] = true
			resList[#resList + 1] = res
		end

		loadDataList[i] = {
			entityType = mo:getEntityType(),
			uid = mo:getUid()
		}

		curRoom:tryAddEntityOccupyGrids(mo, canOverY)
	end

	self._scene.loader:loadResList(resList, self._onLoadEntityListRes, self, {
		loadDataList = loadDataList,
		cb = cb,
		cbObj = cbObj
	})
end

function ArcadeEntityMgr:_onLoadEntityListRes(param)
	local curRoom = self._scene and self._scene.roomMgr:getCurRoom()

	if not curRoom or not param then
		return
	end

	local loadDataList = param.loadDataList

	for _, loadData in ipairs(loadDataList) do
		local uid = loadData.uid
		local entityType = loadData.entityType
		local mo = ArcadeGameModel.instance:getMOWithType(entityType, uid)

		if mo then
			local id = mo:getId()
			local resPath = mo:getRes()
			local typeDict = self._entityDict[entityType]

			if not typeDict then
				typeDict = {}
				self._entityDict[entityType] = typeDict
			end

			local entityCls = ArcadeGameEnum.EntityTypeCls[entityType]

			if entityCls then
				local entityAssetRes = self._scene.loader:getResource(resPath)

				if entityAssetRes then
					local goEntity = gohelper.clone(entityAssetRes, self.go, string.format("%s-%s-%s", entityType, id, uid))
					local entity = MonoHelper.addNoUpdateLuaComOnceToGo(goEntity, entityCls, {
						id = id,
						uid = uid
					})

					entity:refreshPosition()

					typeDict[uid] = entity
				else
					curRoom:removeEntityOccupyGrids(mo)
					logError(string.format("ArcadeEntityMgr:_onLoadEntityListRes error, resPath:%s no asset", resPath))
				end
			else
				curRoom:removeEntityOccupyGrids(mo)
				logError(string.format("ArcadeEntityMgr:_onLoadEntityListRes error, entityType:%s no cls define", entityType))
			end
		end
	end

	ArcadeGameHelper.callCallbackFunc(param.cb, param.cbObj)
	ArcadeGameController.instance:dispatchEvent(ArcadeEvent.OnLoadEntityFinished, loadDataList)
end

function ArcadeEntityMgr:removeEntityWithType(entityType, uid, needWaitRemoveAnim)
	local curRoom = self._scene and self._scene.roomMgr:getCurRoom()

	if entityType == ArcadeGameEnum.EntityType.Character then
		if self._characterEntity then
			if curRoom then
				local mo = self._characterEntity:getMO()

				curRoom:removeEntityOccupyGrids(mo)
			end

			self._characterEntity:destroy()
		end

		self._characterEntity = nil
	else
		local entity = self:getEntityWithType(entityType, uid)

		if entity then
			if curRoom then
				local mo = entity:getMO()

				curRoom:removeEntityOccupyGrids(mo)
			end

			if not needWaitRemoveAnim then
				entity:destroy()
			end

			self._entityDict[entityType][uid] = nil
		end
	end
end

function ArcadeEntityMgr:getEntityWithType(entityType, uid)
	if entityType == ArcadeGameEnum.EntityType.Character then
		return self:getCharacterEntity()
	else
		local dict = self._entityDict[entityType]

		return dict and dict[uid]
	end
end

function ArcadeEntityMgr:getCharacterEntity()
	return self._characterEntity
end

function ArcadeEntityMgr:getEntityDictWithType(entityType)
	return self._entityDict[entityType]
end

function ArcadeEntityMgr:getMonsterEntity(uid)
	return self:getEntityWithType(ArcadeGameEnum.EntityType.Monster, uid)
end

function ArcadeEntityMgr:onClear()
	return
end

return ArcadeEntityMgr
