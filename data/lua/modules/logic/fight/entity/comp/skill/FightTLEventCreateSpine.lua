-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventCreateSpine.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventCreateSpine", package.seeall)

local FightTLEventCreateSpine = class("FightTLEventCreateSpine", FightTimelineTrackItem)

function FightTLEventCreateSpine.getSkinSpineName(spineParam, skinId)
	if string.nilorempty(spineParam) or skinId == 0 then
		return spineParam
	end

	local spineParams = string.split(spineParam, "#")
	local tempSpineName = spineParams[1]
	local replaceSkin = spineParams[2] and spineParams[2] == "1"

	if not replaceSkin then
		return tempSpineName
	end

	if string.find(tempSpineName, "%[") then
		tempSpineName = string.gsub(tempSpineName, "%[%d-%]", skinId)
	end

	local skinCO = lua_skin.configDict[skinId]

	if skinCO and not string.nilorempty(skinCO.spine) then
		local spineSp = string.split(skinCO.spine, "_")
		local paramSp = string.split(tempSpineName, "_")

		paramSp[1] = spineSp[1]

		return table.concat(paramSp, "_")
	end

	return tempSpineName
end

function FightTLEventCreateSpine:onTrackStart(fightStepData, duration, paramsArr)
	self._paramsArr = paramsArr
	self._attacker = FightHelper.getEntity(fightStepData.fromId)

	local spineParam = string.split(paramsArr[1], "#")
	local attackerMO = self._attacker:getMO()
	local skinConfig = attackerMO and attackerMO:getSpineSkinCO()

	self._skinId = skinConfig and skinConfig.id or 0

	local spineName = skinConfig and FightTLEventCreateSpine.getSkinSpineName(paramsArr[1], self._skinId) or paramsArr[1]
	local actionName = paramsArr[2]
	local posX, posY, posZ = 0, 0, 0

	if not string.nilorempty(paramsArr[3]) then
		local arr = string.splitToNumber(paramsArr[3], ",")

		posX = arr[1] or posX
		posY = arr[2] or posY
		posZ = arr[3] or posZ
	end

	local renderOrder = tonumber(paramsArr[4]) or -1
	local scale = tonumber(paramsArr[5]) or 1
	local specificId = fightStepData.stepUid .. "_" .. (string.nilorempty(paramsArr[6]) and spineName or paramsArr[6])
	local hangPointId = tonumber(paramsArr[7]) or 1
	local mirror = tonumber(paramsArr[8]) or 0

	if not self._attacker:isMySide() and paramsArr[9] ~= "4" then
		posX = -posX
	end

	local hangPointGO = self:_getHangPointGO(fightStepData, hangPointId, paramsArr)
	local specificOrder = 0

	if renderOrder == -1 then
		local atkOrder = FightRenderOrderMgr.instance:getOrder(fightStepData.fromId) or 0

		atkOrder = atkOrder / FightEnum.OrderRegion
		specificOrder = atkOrder * FightEnum.OrderRegion
		specificOrder = specificOrder + 1
	elseif renderOrder == -2 then
		local atkOrder = FightRenderOrderMgr.instance:getOrder(fightStepData.toId) or 0

		atkOrder = atkOrder / FightEnum.OrderRegion
		specificOrder = atkOrder * FightEnum.OrderRegion
		specificOrder = specificOrder + (tonumber(paramsArr[13]) or 0)
	else
		specificOrder = renderOrder * FightEnum.OrderRegion
	end

	self.useGoScaleReplaceSpineScale = FightTLHelper.getBoolParam(paramsArr[20])

	local defenders = {}

	if paramsArr[10] == "1" then
		defenders = FightHelper.getDefenders(fightStepData, true)
	else
		table.insert(defenders, FightHelper.getEntity(fightStepData.toId))
	end

	self._spineEntityList = {}

	local count = paramsArr[10] == "1" and #defenders or 1

	for i = 1, count do
		local defender = defenders[i]
		local rootPosX, rootPosY, rootPosZ = 0, 0, 0

		if paramsArr[9] == "1" then
			if hangPointId == 1 then
				rootPosX, rootPosY, rootPosZ = transformhelper.getLocalPos(self._attacker.go.transform)
			else
				rootPosX, rootPosY, rootPosZ = transformhelper.getPos(self._attacker.go.transform)
			end
		elseif paramsArr[9] == "2" and defender then
			if hangPointId == 1 then
				rootPosX, rootPosY, rootPosZ = transformhelper.getLocalPos(defender.go.transform)
			else
				rootPosX, rootPosY, rootPosZ = transformhelper.getPos(defender.go.transform)
			end
		end

		local resultPosX = posX + rootPosX
		local resultPosY = posY + rootPosY
		local resultPosZ = posZ + rootPosZ
		local resultSpecificId = paramsArr[10] == "1" and specificId .. "_multi_" .. i or specificId

		self:_createSpine(spineName, resultSpecificId, mirror, scale, resultPosX, resultPosY, resultPosZ, hangPointGO, specificOrder, actionName)
	end

	self:_setupEntityLookAt(paramsArr[11])
end

function FightTLEventCreateSpine:onTrackEnd()
	self:_clear()
end

