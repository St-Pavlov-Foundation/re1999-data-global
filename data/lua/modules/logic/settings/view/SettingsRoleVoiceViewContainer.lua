module("modules.logic.settings.view.SettingsRoleVoiceViewContainer", package.seeall)

local var_0_0 = class("SettingsRoleVoiceViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0._scrollParam = ListScrollParam.New()
	arg_1_0._scrollParam.scrollGOPath = "#go_rolecontainer/#scroll_card"
	arg_1_0._scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	arg_1_0._scrollParam.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	arg_1_0._scrollParam.cellClass = SettingsRoleVoiceListItem
	arg_1_0._scrollParam.scrollDir = ScrollEnum.ScrollDirV
	arg_1_0._scrollParam.lineCount = 6
	arg_1_0._scrollParam.cellWidth = 250
	arg_1_0._scrollParam.cellHeight = 555
	arg_1_0._scrollParam.cellSpaceH = 18
	arg_1_0._scrollParam.cellSpaceV = 10
	arg_1_0._scrollParam.startSpace = 10
	arg_1_0._scrollParam.frameUpdateMs = 100
	arg_1_0._scrollParam.minUpdateCountInFrame = 100
	arg_1_0._scrollParam.multiSelect = false

	local var_1_0 = {}

	for iter_1_0 = 1, 12 do
		var_1_0[iter_1_0] = math.ceil((iter_1_0 - 1) % 6) * 0.06
	end

	arg_1_0._cardScrollView = LuaListScrollViewWithAnimator.New(CharacterBackpackCardListModel.instance, arg_1_0._scrollParam, var_1_0)

	local var_1_1 = {}

	arg_1_0._mainSettingView = SettingsRoleVoiceView.New()
	arg_1_0._filterView = SettingsRoleVoiceSearchFilterView.New()

	table.insert(var_1_1, arg_1_0._mainSettingView)
	table.insert(var_1_1, arg_1_0._filterView)
	table.insert(var_1_1, TabViewGroup.New(1, "#go_btns"))
	table.insert(var_1_1, arg_1_0._cardScrollView)

	return var_1_1
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			arg_2_0._navigateButtonsView
		}
	end
end

function var_0_0.isBatchEditMode(arg_3_0)
	return arg_3_0._mainSettingView:isBatchEditMode()
end

function var_0_0.setBatchEditMode(arg_4_0, arg_4_1)
	arg_4_0._scrollParam.multiSelect = arg_4_1
end

function var_0_0.getCardScorllView(arg_5_0)
	return arg_5_0._cardScrollView
end

function var_0_0.clearSelectedItems(arg_6_0)
	arg_6_0._cardScrollView:setSelectList()
end

function var_0_0.selectedAllItems(arg_7_0)
	local var_7_0 = CharacterBackpackCardListModel.instance:getCharacterCardList()

	arg_7_0._cardScrollView:setSelectList(var_7_0)
end

return var_0_0
