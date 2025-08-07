module("modules.logic.room.view.gift.RoomBlockGiftBuildingItem", package.seeall)

local var_0_0 = class("RoomBlockGiftBuildingItem", ListScrollCellExtend)

var_0_0.DRAG_RADIUS = 15

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_content")
	arg_1_0._imagerare = gohelper.findChildImage(arg_1_0.viewGO, "#go_content/#image_rare")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_content/#simage_icon")
	arg_1_0._txtcount = gohelper.findChildText(arg_1_0.viewGO, "#go_content/#txt_count")
	arg_1_0._txtbuildingname = gohelper.findChildText(arg_1_0.viewGO, "#go_content/#txt_buildingname")
	arg_1_0._imagearea = gohelper.findChildImage(arg_1_0.viewGO, "#go_content/#image_area")
	arg_1_0._gogroupres = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_groupres")
	arg_1_0._imageres = gohelper.findChildImage(arg_1_0.viewGO, "#go_content/#go_groupres/#image_res")
	arg_1_0._txtaddvalue = gohelper.findChildText(arg_1_0.viewGO, "#go_content/#txt_addvalue")
	arg_1_0._txtcostres = gohelper.findChildText(arg_1_0.viewGO, "#go_content/#txt_costres")
	arg_1_0._imagecostresicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_content/#txt_costres/#image_costresicon")
	arg_1_0._buildingusedesc = gohelper.findChildText(arg_1_0.viewGO, "#go_content/#txt_buildingusedesc")
	arg_1_0._imagebuildingtype = gohelper.findChildImage(arg_1_0.viewGO, "#go_content/#image_buildingtype")
	arg_1_0._txtcritternum = gohelper.findChildText(arg_1_0.viewGO, "#go_content/#txt_critternum")
	arg_1_0._simagebuilddegree = gohelper.findChildImage(arg_1_0.viewGO, "#go_content/#txt_addvalue/#simage_builddegree")
	arg_1_0._gobeplaced = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_beplaced")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_select")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_content/#btn_click")
	arg_1_0._govehicle = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_vehicle")
	arg_1_0._gohasget = gohelper.findChild(arg_1_0.viewGO, "#go_content/go_hasget")
	arg_1_0._btnbuildselect = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_content/#go_select/#btn_check")

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

function var_0_0.addEventListeners(arg_4_0)
	arg_4_0._btnUIlongPrees:SetLongPressTime(arg_4_0._longPressArr)
	arg_4_0._btnUIlongPrees:AddLongPressListener(arg_4_0._onbtnlongPrees, arg_4_0)
	arg_4_0._btnUIclick:AddClickListener(arg_4_0._btnclickOnClick, arg_4_0)
	arg_4_0._btnbuildselect:AddClickListener(arg_4_0._onbtnlongPrees, arg_4_0)

	if arg_4_0._btnUIdrag then
		arg_4_0._btnUIdrag:AddDragBeginListener(arg_4_0._onDragBegin, arg_4_0)
		arg_4_0._btnUIdrag:AddDragListener(arg_4_0._onDragIng, arg_4_0)
		arg_4_0._btnUIdrag:AddDragEndListener(arg_4_0._onDragEnd, arg_4_0)
	end
end

function var_0_0.removeEventListeners(arg_5_0)
	arg_5_0._btnUIlongPrees:RemoveLongPressListener()
	arg_5_0._btnUIclick:RemoveClickListener()
	arg_5_0._btnbuildselect:RemoveClickListener()

	if arg_5_0._btnUIdrag then
		arg_5_0._btnUIdrag:RemoveDragBeginListener()
		arg_5_0._btnUIdrag:RemoveDragListener()
		arg_5_0._btnUIdrag:RemoveDragEndListener()
	end
end

