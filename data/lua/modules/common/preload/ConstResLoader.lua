module("modules.common.preload.ConstResLoader", package.seeall)

local var_0_0 = class("ConstResLoader")

function var_0_0.ctor(arg_1_0)
	arg_1_0._loadFuncList = {
		arg_1_0._initLive2d,
		arg_1_0._loadConstAb,
		arg_1_0._loadIconPrefab,
		arg_1_0._loadAvProPrefab,
		arg_1_0._loadUIBlockAnim,
		arg_1_0._loadLoadingUIBg
	}
	arg_1_0._loadIndex = nil
	arg_1_0._finishCb = nil
	arg_1_0._finishCbObj = nil
end

function var_0_0.startLoad(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._loadIndex = 0
	arg_2_0._finishCb = arg_2_1
	arg_2_0._finishCbObj = arg_2_2

	arg_2_0:_loadShader()
end

function var_0_0._loadShader(arg_3_0)
	ShaderCache.instance:init(arg_3_0._onShaderLoadFinish, arg_3_0)
end

function var_0_0._onShaderLoadFinish(arg_4_0)
	BootLoadingView.instance:show(0.6, booterLang("loading_res"))
	arg_4_0:_startLoadOthers()
end

function var_0_0._startLoadOthers(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0._loadFuncList) do
		iter_5_1(arg_5_0)

		arg_5_0._loadIndex = arg_5_0._loadIndex + 1
	end
end

function var_0_0._onLoadFinish(arg_6_0)
	local var_6_0 = #arg_6_0._loadFuncList
	local var_6_1 = 0.25 * (var_6_0 - arg_6_0._loadIndex) / var_6_0

	BootLoadingView.instance:show(0.6 + var_6_1, booterLang("loading_res"))

	arg_6_0._loadIndex = arg_6_0._loadIndex - 1

	if arg_6_0._loadIndex == 0 then
		arg_6_0._finishCb(arg_6_0._finishCbObj)
	end
end

function var_0_0._initLive2d(arg_7_0)
	if GameResMgr.IsFromEditorDir then
		arg_7_0:_onLoadFinish()
	else
		ZProj.Live2dHelper.Init(arg_7_0._onLoadFinish, arg_7_0)
	end
end

function var_0_0._loadConstAb(arg_8_0)
	ConstAbCache.instance:startLoad(arg_8_0._onLoadFinish, arg_8_0)
end

function var_0_0._loadIconPrefab(arg_9_0)
	IconMgr.instance:preload(arg_9_0._onLoadFinish, arg_9_0)
end

function var_0_0._loadAvProPrefab(arg_10_0)
	AvProMgr.instance:preload(arg_10_0._onLoadFinish, arg_10_0)
end

function var_0_0._loadUIBlockAnim(arg_11_0)
	UIBlockMgrExtend.preload(arg_11_0._onLoadFinish, arg_11_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
