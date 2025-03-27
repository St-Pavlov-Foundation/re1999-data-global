module("modules.logic.fight.view.FightAssistBossScoreView", package.seeall)

slot0 = class("FightAssistBossScoreView", UserDataDispose)
slot1 = "ui/viewres/assistboss/assistbossscore.prefab"

function slot0.init(slot0, slot1)
	slot0:__onInit()

	slot0.goAssistBossContainer = slot1

	slot0:addEventCb(FightController.instance, FightEvent.OnAssistBossScoreChange, slot0.onScoreChange, slot0)

	slot0.loadDone = false

	loadAbAsset(uv0, false, slot0.onLoadCallback, slot0)
end

function slot0.onLoadCallback(slot0, slot1)
	if slot1.IsLoadSuccess then
		slot0.loadDone = true
		slot0._assetItem = slot1

		slot0._assetItem:Retain()

		slot0.instanceGo = gohelper.clone(slot0._assetItem:GetResource(uv0), slot0.goAssistBossContainer)

		gohelper.setAsFirstSibling(slot0.instanceGo)

		slot0.txtScore = gohelper.findChildText(slot0.instanceGo, "Score/#txt_num")
		slot0.txtScore1 = gohelper.findChildText(slot0.instanceGo, "Score/#txt_num/#txt_num1")

		slot0:refreshScore()

		slot0.animation = slot0.txtScore.gameObject:GetComponent(typeof(UnityEngine.Animation))
	end
end

function slot0.refreshScore(slot0)
	if not slot0.loadDone then
		return
	end

	slot1 = FightDataHelper.fieldMgr:getIndicatorNum(slot0.indicatorId)
	slot0.txtScore.text = slot1
	slot0.txtScore1.text = slot1
end

slot0.Duration = 0.5

function slot0.onScoreChange(slot0, slot1, slot2)
	if not slot0.loadDone then
		return
	end

	slot0:killTween()

	slot0.tweenId = ZProj.TweenHelper.DOTweenFloat(slot1, slot2, uv0.Duration, slot0.onFrameCallback, nil, slot0, nil, EaseType.Linear)

	slot0.animation:Play()
end

function slot0.onFrameCallback(slot0, slot1)
	slot1 = math.floor(slot1)
	slot0.txtScore.text = slot1
	slot0.txtScore1.text = slot1
end

function slot0.killTween(slot0)
	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)
	end
end

function slot0.destroy(slot0)
	removeAssetLoadCb(uv0, slot0._onLoadCallback, slot0)

	if slot0._assetItem then
		slot0._assetItem:Release()

		slot0._assetItem = nil
	end

	slot0:killTween()
	slot0:__onDispose()
end

return slot0
