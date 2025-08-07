module("modules.logic.bossrush.view.v2a9.V2a9_BossRushSkillBackpackItem", package.seeall)

local var_0_0 = class("V2a9_BossRushSkillBackpackItem", AssassinBackpackItem)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "#simage_icon")
	arg_1_0._goequip = gohelper.findChild(arg_1_0.viewGO, "#go_equip")
	arg_1_0._txtequipIndex = gohelper.findChildText(arg_1_0.viewGO, "#go_equip/#txt_equipIndex")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#txt_num")
	arg_1_0._goselected = gohelper.findChild(arg_1_0.viewGO, "#go_selected")
	arg_1_0._btnclick = gohelper.findChildClickWithAudio(arg_1_0.viewGO, "#btn_click")

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
	V2a9BossRushSkillBackpackListModel.instance:selectCell(arg_4_0._index, true)

	local var_4_0 = arg_4_0._mo:getId()

	V2a9BossRushModel.instance:selectSpItemId(var_4_0)
	BossRushController.instance:dispatchEvent(BossRushEvent.OnSelectV2a9SpItem)
end

function var_0_0._editableInitView(arg_5_0)
	var_0_0.super._editableInitView(arg_5_0)
end

function var_0_0.refresh(arg_6_0)
	local var_6_0 = arg_6_0._mo:getId()

	AssassinHelper.setAssassinItemIcon(var_6_0, arg_6_0._imageicon)

	arg_6_0._txtnum.text = arg_6_0._mo:getCount()

	local var_6_1 = V2a9BossRushModel.instance:getEquipIndex(arg_6_0._mo.stage, var_6_0)

	if var_6_1 then
		arg_6_0._txtequipIndex.text = var_6_1
	end

	gohelper.setActive(arg_6_0._goequip, var_6_1 and true or false)
end

return var_0_0
