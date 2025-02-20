module("modules.logic.fight.view.FightPreDisplayView", package.seeall)

slot0 = class("FightPreDisplayView", BaseView)

function slot0.onInitView(slot0)
	slot0._obj = gohelper.findChild(slot0.viewGO, "root/predisplay")
	slot0._text = gohelper.findChildText(slot0._obj, "#txt_CardNum")
	slot0._btn = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/predisplay")
	slot0._ani = SLFramework.AnimatorPlayer.Get(slot0._btn.gameObject)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnCameraFocusChanged, slot0._onCameraFocusChanged, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.AddPlayOperationData, slot0._onAddPlayOperationData, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnResetCard, slot0._onResetCard, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnStageChange, slot0._onStageChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnClothSkillExpand, slot0._onClothSkillExpand, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnClothSkillShrink, slot0._onClothSkillShrink, slot0)
	slot0:addClickCb(slot0._btn, slot0._onBtnClick, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0._onBtnClick(slot0)
	if not FightDataHelper.stageMgr:isFree() then
		return
	end

	ViewMgr.instance:openView(ViewName.FightCardDeckView, {
		selectType = FightCardDeckView.SelectType.PreCard
	})
end

function slot0.onRefreshViewParam(slot0)
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0._obj, false)
	slot0:_refreshUI()
end

function slot0._onResetCard(slot0)
	gohelper.setActive(slot0._obj, false)
	slot0:_refreshUI()

	slot0._lastCount = slot0._curCardCount
	slot0._isVisible = false
end

function slot0._refreshUI(slot0)
	slot0._cardList = FightHelper.getNextRoundGetCardList()
	slot0._curCardCount = #slot0._cardList
	slot0._text.text = luaLang("multiple") .. slot0._curCardCount
end

function slot0._onAddPlayOperationData(slot0)
	if FightDataHelper.fieldMgr:isDouQuQu() then
		return
	end

	slot0:_refreshUI()

	if slot0._curCardCount > 0 then
		slot0._isVisible = true
	end

	if slot0._lastCount then
		if slot0._lastCount < #slot0._cardList then
			slot0:_playAni("fiy")
		end
	elseif #slot0._cardList > 0 then
		slot0:_playAni("open")
	end

	slot0._lastCount = #slot0._cardList
end

function slot0._playAni(slot0, slot1)
	slot0._state = slot1

	gohelper.setActive(slot0._obj, true)
	slot0._ani:Play(slot1, slot0._aniDone, slot0)
end

function slot0._aniDone(slot0)
	if slot0._state == "close" then
		gohelper.setActive(slot0._obj, false)
	end
end

function slot0._setActive(slot0, slot1)
	if slot1 then
		if slot0._isVisible then
			slot0:_playAni("open")
		end
	elseif slot0._isVisible then
		slot0:_playAni("close")
	end
end

function slot0._hide(slot0)
	if slot0._isVisible then
		slot0:_playAni("close")
	end
end

function slot0._onCameraFocusChanged(slot0, slot1)
	if slot1 then
		slot0:_setActive(false)
	else
		slot0:_setActive(true)
	end
end

function slot0._onStageChange(slot0, slot1)
	if slot1 ~= FightEnum.Stage.Card then
		gohelper.setActive(slot0._obj, false)

		slot0._isVisible = false
		slot0._lastCount = nil
	end
end

function slot0._onClothSkillExpand(slot0)
	slot0:_setActive(false)
end

function slot0._onClothSkillShrink(slot0)
	slot0:_setActive(true)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
