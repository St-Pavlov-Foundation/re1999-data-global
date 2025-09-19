module("modules.logic.scene.shelter.entity.SurvivalShelterUnitEntity", package.seeall)

local var_0_0 = class("SurvivalShelterUnitEntity", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.unitType = arg_1_1.unitType
	arg_1_0.unitId = arg_1_1.unitId

	SurvivalMapHelper.instance:addShelterEntity(arg_1_0.unitType, arg_1_0.unitId, arg_1_0)
	arg_1_0:onCtor(arg_1_1)
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0.trans = arg_2_1.transform

	arg_2_0:onInit()
	arg_2_0:showEffect()
end

function var_0_0.onLoadedEnd(arg_3_0)
	arg_3_0._isVisible = nil

	arg_3_0:updateEntity()
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnShelterMapUnitAdd, arg_3_0.unitType, arg_3_0.unitId)
end

function var_0_0.updateEntity(arg_4_0, arg_4_1)
	arg_4_0:refreshShow()
	arg_4_0:onUpdateEntity()
	arg_4_0:onChangeEntity(arg_4_1)
end

function var_0_0.refreshShow(arg_5_0)
	local var_5_0 = arg_5_0:canShow()

	arg_5_0:setVisible(var_5_0)
end

function var_0_0.setVisible(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0._isVisible == arg_6_1 and not arg_6_2 then
		return
	end

	arg_6_0._isVisible = arg_6_1

	gohelper.setActive(arg_6_0.goModel, arg_6_0._isVisible)
	gohelper.setActive(arg_6_0._effectRoot, arg_6_0._isVisible)
end

function var_0_0.isVisible(arg_7_0)
	return arg_7_0._isVisible
end

function var_0_0.canShow(arg_8_0)
	return true
end

function var_0_0.onCtor(arg_9_0, arg_9_1)
	return
end

function var_0_0.onInit(arg_10_0)
	return
end

function var_0_0.onUpdateEntity(arg_11_0)
	return
end

function var_0_0.needUI(arg_12_0)
	return false
end

function var_0_0.getFolowerTransform(arg_13_0)
	if gohelper.isNil(arg_13_0.goCenter) then
		local var_13_0, var_13_1, var_13_2 = arg_13_0:getCenterPos()

		arg_13_0.goCenter = gohelper.create3d(arg_13_0.trans.parent.gameObject, "center")
		arg_13_0.transCenter = arg_13_0.goCenter.transform

		local var_13_3 = arg_13_0:getScale()

		transformhelper.setLocalPos(arg_13_0.transCenter, var_13_0, 0.5 * var_13_3, var_13_2)
		gohelper.addChildPosStay(arg_13_0.go, arg_13_0.goCenter)
	end

	return arg_13_0.transCenter
end

function var_0_0.getPos(arg_14_0)
	return arg_14_0.pos
end

function var_0_0.getScale(arg_15_0)
	return 1
end

function var_0_0.getCenterPos(arg_16_0)
	local var_16_0 = arg_16_0:getPos()
	local var_16_1, var_16_2, var_16_3 = SurvivalHelper.instance:hexPointToWorldPoint(var_16_0.q, var_16_0.r)

	return var_16_1, var_16_2, var_16_3
end

function var_0_0.checkClick(arg_17_0, arg_17_1)
	if not arg_17_0._isVisible then
		return false
	end

	return arg_17_0:getPos() == arg_17_1
end

function var_0_0.isInPlayerPos(arg_18_0)
	local var_18_0 = SurvivalMapHelper.instance:getScene()

	if not var_18_0 then
		return false
	end

	return var_18_0.unit:getPlayer():isInPos(arg_18_0:getPos())
end

function var_0_0.focusEntity(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = arg_19_0:getPos()

	if not var_19_0 then
		if arg_19_2 then
			arg_19_2(arg_19_3)
		end

		return
	end

	local var_19_1, var_19_2, var_19_3 = SurvivalHelper.instance:hexPointToWorldPoint(var_19_0.q, var_19_0.r)

	SurvivalController.instance:dispatchEvent(SurvivalEvent.TweenCameraFocus, Vector3(var_19_1, var_19_2, var_19_3), arg_19_1, arg_19_2, arg_19_3)
end

function var_0_0.onChangeEntity(arg_20_0, arg_20_1)
	if arg_20_1 then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnShelterMapUnitChange, arg_20_0.unitType)
	else
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnShelterMapUnitChange, arg_20_0.unitType, arg_20_0.unitId)
	end
end

function var_0_0.onDestroy(arg_21_0)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnShelterMapUnitDel, arg_21_0.unitType, arg_21_0.unitId)
end

function var_0_0.getEffectPath(arg_22_0)
	return nil
end

function var_0_0.showEffect(arg_23_0)
	arg_23_0._effectPath = arg_23_0:getEffectPath()

	if arg_23_0._effectPath == nil then
		return
	end

	if gohelper.isNil(arg_23_0._effectRoot) then
		arg_23_0._effectRoot = gohelper.create3d(arg_23_0.trans.gameObject, "EffectRoot")

		gohelper.setActive(arg_23_0._effectRoot, false)
	end

	if not gohelper.isNil(arg_23_0._goEffect) then
		return
	end

	if arg_23_0._effectLoader then
		return
	end

	arg_23_0._effectLoader = PrefabInstantiate.Create(arg_23_0._effectRoot)

	arg_23_0._effectLoader:startLoad(arg_23_0._effectPath, arg_23_0._onEffectResLoadEnd, arg_23_0)
end

function var_0_0._onEffectResLoadEnd(arg_24_0)
	local var_24_0 = arg_24_0._effectLoader:getInstGO()
	local var_24_1 = var_24_0.transform

	arg_24_0._goEffect = var_24_0

	transformhelper.setLocalPos(var_24_1, 0, 0, 0)
	transformhelper.setLocalRotation(var_24_1, 0, 0, 0)
	transformhelper.setLocalScale(var_24_1, 1, 1, 1)
	arg_24_0:onEffectLoadedEnd()
	gohelper.setActive(arg_24_0._effectRoot, arg_24_0._isVisible)
end

function var_0_0.onEffectLoadedEnd(arg_25_0)
	return
end

return var_0_0
