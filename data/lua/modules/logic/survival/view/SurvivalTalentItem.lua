module("modules.logic.survival.view.SurvivalTalentItem", package.seeall)

local var_0_0 = class("SurvivalTalentItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._imageicon = gohelper.findChildSingleImage(arg_1_1, "#image_Shape")
	arg_1_0._goselect = gohelper.findChild(arg_1_1, "#go_select")
	arg_1_0._goempty = gohelper.findChild(arg_1_1, "#go_empty")
	arg_1_0._btnClick = gohelper.findChildButtonWithAudio(arg_1_1, "#btn_click")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnClick:AddClickListener(arg_2_0._onClickItem, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnClick:RemoveClickListener()
end

function var_0_0.setClickCallback(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._callback = arg_4_1
	arg_4_0._callobj = arg_4_2
end

function var_0_0.setIsSelect(arg_5_0, arg_5_1)
	gohelper.setActive(arg_5_0._goselect, arg_5_1)
end

function var_0_0.updateMo(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._talentCo = arg_6_1

	gohelper.setActive(arg_6_0._goempty, not arg_6_1)
	gohelper.setActive(arg_6_0._imageicon, arg_6_1)
	arg_6_0:setIsSelect(false)

	if arg_6_1 then
		local var_6_0 = arg_6_1.groupId
		local var_6_1 = lua_survival_talent_group.configDict[var_6_0]

		arg_6_0._imageicon:LoadImage(ResUrl.getSurvivalTalentIcon(var_6_1.folder .. "/fuwen_" .. arg_6_1.pos))
	end
end

function var_0_0._onClickItem(arg_7_0)
	if not arg_7_0._talentCo then
		return
	end

	if arg_7_0._callback then
		arg_7_0._callback(arg_7_0._callobj, arg_7_0)

		return
	end
end

return var_0_0
