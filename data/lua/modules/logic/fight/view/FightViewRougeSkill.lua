module("modules.logic.fight.view.FightViewRougeSkill", package.seeall)

slot0 = class("FightViewRougeSkill", BaseViewExtended)
slot1 = {
	Expanding = 3,
	Simple = 1,
	Shrinking = 4,
	Detail = 2
}
slot0.SkillSimpleItemWidth = 72
slot0.BaseWidth = 156

function slot0.onInitView(slot0)
	slot0._rougeStyleIcon = gohelper.findChildImage(slot0.viewGO, "heroSkill/#go_simple/faction/#image_faction")
	slot0._rougeStyleIconDetail = gohelper.findChildImage(slot0.viewGO, "heroSkill/#go_detail/faction/#image_faction")
	slot0._txtNum = gohelper.findChildText(slot0.viewGO, "heroSkill/#go_simple/skillicon/#txt_simpleCurCount")
	slot0._txtNum1 = gohelper.findChildText(slot0.viewGO, "heroSkill/#go_detail/#txt_detailCurCount")
	slot0._txtmax = gohelper.findChildText(slot0.viewGO, "heroSkill/#go_simple/skillicon/max/txtmax")
	slot0._heroSkillGO = gohelper.findChild(slot0.viewGO, "heroSkill")
	slot0._state = uv0.Simple
	slot0._click = gohelper.getClick(gohelper.findChild(slot0._heroSkillGO, "#go_simple"))
	slot0._animator = slot0._heroSkillGO:GetComponent(typeof(UnityEngine.Animator))

	slot0:_onUpdateSpeed()

	slot0._detailClick = {}

	table.insert(slot0._detailClick, gohelper.getClick(gohelper.findChild(slot0._heroSkillGO, "#go_detail/skillDescContent/#go_skillDescItem1")))
	table.insert(slot0._detailClick, gohelper.getClick(gohelper.findChild(slot0._heroSkillGO, "#go_detail/skillDescContent/#go_skillDescItem2")))

	slot0._maxGO = gohelper.findChild(slot0.viewGO, "heroSkill/#go_simple/skillicon/max")
	slot0.rectTrSimpleBg = gohelper.findChildComponent(slot0.viewGO, "heroSkill/#go_simple/bg", gohelper.Type_RectTransform)
	slot0.goSimpleItem = gohelper.findChild(slot0.viewGO, "heroSkill/#go_simple/skillContent/skillitem")
	slot0.goDetailItem = gohelper.findChild(slot0.viewGO, "heroSkill/#go_detail/skillDescContent/detailitem")

	gohelper.setActive(slot0.goSimpleItem, false)
	gohelper.setActive(slot0.goDetailItem, false)

	slot0.skillItemList = {}
end

function slot0.addEvents(slot0)
	if not FightReplayModel.instance:isReplay() then
		slot0._click:AddClickListener(slot0._onClick, slot0)
		slot0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreenUp, slot0._onTouch, slot0)
	end

	slot0:addEventCb(FightController.instance, FightEvent.StartPlayClothSkill, slot0._onStartPlayClothSkill, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, slot0._onStartSequenceFinish, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, slot0._onRoundSequenceFinish, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, slot0._onClothSkillRoundSequenceFinish, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.SimulateClickClothSkillIcon, slot0._simulateClickClothSkillIcon, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.StartReplay, slot0._checkStartReplay, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnUpdateSpeed, slot0._onUpdateSpeed, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.RougeCoinChange, slot0._onRougeCoinChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.RougeMagicChange, slot0._onRougeMagicChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.RougeMagicLimitChange, slot0._onRougeMagicLimitChange, slot0)
end

function slot0.removeEvents(slot0)
	TaskDispatcher.cancelTask(slot0._delayDealTouch, slot0)
	TaskDispatcher.cancelTask(slot0._sendUseClothSkillRequest, slot0)

	slot4 = slot0

	TaskDispatcher.cancelTask(slot0._setState, slot4)
	slot0._click:RemoveClickListener()

	for slot4, slot5 in ipairs(slot0.skillItemList) do
		slot5.detailItem.click:RemoveClickListener()
	end
end

