module("modules.logic.sp01.act205.view.card.Act205CardResultView", package.seeall)

local var_0_0 = class("Act205CardResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "Right/#txt_Descr")
	arg_1_0._goreward = gohelper.findChild(arg_1_0.viewGO, "Right/#go_reward")
	arg_1_0._gorewardItem = gohelper.findChild(arg_1_0.viewGO, "Right/#go_reward/#go_rewardItem")
	arg_1_0._btnFinished = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/LayoutGroup/#btn_Finished")
	arg_1_0._btnNew = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/LayoutGroup/#btn_New")
	arg_1_0._txtGameTimes = gohelper.findChildText(arg_1_0.viewGO, "Right/LayoutGroup/#btn_New/#txt_GameTimes")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnFinished:AddClickListener(arg_2_0._btnFinishedOnClick, arg_2_0)
	arg_2_0._btnNew:AddClickListener(arg_2_0._btnNewOnClick, arg_2_0)
	arg_2_0:addEventCb(Act205Controller.instance, Act205Event.OnInfoUpdate, arg_2_0.refreshTimesInfo, arg_2_0)
	NavigateMgr.instance:addEscape(arg_2_0.viewName, arg_2_0._btnFinishedOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnFinished:RemoveClickListener()
	arg_3_0._btnNew:RemoveClickListener()
	arg_3_0:removeEventCb(Act205Controller.instance, Act205Event.OnInfoUpdate, arg_3_0.refreshTimesInfo, arg_3_0)
end

function var_0_0._btnFinishedOnClick(arg_4_0)
	if Act205CardModel.instance:getGameCount() > 0 then
		Act205CardController.instance:openCardEnterView()
	end

	ViewMgr.instance:closeView(ViewName.Act205CardShowView)
	arg_4_0:closeThis()
end

function var_0_0._btnNewOnClick(arg_5_0)
	Act205CardController.instance:beginNewCardGame()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._pointResultGoDict = arg_6_0:getUserDataTb_()

	local var_6_0 = Act205Config.instance:getPointList()

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		local var_6_1 = gohelper.findChild(arg_6_0.viewGO, string.format("pointResult/%s", iter_6_1))

		if not gohelper.isNil(var_6_1) then
			arg_6_0._pointResultGoDict[iter_6_1] = var_6_1
		end
	end
end

function var_0_0.onUpdateParam(arg_7_0)
	arg_7_0._point = arg_7_0.viewParam.point
	arg_7_0._rewardId = arg_7_0.viewParam.rewardId
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:onUpdateParam()

	local var_8_0 = Act205Config.instance:getGameRewardConfig(Act205Enum.GameStageId.Card, arg_8_0._rewardId)

	arg_8_0._txtDescr.text = var_8_0.rewardDesc

	arg_8_0:refreshPointResult()
	arg_8_0:refreshTimesInfo()
	arg_8_0:createRewardItem(var_8_0)
	TaskDispatcher.runDelay(arg_8_0.showRewardItemGet, arg_8_0, 1)
end

function var_0_0.refreshPointResult(arg_9_0)
	local var_9_0 = arg_9_0._point
	local var_9_1 = arg_9_0._pointResultGoDict[var_9_0]

	if gohelper.isNil(var_9_1) then
		var_9_0 = 0
	end

	for iter_9_0, iter_9_1 in pairs(arg_9_0._pointResultGoDict) do
		gohelper.setActive(iter_9_1, iter_9_0 == var_9_0)
	end

	AudioMgr.instance:trigger(var_9_0 <= 0 and AudioEnum2_9.Activity205.play_ui_s01_yunying_fail or AudioEnum2_9.Activity205.play_ui_s01_yunying_win)
end

function var_0_0.refreshTimesInfo(arg_10_0)
	local var_10_0 = Act205Model.instance:getAct205Id()
	local var_10_1 = Act205Config.instance:getStageConfig(var_10_0, Act205Enum.GameStageId.Card).times
	local var_10_2 = Act205CardModel.instance:getGameCount()

	arg_10_0._txtGameTimes.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("act205_remainGameTimes"), var_10_2, var_10_1)

	local var_10_3 = var_10_2 > 0

	gohelper.setActive(arg_10_0._btnNew.gameObject, var_10_3)
end

function var_0_0.createRewardItem(arg_11_0, arg_11_1)
	arg_11_0.rewardItemList = {}

	local var_11_0 = GameUtil.splitString2(arg_11_1.bonus, true)

	gohelper.CreateObjList(arg_11_0, arg_11_0._onCreateRewardItem, var_11_0, arg_11_0._goreward, arg_11_0._gorewardItem)
end

function var_0_0._onCreateRewardItem(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = arg_12_0:getUserDataTb_()

	var_12_0.go = arg_12_1

	local var_12_1 = gohelper.findChild(var_12_0.go, "go_rewardPos")

	var_12_0.itemIcon = IconMgr.instance:getCommonPropItemIcon(var_12_1)

	var_12_0.itemIcon:setMOValue(arg_12_2[1], arg_12_2[2], arg_12_2[3])
	var_12_0.itemIcon:isShowCount(true)
	var_12_0.itemIcon:setCountFontSize(40)
	var_12_0.itemIcon:showStackableNum2()
	var_12_0.itemIcon:setHideLvAndBreakFlag(true)
	var_12_0.itemIcon:hideEquipLvAndBreak(true)

	var_12_0.goRewardGet = gohelper.findChild(var_12_0.go, "go_rewardGet")

	gohelper.setActive(var_12_0.goRewardGet, false)

	arg_12_0.rewardItemList[arg_12_3] = var_12_0
end

function var_0_0.showRewardItemGet(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.rewardItemList) do
		gohelper.setActive(iter_13_1.goRewardGet, true)
	end
end

function var_0_0.onClose(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0.showRewardItemGet, arg_14_0)
end

function var_0_0.onDestroyView(arg_15_0)
	return
end

return var_0_0
