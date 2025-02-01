module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateEffectView", package.seeall)

slot0 = class("EliminateEffectView", BaseView)

function slot0.onInitView(slot0)
	slot0._goeffect = gohelper.findChild(slot0.viewGO, "#go_effect")
	slot0._godamages = gohelper.findChild(slot0.viewGO, "#go_damages")
	slot0._gohpFlys = gohelper.findChild(slot0.viewGO, "#go_hpFlys")
	slot0._goflyitem = gohelper.findChild(slot0.viewGO, "#go_flyitem")
	slot0._godamage = gohelper.findChild(slot0.viewGO, "#go_damage")
	slot0._txtdamage = gohelper.findChildText(slot0.viewGO, "#go_damage/#txt_damage")
	slot0._gohpFlyItem1 = gohelper.findChild(slot0.viewGO, "#go_hpFlyItem_1")
	slot0._gohpFlyItem2 = gohelper.findChild(slot0.viewGO, "#go_hpFlyItem_2")
	slot0._gohpFlyItem3 = gohelper.findChild(slot0.viewGO, "#go_hpFlyItem_3")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

slot1 = GameUtil.parseColor("#AACD70")
slot2 = GameUtil.parseColor("#E0551D")

function slot0._editableInitView(slot0)
	if slot0.flyItemPool == nil then
		slot0.flyItemPool = LuaObjPool.New(EliminateEnum.dieEffectCacheCount, function ()
			slot0 = gohelper.clone(uv0._goflyitem, uv0._goeffect, "FlyItem")

			gohelper.setActive(slot0, false)

			return slot0
		end, function (slot0)
			if not gohelper.isNil(slot0) then
				gohelper.setActive(slot0, false)
				gohelper.destroy(slot0)
			end
		end, function (slot0)
			if not gohelper.isNil(slot0) then
				gohelper.setActive(slot0, false)
			end
		end)
	end

	if slot0.damageItemPool == nil then
		slot0.damageItemPool = LuaObjPool.New(EliminateEnum.damageCacheCount, function ()
			slot0 = gohelper.clone(uv0._godamage, uv0._godamages, "damageItem")

			gohelper.setActive(slot0, false)

			return slot0
		end, function (slot0)
			if not gohelper.isNil(slot0) then
				gohelper.setActive(slot0, false)
				gohelper.destroy(slot0)
			end
		end, function (slot0)
			if not gohelper.isNil(slot0) then
				gohelper.setActive(slot0, false)
			end
		end)
	end

	if slot0.characterHpFlyItemPools == nil then
		slot0.characterHpFlyItemPools = {}
	end

	for slot4 = 1, 3 do
		slot0.characterHpFlyItemPools[slot4] = LuaObjPool.New(EliminateEnum.hpDamageCacheCount, function ()
			slot0 = gohelper.clone(uv0["_gohpFlyItem" .. uv1], uv0._gohpFlys, "hpFlyItem")

			gohelper.setActive(slot0, false)

			return slot0
		end, function (slot0)
			if not gohelper.isNil(slot0) then
				gohelper.setActive(slot0, false)
				gohelper.destroy(slot0)
			end
		end, function (slot0)
			if not gohelper.isNil(slot0) then
				gohelper.setActive(slot0, false)
			end
		end)
	end

	slot0._godamagesTr = slot0._godamages.transform
	slot0._goeffectTr = slot0._goeffect.transform
	slot0._gohpFlysTr = slot0._gohpFlys.transform
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(EliminateChessController.instance, EliminateChessEvent.ChessResourceFlyEffectPlay, slot0.playResourceFlyEffect, slot0)
	slot0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.PlayDamageEffect, slot0.playDamageEffect, slot0)
	slot0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.PlayCharacterDamageFlyEffect, slot0.playCharacterHpChange, slot0)
end

function slot0.onClose(slot0)
	slot0:removeEventCb(EliminateChessController.instance, EliminateChessEvent.ChessResourceFlyEffectPlay, slot0.playResourceFlyEffect, slot0)
	slot0:removeEventCb(EliminateTeamChessController.instance, EliminateChessEvent.PlayDamageEffect, slot0.playDamageEffect, slot0)
	slot0:removeEventCb(EliminateTeamChessController.instance, EliminateChessEvent.PlayCharacterDamageFlyEffect, slot0.playCharacterHpChange, slot0)
end

function slot0.onDestroyView(slot0)
	if slot0.flyItemPool then
		slot0.flyItemPool:dispose()

		slot0.flyItemPool = nil
	end
end

slot3 = ZProj.TweenHelper

