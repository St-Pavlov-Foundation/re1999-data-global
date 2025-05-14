module("modules.logic.rouge.view.RougeCollectionBaseSlotItem", package.seeall)

local var_0_0 = class("RougeCollectionBaseSlotItem", UserDataDispose)

function var_0_0.onInit(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.viewGO = arg_1_1
	arg_1_0._gocenter = gohelper.findChild(arg_1_0.viewGO, "go_center")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "go_center/simage_icon")
	arg_1_0._goholetool = gohelper.findChild(arg_1_0.viewGO, "go_center/go_holetool")
	arg_1_0._goholeitem = gohelper.findChild(arg_1_0.viewGO, "go_center/go_holetool/go_holeitem")
	arg_1_0._imageenchanticon = gohelper.findChild(arg_1_0.viewGO, "go_center/go_holetool/go_holeitem/image_enchanticon")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0:addEventCb(RougeCollectionEnchantController.instance, RougeEvent.UpdateCollectionEnchant, arg_2_0.updateEnchantInfo, arg_2_0)
	arg_2_0:addEventCb(RougeCollectionChessController.instance, RougeEvent.SetCollectionVisible, arg_2_0.setCollectionVisibleCallBack, arg_2_0)
	arg_2_0:addEventCb(RougeCollectionChessController.instance, RougeEvent.Failed2PlaceSlotCollection, arg_2_0.failed2PlaceSlotCollection, arg_2_0)

	arg_2_0._holeItemTab = arg_2_0:getUserDataTb_()
	arg_2_0._canvasgroup = gohelper.onceAddComponent(arg_2_0.viewGO, gohelper.Type_CanvasGroup)

	arg_2_0:setPerCellWidthAndHeight()
end

function var_0_0.onUpdateMO(arg_3_0, arg_3_1)
	arg_3_0._mo = arg_3_1

	arg_3_0:refreshCollectionIcon()
	arg_3_0:updateItemSize()
	arg_3_0:refreshAllHoles()
	arg_3_0:onUpdateRotateAngle()
	arg_3_0:setItemVisible(true)
	arg_3_0:updateIconPosition()
	arg_3_0:updateCollectionPosition()
end

