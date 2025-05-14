module("modules.logic.versionactivity1_4.act129.view.Activity129PrizeView", package.seeall)

local var_0_0 = class("Activity129PrizeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goPrize = gohelper.findChild(arg_1_0.viewGO, "#go_Prize")
	arg_1_0.click = gohelper.findChildClick(arg_1_0.goPrize, "click")
	arg_1_0.simageIcon = gohelper.findChildSingleImage(arg_1_0.goPrize, "#simage_ItemIcon")
	arg_1_0.imageIcon = gohelper.findChildImage(arg_1_0.goPrize, "#simage_ItemIcon")
	arg_1_0.gonormal = gohelper.findChild(arg_1_0.viewGO, "normal")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(Activity129Controller.instance, Activity129Event.OnShowSpecialReward, arg_2_0.showReward, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0.click:RemoveClickListener()
	arg_3_0:removeEventCb(Activity129Controller.instance, Activity129Event.OnShowSpecialReward, arg_3_0.showReward, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0.actId = arg_5_0.viewParam.actId
end

function var_0_0.showReward(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0:clear()

	arg_6_0.specialList = arg_6_1
	arg_6_0.list = arg_6_2

	arg_6_0:startShow()
end

function var_0_0.startShow(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_qiutu_award_all)
	gohelper.setActive(arg_7_0.gonormal, false)
	gohelper.setActive(arg_7_0.gonormal, true)
	TaskDispatcher.cancelTask(arg_7_0.continueShow, arg_7_0)
	TaskDispatcher.runDelay(arg_7_0.continueShow, arg_7_0, 1.34)
end

function var_0_0.continueShow(arg_8_0)
	gohelper.setActive(arg_8_0.gonormal, false)

	if not arg_8_0.specialList then
		arg_8_0:onShowEnd()

		return
	end

	arg_8_0:showItem()
end

function var_0_0.showItem(arg_9_0)
	local var_9_0 = table.remove(arg_9_0.specialList, 1)

	if not var_9_0 then
		arg_9_0:onShowEnd()

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_qiutu_award_core)

	local var_9_1, var_9_2 = ItemModel.instance:getItemConfigAndIcon(var_9_0[1], var_9_0[2], true)

	arg_9_0.simageIcon:LoadImage(var_9_2)
	gohelper.setActive(arg_9_0.goPrize, false)
	gohelper.setActive(arg_9_0.goPrize, true)
	TaskDispatcher.cancelTask(arg_9_0.showItem, arg_9_0)
	TaskDispatcher.runDelay(arg_9_0.showItem, arg_9_0, 1.84)
end

function var_0_0.onShowEnd(arg_10_0)
	arg_10_0:clear()
	gohelper.setActive(arg_10_0.goPrize, false)
	gohelper.setActive(arg_10_0.gonormal, false)

	local var_10_0 = arg_10_0.list

	arg_10_0.list = nil
	arg_10_0.specialList = nil

	Activity129Controller.instance:dispatchEvent(Activity129Event.OnShowReward, var_10_0)
end

function var_0_0.clear(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0.showItem, arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0.continueShow, arg_11_0)
end

function var_0_0.onClose(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0.showItem, arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0.continueShow, arg_12_0)
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
