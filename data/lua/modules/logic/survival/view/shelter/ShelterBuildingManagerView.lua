module("modules.logic.survival.view.shelter.ShelterBuildingManagerView", package.seeall)

local var_0_0 = class("ShelterBuildingManagerView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goBase = gohelper.findChild(arg_1_0.viewGO, "Panel/Left/#scroll_List/Viewport/Content/#go_Base")
	arg_1_0.goTent = gohelper.findChild(arg_1_0.viewGO, "Panel/Left/#scroll_List/Viewport/Content/#go_Tent")
	arg_1_0.goTentGrid = gohelper.findChild(arg_1_0.goTent, "#go_GridExpand")
	arg_1_0.goBaseItem = gohelper.findChild(arg_1_0.viewGO, "Panel/Left/#scroll_List/Viewport/Content/#go_Base/#go_BaseItem")
	arg_1_0.goBaseSmallItem = gohelper.findChild(arg_1_0.viewGO, "Panel/Left/#scroll_List/Viewport/Content/#go_baseSmallItem")
	arg_1_0.goSmallItem = gohelper.findChild(arg_1_0.viewGO, "Panel/Left/#scroll_List/Viewport/Content/#go_SmallItem")

	gohelper.setActive(arg_1_0.goBaseItem, false)
	gohelper.setActive(arg_1_0.goBaseSmallItem, false)
	gohelper.setActive(arg_1_0.goSmallItem, false)

	arg_1_0.baseItemList = {}
	arg_1_0.smallItemList = {}
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnBuildingInfoUpdate, arg_2_0.onBuildingInfoUpdate, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnBuildingInfoUpdate, arg_3_0.onBuildingInfoUpdate, arg_3_0)
end

function var_0_0.onBuildingInfoUpdate(arg_4_0)
	arg_4_0:refreshView()
end

function var_0_0.onClickBaseSmallItem(arg_5_0, arg_5_1)
	if not arg_5_1.data then
		return
	end

	local var_5_0 = arg_5_1.data.id

	if SurvivalShelterBuildingListModel.instance:setSelectBuilding(var_5_0) then
		arg_5_0:refreshView()
	end
end

function var_0_0.onClickSmallItem(arg_6_0, arg_6_1)
	if not arg_6_1.data then
		return
	end

	local var_6_0 = arg_6_1.data.id

	if SurvivalShelterBuildingListModel.instance:setSelectBuilding(var_6_0) then
		arg_6_0:refreshView()
	end
end

function var_0_0.onOpen(arg_7_0)
	SurvivalShelterBuildingListModel.instance:initViewParam()
	arg_7_0:refreshView()
end

function var_0_0.refreshView(arg_8_0)
	arg_8_0:refreshList()
	arg_8_0:refreshInfoView()
end

