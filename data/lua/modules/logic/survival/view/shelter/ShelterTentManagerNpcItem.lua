module("modules.logic.survival.view.shelter.ShelterTentManagerNpcItem", package.seeall)

local var_0_0 = class("ShelterTentManagerNpcItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.imgQuality = gohelper.findChildImage(arg_1_0.viewGO, "#image_quality")
	arg_1_0.imageNpc = gohelper.findChildImage(arg_1_0.viewGO, "#image_Chess")
	arg_1_0.txtName = gohelper.findChildTextMesh(arg_1_0.viewGO, "#txt_PartnerName")
	arg_1_0.goSelected = gohelper.findChild(arg_1_0.viewGO, "#go_Selected")
	arg_1_0.goTips = gohelper.findChild(arg_1_0.viewGO, "#go_Tips")
	arg_1_0.txtBuildName = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_Tips/#txt_TentName")
	arg_1_0.btn = gohelper.findButtonWithAudio(arg_1_0.viewGO)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btn, arg_2_0.onClickNpcItem, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0.btn)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onClickNpcItem(arg_5_0)
	if not arg_5_0.mo then
		return
	end

	if SurvivalShelterTentListModel.instance:isQuickSelect() then
		SurvivalShelterTentListModel.instance:quickSelectNpc(arg_5_0.mo.id)
	else
		SurvivalShelterTentListModel.instance:setSelectNpc(arg_5_0.mo.id)
		arg_5_0._view.viewContainer:refreshManagerSelectPanel()
	end
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	arg_6_0.mo = arg_6_1

	if not arg_6_1 then
		return
	end

	arg_6_0:refreshItem(arg_6_1)
end

function var_0_0.refreshItem(arg_7_0, arg_7_1)
	local var_7_0 = SurvivalShelterTentListModel.instance:getSelectNpc()

	gohelper.setActive(arg_7_0.goSelected, var_7_0 == arg_7_1.id)

	local var_7_1 = SurvivalShelterModel.instance:getWeekInfo()
	local var_7_2 = var_7_1:getNpcPostion(arg_7_1.id)

	if var_7_2 then
		local var_7_3 = var_7_1:getBuildingInfo(var_7_2)

		gohelper.setActive(arg_7_0.goTips, true)

		local var_7_4 = SurvivalConfig.instance:getBuildingConfig(var_7_3.buildingId, var_7_3.level)

		arg_7_0.txtBuildName.text = var_7_4.name
	else
		gohelper.setActive(arg_7_0.goTips, false)
	end

	arg_7_0.txtName.text = arg_7_1.co.name

	UISpriteSetMgr.instance:setV2a2ChessSprite(arg_7_0.imageNpc, arg_7_1.co.headIcon)
	UISpriteSetMgr.instance:setSurvivalSprite(arg_7_0.imgQuality, string.format("survival_bag_itemquality2_%s", arg_7_1.co.rare))
end

function var_0_0.onDestroyView(arg_8_0)
	return
end

return var_0_0
