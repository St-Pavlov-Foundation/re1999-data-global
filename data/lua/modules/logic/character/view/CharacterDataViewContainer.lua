module("modules.logic.character.view.CharacterDataViewContainer", package.seeall)

local var_0_0 = class("CharacterDataViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, CharacterDataView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "topleft"))
	table.insert(var_1_0, TabViewGroup.New(2, "content"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigationView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			arg_2_0.navigationView
		}
	elseif arg_2_1 == 2 then
		local var_2_0 = ListScrollParam.New()

		var_2_0.scrollGOPath = "content/#scroll_vioce"
		var_2_0.prefabType = ScrollEnum.ScrollPrefabFromRes
		var_2_0.prefabUrl = arg_2_0._viewSetting.otherRes[1]
		var_2_0.cellClass = CharacterVoiceItem
		var_2_0.scrollDir = ScrollEnum.ScrollDirV
		var_2_0.lineCount = 1
		var_2_0.cellWidth = 693.3164
		var_2_0.cellHeight = 90
		var_2_0.cellSpaceH = 0
		var_2_0.cellSpaceV = 2
		var_2_0.startSpace = 0
		var_2_0.endSpace = 0

		return {
			CharacterDataTitleView.New(),
			MultiView.New({
				CharacterDataVoiceView.New(),
				LuaListScrollView.New(CharacterVoiceModel.instance, var_2_0)
			}),
			CharacterDataItemView.New(),
			CharacterDataCultureView.New()
		}
	end
end

function var_0_0.switchTab(arg_3_0, arg_3_1)
	arg_3_0:dispatchEvent(ViewEvent.ToSwitchTab, 2, arg_3_1)
end

function var_0_0.onContainerOpenFinish(arg_4_0)
	arg_4_0.navigationView:resetOnCloseViewAudio(AudioEnum.UI.UI_role_introduce_close)
end

return var_0_0
