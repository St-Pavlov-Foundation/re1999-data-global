module("modules.logic.fight.view.assistboss.FightAssistBossBase", package.seeall)

slot0 = class("FightAssistBossBase", UserDataDispose)
slot0.InCDColor = Color(0.5019607843137255, 0.5019607843137255, 0.5019607843137255)

function slot0.init(slot0, slot1)
	slot0:__onInit()

	slot0.goContainer = slot1
	slot0.loadDone = false

	slot0:setPrefabPath()
	slot0:loadRes()
end

function slot0.setPrefabPath(slot0)
	slot0.prefabPath = "ui/viewres/assistboss/boss0.prefab"
end

function slot0.loadRes(slot0)
	slot0.loader = PrefabInstantiate.Create(slot0.goContainer)

	slot0.loader:startLoad(slot0.prefabPath, slot0.onResLoaded, slot0)
end

function slot0.onResLoaded(slot0)
	slot0.loadDone = true
	slot0.viewGo = slot0.loader:getInstGO()

	slot0:initView()
	slot0:addEvents()
	slot0:refreshUI()
end

function slot0.initView(slot0)
	slot0.headImage = gohelper.findChildImage(slot0.viewGo, "head/boss")
	slot0.headSImage = gohelper.findChildSingleImage(slot0.viewGo, "head/boss")
	slot0.goCD = gohelper.findChild(slot0.viewGo, "cd")
	slot0.txtCD = gohelper.findChildText(slot0.viewGo, "cd/cdbg/#txt_cd")
	slot0.longListener = SLFramework.UGUI.UILongPressListener.Get(gohelper.findChild(slot0.viewGo, "clickarea"))

	slot0.longListener:SetLongPressTime({
		0.5,
		99999
	})
	slot0.longListener:AddLongPressListener(slot0.onLongPress, slot0)
	slot0.longListener:AddClickListener(slot0.playAssistBossCard, slot0)
end

function slot0.addEvents(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnAssistBossPowerChange, slot0.onAssistBossPowerChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnAssistBossCDChange, slot0.onAssistBossCDChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.PowerChange, slot0.onPowerChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnResetCard, slot0.onResetCard, slot0)
end

function slot0.refreshUI(slot0)
	if not slot0.loadDone then
		return
	end

	slot0:refreshHeadImage()
	slot0:refreshPower()
	slot0:refreshCD()
end

function slot0.onAssistBossPowerChange(slot0)
	slot0:refreshPower()
end

function slot0.onAssistBossCDChange(slot0)
	slot0:refreshCD()
end

function slot0.onPowerChange(slot0, slot1, slot2, slot3, slot4)
	if slot2 ~= FightEnum.PowerType.AssistBoss then
		return
	end

	if not FightDataHelper.entityMgr:getAssistBoss() or slot5.id ~= slot1 then
		return
	end

	slot0:refreshPower()
end

function slot0.onResetCard(slot0)
	slot0:refreshPower()
	slot0:refreshCD()
end

function slot0.refreshHeadImage(slot0)
	slot0.headSImage:LoadImage(ResUrl.monsterHeadIcon(FightConfig.instance:getSkinCO(FightDataHelper.entityMgr:getAssistBoss().originSkin).headIcon))
end

function slot0.refreshPower(slot0)
	slot0:refreshHeadImageColor()
end

function slot0.checkInCd(slot0)
	return FightDataHelper.paTaMgr:getCurCD() and slot1 > 0
end

function slot0.refreshCD(slot0)
	slot1 = slot0:checkInCd()

	gohelper.setActive(slot0.goCD, slot1)

	if slot1 then
		slot0.txtCD.text = tostring(FightDataHelper.paTaMgr:getCurCD())
	end

	slot0:refreshHeadImageColor()
end

function slot0.refreshHeadImageColor(slot0)
	if not FightDataHelper.paTaMgr:getCurUseSkillInfo() then
		slot0.headImage.color = uv0.InCDColor

		return
	end

	if slot0:checkInCd() then
		slot0.headImage.color = uv0.InCDColor

		return
	end

	slot0.headImage.color = Color.white
