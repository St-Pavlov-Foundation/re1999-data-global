module("modules.logic.commonbufftip.CommonBuffTipView", package.seeall)

slot0 = class("CommonBuffTipView", BaseView)

function slot0.onInitView(slot0)
	slot0.goclose = gohelper.findChild(slot0.viewGO, "#go_close")
	slot0.goscrolltip = gohelper.findChild(slot0.viewGO, "#scroll_tip")
	slot0.gocontent = gohelper.findChild(slot0.viewGO, "#scroll_tip/Viewport/Content")
	slot0.gotipitem = gohelper.findChild(slot0.viewGO, "#scroll_tip/Viewport/Content/#go_tipitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0.effectTipItemList = {}
	slot0.effectTipItemPool = {}
	slot0.addEffectIdDict = {}
	slot0.rectTrScrollTip = slot0.goscrolltip:GetComponent(gohelper.Type_RectTransform)
	slot0.rectTrViewGo = slot0.viewGO:GetComponent(gohelper.Type_RectTransform)
	slot0.rectTrContent = slot0.gocontent:GetComponent(gohelper.Type_RectTransform)

	gohelper.setActive(slot0.gotipitem, false)

	slot0.closeClick = gohelper.getClickWithDefaultAudio(slot0.goclose)

	slot0.closeClick:AddClickListener(slot0.closeThis, slot0)

	slot0.scrollTip = SLFramework.UGUI.ScrollRectWrap.Get(slot0.goscrolltip)
end

function slot0.setIsShowUI(slot0, slot1)
	if not slot1 then
		slot0:closeThis()
	end
end

function slot0.initViewParam(slot0)
	slot0.effectId = slot0.viewParam.effectId
	slot0.scrollAnchorPos = slot0.viewParam.scrollAnchorPos
	slot0.pivot = slot0.viewParam.pivot
	slot0.clickPosition = slot0.viewParam.clickPosition
	slot0.setScrollPosCallback = slot0.viewParam.setScrollPosCallback
	slot0.setScrollPosCallbackObj = slot0.viewParam.setScrollPosCallbackObj
end

function slot0.onOpen(slot0)
	slot0:initViewParam()
	slot0:setScrollPos()
	slot0:calculateMaxHeight()
	slot0:addBuffTip(slot0.effectId)
	slot0:addEventCb(FightController.instance, FightEvent.SetIsShowUI, slot0.setIsShowUI, slot0)
end

function slot0.setScrollPos(slot0)
	if slot0.setScrollPosCallback then
		slot0.setScrollPosCallback(slot0.setScrollPosCallbackObj, slot0.rectTrViewGo, slot0.rectTrScrollTip)

		return
	end

	if slot0.scrollAnchorPos then
		slot0.rectTrScrollTip.pivot = slot0.pivot

		recthelper.setAnchor(slot0.rectTrScrollTip, slot0.scrollAnchorPos.x, slot0.scrollAnchorPos.y)

		return
	end

	slot0.rectTrScrollTip.pivot = GameUtil.checkClickPositionInRight(slot0.clickPosition) and CommonBuffTipEnum.Pivot.Right or CommonBuffTipEnum.Pivot.Left
	slot2, slot3 = recthelper.screenPosToAnchorPos2(slot0.clickPosition, slot0.rectTrViewGo)

	recthelper.setAnchor(slot0.rectTrScrollTip, slot1 and slot2 - CommonBuffTipEnum.DefaultInterval or slot2 + CommonBuffTipEnum.DefaultInterval, slot3 + CommonBuffTipEnum.DefaultInterval)
end

function slot0.calculateMaxHeight(slot0)
	slot0.maxHeight = recthelper.getHeight(slot0.rectTrViewGo) / 2 + recthelper.getAnchorY(slot0.rectTrScrollTip) - CommonBuffTipEnum.BottomMargin
end

function slot0.addBuffTip(slot0, slot1)
	if slot0.addEffectIdDict[tonumber(slot1)] then
		return
	end

	if not lua_skill_eff_desc.configDict[slot2] then
		logError("not found skill_eff_desc , id : " .. tostring(slot1))

		return
	end

	slot0.addEffectIdDict[slot2] = true
	slot4 = slot0:getTipItem()

	table.insert(slot0.effectTipItemList, slot4)
	gohelper.setActive(slot4.go, true)
	gohelper.setAsLastSibling(slot4.go)

	slot5 = slot3.name
	slot4.txtName.text = SkillHelper.removeRichTag(slot5)
	slot4.txtDesc.text = SkillHelper.getSkillDesc(nil, slot3)
	slot8 = not string.nilorempty(CommonBuffTipController.instance:getBuffTagName(slot5))

	gohelper.setActive(slot4.goTag, slot8)

	if slot8 then
		slot4.txtTag.text = slot7
	end

	slot0:refreshScrollHeight()
end

function slot0.refreshScrollHeight(slot0)
	ZProj.UGUIHelper.RebuildLayout(slot0.rectTrContent)
	recthelper.setHeight(slot0.rectTrScrollTip, math.min(slot0.maxHeight, recthelper.getHeight(slot0.rectTrContent)))

	slot0.scrollTip.verticalNormalizedPosition = 0
end

function slot0.getTipItem(slot0)
	if #slot0.effectTipItemPool > 0 then
		return table.remove(slot0.effectTipItemPool)
	end

	slot1 = slot0:getUserDataTb_()
	slot1.go = gohelper.cloneInPlace(slot0.gotipitem)
	slot1.txtName = gohelper.findChildText(slot1.go, "title/txt_name")
	slot1.txtDesc = gohelper.findChildText(slot1.go, "txt_desc")
	slot1.goTag = gohelper.findChild(slot1.go, "title/txt_name/go_tag")
	slot1.txtTag = gohelper.findChildText(slot1.go, "title/txt_name/go_tag/bg/txt_tagname")

	SkillHelper.addHyperLinkClick(slot1.txtDesc, slot0.onClickHyperLinkText, slot0)

	return slot1
end

function slot0.onClickHyperLinkText(slot0, slot1, slot2)
	slot0:addBuffTip(slot1)
end

function slot0.recycleTipItem(slot0, slot1)
	gohelper.setActive(slot1.go, false)
	table.insert(slot0.effectTipItemPool, slot1)
end

function slot0.recycleAllTipItem(slot0)
	for slot4, slot5 in ipairs(slot0.effectTipItemList) do
		gohelper.setActive(slot5.go, false)
		table.insert(slot0.effectTipItemPool, slot5)
	end

	tabletool.clear(slot0.effectTipItemList)
end

function slot0.onClose(slot0)
	tabletool.clear(slot0.addEffectIdDict)
	slot0:recycleAllTipItem()
	slot0:removeEventCb(FightController.instance, FightEvent.SetIsShowUI, slot0.setIsShowUI, slot0)
end

function slot0.onDestroyView(slot0)
	slot0.closeClick:RemoveClickListener()

	slot0.closeClick = nil
end

return slot0
