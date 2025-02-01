module("modules.logic.tips.view.FightFocusStressComp", package.seeall)

slot0 = class("FightFocusStressComp", UserDataDispose)
slot0.PrefabPath = FightNameUIStressMgr.PrefabPath

function slot0.init(slot0, slot1)
	slot0:__onInit()

	slot0.goStress = slot1

	slot0:loadPrefab()
end

function slot0.loadPrefab(slot0)
	slot0.loader = PrefabInstantiate.Create(slot0.goStress)

	slot0.loader:startLoad(uv0.PrefabPath, slot0.onLoadFinish, slot0)
end

function slot0.onLoadFinish(slot0)
	slot0.instanceGo = slot0.loader:getInstGO()

	slot0:initUI()

	slot0.loaded = true

	slot0:refreshStress(slot0.cacheEntityMo)

	slot0.cacheEntityMo = nil
end

function slot0.initUI(slot0)
	slot0.stressText = gohelper.findChildText(slot0.instanceGo, "#txt_stress")
	slot0.goBlue = gohelper.findChild(slot0.instanceGo, "blue")
	slot0.goRed = gohelper.findChild(slot0.instanceGo, "red")
	slot0.goBroken = gohelper.findChild(slot0.instanceGo, "broken")
	slot0.goStaunch = gohelper.findChild(slot0.instanceGo, "staunch")
	slot0.click = gohelper.findChildClickWithDefaultAudio(slot0.instanceGo, "#go_clickarea")

	slot0.click:AddClickListener(slot0.onClickStress, slot0)
	slot0:resetGo()

	slot0.statusDict = slot0:getUserDataTb_()
	slot0.statusDict[FightEnum.Status.Positive] = slot0.goBlue
	slot0.statusDict[FightEnum.Status.Negative] = slot0.goRed
end

function slot0.show(slot0)
	gohelper.setActive(slot0.instanceGo, true)
end

function slot0.hide(slot0)
	gohelper.setActive(slot0.instanceGo, false)
end

function slot0.resetGo(slot0)
	gohelper.setActive(slot0.goBlue, false)
	gohelper.setActive(slot0.goRed, false)
	gohelper.setActive(slot0.goBroken, false)
	gohelper.setActive(slot0.goStaunch, false)
end

function slot0.onClickStress(slot0)
	if not slot0.entityMo then
		return
	end

	if slot0.entityMo.side == FightEnum.EntitySide.MySide then
		StressTipController.instance:openHeroStressTip(slot0.entityMo:getCO())
	else
		StressTipController.instance:openMonsterStressTip(slot0.entityMo:getCO())
	end
end

function slot0.refreshStress(slot0, slot1)
	if not slot0.loaded then
		slot0.cacheEntityMo = slot1

		return
	end

	if not slot1 then
		slot0:hide()

		return
	end

	if not slot1:hasStress() then
		slot0:hide()

		return
	end

	slot0:show()
	slot0:resetGo()

	slot0.entityMo = slot1
	slot3 = slot1:getPowerInfo(FightEnum.PowerType.Stress) and slot2.num or 0
	slot0.stressText.text = slot3
	slot0.status = FightHelper.getStressStatus(slot3)

	gohelper.setActive(slot0.status and slot0.statusDict[slot0.status], true)
end

function slot0.destroy(slot0)
	slot0.click:RemoveClickListener()

	slot0.click = nil

	slot0.loader:dispose()

	slot0.loader = nil

	slot0:__onDispose()
end

return slot0
