module("modules.logic.fight.entity.comp.FightNameUIStressMgr", package.seeall)

slot0 = class("FightNameUIStressMgr", UserDataDispose)
slot0.PrefabPath = "ui/viewres/fight/fightstressitem.prefab"
slot0.BehaviourAnimDuration = 1
slot0.Behaviour2AudioId = {
	[FightEnum.StressBehaviour.Meltdown] = 20211405,
	[FightEnum.StressBehaviour.Resolute] = 20211404
}

function slot0.initMgr(slot0, slot1, slot2)
	slot0:__onInit()

	slot0.goStress = slot1
	slot0.entity = slot2
	slot0.entityId = slot0.entity.id

	slot0:loadPrefab()
end

function slot0.loadPrefab(slot0)
	slot0.loader = PrefabInstantiate.Create(slot0.goStress)

	slot0.loader:startLoad(uv0.PrefabPath, slot0.onLoadFinish, slot0)
end

function slot0.onLoadFinish(slot0)
	slot0.instanceGo = slot0.loader:getInstGO()

	slot0:initUI()
	slot0:refreshUI()
	slot0:addCustomEvent()
end

function slot0.initUI(slot0)
	slot0.stressText = gohelper.findChildText(slot0.instanceGo, "#txt_stress")
	slot0.goBlue = gohelper.findChild(slot0.instanceGo, "blue")
	slot0.goRed = gohelper.findChild(slot0.instanceGo, "red")
	slot0.goBroken = gohelper.findChild(slot0.instanceGo, "broken")
	slot0.goStaunch = gohelper.findChild(slot0.instanceGo, "staunch")
	slot0.click = gohelper.findChildClickWithDefaultAudio(slot0.instanceGo, "#go_clickarea")

	slot0.click:AddClickListener(slot0.onClickStress, slot0)

	slot0.statusDict = {
		[FightEnum.Status.Positive] = slot0:createStatusItem(slot0.goBlue),
		[FightEnum.Status.Negative] = slot0:createStatusItem(slot0.goRed)
	}
	slot0.animGoDict = slot0:getUserDataTb_()
	slot0.animGoDict[FightEnum.StressBehaviour.Meltdown] = slot0.goBroken
	slot0.animGoDict[FightEnum.StressBehaviour.Resolute] = slot0.goStaunch
end

function slot0.createStatusItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = slot1
	slot2.txtStress = gohelper.findChildText(slot2.go, "add/#txt_stress")
	slot2.animator = slot2.go:GetComponent(gohelper.Type_Animator)

	return slot2
end

function slot0.onClickStress(slot0)
	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		return
	end

	if slot0.entity:getMO().side == FightEnum.EntitySide.MySide then
		StressTipController.instance:openHeroStressTip(slot2:getCO())
	else
		StressTipController.instance:openMonsterStressTip(slot2:getCO())
	end
end

function slot0.updateStatus(slot0)
	slot0:resetGo()

	slot0.status = FightHelper.getStressStatus(slot0:getCurStress())

	if slot0.status and slot0.statusDict[slot0.status] then
		gohelper.setActive(slot2.go, true)
	end
end

function slot0.refreshUI(slot0)
	slot0.stressText.text = slot0:getCurStress()

	slot0:updateStatus()
end

function slot0.addCustomEvent(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.PowerChange, slot0.onPowerChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.TriggerStressBehaviour, slot0.triggerStressBehaviour, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnStageChange, slot0.onStageChange, slot0)
end

function slot0.resetGo(slot0)
	gohelper.setActive(slot0.goBlue, false)
	gohelper.setActive(slot0.goRed, false)
	gohelper.setActive(slot0.goBroken, false)
	gohelper.setActive(slot0.goStaunch, false)
end

function slot0.onStageChange(slot0)
	ViewMgr.instance:closeView(ViewName.StressTipView)
end

function slot0.onPowerChange(slot0, slot1, slot2, slot3, slot4)
	if slot0.playBehaviouring then
		return
	end

	if slot0.entityId ~= slot1 then
		return
	end

	if FightEnum.PowerType.Stress ~= slot2 then
		return
	end

	if slot3 == slot4 then
		return
	end

	slot0:refreshUI()
	slot0:playStressValueChangeAnim()
end

function slot0.playStressValueChangeAnim(slot0)
	if slot0.playBehaviouring then
		return
	end

	if not slot0.status then
		return
	end

	if slot0.statusDict[slot0.status] then
		slot1.animator:Play("up", 0, 0)

		slot1.txtStress.text = slot0:getCurStress()
	else
		slot0:log(string.format("压力值item为nil。cur status : %s, cur stress : %s", slot0.status, slot0:getCurStress()))
	end
end

function slot0.triggerStressBehaviour(slot0, slot1, slot2)
	if slot0.entityId ~= slot1 then
		return
	end

	if FightEnum.StressBehaviour.Resolute ~= slot2 and FightEnum.StressBehaviour.Meltdown ~= slot2 then
		return
	end

	slot0:resetGo()

	slot4 = slot0.Behaviour2AudioId[slot2]

	if not slot0.animGoDict[slot2] then
		slot0:log(string.format("没找到对应行为动画节点，behaviour is : %s", slot2))

		slot3 = slot0.animGoDict[FightEnum.StressBehaviour.Meltdown]
		slot4 = slot0.Behaviour2AudioId[FightEnum.StressBehaviour.Meltdown]
	end

	slot0.playBehaviouring = true

	gohelper.setActive(slot3, true)
	FightAudioMgr.instance:playAudio(slot4)
	TaskDispatcher.runDelay(slot0.onBehaviourDone, slot0, uv0.BehaviourAnimDuration)
end

function slot0.onBehaviourDone(slot0)
	slot0.playBehaviouring = false

	slot0:refreshUI()
	slot0:playStressValueChangeAnim()
end

function slot0.getCurStress(slot0)
	return slot0.entity:getMO():getPowerInfo(FightEnum.PowerType.Stress) and slot2.num or 0
end

function slot0.log(slot0, slot1)
	logError(string.format("[%s] : %s", slot0.entity:getMO():getEntityName(), slot1))
end

function slot0.beforeDestroy(slot0)
	TaskDispatcher.cancelTask(slot0.onBehaviourDone, slot0)
	slot0.click:RemoveClickListener()

	slot0.click = nil

	slot0.loader:dispose()

	slot0.loader = nil

	slot0:__onDispose()
end

return slot0
