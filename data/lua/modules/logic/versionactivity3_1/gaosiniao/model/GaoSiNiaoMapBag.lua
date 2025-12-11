module("modules.logic.versionactivity3_1.gaosiniao.model.GaoSiNiaoMapBag", package.seeall)

local var_0_0 = class("GaoSiNiaoMapBag")

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._mapMO = arg_1_1
	arg_1_0.type = arg_1_2 or GaoSiNiaoEnum.PathType.None
	arg_1_0.count = arg_1_3 or 0
end

function var_0_0.addCnt(arg_2_0, arg_2_1)
	arg_2_0.count = arg_2_0.count + arg_2_1
end

function var_0_0.in_ZoneMask(arg_3_0)
	return GaoSiNiaoEnum.PathInfo[arg_3_0.type].inZM
end

function var_0_0.out_ZoneMask(arg_4_0)
	return GaoSiNiaoEnum.PathInfo[arg_4_0.type].outZM
end

return var_0_0
