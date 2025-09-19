module("modules.logic.survival.view.SurvivalTalentInfoPart", package.seeall)

local var_0_0 = class("SurvivalTalentInfoPart", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_1, "root/#btn_close")
	arg_1_0._desc1 = gohelper.findChildTextMesh(arg_1_1, "root/#go_info/scroll_base/Viewport/Content/#txt_effect")
	arg_1_0._desc2 = gohelper.findChildTextMesh(arg_1_1, "root/#go_info/scroll_base/Viewport/Content/#txt_info")
	arg_1_0._imagetalent = gohelper.findChildSingleImage(arg_1_1, "root/#go_info/top/middle/talent/#image_talent")
	arg_1_0._txtname = gohelper.findChildTextMesh(arg_1_1, "root/#go_info/top/middle/talent/#txt_name")
	arg_1_0._btnEquip = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/bottom/#btn_equiped")
	arg_1_0._btnUnEquip = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/bottom/#btn_unequip")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._onClickClose, arg_2_0)
	arg_2_0._btnEquip:AddClickListener(arg_2_0._onClickEquip, arg_2_0)
	arg_2_0._btnUnEquip:AddClickListener(arg_2_0._onClickEquip, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnEquip:RemoveClickListener()
	arg_3_0._btnUnEquip:RemoveClickListener()
end

function var_0_0.setClickCallback(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._callback = arg_4_1
	arg_4_0._callobj = arg_4_2
end

function var_0_0.setEquipCallback(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._equipcallback = arg_5_1
	arg_5_0._equipcallobj = arg_5_2
end

function var_0_0._onClickClose(arg_6_0)
	if arg_6_0._callback then
		arg_6_0._callback(arg_6_0._callobj)
	end
end

function var_0_0.updateMo(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_1 then
		gohelper.setActive(arg_7_0.go, false)

		return
	end

	gohelper.setActive(arg_7_0.go, true)

	arg_7_0.talentCo = arg_7_1
	arg_7_0.isEquip = arg_7_2
	arg_7_0._desc1.text = arg_7_1.desc1
	arg_7_0._desc2.text = arg_7_1.desc2

	local var_7_0 = arg_7_1.groupId
	local var_7_1 = lua_survival_talent_group.configDict[var_7_0]

	arg_7_0._imagetalent:LoadImage(ResUrl.getSurvivalTalentIcon(var_7_1.folder .. "/icon_tianfu_" .. arg_7_1.pos))

	arg_7_0._txtname.text = arg_7_1.name

	gohelper.setActive(arg_7_0._btnEquip, arg_7_2)
	gohelper.setActive(arg_7_0._btnUnEquip, not arg_7_2)
end

function var_0_0._onClickEquip(arg_8_0)
	if arg_8_0._equipcallback then
		arg_8_0._equipcallback(arg_8_0._equipcallobj, arg_8_0.talentCo, arg_8_0.isEquip)
	end
end

return var_0_0
