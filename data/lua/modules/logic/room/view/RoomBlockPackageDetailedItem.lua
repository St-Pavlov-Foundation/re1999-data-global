module("modules.logic.room.view.RoomBlockPackageDetailedItem", package.seeall)

local var_0_0 = class("RoomBlockPackageDetailedItem", RoomBlockPackageItem)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._go = arg_1_0.viewGO
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "item")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "item/bottom/degree/txt_num")
	arg_1_0._txtdegree = gohelper.findChildText(arg_1_0.viewGO, "item/bottom/degree/txt_degree")
	arg_1_0._imagerare = gohelper.findChildImage(arg_1_0.viewGO, "item/image_rare")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "item/bottom/txt_name")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "item/image_icon/go_reddot")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "go_select")
	arg_1_0._btnItem = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "item")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "item/bottom/go_empty")
	arg_1_0._simagedegree = gohelper.findChildImage(arg_1_0.viewGO, "item/bottom/degree/txt_degree/icon")

	arg_1_0._btnItem:AddClickListener(arg_1_0._btnitemOnClick, arg_1_0)
	UISpriteSetMgr.instance:setRoomSprite(arg_1_0._simagedegree, "jianshezhi")
	arg_1_0:_onInit(arg_1_0.viewGO)
end

function var_0_0._onInit(arg_2_0, arg_2_1)
	arg_2_0._itemCanvasGroup = gohelper.findChild(arg_2_1, "item"):GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_2_0._imageIcon = gohelper.findChildSingleImage(arg_2_1, "item/image_icon")
	arg_2_0._gobirthday = gohelper.findChild(arg_2_1, "item/go_birthday")
	arg_2_0._txtbirthName = gohelper.findChildText(arg_2_1, "item/go_birthday/txt_birthName")
end

function var_0_0._onRefreshUI(arg_3_0)
	arg_3_0._imageIcon:LoadImage(ResUrl.getRoomImage("blockpackage/" .. arg_3_0._packageCfg.icon))

	if arg_3_0._packageCfg.id == RoomBlockPackageEnum.ID.RoleBirthday then
		local var_3_0 = arg_3_0:_getNearBlockName()

		gohelper.setActive(arg_3_0._gobirthday, var_3_0 ~= nil)

		if var_3_0 then
			arg_3_0._txtbirthName.text = var_3_0
		end
	else
		gohelper.setActive(arg_3_0._gobirthday, false)
	end

	local var_3_1 = RoomBlockPackageEnum.RareBigIcon[arg_3_0._packageCfg.rare] or RoomBlockPackageEnum.RareBigIcon[1]

	UISpriteSetMgr.instance:setRoomSprite(arg_3_0._imagerare, var_3_1)
end

function var_0_0._getNearBlockName(arg_4_0)
	local var_4_0 = RoomModel.instance:getSpecialBlockInfoList()
	local var_4_1

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		local var_4_2 = RoomConfig.instance:getBlock(iter_4_1.blockId)

		if var_4_2 and var_4_2.packageId == RoomBlockPackageEnum.ID.RoleBirthday and (var_4_1 == nil or var_4_1.createTime < iter_4_1.createTime) then
			var_4_1 = iter_4_1
		end
	end

	if var_4_1 then
		local var_4_3 = RoomConfig.instance:getSpecialBlockConfig(var_4_1.blockId)

		return var_4_3 and var_4_3.name
	end

	return nil
end

function var_0_0._onSelectUI(arg_5_0)
	return
end

function var_0_0.onDestroyView(arg_6_0)
	var_0_0.super.onDestroyView(arg_6_0)
	arg_6_0._imageIcon:UnLoadImage()
end

return var_0_0
