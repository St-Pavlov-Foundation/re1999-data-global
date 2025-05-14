module("modules.logic.room.view.manufacture.RoomCritterOneKeyView", package.seeall)

local var_0_0 = class("RoomCritterOneKeyView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotitlebefore = gohelper.findChild(arg_1_0.viewGO, "title/#go_titlebefore")
	arg_1_0._gotitleafter = gohelper.findChild(arg_1_0.viewGO, "title/#go_titleafter")
	arg_1_0._btnclose = gohelper.findChildClickWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._godragarea = gohelper.findChild(arg_1_0.viewGO, "#go_dragArea")
	arg_1_0._goLayout = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_Layout")
	arg_1_0._gocarditem = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_Layout/#go_carditem")
	arg_1_0._gocomplete = gohelper.findChild(arg_1_0.viewGO, "#go_complete")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._drag:AddDragBeginListener(arg_2_0._onBeginDrag, arg_2_0)
	arg_2_0._drag:AddDragEndListener(arg_2_0._onEndDrag, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._drag:RemoveDragBeginListener()
	arg_3_0._drag:RemoveDragEndListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._onBeginDrag(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._isDrag = true
end

function var_0_0._onEndDrag(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._isDrag = false
end

function var_0_0._btncloseOnClick(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._onCardItemDrag(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0:_onBeginDrag()
	arg_7_0:_onCardItemHover(arg_7_1)
end

function var_0_0._onCardItemHover(arg_8_0, arg_8_1)
	if not arg_8_0._isDrag then
		return
	end

	arg_8_0:_callCritter(arg_8_1)
end

function var_0_0._callCritter(arg_9_0, arg_9_1)
	if not arg_9_0._waitCallCritterDict or not arg_9_0._waitCallCritterDict[arg_9_1] then
		return
	end

	local var_9_0 = arg_9_0._cardItemDict[arg_9_1]

	if var_9_0 then
		var_9_0.animator:Play("card", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_mj_fenpai)
	end

	arg_9_0._waitCallCritterDict[arg_9_1] = nil

	arg_9_0:checkComplete()
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0:clearVar()

	arg_10_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_10_0._godragarea)
	arg_10_0._goclosebtn = arg_10_0._btnclose.gameObject
end

function var_0_0.onUpdateParam(arg_11_0)
	if not arg_11_0.viewParam then
		return
	end

	arg_11_0.type = arg_11_0.viewParam.type
	arg_11_0.infoList = arg_11_0.viewParam.infoList or {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.infoList) do
		for iter_11_2, iter_11_3 in ipairs(iter_11_1.critterUids) do
			arg_11_0._waitCallCritterDict[iter_11_3] = true
		end
	end
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0:onUpdateParam()
	arg_12_0:initCritterCardItem()
	arg_12_0:checkComplete()
end

function var_0_0.initCritterCardItem(arg_13_0)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in pairs(arg_13_0._waitCallCritterDict) do
		var_13_0[#var_13_0 + 1] = iter_13_0
	end

	gohelper.CreateObjList(arg_13_0, arg_13_0.onSetCritterCardItem, var_13_0, arg_13_0._goLayout, arg_13_0._gocarditem)
end

function var_0_0.onSetCritterCardItem(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = arg_14_0:getUserDataTb_()

	var_14_0.go = arg_14_1
	var_14_0.critterUid = arg_14_2
	var_14_0.animator = var_14_0.go:GetComponent(gohelper.Type_Animator)
	var_14_0.imagecardfrontbg = gohelper.findChildImage(arg_14_1, "#simage_cardfrontbg")
	var_14_0.simagecritter = gohelper.findChildSingleImage(arg_14_1, "#simage_cardfrontbg/#simage_critter")
	var_14_0.simagecardback = gohelper.findChildSingleImage(arg_14_1, "#simage_cardback")

	var_14_0.animator:Play("idle", 0, 0)

	local var_14_1 = CritterModel.instance:getCritterMOByUid(var_14_0.critterUid)

	if var_14_1 then
		local var_14_2 = var_14_1:getDefineId()
		local var_14_3 = ResUrl.getCritterLargeIcon(var_14_2)

		var_14_0.simagecritter:LoadImage(var_14_3)

		local var_14_4 = CritterConfig.instance:getCritterCatalogue(var_14_2)
		local var_14_5 = CritterConfig.instance:getBaseCard(var_14_4)

		UISpriteSetMgr.instance:setCritterSprite(var_14_0.imagecardfrontbg, var_14_5)
	else
		logError(string.format("RoomCritterOneKeyView:onSetCritterCardItem no critterMO, critterUid:%s", arg_14_2))
	end

	var_14_0.click = SLFramework.UGUI.UIClickListener.Get(var_14_0.go)
	var_14_0.drag = SLFramework.UGUI.UIDragListener.Get(var_14_0.go)
	var_14_0.press = SLFramework.UGUI.UILongPressListener.Get(var_14_0.go)

	var_14_0.click:AddClickListener(arg_14_0._callCritter, arg_14_0, arg_14_2)
	var_14_0.drag:AddDragBeginListener(arg_14_0._onCardItemDrag, arg_14_0, arg_14_2)
	var_14_0.drag:AddDragEndListener(arg_14_0._onEndDrag, arg_14_0)
	var_14_0.press:AddHoverListener(arg_14_0._onCardItemHover, arg_14_0, arg_14_2)

	arg_14_0._cardItemDict[arg_14_2] = var_14_0
end

function var_0_0.checkComplete(arg_15_0)
	local var_15_0 = not next(arg_15_0._waitCallCritterDict)

	if var_15_0 then
		RoomRpc.instance:sendRouseCrittersRequest(arg_15_0.type, arg_15_0.infoList)
	end

	gohelper.setActive(arg_15_0._gotitlebefore, not var_15_0)
	gohelper.setActive(arg_15_0._godragarea, not var_15_0)
	gohelper.setActive(arg_15_0._gotitleafter, var_15_0)
	gohelper.setActive(arg_15_0._goclosebtn, var_15_0)
	gohelper.setActive(arg_15_0._gocomplete, var_15_0)
end

function var_0_0.clearVar(arg_16_0)
	arg_16_0._waitCallCritterDict = {}

	if arg_16_0._cardItemDict then
		for iter_16_0, iter_16_1 in pairs(arg_16_0._cardItemDict) do
			iter_16_1.simagecritter:UnLoadImage()
			iter_16_1.simagecardback:UnLoadImage()
			iter_16_1.click:RemoveClickListener()
			iter_16_1.drag:RemoveDragBeginListener()
			iter_16_1.drag:RemoveDragEndListener()
			iter_16_1.press:RemoveHoverListener()
		end
	end

	arg_16_0._cardItemDict = {}
	arg_16_0._isDrag = false
end

function var_0_0.onClose(arg_17_0)
	return
end

function var_0_0.onDestroyView(arg_18_0)
	arg_18_0:clearVar()
end

return var_0_0
