module("modules.logic.tips.view.SkillBuffDescComp", package.seeall)

local var_0_0 = class("SkillBuffDescComp", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._goBuffContainer = arg_1_1
	arg_1_0._btnclosebuff = gohelper.findChildButtonWithAudio(arg_1_1, "buff_bg")
	arg_1_0._goBuffItem = gohelper.findChild(arg_1_1, "#go_buffitem")
	arg_1_0._txtBuffName = gohelper.findChildText(arg_1_1, "#go_buffitem/title/txt_name")
	arg_1_0._goBuffTag = gohelper.findChild(arg_1_1, "#go_buffitem/title/txt_name/go_tag")
	arg_1_0._txtBuffTagName = gohelper.findChildText(arg_1_1, "#go_buffitem/title/txt_name/go_tag/bg/txt_tagname")
	arg_1_0._txtBuffDesc = gohelper.findChildText(arg_1_1, "#go_buffitem/txt_desc")

	gohelper.setActive(arg_1_1, false)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnclosebuff:AddClickListener(arg_2_0._closebuff, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnclosebuff:RemoveClickListener()
end

function var_0_0._closebuff(arg_4_0)
	gohelper.setActive(arg_4_0._goBuffContainer, false)
end

function var_0_0.onShowBuff(arg_5_0, arg_5_1, arg_5_2)
	gohelper.setActive(arg_5_0._goBuffContainer, true)
	arg_5_0:setBuffInfo(arg_5_1)
	arg_5_0:setBuffPos(arg_5_2)
end

function var_0_0.setBuffInfo(arg_6_0, arg_6_1)
	local var_6_0 = SkillConfig.instance:getSkillEffectDescCoByName(arg_6_1)

	arg_6_0._txtBuffName.text = SkillConfig.instance:processSkillDesKeyWords(arg_6_1)
	arg_6_0._txtBuffDesc.text = HeroSkillModel.instance:skillDesToSpot(var_6_0.desc)

	local var_6_1 = FightConfig.instance:getBuffTag(arg_6_1)

	gohelper.setActive(arg_6_0._goBuffTag, not string.nilorempty(var_6_1))

	arg_6_0._txtBuffTagName.text = var_6_1
end

function var_0_0.setBuffPos(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.x - 20
	local var_7_1 = arg_7_1.y
	local var_7_2 = arg_7_0._goBuffItem.transform
	local var_7_3 = arg_7_0._goBuffContainer.transform

	ZProj.UGUIHelper.RebuildLayout(var_7_2)

	local var_7_4 = recthelper.getWidth(var_7_2)
	local var_7_5 = recthelper.getHeight(var_7_2)
	local var_7_6 = recthelper.getWidth(var_7_3)
	local var_7_7 = recthelper.getHeight(var_7_3)

	if -var_7_6 / 2 > var_7_0 - var_7_4 - 10 then
		local var_7_8 = -var_7_6 / 2 + var_7_4 + 10
	end

	if -var_7_7 / 2 > var_7_1 - var_7_5 / 2 - 10 then
		var_7_1 = -var_7_7 / 2 + var_7_5 / 2 + 10
	end

	recthelper.setAnchorY(var_7_2, var_7_1)
end

return var_0_0