function var_0_0.refreshList(arg_9_0)
	local var_9_0, var_9_1 = SurvivalShelterBuildingListModel.instance:getShowList()

	for iter_9_0 = 1, math.max(#var_9_0, #arg_9_0.baseItemList) do
		local var_9_2 = arg_9_0:getBaseItem(iter_9_0)

		arg_9_0:refreshBaseItem(var_9_2, var_9_0[iter_9_0])
	end

	local var_9_3 = #var_9_1

	for iter_9_1 = 1, math.max(var_9_3, #arg_9_0.smallItemList) do
		local var_9_4 = arg_9_0:getSmallItem(iter_9_1, arg_9_0.goTentGrid)

		arg_9_0:refreshSmallItem(var_9_4, var_9_1[iter_9_1])
	end
end

function var_0_0.getBaseItem(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.baseItemList[arg_10_1]

	if not var_10_0 then
		var_10_0 = arg_10_0:getUserDataTb_()
		var_10_0.index = arg_10_1
		var_10_0.go = gohelper.cloneInPlace(arg_10_0.goBaseItem, tostring(arg_10_1))
		var_10_0.goGrid = gohelper.findChild(var_10_0.go, "Grid")
		var_10_0.itemList = {}
		arg_10_0.baseItemList[arg_10_1] = var_10_0
	end

	return var_10_0
end

function var_0_0.refreshBaseItem(arg_11_0, arg_11_1, arg_11_2)
	arg_11_1.data = arg_11_2

	if not arg_11_2 then
		gohelper.setActive(arg_11_1.go, false)

		return
	end

	gohelper.setActive(arg_11_1.go, true)

	for iter_11_0 = 1, math.max(#arg_11_2, #arg_11_1.itemList) do
		local var_11_0 = arg_11_0:getBaseSmallItem(arg_11_1, iter_11_0)

		arg_11_0:refreshSmallItem(var_11_0, arg_11_2[iter_11_0])
	end
end

function var_0_0.getBaseSmallItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_1.itemList[arg_12_2]

	if not var_12_0 then
		var_12_0 = arg_12_0:getUserDataTb_()
		var_12_0.index = arg_12_2
		var_12_0.go = gohelper.clone(arg_12_0.goBaseSmallItem, arg_12_1.goGrid, tostring(arg_12_2))
		var_12_0.txtName = gohelper.findChildTextMesh(var_12_0.go, "#txt_BuildingName")
		var_12_0.txtLev = gohelper.findChildTextMesh(var_12_0.go, "#txt_BuildingLv")
		var_12_0.goSelect = gohelper.findChild(var_12_0.go, "#go_Selected")
		var_12_0.simageBuild = gohelper.findChildSingleImage(var_12_0.go, "#image_Building")
		var_12_0.imageBuild = gohelper.findChildImage(var_12_0.go, "#image_Building")
		var_12_0.goImageBuild = gohelper.findChild(var_12_0.go, "#image_Building")
		var_12_0.goLevUp = gohelper.findChild(var_12_0.go, "#go_LvUp")
		var_12_0.goDestroyed = gohelper.findChild(var_12_0.go, "#go_Destroyed")
		var_12_0.goAdd = gohelper.findChild(var_12_0.go, "#go_Add")
		var_12_0.goLock = gohelper.findChild(var_12_0.go, "#go_Locked")
		var_12_0.btn = gohelper.findButtonWithAudio(var_12_0.go)

		var_12_0.btn:AddClickListener(arg_12_0.onClickBaseSmallItem, arg_12_0, var_12_0)

		var_12_0.goNew = gohelper.findChild(var_12_0.go, "#go_New")
		arg_12_1.itemList[arg_12_2] = var_12_0
	end

	return var_12_0
end

function var_0_0.refreshBaseSmallItem(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0:refreshBuildingItem(arg_13_1, arg_13_2)
end

function var_0_0.getSmallItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.smallItemList[arg_14_1]

	if not var_14_0 then
		var_14_0 = arg_14_0:getUserDataTb_()
		var_14_0.index = arg_14_1
		var_14_0.go = gohelper.clone(arg_14_0.goSmallItem, arg_14_2, tostring(arg_14_1))
		var_14_0.txtName = gohelper.findChildTextMesh(var_14_0.go, "#txt_Name")
		var_14_0.txtLev = gohelper.findChildTextMesh(var_14_0.go, "#txt_Lv")
		var_14_0.goLevUp = gohelper.findChild(var_14_0.go, "#go_LvUp")
		var_14_0.goDestroyed = gohelper.findChild(var_14_0.go, "#go_Destroyed")
		var_14_0.goAdd = gohelper.findChild(var_14_0.go, "#go_Add")
		var_14_0.goLock = gohelper.findChild(var_14_0.go, "#go_Locked")
		var_14_0.goSelect = gohelper.findChild(var_14_0.go, "#go_Selected")
		var_14_0.simageBuild = gohelper.findChildSingleImage(var_14_0.go, "#image_Building")
		var_14_0.imageBuild = gohelper.findChildImage(var_14_0.go, "#image_Building")
		var_14_0.goImageBuild = gohelper.findChild(var_14_0.go, "#image_Building")
		var_14_0.btn = gohelper.findButtonWithAudio(var_14_0.go)

		var_14_0.btn:AddClickListener(arg_14_0.onClickSmallItem, arg_14_0, var_14_0)

		var_14_0.goNew = gohelper.findChild(var_14_0.go, "#go_New")
		arg_14_0.smallItemList[arg_14_1] = var_14_0
	else
		gohelper.addChild(arg_14_2, var_14_0.go)
		gohelper.setAsLastSibling(var_14_0.go)
	end

	return var_14_0
end

function var_0_0.onLoadedImage(arg_15_0)
	arg_15_0.imageBuild:SetNativeSize()
end

function var_0_0.refreshSmallItem(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0:refreshBuildingItem(arg_16_1, arg_16_2)
end

function var_0_0.refreshBuildingItem(arg_17_0, arg_17_1, arg_17_2)
	arg_17_1.data = arg_17_2

	if not arg_17_2 then
		gohelper.setActive(arg_17_1.go, false)

		return
	end

	gohelper.setActive(arg_17_1.go, true)

	local var_17_0 = SurvivalShelterModel.instance:getWeekInfo()

	arg_17_1.txtName.text = arg_17_2.baseCo.name

	gohelper.setActive(arg_17_1.goSelect, SurvivalShelterBuildingListModel.instance:isSelectBuilding(arg_17_2.id))

	local var_17_1 = var_17_0:isBuildingUnlock(arg_17_2.buildingId, arg_17_2.level + 1)
	local var_17_2 = arg_17_2.level == 0
	local var_17_3 = false
	local var_17_4 = var_17_0:isBuildingCanLevup(arg_17_2, arg_17_2.level + 1, false)

	if var_17_2 then
		gohelper.setActive(arg_17_1.goLevUp, false)
		gohelper.setActive(arg_17_1.goDestroyed, false)

		if var_17_1 then
			gohelper.setActive(arg_17_1.goAdd, true)
			gohelper.setActive(arg_17_1.goLock, false)

			arg_17_1.txtLev.text = luaLang("survivalbuildingmanageview_unbuild_txt")
		else
			gohelper.setActive(arg_17_1.goAdd, false)
			gohelper.setActive(arg_17_1.goLock, true)

			arg_17_1.txtLev.text = luaLang("survivalbuildingmanageview_buildinglock_txt")
		end

		var_17_3 = true
	else
		gohelper.setActive(arg_17_1.goLevUp, var_17_4)
		gohelper.setActive(arg_17_1.goDestroyed, arg_17_2.status == SurvivalEnum.BuildingStatus.Destroy)
		gohelper.setActive(arg_17_1.goAdd, false)
		gohelper.setActive(arg_17_1.goLock, false)

		arg_17_1.txtLev.text = string.format("Lv.%s", arg_17_2.level)
		var_17_3 = arg_17_2.status == SurvivalEnum.BuildingStatus.Destroy
	end

	arg_17_1.simageBuild:LoadImage(arg_17_2.baseCo.icon, var_0_0.onLoadedImage, arg_17_1)
	ZProj.UGUIHelper.SetGrayscale(arg_17_1.goImageBuild, var_17_3)
	gohelper.setActive(arg_17_1.goNew, var_17_2 and var_17_4)
end

function var_0_0.refreshInfoView(arg_18_0)
	if not arg_18_0.infoView then
		local var_18_0 = arg_18_0.viewContainer:getRes(arg_18_0.viewContainer:getSetting().otherRes.infoView)
		local var_18_1 = gohelper.findChild(arg_18_0.viewGO, "Panel/Right/go_manageinfo")

		arg_18_0.infoView = ShelterManagerInfoView.getView(var_18_0, var_18_1, "infoView")
	end

	local var_18_2 = {
		showType = SurvivalEnum.InfoShowType.Building,
		showId = SurvivalShelterBuildingListModel.instance:getSelectBuilding()
	}

	arg_18_0.infoView:refreshParam(var_18_2)
end

function var_0_0.onClose(arg_19_0)
	for iter_19_0, iter_19_1 in pairs(arg_19_0.baseItemList) do
		for iter_19_2, iter_19_3 in pairs(iter_19_1.itemList) do
			iter_19_3.btn:RemoveClickListener()
			iter_19_3.simageBuild:UnLoadImage()
		end
	end

	for iter_19_4, iter_19_5 in pairs(arg_19_0.smallItemList) do
		iter_19_5.btn:RemoveClickListener()
		iter_19_5.simageBuild:UnLoadImage()
	end
end

return var_0_0
