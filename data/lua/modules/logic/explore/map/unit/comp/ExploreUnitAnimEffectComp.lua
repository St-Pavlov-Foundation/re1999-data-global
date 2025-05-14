module("modules.logic.explore.map.unit.comp.ExploreUnitAnimEffectComp", package.seeall)

local var_0_0 = class("ExploreUnitAnimEffectComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.unit = arg_1_1
	arg_1_0._effectGo = nil
	arg_1_0._isOnce = false
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
end

function var_0_0.playAnim(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._isOnce = false

	arg_3_0:_releaseEffectGo()

	if arg_3_1 then
		local var_3_0, var_3_1, var_3_2, var_3_3, var_3_4 = ExploreConfig.instance:getUnitEffectConfig(arg_3_0.unit:getResPath(), arg_3_1)

		arg_3_0._isOnce = var_3_1

		if arg_3_2 and var_3_1 then
			return
		end

		ExploreHelper.triggerAudio(var_3_2, var_3_3, arg_3_0.unit.go, var_3_4 and arg_3_0.unit.id or nil)

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

		local var_4_0 = arg_4_0.unit:getEffectRoot()

		arg_4_0._effectGo = arg_4_1:getInstance(nil, nil, var_4_0.gameObject)
	end
end

function var_0_0.destoryEffectIfOnce(arg_5_0)
	if arg_5_0._isOnce then
		arg_5_0:_releaseEffectGo()
	end
end

function var_0_0._releaseEffectGo(arg_6_0)
	ResMgr.removeCallBack(arg_6_0._assetId)
	ResMgr.ReleaseObj(arg_6_0._effectGo)

	arg_6_0._effectGo = nil
	arg_6_0._effectPath = nil
end

function var_0_0.clear(arg_7_0)
	if not arg_7_0.unit then
		return
	end

	GameSceneMgr.instance:getCurScene().audio:stopAudioByUnit(arg_7_0.unit.id)
end

function var_0_0.onDestroy(arg_8_0)
	arg_8_0._isOnce = false
	arg_8_0.unit = false

	arg_8_0:_releaseEffectGo()
end

return var_0_0
