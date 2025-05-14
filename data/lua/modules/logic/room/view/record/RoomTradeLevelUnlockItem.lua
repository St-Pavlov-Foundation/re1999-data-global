module("modules.logic.room.view.record.RoomTradeLevelUnlockItem", package.seeall)

local var_0_0 = class("RoomTradeLevelUnlockItem", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imagebg = gohelper.findChildImage(arg_1_0.viewGO, "normal/#image_bg")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "normal/prop/#txt_num")
	arg_1_0._goprop = gohelper.findChild(arg_1_0.viewGO, "normal/prop")
	arg_1_0._imagepropicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "normal/prop/propicon")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "normal/#image_icon")
	arg_1_0._simagepropicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "normal/prop/propicon")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "normal/txt/#txt_name")
	arg_1_0._gonum = gohelper.findChild(arg_1_0.viewGO, "normal/txt/#go_num")
	arg_1_0._txtcur = gohelper.findChildText(arg_1_0.viewGO, "normal/txt/#go_num/#txt_cur")
	arg_1_0._txtnext = gohelper.findChildText(arg_1_0.viewGO, "normal/txt/#go_num/#txt_next")
	arg_1_0._goup = gohelper.findChild(arg_1_0.viewGO, "normal/go_up")
	arg_1_0._gonew = gohelper.findChild(arg_1_0.viewGO, "normal/go_new")

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

function var_0_0.init(arg_4_0, arg_4_1)
	arg_4_0.viewGO = arg_4_1

	arg_4_0:onInitView()
end

function var_0_0.addEventListeners(arg_5_0)
	arg_5_0:addEvents()
end

function var_0_0.removeEventListeners(arg_6_0)
	arg_6_0:removeEvents()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._click = SLFramework.UGUI.UIClickListener.Get(arg_7_0._imagebg.gameObject)

	arg_7_0._click:AddClickListener(arg_7_0._btnClickOnClick, arg_7_0)
end

function var_0_0._btnClickOnClick(arg_8_0)
	if not arg_8_0._mo or not arg_8_0._mo.type then
		return
	end

	if arg_8_0._co.itemType == 1 and arg_8_0._mo.buildingId then
		MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Building, arg_8_0._mo.buildingId)
	elseif arg_8_0._mo.type == RoomTradeEnum.LevelUnlock.GetBouns then
		local var_8_0 = string.split(arg_8_0._mo.bouns, "#")

		MaterialTipController.instance:showMaterialInfo(var_8_0[1], var_8_0[2])
	end
end

function var_0_0.onStart(arg_9_0)
	return
end

function var_0_0.onDestroy(arg_10_0)
	arg_10_0._imagepropicon:UnLoadImage()
	arg_10_0._simagepropicon:UnLoadImage()

	if arg_10_0._click then
		arg_10_0._click:RemoveClickListener()
	end
end

function var_0_0.onRefreshMo(arg_11_0, arg_11_1)
	arg_11_0._co = RoomTradeConfig.instance:getLevelUnlockCo(arg_11_1.type)
	arg_11_0._mo = arg_11_1

	if arg_11_0._co then
		arg_11_0._txtname.text = arg_11_0._co.name

		gohelper.setActive(arg_11_0._goup, arg_11_0._co.type == 2)
		gohelper.setActive(arg_11_0._gonew.gameObject, arg_11_0._co.type == 1)

		if arg_11_1.type == RoomTradeEnum.LevelUnlock.GetBouns then
			if not string.nilorempty(arg_11_1.bouns) then
				local var_11_0 = string.split(arg_11_1.bouns, "#")
				local var_11_1, var_11_2 = ItemModel.instance:getItemConfigAndIcon(var_11_0[1], var_11_0[2])

				if not string.nilorempty(var_11_2) then
					arg_11_0._imagepropicon:LoadImage(var_11_2)
				end

				arg_11_0._txtnum.text = luaLang("multiple") .. var_11_0[3]
			end
		elseif arg_11_0._co.itemType == 1 and arg_11_1.buildingId then
			local var_11_3 = RoomTradeTaskModel.instance:getBuildingTaskIcon(arg_11_1.buildingId)

			if not string.nilorempty(var_11_3) then
				arg_11_0._simagepropicon:LoadImage(var_11_3)
			end

			recthelper.setWidth(arg_11_0._simagepropicon.transform, 308)
			recthelper.setHeight(arg_11_0._simagepropicon.transform, 277.2)

			arg_11_0._txtnum.text = ""
		else
			local var_11_4 = arg_11_0._co.icon

			if not string.nilorempty(var_11_4) then
				UISpriteSetMgr.instance:setCritterSprite(arg_11_0._imageicon, var_11_4)
			end
		end

		local var_11_5 = arg_11_1.type == RoomTradeEnum.LevelUnlock.GetBouns or arg_11_0._co.itemType == 1

		gohelper.setActive(arg_11_0._goprop, var_11_5)
		gohelper.setActive(arg_11_0._imageicon.gameObject, not var_11_5)
	end

	local var_11_6 = LuaUtil.tableNotEmpty(arg_11_1.num)

	if var_11_6 then
		arg_11_0._txtcur.text = arg_11_1.num.last
		arg_11_0._txtnext.text = arg_11_1.num.cur
	end

	recthelper.setAnchorY(arg_11_0._imageicon.transform, var_11_6 and 0 or 8)
	gohelper.setActive(arg_11_0._gonum, var_11_6)
end

return var_0_0
