module("modules.logic.seasonver.act123.view2_3.Season123_2_3ShowSkillEffectTip", package.seeall)

local var_0_0 = class("Season123_2_3ShowSkillEffectTip", LuaCompBase)

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

function var_0_0.addHyperLinkClick(arg_3_0, arg_3_1)
	gohelper.onceAddComponent(arg_3_1, typeof(ZProj.TMPHyperLinkClick)):SetClickListener(arg_3_0.onHyperLinkClick, arg_3_0)
end

function var_0_0.onHyperLinkClick(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = tonumber(arg_4_1)

	arg_4_0:createAndGetBufferItem(var_4_0)

	local var_4_1 = recthelper.screenPosToAnchorPos(arg_4_2, arg_4_0._goBuffContainer.transform).y

	gohelper.setActive(arg_4_0._goBuffContainer, true)
	recthelper.setAnchorY(arg_4_0._goBuffContent.transform, var_4_1)
end

function var_0_0.createAndGetBufferItem(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._buffTab[arg_5_1]

	if not var_5_0 then
		var_5_0 = {
			go = gohelper.clone(arg_5_0._goBuffItem, arg_5_0._goBuffContent, "go_buffitem" .. arg_5_1)
		}
		var_5_0.txtBuffName = gohelper.findChildText(var_5_0.go, "title/txt_name")
		var_5_0.goBuffTag = gohelper.findChild(var_5_0.go, "title/txt_name/go_tag")
		var_5_0.txtBuffTagName = gohelper.findChildText(var_5_0.go, "title/txt_name/go_tag/bg/txt_tagname")
		var_5_0.txtBuffDesc = gohelper.findChildText(var_5_0.go, "txt_desc")
		var_5_0.config = SkillConfig.instance:getSkillEffectDescCo(arg_5_1)
		arg_5_0._buffTab[arg_5_1] = var_5_0
	end

	gohelper.setActive(var_5_0.go, true)

	local var_5_1 = var_5_0.config.name

	var_5_0.txtBuffName.text = SkillConfig.instance:processSkillDesKeyWords(var_5_1)

	local var_5_2 = FightConfig.instance:getBuffTag(var_5_1)

	gohelper.setActive(var_5_0.goBuffTag, not string.nilorempty(var_5_2))

	var_5_0.txtBuffTagName.text = var_5_2
	var_5_0.txtBuffDesc.text = SkillHelper.buildDesc(var_5_0.config.desc)

	arg_5_0:addChildHyperLinkClick(var_5_0.txtBuffDesc, true)
end

function var_0_0.addChildHyperLinkClick(arg_6_0, arg_6_1)
	gohelper.onceAddComponent(arg_6_1, typeof(ZProj.TMPHyperLinkClick)):SetClickListener(arg_6_0.onChildHyperLinkClick, arg_6_0)
end

function var_0_0.onChildHyperLinkClick(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = tonumber(arg_7_1)

	arg_7_0:createAndGetBufferItem(var_7_0)
end

function var_0_0.onDestroy(arg_8_0)
	arg_8_0._btnclosebuff:RemoveClickListener()
end

return var_0_0
