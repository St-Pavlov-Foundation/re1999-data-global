module("modules.logic.fight.view.FightEnemyActionCardItem", package.seeall)

slot0 = class("FightEnemyActionCardItem", UserDataDispose)

function slot0.get(slot0, slot1)
	slot2 = uv0.New()

	slot2:init(slot0, slot1)

	return slot2
end

function slot0.init(slot0, slot1, slot2)
	uv0.super.__onInit(slot0)

	slot0.goCard = slot1
	slot0.tr = slot1.transform
	slot0.cardMo = slot2
	slot0.skillId = slot2.skillId
	slot0.entityId = slot2.uid
	slot0.entityMo = FightDataHelper.entityMgr:getById(slot0.entityId)
	slot0.skillCo = lua_skill.configDict[slot0.skillId]
	slot6 = slot0.skillId
	slot0.skillCardLv = FightCardModel.instance:getSkillLv(slot0.entityId, slot6)
	slot0.lvGoList = slot0:getUserDataTb_()
	slot0.lvImgIconList = slot0:getUserDataTb_()
	slot0.lvImgCompList = slot0:getUserDataTb_()
	slot0.starItemCanvasList = slot0:getUserDataTb_()

	for slot6 = 1, 4 do
		slot7 = gohelper.findChild(slot0.goCard, "lv" .. slot6)

		gohelper.setActive(slot7, true)
		table.insert(slot0.lvGoList, slot7)
		table.insert(slot0.lvImgIconList, gohelper.findChildSingleImage(slot7, "imgIcon"))
		table.insert(slot0.lvImgCompList, gohelper.findChildImage(slot7, "imgIcon"))
	end

	slot0.goTag = gohelper.findChild(slot0.goCard, "tag")
	slot0.tagPosList = {}

	for slot6 = 1, 4 do
		slot7, slot8 = recthelper.getAnchor(gohelper.findChild(slot0.goCard, "tag/pos" .. slot6).transform)
		slot0.tagPosList[slot6] = {
			slot7,
			slot8
		}
	end

	slot0.tagRootTr = gohelper.findChild(slot0.goCard, "tag/tag").transform
	slot0.tagIcon = gohelper.findChildSingleImage(slot0.goCard, "tag/tag/tagIcon")
	slot0.starGo = gohelper.findChild(slot0.goCard, "star")
	slot6 = UnityEngine.CanvasGroup
	slot0.starCanvas = gohelper.onceAddComponent(slot0.starGo, typeof(slot6))
	slot0.innerStartGoList = slot0:getUserDataTb_()
	slot0.innerStartCanvasList = slot0:getUserDataTb_()

	for slot6 = 1, FightEnum.MaxSkillCardLv do
		slot7 = gohelper.findChild(slot0.goCard, "star/star" .. slot6)

		table.insert(slot0.innerStartGoList, slot7)
		table.insert(slot0.innerStartCanvasList, gohelper.onceAddComponent(slot7, typeof(UnityEngine.CanvasGroup)))
	end

	slot0:hideOther()
end

function slot0.hideOther(slot0)
	if gohelper.onceAddComponent(slot0.goCard, typeof(UnityEngine.Animator)) then
		slot1.enabled = false
	end

	for slot6 = 1, slot0.tr.childCount do
		gohelper.setActive(slot0.tr:GetChild(slot6 - 1).gameObject, false)
	end
end

function slot0.refreshCard(slot0)
	for slot4, slot5 in ipairs(slot0.lvGoList) do
		gohelper.setActive(slot5, true)
		gohelper.setActiveCanvasGroup(slot5, slot0.skillCardLv == slot4)
	end

	slot1 = ResUrl.getSkillIcon(slot0.skillCo.icon)

	for slot5, slot6 in ipairs(slot0.lvImgIconList) do
		if gohelper.isNil(slot0.lvImgCompList[slot5].sprite) then
			slot6:UnLoadImage()
		elseif slot6.curImageUrl ~= slot1 then
			slot6:UnLoadImage()
		end

		slot6:LoadImage(slot1)
	end

	gohelper.setActive(slot0.starGo, slot0.skillCardLv < FightEnum.UniqueSkillCardLv)

	slot0.starCanvas.alpha = 1

	for slot5, slot6 in ipairs(slot0.innerStartGoList) do
		gohelper.setActive(slot6, slot5 == slot0.skillCardLv)

		if slot0.innerStartCanvasList[slot5] then
			slot0.innerStartCanvasList[slot5].alpha = 1
		end
	end

	gohelper.setActive(slot0.goTag, true)
	slot0.tagIcon:LoadImage(ResUrl.getAttributeIcon("attribute_" .. slot0.skillCo.showTag))

	if slot0.tagPosList[slot0.skillCardLv] then
		recthelper.setAnchor(slot0.tagRootTr, slot2[1], slot2[2])
	end

	gohelper.setActive(slot0.tagIcon.gameObject, slot0.skillCardLv < FightEnum.UniqueSkillCardLv)
end

function slot0.refreshSelect(slot0, slot1)
	slot0.select = slot1
end

function slot0.destroy(slot0)
	for slot4, slot5 in ipairs(slot0.lvImgIconList) do
		slot5:UnLoadImage()
	end

	slot0.tagIcon:UnLoadImage()
	uv0.super.__onDispose(slot0)
end

return slot0
