module("modules.logic.room.view.transport.RoomTransportPathViewContainer", package.seeall)

local var_0_0 = class("RoomTransportPathViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoomTransportPathView.New())
	table.insert(var_1_0, TabViewGroup.New(2, "#go_righttop/#go_tabfailtips"))
	table.insert(var_1_0, RoomTransportPathViewUI.New())
	table.insert(var_1_0, RoomTransportPathViewUI.New())

	if RoomTransportPathQuickLinkViewUI._IsShow_ == true and GameResMgr.IsFromEditorDir then
		table.insert(var_1_0, RoomTransportPathQuickLinkViewUI.New())
	end

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigationView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_2_0.navigationView
		}
	elseif arg_2_1 == 2 then
		return {
			RoomTransportPathFailTips.New()
		}
	end
end

return var_0_0
