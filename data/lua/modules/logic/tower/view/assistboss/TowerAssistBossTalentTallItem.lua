module("modules.logic.tower.view.assistboss.TowerAssistBossTalentTallItem", package.seeall)

local var_0_0 = class("TowerAssistBossTalentTallItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.imgTalent = gohelper.findChildImage(arg_1_0.viewGO, "Title/#image_TalentIcon")
	arg_1_0.txtTitle = gohelper.findChildTextMesh(arg_1_0.viewGO, "Title/#txt_Title")
	arg_1_0.txtDesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "#txt_Descr")

	SkillHelper.addHyperLinkClick(arg_1_0.txtDesc, arg_1_0._onHyperLinkClick, arg_1_0)

	arg_1_0.descFixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0.txtDesc.gameObject, FixTmpBreakLine)

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
	return
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	arg_5_0._mo = arg_5_1

	if not arg_5_1 then
		gohelper.setActive(arg_5_0.viewGO, false)

		return
	end

	gohelper.setActive(arg_5_0.viewGO, true)

	local var_5_0 = arg_5_0._mo.config

	arg_5_0.txtTitle.text = var_5_0.nodeName
	arg_5_0.txtDesc.text = SkillHelper.buildDesc(var_5_0.nodeDesc)

	arg_5_0.descFixTmpBreakLine:refreshTmpContent(arg_5_0.txtDesc)
	TowerConfig.instance:setTalentImg(arg_5_0.imgTalent, var_5_0)
end

function var_0_0._onHyperLinkClick(arg_6_0, arg_6_1, arg_6_2)
	CommonBuffTipController.instance:openCommonTipView(tonumber(arg_6_1), arg_6_2)
end

function var_0_0.onDestroyView(arg_7_0)
	return
end

return var_0_0
