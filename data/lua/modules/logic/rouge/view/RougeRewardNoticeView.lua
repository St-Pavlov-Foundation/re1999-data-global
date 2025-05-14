module("modules.logic.rouge.view.RougeRewardNoticeView", package.seeall)

local var_0_0 = class("RougeRewardNoticeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._scrollItemList = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_ItemList")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "#scroll_ItemList/Viewport/Content")
	arg_1_0._goItem = gohelper.findChild(arg_1_0.viewGO, "#scroll_ItemList/Viewport/Content/#go_Item")
	arg_1_0._itemList = {}

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0._initView(arg_6_0)
	arg_6_0._season = RougeOutsideModel.instance:season()

	local var_6_0 = RougeRewardConfig.instance:getBigRewardToStage()

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		local var_6_1 = iter_6_1[1]
		local var_6_2 = arg_6_0._itemList[iter_6_0]

		if var_6_2 == nil then
			var_6_2 = arg_6_0:getUserDataTb_()

			local var_6_3 = gohelper.cloneInPlace(arg_6_0._goItem, "rewarditem" .. iter_6_0)

			var_6_2.go = var_6_3
			var_6_2.co = var_6_1
			var_6_2.index = iter_6_0
			var_6_2.txtNum = gohelper.findChildText(var_6_3, "#txt_Num")
			var_6_2.txtItem = gohelper.findChildText(var_6_3, "#txt_Item")
			var_6_2.goGet = gohelper.findChild(var_6_3, "#go_Get")
			var_6_2.goUnGetBg = gohelper.findChild(var_6_3, "image_ItemIconBG2")
			var_6_2.goLockMask = gohelper.findChild(var_6_3, "#go_LockMask")
			var_6_2.goUnlockItem = gohelper.findChild(var_6_3, "#go_UnlockItem")
			var_6_2.imageItemIcon = gohelper.findChildImage(var_6_3, "#image_ItemIcon")
			var_6_2.goNextUnlock = gohelper.findChild(var_6_3, "#go_nextUnlock")
			var_6_2.btn = gohelper.findChildButton(var_6_3, "btn")

			var_6_2.btn:AddClickListener(arg_6_0._btnclickOnClick, arg_6_0, var_6_2)

			var_6_2.animator = var_6_3:GetComponent(typeof(UnityEngine.Animator))
			var_6_2.layoutindex = math.ceil(var_6_2.index / 3)

			table.insert(arg_6_0._itemList, var_6_2)
		end

		if math.floor(var_6_1.bigRewardId / 10) > 0 then
			var_6_2.txtNum.text = var_6_1.bigRewardId
		else
			var_6_2.txtNum.text = string.format("0%d", var_6_1.bigRewardId)
		end

		var_6_2.txtItem.text = var_6_1.name

		if not string.nilorempty(var_6_1.icon) then
			UISpriteSetMgr.instance:setRouge5Sprite(var_6_2.imageItemIcon, var_6_1.icon)
		end

		local var_6_4 = RougeRewardModel.instance:checShowBigRewardGot(var_6_1.bigRewardId)

		gohelper.setActive(var_6_2.goGet, var_6_4)
		gohelper.setActive(var_6_2.goUnGetBg, not var_6_4)

		local var_6_5 = RougeRewardModel.instance:isStageOpen(var_6_1.stage)

		gohelper.setActive(var_6_2.goLockMask, not var_6_5)
		gohelper.setActive(var_6_2.goUnlockItem, not var_6_5)
		gohelper.setActive(var_6_2.imageItemIcon.gameObject, var_6_5)
		gohelper.setActive(var_6_2.btn, var_6_5)

		var_6_2.txtItem.text = var_6_5 and var_6_1.name or var_6_1.lockName

		local var_6_6 = RougeRewardModel.instance:isShowNextStageTag(var_6_1.stage)

		gohelper.setActive(var_6_2.goNextUnlock, var_6_6)
	end
end

function var_0_0._btnclickOnClick(arg_7_0, arg_7_1)
	arg_7_0:_jumpToTargetReward(arg_7_1.index)
end

function var_0_0._jumpToTargetReward(arg_8_0, arg_8_1)
	arg_8_0:closeThis()
	RougeController.instance:dispatchEvent(RougeEvent.OnClickBigReward, arg_8_1)
end

function var_0_0.onOpen(arg_9_0)
	RougeRewardModel.instance:setNextUnlockStage()
	arg_9_0:_initView()
	arg_9_0:_openAnim()
	AudioMgr.instance:trigger(AudioEnum.UI.OpenRewardNoticeView)
end

function var_0_0._openAnim(arg_10_0)
	function arg_10_0._playAnim()
		if not arg_10_0.viewContainer or not arg_10_0.viewContainer._isVisible then
			return
		end

		TaskDispatcher.cancelTask(arg_10_0._playAnim, arg_10_0)

		function arg_10_0.playfunc(arg_12_0)
			if not arg_10_0.viewContainer or not arg_10_0.viewContainer._isVisible then
				return
			end

			TaskDispatcher.cancelTask(arg_10_0.playfunc, arg_12_0)
			gohelper.setActive(arg_12_0.go, true)
			arg_12_0.animator:Update(0)
			arg_12_0.animator:Play("in", 0, 0)
		end

		for iter_11_0, iter_11_1 in pairs(arg_10_0._itemList) do
			local var_11_0 = iter_11_1.layoutindex * 0.06

			TaskDispatcher.runDelay(arg_10_0.playfunc, iter_11_1, var_11_0)
		end
	end

	local var_10_0 = 0.1

	TaskDispatcher.runDelay(arg_10_0._playAnim, arg_10_0, var_10_0)
end

function var_0_0.onClose(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0._itemList) do
		iter_13_1.btn:RemoveClickListener()
	end
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

return var_0_0
