module("modules.logic.bossrush.view.v2a9.V2a9_BossRushHeroGroupSkillCompItem", package.seeall)

local var_0_0 = class("V2a9_BossRushHeroGroupSkillCompItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "#image_icon")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "#go_select")
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "#go_lock")
	arg_1_0._goadd = gohelper.findChild(arg_1_0.viewGO, "#go_add")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "num/#txt_num")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	if arg_4_0._mo:isLock() then
		return
	end

	BossRushController.instance:openV2a9BossRushSkillBackpackView(arg_4_0._mo:getItemType())
end

function var_0_0._editableInitView(arg_5_0)
	gohelper.setActive(arg_5_0._goselect, false)

	arg_5_0._gonum = gohelper.findChild(arg_5_0.viewGO, "num")
	arg_5_0._anim = arg_5_0.viewGO:GetComponent(gohelper.Type_Animator)
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	arg_6_0._mo = arg_6_1

	local var_6_0 = arg_6_1:getItemType()
	local var_6_1 = arg_6_1:isLock()
	local var_6_2 = arg_6_1:isEquip()

	if var_6_2 then
		local var_6_3 = V2a9BossRushSkillBackpackListModel.instance:getMObyItemType(var_6_0)

		if var_6_3 then
			arg_6_0._txtnum.text = var_6_3:getCount() or 0

			AssassinHelper.setAssassinItemIcon(var_6_3:getId(), arg_6_0._imageicon)
		end
	end

	gohelper.setActive(arg_6_0._golock, var_6_1)
	gohelper.setActive(arg_6_0._goadd, not var_6_1 and not var_6_2)
	gohelper.setActive(arg_6_0._gonum, not var_6_1 and var_6_2)
	gohelper.setActive(arg_6_0._imageicon.gameObject, not var_6_1 and var_6_2)
end

function var_0_0.playAnim(arg_7_0, arg_7_1)
	arg_7_0._anim:Play(arg_7_1, 0, 0)
end

return var_0_0
