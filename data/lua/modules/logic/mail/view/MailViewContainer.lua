module("modules.logic.mail.view.MailViewContainer", package.seeall)

local var_0_0 = class("MailViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "mailtipview/#go_left/#scroll_mail"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_1.cellClass = MailCategoryListItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 523.3303
	var_1_1.cellHeight = 113.2241
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 2.48
	var_1_1.startSpace = 8

	local var_1_2 = {}

	for iter_1_0 = 1, 6 do
		var_1_2[iter_1_0] = 0
	end

	table.insert(var_1_0, LuaListScrollViewWithAnimator.New(MailCategroyModel.instance, var_1_1, var_1_2))
	table.insert(var_1_0, MailView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_btns"))

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
	end
end

function var_0_0.onContainerOpenFinish(arg_3_0)
	arg_3_0.navigationView:resetCloseBtnAudioId(AudioEnum.UI.UI_Mail_close)
end

return var_0_0
