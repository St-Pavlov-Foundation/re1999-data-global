module("modules.logic.summonsimulationpick.view.SummonSimulationResultView", package.seeall)

slot0 = class("SummonSimulationResultView", BaseView)
slot0.SAVED_ANIM_NAME = "open"
slot0.IDLE_ANIM_NAME = "idle"
slot0.FIRST_SAVE_ANIM_DELAY = 0.5
slot0.SUMMON_CONFIRM_TEXT = "p_summonpickresultview_txt_confirm"
slot0.SUMMON_AGAIN_TEXT = "p_summonpickresultview_txt_again"

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._simagebg0 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg0")
	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg2")
	slot0._simageline1 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_line1")
	slot0._simageline2 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_line2")
	slot0._simageline3 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_line3")
	slot0._goheroitem10 = gohelper.findChild(slot0.viewGO, "herocontent/#go_heroitem10")
	slot0._goheroitem5 = gohelper.findChild(slot0.viewGO, "herocontent/#go_heroitem5")
	slot0._goheroitem2 = gohelper.findChild(slot0.viewGO, "herocontent/#go_heroitem2")
	slot0._goheroitem4 = gohelper.findChild(slot0.viewGO, "herocontent/#go_heroitem4")
	slot0._goheroitem7 = gohelper.findChild(slot0.viewGO, "herocontent/#go_heroitem7")
	slot0._goheroitem8 = gohelper.findChild(slot0.viewGO, "herocontent/#go_heroitem8")
	slot0._goheroitem3 = gohelper.findChild(slot0.viewGO, "herocontent/#go_heroitem3")
	slot0._goheroitem1 = gohelper.findChild(slot0.viewGO, "herocontent/#go_heroitem1")
	slot0._goheroitem6 = gohelper.findChild(slot0.viewGO, "herocontent/#go_heroitem6")
	slot0._goheroitem9 = gohelper.findChild(slot0.viewGO, "herocontent/#go_heroitem9")
	slot0._btnsave = gohelper.findChildButtonWithAudio(slot0.viewGO, "Btn/#btn_save")
	slot0._gosaved = gohelper.findChild(slot0.viewGO, "Btn/#go_saved")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "Btn/#btn_confirm")
	slot0._btnagain = gohelper.findChildButtonWithAudio(slot0.viewGO, "Btn/#btn_again")
	slot0._btntips = gohelper.findChildButton(slot0.viewGO, "#btn_tips")
	slot0._txtresttime = gohelper.findChildText(slot0.viewGO, "Btn/rest/#txt_resttime")
	slot0._txtagain = gohelper.findChildText(slot0.viewGO, "Btn/#btn_again/#txt_again")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnsave:AddClickListener(slot0._btnsaveOnClick, slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
	slot0._btnagain:AddClickListener(slot0._btnagainOnClick, slot0)
	slot0._btntips:AddClickListener(slot0._btntipsOnClick, slot0)
	SummonSimulationPickController.instance:registerCallback(SummonSimulationEvent.onSummonSimulation, slot0.onSummonSimulation, slot0)
	SummonSimulationPickController.instance:registerCallback(SummonSimulationEvent.onSaveResult, slot0.onSummonSave, slot0)
	SummonSimulationPickController.instance:registerCallback(SummonSimulationEvent.onSelectResult, slot0.closeThis, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnsave:RemoveClickListener()
	slot0._btnconfirm:RemoveClickListener()
	slot0._btnagain:RemoveClickListener()
	slot0._btntips:RemoveClickListener()
	SummonSimulationPickController.instance:unregisterCallback(SummonSimulationEvent.onSummonSimulation, slot0.onSummonSimulation, slot0)
	SummonSimulationPickController.instance:unregisterCallback(SummonSimulationEvent.onSaveResult, slot0.onSummonSave, slot0)
	SummonSimulationPickController.instance:unregisterCallback(SummonSimulationEvent.onSelectResult, slot0.closeThis, slot0)
end

function slot0._btnsaveOnClick(slot0)
	if slot0._cantClose then
		return
	end

	ViewMgr.instance:openView(ViewName.SummonSimulationPickView, {
		activityId = slot0._activityId,
		pickType = SummonSimulationEnum.PickType.SaveResult
	})
end

function slot0._btnconfirmOnClick(slot0)
	if slot0._cantClose then
		return
	end

	ViewMgr.instance:openView(ViewName.SummonSimulationPickView, {
		activityId = slot0._activityId,
		pickType = SummonSimulationEnum.PickType.SelectResult
	})
end

function slot0._btnagainOnClick(slot0)
	if slot0._cantClose then
		return
	end

	if SummonSimulationPickModel.instance:getActInfo(slot0._activityId).leftTimes > 0 then
		SummonSimulationPickController.instance:summonSimulation(slot0._activityId)
	else
		ViewMgr.instance:openView(ViewName.SummonSimulationPickView, {
			activityId = slot0._activityId,
			pickType = SummonSimulationEnum.PickType.SelectResult
		})
	end
end

function slot0._btntipsOnClick(slot0)
	if slot0._cantClose then
		return
	end

	SummonSimulationPickController.instance:openSummonTips(slot0._activityId)
end

function slot0._btncloseOnClick(slot0)
	if slot0._cantClose then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.SummonSimulationExit, MsgBoxEnum.BoxType.Yes_No, slot0._confirmExit, nil, , slot0)
end

function slot0._confirmExit(slot0)
	if slot0._isReprint == false then
		slot1 = SummonSimulationPickController.instance

		SummonController.instance:setSummonEndOpenCallBack(slot1.backHome, slot1)
	end

	slot0.isClickBack = true

	slot0:closeThis()
end

function slot0.onSummonSimulation(slot0)
	slot0.isSummon = true

	SummonSimulationPickController.instance:startBlack()
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

	slot0._cantClose = true
	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1.5, nil, slot0._tweenFinish, slot0, nil, EaseType.Linear)
	slot0._goSaveAnimator = gohelper.findChildComponent(slot0._gosaved.gameObject, "", gohelper.Type_Animator)
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
	slot0._isReprint = slot0.viewParam.isReprint ~= nil and slot0.viewParam.isReprint or false

	for slot5, slot6 in ipairs(slot0.viewParam.summonResultList) do
		table.insert(slot0._summonResultList, slot6)
	end

	if slot0._curPool then
		SummonModel.sortResult(slot0._summonResultList, slot0._curPool.id)
	end

	slot0.viewContainer.navigateView:setOverrideClose(slot0._btncloseOnClick, slot0)
	slot0:_refreshUI()
	NavigateMgr.instance:addEscape(ViewName.SummonSimulationResultView, slot0._btnconfirmOnClick, slot0)
