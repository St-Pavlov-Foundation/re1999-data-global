module("modules.logic.versionactivity1_3.buff.view.VersionActivity1_3FairyLandItem", package.seeall)

local var_0_0 = class("VersionActivity1_3FairyLandItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imagecard = gohelper.findChildImage(arg_1_0.viewGO, "root/#image_card")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "root/image_namebg/#txt_name")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "root/desc/Viewport/Content/#txt_desc")
	arg_1_0._goselected = gohelper.findChild(arg_1_0.viewGO, "root/#go_selected")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	arg_4_0._landView:landItemClick(arg_4_0)
end

function var_0_0.ctor(arg_5_0, arg_5_1)
	arg_5_0._landView = arg_5_1[1]
	arg_5_0.config = arg_5_1[2]
end

function var_0_0._editableInitView(arg_6_0)
	local var_6_0 = arg_6_0.config.skillId
	local var_6_1 = lua_skill_effect.configDict[var_6_0]

	arg_6_0._txtdesc.text = FightConfig.instance:getSkillEffectDesc(nil, var_6_1)

	local var_6_2 = lua_skill.configDict[var_6_0]

	arg_6_0._txtname.text = var_6_2 and var_6_2.name

	UISpriteSetMgr.instance:setV1a3FairyLandCardSprite(arg_6_0._imagecard, "v1a3_fairylandcard_" .. arg_6_0.config.id - 2130000)
	arg_6_0:setSelected(false)
end

function var_0_0.setSelected(arg_7_0, arg_7_1)
	arg_7_0._isSelected = arg_7_1

	gohelper.setActive(arg_7_0._goselected, arg_7_0._isSelected)
end

function var_0_0._editableRemoveEvents(arg_8_0)
	return
end

function var_0_0.onUpdateMO(arg_9_0, arg_9_1)
	return
end

function var_0_0.onSelect(arg_10_0, arg_10_1)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
