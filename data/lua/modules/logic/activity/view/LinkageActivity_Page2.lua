module("modules.logic.activity.view.LinkageActivity_Page2", package.seeall)

local var_0_0 = class("LinkageActivity_Page2", LinkageActivity_PageBase)

function var_0_0.ctor(arg_1_0, ...)
	var_0_0.super.ctor(arg_1_0, ...)

	arg_1_0._rewardItemList = {}
	arg_1_0._videoItemList = {}
	arg_1_0._curVideoIndex = false
end

function var_0_0.onDestroyView(arg_2_0)
	arg_2_0._curVideoIndex = false

	GameUtil.onDestroyViewMemberList(arg_2_0, "_rewardItemList")
	GameUtil.onDestroyViewMemberList(arg_2_0, "_videoItemList")
	var_0_0.super.onDestroyView(arg_2_0)
end

function var_0_0.addReward(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_3.New({
		parent = arg_3_0,
		baseViewContainer = arg_3_0:baseViewContainer()
	})

	var_3_0:setIndex(arg_3_1)
	var_3_0:init(arg_3_2)
	table.insert(arg_3_0._rewardItemList, var_3_0)

	return var_3_0
end

function var_0_0.addVideo(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = arg_4_3.New({
		parent = arg_4_0,
		baseViewContainer = arg_4_0:baseViewContainer()
	})

	var_4_0:setIndex(arg_4_1)
	var_4_0:init(arg_4_2)
	table.insert(arg_4_0._videoItemList, var_4_0)

	return var_4_0
end

function var_0_0.curVideoIndex(arg_5_0)
	return arg_5_0._curVideoIndex
end

function var_0_0.getReward(arg_6_0, arg_6_1)
	return arg_6_0._rewardItemList[arg_6_1]
end

function var_0_0.getVideo(arg_7_0, arg_7_1)
	return arg_7_0._videoItemList[arg_7_1]
end

function var_0_0.selectedVideo(arg_8_0, arg_8_1)
	if arg_8_0._curVideoIndex == arg_8_1 then
		return
	end

	local var_8_0 = arg_8_0._curVideoIndex == false
	local var_8_1 = arg_8_0._curVideoIndex

	arg_8_0._curVideoIndex = arg_8_1

	arg_8_0:onSelectedVideo(arg_8_1, var_8_1, var_8_0)
end

function var_0_0.onUpdateMO(arg_9_0)
	arg_9_0:_onUpdateMO_rewardList()
	arg_9_0:_onUpdateMO_videoList()
end

function var_0_0._onUpdateMO_rewardList(arg_10_0)
	local var_10_0 = arg_10_0:getTempDataList()

	if var_10_0 then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0._rewardItemList) do
			iter_10_1:onUpdateMO(var_10_0[iter_10_0])
		end
	end
end

function var_0_0._onUpdateMO_videoList(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0._videoItemList) do
		local var_11_0 = arg_11_0:getLinkageActivityCO_res_video(iter_11_0)
		local var_11_1 = {
			videoName = var_11_0
		}

		iter_11_1:onUpdateMO(var_11_1)
	end
end

function var_0_0.onSelectedVideo(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	assert(false, "please override this function")
end

function var_0_0.onPostSelectedPage(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_0 == arg_13_1 then
		arg_13_0:_onUpdateMO_videoList()
	end
end

return var_0_0
