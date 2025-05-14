module("modules.logic.explore.map.light.ExploreMapLightPool", package.seeall)

local var_0_0 = class("ExploreMapLightPool")

function var_0_0.getInst(arg_1_0, arg_1_1, arg_1_2)
	if not arg_1_0._pool then
		arg_1_0._pool = ExploreMapLightItem.getPool()
	end

	if not arg_1_0._lightGo then
		arg_1_0._lightGo = arg_1_0:getLightGo()
	end

	local var_1_0 = arg_1_0._pool:getObject()

	var_1_0:init(arg_1_1, arg_1_2, arg_1_0._lightGo)

	return var_1_0
end

function var_0_0.getLightGo(arg_2_0)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Explore then
		return
	end

	return GameSceneMgr.instance:getCurScene().preloader:getResByPath(ResUrl.getExploreEffectPath(ExploreConstValue.MapLightEffect))
end

function var_0_0.inPool(arg_3_0, arg_3_1)
	if not arg_3_0._pool then
		arg_3_1:release()

		return
	end

	arg_3_0._pool:putObject(arg_3_1)
end

function var_0_0.clear(arg_4_0)
	if arg_4_0._pool then
		arg_4_0._pool:dispose()

		arg_4_0._pool = nil
	end

	arg_4_0._lightGo = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