function slot0.getSkillItem(slot0, slot1)
	if slot1 <= #slot0.skillItemList then
		return slot0.skillItemList[slot1]
	end

	return slot0:createSkillItem(slot1)
end

function slot0.createSkillItem(slot0, slot1)
	slot2 = {
		simpleItem = slot0:createSimpleItem(),
		detailItem = slot0:createDetailItem(slot1)
	}

	table.insert(slot0.skillItemList, slot2)

	return slot2
end

function slot0.createSimpleItem(slot0)
	slot1 = slot0:getUserDataTb_()
	slot1.go = gohelper.cloneInPlace(slot0.goSimpleItem)
	slot1.imageNotCost = gohelper.findChildImage(slot1.go, "notcost")
	slot1.imageCanCost = gohelper.findChildImage(slot1.go, "cancost")
	slot1.goNotCost = slot1.imageNotCost.gameObject
	slot1.goCanCost = slot1.imageCanCost.gameObject

	gohelper.setActive(slot1.go, true)

	return slot1
end

function slot0.createDetailItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = gohelper.cloneInPlace(slot0.goDetailItem)
	slot2.txtDesc = gohelper.findChildText(slot2.go, "desc")
	slot2.imageNotCost = gohelper.findChildImage(slot2.go, "skill/notcost")
	slot2.imageCanCost = gohelper.findChildImage(slot2.go, "skill/cancost")
	slot2.goNotCost = slot2.imageNotCost.gameObject
	slot2.goCanCost = slot2.imageCanCost.gameObject
	slot2.click = gohelper.getClickWithDefaultAudio(slot2.go)

	gohelper.setActive(slot2.go, true)
	slot2.click:AddClickListener(slot0._onClickSkillIcon, slot0, slot1)

	return slot2
end

function slot0._onStartSequenceFinish(slot0)
	slot0:_updateUI()
	slot0:_checkPlayPowerMaxAudio()
	slot0:_shrinkDetailUI()
end

function slot0._onRougeCoinChange(slot0)
	slot0:_updateUI()
end

function slot0._onRougeMagicChange(slot0)
	slot0:_updateUI()
end

function slot0._onRougeMagicLimitChange(slot0)
	slot0:_updateUI()
end

function slot0._onClick(slot0)
	if FightCardModel.instance:isCardOpEnd() then
		return
	end

	if slot0._state == uv0.Simple then
		slot0._animator:Play("fight_heroskill_tips", 0, 0)
		slot0._animator:Update(0)

		slot0._state = uv0.Expanding

		TaskDispatcher.runDelay(slot0._setState, slot0, 0.533)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_shuffle_unfold)
		FightController.instance:dispatchEvent(FightEvent.OnClothSkillExpand)
	end
end

function slot0._setState(slot0)
	if slot0._state == uv0.Expanding then
		slot0._state = uv0.Detail
	elseif slot0._state == uv0.Shrinking then
		slot0._state = uv0.Simple
	end
end

function slot0._onTouch(slot0)
	if slot0._state == uv0.Detail then
		TaskDispatcher.runDelay(slot0._delayDealTouch, slot0, 0.01)
	end
end

function slot0._delayDealTouch(slot0)
	if not slot0._hasClickDetailIcon then
		slot0:_shrinkDetailUI()
	end

	slot0._hasClickDetailIcon = nil
end

function slot0._shrinkDetailUI(slot0)
	slot0._animator:Play("fight_heroskill_out", 0, 0)
	slot0._animator:Update(0)

	slot0._state = uv0.Shrinking

	TaskDispatcher.runDelay(slot0._setState, slot0, 0.533)
	FightController.instance:dispatchEvent(FightEvent.OnClothSkillShrink)
end

function slot0.onOpen(slot0)
	slot0:_updateUI()
	slot0:_checkStartReplay()
end

function slot0._onUpdateSpeed(slot0)
	slot0._animator.speed = FightModel.instance:getUISpeed()
end

function slot0._checkStartReplay(slot0)
	if FightReplayModel.instance:isReplay() then
		slot0._click:RemoveClickListener()

		for slot4, slot5 in ipairs(slot0._detailClick) do
			slot5:RemoveClickListener()
		end

		slot0:removeEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreen, slot0._onTouch, slot0)
	end
