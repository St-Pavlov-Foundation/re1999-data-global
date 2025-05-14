module("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView", package.seeall)

local var_0_0 = class("V2a2_WarmUpLeftView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._middleGo = gohelper.findChild(arg_1_0.viewGO, "Middle")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

setNeedLoadModule("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_Day1", "V2a2_WarmUpLeftView_Day1")
setNeedLoadModule("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_Day2", "V2a2_WarmUpLeftView_Day2")
setNeedLoadModule("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_Day3", "V2a2_WarmUpLeftView_Day3")
setNeedLoadModule("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_Day4", "V2a2_WarmUpLeftView_Day4")
setNeedLoadModule("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_Day5", "V2a2_WarmUpLeftView_Day5")

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._dayItemList = {}

	for iter_4_0 = 1, 5 do
		local var_4_0 = gohelper.findChild(arg_4_0._middleGo, "day" .. iter_4_0)
		local var_4_1 = _G["V2a2_WarmUpLeftView_Day" .. iter_4_0].New({
			parent = arg_4_0,
			baseViewContainer = arg_4_0.viewContainer
		})

		var_4_1:setIndex(iter_4_0)
		var_4_1:_internal_setEpisode(iter_4_0)
		var_4_1:init(var_4_0)

		arg_4_0._dayItemList[iter_4_0] = var_4_1
	end
end

function var_0_0.onOpen(arg_5_0)
	return
end

function var_0_0.onClose(arg_6_0)
	return
end

function var_0_0.onDestroyView(arg_7_0)
	GameUtil.onDestroyViewMemberList(arg_7_0, "_dayItemList")
end

function var_0_0.onDataUpdateFirst(arg_8_0)
	arg_8_0._lastEpisodeId = nil

	if isDebugBuild then
		assert(arg_8_0.viewContainer:getEpisodeCount() <= 5, "invalid config json_activity125 actId: " .. arg_8_0.viewContainer:actId())
	end

	arg_8_0:_getItem():onDataUpdateFirst()
end

function var_0_0.onDataUpdate(arg_9_0)
	arg_9_0:setActiveByEpisode(arg_9_0:_episodeId())
	arg_9_0:_getItem():onDataUpdate()
end

function var_0_0.onSwitchEpisode(arg_10_0)
	arg_10_0:setActiveByEpisode(arg_10_0:_episodeId())
	arg_10_0:_getItem():onSwitchEpisode()
end

function var_0_0.setActiveByEpisode(arg_11_0, arg_11_1)
	if arg_11_0._lastEpisodeId then
		arg_11_0:_getItem(arg_11_0._lastEpisodeId):setActive(false)
	end

	arg_11_0._lastEpisodeId = arg_11_1

	arg_11_0:_getItem(arg_11_1):setActive(true)
end

function var_0_0._episodeId(arg_12_0)
	return arg_12_0.viewContainer:getCurSelectedEpisode()
end

function var_0_0.episode2Index(arg_13_0, arg_13_1)
	return arg_13_0.viewContainer:episode2Index(arg_13_1 or arg_13_0:_episodeId())
end

function var_0_0._getItem(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:episode2Index(arg_14_1)

	return arg_14_0._dayItemList[var_14_0]
end

return var_0_0
