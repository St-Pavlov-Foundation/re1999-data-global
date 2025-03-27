module("modules.logic.versionactivity2_4.pinball.entity.PinballColliderEntity", package.seeall)

slot0 = class("PinballColliderEntity", LuaCompBase)

function slot0.ctor(slot0)
	slot0.x = 0
	slot0.y = 0
	slot0.vx = 0
	slot0.vy = 0
	slot0.ax = 0
	slot0.ay = 0
	slot0.decx = 0
	slot0.decy = 0
	slot0.curHitEntityIdList = {}
	slot0.inBlackHoleId = nil
	slot0.isDead = false
	slot0.width = 1
	slot0.height = 1
	slot0.scale = 1
	slot0.shape = PinballEnum.Shape.Rect
	slot0.path = ""
	slot0.id = 0
	slot0.angle = 0
	slot0.baseForceX = 1
	slot0.baseForceY = 1

	slot0:onInit()
end

function slot0.onInit(slot0)
end

function slot0.initByCo(slot0, slot1)
	if not slot1 then
		return
	end

	slot0.x = slot1.posX
	slot0.y = slot1.posY
	slot0.angle = slot1.angle
	slot0.spData = slot1.specialData
	slot0.path = slot1.spriteName
	slot0.shape = slot1.shape
	slot0.scale = slot1.scale
	slot0.resType = slot1.resType
	slot0.width = slot1.size.x / 2 * slot0.scale
	slot0.height = slot1.size.y / 2 * slot0.scale
	slot0.vx = slot1.speed.x
	slot0.vy = slot1.speed.y
	slot0.unitCo = slot1

	slot0:onInitByCo()
	transformhelper.setLocalRotation(slot0.trans, 0, 0, slot0.angle)
	transformhelper.setLocalScale(slot0.trans, slot0.scale, slot0.scale, slot0.scale)
end

function slot0.onInitByCo(slot0)
end

function slot0.loadRes(slot0)
	if not string.nilorempty(slot0.path) then
		gohelper.setActive(slot0._imageComp, true)
		UISpriteSetMgr.instance:setAct178Sprite(slot0._imageComp, slot0.path, true)
		transformhelper.setLocalScale(slot0.trans, slot0.scale, slot0.scale, slot0.scale)

		if (slot0:isResType() or slot0.unitType == PinballEnum.UnitType.TriggerRefresh) and (slot0.vx ~= 0 or slot0.vy ~= 0) then
			slot0._imageComp.maskable = true
		else
			slot0._imageComp.maskable = false
		end
	else
		gohelper.setActive(slot0._imageComp, false)
	end
end

function slot0.onResLoaded(slot0)
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.trans = slot1.transform
	slot0._imageComp = gohelper.findChildImage(slot0.go, "icon")
	slot0._anim = gohelper.findChildAnim(slot1, "")
	slot0._tail = gohelper.findChild(slot1, "trail")

	if slot0._tail then
		slot0._tailEffect = gohelper.onceAddComponent(slot0._tail, typeof(ZProj.EffectTimeScale))
	end
end

function slot0.playAnim(slot0, slot1, slot2)
	if not slot0._anim then
		return
	end

	slot0._anim:Play(slot1, 0, slot2 or 0)
end

function slot0.tick(slot0, slot1)
	slot0.vx = (slot0.vx + slot0.ax * slot1) * (1 - slot0.decx * slot1)
	slot0.vy = (slot0.vy + slot0.ay * slot1) * (1 - slot0.decy * slot1)
	slot0.x = slot0.x + slot0.vx * slot1
	slot0.y = slot0.y + slot0.vy * slot1

	if not slot0._cacheX or slot0._cacheX ~= slot0.x or slot0._cacheY ~= slot0.y then
		slot0._cacheX = slot0.x
		slot0._cacheY = slot0.y

		recthelper.setAnchor(slot0.trans, slot0.x, slot0.y)
	end

	slot0:fixedPos()
	slot0:onTick(slot1)
end

function slot0._createLinkEntity(slot0, slot1, slot2)
	if slot0.linkEntity then
		return
	end

	slot0.linkEntity = PinballEntityMgr.instance:addEntity(slot0.unitType, slot0.unitCo)
	slot0.linkEntity.x = slot1
	slot0.linkEntity.y = slot2
	slot0.linkEntity.vx = slot0.vx
	slot0.linkEntity.vy = slot0.vy
	slot0.linkEntity.linkEntity = slot0

	slot0.linkEntity:tick(0)
	slot0:onCreateLinkEntity(slot0.linkEntity)
end

function slot0.onCreateLinkEntity(slot0, slot1)
end

function slot0._delLinkEntity(slot0)
	if slot0.linkEntity then
		slot0.linkEntity.linkEntity = nil
	end

	slot0.isDead = true
end

function slot0.fixedPos(slot0)
	if slot0.isDead then
		return
	end

	if slot0.vx > 0 then
		if PinballConst.Const3 < slot0.x + slot0.width then
			slot0:_createLinkEntity(PinballConst.Const4 - slot0.width, slot0.y)
		end

		if PinballConst.Const3 < slot0.x - slot0.width then
			slot0:_delLinkEntity()

			return
		end
	elseif slot0.vx < 0 then
		if slot0.x - slot0.width < PinballConst.Const4 then
			slot0:_createLinkEntity(PinballConst.Const3 + slot0.width, slot0.y)
		end

		if slot0.x + slot0.width < PinballConst.Const4 then
			slot0:_delLinkEntity()

			return
		end
	end

	if slot0.vy > 0 then
		if PinballConst.Const1 < slot0.y + slot0.height then
			slot0:_createLinkEntity(slot0.x, PinballConst.Const2 - slot0.height)
		end

		if PinballConst.Const1 < slot0.y - slot0.height then
			slot0:_delLinkEntity()

			return
		end
	elseif slot0.vy < 0 then
		if slot0.y - slot0.height < PinballConst.Const2 then
			slot0:_createLinkEntity(slot0.x, PinballConst.Const1 + slot0.height)
		end

		if slot0.y + slot0.height < PinballConst.Const2 then
			slot0:_delLinkEntity()

			return
		end
	end
end

function slot0.canHit(slot0)
	return true
end

function slot0.isCheckHit(slot0)
	return false
end

function slot0.isBounce(slot0)
	return true
end

function slot0.isResType(slot0)
	return PinballHelper.isResType(slot0.unitType)
end

function slot0.isMarblesType(slot0)
	return PinballHelper.isMarblesType(slot0.unitType)
end

function slot0.isOtherType(slot0)
	return PinballHelper.isOtherType(slot0.unitType)
end

function slot0.onHitEnter(slot0, slot1, slot2, slot3, slot4)
end

function slot0.onHitExit(slot0, slot1)
end

function slot0.onEnterHole(slot0)
	gohelper.setActive(slot0._tail, false)
end

function slot0.onExitHole(slot0)
	gohelper.setActive(slot0._tail, true)
end

function slot0.onTick(slot0, slot1)
end

function slot0.markDead(slot0)
	slot0.isDead = true

	if slot0.linkEntity and not slot0.linkEntity.isDead then
		slot0.linkEntity:markDead()

		slot0.linkEntity = nil
	end
end

function slot0.onDestroy(slot0)
	slot0.curHitEntityIdList = {}
end

function slot0.dispose(slot0)
	gohelper.destroy(slot0.go)
end

return slot0
