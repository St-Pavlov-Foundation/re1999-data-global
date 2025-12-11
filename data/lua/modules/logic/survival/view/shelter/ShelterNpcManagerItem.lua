module("modules.logic.survival.view.shelter.ShelterNpcManagerItem", package.seeall)

local var_0_0 = class("ShelterNpcManagerItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goGrid = gohelper.findChild(arg_1_0.viewGO, "Grid")
	arg_1_0.goSmallItem = gohelper.findChild(arg_1_0.viewGO, "#go_SmallItem")

	gohelper.setActive(arg_1_0.goSmallItem, false)

	arg_1_0.itemList = {}

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

function var_0_0.onClickGridItem(arg_5_0, arg_5_1)
	if not arg_5_1.data then
		return
	end

	if SurvivalShelterNpcListModel.instance:setSelectNpcId(arg_5_1.data.id) then
		arg_5_0._view.viewContainer:refreshManagerView()
	end
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	arg_6_0.mo = arg_6_1

	if not arg_6_1 then
		return
	end

	local var_6_0 = arg_6_1.dataList

	for iter_6_0 = 1, math.max(#var_6_0, #arg_6_0.itemList) do
		local var_6_1 = arg_6_0:getGridItem(iter_6_0)

		arg_6_0:refreshGridItem(var_6_1, var_6_0[iter_6_0])
	end
end

function var_0_0.getGridItem(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.itemList[arg_7_1]

	if not var_7_0 then
		var_7_0 = arg_7_0:getUserDataTb_()
		var_7_0.index = arg_7_1
		var_7_0.go = gohelper.clone(arg_7_0.goSmallItem, arg_7_0.goGrid, tostring(arg_7_1))
		var_7_0.imgQuality = gohelper.findChildImage(var_7_0.go, "#image_quality")
		var_7_0.imgChess = gohelper.findChildSingleImage(var_7_0.go, "#image_Chess")
		var_7_0.txtName = gohelper.findChildTextMesh(var_7_0.go, "#txt_PartnerName")
		var_7_0.goSelect = gohelper.findChild(var_7_0.go, "#go_Selected")
		var_7_0.goOut = gohelper.findChild(var_7_0.go, "#go_Out")
		var_7_0.goTips = gohelper.findChild(var_7_0.go, "#go_Tips")
		var_7_0.txtTips = gohelper.findChildTextMesh(var_7_0.go, "#go_Tips/#txt_TentName")
		var_7_0.btn = gohelper.findButtonWithAudio(var_7_0.go)

		var_7_0.btn:AddClickListener(arg_7_0.onClickGridItem, arg_7_0, var_7_0)

		arg_7_0.itemList[arg_7_1] = var_7_0
	end

	return var_7_0
end

function var_0_0.refreshGridItem(arg_8_0, arg_8_1, arg_8_2)
	arg_8_1.data = arg_8_2

	if not arg_8_2 then
		gohelper.setActive(arg_8_1.go, false)

		return
	end

	gohelper.setActive(arg_8_1.go, true)
	gohelper.setActive(arg_8_1.goSelect, SurvivalShelterNpcListModel.instance:isSelectNpc(arg_8_2.id))
	gohelper.setActive(arg_8_1.goOut, arg_8_2:isEqualStatus(SurvivalEnum.ShelterNpcStatus.OutSide))

	local var_8_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_8_1 = var_8_0:getNpcPostion(arg_8_2.id)

	if var_8_1 then
		local var_8_2 = var_8_0:getBuildingInfo(var_8_1)

		gohelper.setActive(arg_8_1.goTips, true)

		local var_8_3 = SurvivalConfig.instance:getBuildingConfig(var_8_2.buildingId, var_8_2.level)

		arg_8_1.txtTips.text = var_8_3.name
	else
		gohelper.setActive(arg_8_1.goTips, false)
	end

	arg_8_1.txtName.text = arg_8_2.co.name

	SurvivalUnitIconHelper.instance:setNpcIcon(arg_8_1.imgChess, arg_8_2.co.headIcon)
	UISpriteSetMgr.instance:setSurvivalSprite(arg_8_1.imgQuality, string.format("survival_bag_itemquality2_%s", arg_8_2.co.rare))
end

function var_0_0.onDestroyView(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.itemList) do
		iter_9_1.btn:RemoveClickListener()
	end
end

return var_0_0
