module("modules.logic.turnback.view.TurnbackTaskBonusItem", package.seeall)

local var_0_0 = class("TurnbackTaskBonusItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.param = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0:__onInit()

	arg_2_0.go = arg_2_1
	arg_2_0.index = arg_2_0.param.index
	arg_2_0.goItemContent = gohelper.findChild(arg_2_0.go, "scroll_item/Viewport/go_itemContent")
	arg_2_0.goGetState = gohelper.findChild(arg_2_0.go, "rewardState/go_get")
	arg_2_0.btnCanGetState = gohelper.findChildButtonWithAudio(arg_2_0.go, "rewardState/btn_canget")
	arg_2_0.goDoingState = gohelper.findChild(arg_2_0.go, "rewardState/go_doing")
	arg_2_0.goNotGetActiveState = gohelper.findChild(arg_2_0.go, "activeState/go_notget")
	arg_2_0.txtNoGetActiveState = gohelper.findChildText(arg_2_0.go, "activeState/go_notget/txt_notgetNum")
	arg_2_0.goCanGetActiveState = gohelper.findChild(arg_2_0.go, "activeState/go_canget")
	arg_2_0.txtCanGetActiveState = gohelper.findChildText(arg_2_0.go, "activeState/go_canget/txt_cangetNum")
	arg_2_0.goRedDot = gohelper.findChild(arg_2_0.go, "go_reddot")
	arg_2_0._scrollitem = gohelper.findChild(arg_2_0.go, "scroll_item"):GetComponent(typeof(ZProj.LimitedScrollRect))
	arg_2_0._scrollitem.parentGameObject = arg_2_0.param.parentScrollGO
	arg_2_0._goGetAnim = gohelper.findChild(arg_2_0.go, "ani")

	arg_2_0:initItem()
	arg_2_0:refreshItem()
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0.btnCanGetState:AddClickListener(arg_3_0._btnCanGetOnClick, arg_3_0)
	arg_3_0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshTaskRewardItem, arg_3_0.refreshItem, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0.btnCanGetState:RemoveClickListener()
	arg_4_0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshTaskRewardItem, arg_4_0.refreshItem, arg_4_0)
end

function var_0_0.initItem(arg_5_0)
	arg_5_0.rewardTab = {}
	arg_5_0.curTurnbackId = TurnbackModel.instance:getCurTurnbackId()
	arg_5_0.config = TurnbackConfig.instance:getTurnbackTaskBonusCo(arg_5_0.curTurnbackId, arg_5_0.index)
	arg_5_0.bonusPointType, arg_5_0.bonusPointId = TurnbackConfig.instance:getBonusPointCo(arg_5_0.curTurnbackId)

	local var_5_0 = string.split(arg_5_0.config.bonus, "|")

	for iter_5_0 = 1, #var_5_0 do
		local var_5_1 = string.split(var_5_0[iter_5_0], "#")
		local var_5_2 = IconMgr.instance:getCommonPropItemIcon(arg_5_0.goItemContent)

		var_5_2:setMOValue(var_5_1[1], var_5_1[2], var_5_1[3])
		var_5_2:setPropItemScale(0.55)
		var_5_2:setHideLvAndBreakFlag(true)
		var_5_2:hideEquipLvAndBreak(true)
		var_5_2:setCountFontSize(50)
		table.insert(arg_5_0.rewardTab, var_5_2)
	end

	arg_5_0.txtNoGetActiveState.text = arg_5_0.config.needPoint
	arg_5_0.txtCanGetActiveState.text = arg_5_0.config.needPoint

	gohelper.setActive(arg_5_0._goGetAnim, false)
end

function var_0_0.refreshItem(arg_6_0)
	arg_6_0.hasGetState = false

	local var_6_0 = CurrencyModel.instance:getCurrency(arg_6_0.bonusPointId)
	local var_6_1 = var_6_0 and var_6_0.quantity or 0

	gohelper.setActive(arg_6_0.goNotGetActiveState, var_6_1 < arg_6_0.config.needPoint)
	gohelper.setActive(arg_6_0.goCanGetActiveState, var_6_1 >= arg_6_0.config.needPoint)

	local var_6_2 = TurnbackModel.instance:getCurHasGetTaskBonus()

	for iter_6_0, iter_6_1 in ipairs(var_6_2) do
		if iter_6_1 == arg_6_0.index then
			arg_6_0.hasGetState = true

			break
		end
	end

	gohelper.setActive(arg_6_0.goGetState, arg_6_0.hasGetState)
	gohelper.setActive(arg_6_0.btnCanGetState.gameObject, not arg_6_0.hasGetState and var_6_1 >= arg_6_0.config.needPoint)
	gohelper.setActive(arg_6_0.goDoingState, not arg_6_0.hasGetState and var_6_1 < arg_6_0.config.needPoint)
	gohelper.setActive(arg_6_0.goRedDot, false)

	for iter_6_2, iter_6_3 in ipairs(arg_6_0.rewardTab) do
		iter_6_3:setGetMask(arg_6_0.hasGetState)
	end
end

function var_0_0._btnCanGetOnClick(arg_7_0)
	gohelper.setActive(arg_7_0._goGetAnim, true)
	UIBlockMgr.instance:startBlock("TurnbackTaskBonusItemFinish")
	TaskDispatcher.runDelay(arg_7_0._playGetAnimFinish, arg_7_0, TurnbackEnum.TaskGetBonusAnimTime)
	AudioMgr.instance:trigger(AudioEnum.RewardPoint.play_ui_track_achievement_single)
end

function var_0_0._playGetAnimFinish(arg_8_0)
	gohelper.setActive(arg_8_0._goGetAnim, false)
	UIBlockMgr.instance:endBlock("TurnbackTaskBonusItemFinish")

	local var_8_0 = {
		id = TurnbackModel.instance:getCurTurnbackId(),
		bonusPointId = arg_8_0.index
	}

	TurnbackRpc.instance:sendTurnbackBonusPointRequest(var_8_0)
end

function var_0_0.destroy(arg_9_0)
	arg_9_0:__onDispose()
	TaskDispatcher.TaskDispatcher.cancelTask(arg_9_0._playGetAnimFinish, arg_9_0)
end

return var_0_0
