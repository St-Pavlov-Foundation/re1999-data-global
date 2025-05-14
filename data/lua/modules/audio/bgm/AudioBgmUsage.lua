module("modules.audio.bgm.AudioBgmUsage", package.seeall)

local var_0_0 = class("AudioBgmUsage")

function var_0_0.ctor(arg_1_0)
	arg_1_0.layerList = nil
	arg_1_0.type = nil
	arg_1_0.typeParam = nil
	arg_1_0.queryFunc = nil
	arg_1_0.queryFuncTarget = nil
	arg_1_0.clearPauseBgm = nil
end

function var_0_0.containBgm(arg_2_0, arg_2_1)
	return tabletool.indexOf(arg_2_0.layerList, arg_2_1)
end

function var_0_0.setClearPauseBgm(arg_3_0, arg_3_1)
	arg_3_0.clearPauseBgm = arg_3_1
end

function var_0_0.getBgmLayer(arg_4_0)
	if #arg_4_0.layerList == 1 then
		return arg_4_0.layerList[1]
	end

	if arg_4_0.queryFunc then
		return arg_4_0.queryFunc(arg_4_0.queryFuncTarget, arg_4_0)
	end
end

return var_0_0
