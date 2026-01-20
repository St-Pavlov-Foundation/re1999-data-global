-- chunkname: @modules/logic/fight/entity/comp/FightUnitSpine_500M.lua

module("modules.logic.fight.entity.comp.FightUnitSpine_500M", package.seeall)

local FightUnitSpine_500M = class("FightUnitSpine_500M", LuaCompBase)

function FightUnitSpine_500M:_onResLoaded(loader)
	return
end

function FightUnitSpine_500M:ctor(unitSpawn)
	self.entityId = unitSpawn.id
	self.unitSpawn = unitSpawn

	LuaEventSystem.addEventMechanism(self)
end

function FightUnitSpine_500M:init(go)
	self.go = go
	self.behindGo = gohelper.create3d(go, "behind")
	self.centerGo = gohelper.create3d(go, "center")
	self.frontGo = gohelper.create3d(go, "front")

	self:setCenterSpinePos()
	FightController.instance:registerCallback(FightEvent.RefreshSpineHeadIcon, self.refreshSpineHeadIcon, self)
end

function FightUnitSpine_500M:setCenterSpinePos()
	self:initOffset()

	local tr = self.centerGo.transform

	transformhelper.setLocalPos(tr, self.offsetX, self.offsetY, self.offsetZ)
end

function FightUnitSpine_500M:initOffset()
	if self.offsetX then
		return
	end

	local co = lua_fight_const.configDict[56]

	if not co then
		self.offsetX = 0
		self.offsetY = 0
		self.offsetZ = 0

		return
	end

	local pos = FightStrUtil.instance:getSplitToNumberCache(co.value, "#")

	if not pos then
		self.offsetX = 0
		self.offsetY = 0
		self.offsetZ = 0

		return
	end

	self.offsetX = pos[1]
	self.offsetY = pos[2]
	self.offsetZ = pos[3]
end

function FightUnitSpine_500M:getCenterSpineOffset()
	self:initOffset()

	return self.offsetX, self.offsetY, self.offsetZ
end

function FightUnitSpine_500M:refreshSpineHeadIcon(modelId)
	if not modelId then
		return
	end

	local modelCo = lua_fight_sp_500m_model.configDict[modelId]

	if not modelCo then
		logError("爬塔500M模型配置不存在 : " .. tostring(modelId))

		return
	end

	local headIcon = modelCo.headIcon

	if headIcon == self.headIcon then
		logError("refresh head icon, but icon is equal src")

		return
	end

	self.headIcon = headIcon

	self:loadCenterSpineTexture()
end

function FightUnitSpine_500M:reInitDefaultAnimState()
	self:callFunc("reInitDefaultAnimState")
end

function FightUnitSpine_500M:play(animState, loop, reStart, donotProcess, fightStepData)
	self:callFunc("play", animState, loop, reStart, donotProcess, fightStepData)
end

function FightUnitSpine_500M:replaceAnimState(animState)
	self:callFunc("replaceAnimState", animState)
end

function FightUnitSpine_500M:_onTransitionAnimEvent(actionName, eventName, eventArgs)
	return
end

function FightUnitSpine_500M:tryPlay(animState, loop, reStart)
	return self:callFunc("tryPlay", animState, loop, reStart)
end

function FightUnitSpine_500M:_cannotPlay(animState)
	return self:callFunc("_cannotPlay", animState)
end

function FightUnitSpine_500M:playAnim(animState, loop, reStart)
	self:callFunc("playAnim", animState, loop, reStart)
end

function FightUnitSpine_500M:setFreeze(isFreeze)
	self:callFunc("setFreeze", isFreeze)
end

function FightUnitSpine_500M:setTimeScale(timeScale)
	self:callFunc("setTimeScale", timeScale)
end

function FightUnitSpine_500M:setLayer(layer, recursive)
	self:callFunc("setLayer", layer, recursive)
end

local orderInterval = 10

function FightUnitSpine_500M:setRenderOrder(order, force)
	if self.frontSpine then
		self.frontSpine:setRenderOrder(order + orderInterval, force)
	end

	if self.centerSpine then
		self.centerSpine:setRenderOrder(order, force)
	end

	if self.behindSpine then
		self.behindSpine:setRenderOrder(order - orderInterval, force)
	end
end

function FightUnitSpine_500M:changeLookDir(dir)
	self:callFunc("changeLookDir", dir)
end

