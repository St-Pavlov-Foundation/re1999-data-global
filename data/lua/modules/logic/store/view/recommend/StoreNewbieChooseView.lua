module("modules.logic.store.view.recommend.StoreNewbieChooseView", package.seeall)

slot0 = class("StoreNewbieChooseView", StoreRecommendBaseSubView)

function slot1(slot0)
	slot2, slot3 = PayModel.instance:getProductOriginPriceNum(slot0)
	slot4 = ""

	if string.nilorempty(PayModel.instance:getProductOriginPriceSymbol(slot0)) then
		slot5 = string.reverse(slot3)
		slot6 = string.len(slot5) - string.find(slot5, "%d") + 1

		return string.format("%s<size=60>%s</size>", string.sub(slot3, 1, slot6), string.sub(slot3, slot6 + 1, string.len(slot3)))
	else
		return string.format("<size=60>%s</size>%s", slot1, slot3)
	end
end

slot2 = 3
slot3 = 3
slot4 = {
	3082,
	3020,
	3076
}
slot5 = {
	[3020.0] = 105,
	[3076.0] = 103,
	[3082.0] = 104
}
slot6 = 10170

function slot0.onInitView(slot0)
	slot0._goNewbieChar1 = gohelper.findChild(slot0.viewGO, "recommend/anibg/#simage_char1")
	slot0._goNewbieChar2 = gohelper.findChild(slot0.viewGO, "recommend/anibg/#simage_char2")
	slot0._goNewbieChar3 = gohelper.findChild(slot0.viewGO, "recommend/anibg/#simage_char3")
	slot0._charAnim = gohelper.findChild(slot0.viewGO, "recommend/anibg"):GetComponent(typeof(UnityEngine.Animation))

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
	slot0._txtNum = gohelper.findChildText(slot0.viewGO, "recommend/Buy/txt_Num")
	slot0._txtNum.text = uv0(StoreEnum.NewbiePackId)
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._animatorPlayer = SLFramework.AnimatorPlayer.Get(gohelper.findChild(slot0.viewGO, "recommend"))
	slot0._btn = gohelper.getClickWithAudio(slot0.viewGO)
	slot0._newbieCharGoList = slot0:getUserDataTb_()
	slot0._newbieCharGoList[1] = slot0._goNewbieChar3
	slot0._newbieCharGoList[2] = slot0._goNewbieChar2
	slot0._newbieCharGoList[3] = slot0._goNewbieChar1
end

function slot0.onOpen(slot0)
	StoreRecommendBaseSubView.onOpen(slot0)
	StoreController.instance:dispatchEvent(StoreEvent.SetAutoToNextPage, false)

	slot0._curCharIdx = 0

	slot0:_toNextChar()
	slot0._charAnim:Play()
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._toNextChar, slot0)
	StoreRecommendBaseSubView.onClose(slot0)
	slot0._charAnim:Stop()
	StoreController.instance:dispatchEvent(StoreEvent.SetAutoToNextPage, true)
end

function slot0.onUpdateParam(slot0)
end

function slot0._toNextChar(slot0)
	if uv0 <= slot0._curCharIdx then
		slot0._curCharIdx = 0
	end

	slot0._curCharIdx = slot0._curCharIdx + 1

	if slot0._curCharIdx == uv0 then
		StoreController.instance:dispatchEvent(StoreEvent.SetAutoToNextPage, true)
	end

	slot1 = slot0._newbieCharGoList[slot0._curCharIdx]
	slot5 = HeroConfig.instance:getHeroCO(uv1[slot0._curCharIdx])
	gohelper.findChildText(slot1, "name/image_NameBG/#txt_Name").text = slot5.name

	UISpriteSetMgr.instance:setCommonSprite(gohelper.findChildImage(slot1, "name/#image_Attr"), "lssx_" .. slot5.career)
	TaskDispatcher.runDelay(slot0._toNextChar, slot0, uv2)
end

function slot0._onClick(slot0)
	GameFacade.jumpByAdditionParam(uv0 .. "#" .. StoreEnum.NewbiePackId)
	AudioMgr.instance:trigger(2000001)
	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = "712",
		[StatEnum.EventProperties.RecommendPageName] = "新人邀约"
	})
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._toNextChar, slot0)
end

return slot0
