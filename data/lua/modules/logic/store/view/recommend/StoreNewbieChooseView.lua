module("modules.logic.store.view.recommend.StoreNewbieChooseView", package.seeall)

local var_0_0 = class("StoreNewbieChooseView", StoreRecommendBaseSubView)

local function var_0_1(arg_1_0)
	local var_1_0 = PayModel.instance:getProductOriginPriceSymbol(arg_1_0)
	local var_1_1, var_1_2 = PayModel.instance:getProductOriginPriceNum(arg_1_0)
	local var_1_3 = ""

	if string.nilorempty(var_1_0) then
		local var_1_4 = string.reverse(var_1_2)
		local var_1_5 = string.find(var_1_4, "%d")
		local var_1_6 = string.len(var_1_4) - var_1_5 + 1
		local var_1_7 = string.sub(var_1_2, var_1_6 + 1, string.len(var_1_2))

		var_1_2 = string.sub(var_1_2, 1, var_1_6)

		return string.format("%s<size=60>%s</size>", var_1_2, var_1_7)
	else
		return string.format("<size=60>%s</size>%s", var_1_0, var_1_2)
	end
end

local var_0_2 = 3
local var_0_3 = 3
local var_0_4 = {
	3082,
	3020,
	3076
}
local var_0_5 = {
	[3020] = 105,
	[3076] = 103,
	[3082] = 104
}
local var_0_6 = 10170

function var_0_0.onInitView(arg_2_0)
	arg_2_0._goNewbieChar1 = gohelper.findChild(arg_2_0.viewGO, "recommend/anibg/#simage_char1")
	arg_2_0._goNewbieChar2 = gohelper.findChild(arg_2_0.viewGO, "recommend/anibg/#simage_char2")
	arg_2_0._goNewbieChar3 = gohelper.findChild(arg_2_0.viewGO, "recommend/anibg/#simage_char3")
	arg_2_0._charAnim = gohelper.findChild(arg_2_0.viewGO, "recommend/anibg"):GetComponent(typeof(UnityEngine.Animation))

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0._btn:AddClickListener(arg_3_0._onClick, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0._btn:RemoveClickListener()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._txtNum = gohelper.findChildText(arg_5_0.viewGO, "recommend/Buy/txt_Num")
	arg_5_0._txtNum.text = var_0_1(StoreEnum.NewbiePackId)
	arg_5_0._animator = arg_5_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	local var_5_0 = gohelper.findChild(arg_5_0.viewGO, "recommend")

	arg_5_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(var_5_0)
	arg_5_0._btn = gohelper.getClickWithAudio(arg_5_0.viewGO)
	arg_5_0._newbieCharGoList = arg_5_0:getUserDataTb_()
	arg_5_0._newbieCharGoList[1] = arg_5_0._goNewbieChar3
	arg_5_0._newbieCharGoList[2] = arg_5_0._goNewbieChar2
	arg_5_0._newbieCharGoList[3] = arg_5_0._goNewbieChar1
end

function var_0_0.onOpen(arg_6_0)
	StoreRecommendBaseSubView.onOpen(arg_6_0)

	arg_6_0.config = StoreConfig.instance:getStoreRecommendConfig(StoreEnum.RecommendSubStoreId.ChargeView)

	StoreController.instance:dispatchEvent(StoreEvent.SetAutoToNextPage, false)

	arg_6_0._curCharIdx = 0

	arg_6_0:_toNextChar()
	arg_6_0._charAnim:Play()
end

function var_0_0.onClose(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._toNextChar, arg_7_0)
	StoreRecommendBaseSubView.onClose(arg_7_0)
	arg_7_0._charAnim:Stop()
	StoreController.instance:dispatchEvent(StoreEvent.SetAutoToNextPage, true)
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0._toNextChar(arg_9_0)
	if arg_9_0._curCharIdx >= var_0_2 then
		arg_9_0._curCharIdx = 0
	end

	arg_9_0._curCharIdx = arg_9_0._curCharIdx + 1

	if arg_9_0._curCharIdx == var_0_2 then
		StoreController.instance:dispatchEvent(StoreEvent.SetAutoToNextPage, true)
	end

	local var_9_0 = arg_9_0._newbieCharGoList[arg_9_0._curCharIdx]
	local var_9_1 = var_0_4[arg_9_0._curCharIdx]
	local var_9_2 = gohelper.findChildText(var_9_0, "name/image_NameBG/#txt_Name")
	local var_9_3 = gohelper.findChildImage(var_9_0, "name/#image_Attr")
	local var_9_4 = HeroConfig.instance:getHeroCO(var_9_1)

	var_9_2.text = var_9_4.name

	UISpriteSetMgr.instance:setCommonSprite(var_9_3, "lssx_" .. var_9_4.career)
	TaskDispatcher.runDelay(arg_9_0._toNextChar, arg_9_0, var_0_3)
end

function var_0_0._onClick(arg_10_0)
	local var_10_0 = string.splitToNumber(arg_10_0.config.systemJumpCode, "#")

	if var_10_0[2] then
		local var_10_1 = var_10_0[2]
		local var_10_2 = StoreModel.instance:getGoodsMO(var_10_1)

		StoreController.instance:openPackageStoreGoodsView(var_10_2)
	else
		GameFacade.jumpByAdditionParam(var_0_6 .. "#" .. StoreEnum.NewbiePackId)
	end

	AudioMgr.instance:trigger(2000001)
	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = "712",
		[StatEnum.EventProperties.RecommendPageName] = "新人邀约",
		[StatEnum.EventProperties.RecommendPageRank] = arg_10_0:getTabIndex()
	})
end

function var_0_0.onDestroyView(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._toNextChar, arg_11_0)
end

return var_0_0
