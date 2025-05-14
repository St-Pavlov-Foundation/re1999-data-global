module("modules.logic.signin.view.SignInViewContainer", package.seeall)

local var_0_0 = class("SignInViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "rightContent/monthdetail/scroll_item"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_1.cellClass = SignInListItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 7
	var_1_1.cellWidth = 110
	var_1_1.cellHeight = 144
	var_1_1.cellSpaceH = 8.3
	var_1_1.cellSpaceV = 0
	var_1_1.startSpace = 0
	var_1_1.endSpace = 0
	var_1_1.minUpdateCountInFrame = 100

	table.insert(var_1_0, LuaListScrollView.New(SignInListModel.instance, var_1_1))
	table.insert(var_1_0, TabViewGroup.New(1, "#go_btns"))
	table.insert(var_1_0, SignInView.New())

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = NavigateButtonsView.New({
			false,
			false,
			false
		})

		var_2_0:setOverrideClose(arg_2_0.overrideOnCloseClick, arg_2_0)

		return {
			var_2_0
		}
	end
end

function var_0_0.overrideOnCloseClick(arg_3_0)
	SignInController.instance:dispatchEvent(SignInEvent.CloseSignInView)
end

return var_0_0
