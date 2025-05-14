module("modules.logic.equip.view.EquipCareerItem", package.seeall)

local var_0_0 = class("EquipCareerItem", UserDataDispose)

function var_0_0.onInitView(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
	arg_1_0.selectedBg = gohelper.findChild(arg_1_0.go, "BG")
	arg_1_0.txt = gohelper.findChildText(arg_1_0.go, "txt")
	arg_1_0.icon = gohelper.findChildImage(arg_1_0.go, "icon")
	arg_1_0.clickCallback = arg_1_2
	arg_1_0.clickCallbackObj = arg_1_3
	arg_1_0.click = gohelper.getClick(arg_1_0.go)

	arg_1_0.click:AddClickListener(arg_1_0.onClick, arg_1_0)
	gohelper.setActive(arg_1_0.go, true)
end

function var_0_0.onClick(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)

	if arg_2_0.clickCallback then
		if arg_2_0.clickCallbackObj then
			arg_2_0.clickCallback(arg_2_0.clickCallbackObj, arg_2_0.careerMo)
		else
			arg_2_0.clickCallback(arg_2_0.careerMo)
		end
	end
end

function var_0_0.onUpdateMO(arg_3_0, arg_3_1)
	arg_3_0.careerMo = arg_3_1

	if arg_3_0.careerMo.txt then
		arg_3_0.txt.text = arg_3_0.careerMo.txt

		gohelper.setActive(arg_3_0.txt.gameObject, true)
	else
		gohelper.setActive(arg_3_0.txt.gameObject, false)
	end

	if arg_3_0.careerMo.iconName then
		UISpriteSetMgr.instance:setCommonSprite(arg_3_0.icon, arg_3_0.careerMo.iconName)
		gohelper.setActive(arg_3_0.icon.gameObject, true)
	else
		gohelper.setActive(arg_3_0.icon.gameObject, false)
	end
end

function var_0_0.refreshSelect(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.careerMo.career == arg_4_1

	gohelper.setActive(arg_4_0.selectedBg, var_4_0)
	ZProj.UGUIHelper.SetColorAlpha(arg_4_0.icon, var_4_0 and 1 or 0.4)
end

function var_0_0.onDestroyView(arg_5_0)
	arg_5_0.click:RemoveClickListener()
	arg_5_0:__onDispose()
end

return var_0_0
