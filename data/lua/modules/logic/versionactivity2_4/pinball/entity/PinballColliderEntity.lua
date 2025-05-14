module("modules.logic.versionactivity2_4.pinball.entity.PinballColliderEntity", package.seeall)

local var_0_0 = class("PinballColliderEntity", LuaCompBase)

function var_0_0.ctor(arg_1_0)
	arg_1_0.x = 0
	arg_1_0.y = 0
	arg_1_0.vx = 0
	arg_1_0.vy = 0
	arg_1_0.ax = 0
	arg_1_0.ay = 0
	arg_1_0.decx = 0
	arg_1_0.decy = 0
	arg_1_0.curHitEntityIdList = {}
	arg_1_0.inBlackHoleId = nil
	arg_1_0.isDead = false
	arg_1_0.width = 1
	arg_1_0.height = 1
	arg_1_0.scale = 1
	arg_1_0.shape = PinballEnum.Shape.Rect
	arg_1_0.path = ""
	arg_1_0.id = 0
	arg_1_0.angle = 0
	arg_1_0.baseForceX = 1
	arg_1_0.baseForceY = 1

	arg_1_0:onInit()
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.initByCo(arg_3_0, arg_3_1)
	if not arg_3_1 then
		return
	end

	arg_3_0.x = arg_3_1.posX
	arg_3_0.y = arg_3_1.posY
	arg_3_0.angle = arg_3_1.angle
	arg_3_0.spData = arg_3_1.specialData
	arg_3_0.path = arg_3_1.spriteName
	arg_3_0.shape = arg_3_1.shape
	arg_3_0.scale = arg_3_1.scale
	arg_3_0.resType = arg_3_1.resType
	arg_3_0.width = arg_3_1.size.x / 2 * arg_3_0.scale
	arg_3_0.height = arg_3_1.size.y / 2 * arg_3_0.scale
	arg_3_0.vx = arg_3_1.speed.x
	arg_3_0.vy = arg_3_1.speed.y
	arg_3_0.unitCo = arg_3_1

	arg_3_0:onInitByCo()
	transformhelper.setLocalRotation(arg_3_0.trans, 0, 0, arg_3_0.angle)
	transformhelper.setLocalScale(arg_3_0.trans, arg_3_0.scale, arg_3_0.scale, arg_3_0.scale)
end

function var_0_0.onInitByCo(arg_4_0)
	return
end

function var_0_0.loadRes(arg_5_0)
	if not string.nilorempty(arg_5_0.path) then
		gohelper.setActive(arg_5_0._imageComp, true)
		UISpriteSetMgr.instance:setAct178Sprite(arg_5_0._imageComp, arg_5_0.path, true)
		transformhelper.setLocalScale(arg_5_0.trans, arg_5_0.scale, arg_5_0.scale, arg_5_0.scale)

		if (arg_5_0:isResType() or arg_5_0.unitType == PinballEnum.UnitType.TriggerRefresh) and (arg_5_0.vx ~= 0 or arg_5_0.vy ~= 0) then
			arg_5_0._imageComp.maskable = true
		else
			arg_5_0._imageComp.maskable = false
		end
	else
		gohelper.setActive(arg_5_0._imageComp, false)
	end
end

function var_0_0.onResLoaded(arg_6_0)
	return
end

function var_0_0.init(arg_7_0, arg_7_1)
	arg_7_0.go = arg_7_1
	arg_7_0.trans = arg_7_1.transform
	arg_7_0._imageComp = gohelper.findChildImage(arg_7_0.go, "icon")
	arg_7_0._anim = gohelper.findChildAnim(arg_7_1, "")
	arg_7_0._tail = gohelper.findChild(arg_7_1, "trail")

	if arg_7_0._tail then
		arg_7_0._tailEffect = gohelper.onceAddComponent(arg_7_0._tail, typeof(ZProj.EffectTimeScale))
	end
end

