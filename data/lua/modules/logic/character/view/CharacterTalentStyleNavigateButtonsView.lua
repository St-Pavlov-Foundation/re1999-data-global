module("modules.logic.character.view.CharacterTalentStyleNavigateButtonsView", package.seeall)

local var_0_0 = class("CharacterTalentStyleNavigateButtonsView", NavigateButtonsView)

function var_0_0._editableInitView(arg_1_0)
	var_0_0.super._editableInitView(arg_1_0)

	arg_1_0._btnstat = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_stat")
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	arg_2_0._btnstat:AddClickListener(arg_2_0._btnstatOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	var_0_0.super.removeEvents(arg_3_0)
	arg_3_0._btnstat:RemoveClickListener()
end

function var_0_0._btnstatOnClick(arg_4_0)
	if arg_4_0._overrideStatFunc then
		arg_4_0._overrideStatFunc(arg_4_0._overrideStatObj)
	end
end

function var_0_0.setOverrideStat(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._overrideStatFunc = arg_5_1
	arg_5_0._overrideStatObj = arg_5_2
end

function var_0_0.showStatBtn(arg_6_0, arg_6_1)
	if arg_6_0._btnstat then
		gohelper.setActive(arg_6_0._btnstat.gameObject, arg_6_1)
	end
end

return var_0_0
