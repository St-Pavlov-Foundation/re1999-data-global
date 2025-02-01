module("modules.logic.fight.entity.comp.specialeffect.FightEntitySpecialEffect3079_Buff", package.seeall)

slot0 = class("FightEntitySpecialEffect3079_Buff", FightEntitySpecialEffectBase)

function slot0.initClass(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, slot0._onBuffUpdate, slot0)

	slot0._showBuffIdList = {}
end

slot1 = 1.5
slot2 = 0.9
slot3 = {
	[30790201] = {
		"v1a4_6/6_innate2_01"
	},
	[30790202] = {
		"v1a4_6/6_innate2_02"
	},
	[30790203] = {
		"v1a4_6/6_innate2_03"
	},
	[30790204] = {
		"v1a4_6/6_innate2_04"
	},
	[30790205] = {
		"v1a4_6/6_innate2_05"
	},
	[30790206] = {
		"v1a4_6/6_innate2_06"
	},
	[30790101] = {
		"v1a4_6/6_innate3_01"
	},
	[30790102] = {
		"v1a4_6/6_innate3_02"
	},
	[30790103] = {
		"v1a4_6/6_innate3_03"
	},
	[30790104] = {
		"v1a4_6/6_innate3_04"
	},
	[30790105] = {
		"v1a4_6/6_innate3_05"
	},
	[30790106] = {
		"v1a4_6/6_innate3_06"
	},
	[30790304] = {
		"v1a4_6/6_innate3_01"
	},
	[30790305] = {
		"v1a4_6/6_innate3_02"
	},
	[30790306] = {
		"v1a4_6/6_innate3_03"
	},
	[30790307] = {
		"v1a4_6/6_innate3_04"
	},
	[30790308] = {
		"v1a4_6/6_innate3_05"
	},
	[30790309] = {
		"v1a4_6/6_innate3_06"
	}
}

function slot0._onBuffUpdate(slot0, slot1, slot2, slot3, slot4)
	if slot1 ~= slot0._entity.id then
		return
	end

	if uv0[slot3] and slot2 == FightEnum.EffectType.BUFFADD then
		table.insert(slot0._showBuffIdList, slot3)

		if not slot0._playing then
			slot0:_showBuffEffect()
		end
	end
end

function slot0._showBuffEffect(slot0)
	if table.remove(slot0._showBuffIdList, 1) then
		slot0._playing = true
		slot2 = uv0[slot1]
		slot3 = slot0._entity.effect:addHangEffect(slot2[1], slot2[2] or ModuleEnum.SpineHangPointRoot, nil, uv1)

		FightRenderOrderMgr.instance:onAddEffectWrap(slot0._entity.id, slot3)
		slot3:setLocalPos(0, 0, 0)
		TaskDispatcher.runDelay(slot0._showBuffEffect, slot0, uv2)
	else
		slot0._playing = false
	end
end

function slot0.releaseSelf(slot0)
	TaskDispatcher.cancelTask(slot0._showBuffEffect, slot0)
end

return slot0