end

function slot0.onClose(slot0)
	slot0.viewContainer.navigateView:setOverrideClose(nil, )
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonReply, slot0.onSummonReply, slot0)
	TaskDispatcher.cancelTask(slot0.delayPlayBtnAnim, slot0)
end

function slot0.onCloseFinish(slot0)
	if not slot0:_showCommonPropView() then
		SummonController.instance:dispatchEvent(SummonEvent.onSummonResultClose)
	end
end

function slot0.onClickItem(slot0)
	if slot0.view._summonResultList[slot0.index].heroId and slot3.heroId ~= 0 then
		ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
			showHome = false,
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

function slot0.onSummonSave(slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0.onSaveViewClose, slot0)
end

function slot0.onSaveViewClose(slot0, slot1)
	if slot1 == ViewName.SummonSimulationPickView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0.onSaveViewClose, slot0)
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2SummonSimulation.play_ui_checkpoint_doom_disappear)
		slot0:_refreshSelectState()
	end
end

function slot0._refreshUI(slot0)
	gohelper.setActive(slot0._simagebg0, not VirtualSummonScene.instance:isOpen())

	for slot5 = 1, #slot0._summonResultList do
		if slot0._summonResultList[slot5].heroId and slot6.heroId ~= 0 then
			slot0:_refreshHeroItem(slot0._heroItemTables[slot5], slot6)
		elseif slot6.equipId and slot6.equipId ~= 0 then
			slot0:_refreshEquipItem(slot0._heroItemTables[slot5], slot6)
		elseif slot6:isLuckyBag() then
			slot0:_refreshLuckyBagItem(slot0._heroItemTables[slot5], slot6)
		else
			gohelper.setActive(slot0._heroItemTables[slot5].go, false)
		end
	end

	for slot5 = #slot0._summonResultList + 1, #slot0._heroItemTables do
		gohelper.setActive(slot0._heroItemTables[slot5].go, false)
	end

	slot0:_refreshSelectState()
end

