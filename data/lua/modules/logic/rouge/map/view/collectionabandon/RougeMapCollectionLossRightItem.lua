module("modules.logic.rouge.map.view.collectionabandon.RougeMapCollectionLossRightItem", package.seeall)

local var_0_0 = class("RougeMapCollectionLossRightItem", UserDataDispose)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
	arg_1_0.tr = arg_1_1:GetComponent(gohelper.Type_RectTransform)

	arg_1_0:_editableInitView()
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0.click = gohelper.getClickWithDefaultAudio(arg_2_0.go)
	arg_2_0.goGrid = gohelper.findChild(arg_2_0.go, "#go_grid")
	arg_2_0.goGridItem = gohelper.findChild(arg_2_0.go, "#go_grid/#go_griditem")
	arg_2_0.simageIcon = gohelper.findChildSingleImage(arg_2_0.go, "#simage_icon")
	arg_2_0.txtName = gohelper.findChildText(arg_2_0.go, "right/#txt_name")
	arg_2_0.txtDesc = gohelper.findChildText(arg_2_0.go, "right/Scroll View/Viewport/Content/#txt_desc")
	arg_2_0.click = gohelper.findChildClickWithDefaultAudio(arg_2_0.go, "#btn_click")

	arg_2_0.click:AddClickListener(arg_2_0.onClickSelf, arg_2_0)

	arg_2_0.gridItemList = arg_2_0:getUserDataTb_()

	arg_2_0:addEventCb(RougeController.instance, RougeEvent.SwitchCollectionInfoType, arg_2_0._onSwitchCollectionInfoType, arg_2_0)
end

function var_0_0.onClickSelf(arg_3_0)
	RougeLossCollectionListModel.instance:deselectMo(arg_3_0.mo)
end

function var_0_0.update(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.mo = arg_4_2
	arg_4_0.collectionId = arg_4_0.mo.collectionId

	RougeCollectionHelper.loadShapeGrid(arg_4_0.collectionId, arg_4_0.goGrid, arg_4_0.goGridItem, arg_4_0.gridItemList)
	arg_4_0.simageIcon:LoadImage(RougeCollectionHelper.getCollectionIconUrl(arg_4_0.collectionId))

	arg_4_0.txtName.text = RougeCollectionConfig.instance:getCollectionName(arg_4_0.collectionId)

	arg_4_0:refreshDesc()
end

function var_0_0.hide(arg_5_0)
	gohelper.setActive(arg_5_0.go, false)
end

function var_0_0.show(arg_6_0)
	gohelper.setActive(arg_6_0.go, true)
end

function var_0_0.refreshDesc(arg_7_0)
	local var_7_0 = RougeCollectionDescHelper.getShowDescTypesWithoutText()

	RougeCollectionDescHelper.setCollectionDescInfos3(arg_7_0.collectionId, nil, arg_7_0.txtDesc, var_7_0)
end

function var_0_0._onSwitchCollectionInfoType(arg_8_0)
	arg_8_0:refreshDesc()
end

function var_0_0.destroy(arg_9_0)
	arg_9_0.click:RemoveClickListener()
	arg_9_0.simageIcon:UnLoadImage()
	arg_9_0:__onDispose()
end

return var_0_0
