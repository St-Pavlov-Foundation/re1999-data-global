module("modules.logic.fight.view.FightEnemyInfoView", package.seeall)

slot0 = class("FightEnemyInfoView", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.GMHideFightView, slot0._checkHideUI, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnCameraFocusChanged, slot0._onCameraFocusChanged, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyBattleOpenEnemyInfo, slot0.OnOpenEnemyInfo, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.GMHideFightView, slot0._checkHideUI, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnCameraFocusChanged, slot0._onCameraFocusChanged, slot0)
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyBattleOpenEnemyInfo, slot0.OnOpenEnemyInfo, slot0)
end

function slot0._editableInitView(slot0)
	slot0.enemyInfoBtn = gohelper.findChildButton(slot0.viewGO, "root/topLeftContent/enemyinfo/#btn_enemyinfo")
	slot0.enemyInfoGo = gohelper.findChild(slot0.viewGO, "root/topLeftContent/enemyinfo/")

	gohelper.setActive(slot0.enemyInfoGo, OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightBack) and not FightReplayModel.instance:isReplay() and GMFightShowState.leftMonster)

	if slot1 then
		slot0.enemyInfoBtn:AddClickListener(slot0.enemyInfoBtnOnClick, slot0)
	end
end

function slot0.OnOpenEnemyInfo(slot0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightBack) then
		slot0:enemyInfoBtnOnClick()
	end
end

function slot0._onCameraFocusChanged(slot0, slot1)
	slot0._isFocus = slot1
end

function slot0._checkHideUI(slot0)
	gohelper.setActive(slot0.enemyInfoGo, OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightBack) and not FightReplayModel.instance:isReplay() and GMFightShowState.leftMonster)
end

function slot0.enemyInfoBtnOnClick(slot0)
	if FightReplayModel.instance:isReplay() then
		return
	end

	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidLongPressCard) then
		return
	end

	if FightViewHandCard.blockOperate then
		return
	end

	if GuideModel.instance:isDoingFirstGuide() then
		logNormal("新手第一个指引不能长按查看详情")

		return
	end

	if FightModel.instance:isAuto() then
		return
	end

	if FightCardModel.instance:isCardOpEnd() then
		logNormal("出完牌了不能长按查看详情")

		return
	end

	if slot0._isFocus then
		logNormal("正在查看怪物详情，不给点")

		return
	end

	if not FightDataHelper.stageMgr:isFree() then
		return
	end

	slot0.viewContainer:openFightFocusView()
end

function slot0.onClose(slot0)
	slot0.enemyInfoBtn:RemoveClickListener()
end

return slot0
