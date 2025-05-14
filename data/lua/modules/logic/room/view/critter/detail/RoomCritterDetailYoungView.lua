module("modules.logic.room.view.critter.detail.RoomCritterDetailYoungView", package.seeall)

local var_0_0 = class("RoomCritterDetailYoungView", RoomCritterDetailView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._goyoung = gohelper.findChild(arg_1_0.viewGO, "#go_young")
	arg_1_0._scrollcritter = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_young/#scroll_critter")
	arg_1_0._gocritteritem = gohelper.findChild(arg_1_0.viewGO, "#go_young/#scroll_critter/viewport/content/#go_critteritem")
	arg_1_0._gocrittericon = gohelper.findChild(arg_1_0.viewGO, "#go_young/#scroll_critter/viewport/content/#go_critteritem/#go_crittericon")
	arg_1_0._godetail = gohelper.findChild(arg_1_0.viewGO, "#go_young/Left/#go_detail")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#go_young/Left/#go_detail/#txt_name")
	arg_1_0._imagelock = gohelper.findChildImage(arg_1_0.viewGO, "#go_young/Left/#go_detail/#txt_name/#image_lock")
	arg_1_0._imagesort = gohelper.findChildImage(arg_1_0.viewGO, "#go_young/Left/#go_detail/#image_sort")
	arg_1_0._txtsort = gohelper.findChildText(arg_1_0.viewGO, "#go_young/Left/#go_detail/#image_sort/#txt_sort")
	arg_1_0._txttag1 = gohelper.findChildText(arg_1_0.viewGO, "#go_young/Left/#go_detail/tag/#txt_tag1")
	arg_1_0._txttag2 = gohelper.findChildText(arg_1_0.viewGO, "#go_young/Left/#go_detail/tag/#txt_tag2")
	arg_1_0._scrolldes = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_young/Left/#go_detail/#scroll_des")
	arg_1_0._txtDesc = gohelper.findChildText(arg_1_0.viewGO, "#go_young/Left/#go_detail/#scroll_des/viewport/content/#txt_Desc")
	arg_1_0._scrollbase = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_young/Left/base/#scroll_base")
	arg_1_0._gobaseitem = gohelper.findChild(arg_1_0.viewGO, "#go_young/Left/base/#scroll_base/viewport/content/#go_baseitem")
	arg_1_0._btnattrclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_young/Left/base/basetips/#btn_attrclose")
	arg_1_0._scrolltipbase = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_young/Left/base/basetips/#scroll_base")
	arg_1_0._gobasetipsitem = gohelper.findChild(arg_1_0.viewGO, "#go_young/Left/base/basetips/#scroll_base/viewport/content/#go_basetipsitem")
	arg_1_0._scrollskill = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_young/Left/skill/#scroll_skill")
	arg_1_0._goskillItem = gohelper.findChild(arg_1_0.viewGO, "#go_young/Left/skill/#scroll_skill/viewport/content/#go_skillItem")
	arg_1_0._gocritterlive2d = gohelper.findChild(arg_1_0.viewGO, "#go_young/Right/#go_critterlive2d")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._gostar = gohelper.findChild(arg_1_0.viewGO, "#go_young/Left/#go_detail/starList")
	arg_1_0._gotipbase = gohelper.findChild(arg_1_0.viewGO, "#go_young/Left/base/basetips")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	arg_2_0._btnattrclose:AddClickListener(arg_2_0._btnattrcloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	var_0_0.super.removeEvents(arg_3_0)
	arg_3_0._btnattrclose:RemoveClickListener()
end

function var_0_0._btnattrcloseOnClick(arg_4_0)
	gohelper.setActive(arg_4_0._gotipbase.gameObject, false)
end

function var_0_0._btnLockOnClick(arg_5_0)
	CritterRpc.instance:sendLockCritterRequest(arg_5_0._critterMo.uid, not arg_5_0._critterMo.lock, arg_5_0.refreshLock, arg_5_0)
end

function var_0_0._editableInitView(arg_6_0)
	var_0_0.super._editableInitView(arg_6_0)

	arg_6_0._goLock = gohelper.findChild(arg_6_0.viewGO, "#go_young/Left/#go_detail/#txt_name/#image_lock")

	if arg_6_0._goLock then
		local var_6_0 = gohelper.findChild(arg_6_0._goLock, "clickarea")

		arg_6_0._lockbtn = SLFramework.UGUI.UIClickListener.Get(var_6_0)

		arg_6_0._lockbtn:AddClickListener(arg_6_0._btnLockOnClick, arg_6_0)
	end
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0._critterMo = arg_7_0.viewParam.critterMo
	arg_7_0._critterMoList = arg_7_0.viewParam.critterMos

	if arg_7_0._critterMoList then
		gohelper.setActive(arg_7_0._scrollcritter.gameObject, true)

		arg_7_0._selectCritterIndex = 1
		arg_7_0._critterMo = arg_7_0._critterMoList and arg_7_0._critterMoList[arg_7_0._selectCritterIndex]

		arg_7_0:setCritter()
	else
		gohelper.setActive(arg_7_0._scrollcritter.gameObject, false)
	end

	if not arg_7_0._critterMo then
		return
	end

	gohelper.setActive(arg_7_0._gobaseitem.gameObject, false)
	gohelper.setActive(arg_7_0._goskillItem.gameObject, false)

	if arg_7_0._goLock then
		gohelper.setActive(arg_7_0._goLock.gameObject, not arg_7_0.viewParam.isPreview)
	end

	arg_7_0:onRefresh()
	arg_7_0:initAttrInfo()
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_mj_open)
end

function var_0_0.onRefresh(arg_8_0)
	if arg_8_0._critterMoList then
		arg_8_0._critterMo = arg_8_0._critterMoList and arg_8_0._critterMoList[arg_8_0._selectCritterIndex]
	else
		arg_8_0._critterMo = arg_8_0.viewParam.critterMo
	end

	var_0_0.super.onRefresh(arg_8_0)
end

function var_0_0.setCritter(arg_9_0)
	if not arg_9_0._scrollcritter or not arg_9_0._critterMoList then
		return
	end

	local var_9_0 = #arg_9_0._critterMoList

	for iter_9_0 = 1, var_9_0 do
		local var_9_1 = arg_9_0._critterMoList[iter_9_0]
		local var_9_2 = arg_9_0:getCritterItem(iter_9_0)

		if not var_9_2._critterIcon then
			var_9_2._critterIcon = IconMgr.instance:getCommonCritterIcon(var_9_2.critterGo)
		end

		var_9_2._critterIcon:onUpdateMO(var_9_1, true)
		var_9_2._critterIcon:hideMood()
		var_9_2._critterIcon:setSelectUIVisible(iter_9_0 == arg_9_0._selectCritterIndex)
		var_9_2._critterIcon:onSelect(iter_9_0 == arg_9_0._selectCritterIndex)
		var_9_2._critterIcon:setCustomClick(arg_9_0._btnCritterOnClick, arg_9_0, iter_9_0)
		gohelper.setActive(var_9_2.line, iter_9_0 < var_9_0)
	end

	if arg_9_0._critterItems then
		for iter_9_1, iter_9_2 in ipairs(arg_9_0._critterItems) do
			gohelper.setActive(iter_9_2.go, iter_9_1 <= var_9_0)
		end
	end
end

function var_0_0._btnCritterOnClick(arg_10_0, arg_10_1)
	arg_10_0._selectCritterIndex = arg_10_1

	if arg_10_0._critterItems then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0._critterItems) do
			iter_10_1._critterIcon:setSelectUIVisible(iter_10_0 == arg_10_0._selectCritterIndex)
			iter_10_1._critterIcon:onSelect(iter_10_0 == arg_10_0._selectCritterIndex)
		end
	end

	gohelper.setActive(arg_10_0._gotipbase.gameObject, false)
	arg_10_0:onRefresh()
