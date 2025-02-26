module("modules.logic.summon.view.SummonResultView", package.seeall)

slot0 = class("SummonResultView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnok = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_ok")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnok:AddClickListener(slot0._btnokOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnok:RemoveClickListener()
end

function slot0._btnokOnClick(slot0)
	if slot0._cantClose then
		return
	end

	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goheroitem, false)

	slot0._heroItemTables = {}

	for slot4 = 1, 10 do
		slot5 = slot0:getUserDataTb_()
		slot5.go = gohelper.findChild(slot0.viewGO, "herocontent/#go_heroitem" .. slot4)
		slot5.txtname = gohelper.findChildText(slot5.go, "name")
		slot5.txtnameen = gohelper.findChildText(slot5.go, "nameen")
		slot5.imagerare = gohelper.findChildImage(slot5.go, "rare")
		slot5.equiprare = gohelper.findChildImage(slot5.go, "equiprare")
		slot5.imagecareer = gohelper.findChildImage(slot5.go, "career")
		slot5.imageequipcareer = gohelper.findChildImage(slot5.go, "equipcareer")
		slot5.goHeroIcon = gohelper.findChild(slot5.go, "heroicon")
		slot5.simageicon = gohelper.findChildSingleImage(slot5.go, "heroicon/icon")
		slot5.simageequipicon = gohelper.findChildSingleImage(slot5.go, "equipicon")
		slot5.imageicon = gohelper.findChildImage(slot5.go, "heroicon/icon")
		slot5.goeffect = gohelper.findChild(slot5.go, "effect")
		slot5.btnself = gohelper.findChildButtonWithAudio(slot5.go, "btn_self")
		slot5.goluckybag = gohelper.findChild(slot5.go, "luckybag")
		slot5.txtluckybagname = gohelper.findChildText(slot5.goluckybag, "name")
		slot5.txtluckybagnameen = gohelper.findChildText(slot5.goluckybag, "nameen")
		slot5.simageluckgbagicon = gohelper.findChildSingleImage(slot5.goluckybag, "icon")

		slot5.btnself:AddClickListener(slot0.onClickItem, {
			view = slot0,
			index = slot4
		})
		table.insert(slot0._heroItemTables, slot5)
	end

	slot0._animation = slot0.viewGO:GetComponent(typeof(UnityEngine.Animation))

	slot0._animation:PlayQueued("summonresult_loop", UnityEngine.QueueMode.CompleteOthers)

	slot0._cantClose = true
	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1.5, nil, slot0._tweenFinish, slot0, nil, EaseType.Linear)
end

function slot0.onDestroyView(slot0)
	for slot4 = 1, 10 do
		if slot0._heroItemTables[slot4] then
			if slot5.simageicon then
				slot5.simageicon:UnLoadImage()
			end

			if slot5.simageequipicon then
				slot5.simageequipicon:UnLoadImage()
			end

			if slot5.btnself then
				slot5.btnself:RemoveClickListener()
			end

			if slot5.simageluckgbagicon then
				slot5.simageluckgbagicon:UnLoadImage()
			end
		end
	end

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)
	end
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_LuckDraw_TenHero_OpenAll)

	slot0._curPool = slot0.viewParam.curPool
	slot0._summonResultList = {}

	for slot5, slot6 in ipairs(slot0.viewParam.summonResultList) do
		table.insert(slot0._summonResultList, slot6)
	end

	if slot0._curPool then
		SummonModel.sortResult(slot0._summonResultList, slot0._curPool.id)
	end

	slot0:_refreshUI()
	NavigateMgr.instance:addEscape(ViewName.SummonResultView, slot0._btnokOnClick, slot0)
end

function slot0.onClose(slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonReply, slot0.onSummonReply, slot0)

	if not slot0:_showCommonPropView() then
		SummonController.instance:dispatchEvent(SummonEvent.onSummonResultClose)
	end
end

function slot0.onCloseFinish(slot0)
end

function slot0.onClickItem(slot0)
	if slot0.view._summonResultList[slot0.index].heroId and slot3.heroId ~= 0 then
		ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
			heroId = slot3.heroId
		})
	elseif slot3.equipId and slot3.equipId ~= 0 then
		EquipController.instance:openEquipView({
			equipId = slot3.equipId
		})
	elseif slot3:isLuckyBag() then
		GameFacade.showToast(ToastEnum.SummonLuckyBagGoMainViewOpen)
	end
end

function slot0._tweenFinish(slot0)
	slot0._cantClose = false
end

function slot0.onSummonReply(slot0)
	slot0:closeThis()
end

function slot0._refreshUI(slot0)
	for slot4 = 1, #slot0._summonResultList do
		if slot0._summonResultList[slot4].heroId and slot5.heroId ~= 0 then
			slot0:_refreshHeroItem(slot0._heroItemTables[slot4], slot5)
		elseif slot5.equipId and slot5.equipId ~= 0 then
			slot0:_refreshEquipItem(slot0._heroItemTables[slot4], slot5)
		elseif slot5:isLuckyBag() then
			slot0:_refreshLuckyBagItem(slot0._heroItemTables[slot4], slot5)
		else
			gohelper.setActive(slot0._heroItemTables[slot4].go, false)
		end
	end

	for slot4 = #slot0._summonResultList + 1, #slot0._heroItemTables do
		gohelper.setActive(slot0._heroItemTables[slot4].go, false)
	end
end

function slot1(slot0)
	if not gohelper.isNil(slot0.imageicon) then
		slot0.imageicon:SetNativeSize()
	end
end

