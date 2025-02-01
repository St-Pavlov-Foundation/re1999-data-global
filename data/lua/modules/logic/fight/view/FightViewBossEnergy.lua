module("modules.logic.fight.view.FightViewBossEnergy", package.seeall)

slot0 = class("FightViewBossEnergy", BaseViewExtended)

function slot0.ctor(slot0, slot1)
	slot0._bossEntityMO = slot1

	uv0.super.ctor(slot0)
end

function slot0.onInitView(slot0)
	slot0._imghpbar = gohelper.findChildImage(slot0.viewGO, "image_hpbarbg/image_hpbarfg")
	slot0._imgSignEnergyContainer = gohelper.findChild(slot0.viewGO, "image_hpbarbg/divide")
	slot0._imgSignEnergyItem = gohelper.findChild(slot0.viewGO, "image_hpbarbg/divide/#go_divide1")
	slot0._txtnum = gohelper.findChildTextMesh(slot0.viewGO, "image_hpbarbg/#txt_num")
	slot0._gomax = gohelper.findChild(slot0.viewGO, "image_hpbarbg/max")
	slot0._gobreak = gohelper.findChild(slot0.viewGO, "image_hpbarbg/breakthrough")
end

function slot0.addEvents(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.PowerChange, slot0._onPowerChange, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.PowerChange, slot0._onPowerChange, slot0)
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0._gobreak, false)

	slot2 = {}

	if not string.nilorempty(slot0._bossEntityMO:getCO().energySign) then
		slot2 = string.splitToNumber(slot1.energySign, "#")
	end

	gohelper.CreateObjList(slot0, slot0._bossEnergySignShow, slot2, slot0._imgSignEnergyContainer, slot0._imgSignEnergyItem)
	slot0:_setValue(slot0._bossEntityMO:getPowerInfo(FightEnum.PowerType.Energy).num / 1000, false)
end

function slot0._bossEnergySignShow(slot0, slot1, slot2, slot3)
	recthelper.setAnchorX(slot1.transform, slot2 / 1000 * recthelper.getWidth(slot1.transform.parent.parent))
end

function slot0._onPowerChange(slot0, slot1, slot2, slot3, slot4)
	if slot0._bossEntityMO.id == slot1 and FightEnum.PowerType.Energy == slot2 and slot3 ~= slot4 then
		slot0:_setValue(slot4 / 1000, true)
	end
end

function slot0._setValue(slot0, slot1, slot2)
	if slot2 then
		ZProj.TweenHelper.KillByObj(slot0._imghpbar)
		ZProj.TweenHelper.DOFillAmount(slot0._imghpbar, slot1, 0.2)
	else
		slot0._imghpbar.fillAmount = slot1
	end

	slot0._txtnum.text = string.format("%s%%", math.floor(slot1 * 1000) / 10)

	gohelper.setActive(slot0._gomax, slot1 == 1)
	gohelper.setActive(slot0._gobreak, slot1 > 1)
end

return slot0
