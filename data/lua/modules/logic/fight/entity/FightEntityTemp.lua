module("modules.logic.fight.entity.FightEntityTemp", package.seeall)

local var_0_0 = class("FightEntityTemp", BaseFightEntity)

function var_0_0.getTag(arg_1_0)
	return SceneTag.UnitNpc
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, arg_2_1)
	FightRenderOrderMgr.instance:unregister(arg_2_0.id)
end

function var_0_0.initComponents(arg_3_0)
	arg_3_0:addComp("spine", UnitSpine)
	arg_3_0:addComp("spineRenderer", UnitSpineRenderer)
	arg_3_0:addComp("mover", UnitMoverEase)
	arg_3_0:addComp("parabolaMover", UnitMoverParabola)
	arg_3_0:addComp("bezierMover", UnitMoverBezier)
	arg_3_0:addComp("curveMover", UnitMoverCurve)
	arg_3_0:addComp("moveHandler", UnitMoverHandler)
	arg_3_0:addComp("effect", FightEffectComp)
	arg_3_0:addComp("variantHeart", FightVariantHeartComp)
	arg_3_0:addComp("entityVisible", FightEntityVisibleComp)
end

function var_0_0.setSide(arg_4_0, arg_4_1)
	arg_4_0._tempSide = arg_4_1
end

function var_0_0.getSide(arg_5_0)
	return arg_5_0._tempSide
end

function var_0_0.loadSpine(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0._callback = arg_6_2
	arg_6_0._callbackObj = arg_6_3

	local var_6_0 = ResUrl.getSpineFightPrefab(arg_6_1)

	arg_6_0.spine:setResPath(var_6_0, arg_6_0._onSpineLoaded, arg_6_0)
end

function var_0_0.loadSpineBySkin(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0._callback = arg_7_2
	arg_7_0._callbackObj = arg_7_3

	local var_7_0 = ResUrl.getSpineFightPrefabBySkin(arg_7_1)

	arg_7_0.spine:setResPath(var_7_0, arg_7_0._onSpineLoaded, arg_7_0)
end

function var_0_0.loadSpineBySpinePath(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0._callback = arg_8_2
	arg_8_0._callbackObj = arg_8_3

	arg_8_0.spine:setResPath(arg_8_1, arg_8_0._onSpineLoaded, arg_8_0)
end

return var_0_0
