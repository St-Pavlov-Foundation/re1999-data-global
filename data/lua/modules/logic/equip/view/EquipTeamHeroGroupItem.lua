module("modules.logic.equip.view.EquipTeamHeroGroupItem", package.seeall)

local var_0_0 = class("EquipTeamHeroGroupItem", BaseChildView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_info/#simage_icon")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")
	arg_1_0._imagerare = gohelper.findChildImage(arg_1_0.viewGO, "#go_info/#rare")
	arg_1_0._txtequipnamecn = gohelper.findChildText(arg_1_0.viewGO, "#go_info/#txt_equipnamecn")
	arg_1_0._txtequipnameen = gohelper.findChildText(arg_1_0.viewGO, "#go_info/#txt_equipnameen")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_info/#simage_bg")
	arg_1_0._goinfo = gohelper.findChild(arg_1_0.viewGO, "#go_info")

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
	if arg_4_0._equipMO then
		EquipController.instance:openEquipTeamShowView({
			arg_4_0._equipMO.uid,
			true
		})
	end
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._rareLineColor = {
		"#DCF5D5",
		"#9EB7D7",
		"#7D5B7E",
		"#D2D79E",
		"#D6A181"
	}
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0 = EquipTeamListModel.instance:getTeamEquip()[1]

	arg_7_0._equipMO = EquipModel.instance:getEquip(var_7_0)

	arg_7_0:showEquip()
end

function var_0_0.setHeroGroupType(arg_8_0)
	arg_8_0._heroGroupType = true
end

function var_0_0.showEquip(arg_9_0)
	local var_9_0 = arg_9_0._equipMO ~= nil

	gohelper.setActive(arg_9_0._simageicon.gameObject, var_9_0)

	if var_9_0 then
		arg_9_0._simageicon:LoadImage(ResUrl.getEquipSuit(arg_9_0._equipMO.config.icon))
		arg_9_0._simagebg:LoadImage(ResUrl.getEquipBg("bg_xinxiangzhezhao.png"))

		arg_9_0._txtequipnamecn.text = arg_9_0._equipMO.config.name
		arg_9_0._txtequipnameen.text = arg_9_0._equipMO.config.name_en

		SLFramework.UGUI.GuiHelper.SetColor(arg_9_0._imagerare, arg_9_0._rareLineColor[arg_9_0._equipMO.config.rare])
	end

	gohelper.setActive(arg_9_0._goinfo, var_9_0)
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0._simageicon:UnLoadImage()
	arg_11_0._simagebg:UnLoadImage()
end

return var_0_0
