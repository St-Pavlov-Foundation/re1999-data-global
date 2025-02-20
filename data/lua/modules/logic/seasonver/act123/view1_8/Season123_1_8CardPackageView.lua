module("modules.logic.seasonver.act123.view1_8.Season123_1_8CardPackageView", package.seeall)

slot0 = class("Season123_1_8CardPackageView", BaseView)

function slot0.onInitView(slot0)
	slot0._gocardpackage = gohelper.findChild(slot0.viewGO, "#go_cardpackage")
	slot0._gocardgetBtns = gohelper.findChild(slot0.viewGO, "#go_cardpackage/cardgetBtns")
	slot0._gopackageCount = gohelper.findChild(slot0.viewGO, "#go_cardpackage/cardpackage/package/#go_packageCount")
	slot0._txtpackageCount = gohelper.findChildText(slot0.viewGO, "#go_cardpackage/cardpackage/package/#go_packageCount/#txt_packageCount")
	slot0._btnopenPackage = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_cardpackage/cardgetBtns/#btn_openPackage")
	slot0._btnopenOnePackage = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_cardpackage/cardgetBtns/#btn_openOnePackage")
	slot0._btnopenAllPackage = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_cardpackage/cardgetBtns/#btn_openAllPackage")
	slot0._gowaitingOpen = gohelper.findChild(slot0.viewGO, "#go_cardpackage/#go_waitingOpen")
	slot0._gorealOpen = gohelper.findChild(slot0.viewGO, "#go_cardpackage/#go_waitingOpen/#drag_realOpen")
	slot0._gocardget = gohelper.findChild(slot0.viewGO, "#go_cardget")
	slot0._scrollcardget = gohelper.findChildScrollRect(slot0.viewGO, "#go_cardget/mask/#scroll_cardget")
	slot0._gocardContent = gohelper.findChild(slot0.viewGO, "#go_cardget/mask/#scroll_cardget/Viewport/#go_cardContent")
	slot0._gocarditem = gohelper.findChild(slot0.viewGO, "#go_cardget/mask/#scroll_cardget/Viewport/#go_cardContent/#go_carditem")
	slot0._btnquit = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_cardget/#btn_quit")
	slot0._btnopenNext = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_cardget/cardgetBtns/#btn_openNext")
	slot0._btnskip = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_skip")
	slot0._imageskip = gohelper.findChildImage(slot0.viewGO, "#btn_skip/#image_skip")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._goopenEffect = gohelper.findChild(slot0.viewGO, "#go_cardpackage/cardpackage/package/openup")
	slot0._goopenLineEffect = gohelper.findChild(slot0.viewGO, "#go_cardpackage/cardpackage/package/kabao/go_line")
	slot0._animator = ZProj.ProjAnimatorPlayer.Get(slot0.viewGO)
	slot0._dragrealOpen = SLFramework.UGUI.UIDragListener.Get(slot0._gorealOpen)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnopenPackage:AddClickListener(slot0._btnopenPackageOnClick, slot0)
	slot0._btnopenOnePackage:AddClickListener(slot0._btnopenOnePackageOnClick, slot0)
	slot0._btnopenAllPackage:AddClickListener(slot0._btnopenAllPackageOnClick, slot0)
	slot0._dragrealOpen:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._dragrealOpen:AddDragEndListener(slot0._onDragEnd, slot0)
	slot0._btnquit:AddClickListener(slot0._btnquitOnClick, slot0)
	slot0._btnopenNext:AddClickListener(slot0._btnopenNextOnClick, slot0)
	slot0._btnskip:AddClickListener(slot0._btnskipOnClick, slot0)
	slot0:addEventCb(Season123Controller.instance, Season123Event.OnCardPackageOpen, slot0.showWaitingOpenView, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnopenPackage:RemoveClickListener()
	slot0._btnopenOnePackage:RemoveClickListener()
	slot0._btnopenAllPackage:RemoveClickListener()
	slot0._dragrealOpen:RemoveDragBeginListener()
	slot0._dragrealOpen:RemoveDragEndListener()
	slot0._btnquit:RemoveClickListener()
	slot0._btnopenNext:RemoveClickListener()
	slot0._btnskip:RemoveClickListener()
	slot0:removeEventCb(Season123Controller.instance, Season123Event.OnCardPackageOpen, slot0.showWaitingOpenView, slot0)
end

slot0.hideCardPackageTime = 0.33

function slot0._btnopenPackageOnClick(slot0)
	slot0:openCardPackage()
end

function slot0._btnopenOnePackageOnClick(slot0)
	slot0:openCardPackage()
end

function slot0._btnopenAllPackageOnClick(slot0)
	if slot0.hasClickOpen then
		return
	end

	Activity123Rpc.instance:sendAct123OpenCardBagRequest(slot0.actId, Activity123Enum.openAllCardPackage)
	Activity123Rpc.instance:sendGetUnlockAct123EquipIdsRequest(slot0.actId)
end

function slot0._onDragBegin(slot0, slot1, slot2)
	slot0._startPos = slot2.position.x
end

function slot0._onDragEnd(slot0, slot1, slot2)
	if slot0._startPos < slot2.position.x and recthelper.getWidth(slot0._gorealOpen.transform) / 4 <= Mathf.Abs(slot3 - slot0._startPos) then
		slot0:playOpenCardAnim()
		gohelper.setActive(slot0._gowaitingOpen, false)
	end
end

function slot0._btnskipOnClick(slot0)
	if slot0.hasClickSkip then
		return
	end

	slot0._animator:Stop()

	slot5 = slot0.showCardGetView

	slot0._animator:Play("kabao_skip", slot5, slot0)

	for slot5 = 2, 5 do
		gohelper.setActive(slot0.rareEffectList[slot5], slot5 == Season123CardPackageModel.instance:getCardMaxRare())
	end

	slot0.hasClickSkip = true
end

function slot0._btnquitOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnopenNextOnClick(slot0)
	slot0:openCardPackage()
end

function slot0._editableInitView(slot0)
	slot0.rareEffectList = slot0:getUserDataTb_()
	slot0.rareLineEffectList = slot0:getUserDataTb_()
	slot0.actId = Season123Model.instance:getCurSeasonId()
	slot4 = typeof
	slot0.contentGrid = slot0._gocardContent:GetComponent(slot4(UnityEngine.UI.GridLayoutGroup))

	for slot4 = 2, 5 do
		slot5 = gohelper.findChild(slot0._goopenEffect, "go_rare" .. slot4)
		slot6 = gohelper.findChild(slot0._goopenLineEffect, "go_rare" .. slot4)
		slot0.rareEffectList[slot4] = slot5
		slot0.rareLineEffectList[slot4] = slot6

		gohelper.setActive(slot5, false)
		gohelper.setActive(slot6, false)
	end

	slot0.hasClickSkip = false
	slot0.hasClickOpen = false
end

function slot0.onOpen(slot0)
	slot0:refreshCardPackageUI()
	gohelper.setActive(slot0._gocardgetBtns, true)
	gohelper.setActive(slot0._btnskip.gameObject, false)
	gohelper.setActive(slot0._gowaitingOpen, false)
	gohelper.setActive(slot0._gobtns, true)
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_jinye_cardpacks_unfold)
end