function var_0_0.setPerCellWidthAndHeight(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._perCellWidth = arg_4_1 or RougeCollectionHelper.CollectionSlotCellSize.x
	arg_4_0._perCellHeight = arg_4_2 or RougeCollectionHelper.CollectionSlotCellSize.y
end

function var_0_0.refreshCollectionIcon(arg_5_0)
	arg_5_0._collectionCfg = RougeCollectionConfig.instance:getCollectionCfg(arg_5_0._mo.cfgId)

	local var_5_0 = RougeCollectionHelper.getCollectionIconUrl(arg_5_0._mo.cfgId)

	arg_5_0._simageicon:LoadImage(var_5_0)
	arg_5_0:setIconRoateAngle()
	RougeCollectionHelper.computeAndSetCollectionIconScale(arg_5_0._mo.cfgId, arg_5_0._simageicon.transform, arg_5_0._perCellWidth, arg_5_0._perCellHeight)
end

function var_0_0.onUpdateRotateAngle(arg_6_0)
	arg_6_0:updateItemSize()
	arg_6_0:setIconRoateAngle()
	arg_6_0:updateHoleContainerPos()
end

function var_0_0.updateItemSize(arg_7_0)
	local var_7_0 = arg_7_0._mo:getRotation()
	local var_7_1, var_7_2 = RougeCollectionHelper.getCollectionSizeAfterRotation(arg_7_0._mo.cfgId, var_7_0)
	local var_7_3 = arg_7_0._perCellWidth * var_7_1
	local var_7_4 = arg_7_0._perCellHeight * var_7_2

	recthelper.setSize(arg_7_0.viewGO.transform, var_7_3, var_7_4)
end

function var_0_0.refreshAllHoles(arg_8_0)
	local var_8_0 = arg_8_0._mo:getAllEnchantId() or {}

	gohelper.CreateObjList(arg_8_0, arg_8_0.refrehHole, var_8_0, arg_8_0._goholetool, arg_8_0._goholeitem)
	arg_8_0:updateHoleContainerPos()
end

var_0_0.BaseHoleContainerAnchorPosX = 0

function var_0_0.updateHoleContainerPos(arg_9_0)
	if (arg_9_0._collectionCfg.holeNum or 0) <= 0 then
		return
	end

	local var_9_0 = arg_9_0._mo:getRotation()
	local var_9_1 = RougeCollectionConfig.instance:getShapeMatrix(arg_9_0._mo.cfgId, var_9_0)
	local var_9_2 = var_9_1[tabletool.len(var_9_1)]
	local var_9_3 = 0
	local var_9_4 = #var_9_2

	for iter_9_0 = var_9_4, 1, -1 do
		if var_9_2[iter_9_0] and var_9_2[iter_9_0] > 0 then
			var_9_3 = var_9_4 - iter_9_0

			break
		end
	end

	local var_9_5 = -var_9_3 * RougeCollectionHelper.CollectionSlotCellSize.x
	local var_9_6 = var_0_0.BaseHoleContainerAnchorPosX + var_9_5

	recthelper.setAnchorX(arg_9_0._goholetool.transform, var_9_6)
end

function var_0_0.refrehHole(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = gohelper.findChild(arg_10_1, "go_none")
	local var_10_1 = gohelper.findChild(arg_10_1, "go_get")
	local var_10_2 = arg_10_2 and arg_10_2 > 0

	gohelper.setActive(var_10_1, var_10_2)
	gohelper.setActive(var_10_0, not var_10_2)

	if not arg_10_0._holeItemTab[arg_10_3] then
		arg_10_0._holeItemTab[arg_10_3] = arg_10_1
	end

	if not var_10_2 then
		return
	end

	local var_10_3 = gohelper.findChildSingleImage(arg_10_1, "go_get/image_enchanticon")
	local var_10_4, var_10_5 = arg_10_0._mo:getEnchantIdAndCfgId(arg_10_3)
	local var_10_6 = RougeCollectionHelper.getCollectionIconUrl(var_10_5)

	var_10_3:LoadImage(var_10_6)
end

function var_0_0.getHoleObj(arg_11_0, arg_11_1)
	return arg_11_0._holeItemTab and arg_11_0._holeItemTab[arg_11_1]
end

function var_0_0.getAllHoleObj(arg_12_0)
	return arg_12_0._holeItemTab
end

function var_0_0.setCollectionVisibleCallBack(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_0._mo and arg_13_0._mo.id == arg_13_1 then
		arg_13_0:setItemVisible(arg_13_2)
	end
end

function var_0_0.setItemVisible(arg_14_0, arg_14_1)
	gohelper.setActive(arg_14_0.viewGO, arg_14_1)
	arg_14_0:setCanvasGroupVisible(arg_14_1)
end

function var_0_0.setCanvasGroupVisible(arg_15_0, arg_15_1)
	arg_15_0._canvasgroup.alpha = arg_15_1 and 1 or 0

	arg_15_0:setCollectionInteractable(arg_15_1)
end

function var_0_0.setCollectionInteractable(arg_16_0, arg_16_1)
	arg_16_0._canvasgroup.interactable = arg_16_1
	arg_16_0._canvasgroup.blocksRaycasts = arg_16_1
end

function var_0_0.updateEnchantInfo(arg_17_0, arg_17_1)
	if not arg_17_0._mo or arg_17_0._mo.id ~= arg_17_1 then
		return
	end

	local var_17_0 = arg_17_0._mo:getAllEnchantId()

	if not var_17_0 then
		return
	end

	for iter_17_0, iter_17_1 in pairs(var_17_0) do
		local var_17_1 = arg_17_0:getHoleObj(iter_17_0)

		if var_17_1 then
			arg_17_0:refrehHole(var_17_1, iter_17_1, iter_17_0)
		end
	end
end

function var_0_0.setHoleToolVisible(arg_18_0, arg_18_1)
	gohelper.setActive(arg_18_0._goholetool, arg_18_1)
end

function var_0_0.setIconRoateAngle(arg_19_0)
	local var_19_0 = arg_19_0._mo:getRotation()
	local var_19_1 = RougeCollectionHelper.getRotateAngleByRotation(var_19_0)

	transformhelper.setLocalRotation(arg_19_0._simageicon.transform, 0, 0, var_19_1)
end

function var_0_0.updateIconPosition(arg_20_0)
	local var_20_0 = arg_20_0._mo.cfgId
	local var_20_1 = RougeCollectionConfig.instance:getOriginEditorParam(var_20_0, RougeEnum.CollectionEditorParamType.IconOffset)

	recthelper.setAnchor(arg_20_0._gocenter.transform, var_20_1.x, var_20_1.y)
end

function var_0_0.updateCollectionPosition(arg_21_0)
	if not arg_21_0._mo or not arg_21_0._mo.getLeftTopPos then
		return
	end

	local var_21_0 = arg_21_0._mo:getLeftTopPos()
	local var_21_1, var_21_2 = RougeCollectionHelper.getCollectionPlacePosition(var_21_0, arg_21_0._perCellWidth, arg_21_0._perCellHeight)

	arg_21_0:setCollectionPosition(var_21_1, var_21_2)
end

function var_0_0.setCollectionPosition(arg_22_0, arg_22_1, arg_22_2)
	recthelper.setAnchor(arg_22_0.viewGO.transform, arg_22_1, arg_22_2)
end

function var_0_0.failed2PlaceSlotCollection(arg_23_0, arg_23_1)
	if arg_23_0._mo and arg_23_0._mo.id == arg_23_1 then
		arg_23_0:setItemVisible(true)
	end
end

function var_0_0.reset(arg_24_0)
	arg_24_0._mo = nil

	arg_24_0:setItemVisible(false)
end

function var_0_0.destroy(arg_25_0)
	arg_25_0._simageicon:UnLoadImage()

	if arg_25_0._holeItemTab then
		for iter_25_0, iter_25_1 in pairs(arg_25_0._holeItemTab) do
			gohelper.findChildSingleImage(iter_25_1, "go_get/image_enchanticon"):UnLoadImage()
		end
	end

	arg_25_0:__onDispose()
end

return var_0_0
