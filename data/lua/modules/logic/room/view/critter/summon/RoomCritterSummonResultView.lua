module("modules.logic.room.view.critter.summon.RoomCritterSummonResultView", package.seeall)

local var_0_0 = class("RoomCritterSummonResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._txtclose = gohelper.findChildText(arg_1_0.viewGO, "#btn_close/#txt_close")
	arg_1_0._goposcontent = gohelper.findChild(arg_1_0.viewGO, "#go_pos_content")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "#go_item")
	arg_1_0._goegg = gohelper.findChild(arg_1_0.viewGO, "#go_item/#go_egg")
	arg_1_0._gocritter = gohelper.findChild(arg_1_0.viewGO, "#go_item/#go_critter")
	arg_1_0._imagequality = gohelper.findChildImage(arg_1_0.viewGO, "#go_item/#go_critter/#image_quality")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_item/#go_critter/#simage_icon")
	arg_1_0._btnopenEgg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_item/#btn_openEgg")
	arg_1_0._btnopenall = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_openall")
	arg_1_0._btnskip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_skip")
	arg_1_0._imageskip = gohelper.findChildImage(arg_1_0.viewGO, "#btn_skip/#image_skip")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnopenEgg:AddClickListener(arg_2_0._btnopenEggOnClick, arg_2_0)
	arg_2_0._btnopenall:AddClickListener(arg_2_0._btnopenallOnClick, arg_2_0)
	arg_2_0._btnskip:AddClickListener(arg_2_0._btnskipOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnopenEgg:RemoveClickListener()
	arg_3_0._btnopenall:RemoveClickListener()
	arg_3_0._btnskip:RemoveClickListener()
end

function var_0_0._btnskipOnClick(arg_4_0)
	arg_4_0:_setAllOpen(true)
	arg_4_0:_refreshUI()
end

function var_0_0._btnopenallOnClick(arg_5_0)
	local var_5_0 = arg_5_0:_findNotOpenMOList()

	if var_5_0 and #var_5_0 > 0 then
		local var_5_1 = {
			mode = RoomSummonEnum.SummonType.Summon,
			critterMo = var_5_0[1],
			critterMOList = var_5_0
		}

		CritterSummonController.instance:openSummonGetCritterView(var_5_1, true)
		arg_5_0:_setAllOpen()
	end
end

function var_0_0._btncloseOnClick(arg_6_0)
	if arg_6_0:isAllOpen() then
		arg_6_0:closeThis()
		CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingViewRefreshCamera)
		CritterSummonController.instance:dispatchEvent(CritterSummonEvent.onCloseGetCritter)
	end
end

function var_0_0._btnopenEggOnClick(arg_7_0)
	return
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._itemCompList = {}

	for iter_8_0 = 1, 10 do
		local var_8_0 = gohelper.findChild(arg_8_0._goposcontent, "go_pos" .. iter_8_0)
		local var_8_1 = gohelper.clone(arg_8_0._goitem, var_8_0)
		local var_8_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_8_1, RoomCritterSummonResultItem)

		var_8_2._view = arg_8_0
		arg_8_0._itemCompList[iter_8_0] = var_8_2
	end

	gohelper.setActive(arg_8_0._goitem)
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_niudan_obtain)
	arg_10_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_10_0._onOpenCloseView, arg_10_0)
	arg_10_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_10_0._onOpenCloseView, arg_10_0)

	local var_10_0 = {}

	if arg_10_0.viewParam and arg_10_0.viewParam.critterMOList then
		tabletool.addValues(var_10_0, arg_10_0.viewParam.critterMOList)
	end

	arg_10_0._critterMOList = var_10_0

	arg_10_0:_refreshCritterUI()
	arg_10_0:_refreshUI()
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0._onOpenCloseView(arg_12_0)
	local var_12_0 = ViewMgr.instance:isOpen(ViewName.RoomGetCritterView)

	if arg_12_0._lastIsOpen ~= var_12_0 then
		arg_12_0._lastIsOpen = var_12_0

		arg_12_0:_refreshUI()

		if not var_12_0 then
			local var_12_1 = false

			for iter_12_0 = 1, #arg_12_0._itemCompList do
				local var_12_2 = arg_12_0._itemCompList[iter_12_0]

				if var_12_2.critterMO then
					local var_12_3 = var_12_2:isOpenEgg()

					if var_12_2:playAnim(var_12_3) then
						var_12_1 = true
					end
				end
			end

			if var_12_1 then
				AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_niudan_shilian1)
			end
		end
	end
end

function var_0_0._refreshUI(arg_13_0)
	local var_13_0 = arg_13_0:isAllOpen()

	gohelper.setActive(arg_13_0._txtclose, var_13_0)
	gohelper.setActive(arg_13_0._btnopenall, not var_13_0)
	gohelper.setActive(arg_13_0._btnskip, not var_13_0)
end

function var_0_0._refreshCritterUI(arg_14_0)
	for iter_14_0 = 1, #arg_14_0._itemCompList do
		arg_14_0._itemCompList[iter_14_0]:onUpdateMO(arg_14_0._critterMOList[iter_14_0])
	end
end

function var_0_0.isAllOpen(arg_15_0)
	for iter_15_0 = 1, #arg_15_0._itemCompList do
		if not arg_15_0._itemCompList[iter_15_0]:isOpenEgg() and arg_15_0._critterMOList[iter_15_0] then
			return false
		end
	end

	return true
end

function var_0_0._findNotOpenMOList(arg_16_0, arg_16_1)
	local var_16_0

	for iter_16_0 = 1, #arg_16_0._itemCompList do
		if not arg_16_0._itemCompList[iter_16_0]:isOpenEgg() and arg_16_0._critterMOList[iter_16_0] then
			var_16_0 = var_16_0 or {}

			table.insert(var_16_0, arg_16_0._critterMOList[iter_16_0])
		end
	end

	return var_16_0
end

function var_0_0._setAllOpen(arg_17_0, arg_17_1)
	local var_17_0 = false

	for iter_17_0 = 1, #arg_17_0._itemCompList do
		if arg_17_0._critterMOList[iter_17_0] then
			local var_17_1 = arg_17_0._itemCompList[iter_17_0]

			var_17_1:setOpenEgg(true)

			if arg_17_1 and var_17_1:playAnim(true) then
				var_17_0 = true
			end
		end
	end

	if var_17_0 then
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_niudan_shilian1)
	end
end

function var_0_0.onDestroyView(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0._itemCompList) do
		iter_18_1:onDestroy()
	end
end

return var_0_0
