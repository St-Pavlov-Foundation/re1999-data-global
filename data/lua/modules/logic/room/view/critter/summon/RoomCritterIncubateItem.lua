module("modules.logic.room.view.critter.summon.RoomCritterIncubateItem", package.seeall)

local var_0_0 = class("RoomCritterIncubateItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goicon = gohelper.findChild(arg_1_0.viewGO, "#go_icon")
	arg_1_0._goinfo = gohelper.findChild(arg_1_0.viewGO, "#go_info")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#go_info/#txt_name")
	arg_1_0._goselected = gohelper.findChild(arg_1_0.viewGO, "#go_selected")
	arg_1_0._btnclick = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "#btn_click")
	arg_1_0._scrollbase = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_base")
	arg_1_0._gobaseitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_base/viewport/content/#go_baseitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	CritterSummonController.instance:registerCallback(CritterSummonEvent.onSelectParentCritter, arg_2_0.refreshSelectParent, arg_2_0)
	CritterSummonController.instance:registerCallback(CritterSummonEvent.onRemoveParentCritter, arg_2_0.refreshSelectParent, arg_2_0)
	arg_2_0:addEventCb(CritterController.instance, CritterEvent.CritterRenameReply, arg_2_0._onCritterRenameReply, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0._btnlongPrees:RemoveLongPressListener()
	CritterSummonController.instance:unregisterCallback(CritterSummonEvent.onSelectParentCritter, arg_3_0.refreshSelectParent, arg_3_0)
	CritterSummonController.instance:unregisterCallback(CritterSummonEvent.onRemoveParentCritter, arg_3_0.refreshSelectParent, arg_3_0)
	arg_3_0:removeEventCb(CritterController.instance, CritterEvent.CritterRenameReply, arg_3_0._onCritterRenameReply, arg_3_0)
end

function var_0_0._btnclickOnClick(arg_4_0)
	if arg_4_0.isSelect then
		CritterIncubateModel.instance:removeSelectParentCritter(arg_4_0._uid)
	else
		CritterIncubateModel.instance:addSelectParentCritter(arg_4_0._uid)
	end
end

local var_0_1 = 0.5
local var_0_2 = 99999

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._btnlongPrees = SLFramework.UGUI.UILongPressListener.Get(arg_5_0._btnclick.gameObject)

	arg_5_0._btnlongPrees:SetLongPressTime({
		var_0_1,
		var_0_2
	})
	arg_5_0._btnlongPrees:AddLongPressListener(arg_5_0._onLongPress, arg_5_0)
end

function var_0_0._onLongPress(arg_6_0)
	local var_6_0 = arg_6_0._mo:isMaturity()

	CritterController.instance:openRoomCritterDetailView(not var_6_0, arg_6_0._mo)
end

function var_0_0._editableAddEvents(arg_7_0)
	return
end

function var_0_0._editableRemoveEvents(arg_8_0)
	return
end

function var_0_0.onUpdateMO(arg_9_0, arg_9_1)
	arg_9_0._mo = arg_9_1
	arg_9_0._uid = arg_9_0._mo.uid
	arg_9_0._txtname.text = arg_9_1:getName()

	if not arg_9_0._critterIcon then
		arg_9_0._critterIcon = IconMgr.instance:getCommonCritterIcon(arg_9_0._goicon)
	end

	arg_9_0._critterIcon:onUpdateMO(arg_9_0._mo)
	arg_9_0._critterIcon:hideMood()
	arg_9_0:showAttr()
	arg_9_0:refreshSelect()

	local var_9_0 = arg_9_1:getAdditionAttr()

	if next(var_9_0) ~= nil then
		arg_9_0._critterIcon:showUpTip()
	end
end

function var_0_0.onSelect(arg_10_0, arg_10_1)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

function var_0_0._onCritterRenameReply(arg_12_0, arg_12_1)
	if arg_12_0._mo and arg_12_0._uid == arg_12_1 then
		arg_12_0._txtname.text = arg_12_0._mo:getName()
	end
end

function var_0_0.showAttr(arg_13_0)
	local var_13_0 = arg_13_0._mo:getAttributeInfos()

	if not arg_13_0._attrItems then
		arg_13_0._attrItems = arg_13_0:getUserDataTb_()
	end

	local var_13_1 = 1

	if var_13_0 then
		for iter_13_0, iter_13_1 in pairs(var_13_0) do
			local var_13_2 = arg_13_0:getAttrItem(var_13_1)
			local var_13_3, var_13_4 = arg_13_0:getAttrRatioColor()

			var_13_2:setRatioColor(var_13_3, var_13_4)
			var_13_2:onRefreshMo(iter_13_1, var_13_1)

			var_13_1 = var_13_1 + 1
		end
	end

	for iter_13_2 = 1, #arg_13_0._attrItems do
		gohelper.setActive(arg_13_0._attrItems[iter_13_2].viewGO, iter_13_2 < var_13_1)
	end
end

function var_0_0.getAttrRatioColor(arg_14_0)
	return "#acacac", "#FFAE46"
end

function var_0_0.getAttrItem(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0._attrItems[arg_15_1]

	if not var_15_0 then
		local var_15_1 = gohelper.cloneInPlace(arg_15_0._gobaseitem)

		var_15_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_15_1, RoomCritterDetailAttrItem)
		arg_15_0._attrItems[arg_15_1] = var_15_0
	end

	return var_15_0
end

function var_0_0.refreshSelectParent(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_0._uid ~= arg_16_2 then
		return
	end

	arg_16_0:refreshSelect()
end

function var_0_0.refreshSelect(arg_17_0)
	arg_17_0.isSelect = CritterIncubateModel.instance:isSelectParentCritter(arg_17_0._uid)

	gohelper.setActive(arg_17_0._goselected, arg_17_0.isSelect)
end

return var_0_0