function FightUnitSpine_500M:_changeLookDir()
	self:callFunc("_changeLookDir")
end

function FightUnitSpine_500M:setActive(isActive)
	self:callFunc("setActive", isActive)
end

function FightUnitSpine_500M:setAnimation(animState, loop, mixTime)
	self:callFunc("setAnimation", animState, loop, mixTime)
end

function FightUnitSpine_500M:_initSpine(spineGO)
	return
end

function FightUnitSpine_500M:_initSpecialSpine()
	return
end

function FightUnitSpine_500M:detectDisplayInScreen()
	return self:callFunc("detectDisplayInScreen")
end

function FightUnitSpine_500M:detectRefreshAct(buffId)
	return self:callFunc("detectRefreshAct", buffId)
end

function FightUnitSpine_500M:_onBuffUpdate(entityId, effectType, buffId)
	return
end

function FightUnitSpine_500M:releaseSpecialSpine()
	self:callFunc("releaseSpecialSpine")
end

function FightUnitSpine_500M:_clear()
	self:callFunc("_clear")
end

function FightUnitSpine_500M:beforeDestroy()
	self:clearLoader()
	self:removeAnimEventCallback(self.onAnimEvent, self)
	FightController.instance:unregisterCallback(FightEvent.RefreshSpineHeadIcon, self.refreshSpineHeadIcon, self)
	self:callFunc("beforeDestroy")
end

function FightUnitSpine_500M:onDestroy()
	return
end

function FightUnitSpine_500M:getSpineGO()
	if self.centerSpine then
		return self.centerSpine:getSpineGO()
	end
end

function FightUnitSpine_500M:getSpineTr()
	if self.centerSpine then
		return self.centerSpine:getSpineTr()
	end
end

function FightUnitSpine_500M:getSkeletonAnim()
	if self.centerSpine then
		return self.centerSpine:getSkeletonAnim()
	end
end

function FightUnitSpine_500M:getAnimState()
	if self.centerSpine then
		return self.centerSpine:getSkeletonAnim()
	end
end

function FightUnitSpine_500M:getPPEffectMask()
	if self.centerSpine then
		return self.centerSpine:getPPEffectMask()
	end
end

function FightUnitSpine_500M:getLookDir()
	if self.centerSpine then
		return self.centerSpine:getLookDir()
	end
end

function FightUnitSpine_500M:hasAnimation(animState)
	if self.centerSpine then
		return self.centerSpine:hasAnimation(animState)
	end
end

function FightUnitSpine_500M:addAnimEventCallback(animEvtCb, animEvtCbObj, param)
	if self.centerSpine then
		return self.centerSpine:addAnimEventCallback(animEvtCb, animEvtCbObj, param)
	end
end

function FightUnitSpine_500M:removeAnimEventCallback(animEvtCb, animEvtCbObj)
	if self.centerSpine then
		return self.centerSpine:removeAnimEventCallback(animEvtCb, animEvtCbObj)
	end
end

function FightUnitSpine_500M:removeAllAnimEventCallback()
	if self.centerSpine then
		return self.centerSpine:removeAllAnimEventCallback()
	end
end

function FightUnitSpine_500M:_onAnimCallback(actionName, eventName, eventArgs)
	return
end

function FightUnitSpine_500M:setResPath(resPath, loadedCb, loadedCbObj)
	local entityMo = self.unitSpawn:getMO()
	local modeId = entityMo.modelId

	if not modeId then
		return
	end

	local modelCo = lua_fight_sp_500m_model.configDict[modeId]

	if not modelCo then
		logError("爬塔500M模型配置不存在 : " .. tostring(modeId))

		return
	end

	self.loadedCb = loadedCb
	self.loadedCbObj = loadedCbObj
	self.headIcon = modelCo.headIcon
	self.frontSpineLoaded = false
	self.centerSpineLoaded = false
	self.behindSpineLoaded = false

	if not self.frontSpine then
		self.frontSpine = MonoHelper.addLuaComOnceToGo(self.frontGo, FightUnitSpine, self.unitSpawn)
	end

	if not self.centerSpine then
		self.centerSpine = MonoHelper.addLuaComOnceToGo(self.centerGo, FightUnitSpine, self.unitSpawn)
	end

	if not self.behindSpine then
		self.behindSpine = MonoHelper.addLuaComOnceToGo(self.behindGo, FightUnitSpine, self.unitSpawn)
	end

	self:loadCenterSpineTexture()
	self.frontSpine:setResPath(self:getSpineRes(modelCo.front), self.onFrontResLoaded, self)
	self.centerSpine:setResPath(self:getSpineRes(modelCo.center), self.onCenterResLoaded, self)
	self.behindSpine:setResPath(self:getSpineRes(modelCo.behind), self.onBehindResLoaded, self)
