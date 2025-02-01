module("modules.logic.fight.view.cardeffect.FightCardChangeEffect", package.seeall)

slot0 = class("FightCardChangeEffect", BaseWork)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot0._paramDict = {}

	slot0:_playEffects()
	TaskDispatcher.runDelay(slot0._delayDone, slot0, FightEnum.PerformanceTime.CardLevelChange / FightModel.instance:getUISpeed())
end

function slot0._playEffects(slot0)
	slot0._effectGOList = {}
	slot0._effectLoaderList = {}
	slot0._entityId = slot0.context.entityId
	slot0._skillId = slot0.context.skillId
	slot0._changeFailType = slot0.context.failType
	slot0._paramDict[PrefabInstantiate.Create(gohelper.create2d(slot0.context.cardItem.go, "lvChangeEffect"))] = {
		newCardLevel = slot0.context.newCardLevel,
		oldCardLv = slot0.context.oldCardLevel
	}
	slot7 = nil

	slot6:startLoad(slot0._changeFailType and (slot0._changeFailType == FightEnum.CardRankChangeFail.UpFail and FightPreloadOthersWork.LvUpEffectPath or FightPreloadOthersWork.LvDownEffectPath) or slot2 < slot3 and FightPreloadOthersWork.LvUpEffectPath or FightPreloadOthersWork.LvDownEffectPath, slot0._onLvEffectLoaded, slot0)

	slot8 = nil
	slot9 = MultiAbLoader.New()
	slot0._paramDict[slot9] = {
		newCardLevel = slot3,
		oldCardLv = slot2,
		cardItem = slot1
	}

	slot9:addPath(slot0._changeFailType and (slot0._changeFailType == FightEnum.CardRankChangeFail.UpFail and ViewAnim.LvUpAnimPath or ViewAnim.LvDownAnimPath) or slot2 < slot3 and ViewAnim.LvUpAnimPath or ViewAnim.LvDownAnimPath)
	slot9:startLoad(slot0._onLvAnimLoaded, slot0)

	slot0._animLoaderList = slot0._animLoaderList or {}

	table.insert(slot0._animLoaderList, slot9)
	table.insert(slot0._effectGOList, slot5)
	table.insert(slot0._effectLoaderList, slot6)
end

function slot0._onLvEffectLoaded(slot0, slot1)
	gohelper.onceAddComponent(slot1:getInstGO(), typeof(ZProj.EffectTimeScale)):SetTimeScale(FightModel.instance:getUISpeed())

	slot2 = slot0._paramDict[slot1]
	slot5 = FightCardModel.instance:isUniqueSkill(slot0._entityId, slot0._skillId)
	slot6 = slot1:getInstGO()

	gohelper.setActive(gohelper.findChild(slot6, "#card/normal_effect"), not slot5)
	gohelper.setActive(gohelper.findChild(slot6, "#card/ultimate_effect"), slot5)

	for slot15 = 0, gohelper.findChild(slot6, "#star").transform.childCount - 1 do
		if slot9:GetChild(slot15) then
			gohelper.setActive(slot16.gameObject, slot16.name == slot2.oldCardLv .. "_" .. slot2.newCardLevel)
		end
	end
end

function slot0._onLvAnimLoaded(slot0, slot1)
	slot2 = slot0._paramDict[slot1]
	slot4 = slot2.oldCardLv

	gohelper.setActive(gohelper.findChild(slot2.cardItem.go, "star/star1"), slot2.newCardLevel == 1 or slot4 == 1)
	gohelper.setActive(gohelper.findChild(slot6, "star/star2"), slot3 == 2 or slot4 == 2)
	gohelper.setActive(gohelper.findChild(slot6, "star/star3"), slot3 == 3 or slot4 == 3)

	for slot10, slot11 in ipairs(slot5._lvGOs) do
		gohelper.setActiveCanvasGroup(slot11, slot3 == slot10 or slot4 == slot10)
	end

	slot7 = nil

	if slot0._changeFailType then
		-- Nothing
	elseif slot4 < slot3 then
		slot7 = "fightcard_rising" .. slot4 .. "_" .. slot3
	else
		slot7 = "fightcard_escending" .. slot4 .. "_" .. slot3
	end

	if slot7 then
		slot8 = gohelper.onceAddComponent(slot6, typeof(UnityEngine.Animator))
		slot8.runtimeAnimatorController = nil
		slot8.runtimeAnimatorController = slot1:getFirstAssetItem():GetResource()
		slot8.speed = FightModel.instance:getUISpeed()
		slot8.enabled = true

		slot8:Play(slot7, 0, 0)
		slot8:Update(0)

		slot0._animCompList = slot0._animCompList or {}

		table.insert(slot0._animCompList, slot8)
	end
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._removeDownEffect, slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	slot0:_removeDownEffect()
	slot0:_removeLvAnim()

	slot0._imgMaskMatDict = nil
	slot0._imgList = nil
	slot0._paramDict = nil
end

function slot0._removeDownEffect(slot0)
	if slot0._effectLoaderList then
		for slot4, slot5 in ipairs(slot0._effectLoaderList) do
			slot5:dispose()
		end
	end

	if slot0._effectGOList then
		for slot4, slot5 in ipairs(slot0._effectGOList) do
			gohelper.destroy(slot5)
		end
	end

	slot0._effectGOList = nil
	slot0._effectLoaderList = nil
end

function slot0._removeLvAnim(slot0)
	if slot0._animLoaderList then
		for slot4, slot5 in ipairs(slot0._animLoaderList) do
			slot5:dispose()
		end
	end

	slot0._animLoaderList = nil

	if slot0._animCompList then
		for slot4, slot5 in ipairs(slot0._animCompList) do
			if not gohelper.isNil(slot5) then
				slot5.runtimeAnimatorController = nil
			end
		end
	end

	slot0._animCompList = nil
end

return slot0
