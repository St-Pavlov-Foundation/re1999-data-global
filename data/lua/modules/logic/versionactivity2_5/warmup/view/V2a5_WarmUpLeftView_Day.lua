module("modules.logic.versionactivity2_5.warmup.view.V2a5_WarmUpLeftView_Day", package.seeall)

local var_0_0 = class("V2a5_WarmUpLeftView_Day", RougeSimpleItemBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()
	var_0_0.super.ctor(arg_1_0, arg_1_1)
end

function var_0_0._editableInitView(arg_2_0)
	var_0_0.super._editableInitView(arg_2_0)
end

function var_0_0._internal_setEpisode(arg_3_0, arg_3_1)
	arg_3_0._episodeId = arg_3_1
end

function var_0_0.setActive(arg_4_0, arg_4_1)
	gohelper.setActive(arg_4_0.viewGO, arg_4_1)
end

function var_0_0.onDestroyView(arg_5_0)
	var_0_0.super.onDestroyView(arg_5_0)
	arg_5_0:__onDispose()
end

return var_0_0
