module("modules.logic.seasonver.act123.view1_8.Season123_1_8ShowSkillEffectTip", package.seeall)

local var_0_0 = class("Season123_1_8ShowSkillEffectTip", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._goBuffContainer = arg_1_1
	arg_1_0._btnclosebuff = gohelper.findChildButtonWithAudio(arg_1_0._goBuffContainer, "buff_bg")
	arg_1_0._goBuffContent = gohelper.findChild(arg_1_0._goBuffContainer, "#go_buffContent")
	arg_1_0._goBuffItem = gohelper.findChild(arg_1_0._goBuffContainer, "#go_buffContent/#go_buffitem")
	arg_1_0._buffTab = arg_1_0:getUserDataTb_()

	arg_1_0._btnclosebuff:AddClickListener(arg_1_0._btnclosebuffOnClick, arg_1_0)
	gohelper.setActive(arg_1_0._goBuffContainer, false)
	gohelper.setActive(arg_1_0._goBuffItem, false)
end

function var_0_0._btnclosebuffOnClick(arg_2_0)
	gohelper.setActive(arg_2_0._goBuffContainer, false)

	for iter_2_0, iter_2_1 in pairs(arg_2_0._buffTab) do
		arg_2_0._buffTab[iter_2_0] = nil

		gohelper.destroy(iter_2_1.go)
	end
end

function var_0_0.addLink(arg_3_0, arg_3_1)
	if string.nilorempty(arg_3_1) then
		return ""
	end

	arg_3_1 = string.gsub(arg_3_1, "%[(.-)%]", var_0_0.addLinkTag1)
	arg_3_1 = string.gsub(arg_3_1, "%【(.-)%】", var_0_0.addLinkTag2)

	return arg_3_1
end

function var_0_0.addLinkTag1(arg_4_0)
	arg_4_0 = SkillConfig.instance:processSkillDesKeyWords(arg_4_0)

	local var_4_0 = SkillConfig.instance:getSkillEffectDescCoByName(arg_4_0)

	if not var_4_0 or var_4_0.isNoShow4ActiveSkill == 1 or var_4_0.isSpecialCharacter == 1 then
		return string.format("[%s]", arg_4_0)
	end

	return string.format("<u><link=%s>[%s]</link></u>", var_4_0.id, arg_4_0)
end

function var_0_0.addLinkTag2(arg_5_0)
	arg_5_0 = SkillConfig.instance:processSkillDesKeyWords(arg_5_0)

	local var_5_0 = SkillConfig.instance:getSkillEffectDescCoByName(arg_5_0)

	if not var_5_0 or var_5_0.isNoShow4ActiveSkill == 1 or var_5_0.isSpecialCharacter == 1 then
		return string.format("【%s】", arg_5_0)
	end

	return string.format("<u><link=%s>【%s】</link></u>", var_5_0.id, arg_5_0)
end

function var_0_0.addHyperLinkClick(arg_6_0, arg_6_1)
	gohelper.onceAddComponent(arg_6_1, typeof(ZProj.TMPHyperLinkClick)):SetClickListener(arg_6_0.onHyperLinkClick, arg_6_0)
end

function var_0_0.onHyperLinkClick(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = tonumber(arg_7_1)

	arg_7_0:createAndGetBufferItem(var_7_0)

	local var_7_1 = recthelper.screenPosToAnchorPos(arg_7_2, arg_7_0._goBuffContainer.transform).y

	gohelper.setActive(arg_7_0._goBuffContainer, true)
	recthelper.setAnchorY(arg_7_0._goBuffContent.transform, var_7_1)
end

function var_0_0.createAndGetBufferItem(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._buffTab[arg_8_1]

	if not var_8_0 then
		var_8_0 = {
			go = gohelper.clone(arg_8_0._goBuffItem, arg_8_0._goBuffContent, "go_buffitem" .. arg_8_1)
		}
		var_8_0.txtBuffName = gohelper.findChildText(var_8_0.go, "title/txt_name")
		var_8_0.goBuffTag = gohelper.findChild(var_8_0.go, "title/txt_name/go_tag")
		var_8_0.txtBuffTagName = gohelper.findChildText(var_8_0.go, "title/txt_name/go_tag/bg/txt_tagname")
		var_8_0.txtBuffDesc = gohelper.findChildText(var_8_0.go, "txt_desc")
		var_8_0.config = SkillConfig.instance:getSkillEffectDescCo(arg_8_1)
		arg_8_0._buffTab[arg_8_1] = var_8_0
	end

	gohelper.setActive(var_8_0.go, true)

	local var_8_1 = var_8_0.config.name

	var_8_0.txtBuffName.text = SkillConfig.instance:processSkillDesKeyWords(var_8_1)

	local var_8_2 = FightConfig.instance:getBuffTag(var_8_1)

	gohelper.setActive(var_8_0.goBuffTag, not string.nilorempty(var_8_2))

	var_8_0.txtBuffTagName.text = var_8_2
	var_8_0.txtBuffDesc.text = arg_8_0:addLink(HeroSkillModel.instance:skillDesToSpot(var_8_0.config.desc))

	arg_8_0:addChildHyperLinkClick(var_8_0.txtBuffDesc, true)
end

function var_0_0.addChildHyperLinkClick(arg_9_0, arg_9_1)
	gohelper.onceAddComponent(arg_9_1, typeof(ZProj.TMPHyperLinkClick)):SetClickListener(arg_9_0.onChildHyperLinkClick, arg_9_0)
end

function var_0_0.onChildHyperLinkClick(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = tonumber(arg_10_1)

	arg_10_0:createAndGetBufferItem(var_10_0)
end

function var_0_0.onDestroy(arg_11_0)
	arg_11_0._btnclosebuff:RemoveClickListener()
end

return var_0_0
