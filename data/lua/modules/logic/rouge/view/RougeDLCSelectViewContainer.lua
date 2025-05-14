module("modules.logic.rouge.view.RougeDLCSelectViewContainer", package.seeall)

local var_0_0 = class("RougeDLCSelectViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = MixScrollParam.New()

	var_1_0.scrollGOPath = "#go_root/#scroll_dlcs"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_0.prefabUrl = "#go_root/#scroll_dlcs/Viewport/Content/#go_dlcitem"
	var_1_0.cellClass = RougeDLCSelectListItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 1
	var_1_0.startSpace = 0
	var_1_0.endSpace = 0

	local var_1_1 = {}

	table.insert(var_1_1, RougeDLCSelectView.New())
	table.insert(var_1_1, TabViewGroup.New(1, "#go_root/#go_topleft"))
	table.insert(var_1_1, LuaMixScrollView.New(RougeDLCSelectListModel.instance, var_1_0))

	return var_1_1
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_2_0.navigateView
		}
	end
end

return var_0_0