function slot0.playResourceFlyEffect(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = slot0.flyItemPool:getObject()
	slot7 = slot6.transform
	slot8, slot9 = recthelper.worldPosToAnchorPosXYZ(slot2, slot3, 1, slot0._goeffectTr)

	recthelper.setAnchor(slot7, slot8, slot9)
	gohelper.setActive(slot6, true)

	slot10, slot11 = recthelper.worldPosToAnchorPosXYZ(slot4, slot5, 1, slot0._goeffectTr)

	uv0.DOAnchorPos(slot7, slot10, slot11, EliminateEnum.ResourceFlyTime, slot0.resourceFlyEnd, slot0, {
		item = slot6,
		resourceId = slot1
	}, EaseType.OutQuart)
end

function slot0.resourceFlyEnd(slot0, slot1)
	slot2 = slot1.item
	slot3 = slot1.resourceId

	if slot0.flyItemPool and not gohelper.isNil(slot2) then
		slot0.flyItemPool:putObject(slot2)
	end

	EliminateChessController.instance:dispatchEvent(EliminateChessEvent.ChessResourceFlyEffectPlayFinish, slot3)
end

function slot0.playDamageEffect(slot0, slot1, slot2, slot3, slot4)
	slot6 = slot0.damageItemPool:getObject().transform
	slot7 = EliminateTeamChessEnum.ChessDamageSize
	slot8 = EliminateTeamChessEnum.teamChessPowerJumpTime

	if EliminateTeamChessEnum.HpDamageType.Character == slot4 then
		slot7 = EliminateTeamChessEnum.CharacterHpDamageSize
		slot8 = EliminateTeamChessEnum.hpDamageJumpTime
	end

	if EliminateTeamChessEnum.HpDamageType.GrowUpToChess == slot4 then
		slot8 = EliminateTeamChessEnum.teamChessGrowUpToChangePowerJumpTime
	end

	slot9 = gohelper.findChildText(slot5, "#txt_damage")
	slot9.text = string.format(slot1 > 0 and "＋%d" or "－%d", math.abs(slot1))
	slot9.color = slot1 > 0 and uv0 or uv1
	slot9.fontSize = slot7
	slot11, slot12 = recthelper.worldPosToAnchorPosXYZ(slot2, slot3, 1, slot0._godamagesTr)

	recthelper.setAnchor(slot6, slot11, slot12)
	gohelper.setActive(slot5, true)
	uv2.DOHeight(slot6, recthelper.getHeight(slot6), slot8, slot0.playDamageEffectEnd, slot0, slot5)
end

function slot0.playDamageEffectEnd(slot0, slot1)
	if slot0.damageItemPool and not gohelper.isNil(slot1) then
		slot0.damageItemPool:putObject(slot1)
	end
end

slot4 = ZProj.TweenHelper

function slot0.playCharacterHpChange(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot7 = EliminateTeamChessModel.instance:calDamageGear(math.abs(slot2))

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_fire)

	slot9 = slot0.characterHpFlyItemPools[slot7]:getObject()
	slot10 = slot9.transform

	transformhelper.setEulerAngles(slot10, 0, 0, math.deg(math.atan2(slot6 - slot4, slot5 - slot3)) + 180)

	slot15, slot16 = recthelper.worldPosToAnchorPosXYZ(slot3, slot4, 1, slot0._gohpFlysTr)

	recthelper.setAnchor(slot10, slot15, slot16)
	gohelper.setActive(slot9, true)

	slot18, slot19 = recthelper.worldPosToAnchorPosXYZ(slot5, slot6, 1, slot0._gohpFlysTr)

	uv0.DOAnchorPos(slot10, slot18, slot19, EliminateTeamChessEnum.characterHpDamageFlyTime, nil, , , EaseType.OutQuart)
	uv0.DOHeight(slot10, recthelper.getHeight(slot10), EliminateTeamChessEnum.characterHpDamageFlyTimeTipHpChange, slot0.playCharacterHpChangeFlyEnd, slot0, {
		TeamType = slot1,
		Gear = slot7,
		ItemGo = slot9,
		diffValue = slot2
	}, EaseType.OutQuart)
end

function slot0.playCharacterHpChangeFlyEnd(slot0, slot1)
	slot2 = slot1.ItemGo
	slot3 = slot1.Gear
	slot4 = slot1.TeamType
	slot5 = slot1.diffValue

	if slot0.characterHpFlyItemPools and slot0.characterHpFlyItemPools[slot3] and not gohelper.isNil(slot2) then
		slot0.characterHpFlyItemPools[slot3]:putObject(slot2)
	end

	EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.CharacterHpDamageFlyEffectPlayFinish, slot4, slot5, slot3)
end

return slot0
