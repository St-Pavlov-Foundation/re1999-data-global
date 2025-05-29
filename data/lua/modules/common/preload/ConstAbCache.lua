module("modules.common.preload.ConstAbCache", package.seeall)

local var_0_0 = class("ConstAbCache")

function var_0_0.ctor(arg_1_0)
	arg_1_0._pathTab = {
		"ui/viewres/rpcblock/rpcblock.prefab",
		PostProcessingMgr.MainHighProfilePath,
		PostProcessingMgr.MainMiddleProfilePath,
		PostProcessingMgr.MainLowProfilePath,
		ExploreScenePPVolume.ExploreHighProfilePath,
		ExploreScenePPVolume.ExploreMiddleProfilePath,
		ExploreScenePPVolume.ExploreLowProfilePath,
		RoomResourceEnum.PPVolume.High,
		RoomResourceEnum.PPVolume.Middle,
		RoomResourceEnum.PPVolume.Low,
		PostProcessingMgr.CaptureResPath
	}
	arg_1_0._pathResTab = {}
end

function var_0_0.getRes(arg_2_0, arg_2_1)
	return arg_2_0._pathResTab[arg_2_1]
end

function var_0_0.startLoad(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._finishCb = arg_3_1
	arg_3_0._finishCbObj = arg_3_2
	arg_3_0._needCount = #arg_3_0._pathTab

	for iter_3_0, iter_3_1 in ipairs(arg_3_0._pathTab) do
		loadAbAsset(iter_3_1, false, arg_3_0._onLoadOne, arg_3_0)
	end
end

function var_0_0._onLoadOne(arg_4_0, arg_4_1)
	if arg_4_1.IsLoadSuccess then
		arg_4_1:Retain()

		arg_4_0._pathResTab[arg_4_1.ResPath] = arg_4_1:GetResource()
		arg_4_0._needCount = arg_4_0._needCount - 1

		if arg_4_0._needCount == 0 then
			if arg_4_0._finishCb then
				arg_4_0._finishCb(arg_4_0._finishCbObj)

				arg_4_0._finishCb = nil
				arg_4_0._finishCbObj = nil
			end

			logNormal("ConstAbCache 预加载ab资源完成了!")
		end

		return
	end

	logError("ConstAbCache 预加载ab资源失败，path = " .. arg_4_1.ResPath)
end

var_0_0.instance = var_0_0.New()

return var_0_0
