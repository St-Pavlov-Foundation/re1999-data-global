module("modules.logic.roomfishing.view.RoomFishingRewardView", package.seeall)

local var_0_0 = class("RoomFishingRewardView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goState1 = gohelper.findChild(arg_1_0.viewGO, "#go_State1")
	arg_1_0._btnView = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_State1/#btn_View")
	arg_1_0._btnskip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_State1/#btn_skip")
	arg_1_0._goState2 = gohelper.findChild(arg_1_0.viewGO, "#go_State2")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_State2/#btn_Close")
	arg_1_0._gomyfishing = gohelper.findChild(arg_1_0.viewGO, "#go_State2/ScrollView/Viewport/Content/#go_myfishing")
	arg_1_0._txtmyfishing = gohelper.findChildText(arg_1_0.viewGO, "#go_State2/ScrollView/Viewport/Content/#go_myfishing/Tips/image_TipsBG/#txt_Statistics")
	arg_1_0._gomyfishingcontent = gohelper.findChild(arg_1_0.viewGO, "#go_State2/ScrollView/Viewport/Content/#go_myfishing/Grid")
	arg_1_0._gomyfishingitem = gohelper.findChild(arg_1_0.viewGO, "#go_State2/ScrollView/Viewport/Content/#go_myfishing/Grid/#go_Item")
	arg_1_0._gootherfishing = gohelper.findChild(arg_1_0.viewGO, "#go_State2/ScrollView/Viewport/Content/#go_otherfishing")
	arg_1_0._txtotherfishing = gohelper.findChildText(arg_1_0.viewGO, "#go_State2/ScrollView/Viewport/Content/#go_otherfishing/Tips/image_TipsBG/#txt_Statistics")
	arg_1_0._gootherfishingcontent = gohelper.findChild(arg_1_0.viewGO, "#go_State2/ScrollView/Viewport/Content/#go_otherfishing/Grid")
	arg_1_0._gootherfishingitem = gohelper.findChild(arg_1_0.viewGO, "#go_State2/ScrollView/Viewport/Content/#go_otherfishing/Grid/#go_Item")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnView:AddClickListener(arg_2_0._btnViewOnClick, arg_2_0)
	arg_2_0._btnskip:AddClickListener(arg_2_0._btnskipOnClick, arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
	arg_2_0._stateAnimEventWrap:AddEventListener("openReward", arg_2_0._onOpenReward, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnView:RemoveClickListener()
	arg_3_0._btnskip:RemoveClickListener()
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0._stateAnimEventWrap:RemoveAllEventListener()
end

function var_0_0._btnViewOnClick(arg_4_0)
	if arg_4_0._stateAnimator then
		arg_4_0._stateAnimator:Play("click", 0, 0)
		AudioMgr.instance:trigger(AudioEnum3_1.RoomFishing.ui_home_mingdi_huoqu1)
	else
		arg_4_0:_btnskipOnClick()
	end
end

function var_0_0._btnskipOnClick(arg_5_0)
	gohelper.setActive(arg_5_0._goState1, false)
	gohelper.setActive(arg_5_0._goState2, true)
	AudioMgr.instance:trigger(AudioEnum3_1.RoomFishing.ui_home_mingdi_huoqu2)
end

function var_0_0._btnCloseOnClick(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._onOpenReward(arg_7_0)
	arg_7_0:_btnskipOnClick()
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._stateAnimator = arg_8_0._goState1:GetComponent(typeof(UnityEngine.Animator))
	arg_8_0._stateAnimEventWrap = arg_8_0._goState1:GetComponent(typeof(ZProj.AnimationEventWrap))

	gohelper.setActive(arg_8_0._goState1, true)
	gohelper.setActive(arg_8_0._goState2, false)
end

function var_0_0.onUpdateParam(arg_9_0)
	local var_9_0 = arg_9_0.viewParam and arg_9_0.viewParam.myFishingInfo
	local var_9_1 = arg_9_0.viewParam and arg_9_0.viewParam.otherFishingInfo

	if var_9_0 then
		local var_9_2, var_9_3, var_9_4 = TimeUtil.secondToHMS(var_9_0.time)
		local var_9_5 = 0

		for iter_9_0, iter_9_1 in pairs(var_9_0.fishingTimesDict) do
			var_9_5 = var_9_5 + iter_9_1
		end

		arg_9_0._txtmyfishing.text = GameUtil.getSubPlaceholderLuaLangThreeParam(luaLang("RoomFishing_reward_tips"), var_9_2, var_9_3, var_9_5)
	end

	if var_9_1 then
		local var_9_6, var_9_7, var_9_8 = TimeUtil.secondToHMS(var_9_1.time)
		local var_9_9 = 0

		for iter_9_2, iter_9_3 in pairs(var_9_1.fishingTimesDict) do
			var_9_9 = var_9_9 + iter_9_3
		end

		arg_9_0._txtotherfishing.text = GameUtil.getSubPlaceholderLuaLangThreeParam(luaLang("RoomFishing_other_reward_tips"), var_9_6, var_9_7, var_9_9)
	end

	arg_9_0:setRewardItems(var_9_0, arg_9_0._gomyfishing, arg_9_0._gomyfishingcontent, arg_9_0._gomyfishingitem)
	arg_9_0:setRewardItems(var_9_1, arg_9_0._gootherfishing, arg_9_0._gootherfishingcontent, arg_9_0._gootherfishingitem, true)
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:onUpdateParam()
	AudioMgr.instance:trigger(AudioEnum3_1.RoomFishing.play_ui_home_mingdi_harvest)
end

function var_0_0.setRewardItems(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	local var_11_0 = {}

	if arg_11_1 then
		var_11_0 = FishingModel.instance:getFishingItemList(arg_11_1.poolIdList, arg_11_1.fishingTimesDict, arg_11_5)
	end

	gohelper.CreateObjList(arg_11_0, arg_11_0.onRewardItemShow, var_11_0, arg_11_3, arg_11_4, RoomFishingResourceItem)
	gohelper.setActive(arg_11_2, var_11_0 and #var_11_0 > 0)
end

function var_0_0.onRewardItemShow(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_1:onUpdateMO(arg_12_2)
	arg_12_1:setCanClick(true)
end

function var_0_0.onClose(arg_13_0)
	return
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

return var_0_0
