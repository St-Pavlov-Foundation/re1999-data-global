module("modules.logic.fight.view.FightPlayerFinisherSkillView", package.seeall)

slot0 = class("FightPlayerFinisherSkillView", FightBaseView)

function slot0.onInitView(slot0)
	slot0._click = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "skill/btn_skill")
	slot0._longPress = SLFramework.UGUI.UILongPressListener.Get(slot0._click.gameObject)
	slot0._used = gohelper.findChild(slot0.viewGO, "skill/melody/used")
	slot0._power = gohelper.findChild(slot0.viewGO, "skill/melody/power")
	slot0._noPower = gohelper.findChild(slot0.viewGO, "skill/melody/noPower")
	slot0._powerList = {}
	slot0._aniList = {}

	for slot5 = 0, 4 do
		slot6 = gohelper.findChild(slot0.viewGO, "skill/go_energy").transform:GetChild(slot5).gameObject

		table.insert(slot0._powerList, slot6)
		table.insert(slot0._aniList, gohelper.onceAddComponent(slot6, typeof(UnityEngine.Animator)))
	end

	slot0._tips = gohelper.findChild(slot0.viewGO, "skill/#go_skilltip")
	slot0._btnClose = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "skill/#go_skilltip/#btn_close")
	slot0._title = gohelper.findChildText(slot0.viewGO, "skill/#go_skilltip/bg/#txt_title")
	slot0._desc = gohelper.findChildText(slot0.viewGO, "skill/#go_skilltip/bg/#txt_dec")
end

function slot0.addEvents(slot0)
	slot0:com_registMsg(FightMsgId.RefreshPlayerFinisherSkill, slot0._onRefreshPlayerFinisherSkill)
	slot0:com_registFightEvent(FightEvent.PowerChange, slot0._onPowerChange)
	slot0:com_registFightEvent(FightEvent.PowerInfoChange, slot0._onPowerInfoChange)
	slot0:com_registFightEvent(FightEvent.StageChanged, slot0._onStageChanged)
	slot0:com_registFightEvent(FightEvent.CancelOperation, slot0._onCancelOperation)
	slot0:com_registFightEvent(FightEvent.TouchFightViewScreen, slot0._onTouchFightViewScreen)
	slot0:com_registClick(slot0._click, slot0._onClick)
	slot0:com_registLongPress(slot0._longPress, slot0._onLongPress)
	slot0:com_registClick(slot0._btnClose, slot0._onBtnClose)
end

function slot0._onTouchFightViewScreen(slot0)
	gohelper.setActive(slot0._tips, false)
end

function slot0._onBtnClose(slot0)
	gohelper.setActive(slot0._tips, false)
end

function slot0._onLongPress(slot0)
	if not FightDataHelper.stageMgr:isFree() then
		return
	end

	gohelper.setActive(slot0._tips, true)
end

function slot0._onCancelOperation(slot0)
	slot0:_refreshPower()
end

function slot0._onStageChanged(slot0)
	slot0:_refreshPower()
end

function slot0._canUse(slot0)
	if slot0:_getSkillData() then
		if not FightDataHelper.entityMgr:getById(FightEntityScene.MySideId) then
			return
		end

		if not slot2:getPowerInfo(FightEnum.PowerType.PlayerFinisherSkill) then
			return
		end

		slot0._curSkillId = slot1.skillId

		if FightDataHelper.fieldMgr.playerFinisherInfo.roundUseLimit <= (FightDataHelper.operationMgr.playerFinisherSkillUsedCount or 0) then
			return
		end

		slot6 = slot1.needPower

		if slot6 > slot3.num - slot5 * slot6 then
			return
		end

		return true, slot1
	end

	return false
end

function slot0._onClick(slot0)
	if not FightDataHelper.stageMgr:isFree() then
		return
	end

	if FightCardModel.instance:isCardOpEnd() then
		return
	end

	slot1, slot2 = slot0:_canUse()

	if slot1 then
		slot3 = slot2.skillId
		slot0._curSkillId = slot3
		slot7 = #FightDataHelper.entityMgr:getMyNormalList() + #FightDataHelper.entityMgr:getSpList(FightEnum.EntitySide.MySide)

		if lua_skill.configDict[slot3] and FightEnum.ShowLogicTargetView[slot4.logicTarget] and slot4.targetLimit == FightEnum.TargetLimit.MySide then
			if slot7 > 1 then
				ViewMgr.instance:openView(ViewName.FightSkillTargetView, {
					fromId = FightEntityScene.MySideId,
					skillId = slot3,
					callback = slot0._useSkill,
					callbackObj = slot0
				})

				return
			end

			if slot7 == 1 then
				slot0:_useSkill(slot5[1].id)

				return
			end
		end

		slot0:_useSkill(FightCardModel.instance.curSelectEntityId)
	end
