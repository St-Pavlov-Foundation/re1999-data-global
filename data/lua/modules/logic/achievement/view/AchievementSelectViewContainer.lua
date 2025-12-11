module("modules.logic.achievement.view.AchievementSelectViewContainer", package.seeall)

local var_0_0 = class("AchievementSelectViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0._scrollView = LuaMixScrollView.New(AchievementSelectListModel.instance, arg_1_0:getMixContentParam())
	arg_1_0._nameplatescrollView = LuaMixScrollView.New(AchievementSelectListModel.instance, arg_1_0:getMixNamePlateContentParam())

	return {
		AchievementSelectView.New(),
		TabViewGroup.New(1, "#go_btns"),
		arg_1_0._scrollView,
		arg_1_0._nameplatescrollView
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		arg_2_0.navigateView:setOverrideClose(arg_2_0.overrideCloseFunc, arg_2_0)

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0.getMixContentParam(arg_3_0)
	local var_3_0 = MixScrollParam.New()

	var_3_0.scrollGOPath = "#go_container/#scroll_content"
	var_3_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_3_0.prefabUrl = arg_3_0._viewSetting.otherRes[1]
	var_3_0.cellClass = AchievementSelectItem
	var_3_0.scrollDir = ScrollEnum.ScrollDirV
	var_3_0.endSpace = 50

	return var_3_0
end

function var_0_0.getMixNamePlateContentParam(arg_4_0)
	local var_4_0 = MixScrollParam.New()

	var_4_0.scrollGOPath = "#go_container/#scroll_content_misihai"
	var_4_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_4_0.prefabUrl = arg_4_0._viewSetting.otherRes[3]
	var_4_0.cellClass = AchievementNamePlateSelectItem
	var_4_0.scrollDir = ScrollEnum.ScrollDirV
	var_4_0.endSpace = 50

	return var_4_0
end

function var_0_0.overrideCloseFunc(arg_5_0)
	AchievementSelectController.instance:popUpMessageBoxIfNeedSave(arg_5_0.yesCallBackFunc, nil, arg_5_0.closeThis, arg_5_0, nil, arg_5_0)
end

function var_0_0.yesCallBackFunc(arg_6_0)
	AchievementSelectController.instance:resumeToOriginSelect()
	arg_6_0:closeThis()
end

return var_0_0
