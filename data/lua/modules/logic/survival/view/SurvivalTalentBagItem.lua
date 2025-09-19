module("modules.logic.survival.view.SurvivalTalentBagItem", package.seeall)

local var_0_0 = class("SurvivalTalentBagItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._gonormal = gohelper.findChild(arg_1_1, "root/has")
	arg_1_0._goempty = gohelper.findChild(arg_1_1, "root/empty")
	arg_1_0._btnClick = gohelper.findChildButtonWithAudio(arg_1_1, "root/btn_Click")
	arg_1_0._goselect = gohelper.findChild(arg_1_1, "root/has/go_select")
	arg_1_0._goitem = gohelper.findChild(arg_1_0._gonormal, "collection")
	arg_1_0._gonpc = gohelper.findChild(arg_1_0._gonormal, "npc")
	arg_1_0._gotalent = gohelper.findChild(arg_1_0._gonormal, "Talent")
	arg_1_0._imageicon = gohelper.findChildSingleImage(arg_1_0._gotalent, "#image_Icon")

	gohelper.setActive(arg_1_0._goitem, false)
	gohelper.setActive(arg_1_0._gonpc, false)
	gohelper.setActive(arg_1_0._gotalent, true)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnClick:AddClickListener(arg_2_0._onItemClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnClick:RemoveClickListener()
end

function var_0_0.updateMo(arg_4_0, arg_4_1)
	arg_4_0._talentCo = arg_4_1

	gohelper.setActive(arg_4_0._gonormal, arg_4_1)
	gohelper.setActive(arg_4_0._goempty, not arg_4_1)
	arg_4_0:setIsSelect(false)

	if arg_4_1 then
		local var_4_0 = arg_4_1.groupId
		local var_4_1 = lua_survival_talent_group.configDict[var_4_0]

		arg_4_0._imageicon:LoadImage(ResUrl.getSurvivalTalentIcon(var_4_1.folder .. "/icon_tianfu_" .. arg_4_1.pos))
	end
end

function var_0_0.isEmpty(arg_5_0)
	return not arg_5_0._talentCo
end

function var_0_0.setClickCallback(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._callback = arg_6_1
	arg_6_0._callobj = arg_6_2
end

function var_0_0.setIsSelect(arg_7_0, arg_7_1)
	gohelper.setActive(arg_7_0._goselect, arg_7_1)
end

function var_0_0._onItemClick(arg_8_0)
	if not arg_8_0._talentCo then
		return
	end

	if arg_8_0._callback then
		arg_8_0._callback(arg_8_0._callobj, arg_8_0)

		return
	end
end

function var_0_0.onDestroy(arg_9_0)
	arg_9_0._imageicon:UnLoadImage()
end

return var_0_0
