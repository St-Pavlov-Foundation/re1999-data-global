-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventAtkFullEffect.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventAtkFullEffect", package.seeall)

local FightTLEventAtkFullEffect = class("FightTLEventAtkFullEffect", FightTimelineTrackItem)

function FightTLEventAtkFullEffect:onTrackStart(fightStepData, duration, paramsArr)
	if not FightHelper.detectTimelinePlayEffectCondition(fightStepData, paramsArr[4]) then
		return
	end

	self._attacker = FightHelper.getEntity(fightStepData.fromId)

	if not self._attacker then
		return
	end

	if not string.nilorempty(paramsArr[10]) then
		self._attacker.effect:_onInvokeTokenRelease(paramsArr[10])

		return
	end

	local effectName = paramsArr[1]
	local offsetX, offsetY, offsetZ = 0, 0, 0

	if paramsArr[2] then
		local arr = string.split(paramsArr[2], ",")

		offsetX = arr[1] and tonumber(arr[1]) or offsetX

		if not self._attacker:isMySide() and paramsArr[5] ~= "1" then
			offsetX = -offsetX
		end

		offsetY = arr[2] and tonumber(arr[2]) or offsetY
		offsetZ = arr[3] and tonumber(arr[3]) or offsetZ
	end

	if not string.nilorempty(paramsArr[6]) then
		local arr = GameUtil.splitString2(paramsArr[6], true)
		local fightScene = GameSceneMgr.instance:getCurScene()
		local levelId = fightScene:getCurLevelId()
		local stanceId = FightHelper.getEntityStanceId(self._attacker:getMO())

		for i, v in ipairs(arr) do
			if levelId == v[1] and stanceId == v[2] then
				offsetX = offsetX + v[3] or 0
				offsetY = offsetY + v[4] or 0
				offsetZ = offsetZ + v[5] or 0
			end
		end
	end

	if not string.nilorempty(paramsArr[7]) then
		local tempSide = self._attacker:getSide() == FightEnum.EntitySide.MySide and FightEnum.EntitySide.EnemySide or FightEnum.EntitySide.MySide
		local entityMO = FightDataHelper.entityMgr:getNormalList(tempSide)[1]

		if entityMO then
			local arr = GameUtil.splitString2(paramsArr[7], true)
			local fightScene = GameSceneMgr.instance:getCurScene()
			local levelId = fightScene:getCurLevelId()
			local stanceId = FightHelper.getEntityStanceId(entityMO)

			for i, v in ipairs(arr) do
				if levelId == v[1] and stanceId == v[2] then
					offsetX = offsetX + v[3] or 0
					offsetY = offsetY + v[4] or 0
					offsetZ = offsetZ + v[5] or 0
				end
			end
		end
	end

	if string.nilorempty(effectName) then
		logError("atk effect name is nil")
	else
		self._releaseTime = nil

		if not string.nilorempty(paramsArr[11]) and paramsArr[11] ~= "0" then
			self._releaseTime = tonumber(paramsArr[11]) / FightModel.instance:getSpeed()
		end

		self._effectWrap = self._attacker.effect:addGlobalEffect(effectName, nil, self._releaseTime)

		local useWorldPos = true

		if paramsArr[13] == "1" then
			local mainCamera = CameraMgr.instance:getMainCameraGO()

			gohelper.addChild(mainCamera, self._effectWrap.containerGO)

			useWorldPos = false
		end

		local order = tonumber(paramsArr[3]) or -1

		if order == -1 then
			FightRenderOrderMgr.instance:onAddEffectWrap(self._attacker.id, self._effectWrap)
		else
			FightRenderOrderMgr.instance:setEffectOrder(self._effectWrap, order)
		end

		if useWorldPos then
			self._effectWrap:setWorldPos(offsetX, offsetY, offsetZ)
		else
			self._effectWrap:setLocalPos(offsetX, offsetY, offsetZ)
		end

		self._releaseByServer = tonumber(paramsArr[8])

		if self._releaseByServer then
			self._attacker.effect:addServerRelease(self._releaseByServer, self._effectWrap)
		end

		self._tokenRelease = not string.nilorempty(paramsArr[9])

		if self._tokenRelease then
			self._attacker.effect:addTokenRelease(paramsArr[9], self._effectWrap)
		end

		self._roundRelease = not string.nilorempty(paramsArr[12])

		if self._roundRelease then
			self._attacker.effect:addRoundRelease(tonumber(paramsArr[12]), self._effectWrap)
		end
	end

	local audioId = tonumber(paramsArr[14])

	if audioId then
		AudioMgr.instance:trigger(audioId)
	end
end

function FightTLEventAtkFullEffect:onTrackEnd()
	self:_removeEffect()
end

function FightTLEventAtkFullEffect:onDestructor()
	self:_removeEffect()
end

function FightTLEventAtkFullEffect:_removeEffect()
	local canRelease = true

	if self._releaseByServer then
		canRelease = false
	end

	if self._tokenRelease then
		canRelease = false
	end

	if self._releaseTime then
		canRelease = false
	end

	if self._roundRelease then
		canRelease = false
	end

	if canRelease and self._effectWrap then
		self._attacker.effect:removeEffect(self._effectWrap)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(self._attacker.id, self._effectWrap)
	end

	self._effectWrap = nil
	self._attacker = nil
end

return FightTLEventAtkFullEffect
