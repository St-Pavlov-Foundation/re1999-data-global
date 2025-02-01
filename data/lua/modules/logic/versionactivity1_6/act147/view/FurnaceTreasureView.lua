module("modules.logic.versionactivity1_6.act147.view.FurnaceTreasureView", package.seeall)

slot0 = class("FurnaceTreasureView", BaseView)

function slot0.onInitView(slot0)
	slot0._gospine = gohelper.findChild(slot0.viewGO, "#go_spine")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Right/LimitTimeBg/#txt_LimitTime")
	slot0._goDecContent = gohelper.findChild(slot0.viewGO, "Right/DecBg/scroll_Dec/Viewport/Content")
	slot0._txtDecItem = gohelper.findChildText(slot0.viewGO, "Right/DecBg/scroll_Dec/Viewport/Content/#txt_DecItem")
	slot0._gorewards = gohelper.findChild(slot0.viewGO, "Right/scroll_Reward/Viewport/#go_rewards")
	slot0._btngoto = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_goto")
	slot0._goarrow = gohelper.findChild(slot0.viewGO, "Right/arrow")
	slot0._txtlimitbuy = gohelper.findChildText(slot0.viewGO, "LimitTips/bg/#txt_limitbuy")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btngoto:AddClickListener(slot0._btngotoOnClick, slot0)
	slot0:addEventCb(FurnaceTreasureController.instance, FurnaceTreasureEvent.onFurnaceTreasureGoodsUpdate, slot0.refreshBuyCount, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btngoto:RemoveClickListener()
	slot0:removeEventCb(FurnaceTreasureController.instance, FurnaceTreasureEvent.onFurnaceTreasureGoodsUpdate, slot0.refreshBuyCount, slot0)
end

function slot0._btngotoOnClick(slot0)
	if FurnaceTreasureConfig.instance:getJumpId(slot0.actId) and slot1 ~= 0 then
		GameFacade.jump(slot1)
	end
end

function slot0._editableInitView(slot0)
	slot0.actId = nil
	slot0._uiSpine = GuiSpine.Create(slot0._gospine, false)

	if slot0._uiSpine then
		slot0._uiSpine:useRT()
		slot0._uiSpine:setImgPos(0, 0)
		slot0._uiSpine:setImgParent(slot0._gospine.transform)
	end
end

function slot0.onOpen(slot0)
	if slot0.viewParam then
		gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)

		slot0.actId = slot0.viewParam.actId
	end

	slot0:setDescList()
	slot0:setRewardList()
	slot0:refreshBuyCount()
	slot0:refreshLimitTime()
	TaskDispatcher.cancelTask(slot0.refreshLimitTime, slot0)
	TaskDispatcher.runRepeat(slot0.refreshLimitTime, slot0, TimeUtil.OneMinuteSecond)

	slot1 = FurnaceTreasureConfig.instance:getSpineRes(slot0.actId)

	if not slot0._uiSpine or string.nilorempty(slot1) then
		return
	end

	slot0._uiSpine:setResPath(slot1, slot0._onSpineLoaded, slot0)
end

function slot0.setDescList(slot0)
	gohelper.CreateObjList(slot0, slot0.onSetSingleDesc, FurnaceTreasureConfig.instance:getDescList(slot0.actId), slot0._goDecContent, slot0._txtDecItem.gameObject)
end

function slot0.onSetSingleDesc(slot0, slot1, slot2, slot3)
	if gohelper.isNil(slot1) then
		return
	end

	if slot1:GetComponent(gohelper.Type_TextMesh) then
		slot4.text = slot2
	end
end

function slot0.setRewardList(slot0)
	IconMgr.instance:getCommonPropItemIconList(slot0, slot0.onSetSingleReward, FurnaceTreasureConfig.instance:getRewardList(slot0.actId), slot0._gorewards)
end

function slot0.onSetSingleReward(slot0, slot1, slot2, slot3)
	if not slot2.quantity then
		slot2.quantity = 0
	end

	slot1:onUpdateMO(slot2)
	slot1:isShowEffect(true)
	slot1:setAutoPlay(true)
	slot1:isShowCount(false)
end

function slot0._onSpineLoaded(slot0)
	if not slot0._uiSpine then
		return
	end

	slot0._uiSpine:setImageUIMask(true)
	slot0._uiSpine:playVoice(FurnaceTreasureModel.instance:getSpinePlayData())
end

function slot0.refreshBuyCount(slot0)
	slot0._txtlimitbuy.text = formatLuaLang("remain_buy_count", FurnaceTreasureModel.instance:getTotalRemainCount(slot0.actId))
end

function slot0.refreshLimitTime(slot0)
	slot2 = formatLuaLang("cachotprogressview_remainDay", 0)

	if ActivityModel.instance:getActMO(slot0.actId) then
		slot2 = TimeUtil.SecondToActivityTimeFormat(slot1:getRealEndTimeStamp() - ServerTime.now())
	end

	slot0._txtLimitTime.text = string.format(luaLang("remain"), slot2)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.refreshLimitTime, slot0)
end

function slot0.onDestroyView(slot0)
	if slot0._uiSpine then
		slot0._uiSpine:doClear()
	end

	slot0._uiSpine = false
end

return slot0
