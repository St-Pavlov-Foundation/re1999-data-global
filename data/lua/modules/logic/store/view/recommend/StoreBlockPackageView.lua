module("modules.logic.store.view.recommend.StoreBlockPackageView", package.seeall)

slot0 = class("StoreBlockPackageView", StoreRecommendBaseSubView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "view/#simage_bg")
	slot0._txtdurationTime = gohelper.findChildText(slot0.viewGO, "view/title/time/#txt_durationTime")
	slot0._btnbuy = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/right/#btn_buy")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnbuy:AddClickListener(slot0._btnbuyOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnbuy:RemoveClickListener()
end

function slot0.ctor(slot0, ...)
	uv0.super.ctor(slot0, ...)

	slot0.config = StoreConfig.instance:getStoreRecommendConfig(StoreEnum.RecommendSubStoreId.StoreBlockPackageView)
end

function slot0._btnbuyOnClick(slot0)
	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = tostring(slot0.config and slot0.config.id or ""),
		[StatEnum.EventProperties.RecommendPageName] = slot0.config and slot0.config.name or "StoreBlockPackageView"
	})
	GameFacade.jumpByAdditionParam(slot0.config.systemJumpCode)
end

function slot0._editableInitView(slot0)
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._animatorPlayer = SLFramework.AnimatorPlayer.Get(slot0.viewGO)

	slot0._simagebg:LoadImage(ResUrl.getStoreBottomBgIcon("blockbg"))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	uv0.super.onOpen(slot0)
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0._txtdurationTime.text = StoreController.instance:getRecommendStoreTime(slot0.config)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
end

return slot0
