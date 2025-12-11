module("modules.logic.fight.entity.FightEntityMonster_500M", package.seeall)

local var_0_0 = class("FightEntityMonster_500M", FightEntityMonster)

function var_0_0.initComponents(arg_1_0)
	arg_1_0:addComp("spine", FightUnitSpine_500M)
	arg_1_0:addComp("spineRenderer", UnitSpineRenderer_500M)
	arg_1_0:addComp("mover", UnitMoverEase)
	arg_1_0:addComp("parabolaMover", UnitMoverParabola)
	arg_1_0:addComp("bezierMover", UnitMoverBezier)
	arg_1_0:addComp("curveMover", UnitMoverCurve)
	arg_1_0:addComp("moveHandler", UnitMoverHandler)
	arg_1_0:addComp("skill", FightSkillComp)
	arg_1_0:addComp("effect", FightEffectComp)
	arg_1_0:addComp("buff", FightBuffComp)
	arg_1_0:addComp("skinSpineAction", FightSkinSpineAction)
	arg_1_0:addComp("skinSpineEffect", FightSkinSpineEffect)
	arg_1_0:addComp("totalDamage", FightTotalDamageComp)
	arg_1_0:addComp("uniqueEffect", FightUniqueEffectComp)
	arg_1_0:addComp("skinCustomComp", FightSkinCustomComp)
	arg_1_0:addComp("nameUI", FightNameUI)
	arg_1_0:addComp("variantHeart", FightVariantHeartComp)
	arg_1_0:addComp("entityVisible", FightEntityVisibleComp)
	arg_1_0:addComp("nameUIVisible", FightNameUIVisibleComp)
	arg_1_0:initCompDone()
end

function var_0_0.getSpineClass(arg_2_0)
	return FightUnitSpine_500M
end

return var_0_0
