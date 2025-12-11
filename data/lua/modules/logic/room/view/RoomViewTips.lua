module("modules.logic.room.view.RoomViewTips", package.seeall)

local var_0_0 = class("RoomViewTips", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnfishingResources = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_normalroot/btn_fishingResource")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "go_normalroot/#go_tips")
	arg_1_0._btntipsmask = gohelper.findChildClickWithAudio(arg_1_0.viewGO, "go_normalroot/#go_tips/#btn_tipsMask")
	arg_1_0._goresrourcestips = gohelper.findChild(arg_1_0.viewGO, "go_normalroot/#go_tips/#go_resourcesTip")
	arg_1_0._goresourcesitem = gohelper.findChild(arg_1_0.viewGO, "go_normalroot/#go_tips/#go_resourcesTip/#go_Item")
	arg_1_0._gofishingtips = gohelper.findChild(arg_1_0.viewGO, "go_normalroot/#go_tips/#go_fishingTip")
	arg_1_0._gofishingContent = gohelper.findChild(arg_1_0.viewGO, "go_normalroot/#go_tips/#go_fishingTip/List")
	arg_1_0._gofishingItem = gohelper.findChild(arg_1_0.viewGO, "go_normalroot/#go_tips/#go_fishingTip/List/#go_Item")
	arg_1_0.resTipAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_1_0._goresrourcestips)
	arg_1_0.fishingTipAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_1_0._gofishingtips)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnfishingResources:AddClickListener(arg_2_0._btnFishingResourcesOnClick, arg_2_0)
	arg_2_0._btntipsmask:AddClickListener(arg_2_0._btnTipsMaskOnClick, arg_2_0)
	arg_2_0:addEventCb(FishingController.instance, FishingEvent.OnFishingInfoUpdate, arg_2_0._onFishingInfoUpdate, arg_2_0)
	arg_2_0:addEventCb(FishingController.instance, FishingEvent.ShowFishingTip, arg_2_0._onShowFishingTip, arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0._onCurrencyChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnfishingResources:RemoveClickListener()
	arg_3_0._btntipsmask:RemoveClickListener()
	arg_3_0:removeEventCb(FishingController.instance, FishingEvent.OnFishingInfoUpdate, arg_3_0._onFishingInfoUpdate, arg_3_0)
	arg_3_0:removeEventCb(FishingController.instance, FishingEvent.ShowFishingTip, arg_3_0._onShowFishingTip, arg_3_0)
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0._onCurrencyChange, arg_3_0)
end

function var_0_0._btnFishingResourcesOnClick(arg_4_0)
	local var_4_0 = FishingModel.instance:getBackpackItemList()

	if #var_4_0 <= 0 then
		GameFacade.showToast(ToastEnum.NoRoomFishingResources)

		return
	end

	arg_4_0._showFishingResourcesTip = not arg_4_0._showFishingResourcesTip

	if arg_4_0._showFishingResourcesTip then
		gohelper.CreateObjList(arg_4_0, arg_4_0._onFishingResourceItemShow, var_4_0, arg_4_0._goresrourcestips, arg_4_0._goresourcesitem, RoomFishingResourceItem)
		arg_4_0:_checkResourcesTipShow()
		arg_4_0.resTipAnimatorPlayer:Play(UIAnimationName.Open)
	else
		arg_4_0.resTipAnimatorPlayer:Play(UIAnimationName.Close, arg_4_0._checkResourcesTipShow, arg_4_0)
	end

	arg_4_0:refreshTipMask()
end

function var_0_0._onFishingResourceItemShow(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_1:onUpdateMO(arg_5_2)
	arg_5_1:setCanClick(true)
end

function var_0_0._checkResourcesTipShow(arg_6_0)
	gohelper.setActive(arg_6_0._goresrourcestips, arg_6_0._showFishingResourcesTip)
end

function var_0_0._btnFishOnClick(arg_7_0, arg_7_1)
	FishingController.instance:beginFishing(arg_7_1)
end

function var_0_0._btnTipsMaskOnClick(arg_8_0)
	if arg_8_0._showFishingResourcesTip then
		arg_8_0:_btnFishingResourcesOnClick()
	end

	if arg_8_0._showFishingTip then
		arg_8_0:_onShowFishingTip()
	end

	arg_8_0:refreshTipMask()
end

function var_0_0._onFishingInfoUpdate(arg_9_0)
	if not arg_9_0._showFishingTip then
		return
	end

	arg_9_0:clearFishingItem()

	local var_9_0 = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.FishOption, true, "#")

	gohelper.CreateObjList(arg_9_0, arg_9_0._onFishingItemShow, var_9_0, arg_9_0._gofishingContent, arg_9_0._gofishingItem)
end

