module("modules.logic.fight.view.cardeffect.FightCardChangeEffectInWaitingArea", package.seeall)

slot0 = class("FightCardChangeEffectInWaitingArea", BaseWork)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot0._paramDict = {}

	slot0:_playEffects()
	TaskDispatcher.runDelay(slot0._removeDownEffect, slot0, 1.2 / FightModel.instance:getUISpeed())
	TaskDispatcher.runDelay(slot0._delayDone, slot0, 1.5 / FightModel.instance:getUISpeed())
end

function slot0._playEffects(slot0)
	slot0._effectGOList = {}
	slot0._effectLoaderList = {}
	slot1 = {}
	slot2 = {}

	for slot6, slot7 in ipairs(slot0.context.changeInfos) do
		for slot11, slot12 in ipairs(slot0.context.cardItemList) do
			slot14 = FightCardModel.instance:getSkillPrevLvId(slot12.skillId)
			slot15 = FightCardModel.instance:getSkillNextLvId(slot12.skillId)

			if slot12.go.activeInHierarchy and slot14 and slot14 == slot7.targetSkillId then
				if not tabletool.indexOf(slot1, slot12) then
					table.insert(slot1, slot12)
					table.insert(slot2, slot7)
				end
			elseif slot13 and slot15 and slot15 == slot7.targetSkillId and not tabletool.indexOf(slot1, slot12) then
				table.insert(slot1, slot12)
				table.insert(slot2, slot7)
			end
		end
	end

	if #slot1 > 0 then
		for slot6, slot7 in ipairs(slot1) do
			slot8 = slot2[slot6]
			slot14 = PrefabInstantiate.Create(gohelper.findChild(slot7.go, "lvChangeEffect") or gohelper.create2d(slot12, "lvChangeEffect"))

			if FightCardModel.instance:getSkillLv(slot8.entityId, slot8.targetSkillId) ~= FightCardModel.instance:getSkillLv(slot7.entityId, slot7.skillId) then
				slot0._paramDict[slot14] = {
					newCardLevel = slot15,
					oldCardLevel = slot11
				}

				slot14:startLoad(slot11 < slot15 and FightPreloadOthersWork.LvUpEffectPath or FightPreloadOthersWork.LvDownEffectPath, slot0._onLvEffectLoaded, slot0)

				slot18 = MultiAbLoader.New()
				slot0._paramDict[slot18] = {
					newCardLevel = slot15,
					oldCardLevel = slot11,
					cardItem = slot7
				}

				slot18:addPath(slot11 < slot15 and ViewAnim.LvUpAnimPath or ViewAnim.LvDownAnimPath)
				slot18:startLoad(slot0._onLvAnimLoaded, slot0)

				slot0._animLoaderList = slot0._animLoaderList or {}

				table.insert(slot0._animLoaderList, slot18)
			else
				logError("手牌星级变更失败，等级相同：" .. slot7.skillId .. " -> " .. slot10)
			end

			table.insert(slot0._effectGOList, slot13)
			table.insert(slot0._effectLoaderList, slot14)

			slot7.op.skillId = slot10
		end
	else
		slot0:onDone(true)
	end
end

function slot0._onLvEffectLoaded(slot0, slot1)
	slot2 = slot0._paramDict[slot1]

	if slot2.oldCardLevel < slot2.newCardLevel then
		gohelper.setActive(gohelper.findChild(slot1:getInstGO(), "cardrising01"), slot3 == 2)
		gohelper.setActive(gohelper.findChild(slot1:getInstGO(), "cardrising02"), slot3 == 3)
	else
		gohelper.setActive(gohelper.findChild(slot1:getInstGO(), "starescending01"), slot3 == 1)
		gohelper.setActive(gohelper.findChild(slot1:getInstGO(), "starescending02"), slot3 == 2)
	end
end