function slot0._refreshEquipItem(slot0, slot1, slot2)
	gohelper.setActive(slot1.goHeroIcon, false)
	gohelper.setActive(slot1.simageequipicon.gameObject, true)
	gohelper.setActive(slot1.goluckybag, false)
	gohelper.setActive(slot1.txtname, true)
	gohelper.setActive(slot1.txtnameen, GameConfig:GetCurLangType() == LangSettings.zh)

	slot5 = EquipConfig.instance:getEquipCo(slot2.equipId)
	slot1.txtname.text = slot5.name
	slot1.txtnameen.text = slot5.name_en

	UISpriteSetMgr.instance:setSummonSprite(slot1.imagerare, "pingzhi_" .. tostring(CharacterEnum.Color[slot5.rare]))
	UISpriteSetMgr.instance:setSummonSprite(slot1.equiprare, "equiprare_" .. tostring(CharacterEnum.Color[slot5.rare]))
	gohelper.setActive(slot1.imagecareer.gameObject, false)
	gohelper.setActive(slot1.simageicon.gameObject, false)
	slot1.simageequipicon:LoadImage(ResUrl.getSummonEquipGetIcon(slot5.icon), uv0, slot1)
	EquipHelper.loadEquipCareerNewIcon(slot5, slot1.imageequipcareer, 1, "lssx")
	slot0:_refreshEffect(slot5.rare, slot1)
	gohelper.setActive(slot1.go, true)
end

function slot0._refreshHeroItem(slot0, slot1, slot2)
	gohelper.setActive(slot1.imageequipcareer.gameObject, false)
	gohelper.setActive(slot1.goHeroIcon, true)
	gohelper.setActive(slot1.goluckybag, false)
	gohelper.setActive(slot1.txtname, true)
	gohelper.setActive(slot1.txtnameen, GameConfig:GetCurLangType() == LangSettings.zh)

	slot5 = HeroConfig.instance:getHeroCO(slot2.heroId)

	gohelper.setActive(slot1.equiprare.gameObject, false)
	gohelper.setActive(slot1.simageequipicon.gameObject, false)

	slot1.txtname.text = slot5.name
	slot1.txtnameen.text = slot5.nameEng

	UISpriteSetMgr.instance:setSummonSprite(slot1.imagerare, "pingzhi_" .. tostring(CharacterEnum.Color[slot5.rare]))
	UISpriteSetMgr.instance:setCommonSprite(slot1.imagecareer, "lssx_" .. tostring(slot5.career))
	slot1.simageicon:LoadImage(ResUrl.getHeadIconMiddle(SkinConfig.instance:getSkinCo(slot5.skinId).retangleIcon))

	if slot1.effect then
		gohelper.destroy(slot1.effect)

		slot1.effect = nil
	end

	slot0:_refreshEffect(slot5.rare, slot1)
	gohelper.setActive(slot1.go, true)
end

function slot0._refreshLuckyBagItem(slot0, slot1, slot2)
	gohelper.setActive(slot1.goluckybag, true)
	gohelper.setActive(slot1.equiprare.gameObject, false)
	gohelper.setActive(slot1.simageequipicon.gameObject, false)
	gohelper.setActive(slot1.imagecareer.gameObject, false)
	gohelper.setActive(slot1.simageicon.gameObject, false)
	gohelper.setActive(slot1.txtname, false)
	gohelper.setActive(slot1.txtnameen, false)

	slot3 = slot2.luckyBagId

	if not slot0._curPool then
		return
	end

	slot4 = SummonConfig.instance:getLuckyBag(slot0._curPool.id, slot3)
	slot1.txtluckybagname.text = slot4.name
	slot1.txtluckybagnameen.text = slot4.nameEn or ""

	slot1.simageluckgbagicon:LoadImage(ResUrl.getSummonCoverBg(slot4.icon))
	UISpriteSetMgr.instance:setSummonSprite(slot1.imagerare, "pingzhi_" .. tostring(CharacterEnum.Color[SummonEnum.LuckyBagRare]))
	slot0:_refreshEffect(SummonEnum.LuckyBagRare, slot1)
	gohelper.setActive(slot1.go, true)
end

function slot0._refreshEffect(slot0, slot1, slot2)
	slot3 = nil

	if slot1 == 3 then
		slot3 = slot0.viewContainer:getSetting().otherRes[1]
	elseif slot1 == 4 then
		slot3 = slot0.viewContainer:getSetting().otherRes[2]
	elseif slot1 == 5 then
		slot3 = slot0.viewContainer:getSetting().otherRes[3]
	end

	if slot3 then
		slot2.effect = slot0.viewContainer:getResInst(slot3, slot2.goeffect, "effect")

		slot2.effect:GetComponent(typeof(UnityEngine.Animation)):PlayQueued("ssr_loop", UnityEngine.QueueMode.CompleteOthers)
	end
end

function slot0.onUpdateParam(slot0)
	slot0._summonResultList = {}
	slot0._curPool = slot0.viewParam.curPool

	for slot5, slot6 in ipairs(slot0.viewParam.summonResultList) do
		table.insert(slot0._summonResultList, slot6)
	end

	if slot0._curPool then
		SummonModel.sortResult(slot0._summonResultList, slot0._curPool.id)
	end

	slot0:_refreshUI()
end

function slot0._showCommonPropView(slot0)
	if GuideController.instance:isGuiding() and GuideModel.instance:getDoingGuideId() == 102 then
		return false
	end

	slot1 = SummonModel.getRewardList(slot0._summonResultList)

	if slot0._curPool and slot0._curPool.ticketId ~= 0 then
		SummonModel.appendRewardTicket(slot0._summonResultList, slot1, slot0._curPool.ticketId)
	end

	if #slot1 <= 0 then
		return false
	end

	table.sort(slot1, SummonModel.sortRewards)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, slot1)

	return true
end

return slot0
