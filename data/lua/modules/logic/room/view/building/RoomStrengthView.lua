module("modules.logic.room.view.building.RoomStrengthView", package.seeall)

local var_0_0 = class("RoomStrengthView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageproducticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "productdetail/#simage_producticon")
	arg_1_0._txtnameEn = gohelper.findChildText(arg_1_0.viewGO, "productdetail/#txt_nameEn")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "productdetail/#txt_name")
	arg_1_0._txtlv = gohelper.findChildText(arg_1_0.viewGO, "productdetail/#txt_name/#txt_lv")
	arg_1_0._txtnosetting = gohelper.findChildText(arg_1_0.viewGO, "productdetail/#txt_name/#txt_nosetting")
	arg_1_0._goslotitem = gohelper.findChild(arg_1_0.viewGO, "productdetail/scroll_productprop/viewport/content/#go_slotitem")
	arg_1_0._golevelitem = gohelper.findChild(arg_1_0.viewGO, "scroll_level/viewport/content/#go_levelitem")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnclickOnClick(arg_5_0, arg_5_1)
	arg_5_0._level = arg_5_0._levelItemDict[arg_5_1].level

	arg_5_0:_refreshLevel()
	arg_5_0:_refreshStrength()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._levelItemDict = {}

	gohelper.setActive(arg_6_0._golevelitem, false)

	arg_6_0._slotItemList = {}

	gohelper.setActive(arg_6_0._goslotitem, false)
end

function var_0_0._refreshUI(arg_7_0)
	arg_7_0:_refreshLevel()
	arg_7_0:_refreshStrength()
end

function var_0_0._refreshLevel(arg_8_0)
	local var_8_0 = RoomConfig.instance:getLevelGroupMaxLevel(arg_8_0._levelGroup)

	for iter_8_0 = 0, var_8_0 do
		local var_8_1 = iter_8_0
		local var_8_2 = arg_8_0._levelItemDict[iter_8_0]

		if not var_8_2 then
			var_8_2 = arg_8_0:getUserDataTb_()
			var_8_2.index = iter_8_0
			var_8_2.go = gohelper.cloneInPlace(arg_8_0._golevelitem, "item" .. iter_8_0)
			var_8_2.goselect = gohelper.findChild(var_8_2.go, "go_beselect")
			var_8_2.gounselect = gohelper.findChild(var_8_2.go, "go_unselect")
			var_8_2.txtlvselect = gohelper.findChildText(var_8_2.go, "go_beselect/txt_lv")
			var_8_2.txtlvunselect = gohelper.findChildText(var_8_2.go, "go_unselect/txt_lv")
			var_8_2.btnclick = gohelper.findChildButtonWithAudio(var_8_2.go, "btn_click")

			var_8_2.btnclick:AddClickListener(arg_8_0._btnclickOnClick, arg_8_0, var_8_2.index)

			arg_8_0._levelItemDict[iter_8_0] = var_8_2
		end

		var_8_2.level = var_8_1

		if var_8_1 > 0 then
			var_8_2.txtlvselect.text = string.format("Lv.%s", var_8_1)
			var_8_2.txtlvunselect.text = string.format("Lv.%s", var_8_1)
		else
			var_8_2.txtlvselect.text = luaLang("roomtradeitemdetail_nosetting")
			var_8_2.txtlvunselect.text = luaLang("roomtradeitemdetail_nosetting")
		end

		gohelper.setActive(var_8_2.goselect, arg_8_0._level == var_8_2.level)
		gohelper.setActive(var_8_2.gounselect, arg_8_0._level ~= var_8_2.level)
		gohelper.setActive(var_8_2.go, true)
	end

	for iter_8_1, iter_8_2 in pairs(arg_8_0._levelItemDict) do
		if var_8_0 < iter_8_1 then
			gohelper.setActive(iter_8_2.go, false)
		end
	end
end

function var_0_0._refreshStrength(arg_9_0)
	local var_9_0 = arg_9_0._level or 0
	local var_9_1 = RoomConfig.instance:getLevelGroupInfo(arg_9_0._levelGroup, var_9_0)

	arg_9_0._simageproducticon:LoadImage(ResUrl.getRoomImage("modulepart/" .. var_9_1.icon))

	arg_9_0._txtname.text = var_9_1.name
	arg_9_0._txtnameEn.text = var_9_1.nameEn

	gohelper.setActive(arg_9_0._txtlv.gameObject, var_9_0 > 0)
	gohelper.setActive(arg_9_0._txtnosetting.gameObject, var_9_0 <= 0)

	if var_9_0 > 0 then
		arg_9_0._txtlv.text = string.format("Lv.%s", var_9_0)
	end

	local var_9_2 = {}

	if var_9_0 == 0 then
		if not string.nilorempty(var_9_1.desc) then
			table.insert(var_9_2, {
				desc = string.format("<color=#57503B>%s</color>", var_9_1.desc)
			})
		end
	else
		local var_9_3 = RoomConfig.instance:getLevelGroupConfig(arg_9_0._levelGroup, var_9_0)

		table.insert(var_9_2, {
			desc = string.format("<color=#608C54>%s</color>", var_9_3.desc)
		})

		if var_9_3.costResource > 0 then
			table.insert(var_9_2, {
				desc = string.format("<color=#943330>%s+%s</color>", luaLang("roomstrengthview_costresource"), var_9_3.costResource)
			})
		elseif var_9_3.costResource < 0 then
			table.insert(var_9_2, {
				desc = string.format("<color=#608C54>%s-%s</color>", luaLang("roomstrengthview_costresource"), math.abs(var_9_3.costResource))
			})
		end
	end

	for iter_9_0, iter_9_1 in ipairs(var_9_2) do
		local var_9_4 = arg_9_0._slotItemList[iter_9_0]

		if not var_9_4 then
			var_9_4 = arg_9_0:getUserDataTb_()
			var_9_4.go = gohelper.cloneInPlace(arg_9_0._goslotitem, "item" .. iter_9_0)
			var_9_4.gopoint1 = gohelper.findChild(var_9_4.go, "go_point1")
			var_9_4.gopoint2 = gohelper.findChild(var_9_4.go, "go_point2")
			var_9_4.txtslotdesc = gohelper.findChildText(var_9_4.go, "")

			gohelper.setActive(var_9_4.gopoint1, iter_9_0 % 2 == 1)
			gohelper.setActive(var_9_4.gopoint2, iter_9_0 % 2 == 0)
			table.insert(arg_9_0._slotItemList, var_9_4)
		end

		var_9_4.txtslotdesc.text = iter_9_1.desc

		gohelper.setActive(var_9_4.go, true)
	end

	for iter_9_2 = #var_9_2 + 1, #arg_9_0._slotItemList do
		local var_9_5 = arg_9_0._slotItemList[iter_9_2]

		gohelper.setActive(var_9_5.go, false)
	end
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0._levelGroup = arg_10_0.viewParam.levelGroup
	arg_10_0._level = arg_10_0.viewParam.level

	arg_10_0:_refreshUI()
end

function var_0_0.onUpdateParam(arg_11_0)
	arg_11_0._levelGroup = arg_11_0.viewParam.levelGroup
	arg_11_0._level = arg_11_0.viewParam.level

	arg_11_0:_refreshUI()
end

function var_0_0.onClose(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	arg_13_0._simageproducticon:UnLoadImage()

	for iter_13_0, iter_13_1 in pairs(arg_13_0._levelItemDict) do
		iter_13_1.btnclick:RemoveClickListener()
	end
end

return var_0_0
