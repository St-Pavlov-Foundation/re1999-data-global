module("modules.logic.playercard.view.comp.PlayerCardAchievementSelectIcon", package.seeall)

local var_0_0 = class("PlayerCardAchievementSelectIcon", UserDataDispose)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:__onInit()

	arg_1_0.viewGO = arg_1_1
	arg_1_0.iconGO = arg_1_2

	arg_1_0:initComponents()
end

function var_0_0.initComponents(arg_2_0)
	arg_2_0._goicon = gohelper.findChild(arg_2_0.viewGO, "#go_icon")
	arg_2_0._icon = AchievementMainIcon.New()

	arg_2_0._icon:init(arg_2_0.iconGO)
	arg_2_0._icon:setClickCall(arg_2_0.onClickSelf, arg_2_0)
	gohelper.addChild(arg_2_0._goicon, arg_2_0.iconGO)
end

function var_0_0.setData(arg_3_0, arg_3_1)
	arg_3_0.taskCO = arg_3_1

	arg_3_0:refreshUI()
end

function var_0_0.refreshUI(arg_4_0)
	arg_4_0._icon:setData(arg_4_0.taskCO)
	arg_4_0._icon:setBgVisible(true)

	local var_4_0 = PlayerCardAchievementSelectListModel.instance:isSingleSelected(arg_4_0.taskCO.id)

	arg_4_0._icon:setSelectIconVisible(var_4_0)

	if var_4_0 then
		arg_4_0._icon:setSelectIndex(PlayerCardAchievementSelectListModel.instance:getSelectOrderIndex(arg_4_0.taskCO.id))
	end
end

function var_0_0.onClickSelf(arg_5_0)
	PlayerCardAchievementSelectController.instance:changeSingleSelect(arg_5_0.taskCO.id)

	local var_5_0 = PlayerCardAchievementSelectListModel.instance:isSingleSelected(arg_5_0.taskCO.id)

	AudioMgr.instance:trigger(var_5_0 and AudioEnum.UI.play_ui_hero_card_click or AudioEnum.UI.play_ui_hero_card_gone)
end

function var_0_0.dispose(arg_6_0)
	if arg_6_0._icon then
		arg_6_0._icon:dispose()
	end

	arg_6_0:__onDispose()
end

return var_0_0