function slot0._onLvAnimLoaded(slot0, slot1)
	slot2 = slot0._paramDict[slot1]
	slot4 = slot2.oldCardLevel

	gohelper.setActive(gohelper.findChild(slot2.cardItem.go, "star/star1"), slot2.newCardLevel == 1 or slot4 == 1)
	gohelper.setActive(gohelper.findChild(slot6, "star/star2"), slot3 == 2 or slot4 == 2)
	gohelper.setActive(gohelper.findChild(slot6, "star/star3"), slot3 == 3 or slot4 == 3)
	gohelper.onceAddComponent(gohelper.findChild(slot6, "lv1"), typeof(UnityEngine.UI.RectMask2D))
	gohelper.onceAddComponent(gohelper.findChild(slot6, "lv2"), typeof(UnityEngine.UI.RectMask2D))
	gohelper.onceAddComponent(gohelper.findChild(slot6, "lv3"), typeof(UnityEngine.UI.RectMask2D))
	gohelper.onceAddComponent(gohelper.findChild(slot6, "star/star1"), typeof(UnityEngine.CanvasGroup))
	gohelper.onceAddComponent(gohelper.findChild(slot6, "star/star2"), typeof(UnityEngine.CanvasGroup))
	gohelper.onceAddComponent(gohelper.findChild(slot6, "star/star3"), typeof(UnityEngine.CanvasGroup))

	if gohelper.findChild(slot5.go, "lock") and slot7.activeSelf then
		gohelper.setActive(slot7, false)

		slot0._lockGO = slot7
	end

	slot8 = nil
	slot9, slot10, slot11 = transformhelper.getLocalScale(slot5.tr.parent)
	slot12 = gohelper.onceAddComponent(slot6, typeof(UnityEngine.Animator))
	slot12.runtimeAnimatorController = nil
	slot12.runtimeAnimatorController = slot1:getFirstAssetItem():GetResource()
	slot12.speed = FightModel.instance:getUISpeed()

	slot12:Play(slot4 < slot3 and (slot9 == 1 and (slot3 == 2 and "fightcard_rising03" or "fightcard_rising4") or slot3 == 2 and "fightcard_rising01" or "fightcard_rising02") or slot9 == 1 and (slot3 == 1 and "fightcard_escending03" or "fightcard_escending04") or slot3 == 1 and "fightcard_escending01" or "fightcard_escending02", 0, 0)
	slot12:Update(0)

	slot0._animCompList = slot0._animCompList or {}

	table.insert(slot0._animCompList, slot12)
	gohelper.setActiveCanvasGroup(gohelper.findChild(slot6, "lv1"), slot3 == 1 or slot4 == 1)
	gohelper.setActiveCanvasGroup(gohelper.findChild(slot6, "lv2"), slot3 == 2 or slot4 == 2)
	gohelper.setActiveCanvasGroup(gohelper.findChild(slot6, "lv3"), slot3 == 3 or slot4 == 3)
end

function slot0._delayDone(slot0)
	if slot0._lockGO then
		gohelper.setActive(slot0._lockGO, true)

		slot0._lockGO = nil
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._removeDownEffect, slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	slot0:_removeDownEffect()
	slot0:_removeLvAnim()

	slot0._imgList = nil
	slot0._lockGO = nil
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

				gohelper.removeComponent(gohelper.findChild(slot5.gameObject, "lv1"), typeof(UnityEngine.UI.RectMask2D))
				gohelper.removeComponent(gohelper.findChild(slot5.gameObject, "lv2"), typeof(UnityEngine.UI.RectMask2D))
				gohelper.removeComponent(gohelper.findChild(slot5.gameObject, "lv3"), typeof(UnityEngine.UI.RectMask2D))
				gohelper.removeComponent(gohelper.findChild(slot5.gameObject, "star/star1"), typeof(UnityEngine.CanvasGroup))
				gohelper.removeComponent(gohelper.findChild(slot5.gameObject, "star/star2"), typeof(UnityEngine.CanvasGroup))
				gohelper.removeComponent(gohelper.findChild(slot5.gameObject, "star/star3"), typeof(UnityEngine.CanvasGroup))
			end
		end
	end

	slot0._animCompList = nil
end

return slot0
