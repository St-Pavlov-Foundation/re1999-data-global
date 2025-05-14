module("modules.logic.explore.map.whirl.comp.ExploreWhirlEffectComp", package.seeall)

local var_0_0 = class("ExploreWhirlEffectComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.whirl = arg_1_1
	arg_1_0._effectGo = nil
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
end

function var_0_0.playAnim(arg_3_0, arg_3_1)
	arg_3_0:_releaseEffectGo()

	if arg_3_1 then
		local var_3_0 = ExploreConfig.instance:getUnitEffectConfig(arg_3_0.whirl:getResPath(), arg_3_1)

		if string.nilorempty(var_3_0) == false then
			arg_3_0._effectPath = ResUrl.getExploreEffectPath(var_3_0)
			arg_3_0._assetId = ResMgr.getAbAsset(arg_3_0._effectPath, arg_3_0._onResLoaded, arg_3_0, arg_3_0._assetId)
		end
	else
		arg_3_0._effectPath = nil
	end
end

function var_0_0._onResLoaded(arg_4_0, arg_4_1)
	if not arg_4_1.IsLoadSuccess then
		return
	end

	if arg_4_0._effectPath == arg_4_1:getUrl() then
		arg_4_0:_releaseEffectGo()

		arg_4_0._effectPath = arg_4_1:getUrl()
		arg_4_0._effectGo = arg_4_1:getInstance(nil, nil, arg_4_0.go)
	end
end

function var_0_0._releaseEffectGo(arg_5_0)
	ResMgr.ReleaseObj(arg_5_0._effectGo)
	ResMgr.removeCallBack(arg_5_0._assetId)

	arg_5_0._effectGo = nil
	arg_5_0._effectPath = nil
end

function var_0_0.onDestroy(arg_6_0)
	arg_6_0:_releaseEffectGo()
end

return var_0_0