end

function var_0_0.getCritterItem(arg_11_0, arg_11_1)
	if not arg_11_0._critterItems then
		arg_11_0._critterItems = arg_11_0:getUserDataTb_()
	end

	local var_11_0 = arg_11_0._critterItems[arg_11_1]

	if not var_11_0 then
		local var_11_1 = gohelper.cloneInPlace(arg_11_0._gocritteritem)
		local var_11_2 = gohelper.findChild(var_11_1, "#go_crittericon")
		local var_11_3 = gohelper.findChild(var_11_1, "line")

		var_11_0 = {
			go = var_11_1,
			critterGo = var_11_2,
			line = var_11_3
		}
		arg_11_0._critterItems[arg_11_1] = var_11_0
	end

	return var_11_0
end

function var_0_0.getAttrRatio(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0.viewParam.isPreview then
		local var_12_0 = arg_12_0._critterMo:getDefineId()
		local var_12_1 = CritterIncubateModel.instance:getSelectParentCritterMoByid(var_12_0)

		if var_12_1 then
			local var_12_2 = var_12_1:getAttributeInfoByType(arg_12_1)

			if var_12_2 then
				local var_12_3 = var_12_2:getRate()
				local var_12_4 = arg_12_2:getRate()
				local var_12_5 = var_12_4 - var_12_3
				local var_12_6 = math.floor(var_12_5 * 100) / 100

				if var_12_6 == 0 then
					return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("critter_attr_rate"), var_12_4)
				else
					local var_12_7 = var_12_6 > 0 and "room_preview_critter_attr_add_ratio" or "room_preview_critter_attr_reduce_ratio"

					return GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang(var_12_7), var_12_4, var_12_6)
				end
			end
		end
	else
		return arg_12_2:getRateStr()
	end
end

return var_0_0
