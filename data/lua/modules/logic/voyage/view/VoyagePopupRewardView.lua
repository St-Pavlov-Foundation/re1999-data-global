module("modules.logic.voyage.view.VoyagePopupRewardView", package.seeall)

local var_0_0 = class("VoyagePopupRewardView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goclickmask = gohelper.findChild(arg_1_0.viewGO, "Root/#go_clickmask")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_bg")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "Root/desc_scroll/viewport/#txt_title")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "Root/reward_scroll/viewport/content/#go_normal")
	arg_1_0._imagenum = gohelper.findChildImage(arg_1_0.viewGO, "Root/reward_scroll/viewport/content/#go_normal/#image_num")
	arg_1_0._goimgall = gohelper.findChild(arg_1_0.viewGO, "Root/reward_scroll/viewport/content/#go_normal/#go_imgall")
	arg_1_0._txttaskdesc = gohelper.findChildText(arg_1_0.viewGO, "Root/reward_scroll/viewport/content/#go_normal/#txt_taskdesc")
	arg_1_0._goRewards = gohelper.findChild(arg_1_0.viewGO, "Root/reward_scroll/viewport/content/#go_normal/scroll_Rewards/Viewport/#go_Rewards")
	arg_1_0._btnjump = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/#btn_jump")
	arg_1_0._gomail = gohelper.findChild(arg_1_0.viewGO, "Root/#btn_jump/#go_mail")
	arg_1_0._godungeon = gohelper.findChild(arg_1_0.viewGO, "Root/#btn_jump/#go_dungeon")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnjump:AddClickListener(arg_2_0._btnjumpOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnjump:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btnjumpOnClick(arg_4_0)
	VoyageController.instance:jump()
end

function var_0_0._btncloseOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0:addClickCb(gohelper.getClick(arg_6_0._goclickmask), arg_6_0.closeThis, arg_6_0)

	arg_6_0._txttitle.text = VoyageConfig.instance:getTitle()

	gohelper.setActive(arg_6_0._gomail, false)
	gohelper.setActive(arg_6_0._godungeon, false)
end

function var_0_0.onUpdateParam(arg_7_0)
	arg_7_0:_refresh()
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:_refresh()
	VoyageController.instance:registerCallback(VoyageEvent.OnReceiveAct1001UpdatePush, arg_8_0._refresh, arg_8_0)
	VoyageController.instance:registerCallback(VoyageEvent.OnReceiveAct1001GetInfoReply, arg_8_0._refresh, arg_8_0)
end

function var_0_0.onClose(arg_9_0)
	VoyageController.instance:unregisterCallback(VoyageEvent.OnReceiveAct1001GetInfoReply, arg_9_0._refresh, arg_9_0)
	VoyageController.instance:unregisterCallback(VoyageEvent.OnReceiveAct1001UpdatePush, arg_9_0._refresh, arg_9_0)
end

function var_0_0.onDestroyView(arg_10_0)
	GameUtil.onDestroyViewMemberList(arg_10_0, "_itemList")
end

function var_0_0._createOrRefreshList(arg_11_0)
	arg_11_0:_createItemList()

	for iter_11_0, iter_11_1 in pairs(arg_11_0._itemList) do
		iter_11_1:onRefresh()
	end
end

function var_0_0._createItemList(arg_12_0)
	if arg_12_0._itemList then
		return
	end

	arg_12_0._itemList = {}

	gohelper.setActive(arg_12_0._gonormal, true)

	local var_12_0 = VoyageConfig.instance:getTaskList()

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		local var_12_1 = arg_12_0:_createItem(VoyagePopupRewardViewItem)

		var_12_1._index = iter_12_0
		var_12_1._view = arg_12_0

		var_12_1:onUpdateMO(iter_12_1)
		table.insert(arg_12_0._itemList, var_12_1)
	end

	gohelper.setActive(arg_12_0._gonormal, false)
end

function var_0_0._refresh(arg_13_0)
	arg_13_0:_createOrRefreshList()
	arg_13_0:_refreshJumpBtn()
end

function var_0_0._createItem(arg_14_0, arg_14_1)
	local var_14_0 = gohelper.cloneInPlace(arg_14_0._gonormal, arg_14_1.__name)

	return MonoHelper.addNoUpdateLuaComOnceToGo(var_14_0, arg_14_1)
end

function var_0_0._refreshJumpBtn(arg_15_0)
	local var_15_0 = VoyageModel.instance:hasAnyRewardAvailable()

	gohelper.setActive(arg_15_0._gomail, var_15_0)
	gohelper.setActive(arg_15_0._godungeon, not var_15_0)
end

return var_0_0
