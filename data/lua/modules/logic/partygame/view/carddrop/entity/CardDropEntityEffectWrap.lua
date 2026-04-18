-- chunkname: @modules/logic/partygame/view/carddrop/entity/CardDropEntityEffectWrap.lua

module("modules.logic.partygame.view.carddrop.entity.CardDropEntityEffectWrap", package.seeall)

local CardDropEntityEffectWrap = class("CardDropEntityEffectWrap", UserDataDispose)
local uid = 0

local function GetUid()
	uid = uid + 1

	return uid
end

function CardDropEntityEffectWrap:init(entityUid, entity)
	CardDropEntityEffectWrap.super.__onInit(self)

	self.uid = GetUid()
	self.entityUid = entityUid
	self.entity = entity
end

function CardDropEntityEffectWrap:createEffect(effectName, parentGo)
	self.containerGo = gohelper.create3d(parentGo, effectName)
	self.containerTr = self.containerGo.transform
	self.loader = PrefabInstantiate.Create(self.containerGo)
	self.effectName = effectName
	self.effectFullPath = ResUrl.getEffect(effectName)

	self.loader:startLoad(self.effectFullPath, self.onLoadEffectDone, self)
end

function CardDropEntityEffectWrap:setLocalPos(x, y, z)
	if gohelper.isNil(self.containerTr) then
		return
	end

	transformhelper.setLocalPos(self.containerTr, x, y, z)
end

function CardDropEntityEffectWrap:setLocalScale(scale)
	transformhelper.setLocalScale(self.containerTr, scale, scale, scale)
end

function CardDropEntityEffectWrap:onLoadEffectDone()
	self.effectGo = self.loader:getInstGO()
	self.realEffectGo = self:removeAndGetRealEffectGo()

	gohelper.setLayer(self.containerGo, UnityLayer.Scene, true)

	local tr = self.effectGo.transform

	transformhelper.setLocalPos(tr, 0, 0, 0)
	self:playShake()
end

local ShakeCompType = typeof(ZProj.EffectShakeComponent)

function CardDropEntityEffectWrap:playShake()
	local effectShakeComp = self.realEffectGo and self.realEffectGo:GetComponent(ShakeCompType)

	if effectShakeComp then
		effectShakeComp:Play(CameraMgr.instance:getCameraShake(), 1, 1)
	end
end

function CardDropEntityEffectWrap:removeAndGetRealEffectGo()
	local array = string.split(self.effectName, "/")
	local srcEffectName = array[#array]
	local side = self:getSide()
	local suffix = side == CardDropEnum.Side.My and "_l" or "_r"
	local effectName = srcEffectName .. tostring(suffix)
	local removeGo = gohelper.findChild(self.effectGo, effectName)

	gohelper.destroy(removeGo)

	suffix = side == CardDropEnum.Side.My and "_r" or "_l"
	effectName = srcEffectName .. tostring(suffix)

	local remainGo = gohelper.findChild(self.effectGo, effectName)

	return remainGo
end

function CardDropEntityEffectWrap:setSide(side)
	self._side = side
end

function CardDropEntityEffectWrap:getSide()
	if self._side then
		return self._side
	end

	return self.entity:getSide()
end

function CardDropEntityEffectWrap:destroy()
	gohelper.destroy(self.containerGo)
	CardDropEntityEffectWrap.super.__onDispose(self)
end

return CardDropEntityEffectWrap
