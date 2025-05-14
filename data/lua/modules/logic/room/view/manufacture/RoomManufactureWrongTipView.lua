module("modules.logic.room.view.manufacture.RoomManufactureWrongTipView", package.seeall)

local var_0_0 = class("RoomManufactureWrongTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goroot = gohelper.findChild(arg_1_0.viewGO, "root")
	arg_1_0._gorightroot = gohelper.findChild(arg_1_0.viewGO, "rightRoot")
	arg_1_0._goworngPop = gohelper.findChild(arg_1_0.viewGO, "root/#go_wrongPop")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#go_wrongPop/#simage_bg")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "root/#go_wrongPop/#txt_title")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_wrongPop/#btn_close")
	arg_1_0._scrolllist = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/#go_wrongPop/#scroll_list")
	arg_1_0._gotipcontent = gohelper.findChild(arg_1_0.viewGO, "root/#go_wrongPop/#scroll_list/viewport/content")
	arg_1_0._gotipItem = gohelper.findChild(arg_1_0.viewGO, "root/#go_wrongPop/#scroll_list/viewport/content/#go_tipItem")

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

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	if not arg_6_0.viewParam then
		return
	end

	arg_6_0.isRight = arg_6_0.viewParam.isRight
	arg_6_0.buildingUid = arg_6_0.viewParam.buildingUid

	arg_6_0:setTipItems()
	ManufactureController.instance:dispatchEvent(ManufactureEvent.OnWrongTipViewChange, arg_6_0.buildingUid)
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:onUpdateParam()

	if arg_7_0.isRight then
		gohelper.addChild(arg_7_0._gorightroot, arg_7_0._goworngPop)
	end
end

function var_0_0.setTipItems(arg_8_0)
	arg_8_0.tipItemList = {}

	local var_8_0 = ManufactureModel.instance:getManufactureWrongTipItemList(arg_8_0.buildingUid)

	gohelper.CreateObjList(arg_8_0, arg_8_0._onSetTipItem, var_8_0, arg_8_0._gotipcontent, arg_8_0._gotipItem, RoomManufactureWrongTipItem)
end

function var_0_0._onSetTipItem(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0.tipItemList[arg_9_3] = arg_9_1

	arg_9_1:setData(arg_9_0.buildingUid, arg_9_2.manufactureItemId, arg_9_2.wrongSlotIdList, arg_9_0.isRight)
end

function var_0_0.onClose(arg_10_0)
	ManufactureController.instance:dispatchEvent(ManufactureEvent.OnWrongTipViewChange)
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
