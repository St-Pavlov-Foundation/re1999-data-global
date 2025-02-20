module("modules.logic.fight.view.FightTechniqueContentItem", package.seeall)

slot0 = class("FightTechniqueContentItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._img1 = gohelper.findChildSingleImage(slot1, "#go_content/#simage_icon1")
	slot0._img2 = gohelper.findChildSingleImage(slot1, "#go_content/#simage_icon2")
	slot0._txtBottomDesc1 = gohelper.findChildText(slot1, "#txt_bottomdesc1")
	slot0._txtBottomDesc2 = gohelper.findChildText(slot1, "#txt_bottomdesc2")
	slot0._customGODict = slot0:getUserDataTb_()

	for slot8 = 1, gohelper.findChild(slot1, "#go_customList").transform.childCount do
		if tonumber(slot3:GetChild(slot8 - 1).name) then
			slot0._customGODict[slot10] = slot9.gameObject
		end
	end
end

function slot0.updateItem(slot0, slot1)
	slot0._index = slot1.index
	slot0._id = slot1.id
	slot6 = 0
	slot7 = 0

	transformhelper.setLocalPos(slot0.go.transform, slot1.pos, slot6, slot7)

	slot2 = lua_fight_technique.configDict[slot0._id]
	slot0._txtBottomDesc1.text = slot2.content1
	slot0._txtBottomDesc2.text = slot2.content2

	for slot6, slot7 in pairs(slot0._customGODict) do
		gohelper.setActive(slot7, slot0._id == slot6)
	end
end

function slot0.setSelect(slot0, slot1)
	if slot0._index == slot1 then
		if not string.nilorempty(lua_fight_technique.configDict[slot0._id].picture1) then
			slot0._img1:LoadImage(ResUrl.getFightIcon(slot3.picture1) .. ".png")
		end

		if not string.nilorempty(slot3.picture2) then
			slot0._img2:LoadImage(ResUrl.getFightIcon(slot3.picture2) .. ".png")
		end

		gohelper.setActive(slot0.go, true)
		TaskDispatcher.cancelTask(slot0._hideGO, slot0)
	elseif slot0.go.activeInHierarchy then
		TaskDispatcher.runDelay(slot0._hideGO, slot0, 0.25)
	end
end

function slot0._hideGO(slot0)
	gohelper.setActive(slot0.go, false)
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._hideGO, slot0)

	if slot0._img1 then
		slot0._img1:UnLoadImage()
		slot0._img2:UnLoadImage()

		slot0._img1 = nil
		slot0._img2 = nil
	end
end

return slot0
