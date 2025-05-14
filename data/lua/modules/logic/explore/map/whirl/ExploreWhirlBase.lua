module("modules.logic.explore.map.whirl.ExploreWhirlBase", package.seeall)

local var_0_0 = class("ExploreWhirlBase", BaseUnitSpawn)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = gohelper.create3d(arg_1_1, arg_1_2)

	arg_1_0.trans = var_1_0.transform

	arg_1_0:init(var_1_0)

	arg_1_0._type = arg_1_2
	arg_1_0._resPath = ""

	arg_1_0:onInit()
	arg_1_0:_loadAssets()
end

function var_0_0.initComponents(arg_2_0)
	arg_2_0:addComp("followComp", ExploreWhirlFollowComp)
	arg_2_0:addComp("effectComp", ExploreWhirlEffectComp)
end

function var_0_0.onInit(arg_3_0)
	return
end

function var_0_0._loadAssets(arg_4_0)
	if string.nilorempty(arg_4_0._resPath) then
		return
	end

	arg_4_0._assetId = ResMgr.getAbAsset(arg_4_0._resPath, arg_4_0._onResLoaded, arg_4_0, arg_4_0._assetId)
end

function var_0_0.getResPath(arg_5_0)
	return arg_5_0._resPath
end

function var_0_0.onResLoaded(arg_6_0)
	return
end

function var_0_0.getGo(arg_7_0)
	return arg_7_0._displayGo
end

function var_0_0._onResLoaded(arg_8_0, arg_8_1)
	if not arg_8_1.IsLoadSuccess then
		return
	end

	arg_8_0:_releaseDisplayGo()

	arg_8_0._displayGo = arg_8_1:getInstance(nil, nil, arg_8_0.go)
	arg_8_0._displayTr = arg_8_0._displayGo.transform

	if arg_8_0.followComp then
		arg_8_0.followComp:setup(arg_8_0.go)
		arg_8_0.followComp:start()
	end

	arg_8_0:onResLoaded()
end

function var_0_0._releaseDisplayGo(arg_9_0)
	ResMgr.ReleaseObj(arg_9_0._displayGo)
	ResMgr.removeCallBack(arg_9_0._assetId)

	arg_9_0._displayGo = nil
	arg_9_0._displayTr = nil
end

function var_0_0.destroy(arg_10_0)
	arg_10_0:_releaseDisplayGo()
	gohelper.destroy(arg_10_0.go)
	arg_10_0:onDestroy()

	arg_10_0.trans = nil
end

return var_0_0
