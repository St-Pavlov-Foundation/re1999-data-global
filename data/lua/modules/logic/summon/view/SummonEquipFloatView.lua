module("modules.logic.summon.view.SummonEquipFloatView", package.seeall)

slot0 = class("SummonEquipFloatView", BaseView)

function slot0.onInitView(slot0)
	slot0._goresult = gohelper.findChild(slot0.viewGO, "#go_result")
	slot0._goresultitem = gohelper.findChild(slot0.viewGO, "#go_result/resultcontent/#go_resultitem")
	slot0._btnopenall = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_result/#btn_openall")
	slot0._btnreturn = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_result/#btn_return")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnopenall:AddClickListener(slot0._btnopenallOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnopenall:RemoveClickListener()
end

function slot0._btnopenallOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_click)

	for slot4 = 1, 10 do
		slot0:openSummonResult(slot4, true)
	end

	SummonController.instance:nextSummonPopupParam()
end

function slot0.handleSkip(slot0)
	if not slot0._isDrawing or not slot0.summonResult then
		return
	end

	SummonController.instance:clearSummonPopupList()

	if #slot0.summonResult == 1 then
		slot2, slot3 = SummonModel.instance:openSummonEquipResult(1)

		if slot2 then
			ViewMgr.instance:openView(ViewName.SummonEquipGainView, {
				skipVideo = true,
				equipId = slot2.equipId,
				summonResultMo = slot2
			})
		end
	elseif slot1 >= 10 then
		for slot5 = 1, 10 do
			SummonModel.instance:openSummonResult(slot5)
		end

		if not SummonController.instance:getLastPoolId() then
			return
		end

		if not SummonConfig.instance:getSummonPool(slot2) then
			return
		end

		ViewMgr.instance:openView(ViewName.SummonResultView, {
			summonResultList = slot0.summonResult,
			curPool = slot3
		})
	end
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goresultitem, false)

	slot0._resultitems = {}
	slot0._summonUIEffects = slot0:getUserDataTb_()
end

function slot0.onOpen(slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonReply, slot0.startDraw, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonAnimRareEffect, slot0.handleSummonAnimRareEffect, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonAnimEnd, slot0.handleSummonAnimEnd, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonEquipEnd, slot0.handleSummonEnd, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonSkip, slot0.handleSkip, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0.handleCloseView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0.handleOpenView, slot0)
end

function slot0.onClose(slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonReply, slot0.startDraw, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonAnimRareEffect, slot0.handleSummonAnimRareEffect, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonAnimEnd, slot0.handleSummonAnimEnd, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonEquipEnd, slot0.handleSummonEnd, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonSkip, slot0.handleSkip, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0.handleCloseView, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0.handleOpenView, slot0)
end

function slot0.startDraw(slot0)
	SummonController.instance:clearSummonPopupList()

	slot0.summonResult = SummonModel.instance:getSummonResult(true)

	slot0:recycleEffect()

	slot0._isDrawing = true
end

function slot0.handleSummonAnimEnd(slot0)
	slot0:initSummonResult()
end

function slot0.handleSummonEnd(slot0)
	slot0:recycleEffect()
end

