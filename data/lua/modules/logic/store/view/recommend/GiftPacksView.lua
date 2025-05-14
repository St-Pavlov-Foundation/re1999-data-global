module("modules.logic.store.view.recommend.GiftPacksView", package.seeall)

local var_0_0 = class("GiftPacksView", StoreRecommendBaseSubView)

function var_0_0.onInitView(arg_1_0)
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
	arg_4_0._animator = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_4_0.viewGO)
	arg_4_0._btn = gohelper.findChildClickWithAudio(arg_4_0.viewGO, "view/#simage_bg")
	arg_4_0._simagebg = gohelper.findChildSingleImage(arg_4_0.viewGO, "view/#simage_bg")

	arg_4_0._simagebg:LoadImage(ResUrl.getStoreGiftPackBg("bg"))

	arg_4_0._txtpack2 = gohelper.findChildText(arg_4_0.viewGO, "view/#simage_bg/pack2/#txt_pack2")

	local var_4_0 = "%s<color=#1a1a1a>%s</color>"

	if GameLanguageMgr.instance:getLanguageTypeStoryIndex() ~= LanguageEnum.LanguageStoryType.CN then
		var_4_0 = "%s<color=#1a1a1a> %s</color>"
	end

	arg_4_0._txtpack2.text = string.format(var_4_0, luaLang("p_giftpackview_pack2_orange"), luaLang("p_giftpackview_pack2_black"))
	arg_4_0._txtpack3 = gohelper.findChildText(arg_4_0.viewGO, "view/#simage_bg/pack3/#txt_pack3")
	arg_4_0._txtpack3.text = string.format(var_4_0, luaLang("p_giftpackview_pack3_orange"), luaLang("p_giftpackview_pack3_black"))
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0._onClick(arg_6_0)
	GameFacade.jumpByAdditionParam("10170")
	AudioMgr.instance:trigger(2000001)
	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = "713",
		[StatEnum.EventProperties.RecommendPageName] = "精选组合推荐"
	})
end

function var_0_0.onDestroyView(arg_7_0)
	arg_7_0._simagebg:UnLoadImage()
end

return var_0_0
