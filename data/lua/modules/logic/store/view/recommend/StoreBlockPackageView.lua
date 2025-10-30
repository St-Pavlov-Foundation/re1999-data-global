module("modules.logic.store.view.recommend.StoreBlockPackageView", package.seeall)

local var_0_0 = class("StoreBlockPackageView", StoreRecommendBaseSubView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/#simage_bg")
	arg_1_0._txtdurationTime = gohelper.findChildText(arg_1_0.viewGO, "view/title/time/#txt_durationTime")
	arg_1_0._btnbuy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/right/#btn_buy")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnbuy:AddClickListener(arg_2_0._btnbuyOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnbuy:RemoveClickListener()
end

function var_0_0.ctor(arg_4_0, ...)
	var_0_0.super.ctor(arg_4_0, ...)

	arg_4_0.config = StoreConfig.instance:getStoreRecommendConfig(StoreEnum.RecommendSubStoreId.StoreBlockPackageView)
end

function var_0_0._btnbuyOnClick(arg_5_0)
	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = tostring(arg_5_0.config and arg_5_0.config.id or ""),
		[StatEnum.EventProperties.RecommendPageName] = arg_5_0.config and arg_5_0.config.name or "StoreBlockPackageView",
		[StatEnum.EventProperties.RecommendPageRank] = arg_5_0:getTabIndex()
	})
	GameFacade.jumpByAdditionParam(arg_5_0.config.systemJumpCode)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._animator = arg_6_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_6_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_6_0.viewGO)

	arg_6_0._simagebg:LoadImage(ResUrl.getStoreBottomBgIcon("blockbg"))
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	var_0_0.super.onOpen(arg_8_0)
	arg_8_0:refreshUI()
end

function var_0_0.refreshUI(arg_9_0)
	arg_9_0._txtdurationTime.text = StoreController.instance:getRecommendStoreTime(arg_9_0.config)
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0._simagebg:UnLoadImage()
end

return var_0_0
