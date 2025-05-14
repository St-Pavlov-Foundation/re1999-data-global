module("modules.logic.store.view.recommend.StoreNewbieView", package.seeall)

local var_0_0 = class("StoreNewbieView", StoreRecommendBaseSubView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "recommend/#simage_bg")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btn:AddClickListener(arg_2_0._onClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btn:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._simagebg:LoadImage(ResUrl.getStoreBottomBgIcon("firstchargeview/bg"))

	arg_4_0._animator = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	local var_4_0 = gohelper.findChild(arg_4_0.viewGO, "recommend")

	arg_4_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(var_4_0)
	arg_4_0._btn = gohelper.getClickWithAudio(arg_4_0.viewGO)
	arg_4_0._txticon = gohelper.findChildText(arg_4_0.viewGO, "recommend/#simage_bg/#txt_num/#txt_icon")
	arg_4_0._txtnum = gohelper.findChildText(arg_4_0.viewGO, "recommend/#simage_bg/#txt_num")
	arg_4_0._txticon.text = PayModel.instance:getProductOriginPriceSymbol(610002)
	arg_4_0._txtnum.text = PayModel.instance:getProductOriginPriceNum(610002)
	arg_4_0._txtnum = gohelper.getDynamicSizeText(arg_4_0._txtnum.gameObject)
	arg_4_0._txtnum.maxIteration = 3
	arg_4_0._txticon.text = ""

	local var_4_1 = PayModel.instance:getProductOriginPriceSymbol(610002)
	local var_4_2, var_4_3 = PayModel.instance:getProductOriginPriceNum(610002)
	local var_4_4 = ""

	if string.nilorempty(var_4_1) then
		local var_4_5 = string.reverse(var_4_3)
		local var_4_6 = string.find(var_4_5, "%d")
		local var_4_7 = string.len(var_4_5) - var_4_6 + 1
		local var_4_8 = string.sub(var_4_3, var_4_7 + 1, string.len(var_4_3))

		var_4_3 = string.sub(var_4_3, 1, var_4_7)
		arg_4_0._txtnum.text = string.format("%s<size=100>%s</size>", var_4_3, var_4_8)
	else
		arg_4_0._txtnum.text = string.format("<size=100>%s</size>%s", var_4_1, var_4_3)
	end
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0._onClick(arg_6_0)
	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = "712",
		[StatEnum.EventProperties.RecommendPageName] = "新人邀约"
	})
	GameFacade.jumpByAdditionParam("10170#610002")
	AudioMgr.instance:trigger(2000001)
end

function var_0_0.onDestroyView(arg_7_0)
	arg_7_0._simagebg:UnLoadImage()
end

return var_0_0
