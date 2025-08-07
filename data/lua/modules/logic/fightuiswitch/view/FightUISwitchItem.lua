module("modules.logic.fightuiswitch.view.FightUISwitchItem", package.seeall)

local var_0_0 = class("FightUISwitchItem", MainSceneSwitchItem)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_normal")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_normal/#simage_icon")
	arg_1_0._goLocked = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_Locked")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_reddot")
	arg_1_0._goTag = gohelper.findChild(arg_1_0.viewGO, "#go_Tag")
	arg_1_0._goselected = gohelper.findChild(arg_1_0.viewGO, "#go_selected")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._onClick(arg_4_0)
	if arg_4_0._isSelect then
		return
	end

	FightUISwitchModel.instance:onSelect(arg_4_0._mo)
	AudioMgr.instance:trigger(AudioEnum.MainSceneSkin.play_ui_main_switch_scene)
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	arg_5_0._mo = arg_5_1

	if arg_5_1 then
		gohelper.setActive(arg_5_0._goLocked, not arg_5_1:isUnlock())
		gohelper.setActive(arg_5_0._goTag, arg_5_1:isUse())

		local var_5_0 = arg_5_1:getConfig()

		arg_5_0._simageicon:LoadImage(ResUrl.getMainSceneSwitchIcon(var_5_0.image))

		local var_5_1 = FightUISwitchListModel.instance:getSelectMo() == arg_5_1

		arg_5_0:onSelect(var_5_1)
		ZProj.UGUIHelper.SetGrayscale(arg_5_0._simageicon.gameObject, not arg_5_1:isUnlock())
	end
end

function var_0_0.onSelect(arg_6_0, arg_6_1)
	if arg_6_0._mo then
		var_0_0.super.onSelect(arg_6_0, arg_6_1)
	end
end

return var_0_0
