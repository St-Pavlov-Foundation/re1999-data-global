module("modules.logic.bossrush.view.V1a4_BossRush_HeroGroup", package.seeall)

slot0 = class("V1a4_BossRush_HeroGroup", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0._parentViewContainer = slot1
end

function slot0.init(slot0, slot1)
	slot0._groupList = slot0:getUserDataTb_()

	for slot7 = 0, slot1.transform.childCount - 1 do
		slot9 = slot0:getUserDataTb_()

		for slot13 = 0, slot7 do
			table.insert(slot9, slot2:GetChild(slot7):GetChild(slot13).gameObject)
		end

		table.insert(slot0._groupList, slot9)
	end
end

function slot0._createHeroItem(slot0, slot1, slot2, slot3)
	slot4, slot5 = nil

	if slot3 then
		slot4 = V1a4_BossRush_HeroGroupItem1
		slot5 = BossRushEnum.ResPath.v1a4_bossrush_herogroupitem1
	else
		slot4 = V1a4_BossRush_HeroGroupItem2
		slot5 = BossRushEnum.ResPath.v1a4_bossrush_herogroupitem2
	end

	return MonoHelper.addNoUpdateLuaComOnceToGo(slot0._parentViewContainer:getResInst(slot5, slot1, slot4.__cname), slot4)
end

function slot0.setDataByFightParam(slot0, slot1)
	slot2 = slot1:getHeroEquipMoList()
	slot0._heroList = {}

	for slot8, slot9 in ipairs(slot2) do
		slot11 = slot9.heroMo
		slot12 = slot9.equipMo
		slot13 = slot0:_createHeroItem(slot0._groupList[math.min(4, #slot2)][slot8], slot11, slot12)

		slot13:setData(slot11, slot12)

		slot0._heroList[slot8] = slot13
	end
end

function slot0.setDataByCurFightParam(slot0)
	slot0:setDataByFightParam(FightModel.instance:getFightParam())
end

function slot0.onDestroyView(slot0)
	GameUtil.onDestroyViewMemberList(slot0, "_heroList")
end

return slot0