function slot0._refreshSelectState(slot0)
	slot1 = SummonSimulationPickController.instance:getCurrentSummonActivityId()
	slot0._activityId = slot1

	if not SummonSimulationPickModel.instance:getActInfo(slot1) then
		return
	end

	slot4 = slot2.leftTimes
	slot0._txtresttime.text = string.format("<size=46><#C66030>%s</color></size>/%s", slot4, SummonSimulationPickModel.instance:getActivityMaxSummonCount(slot1))
	slot5 = slot4 <= 0

	gohelper.setActive(slot0._btnsave, not slot5)
	gohelper.setActive(slot0._btnconfirm, not slot5)
	gohelper.setActive(slot0._gosaved, slot2:haveSaveCurrent() and not slot5)

	slot0._txtagain.text = slot5 and luaLang(slot0.SUMMON_CONFIRM_TEXT) or luaLang(slot0.SUMMON_AGAIN_TEXT)
	slot8 = slot6 and not slot0._isReprint
	slot0._goSaveAnimator.enabled = slot8

	if slot8 then
		if slot4 == slot3 - 1 then
			TaskDispatcher.runDelay(slot0.delayPlayBtnAnim, slot0, slot0.FIRST_SAVE_ANIM_DELAY)
		else
			slot9:Play(slot0.SAVED_ANIM_NAME, 0, 0)
		end
	end
end

function slot0.delayPlayBtnAnim(slot0)
	slot0._goSaveAnimator:Play(slot0.SAVED_ANIM_NAME, 0, 0)
	GameFacade.showToast(ToastEnum.SummonSimulationSaveResult)
	TaskDispatcher.cancelTask(slot0.delayPlayBtnAnim, slot0)
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
	gohelper.setActive(slot1.txtnameen, true)

	slot4 = EquipConfig.instance:getEquipCo(slot2.equipId)
	slot1.txtname.text = slot4.name
	slot1.txtnameen.text = slot4.name_en

	UISpriteSetMgr.instance:setSummonSprite(slot1.imagerare, "pingzhi_" .. tostring(CharacterEnum.Color[slot4.rare]))
	UISpriteSetMgr.instance:setSummonSprite(slot1.equiprare, "equiprare_" .. tostring(CharacterEnum.Color[slot4.rare]))
	gohelper.setActive(slot1.imagecareer.gameObject, false)
	gohelper.setActive(slot1.simageicon.gameObject, false)
	slot1.simageequipicon:LoadImage(ResUrl.getSummonEquipGetIcon(slot4.icon), uv0, slot1)
	EquipHelper.loadEquipCareerNewIcon(slot4, slot1.imageequipcareer, 1, "lssx")
	slot0:_refreshEffect(slot4.rare, slot1)
	gohelper.setActive(slot1.go, true)
end

function slot0._refreshHeroItem(slot0, slot1, slot2)
	gohelper.setActive(slot1.imageequipcareer.gameObject, false)
	gohelper.setActive(slot1.goHeroIcon, true)
	gohelper.setActive(slot1.goluckybag, false)
	gohelper.setActive(slot1.txtname, true)
	gohelper.setActive(slot1.txtnameen, true)

	slot4 = HeroConfig.instance:getHeroCO(slot2.heroId)

	gohelper.setActive(slot1.equiprare.gameObject, false)
	gohelper.setActive(slot1.simageequipicon.gameObject, false)

	slot1.txtname.text = slot4.name
	slot1.txtnameen.text = slot4.nameEng

	UISpriteSetMgr.instance:setSummonSprite(slot1.imagerare, "pingzhi_" .. tostring(CharacterEnum.Color[slot4.rare]))
	UISpriteSetMgr.instance:setCommonSprite(slot1.imagecareer, "lssx_" .. tostring(slot4.career))
	slot1.simageicon:LoadImage(ResUrl.getHeadIconMiddle(SkinConfig.instance:getSkinCo(slot4.skinId).retangleIcon))

	if slot1.effect then
		gohelper.destroy(slot1.effect)

		slot1.effect = nil
	end

	slot0:_refreshEffect(slot4.rare, slot1)
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
	if SummonSimulationPickModel.instance:getActInfo(slot0._activityId).isSelect == false then
		if VirtualSummonScene.instance:isOpen() then
			if slot0.isClickBack then
				return false
			elseif slot0.isSummon then
				return true
			end
		end

		return not slot0._isReprint
	end

	if SummonController.instance:getVirtualSummonResult(slot2.saveHeroIds, false, true) == nil then
		return false
	end

	slot5 = SummonSimulationPickController.instance

	SummonController.instance:setSummonEndOpenCallBack(slot5.backHome, slot5)

	slot6 = SummonModel.getRewardList(slot4, true)

	table.sort(slot6, SummonModel.sortRewards)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, slot6)

	return true
end

return slot0
