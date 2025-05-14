module("modules.logic.room.view.RoomBlockPackageSimpleItem", package.seeall)

local var_0_0 = class("RoomBlockPackageSimpleItem", RoomBlockPackageItem)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._go = arg_1_0.viewGO
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "item")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "item/image_rare/bottom/txt_num")
	arg_1_0._txtdegree = gohelper.findChildText(arg_1_0.viewGO, "item/image_rare/bottom/txt_degree")
	arg_1_0._imagerare = gohelper.findChildImage(arg_1_0.viewGO, "item/image_rare")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "item/image_rare/txt_name")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "item/image_rare/go_reddot")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "item/image_rare/go_select")
	arg_1_0._btnItem = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "item")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "item/image_rare/bottom/go_empty")
	arg_1_0._simagedegree = gohelper.findChildImage(arg_1_0.viewGO, "item/image_rare/bottom/txt_degree/icon")

	arg_1_0._btnItem:AddClickListener(arg_1_0._btnitemOnClick, arg_1_0)
	UISpriteSetMgr.instance:setRoomSprite(arg_1_0._simagedegree, "jianshezhi")
	arg_1_0:_onInit(arg_1_0.viewGO)
end

function var_0_0._onInit(arg_2_0, arg_2_1)
	gohelper.setActive(arg_2_0._goselect, false)
end

function var_0_0._onRefreshUI(arg_3_0)
	local var_3_0 = RoomBlockPackageEnum.RareIcon[arg_3_0._packageCfg.rare] or RoomBlockPackageEnum.RareIcon[1]

	UISpriteSetMgr.instance:setRoomSprite(arg_3_0._imagerare, var_3_0)
end

function var_0_0._onSelectUI(arg_4_0)
	return
end

return var_0_0
