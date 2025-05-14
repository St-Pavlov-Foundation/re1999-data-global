module("modules.logic.rouge.dlc.102.view.RougeCollectionLevelUpLeftItem", package.seeall)

local var_0_0 = class("RougeCollectionLevelUpLeftItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.click = gohelper.getClickWithDefaultAudio(arg_1_0.go)
	arg_1_0.goGrid = gohelper.findChild(arg_1_0.go, "#go_grid")
	arg_1_0.goGridItem = gohelper.findChild(arg_1_0.go, "#go_grid/#go_griditem")
	arg_1_0.simageIcon = gohelper.findChildSingleImage(arg_1_0.go, "#simage_icon")
	arg_1_0.txtName = gohelper.findChildText(arg_1_0.go, "right/#txt_name")
	arg_1_0.txtDesc = gohelper.findChildText(arg_1_0.go, "right/Scroll View/Viewport/Content/#txt_desc")
	arg_1_0.click = gohelper.findChildClickWithDefaultAudio(arg_1_0.go, "#btn_click")

	arg_1_0.click:AddClickListener(arg_1_0.onClickSelf, arg_1_0)

	arg_1_0.gridItemList = arg_1_0:getUserDataTb_()

	arg_1_0:addEventCb(RougeController.instance, RougeEvent.SwitchCollectionInfoType, arg_1_0._onSwitchCollectionInfoType, arg_1_0)
end

function var_0_0.onClickSelf(arg_2_0)
	if not RougeCollectionLevelUpListModel.instance:checkCanSelect() then
		return
	end

	gohelper.setActive(arg_2_0.go, false)
	arg_2_0._view.viewContainer:getListRemoveComp():removeByIndex(arg_2_0._index, arg_2_0.onRemoveAnimDone, arg_2_0)
end

function var_0_0.onRemoveAnimDone(arg_3_0)
	RougeCollectionLevelUpListModel.instance:selectMo(arg_3_0.mo)
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0.mo = arg_4_1
	arg_4_0.collectionId = arg_4_0.mo.collectionId
	arg_4_0.uid = arg_4_0.mo.uid

	gohelper.setActive(arg_4_0.go, true)
	RougeCollectionHelper.loadShapeGrid(arg_4_0.collectionId, arg_4_0.goGrid, arg_4_0.goGridItem, arg_4_0.gridItemList)
	arg_4_0.simageIcon:LoadImage(RougeCollectionHelper.getCollectionIconUrl(arg_4_0.collectionId))

	arg_4_0.txtName.text = RougeCollectionConfig.instance:getCollectionName(arg_4_0.collectionId)

	arg_4_0:refreshDesc()
end

function var_0_0.refreshDesc(arg_5_0)
	local var_5_0 = RougeCollectionDescHelper.getShowDescTypesWithoutText()

	RougeCollectionDescHelper.setCollectionDescInfos3(arg_5_0.collectionId, nil, arg_5_0.txtDesc, var_5_0)
end

function var_0_0._onSwitchCollectionInfoType(arg_6_0)
	arg_6_0:refreshDesc()
end

function var_0_0.onDestroy(arg_7_0)
	arg_7_0.click:RemoveClickListener()
	arg_7_0.simageIcon:UnLoadImage()
end

return var_0_0
