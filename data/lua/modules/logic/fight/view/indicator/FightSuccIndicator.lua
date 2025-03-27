module("modules.logic.fight.view.indicator.FightSuccIndicator", package.seeall)

slot0 = class("FightSuccIndicator", FightIndicatorBaseView)
slot1 = "ui/viewres/versionactivity_1_2/versionactivity_1_2_successitem.prefab"

function slot0.initView(slot0, slot1, slot2, slot3)
	uv0.super.initView(slot0, slot1, slot2, slot3)

	slot0.goSuccContainer = gohelper.findChild(slot0.goIndicatorRoot, "success_indicator")
end

function slot0.startLoadPrefab(slot0)
	gohelper.setActive(slot0.goSuccContainer, true)

	slot0.loader = PrefabInstantiate.Create(slot0.goSuccContainer)

	slot0.loader:startLoad(uv0, slot0.onLoadCallback, slot0)
end

function slot0.onLoadCallback(slot0)
	slot0.loadDone = true
	slot0.instanceGo = slot0.loader:getInstGO()
	slot0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0.instanceGo)
	slot0.txtIndicatorProcess = gohelper.findChildText(slot0.instanceGo, "txt_itemProcess")
	slot0.txtIndicatorProcess.text = string.format("%d/%d", FightDataHelper.fieldMgr:getIndicatorNum(slot0.indicatorId), slot0.totalIndicatorNum)
end

function slot0.onIndicatorChange(slot0)
	if not slot0.loadDone then
		return
	end

	slot0:updateUI()
end

function slot0.updateUI(slot0)
	if not slot0.loadDone then
		return
	end

	slot0.txtIndicatorProcess.text = string.format("%d/%d", FightDataHelper.fieldMgr:getIndicatorNum(slot0.indicatorId), slot0.totalIndicatorNum)

	FightModel.instance:setWaitIndicatorAnimation(true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_triumph_dreamepilogue_collect)
	slot0.animatorPlayer:Play("add", slot0.onAddAnimationDone, slot0)
end

function slot0.onAddAnimationDone(slot0)
	if FightDataHelper.fieldMgr:getIndicatorNum(slot0.indicatorId) == slot0.totalIndicatorNum then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_triumph_dreamepilogue_achieve)
		slot0.animatorPlayer:Play("finish", slot0.onFinishAnimationDone, slot0)
	else
		FightController.instance:dispatchEvent(FightEvent.OnIndicatorAnimationDone)
	end
end

function slot0.onFinishAnimationDone(slot0)
	FightController.instance:dispatchEvent(FightEvent.OnIndicatorAnimationDone)
end

function slot0.onDestroy(slot0)
	if slot0.loader then
		slot0.loader:dispose()
	end

	uv0.super.onDestroy(slot0)
end

return slot0