function FightTLEventCreateSpine:_setupEntityLookAt(needLookAtCamera)
	if needLookAtCamera and needLookAtCamera == "1" then
		TaskDispatcher.runRepeat(self._onTickLookAtCamera, self, 0.01)
	end
end

function FightTLEventCreateSpine:_onTickLookAtCamera()
	local entityMgr = FightGameMgr.entityMgr

	for _, entity in ipairs(self._spineEntityList) do
		entityMgr:adjustSpineLookRotation(entity)
	end
end

function FightTLEventCreateSpine:onSpineLoaded(spine)
	if self.spineEntity == spine.entity then
		self:setSubRootPathRenderer()
	end
end

function FightTLEventCreateSpine:setSubRootPathRenderer()
	if self.spineEntity and self.spineEntity.spine then
		local obj = self.spineEntity.spine:getSpineGO()
		local arr = string.split(self._paramsArr[19], "#")

		for k, path in pairs(arr) do
			local subObj = gohelper.findChild(obj, path)

			if subObj then
				local renderer = subObj:GetComponent(typeof(UnityEngine.MeshRenderer))

				if renderer then
					renderer.sortingOrder = self.specificOrder
				end
			end
		end
	end
end

function FightTLEventCreateSpine:_createSpine(spineName, specificId, mirror, scale, posX, posY, posZ, hangPointGO, specificOrder, actionName)
	local entityMgr = FightGameMgr.entityMgr
	local specificSide = self._attacker:getSide()
	local entityParam = {}

	if self._paramsArr[17] == "1" then
		entityParam = {
			ingoreRainEffect = true
		}
	end

	local spineEntity = entityMgr:buildTempSpineByName(spineName, specificId, specificSide, mirror == 1, nil, entityParam, self._paramsArr[18] == "1", self.useGoScaleReplaceSpineScale)

	self.spineEntity = spineEntity
	self.specificOrder = specificOrder

	if not string.nilorempty(self._paramsArr[19]) and spineEntity.spine then
		if gohelper.isNil(spineEntity.spine:getSpineGO()) then
			self:com_registFightEvent(FightEvent.OnSpineLoaded, self.onSpineLoaded)
		else
			self:setSubRootPathRenderer()
		end
	end

	spineEntity.variantHeart:setEntity(self._attacker)
	spineEntity:setScale(scale)

	if hangPointGO then
		gohelper.addChild(hangPointGO, spineEntity.go)
	end

	if self._paramsArr[7] == "3" or self._paramsArr[7] == "4" then
		transformhelper.setPos(spineEntity.go.transform, posX, posY, posZ)
	else
		transformhelper.setLocalPos(spineEntity.go.transform, posX, posY, posZ)
	end

	spineEntity:setRenderOrder(specificOrder)

	if not string.nilorempty(actionName) then
		spineEntity.spine:play(actionName)

		if self._attacker and self._attacker.skill and self._attacker.skill:sameSkillPlaying() and not string.nilorempty(self._paramsArr[12]) then
			spineEntity.spine._skeletonAnim:Jump2Time(tonumber(self._paramsArr[12]))
		end
	end

	if self._paramsArr[14] == "1" then
		entityMgr.entityDic[spineEntity.id] = nil

		FightController.instance:dispatchEvent(FightEvent.EntrustTempEntity, spineEntity)
	end

	if not string.nilorempty(self._paramsArr[15]) then
		local entityMgr = FightGameMgr.entityMgr

		entityMgr.entityDic[spineEntity.id] = nil

		FightMsgMgr.sendMsg(FightMsgId.SetBossEvolution, spineEntity, tonumber(self._paramsArr[15]))
	end

	table.insert(self._spineEntityList, spineEntity)
end

function FightTLEventCreateSpine:_getHangPointGO(fightStepData, hangPointId, param)
	local pathStr = param[16]

	if not string.nilorempty(pathStr) then
		local cameraRoot = CameraMgr.instance:getCameraRootGO()
		local arr = string.split(pathStr, "#")
		local side = self._attacker:getSide()
		local path = arr[side] or arr[1]

		if path then
			local findRoot = gohelper.findChild(cameraRoot, path)

			if findRoot then
				return findRoot
			end
		end
	end

	if hangPointId == 2 then
		return CameraMgr.instance:getCameraTraceGO()
	elseif hangPointId == 3 then
		local attacker = FightHelper.getEntity(fightStepData.fromId)

		return attacker and attacker.go
	elseif hangPointId == 4 then
		local defender = FightHelper.getEntity(fightStepData.toId)

		return defender and defender.go
	end
end

function FightTLEventCreateSpine:onDestructor()
	self:_clear()
end

function FightTLEventCreateSpine:_clear()
	TaskDispatcher.cancelTask(self._onTickLookAtCamera, self)

	if self._spineEntityList then
		for i, spineEntity in ipairs(self._spineEntityList) do
			local entityMgr = FightGameMgr.entityMgr
			local canRemove = true

			if self._paramsArr[14] == "1" then
				canRemove = false
			end

			if not string.nilorempty(self._paramsArr[15]) then
				canRemove = false
			end

			if canRemove then
				entityMgr:delEntity(spineEntity.id)
			end

			spineEntity = nil
		end
	end

	self._spineEntityList = nil
end

return FightTLEventCreateSpine
