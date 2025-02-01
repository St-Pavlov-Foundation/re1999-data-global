module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameResultView", package.seeall)

slot0 = class("AiZiLaGameResultView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg2")
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg1")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._txtday = gohelper.findChildText(slot0.viewGO, "content/Title/#txt_day")
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "content/Title/#txt_Title")
	slot0._gosuccess = gohelper.findChild(slot0.viewGO, "content/#go_success")
	slot0._gofail = gohelper.findChild(slot0.viewGO, "content/#go_fail")
	slot0._txtuseTimes = gohelper.findChildText(slot0.viewGO, "content/roundUse/#txt_useTimes")
	slot0._txttimes = gohelper.findChildText(slot0.viewGO, "content/round/#txt_times")
	slot0._goTips = gohelper.findChild(slot0.viewGO, "content/Layout/#go_Tips")
	slot0._txtTips = gohelper.findChildText(slot0.viewGO, "content/Layout/#go_Tips/#txt_Tips")
	slot0._scrollItems = gohelper.findChildScrollRect(slot0.viewGO, "content/Layout/#scroll_Items")
	slot0._gorewardContent = gohelper.findChild(slot0.viewGO, "content/Layout/#scroll_Items/Viewport/#go_rewardContent")
	slot0._goBackBtns = gohelper.findChild(slot0.viewGO, "#go_BackBtns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	if slot0:isLockOp() then
		return
	end

	AiZiLaGameController.instance:gameResultOver()
end

function slot0._editableInitView(slot0)
	slot0._goodsItemGo = slot0:getResInst(AiZiLaGoodsItem.prefabPath, slot0.viewGO)

	gohelper.setActive(slot0._goodsItemGo, false)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._animator = slot0.viewGO:GetComponent(AiZiLaEnum.ComponentType.Animator)

	slot0:addEventCb(AiZiLaController.instance, AiZiLaEvent.ExitGame, slot0.closeThis, slot0)

	if slot0.viewContainer then
		NavigateMgr.instance:addEscape(slot0.viewContainer.viewName, slot0._btncloseOnClick, slot0)
	end

	slot0:_setLockOpTime(1)
	slot0:refreshUI()
	AudioMgr.instance:trigger(AiZiLaGameModel.instance:getIsSafe() and AudioEnum.V1a5AiZiLa.ui_wulu_aizila_safe_away or AudioEnum.V1a5AiZiLa.ui_wulu_aizila_urgent_away)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0.playViewAnimator(slot0, slot1)
	if slot0._animator then
		slot0._animator.enabled = true

		slot0._animator:Play(slot1, 0, 0)
	end
end

function slot0.refreshUI(slot0)
	slot1 = AiZiLaGameModel.instance:getIsSafe()
	slot3 = AiZiLaGameModel.instance:getEpisodeMO() and slot2:getConfig()
	slot4 = {}

	if AiZiLaGameModel.instance:getIsFirstPass() and slot3 then
		AiZiLaHelper.getItemMOListByBonusStr(slot3.bonus, slot4)
	end

	tabletool.addValues(slot4, AiZiLaGameModel.instance:getResultItemList())
	gohelper.setActive(slot0._gosuccess, slot1)
	gohelper.setActive(slot0._gofail, not slot1)
	gohelper.setActive(slot0._goTips, not slot1 and #slot4 > 0)
	gohelper.CreateObjList(slot0, slot0._onRewardItem, slot4, slot0._gorewardContent, slot0._goodsItemGo, AiZiLaGoodsItem)

	if slot2 then
		slot5 = slot2.day or 0
		slot0._txtuseTimes.text = string.format("%sm", math.max(0, slot2.altitude or 0))
		slot0._txttimes.text = math.max(0, slot2.actionPoint or 0)
		slot0._txtTitle.text = slot3 and slot3.name or ""
		slot0._txtday.text = formatLuaLang("v1a5_aizila_day_str", slot5)
		slot6 = AiZiLaConfig.instance:getRoundCo(slot3.activityId, slot3.episodeId, math.max(1, slot5))

		if not slot1 and slot6 then
			slot0._txtTips.text = formatLuaLang("v1a5_aizila_keep_material_rate", (1000 - slot6.keepMaterialRate) * 0.1 .. "%")
		end
	end
end

function slot0._onRewardItem(slot0, slot1, slot2, slot3)
	slot1:onUpdateMO(slot2)
end

function slot0._setLockOpTime(slot0, slot1)
	slot0._lockTime = Time.time + slot1
end

function slot0.isLockOp(slot0)
	if slot0._lockTime and Time.time < slot0._lockTime then
		return true
	end

	return false
end

return slot0