function var_0_0.playAnim(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0._anim then
		return
	end

	arg_8_0._anim:Play(arg_8_1, 0, arg_8_2 or 0)
end

function var_0_0.tick(arg_9_0, arg_9_1)
	arg_9_0.vx = (arg_9_0.vx + arg_9_0.ax * arg_9_1) * (1 - arg_9_0.decx * arg_9_1)
	arg_9_0.vy = (arg_9_0.vy + arg_9_0.ay * arg_9_1) * (1 - arg_9_0.decy * arg_9_1)
	arg_9_0.x = arg_9_0.x + arg_9_0.vx * arg_9_1
	arg_9_0.y = arg_9_0.y + arg_9_0.vy * arg_9_1

	if not arg_9_0._cacheX or arg_9_0._cacheX ~= arg_9_0.x or arg_9_0._cacheY ~= arg_9_0.y then
		arg_9_0._cacheX = arg_9_0.x
		arg_9_0._cacheY = arg_9_0.y

		recthelper.setAnchor(arg_9_0.trans, arg_9_0.x, arg_9_0.y)
	end

	arg_9_0:fixedPos()
	arg_9_0:onTick(arg_9_1)
end

function var_0_0._createLinkEntity(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0.linkEntity then
		return
	end

	arg_10_0.linkEntity = PinballEntityMgr.instance:addEntity(arg_10_0.unitType, arg_10_0.unitCo)
	arg_10_0.linkEntity.x = arg_10_1
	arg_10_0.linkEntity.y = arg_10_2
	arg_10_0.linkEntity.vx = arg_10_0.vx
	arg_10_0.linkEntity.vy = arg_10_0.vy
	arg_10_0.linkEntity.linkEntity = arg_10_0

	arg_10_0.linkEntity:tick(0)
	arg_10_0:onCreateLinkEntity(arg_10_0.linkEntity)
end

function var_0_0.onCreateLinkEntity(arg_11_0, arg_11_1)
	return
end

function var_0_0._delLinkEntity(arg_12_0)
	if arg_12_0.linkEntity then
		arg_12_0.linkEntity.linkEntity = nil
	end

	arg_12_0.isDead = true
end

function var_0_0.fixedPos(arg_13_0)
	if arg_13_0.isDead then
		return
	end

	if arg_13_0.vx > 0 then
		if arg_13_0.x + arg_13_0.width > PinballConst.Const3 then
			arg_13_0:_createLinkEntity(PinballConst.Const4 - arg_13_0.width, arg_13_0.y)
		end

		if arg_13_0.x - arg_13_0.width > PinballConst.Const3 then
			arg_13_0:_delLinkEntity()

			return
		end
	elseif arg_13_0.vx < 0 then
		if arg_13_0.x - arg_13_0.width < PinballConst.Const4 then
			arg_13_0:_createLinkEntity(PinballConst.Const3 + arg_13_0.width, arg_13_0.y)
		end

		if arg_13_0.x + arg_13_0.width < PinballConst.Const4 then
			arg_13_0:_delLinkEntity()

			return
		end
	end

	if arg_13_0.vy > 0 then
		if arg_13_0.y + arg_13_0.height > PinballConst.Const1 then
			arg_13_0:_createLinkEntity(arg_13_0.x, PinballConst.Const2 - arg_13_0.height)
		end

		if arg_13_0.y - arg_13_0.height > PinballConst.Const1 then
			arg_13_0:_delLinkEntity()

			return
		end
	elseif arg_13_0.vy < 0 then
		if arg_13_0.y - arg_13_0.height < PinballConst.Const2 then
			arg_13_0:_createLinkEntity(arg_13_0.x, PinballConst.Const1 + arg_13_0.height)
		end

		if arg_13_0.y + arg_13_0.height < PinballConst.Const2 then
			arg_13_0:_delLinkEntity()

			return
		end
	end
end

function var_0_0.canHit(arg_14_0)
	return true
end

function var_0_0.isCheckHit(arg_15_0)
	return false
end

function var_0_0.isBounce(arg_16_0)
	return true
end

function var_0_0.isResType(arg_17_0)
	return PinballHelper.isResType(arg_17_0.unitType)
end

function var_0_0.isMarblesType(arg_18_0)
	return PinballHelper.isMarblesType(arg_18_0.unitType)
end

function var_0_0.isOtherType(arg_19_0)
	return PinballHelper.isOtherType(arg_19_0.unitType)
end

function var_0_0.onHitEnter(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	return
end

function var_0_0.onHitExit(arg_21_0, arg_21_1)
	return
end

function var_0_0.onEnterHole(arg_22_0)
	gohelper.setActive(arg_22_0._tail, false)
end

function var_0_0.onExitHole(arg_23_0)
	gohelper.setActive(arg_23_0._tail, true)
end

function var_0_0.onTick(arg_24_0, arg_24_1)
	return
end

function var_0_0.markDead(arg_25_0)
	arg_25_0.isDead = true

	if arg_25_0.linkEntity and not arg_25_0.linkEntity.isDead then
		arg_25_0.linkEntity:markDead()

		arg_25_0.linkEntity = nil
	end
end

function var_0_0.onDestroy(arg_26_0)
	arg_26_0.curHitEntityIdList = {}
end

function var_0_0.dispose(arg_27_0)
	gohelper.destroy(arg_27_0.go)
end

return var_0_0