function var_0_0._btnclickOnClick(arg_6_0)
	if arg_6_0._mo:isCollect() then
		return
	end

	RoomBlockBuildingGiftModel.instance:onSelect(arg_6_0._mo)
	RoomBlockGiftController.instance:dispatchEvent(RoomBlockGiftEvent.OnSelect, arg_6_0._mo.subType, arg_6_0._mo.id)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._longPressArr = {
		1,
		99999
	}
	arg_7_0._buildingDragStarY = 350 * UnityEngine.Screen.height / 1080
	arg_7_0._scene = GameSceneMgr.instance:getCurScene()

	UISpriteSetMgr.instance:setRoomSprite(arg_7_0._simagebuilddegree, "jianshezhi")

	arg_7_0._isSelect = false
	arg_7_0._animator = arg_7_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	local var_7_0 = arg_7_0._btnclick.gameObject

	gohelper.addUIClickAudio(var_7_0, AudioEnum.UI.UI_Common_Click)

	arg_7_0._btnUIlongPrees = SLFramework.UGUI.UILongPressListener.Get(var_7_0)
	arg_7_0._btnUIclick = SLFramework.UGUI.UIClickListener.Get(var_7_0)
	arg_7_0._btnUIdrag = SLFramework.UGUI.UIDragListener.Get(var_7_0)
	arg_7_0._buildingTypeDefindeColor = "#FFFFFF"
	arg_7_0._buildingTypeIconColor = {
		[RoomBuildingEnum.BuildingType.Collect] = "#6E9FB1",
		[RoomBuildingEnum.BuildingType.Process] = "#C6BA7B",
		[RoomBuildingEnum.BuildingType.Manufacture] = "#7BB19A"
	}
end

function var_0_0._refreshUI(arg_8_0)
	arg_8_0._simageicon:LoadImage(ResUrl.getRoomImage("building/" .. arg_8_0._mo:getIcon()))
	gohelper.setActive(arg_8_0._gobeplaced, arg_8_0._mo.use)

	arg_8_0._txtcount.text = luaLang("multiple") .. 1
	arg_8_0._txtaddvalue.text = arg_8_0._mo.config.buildDegree
	arg_8_0._txtbuildingname.text = arg_8_0._mo.config.name

	gohelper.setActive(arg_8_0._txtcostres.gameObject, false)

	local var_8_0 = arg_8_0._mo:getBuildingAreaConfig()

	UISpriteSetMgr.instance:setRoomSprite(arg_8_0._imagearea, "xiaowuliubianxing_" .. var_8_0.icon)

	local var_8_1 = RoomBuildingEnum.RareIcon[arg_8_0._mo.config.rare] or RoomBuildingEnum.RareIcon[1]

	UISpriteSetMgr.instance:setRoomSprite(arg_8_0._imagerare, var_8_1)

	if arg_8_0._refresCostBuilding ~= arg_8_0._mo.buildingId then
		arg_8_0._refresCostBuilding = arg_8_0._mo.buildingId

		arg_8_0:_refreshCostResList(arg_8_0._mo.buildingId)
	end

	gohelper.setActive(arg_8_0._govehicle, arg_8_0._mo.config.vehicleType ~= 0)

	local var_8_2 = true

	if arg_8_0._mo.config.buildingType ~= RoomBuildingEnum.BuildingType.Decoration then
		var_8_2 = false
	end

	gohelper.setActive(arg_8_0._txtcount, var_8_2)
	gohelper.setActive(arg_8_0._txtaddvalue, var_8_2)
	gohelper.setActive(arg_8_0._buildingusedesc, not var_8_2)
	gohelper.setActive(arg_8_0._imagebuildingtype, not var_8_2)

	if var_8_2 then
		gohelper.setActive(arg_8_0._txtcritternum, false)
	else
		arg_8_0:_refreshBuildingTypeIcon(arg_8_0._mo.config)
	end

	gohelper.setActive(arg_8_0._gohasget, arg_8_0._mo:isCollect())
	arg_8_0:onSelect()
end

function var_0_0._refreshCostResList(arg_9_0, arg_9_1)
	arg_9_0._imageResList = arg_9_0._imageResList or {
		arg_9_0._imageres
	}

	local var_9_0 = RoomBuildingHelper.getCostResource(arg_9_1)
	local var_9_1 = var_9_0 and #var_9_0 or 0

	for iter_9_0 = 1, var_9_1 do
		local var_9_2 = arg_9_0._imageResList[iter_9_0]

		if not var_9_2 then
			local var_9_3 = gohelper.clone(arg_9_0._imageres.gameObject, arg_9_0._gogroupres, "imageres" .. iter_9_0)

			var_9_2 = gohelper.onceAddComponent(var_9_3, gohelper.Type_Image)

			table.insert(arg_9_0._imageResList, var_9_2)
		end

		gohelper.setActive(var_9_2.gameObject, true)
		UISpriteSetMgr.instance:setRoomSprite(var_9_2, string.format("fanzhi_icon_%s", var_9_0[iter_9_0]))
	end

	for iter_9_1 = var_9_1 + 1, #arg_9_0._imageResList do
		local var_9_4 = arg_9_0._imageResList[iter_9_1]

		gohelper.setActive(var_9_4.gameObject, false)
	end
