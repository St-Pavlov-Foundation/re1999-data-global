module("modules.logic.versionactivity2_7.act191.view.Act191EnhanceTipView", package.seeall)

local var_0_0 = class("Act191EnhanceTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Close")
	arg_1_0._goRoot = gohelper.findChild(arg_1_0.viewGO, "#go_Root")
	arg_1_0._simageIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Root/#simage_Icon")
	arg_1_0._txtName = gohelper.findChildText(arg_1_0.viewGO, "#go_Root/#txt_Name")
	arg_1_0._txtDesc = gohelper.findChildText(arg_1_0.viewGO, "#go_Root/scroll_desc/Viewport/go_desccontent/#txt_Desc")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
end

function var_0_0._btnCloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.actId = Activity191Model.instance:getCurActId()
end

function var_0_0.onOpen(arg_6_0)
	gohelper.setActive(arg_6_0._btnClose, not arg_6_0.viewParam.notShowBg)

	if arg_6_0.viewParam.pos then
		local var_6_0 = recthelper.rectToRelativeAnchorPos(arg_6_0.viewParam.pos, arg_6_0.viewGO.transform)

		recthelper.setAnchor(arg_6_0._goRoot.transform, var_6_0.x + 85, 8)
	end

	local var_6_1 = arg_6_0.viewParam.co

	if var_6_1 then
		arg_6_0._simageIcon:LoadImage(ResUrl.getAct174BuffIcon(var_6_1.icon))

		arg_6_0._txtName.text = var_6_1.name
		arg_6_0._txtDesc.text = var_6_1.desc

		local var_6_2 = SkillHelper.addLink(var_6_1.desc)
		local var_6_3 = string.splitToNumber(var_6_1.effects, "|")[1]
		local var_6_4 = lua_activity191_effect.configDict[var_6_3]

		if var_6_4 then
			if var_6_4.type == Activity191Enum.EffectType.EnhanceHero then
				arg_6_0._txtDesc.text = Activity191Helper.buildDesc(var_6_2, Activity191Enum.HyperLinkPattern.EnhanceDestiny, var_6_4.typeParam)

				SkillHelper.addHyperLinkClick(arg_6_0._txtDesc, Activity191Helper.clickHyperLinkDestiny)
			elseif var_6_4.type == Activity191Enum.EffectType.EnhanceItem then
				arg_6_0._txtDesc.text = Activity191Helper.buildDesc(var_6_2, Activity191Enum.HyperLinkPattern.EnhanceItem, var_6_4.typeParam .. "#")

				SkillHelper.addHyperLinkClick(arg_6_0._txtDesc, Activity191Helper.clickHyperLinkItem)
			else
				arg_6_0._txtDesc.text = var_6_2
			end
		else
			arg_6_0._txtDesc.text = var_6_2
		end
	end
end

function var_0_0.onUpdateParam(arg_7_0)
	arg_7_0:onOpen()
end

return var_0_0
