module("modules.logic.handbook.view.HandbookEquipViewContainer", package.seeall)

local var_0_0 = class("HandbookEquipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, HandbookEquipView.New())
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

function var_0_0.onContainerInit(arg_3_0)
	arg_3_0:checkConfigValid()
end

function var_0_0.onContainerOpenFinish(arg_4_0)
	arg_4_0.navigateView:resetCloseBtnAudioId(AudioEnum.UI.Play_UI_CloseHouse)
	arg_4_0.navigateView:resetHomeBtnAudioId(AudioEnum.UI.UI_checkpoint_story_close)
end

function var_0_0.checkConfigValid(arg_5_0)
	if not SLFramework.FrameworkSettings.IsEditor then
		return
	end

	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(lua_handbook_equip.configList) do
		var_5_0[iter_5_1.equipId] = true
	end

	local var_5_1 = {}

	for iter_5_2, iter_5_3 in ipairs(lua_equip.configList) do
		var_5_1[iter_5_3.id] = true
	end

	for iter_5_4, iter_5_5 in pairs(var_5_1) do
		if not var_5_0[iter_5_4] then
			local var_5_2 = lua_equip.configDict[iter_5_4]

			if string.nilorempty(var_5_2.canShowHandbook) then
				logError("图鉴心相表未配置装备id : " .. iter_5_4)
			end
		end
	end
end

return var_0_0