end

function var_0_0.onUpdateMO(arg_10_0, arg_10_1)
	arg_10_0._mo = arg_10_1

	local var_10_0 = arg_10_1 and arg_10_1.config

	gohelper.setActive(arg_10_0._gocontent, var_10_0)

	if var_10_0 then
		arg_10_0:_refreshUI()
	end
end

function var_0_0.getAnimator(arg_11_0)
	return arg_11_0._animator
end

function var_0_0.onSelect(arg_12_0)
	arg_12_0._isSelect = RoomBlockBuildingGiftModel.instance:isSelect(arg_12_0._mo)

	gohelper.setActive(arg_12_0._goselect, arg_12_0._isSelect)
end

function var_0_0.onDestroy(arg_13_0)
	arg_13_0._simageicon:UnLoadImage()
end

function var_0_0._refreshBuildingTypeIcon(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1.buildingType
	local var_14_1 = arg_14_1.id
	local var_14_2 = arg_14_0._buildingTypeIconColor[var_14_0] or arg_14_0._buildingTypeDefindeColor

	SLFramework.UGUI.GuiHelper.SetColor(arg_14_0._buildingusedesc, var_14_2)
	SLFramework.UGUI.GuiHelper.SetColor(arg_14_0._imagebuildingtype, var_14_2)

	local var_14_3

	if RoomBuildingEnum.BuildingArea[var_14_0] then
		var_14_3 = ManufactureConfig.instance:getManufactureBuildingIcon(var_14_1)
	else
		var_14_3 = RoomConfig.instance:getBuildingTypeIcon(var_14_0)
	end

	arg_14_0._buildingusedesc.text = arg_14_1.useDesc

	UISpriteSetMgr.instance:setRoomSprite(arg_14_0._imagebuildingtype, var_14_3)

	local var_14_4 = 0

	if RoomBuildingEnum.BuildingArea[var_14_0] or var_14_0 == RoomBuildingEnum.BuildingType.Rest then
		local var_14_5 = ManufactureModel.instance:getTradeLevel()

		var_14_4 = ManufactureConfig.instance:getBuildingCanPlaceCritterCount(var_14_1, var_14_5)
	end

	gohelper.setActive(arg_14_0._txtcritternum, var_14_4 > 0)

	if var_14_4 > 0 then
		arg_14_0._txtcritternum.text = var_14_4
	end
end

function var_0_0._onbtnlongPrees(arg_15_0)
	local var_15_0 = arg_15_0._mo.subType
	local var_15_1 = arg_15_0._mo.id
	local var_15_2 = {
		type = var_15_0,
		id = var_15_1
	}

	MaterialTipController.instance:showMaterialInfoWithData(var_15_0, var_15_1, var_15_2)
end

function var_0_0._onDragBegin(arg_16_0, arg_16_1, arg_16_2)
	RoomBlockGiftController.instance:dispatchEvent(RoomBlockGiftEvent.OnStartDragItem, arg_16_2)
end

function var_0_0._onDragIng(arg_17_0, arg_17_1, arg_17_2)
	RoomBlockGiftController.instance:dispatchEvent(RoomBlockGiftEvent.OnDragingItem, arg_17_2)
end

function var_0_0._onDragEnd(arg_18_0, arg_18_1, arg_18_2)
	RoomBlockGiftController.instance:dispatchEvent(RoomBlockGiftEvent.OnEndDragItem, arg_18_2)
end

function var_0_0.setActive(arg_19_0, arg_19_1)
	gohelper.setActive(arg_19_0.viewGO, arg_19_1)
end

function var_0_0.initViewGo(arg_20_0, arg_20_1)
	arg_20_0.viewGO = arg_20_1

	arg_20_0:onInitView()
end

return var_0_0
