module("modules.logic.tips.view.FightBloodPoolTipView", package.seeall)

local var_0_0 = class("FightBloodPoolTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "root/layout/#txt_title")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "root/layout/#txt_desc")

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

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.click = gohelper.findChildClickWithDefaultAudio(arg_4_0.viewGO, "close_block")

	arg_4_0.click:AddClickListener(arg_4_0.closeThis, arg_4_0)
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0._txttitle.text = lua_fight_xcjl_const.configDict[6].value2

	local var_5_0 = lua_fight_xcjl_const.configDict[7].value2
	local var_5_1 = FightHelper.getBloodPoolSkillId()
	local var_5_2 = lua_skill.configDict[var_5_1]
	local var_5_3 = formatLuaLang("DungeonWeekWalkView_txtcurprogress_battleName", var_5_2.name)
	local var_5_4 = GameUtil.getSubPlaceholderLuaLangTwoParam(var_5_0, lua_fight_xcjl_const.configDict[3].value, var_5_3)
	local var_5_5 = FightConfig.instance:getSkillEffectDesc(nil, var_5_2)

	arg_5_0._txtdesc.text = formatLuaLang("fightbloodpooltipview_txtdesc", var_5_4, var_5_3, var_5_5)
end

function var_0_0.onDestroyView(arg_6_0)
	if arg_6_0.click then
		arg_6_0.click:RemoveClickListener()

		arg_6_0.click = nil
	end
end

return var_0_0