end

function slot0._useSkill(slot0, slot1)
	slot0:_playAudio(20249031)

	slot2 = FightCardModel.instance:playPlayerFinisherSkill(slot0._curSkillId, slot1)

	FightController.instance:dispatchEvent(FightEvent.AddPlayOperationData, slot2)
	FightController.instance:dispatchEvent(FightEvent.onNoActCostMoveFlowOver)
	FightController.instance:dispatchEvent(FightEvent.RefreshPlayCardRoundOp, slot2)
	FightController.instance:dispatchEvent(FightEvent.OnPlayCardFlowDone, slot2)

	FightDataHelper.operationMgr.playerFinisherSkillUsedCount = (FightDataHelper.operationMgr.playerFinisherSkillUsedCount or 0) + 1

	slot0:_refreshPower()
end

function slot0._onRefreshPlayerFinisherSkill(slot0)
	slot0:_initSkill()
	slot0:_refreshPower()
	slot0:_playChangeAudio()
end

function slot0.onOpen(slot0)
	slot0:_initSkill()
	slot0:_refreshPower()
	slot0:_playChangeAudio()
end

function slot0._playChangeAudio(slot0)
	if slot0:_canUse() ~= slot0._lastCanUse then
		slot0._lastCanUse = slot1

		slot0:_playAudio(slot0._lastCanUse and 20249032 or 20249030)
	end
end

function slot0._initSkill(slot0)
	if slot0:_getSkillData() then
		slot2 = lua_skill.configDict[slot1.skillId]
		slot0._title.text = slot2.name
		slot0._desc.text = HeroSkillModel.instance:skillDesToSpot(FightConfig.instance:getEntitySkillDesc(FightEntityScene.MySideId, slot2, slot1.skillId), "#c56131", "#7c93ad")
	end
end

function slot0._getSkillData(slot0)
	return FightDataHelper.fieldMgr.playerFinisherInfo and slot1.skills[1]
end

function slot0._refreshPower(slot0)
	slot1 = slot0:_getSkillData()

	if FightDataHelper.entityMgr:getById(FightEntityScene.MySideId) and slot2:getPowerInfo(FightEnum.PowerType.PlayerFinisherSkill) then
		gohelper.setActive(slot0.viewGO, true)

		slot4 = FightDataHelper.operationMgr.playerFinisherSkillUsedCount or 0
		slot8 = slot3.num - slot4 * (slot1 and slot1.needPower or 0)

		gohelper.setActive(slot0._used, slot4 > 0)
		gohelper.setActive(slot0._power, slot4 <= 0 and slot8 > 0)
		gohelper.setActive(slot0._noPower, slot4 <= 0 and slot8 <= 0)

		for slot12, slot13 in ipairs(slot0._powerList) do
			gohelper.setActive(slot13, slot12 <= slot3.max)
			gohelper.setActive(gohelper.findChild(slot13, "light"), slot12 <= slot7)
			slot0._aniList[slot12]:Play(slot12 <= slot8 and "idle" or "flash", -1, 0)
		end
	else
		gohelper.setActive(slot0.viewGO, false)
	end
end

function slot0._playAudio(slot0, slot1)
	AudioMgr.instance:trigger(slot1)
end

function slot0._onPowerChange(slot0, slot1, slot2, slot3, slot4)
	if slot1 == FightEntityScene.MySideId and slot2 == FightEnum.PowerType.PlayerFinisherSkill then
		slot0:_refreshPower()

		if slot3 < slot4 then
			for slot8 = slot3 + 1, slot4 do
				slot0._aniList[slot8]:Play("add")
			end

			slot0:_playAudio(20249033)
		end

		slot0:_playChangeAudio()
	end
end

function slot0._onPowerInfoChange(slot0, slot1, slot2)
	if slot1 == FightEntityScene.MySideId and slot2 == FightEnum.PowerType.PlayerFinisherSkill then
		slot0:_refreshPower()
		slot0:_playChangeAudio()
	end
end

return slot0