end

function slot0._getClothLevelCO(slot0)
	if not RougeModel.instance:getRougeInfo() then
		return
	end

	if not FightModel.instance.clothId then
		return
	end

	return lua_rouge_style.configDict[slot1.season] and lua_rouge_style.configDict[slot1.season][slot2]
end

function slot0._onStartPlayClothSkill(slot0)
	gohelper.setActive(slot0.viewGO, false)
end

function slot0._onRoundSequenceFinish(slot0)
	slot0:_onClothSkillRoundSequenceFinish()
end

function slot0._onClothSkillRoundSequenceFinish(slot0)
	gohelper.setActive(slot0.viewGO, true)
	slot0:_updateUI()
	slot0:_checkPlayPowerMaxAudio()
	slot0:_shrinkDetailUI()
end

function slot0._canUseAnySkill(slot0)
	slot1 = FightModel.instance:getClothSkillList()

	for slot5 = 1, 2 do
		if slot1 and slot1[slot5] then
			return slot0:_canUseSkill(slot6)
		end
	end
end

function slot0._canUseSkill(slot0, slot1)
	if lua_rouge_active_skill.configDict[slot1.skillId] then
		slot3 = true

		if slot1.cd > 0 then
			slot3 = false
		end

		if slot0:_getMagic() < slot2.powerCost then
			slot3 = false
		end

		if slot0:_getCoint() < slot2.coinCost then
			slot3 = false
		end

		return slot3
	end
end

function slot0._getMagic(slot0)
	return FightModel.instance:getRougeExData(FightEnum.ExIndexForRouge.Magic)
end

function slot0._getCoint(slot0)
	return FightModel.instance:getRougeExData(FightEnum.ExIndexForRouge.Coin)
end

function slot0._updateUI(slot0)
	if not FightModel.instance:getClothSkillList() or #slot1 < 1 then
		gohelper.setActive(slot0.viewGO, false)

		return
	end

	gohelper.setActive(slot0.viewGO, true)

	if lua_rouge_style.configDict[RougeModel.instance:getSeason()] and slot2[FightModel.instance.clothId] then
		UISpriteSetMgr.instance:setRouge2Sprite(slot0._rougeStyleIcon, slot2.icon .. "_light")
		UISpriteSetMgr.instance:setRouge2Sprite(slot0._rougeStyleIconDetail, slot2.icon .. "_light")
	end

	for slot6, slot7 in ipairs(slot1) do
		if lua_rouge_active_skill.configDict[slot7.skillId] then
			slot9 = slot0:getSkillItem(slot6)
			slot10 = slot8.icon

			UISpriteSetMgr.instance:setRouge2Sprite(slot9.simpleItem.imageNotCost, slot10)
			UISpriteSetMgr.instance:setRouge2Sprite(slot9.simpleItem.imageCanCost, slot10)
			UISpriteSetMgr.instance:setRouge2Sprite(slot9.detailItem.imageNotCost, slot10)
			UISpriteSetMgr.instance:setRouge2Sprite(slot9.detailItem.imageCanCost, slot10)

			slot11 = slot0:_canUseSkill(slot7)

			gohelper.setActive(slot9.simpleItem.goNotCost, not slot11)
			gohelper.setActive(slot9.simpleItem.goCanCost, slot11)
			gohelper.setActive(slot9.detailItem.goNotCost, not slot11)
			gohelper.setActive(slot9.detailItem.goCanCost, slot11)

			slot9.detailItem.txtDesc.text = slot8.desc .. "\nCOST<color=#FFA500>-" .. slot8.powerCost .. "</color>"
		else
			logError("流派技能配置不存在,技能id = " .. slot7.skillId)
		end
	end

	recthelper.setWidth(slot0.rectTrSimpleBg, uv0.BaseWidth + #slot1 * uv0.SkillSimpleItemWidth)

	slot4 = slot0:_getMagic()

	if slot0:_getClothLevelCO() then
		slot0._txtNum.text = slot4
		slot0._txtNum1.text = slot4
		slot0._txtmax.text = slot5.powerLimit

		gohelper.setActive(slot0._maxGO, slot4 > 0 and slot4 == slot6)
	else
		slot0._txtNum.text = slot4
		slot0._txtNum1.text = slot4
		slot0._txtmax.text = ""

		gohelper.setActive(slot0._maxGO, false)
	end
end

function slot0._checkPlayPowerMaxAudio(slot0)
	slot4 = slot0:_getClothLevelCO() and slot2.powerLimit or 0
	slot3 = Mathf.Clamp(slot0:_getMagic(), 0, slot4)

	if (slot0._prevPower or 0) < slot4 and slot3 > 0 and slot3 == slot4 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_clothskill_power_max)
	end

	slot0._prevPower = slot3