function slot0.refreshCardPackageUI(slot0)
	gohelper.setActive(slot0._gocardpackage, true)
	gohelper.setActive(slot0._gocardget, false)

	slot0.curPackageCount = Season123CardPackageModel.instance:initPackageCount()
	slot0._txtpackageCount.text = slot0.curPackageCount

	gohelper.setActive(slot0._btnopenPackage.gameObject, slot0.curPackageCount == 1)
	gohelper.setActive(slot0._btnopenOnePackage.gameObject, slot0.curPackageCount > 1)
	gohelper.setActive(slot0._btnopenAllPackage.gameObject, slot0.curPackageCount > 1)
end

function slot0.showWaitingOpenView(slot0)
	slot0._animator:Play("kabao_wait")
	slot0:refreshCardPackageUI()
	gohelper.setActive(slot0._gowaitingOpen, true)
	gohelper.setActive(slot0._gocardgetBtns, false)
	gohelper.setActive(slot0._gobtns, false)
end

function slot0.playOpenCardAnim(slot0)
	slot0:refreshCardPackageUI()
	gohelper.setActive(slot0._btnskip.gameObject, true)
	gohelper.setActive(slot0._gocardgetBtns, false)

	slot5 = slot0.showCardGetView

	slot0._animator:Play("kabao_open", slot5, slot0)

	slot0.openCardPackageAudioId = AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_jinye_cardpacks_open)
	slot1 = Season123CardPackageModel.instance:getCardMaxRare()

	for slot5 = 2, 5 do
		gohelper.setActive(slot0.rareEffectList[slot5], slot5 == slot1)
		gohelper.setActive(slot0.rareLineEffectList[slot5], slot5 == slot1)
	end
end

function slot0.showCardGetView(slot0)
	slot0:refreshCardGetUI()
	TaskDispatcher.runDelay(slot0.hideCardPackageView, slot0, uv0.hideCardPackageTime)

	if slot0.hasClickSkip then
		slot0:stopOpenCardPackageAudio()
	end

	Season123Controller.instance:dispatchEvent(Season123Event.GotCardView)
end

function slot0.hideCardPackageView(slot0)
	gohelper.setActive(slot0._gocardpackage, false)

	slot0.hasClickSkip = false
end

function slot0.refreshCardGetUI(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_celebrity_get)
	gohelper.setActive(slot0._gocardget, true)
	gohelper.setActive(slot0._btnskip.gameObject, false)
	slot0:refreshScrollPos()
	gohelper.setActive(slot0._btnopenNext, slot0.curPackageCount > 0)
	gohelper.setActive(slot0._btnquit, true)
	gohelper.setActive(slot0._gobtns, false)

	slot0.hasClickOpen = false
end

function slot0.refreshScrollPos(slot0)
	if Season123CardPackageModel.instance:getCount() <= 6 then
		slot0.contentGrid.enabled = false
		slot0.contentGrid.enabled = true

		transformhelper.setLocalPosXY(slot0._scrollcardget.transform, 0, -680)
	else
		slot0.contentGrid.enabled = false

		transformhelper.setLocalPosXY(slot0._scrollcardget.transform, 0, -570)
	end
end

function slot0.openCardPackage(slot0)
	if slot0.hasClickOpen then
		return
	end

	slot0.hasClickOpen = true

	Activity123Rpc.instance:sendAct123OpenCardBagRequest(slot0.actId, Season123CardPackageModel.instance:getOpenPackageMO().id)
	Activity123Rpc.instance:sendGetUnlockAct123EquipIdsRequest(slot0.actId)
	slot0:stopOpenCardPackageAudio()
end

function slot0.stopOpenCardPackageAudio(slot0)
	if slot0.openCardPackageAudioId then
		AudioMgr.instance:stopPlayingID(slot0.openCardPackageAudioId)

		slot0.openCardPackageAudioId = nil
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.hideCardPackageView, slot0)
	slot0:stopOpenCardPackageAudio()
end

function slot0.onDestroyView(slot0)
	Season123CardPackageModel.instance:release()
end

return slot0
