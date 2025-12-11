module("modules.logic.room.view.gift.RoomBlockGiftPackageItem", package.seeall)

local var_0_0 = class("RoomBlockGiftPackageItem", RoomBlockPackageDetailedItem)

function var_0_0._onInit(arg_1_0, arg_1_1)
	var_0_0.super._onInit(arg_1_0, arg_1_1)
	gohelper.setActive(arg_1_0._gobirthday, false)

	arg_1_0._gohasget = gohelper.findChild(arg_1_1, "item/go_hasget")
	arg_1_0._imagehasgetIcon = gohelper.findChildSingleImage(arg_1_1, "item/go_hasget/image_icon")

	gohelper.setActive(arg_1_0._goempty, false)

	arg_1_0._btnUIlongPrees = SLFramework.UGUI.UILongPressListener.Get(arg_1_0._btnItem.gameObject)
	arg_1_0._btnblockselect = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_select/#btn_check")
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._go = arg_2_0.viewGO
	arg_2_0._goitem = gohelper.findChild(arg_2_0.viewGO, "item")
	arg_2_0._txtnum = gohelper.findChildText(arg_2_0.viewGO, "item/txt_num")
	arg_2_0._txtdegree = gohelper.findChildText(arg_2_0.viewGO, "item/txt_degree")
	arg_2_0._imagerare = gohelper.findChildImage(arg_2_0.viewGO, "item/image_rare")
	arg_2_0._txtname = gohelper.findChildText(arg_2_0.viewGO, "item/txt_name")
	arg_2_0._goreddot = gohelper.findChild(arg_2_0.viewGO, "item/txt_name/go_reddot")
	arg_2_0._goselect = gohelper.findChild(arg_2_0.viewGO, "go_select")
	arg_2_0._btnItem = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "item")
	arg_2_0._goempty = gohelper.findChild(arg_2_0.viewGO, "item/go_empty")
	arg_2_0._simagedegree = gohelper.findChildImage(arg_2_0.viewGO, "item/txt_degree/icon")

	arg_2_0._btnItem:AddClickListener(arg_2_0._btnitemOnClick, arg_2_0)
	UISpriteSetMgr.instance:setRoomSprite(arg_2_0._simagedegree, "jianshezhi")
	arg_2_0:_onInit(arg_2_0.viewGO)
end

function var_0_0.addEventListeners(arg_3_0)
	var_0_0.super.addEventListeners(arg_3_0)

	local var_3_0 = {
		1,
		99999
	}

	arg_3_0._btnUIlongPrees:SetLongPressTime(var_3_0)
	arg_3_0._btnUIlongPrees:AddLongPressListener(arg_3_0._onbtnlongPrees, arg_3_0)
	arg_3_0._btnblockselect:AddClickListener(arg_3_0._onbtnlongPrees, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._btnUIlongPrees:RemoveLongPressListener()
	var_0_0.super.removeEventListeners(arg_4_0)
	arg_4_0._btnblockselect:RemoveClickListener()
end

function var_0_0.setPackageId(arg_5_0, arg_5_1)
	arg_5_0._packageId = arg_5_1
	arg_5_0._packageCfg = RoomConfig.instance:getBlockPackageConfig(arg_5_1) or nil
	arg_5_0._blockNum = arg_5_0._showPackageMO:getBlockNum()
	arg_5_0._isCollocted = arg_5_0._showPackageMO:isCollect()

	arg_5_0:_refreshUI()
end

function var_0_0._refreshUI(arg_6_0)
	if not arg_6_0._packageCfg then
		return
	end

	arg_6_0._txtname.text = arg_6_0._packageCfg.name
	arg_6_0._txtnum.text = arg_6_0._blockNum
	arg_6_0._txtdegree.text = arg_6_0._packageCfg.blockBuildDegree * arg_6_0._blockNum

	gohelper.setActive(arg_6_0._gohasget, arg_6_0._isCollocted)
	gohelper.setActive(arg_6_0._txtnum.gameObject, not arg_6_0._isCollocted)
	gohelper.setActive(arg_6_0._txtdegree.gameObject, not arg_6_0._isCollocted)
	arg_6_0:_onRefreshUI()
end

function var_0_0._onRefreshUI(arg_7_0)
	arg_7_0._imageIcon:LoadImage(ResUrl.getRoomImage("blockpackage/" .. arg_7_0._packageCfg.icon))

	local var_7_0 = RoomBlockPackageEnum.RareBigIcon[arg_7_0._packageCfg.rare] or RoomBlockPackageEnum.RareBigIcon[1]

	UISpriteSetMgr.instance:setRoomSprite(arg_7_0._imagerare, var_7_0)

	if arg_7_0._showPackageMO:isCollect() then
		arg_7_0._imagehasgetIcon:LoadImage(ResUrl.getRoomImage("blockpackage/" .. arg_7_0._packageCfg.icon))
	end

	arg_7_0:onSelect()
end

function var_0_0._onbtnlongPrees(arg_8_0)
	local var_8_0 = arg_8_0._showPackageMO.subType
	local var_8_1 = arg_8_0._showPackageMO.id
	local var_8_2 = {
		type = var_8_0,
		id = var_8_1
	}

	MaterialTipController.instance:showMaterialInfoWithData(var_8_0, var_8_1, var_8_2)
end

function var_0_0._btnitemOnClick(arg_9_0)
	if arg_9_0._showPackageMO:isCollect() then
		return
	end

	RoomBlockBuildingGiftModel.instance:onSelect(arg_9_0._showPackageMO)
	RoomBlockGiftController.instance:dispatchEvent(RoomBlockGiftEvent.OnSelect, arg_9_0._showPackageMO)
end

function var_0_0.onSelect(arg_10_0)
	arg_10_0._isSelect = arg_10_0._showPackageMO.isSelect

	gohelper.setActive(arg_10_0._goselect, arg_10_0._isSelect)
end

function var_0_0.setActive(arg_11_0, arg_11_1)
	gohelper.setActive(arg_11_0._go, arg_11_1)
end

return var_0_0