function slot0.handleSummonAnimRareEffect(slot0)
	slot1 = nil

	for slot5 = 1, #slot0.summonResult do
		slot8 = ""
		slot9 = ""
		slot8 = (EquipConfig.instance:getEquipCo(slot0.summonResult[slot5].equipId).rare > 2 or SummonEnum.SummonPreloadPath.EquipUIN) and (slot7.rare ~= 3 or SummonEnum.SummonPreloadPath.EquipUIR) and (slot7.rare ~= 4 or SummonEnum.SummonPreloadPath.EquipUISR) and SummonEnum.SummonPreloadPath.EquipUISSR
		slot10 = SummonEffectPool.getEffect(slot8, ((#slot0.summonResult <= 1 or SummonController.instance:getUINodes()) and SummonController.instance:getOnlyUINode())[slot5])

		slot10:setAnimationName(SummonEnum.AnimationName[slot8])
		slot10:play()
		slot10:loadEquipWaitingClick()
		slot10:setEquipFrame(false)
		table.insert(slot0._summonUIEffects, slot10)
	end
end

function slot0.initSummonResult(slot0)
	slot0._waitEffectList = {}
	slot0._waitNormalEffectList = {}
	slot1 = nil
	slot1 = (#slot0.summonResult <= 1 or SummonController.instance:getUINodes()) and SummonController.instance:getOnlyUINode()

	for slot5 = 1, #slot0.summonResult do
		slot6 = slot0.summonResult[slot5]

		if not slot0._resultitems[slot5] then
			slot7 = slot0:getUserDataTb_()
			slot7.go = gohelper.cloneInPlace(slot0._goresultitem, "item" .. slot5)
			slot7.index = slot5
			slot7.btnopen = gohelper.findChildButtonWithAudio(slot7.go, "btn_open")

			slot7.btnopen:AddClickListener(slot0.onClickItem, slot0, slot7)
			table.insert(slot0._resultitems, slot7)
		end

		if slot1[slot5] then
			slot11 = recthelper.worldPosToAnchorPos(gohelper.findChild(slot8, "btn/btnTopLeft").transform.position, slot0.viewGO.transform)
			slot12 = recthelper.worldPosToAnchorPos(gohelper.findChild(slot8, "btn/btnBottomRight").transform.position, slot0.viewGO.transform)

			recthelper.setAnchor(slot7.go.transform, (slot11.x + slot12.x) / 2, (slot11.y + slot12.y) / 2)
			recthelper.setHeight(slot7.go.transform, math.abs(slot11.y - slot12.y))
			recthelper.setWidth(slot7.go.transform, math.abs(slot12.x - slot11.x))
		end

		gohelper.setActive(slot7.btnopen.gameObject, true)
		gohelper.setActive(slot7.go, true)
	end

	for slot5 = #slot0.summonResult + 1, #slot0._resultitems do
		gohelper.setActive(slot0._resultitems[slot5].go, false)
	end
end

function slot0.onClickItem(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_click)
	slot0:openSummonResult(slot1.index)
	SummonController.instance:nextSummonPopupParam()
end

function slot0.openSummonResult(slot0, slot1, slot2)
	slot3, slot4 = SummonModel.instance:openSummonEquipResult(slot1)
	slot6 = #slot0.summonResult >= 10

	if slot3 then
		if not slot2 then
			logNormal(string.format("获得心相:%s", EquipConfig.instance:getEquipCo(slot3.equipId).name))
		end

		if slot0._resultitems[slot1] then
			gohelper.setActive(slot0._resultitems[slot1].btnopen.gameObject, false)
		end

		if not slot6 or not slot2 or slot8.rare >= 5 then
			table.insert(slot0._waitEffectList, {
				index = slot1,
				equipId = slot7
			})
			SummonController.instance:insertSummonPopupList(PopupEnum.PriorityType.GainCharacterView, ViewName.SummonEquipGainView, {
				equipId = slot7,
				summonResultMo = slot3,
				isSummonTen = slot6
			})
		elseif not slot2 then
			slot9 = slot0._summonUIEffects[slot1]

			slot9:setEquipFrame(true)
			slot9:loadEquipIcon(slot7)
		else
			table.insert(slot0._waitNormalEffectList, {
				index = slot1,
				equipId = slot7
			})
		end

		if SummonModel.instance:isAllOpened() then
			gohelper.setActive(slot0._btnopenall.gameObject, false)

			if not slot6 then
				gohelper.setActive(slot0._btnreturn.gameObject, true)
			else
				if not SummonController.instance:getLastPoolId() then
					return
				end

				if not SummonConfig.instance:getSummonPool(slot9) then
					return
				end

				SummonController.instance:insertSummonPopupList(PopupEnum.PriorityType.SummonResultView, ViewName.SummonResultView, {
					summonResultList = slot5,
					curPool = slot10
				})
			end
		end
	end
end

function slot0._refreshIcons(slot0)
	if (not slot0._waitEffectList or #slot0._waitEffectList <= 1) and slot0._waitNormalEffectList and #slot0._waitNormalEffectList > 0 then
		for slot4, slot5 in ipairs(slot0._waitNormalEffectList) do
			if slot0._summonUIEffects[slot5.index] then
				slot8:setEquipFrame(true)
				slot8:loadEquipIcon(slot5.equipId)
			end
		end
	end

	if not slot0._waitEffectList or #slot0._waitEffectList <= 0 then
		return
	end

	slot1 = slot0._waitEffectList[1]

	table.remove(slot0._waitEffectList, 1)

	slot3 = slot1.equipId

	if not slot0._summonUIEffects[slot1.index] then
		return
	end

	slot4:setEquipFrame(true)
	slot4:loadEquipIcon(slot3)
end

function slot0.handleCloseView(slot0, slot1)
	if slot1 == ViewName.SummonEquipGainView then
		slot0:_refreshIcons()
	end
end

function slot0.handleOpenView(slot0, slot1)
	if slot1 == ViewName.SummonResultView then
		slot0:_refreshIcons()
	end
end

function slot0.recycleEffect(slot0)
	if slot0._summonUIEffects then
		for slot4 = 1, #slot0._summonUIEffects do
			SummonEffectPool.returnEffect(slot0._summonUIEffects[slot4])

			slot0._summonUIEffects[slot4] = nil
		end
	end
end

function slot0.onDestroyView(slot0)
	for slot4 = 1, #slot0._resultitems do
		slot0._resultitems[slot4].btnopen:RemoveClickListener()
	end
end

return slot0