end

function slot0._onClickSkillIcon(slot0, slot1)
	slot0._hasClickDetailIcon = true

	if FightCardModel.instance:isCardOpEnd() then
		return
	end

	if FightViewHandCard.blockOperate or FightModel.instance:isAuto() then
		return
	end

	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		return
	end

	if #FightCardModel.instance:getCardOps() > 0 then
		GameFacade.showToast(ToastEnum.RougeSkillNeedCancelOperation)

		return
	end

	slot4 = slot0:_getMagic()
	slot5 = FightModel.instance:getClothSkillList() and slot3[slot1]
	slot0._toUseSkillId = slot5 and slot5.skillId

	if slot5.cd > 0 then
		GameFacade.showToast(ToastEnum.UseSkill2)

		return
	end

	slot6 = lua_rouge_active_skill.configDict[slot5.skillId]

	if not slot0._toUseSkillId or slot4 < slot6.powerCost then
		GameFacade.showToast(ToastEnum.RougeSkillMagicNotEnough)

		return
	end

	if not slot0._toUseSkillId or slot0:_getCoint() < slot6.coinCost then
		GameFacade.showToast(ToastEnum.RougeSkillCoinNotEnough)

		return
	end

	if lua_skill.configDict[slot0._toUseSkillId] and FightEnum.ShowLogicTargetView[slot8.logicTarget] and slot8.targetLimit == FightEnum.TargetLimit.MySide then
		ViewMgr.instance:openView(ViewName.FightSkillTargetView, {
			skillId = slot0._toUseSkillId,
			callback = slot0._selectCallback,
			callbackObj = slot0
		})
	else
		slot0._fromId = nil
		slot0._toId = FightCardModel.instance.curSelectEntityId

		slot0:_sendUseClothSkill()
	end
end

function slot0._selectCallback(slot0, slot1)
	slot0._state = uv0.Simple
	slot0._fromId = nil
	slot0._toId = slot1

	slot0:_sendUseClothSkill()
end

function slot0._sendUseClothSkill(slot0)
	TaskDispatcher.runDelay(slot0._sendUseClothSkillRequest, slot0, 0.33)
	slot0:_blockClick()
end

function slot0._sendUseClothSkillRequest(slot0)
	FightRpc.instance:sendUseClothSkillRequest(slot0._toUseSkillId, slot0._fromId, slot0._toId, FightEnum.ClothSkillType.Rouge)
end

function slot0._blockClick(slot0)
	UIBlockMgr.instance:endAll()

	UIBlockMgrExtend.CircleMvDelay = 10

	UIBlockMgr.instance:startBlock(UIBlockKey.PlayClothSkill)
	slot0:addEventCb(FightController.instance, FightEvent.RespUseClothSkillFail, slot0._cancelBlock, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, slot0._cancelBlock, slot0)
end

function slot0._cancelBlock(slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.RespUseClothSkillFail, slot0._cancelBlock, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, slot0._cancelBlock, slot0)

	UIBlockMgrExtend.CircleMvDelay = nil

	UIBlockMgr.instance:endBlock(UIBlockKey.PlayClothSkill)
end

function slot0._simulateClickClothSkillIcon(slot0, slot1)
	if slot1 and slot1.skillId then
		for slot7, slot8 in ipairs(FightModel.instance:getClothSkillList()) do
			if slot8.skillId == slot2 then
				slot0:_onClickSkillIcon(slot7)

				return
			end
		end

		logError("主角技能不存在：" .. slot2 .. ", " .. cjson.encode(slot3))
	end
end

return slot0
