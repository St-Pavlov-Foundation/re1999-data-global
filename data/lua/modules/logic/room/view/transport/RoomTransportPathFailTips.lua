module("modules.logic.room.view.transport.RoomTransportPathFailTips", package.seeall)

local var_0_0 = class("RoomTransportPathFailTips", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_content")
	arg_1_0._btntips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_content/#btn_tips")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_content/expand/#btn_close")
	arg_1_0._scrolldec = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_content/expand/bg/#scroll_dec")
	arg_1_0._godecitem = gohelper.findChild(arg_1_0.viewGO, "#go_content/expand/bg/#scroll_dec/viewport/content/#go_decitem")
	arg_1_0._txtdec = gohelper.findChildText(arg_1_0.viewGO, "#go_content/expand/bg/#scroll_dec/viewport/content/#go_decitem/#txt_dec")
	arg_1_0._txtfailcount = gohelper.findChildText(arg_1_0.viewGO, "#go_content/#txt_failcount")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntips:AddClickListener(arg_2_0._btntipsOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntips:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btntipsOnClick(arg_4_0)
	arg_4_0._isShow = true

	gohelper.setActive(arg_4_0._goexpand, true)
	gohelper.setActive(arg_4_0._btntips, false)
	arg_4_0._animatorPlayer:Play(UIAnimationName.Open, arg_4_0._animDone, arg_4_0)
end

function var_0_0._btncloseOnClick(arg_5_0)
	arg_5_0._isShow = false

	arg_5_0._animatorPlayer:Play(UIAnimationName.Close, arg_5_0._animDone, arg_5_0)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._goexpand = gohelper.findChild(arg_6_0.viewGO, "#go_content/expand")

	gohelper.setActive(arg_6_0._goexpand, false)

	arg_6_0._isShow = false
	arg_6_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_6_0._goexpand)
	arg_6_0._slotDataList = {
		{
			slotType = RoomBuildingEnum.BuildingType.Collect
		},
		{
			slotType = RoomBuildingEnum.BuildingType.Process
		},
		{
			slotType = RoomBuildingEnum.BuildingType.Manufacture
		}
	}
	arg_6_0._tbItemList = {
		arg_6_0:_createTB(arg_6_0._godecitem)
	}

	for iter_6_0 = 1, #arg_6_0._slotDataList do
		local var_6_0 = arg_6_0._tbItemList[iter_6_0]

		if var_6_0 == nil then
			local var_6_1 = gohelper.cloneInPlace(arg_6_0._godecitem)

			var_6_0 = arg_6_0:_createTB(var_6_1)

			table.insert(arg_6_0._tbItemList, var_6_0)
		end

		var_6_0.dataMO = arg_6_0._slotDataList[iter_6_0]

		local var_6_2 = RoomTransportPathEnum.TipLang[var_6_0.dataMO.slotType]

		var_6_0._txtdec.text = luaLang(var_6_2)
	end
end

function var_0_0._animDone(arg_7_0)
	if not arg_7_0._isShow then
		gohelper.setActive(arg_7_0._goexpand, false)
		gohelper.setActive(arg_7_0._btntips, true)
	end
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:addEventCb(RoomMapController.instance, RoomEvent.TransportPathLineChanged, arg_9_0.refreshUI, arg_9_0)
	arg_9_0:refreshUI()
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

function var_0_0.refreshUI(arg_12_0)
	local var_12_0 = RoomMapTransportPathModel.instance:getLinkFailCount()

	if arg_12_0._lastFailCount ~= var_12_0 then
		arg_12_0._lastFailCount = var_12_0

		gohelper.setActive(arg_12_0._gocontent, var_12_0 > 0)

		arg_12_0._txtfailcount.text = var_12_0
	end

	if var_12_0 > 0 then
		arg_12_0:_refreshItemTbList()
	end
end

function var_0_0._refreshItemTbList(arg_13_0)
	local var_13_0 = RoomMapTransportPathModel.instance

	for iter_13_0 = 1, #arg_13_0._tbItemList do
		local var_13_1 = arg_13_0._tbItemList[iter_13_0]
		local var_13_2, var_13_3 = RoomTransportHelper.getSiteFromToByType(var_13_1.dataMO.slotType)
		local var_13_4 = var_13_0:getTransportPathMOBy2Type(var_13_2, var_13_3)
		local var_13_5 = true

		if var_13_4 and var_13_4:isLinkFinish() then
			var_13_5 = false
		end

		gohelper.setActive(var_13_1.go, var_13_5)
	end
end

function var_0_0._createTB(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getUserDataTb_()

	var_14_0.go = arg_14_1
	var_14_0._txtdec = gohelper.findChildText(arg_14_1, "#txt_dec")

	return var_14_0
end

var_0_0.prefabPath = "ui/viewres/room/transport/roomtransportpathfailtips.prefab"

return var_0_0