function var_0_0._onShowFishingTip(arg_10_0, arg_10_1)
	arg_10_0._showFishingTip = arg_10_1 and true or false

	if arg_10_0._showFishingTip then
		local var_10_0 = arg_10_0._transtip:InverseTransformPoint(arg_10_1)

		transformhelper.setLocalPosXY(arg_10_0._transfishingtips, var_10_0.x, var_10_0.y)
		arg_10_0:clearFishingItem()

		local var_10_1 = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.FishOption, true, "#")

		gohelper.CreateObjList(arg_10_0, arg_10_0._onFishingItemShow, var_10_1, arg_10_0._gofishingContent, arg_10_0._gofishingItem)
		arg_10_0:_checkFishingTipsShow()
		arg_10_0.fishingTipAnimatorPlayer:Play(UIAnimationName.Open)
		AudioMgr.instance:trigger(AudioEnum3_1.RoomFishing.ui_home_mingdi_tan)
	else
		arg_10_0.fishingTipAnimatorPlayer:Play(UIAnimationName.Close, arg_10_0._checkFishingTipsShow, arg_10_0)
		AudioMgr.instance:trigger(AudioEnum3_1.RoomFishing.play_ui_home_mingdi_shou)
	end

	arg_10_0:refreshFishingItem()
	arg_10_0:refreshTipMask()
end

function var_0_0._onFishingItemShow(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_0:getUserDataTb_()

	var_11_0.go = arg_11_1
	var_11_0.fishingTimes = arg_11_2
	var_11_0.txtTime = gohelper.findChildText(var_11_0.go, "#txt_Time")
	var_11_0.simageProp = gohelper.findChildSingleImage(var_11_0.go, "Prop/#simage_Prop")
	var_11_0.txtNum = gohelper.findChildText(var_11_0.go, "Prop/#txt_Num")
	var_11_0.txtFishing = gohelper.findChildText(var_11_0.go, "#btn_Fishing/txt_Fishing")
	var_11_0.txtCost = gohelper.findChildText(var_11_0.go, "#btn_Fishing/#txt_Num")
	var_11_0.btn = gohelper.findChildButtonWithAudio(var_11_0.go, "#btn_Fishing")
	var_11_0.goBtn = var_11_0.btn.gameObject

	local var_11_1 = ""
	local var_11_2 = FishingModel.instance:getCurFishingPoolId()
	local var_11_3 = FishingConfig.instance:getFishingTime(var_11_2)

	if var_11_3 then
		var_11_1 = string.format("%s%s", TimeUtil.secondToRoughTime(var_11_3 * var_11_0.fishingTimes, true))
	end

	var_11_0.txtTime.text = var_11_1

	local var_11_4 = FishingModel.instance:getCurFishingPoolItem()
	local var_11_5, var_11_6 = ItemModel.instance:getItemConfigAndIcon(var_11_4[1], var_11_4[2])

	var_11_0.simageProp:LoadImage(var_11_6)

	var_11_0.txtNum.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("multi_num"), var_11_4[3] * var_11_0.fishingTimes)
	var_11_0.txtFishing.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("RoomFishing_times"), var_11_0.fishingTimes)

	local var_11_7 = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.OneFishCost, true, "#")
	local var_11_8 = var_11_0.fishingTimes * var_11_7[2]

	var_11_0.txtCost.text = string.format("-%d", var_11_8)

	var_11_0.btn:AddClickListener(arg_11_0._btnFishOnClick, arg_11_0, var_11_0.fishingTimes)

	arg_11_0._fishingItemList[arg_11_3] = var_11_0
end

function var_0_0._checkFishingTipsShow(arg_12_0)
	gohelper.setActive(arg_12_0._gofishingtips, arg_12_0._showFishingTip)
end

function var_0_0._onCurrencyChange(arg_13_0)
	arg_13_0:refreshFishingItem()
end

function var_0_0._editableInitView(arg_14_0)
	arg_14_0._transfishingtips = arg_14_0._gofishingtips.transform
	arg_14_0._transtip = arg_14_0._gotips.transform
	arg_14_0._showFishingResourcesTip = false
	arg_14_0._showFishingTip = false
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0:_checkResourcesTipShow()
	arg_15_0:_checkFishingTipsShow()
	arg_15_0:refreshTipMask()
end

function var_0_0.refreshTipMask(arg_16_0)
	gohelper.setActive(arg_16_0._btntipsmask, arg_16_0._showFishingTip or arg_16_0._showFishingResourcesTip)
end

function var_0_0.refreshFishingItem(arg_17_0)
	if not arg_17_0._showFishingTip then
		return
	end

	if arg_17_0._fishingItemList then
		for iter_17_0, iter_17_1 in ipairs(arg_17_0._fishingItemList) do
			local var_17_0 = FishingModel.instance:isEnoughToFish(iter_17_1.fishingTimes)
			local var_17_1 = var_17_0 and "#101010" or "#972D1B"

			SLFramework.UGUI.GuiHelper.SetColor(iter_17_1.txtFishing, var_17_1)
			SLFramework.UGUI.GuiHelper.SetColor(iter_17_1.txtCost, var_17_1)
			ZProj.UGUIHelper.SetGrayscale(iter_17_1.goBtn, not var_17_0)
		end
	end
end

function var_0_0.clearFishingItem(arg_18_0)
	if arg_18_0._fishingItemList then
		for iter_18_0, iter_18_1 in ipairs(arg_18_0._fishingItemList) do
			iter_18_1.simageProp:UnLoadImage()
			iter_18_1.btn:RemoveClickListener()
		end
	end

	arg_18_0._fishingItemList = {}
end

function var_0_0.onClose(arg_19_0)
	arg_19_0:clearFishingItem()
end

function var_0_0.onDestroyView(arg_20_0)
	return
end

return var_0_0
