module("modules.logic.versionactivity2_0.dungeon.view.graffiti.VersionActivity2_0DungeonGraffitiDrawViewContainer", package.seeall)

local var_0_0 = class("VersionActivity2_0DungeonGraffitiDrawViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, VersionActivity2_0DungeonGraffitiDrawView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		arg_2_0._navigateButtonView:setOverrideClose(arg_2_0._overrideCloseFunc, arg_2_0)

		return {
			arg_2_0._navigateButtonView
		}
	end
end

function var_0_0._overrideCloseFunc(arg_3_0)
	if Activity161Model.instance.graffitiInfoMap[arg_3_0.viewParam.graffitiMO.id].state ~= Activity161Enum.graffitiState.IsFinished and arg_3_0._isBeginDraw then
		GameFacade.showMessageBox(MessageBoxIdDefine.GraffitiUnFinishConfirm, MsgBoxEnum.BoxType.Yes_No, arg_3_0.closeThis, nil, nil, arg_3_0)
	else
		arg_3_0:closeThis()
	end
end

function var_0_0.setIsBeginDrawState(arg_4_0, arg_4_1)
	arg_4_0._isBeginDraw = arg_4_1
end

return var_0_0
