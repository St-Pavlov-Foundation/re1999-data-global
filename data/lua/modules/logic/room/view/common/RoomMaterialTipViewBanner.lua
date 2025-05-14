module("modules.logic.room.view.common.RoomMaterialTipViewBanner", package.seeall)

local var_0_0 = class("RoomMaterialTipViewBanner", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobannerContent = gohelper.findChild(arg_1_0.viewGO, "left/banner/#go_bannerContent")
	arg_1_0._goroominfoItem = gohelper.findChild(arg_1_0.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem")
	arg_1_0._goslider = gohelper.findChild(arg_1_0.viewGO, "left/banner/#go_slider")
	arg_1_0._gobannerscroll = gohelper.findChild(arg_1_0.viewGO, "left/banner/#go_bannerscroll")
	arg_1_0._gobannerSelectItem = gohelper.findChild(arg_1_0.viewGO, "left/banner/#go_slider/go_bannerSelectItem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._bannerscroll:AddDragBeginListener(arg_2_0._onScrollDragBegin, arg_2_0)
	arg_2_0._bannerscroll:AddDragEndListener(arg_2_0._onScrollDragEnd, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._bannerscroll:RemoveDragBeginListener()
	arg_3_0._bannerscroll:RemoveDragEndListener()
end

function var_0_0._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0._gojumpItem, false)

	arg_4_0._bannerscroll = SLFramework.UGUI.UIDragListener.Get(arg_4_0._gobannerscroll)
	arg_4_0._infoItemTbList = {}
	arg_4_0._infoItemDataList = {}
	arg_4_0._pageItemTbList = {}

	arg_4_0:_createInfoItemUserDataTb_(arg_4_0._goroominfoItem)
	arg_4_0:_createPageItemUserDataTb_(arg_4_0._gobannerSelectItem)
	transformhelper.setLocalPosXY(arg_4_0._gobannerContent.transform, -1, 0)
end

function var_0_0._getMaxPage(arg_5_0)
	return arg_5_0._infoItemDataList and #arg_5_0._infoItemDataList or 0
end

function var_0_0._checkCurPage(arg_6_0)
	local var_6_0 = arg_6_0:_getMaxPage()

	if not arg_6_0._curPage or var_6_0 < arg_6_0._curPage then
		arg_6_0._curPage = 1
	end

	if arg_6_0._curPage < 1 then
		arg_6_0._curPage = var_6_0
	end

	return arg_6_0._curPage
end

function var_0_0._isFirstPage(arg_7_0)
	return arg_7_0:_checkCurPage() <= 1
end

function var_0_0._isLastPage(arg_8_0)
	return arg_8_0:_checkCurPage() >= arg_8_0:_getMaxPage()
end

function var_0_0._getItemDataList(arg_9_0)
	local var_9_0 = {}
	local var_9_1 = {
		itemId = arg_9_0.viewParam.id,
		itemType = arg_9_0.viewParam.type,
		roomBuildingLevel = arg_9_0.viewParam.roomBuildingLevel,
		roomSkinId = arg_9_0.viewParam.roomSkinId
	}

	table.insert(var_9_0, var_9_1)

	return var_9_0
end

function var_0_0._onScrollDragBegin(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._scrollStartPosX = GamepadController.instance:getMousePosition().x
end

function var_0_0._onScrollDragEnd(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = GamepadController.instance:getMousePosition().x - arg_11_0._scrollStartPosX

	if var_11_0 > 80 then
		arg_11_0:_runSwithPage(true)
	elseif var_11_0 < -80 then
		arg_11_0:_runSwithPage(false)
	end
end

function var_0_0._startAutoSwitch(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._onSwitch, arg_12_0)

	if arg_12_0:_getMaxPage() > 1 then
		TaskDispatcher.runRepeat(arg_12_0._onSwitch, arg_12_0, 3)
	end
end

function var_0_0._onSwitch(arg_13_0)
	if arg_13_0:_getMaxPage() <= 1 then
		TaskDispatcher.cancelTask(arg_13_0._onSwitch, arg_13_0)

		return
	end

	if not arg_13_0._nextRunSwitchTime or arg_13_0._nextRunSwitchTime <= Time.time then
		arg_13_0:_runSwithPage(false)
	end
end

function var_0_0._runSwithPage(arg_14_0, arg_14_1)
	arg_14_0._nextRunSwitchTime = Time.time + 2

	local var_14_0 = arg_14_0:_checkCurPage()
	local var_14_1 = false

	if arg_14_1 then
		var_14_1 = arg_14_0:_isFirstPage()
		arg_14_0._curPage = var_14_0 - 1
	else
		var_14_1 = arg_14_0:_isLastPage()
		arg_14_0._curPage = var_14_0 + 1
	end

	if var_14_1 and arg_14_0:_getMaxPage() > 2 then
		local var_14_2 = arg_14_1 and arg_14_0:_getMaxPage() - 1 or 2
		local var_14_3 = arg_14_0:_getPosXByPage(var_14_2)

		recthelper.setAnchorX(arg_14_0._gobannerContent.transform, -var_14_3)
	end

	if var_14_0 == arg_14_0:_checkCurPage() then
		return
	end

	arg_14_0:_refreshUI()
end

function var_0_0._refreshUI(arg_15_0)
	arg_15_0:_refreshPageUI()
	arg_15_0:_refreshInfoUI()
end

function var_0_0._refreshPageUI(arg_16_0)
	local var_16_0 = arg_16_0:_getMaxPage()
	local var_16_1 = arg_16_0:_checkCurPage()

	gohelper.setActive(arg_16_0._goslider, var_16_0 > 1)

	for iter_16_0 = 1, var_16_0 do
		local var_16_2 = arg_16_0._pageItemTbList[iter_16_0]

		if not var_16_2 then
			local var_16_3 = gohelper.clone(arg_16_0._gobannerSelectItem, arg_16_0._goslider, "go_bannerSelectItem" .. iter_16_0)

			var_16_2 = arg_16_0:_createPageItemUserDataTb_(var_16_3)
		end

		arg_16_0:_updatePageItemUI(var_16_2, iter_16_0 == var_16_1)
		gohelper.setActive(var_16_2._go, true)
	end

	for iter_16_1 = var_16_0 + 1, #arg_16_0._pageItemTbList do
		local var_16_4 = arg_16_0._pageItemTbList[iter_16_1]

		gohelper.setActive(var_16_4._go, false)
	end
end

function var_0_0._refreshInfoUI(arg_17_0)
	local var_17_0 = arg_17_0:_getMaxPage()
	local var_17_1 = arg_17_0:_checkCurPage()
	local var_17_2 = math.min(3, var_17_0)

	for iter_17_0 = #arg_17_0._infoItemTbList + 1, var_17_2 do
		local var_17_3 = gohelper.clone(arg_17_0._goroominfoItem, arg_17_0._gobannerContent, "go_bannerSelectItem" .. iter_17_0)

		arg_17_0:_createInfoItemUserDataTb_(var_17_3)
	end

	local var_17_4 = 0

	if var_17_0 < #arg_17_0._infoItemTbList or arg_17_0:_isFirstPage() then
		var_17_4 = 0
	elseif arg_17_0:_isLastPage() then
		var_17_4 = var_17_0 - 3
	else
		var_17_4 = var_17_1 - 2
	end

	for iter_17_1 = 1, #arg_17_0._infoItemTbList do
		arg_17_0:_refreshInfoItem(iter_17_1, var_17_4 + iter_17_1)
	end

	if var_17_0 > 0 then
		local var_17_5 = arg_17_0:_getPosXByPage(var_17_1)

		ZProj.TweenHelper.DOAnchorPosX(arg_17_0._gobannerContent.transform, -var_17_5, 0.75)
	end
end

function var_0_0._refreshInfoItem(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0._infoItemDataList[arg_18_2]
	local var_18_1 = arg_18_0._infoItemTbList[arg_18_1]

	if var_18_0 then
		if var_18_0.roomSkinId then
			arg_18_0:_updateInfoRoomSkinUI(var_18_1, var_18_0.roomSkinId)
		else
			arg_18_0:_updateInfoItemUI(var_18_1, var_18_0.itemId, var_18_0.itemType, var_18_0.roomBuildingLevel)
		end

		local var_18_2 = arg_18_0:_getPosXByPage(arg_18_2)

		transformhelper.setLocalPosXY(var_18_1._go.transform, var_18_2, 0)
	end

	if var_18_1 then
		gohelper.setActive(var_18_1._go, var_18_0 and true or false)
	end
end

function var_0_0._getPosXByPage(arg_19_0, arg_19_1)
	return (arg_19_1 - 1) * 1030
end

function var_0_0._createPageItemUserDataTb_(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0:getUserDataTb_()

	var_20_0._go = arg_20_1
	var_20_0._gonomalstar = gohelper.findChild(arg_20_1, "go_nomalstar")
	var_20_0._golightstar = gohelper.findChild(arg_20_1, "go_lightstar")

	table.insert(arg_20_0._pageItemTbList, var_20_0)

	return var_20_0
end

function var_0_0._updatePageItemUI(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_1

	gohelper.setActive(var_21_0._gonomalstar, not arg_21_2)
	gohelper.setActive(var_21_0._golightstar, arg_21_2)
end

function var_0_0._createInfoItemUserDataTb_(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:getUserDataTb_()

	var_22_0._go = arg_22_1
	var_22_0._simagetheme = gohelper.findChildSingleImage(arg_22_1, "iconmask/simage_theme")
	var_22_0._gotag = gohelper.findChild(arg_22_1, "#go_tag")
	var_22_0._txtdesc = gohelper.findChildText(arg_22_1, "txt_desc")
	var_22_0._txtname = gohelper.findChildText(arg_22_1, "txt_desc/txt_name")
	var_22_0._goitemContent = gohelper.findChild(arg_22_1, "go_itemContent")
	var_22_0._goitemEnergy = gohelper.findChild(arg_22_1, "go_itemContent/bg/go_itemEnergy")
	var_22_0._goitemBlock = gohelper.findChild(arg_22_1, "go_itemContent/bg/go_itemBlock")
	var_22_0._txtenergynum = gohelper.findChildText(arg_22_1, "go_itemContent/bg/go_itemEnergy/txt_energynum")
	var_22_0._txtblocknum = gohelper.findChildText(arg_22_1, "go_itemContent/bg/go_itemBlock/txt_blocknum")
	var_22_0._simageinfobg = gohelper.findChildSingleImage(arg_22_1, "simage_infobg")
	arg_22_0._infoItemTbList = arg_22_0._infoItemTbList or {}

	table.insert(arg_22_0._infoItemTbList, var_22_0)

	return var_22_0
end

function var_0_0._updateInfoItemUI(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	local var_23_0 = arg_23_1
	local var_23_1 = ItemModel.instance:getItemConfig(arg_23_3, arg_23_2)

	var_23_0._txtdesc.text = var_23_1.desc
	var_23_0._txtname.text = var_23_1.name

	local var_23_2 = arg_23_3 == MaterialEnum.MaterialType.BlockPackage
	local var_23_3 = arg_23_3 == MaterialEnum.MaterialType.BlockPackage or arg_23_3 == MaterialEnum.MaterialType.Building

	if var_23_3 and arg_23_3 == MaterialEnum.MaterialType.Building and var_23_1.buildDegree <= 0 then
		var_23_3 = false
	end

	gohelper.setActive(var_23_0._goitemContent, var_23_2 or var_23_3)
	gohelper.setActive(var_23_0._goitemBlock, var_23_2)
	gohelper.setActive(var_23_0._goitemEnergy, var_23_3)
	gohelper.setActive(var_23_0._gotag, false)
	var_23_0._simageinfobg:LoadImage(ResUrl.getRoomImage("bg_zhezhao_yinying"))

	if arg_23_3 == MaterialEnum.MaterialType.Building then
		var_23_0._txtenergynum.text = var_23_1.buildDegree

		local var_23_4

		if arg_23_4 and arg_23_4 >= 0 then
			local var_23_5 = RoomConfig.instance:getLevelGroupConfig(arg_23_2, arg_23_4)

			var_23_4 = var_23_5 and var_23_5.rewardIcon
		end

		if string.nilorempty(var_23_4) then
			var_23_4 = var_23_1.rewardIcon
		end

		var_23_0._simagetheme:LoadImage(ResUrl.getRoomBuildingRewardIcon(var_23_4))
	elseif arg_23_3 == MaterialEnum.MaterialType.BlockPackage then
		var_23_0._simagetheme:LoadImage(ResUrl.getRoomBlockPackageRewardIcon(var_23_1.rewardIcon))

		local var_23_6 = 0
		local var_23_7 = RoomConfig.instance:getBlockListByPackageId(arg_23_2) or {}

		for iter_23_0 = 1, #var_23_7 do
			local var_23_8 = var_23_7[iter_23_0]

			if var_23_8.ownType ~= RoomBlockEnum.OwnType.Special or RoomModel.instance:isHasBlockById(var_23_8.blockId) then
				var_23_6 = var_23_6 + 1
			end
		end

		if var_23_6 < 1 and #var_23_7 >= 1 then
			var_23_6 = 1
		end

		var_23_0._txtenergynum.text = var_23_1.blockBuildDegree * var_23_6
		var_23_0._txtblocknum.text = var_23_6
	elseif arg_23_3 == MaterialEnum.MaterialType.RoomTheme then
		var_23_0._simagetheme:LoadImage(ResUrl.getRoomThemeRewardIcon(var_23_1.rewardIcon))
	elseif arg_23_3 == MaterialEnum.MaterialType.SpecialBlock then
		local var_23_9 = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.BlockPackage, RoomBlockPackageEnum.ID.RoleBirthday)

		if var_23_9 then
			var_23_0._simagetheme:LoadImage(ResUrl.getRoomBlockPackageRewardIcon(var_23_9.rewardIcon))
		end
	end
end

function var_0_0._updateInfoRoomSkinUI(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_1

	gohelper.setActive(var_24_0._gotag, true)
	gohelper.setActive(var_24_0._goitemContent, false)
	var_24_0._simageinfobg:LoadImage(ResUrl.getRoomImage("bg_zhezhao_yinying"))

	local var_24_1 = RoomConfig.instance:getRoomSkinName(arg_24_2)

	var_24_0._txtname.text = var_24_1

	local var_24_2 = RoomConfig.instance:getRoomSkinDesc(arg_24_2)

	var_24_0._txtdesc.text = var_24_2

	local var_24_3 = RoomConfig.instance:getRoomSkinBannerIcon(arg_24_2)
	local var_24_4 = ResUrl.getRoomBuildingRewardIcon(var_24_3)

	var_24_0._simagetheme:LoadImage(var_24_4)
end

function var_0_0.onUpdateParam(arg_25_0)
	arg_25_0._infoItemDataList = {}

	tabletool.addValues(arg_25_0._infoItemDataList, arg_25_0:_getItemDataList())
	arg_25_0:_refreshUI()
	arg_25_0:_startAutoSwitch()
end

function var_0_0.onOpen(arg_26_0)
	arg_26_0._infoItemDataList = {}

	tabletool.addValues(arg_26_0._infoItemDataList, arg_26_0:_getItemDataList())
	arg_26_0:_refreshUI()
	arg_26_0:_startAutoSwitch()
end

function var_0_0.onClose(arg_27_0)
	return
end

function var_0_0.onDestroyView(arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0._onSwitch, arg_28_0)

	for iter_28_0 = 1, #arg_28_0._infoItemTbList do
		arg_28_0._infoItemTbList[iter_28_0]._simagetheme:UnLoadImage()
		arg_28_0._infoItemTbList[iter_28_0]._simageinfobg:UnLoadImage()
	end
end

return var_0_0
