module("modules.logic.explore.map.light.ExploreMapLightItem", package.seeall)

local var_0_0 = class("ExploreMapLightItem")

var_0_0._itemPool = nil

function var_0_0.getPool()
	if not var_0_0._itemPool then
		var_0_0._itemPool = LuaObjPool.New(100, var_0_0._poolNew, var_0_0._poolRelease, var_0_0._poolReset)
	end

	return var_0_0._itemPool
end

function var_0_0._poolNew()
	return var_0_0.New()
end

function var_0_0._poolRelease(arg_3_0)
	arg_3_0:release()
end

function var_0_0._poolReset(arg_4_0)
	arg_4_0:reset()
end

function var_0_0.release(arg_5_0)
	if arg_5_0._cloneGo then
		gohelper.destroy(arg_5_0._cloneGo)

		arg_5_0._cloneGo = nil
	end

	arg_5_0._trans = nil
	arg_5_0._lightCenter = nil
	arg_5_0._lightLast = nil
end

function var_0_0.reset(arg_6_0)
	arg_6_0._trans:SetParent(nil)
	transformhelper.setLocalScale(arg_6_0._trans, 0, 0, 0)
end

function var_0_0.ctor(arg_7_0)
	arg_7_0._cloneGo = nil
end

function var_0_0.init(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if not arg_8_0._cloneGo then
		arg_8_0._cloneGo = gohelper.clone(arg_8_3, arg_8_2)
		arg_8_0._trans = arg_8_0._cloneGo.transform
		arg_8_0._lightCenter = arg_8_0._trans:Find("zhong")
		arg_8_0._lightLast = arg_8_0._trans:Find("wei")
	else
		arg_8_0._trans:SetParent(arg_8_2.transform)
	end

	arg_8_0:updateLightMO(arg_8_1)
end

function var_0_0.updateLightMO(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.dir
	local var_9_1 = arg_9_1.lightLen

	transformhelper.setLocalPos(arg_9_0._trans, 0, 1, 0)
	transformhelper.setLocalRotation(arg_9_0._trans, 0, var_9_0, 0)
	transformhelper.setLocalScale(arg_9_0._trans, 1, 1, 1)
	transformhelper.setLocalScale(arg_9_0._lightCenter, 3, 0.2, var_9_1 - 0.5)
	transformhelper.setLocalPos(arg_9_0._lightLast, 0, 0, var_9_1 - 0.1)
end

return var_0_0
