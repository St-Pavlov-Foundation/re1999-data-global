module("modules.logic.handbook.view.HandbookCGViewContainer", package.seeall)

local var_0_0 = class("HandbookCGViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = MixScrollParam.New()

	var_1_1.scrollGOPath = "#scroll_cg"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_1.cellClass = HandbookCGItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	arg_1_0._csScrollView = LuaMixScrollView.New(HandbookCGTripleListModel.instance, var_1_1)

	table.insert(var_1_0, HandbookCGView.New())
	table.insert(var_1_0, arg_1_0._csScrollView)
	table.insert(var_1_0, TabViewGroup.New(1, "#go_btns"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0.getCsScroll(arg_3_0)
	return arg_3_0._csScrollView
end

function var_0_0.onContainerOpenFinish(arg_4_0)
	arg_4_0.navigateView:resetCloseBtnAudioId(AudioEnum.UI.play_ui_screenplay_photo_close)
	arg_4_0.navigateView:resetHomeBtnAudioId(AudioEnum.UI.play_ui_screenplay_photo_close)
end

return var_0_0