end

function FightUnitSpine_500M:getSpineRes(res)
	return string.format("roles/%s.prefab", res)
end

function FightUnitSpine_500M:callFunc(funcName, ...)
	if self.frontSpine then
		local func = self.frontSpine[funcName]

		if func then
			func(self.frontSpine, ...)
		else
			logError("not found func int frontSpine : " .. tostring(funcName))
		end
	end

	if self.behindSpine then
		local func = self.behindSpine[funcName]

		if func then
			func(self.behindSpine, ...)
		else
			logError("not found func int behindSpine : " .. tostring(funcName))
		end
	end

	if self.centerSpine then
		local func = self.centerSpine[funcName]

		if func then
			return func(self.centerSpine, ...)
		else
			logError("not found func int centerSpine : " .. tostring(funcName))
		end
	end
end

function FightUnitSpine_500M:onFrontResLoaded()
	gohelper.addChild(self.frontGo, self.frontSpine:getSpineGO())

	self.frontSpineLoaded = true

	self.frontSpine:setActive(false)
	self:checkLoadResDone()
end

function FightUnitSpine_500M:onCenterResLoaded()
	gohelper.addChild(self.centerGo, self.centerSpine:getSpineGO())

	self.centerSpineLoaded = true

	self.centerSpine:setActive(false)
	self:checkLoadResDone()
end

function FightUnitSpine_500M:onBehindResLoaded()
	gohelper.addChild(self.behindGo, self.behindSpine:getSpineGO())

	self.behindSpineLoaded = true

	self.behindSpine:setActive(false)
	self:checkLoadResDone()
end

function FightUnitSpine_500M:checkLoadResDone()
	if not self.frontSpineLoaded then
		return
	end

	if not self.centerSpineLoaded then
		return
	end

	if not self.behindSpineLoaded then
		return
	end

	self:setActive(true)

	if self:checkCanPlayBornAnim() then
		self:addAnimEventCallback(self.onAnimEvent, self)
		self:playAnim("born", false, true)
	end

	if self.loadedCb then
		if self.loadedCbObj then
			self.loadedCb(self.loadedCbObj, self)
		else
			self.loadedCb(self)
		end
	end

	self.loadedCb = nil
	self.loadedCbObj = nil

	self:setHeadTexture()
	self:dispatchEvent(UnitSpine.Evt_OnLoaded)
end

function FightUnitSpine_500M:checkCanPlayBornAnim()
	if FightModel.instance.needFightReconnect then
		return false
	end

	local stage = self.unitSpawn:getCreateStage()

	return stage == FightEnum.EntityCreateStage.Init
end

function FightUnitSpine_500M:onAnimEvent(actionName, eventName, eventArgs)
	if eventName == SpineAnimEvent.ActionComplete then
		self:removeAnimEventCallback(self.onAnimEvent, self)
		self.unitSpawn:resetAnimState()
	end
end

function FightUnitSpine_500M:loadCenterSpineTexture()
	if string.nilorempty(self.headIcon) then
		self:onLoadTextureFinish()

		return
	end

	self:clearLoader()

	self.loader = MultiAbLoader.New()

	self.loader:addPath(ResUrl.getRoleDynamicTexture(self.headIcon))
	self.loader:startLoad(self.onLoadTextureFinish, self)
end

function FightUnitSpine_500M:onLoadTextureFinish(loader)
	local assetItem = loader and loader:getFirstAssetItem()
	local texture = assetItem and assetItem:GetResource()

	self.headTexture = texture
	self.loadHeadTextureDone = true

	self:setHeadTexture()
end

local propertyId = UnityEngine.Shader.PropertyToID("_MainTex")

function FightUnitSpine_500M:setHeadTexture()
	local mat = self.unitSpawn.spineRenderer:getReplaceMat()

	if mat and self.headTexture then
		mat:SetTexture(propertyId, self.headTexture)
	end
end

function FightUnitSpine_500M:clearLoader()
	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end

	self.headTexture = nil
	self.loadHeadTextureDone = false
end

return FightUnitSpine_500M
