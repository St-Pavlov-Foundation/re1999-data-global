module("modules.logic.store.view.recommend.StoreNewbieView", package.seeall)

slot0 = class("StoreNewbieView", StoreRecommendBaseSubView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "recommend/#simage_bg")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btn:AddClickListener(slot0._onClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btn:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getStoreBottomBgIcon("firstchargeview/bg"))

	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._animatorPlayer = SLFramework.AnimatorPlayer.Get(gohelper.findChild(slot0.viewGO, "recommend"))
	slot0._btn = gohelper.getClickWithAudio(slot0.viewGO)
	slot0._txticon = gohelper.findChildText(slot0.viewGO, "recommend/#simage_bg/#txt_num/#txt_icon")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "recommend/#simage_bg/#txt_num")
	slot0._txticon.text = PayModel.instance:getProductOriginPriceSymbol(610002)
	slot0._txtnum.text = PayModel.instance:getProductOriginPriceNum(610002)
	slot0._txtnum = gohelper.getDynamicSizeText(slot0._txtnum.gameObject)
	slot0._txtnum.maxIteration = 3
	slot0._txticon.text = ""
	slot3, slot4 = PayModel.instance:getProductOriginPriceNum(610002)
	slot5 = ""

	if string.nilorempty(PayModel.instance:getProductOriginPriceSymbol(610002)) then
		slot6 = string.reverse(slot4)
		slot7 = string.len(slot6) - string.find(slot6, "%d") + 1
		slot0._txtnum.text = string.format("%s<size=100>%s</size>", string.sub(slot4, 1, slot7), string.sub(slot4, slot7 + 1, string.len(slot4)))
	else
		slot0._txtnum.text = string.format("<size=100>%s</size>%s", slot2, slot4)
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0._onClick(slot0)
	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = "712",
		[StatEnum.EventProperties.RecommendPageName] = "新人邀约"
	})
	GameFacade.jumpByAdditionParam("10170#610002")
	AudioMgr.instance:trigger(2000001)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
end

return slot0