end

function slot0.onLongPress(slot0)
	if FightModel.instance:getCurStage() == FightEnum.Stage.AutoCard then
		return
	end

	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		return
	end

	if FightCardModel.instance:isCardOpEnd() then
		return
	end

	if not FightDataHelper.paTaMgr:getCurUseSkillInfo() and not FightDataHelper.paTaMgr:getBossSkillInfoList()[1] then
		logError("boss not found any one skill!")

		return
	end

	if not lua_skill.configDict[slot1.skillId] then
		logError("long press assist boss, skill not exist !!! id : " .. tostring(slot2))

		return
	end

	slot0.tempInfo = slot0.tempInfo or {}

	tabletool.clear(slot0.tempInfo)

	slot0.tempSkillIdList = slot0.tempSkillIdList or {}

	tabletool.clear(slot0.tempSkillIdList)

	slot0.tempSkillIdList[1] = slot2
	slot0.tempInfo.super = slot3.isBigSkill == 1
	slot0.tempInfo.skillIdList = slot0.tempSkillIdList
	slot0.tempInfo.skillIndex = 1
	slot0.tempInfo.monsterName = FightDataHelper.entityMgr:getAssistBoss() and slot4:getEntityName() or ""

	ViewMgr.instance:openView(ViewName.SkillTipView, slot0.tempInfo)
end

function slot0.playAssistBossCard(slot0)
	if FightModel.instance:getCurStage() == FightEnum.Stage.AutoCard then
		return
	end

	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		return
	end

	if FightCardModel.instance:isCardOpEnd() then
		return
	end

	if not slot0:canUseSkill() then
		return
	end

	slot2 = FightCardModel.instance:playAssistBossHandCardOp(slot1.skillId)

	FightController.instance:dispatchEvent(FightEvent.AddPlayOperationData, slot2)
	FightController.instance:dispatchEvent(FightEvent.onNoActCostMoveFlowOver)
	FightController.instance:dispatchEvent(FightEvent.RefreshPlayCardRoundOp, slot2)
	FightController.instance:dispatchEvent(FightEvent.OnPlayAssistBossCardFlowDone, slot2)
	FightDataHelper.paTaMgr:playAssistBossSkill(slot1)
	FightController.instance:dispatchEvent(FightEvent.OnAssistBossPowerChange)
	FightController.instance:dispatchEvent(FightEvent.OnAssistBossCDChange)

	return true
end

function slot0.canUseSkill(slot0)
	if not FightDataHelper.paTaMgr:canUseSkill() then
		return
	end

	if FightDataHelper.paTaMgr:getCurCD() and slot1 > 0 then
		return
	end

	if not FightDataHelper.paTaMgr:getCurUseSkillInfo() then
		return
	end

	if FightDataHelper.paTaMgr:getAssistBossPower() < FightDataHelper.paTaMgr:getNeedPower(slot2) then
		return
	end

	return slot2
end

slot0.Duration = 0.5

function slot0.setFillAmount(slot0, slot1, slot2)
	slot0:killTween()

	if not slot1 then
		slot0.curImage = nil

		return
	end

	slot0.curImage = slot1
	slot0.tweenId = ZProj.TweenHelper.DOTweenFloat(slot1.fillAmount, slot2, uv0.Duration, slot0.onFrameCallback, nil, slot0, nil, EaseType.Linear)
end

function slot0.onFrameCallback(slot0, slot1)
	slot0.curImage.fillAmount = slot1
end

function slot0.killTween(slot0)
	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)
	end
end

function slot0.destroy(slot0)
	slot0:killTween()

	if slot0.headSImage then
		slot0.headSImage:UnLoadImage()
	end

	if slot0.loader then
		slot0.loader:dispose()

		slot0.loader = nil
	end

	if slot0.longListener then
		slot0.longListener:RemoveClickListener()
		slot0.longListener:RemoveLongPressListener()

		slot0.longListener = nil
	end

	slot0.loadDone = false

	slot0:__onDispose()
end

return slot0
