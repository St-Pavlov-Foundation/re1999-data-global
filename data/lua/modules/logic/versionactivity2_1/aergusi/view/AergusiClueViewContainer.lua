module("modules.logic.versionactivity2_1.aergusi.view.AergusiClueViewContainer", package.seeall)

local var_0_0 = class("AergusiClueViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		AergusiClueMergeView.New(),
		AergusiClueListView.New(),
		AergusiClueDetailView.New(),
		AergusiClueView.New(),
		TabViewGroup.New(1, "#go_BackBtns")
	}
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	arg_2_0:closeThis()
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	local var_3_0 = NavigateButtonsView.New()

	if arg_3_0.viewParam and arg_3_0.viewParam.episodeId then
		var_3_0:setParam({
			true,
			false,
			false
		})
	else
		var_3_0:setParam({
			true,
			true,
			false
		})
	end

	var_3_0:setOverrideClose(arg_3_0.overrideOnCloseClick, arg_3_0)

	return {
		var_3_0
	}
end

function var_0_0.overrideOnCloseClick(arg_4_0)
	if arg_4_0.viewParam and arg_4_0.viewParam.callback then
		arg_4_0.viewParam.callback(arg_4_0.viewParam.callbackObj, -1)
	end

	arg_4_0:closeThis()
end

return var_0_0
