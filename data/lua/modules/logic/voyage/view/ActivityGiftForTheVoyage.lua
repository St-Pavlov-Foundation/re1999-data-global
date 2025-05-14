module("modules.logic.voyage.view.ActivityGiftForTheVoyage", package.seeall)

local var_0_0 = class("ActivityGiftForTheVoyage", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "title/scroll/view/#txt_title")
	arg_1_0._gotaskitem = gohelper.findChild(arg_1_0.viewGO, "scroll_task/Viewport/content/#go_taskitem")
	arg_1_0._goRewards = gohelper.findChild(arg_1_0.viewGO, "scroll_task/Viewport/content/#go_taskitem/scroll_Rewards/Viewport/#go_Rewards")
	arg_1_0._btnjump = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_jump")
	arg_1_0._gomail = gohelper.findChild(arg_1_0.viewGO, "#btn_jump/#go_mail")
	arg_1_0._godungeon = gohelper.findChild(arg_1_0.viewGO, "#btn_jump/#go_dungeon")
	arg_1_0._gored = gohelper.findChild(arg_1_0.viewGO, "#btn_jump/#go_red")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnjump:AddClickListener(arg_2_0._btnjumpOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnjump:RemoveClickListener()
end

function var_0_0._btnjumpOnClick(arg_4_0)
	ViewMgr.instance:closeView(ViewName.ActivityBeginnerView)
	VoyageController.instance:jump()
end

function var_0_0._editableInitView(arg_5_0)
	gohelper.setActive(arg_5_0._gomail, false)
	gohelper.setActive(arg_5_0._godungeon, false)

	arg_5_0._txttitle.text = VoyageConfig.instance:getTitle()
end

function var_0_0.onUpdateParam(arg_6_0)
	arg_6_0:_refresh()
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0 = arg_7_0.viewParam.parent

	gohelper.addChild(var_7_0, arg_7_0.viewGO)
	arg_7_0:_refresh()
	VoyageController.instance:registerCallback(VoyageEvent.OnReceiveAct1001UpdatePush, arg_7_0._refresh, arg_7_0)
	VoyageController.instance:registerCallback(VoyageEvent.OnReceiveAct1001GetInfoReply, arg_7_0._refresh, arg_7_0)
	Activity1001Rpc.instance:sendAct1001GetInfoRequest(VoyageConfig.instance:getActivityId())
	RedDotController.instance:addRedDot(arg_7_0._gored, -11235, nil, arg_7_0._addRedDotOverrideFunc, arg_7_0)
end

function var_0_0.onClose(arg_8_0)
	VoyageController.instance:unregisterCallback(VoyageEvent.OnReceiveAct1001GetInfoReply, arg_8_0._refresh, arg_8_0)
	VoyageController.instance:unregisterCallback(VoyageEvent.OnReceiveAct1001UpdatePush, arg_8_0._refresh, arg_8_0)
end

function var_0_0.onDestroyView(arg_9_0)
	GameUtil.onDestroyViewMemberList(arg_9_0, "_itemList")
end

function var_0_0._createItemList(arg_10_0)
	if arg_10_0._itemList then
		return
	end

	arg_10_0._itemList = {}

	local var_10_0 = VoyageConfig.instance:getTaskList()

	gohelper.setActive(arg_10_0._gotaskitem, true)

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		local var_10_1 = arg_10_0:_createItem(ActivityGiftForTheVoyageItem)

		var_10_1._index = iter_10_0
		var_10_1._view = arg_10_0

		var_10_1:onUpdateMO(iter_10_1)
		var_10_1:setActiveLine(iter_10_0 ~= #var_10_0)
		table.insert(arg_10_0._itemList, var_10_1)
	end

	gohelper.setActive(arg_10_0._gotaskitem, false)
end

function var_0_0._refresh(arg_11_0)
	arg_11_0:_createOrRefreshList()
	arg_11_0:_refreshJumpBtn()
end

function var_0_0._createItem(arg_12_0, arg_12_1)
	local var_12_0 = gohelper.cloneInPlace(arg_12_0._gotaskitem, arg_12_1.__name)

	return MonoHelper.addNoUpdateLuaComOnceToGo(var_12_0, arg_12_1)
end

function var_0_0._createOrRefreshList(arg_13_0)
	arg_13_0:_createItemList()

	for iter_13_0, iter_13_1 in pairs(arg_13_0._itemList) do
		iter_13_1:onRefresh()
	end
end

function var_0_0._refreshJumpBtn(arg_14_0)
	local var_14_0 = VoyageModel.instance:hasAnyRewardAvailable()

	gohelper.setActive(arg_14_0._gomail, var_14_0)
	gohelper.setActive(arg_14_0._godungeon, not var_14_0)
end

function var_0_0._addRedDotOverrideFunc(arg_15_0, arg_15_1)
	arg_15_1.show = VoyageModel.instance:hasAnyRewardAvailable()

	arg_15_1:showRedDot(RedDotEnum.Style.Normal)
end

return var_0_0
