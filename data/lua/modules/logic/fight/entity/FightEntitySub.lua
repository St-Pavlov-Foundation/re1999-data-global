module("modules.logic.fight.entity.FightEntitySub", package.seeall)

local var_0_0 = class("FightEntitySub", BaseFightEntity)

var_0_0.Online = true

function var_0_0.getTag(arg_1_0)
	return arg_1_0:isMySide() and SceneTag.UnitPlayer or SceneTag.UnitMonster
end

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0.isSub = true

	var_0_0.super.ctor(arg_2_0, arg_2_1)
end

function var_0_0.initComponents(arg_3_0)
	arg_3_0:addComp("spine", UnitSpine)
	arg_3_0:addComp("spineRenderer", UnitSpineRenderer)
	arg_3_0:addComp("entityVisible", FightEntityVisibleComp)
	arg_3_0:addComp("effect", FightEffectComp)
	arg_3_0:addComp("variantCrayon", FightVariantCrayonComp)
end

function var_0_0.setRenderOrder(arg_4_0, arg_4_1)
	var_0_0.super.setRenderOrder(arg_4_0, arg_4_1)
end

function var_0_0.setAlpha(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0.spineRenderer then
		arg_5_0.spineRenderer:setAlpha(arg_5_1, arg_5_2)
	end
end

function var_0_0.loadSpine(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._callback = arg_6_1
	arg_6_0._callbackObj = arg_6_2

	local var_6_0 = arg_6_0:getMO()
	local var_6_1 = FightConfig.instance:getSkinCO(var_6_0.skin)
	local var_6_2 = ResUrl.getSpineFightPrefab(var_6_1 and var_6_1.alternateSpine)

	arg_6_0.spine:setResPath(var_6_2, arg_6_0._onSpineLoaded, arg_6_0)
end

function var_0_0._getOrCreateBoxSpine(arg_7_0, arg_7_1)
	local var_7_0 = gohelper.findChild(arg_7_0.go, arg_7_1) or gohelper.create3d(arg_7_0.go, arg_7_1)

	return var_7_0, MonoHelper.addNoUpdateLuaComOnceToGo(var_7_0, UnitSpine)
end

function var_0_0._onSpineLoaded(arg_8_0, arg_8_1)
	if arg_8_0.spineRenderer then
		arg_8_0.spineRenderer:setSpine(arg_8_1)
	end

	if arg_8_0._callback then
		if arg_8_0._callbackObj then
			arg_8_0._callback(arg_8_0._callbackObj, arg_8_1, arg_8_0)
		else
			arg_8_0._callback(arg_8_1, arg_8_0)
		end
	end

	arg_8_0._callback = nil
	arg_8_0._callbackObj = nil
	arg_8_0.parabolaMover = MonoHelper.addLuaComOnceToGo(arg_8_0.spine:getSpineGO(), UnitMoverParabola, arg_8_0)

	MonoHelper.addLuaComOnceToGo(arg_8_0.spine:getSpineGO(), UnitMoverHandler, arg_8_0)
end

return var_0_0
