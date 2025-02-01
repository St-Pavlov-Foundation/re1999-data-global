module("modules.logic.fight.view.FightGuideItem", package.seeall)

slot0 = class("FightGuideItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._simagebg = gohelper.findChildSingleImage(slot1, "#simage_icon")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot1, "#btn_close")

	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)

	slot0._customGODict = slot0:getUserDataTb_()

	for slot8 = 1, gohelper.findChild(slot1, "#go_customList").transform.childCount do
		if tonumber(slot3:GetChild(slot8 - 1).name) then
			slot0._customGODict[slot10] = slot9.gameObject
		end
	end
end

function slot0._btncloseOnClick(slot0)
	ViewMgr.instance:closeView(ViewName.FightGuideView)
end

function slot0.updateItem(slot0, slot1)
	slot0._index = slot1.index
	slot0._maxIndex = slot1.maxIndex
	slot0._id = slot1.id

	transformhelper.setLocalPos(slot0.go.transform, slot1.pos, 0, 0)
	slot0._simagebg:LoadImage(ResUrl.getFightGuideIcon(slot0._id))
	gohelper.setActive(slot0._customGODict[slot0._id], true)
	gohelper.setActive(slot0._btnclose.gameObject, slot0._maxIndex == slot0._index)
end

function slot0.setSelect(slot0, slot1)
	if slot0._index == slot1 then
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
	slot0._btnclose:RemoveClickListener()
	TaskDispatcher.cancelTask(slot0._hideGO, slot0)
	slot0._simagebg:UnLoadImage()
end

return slot0
