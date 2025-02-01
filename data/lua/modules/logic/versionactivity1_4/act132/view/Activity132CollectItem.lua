module("modules.logic.versionactivity1_4.act132.view.Activity132CollectItem", package.seeall)

slot0 = class("Activity132CollectItem", UserDataDispose)

function slot0.ctor(slot0, slot1)
	slot0:__onInit()

	slot0._viewGO = slot1
	slot0._goSelect = gohelper.findChild(slot1, "beselected")
	slot0._goUnSelected = gohelper.findChild(slot1, "unselected")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot1, "btnclick")
	slot0._selectNameTxt = gohelper.findChildTextMesh(slot0._goSelect, "chapternamecn")
	slot0._selectNameEnTxt = gohelper.findChildTextMesh(slot0._goSelect, "chapternameen")
	slot0._unselectNameTxt = gohelper.findChildTextMesh(slot0._goUnSelected, "chapternamecn")
	slot0._unselectNameEnTxt = gohelper.findChildTextMesh(slot0._goUnSelected, "chapternameen")
	slot0.goRedDot = gohelper.findChild(slot1, "#go_reddot")

	slot0:addClickCb(slot0._btnclick, slot0.onClickBtn, slot0)
end

function slot0.onClickBtn(slot0)
	if not slot0.data or slot0.isSelect then
		return
	end

	Activity132Model.instance:setSelectCollectId(slot0.data.activityId, slot0.data.collectId)
end

function slot0.setData(slot0, slot1, slot2)
	slot0.data = slot1

	if not slot1 then
		gohelper.setActive(slot0._viewGO, false)

		if slot0._redDot then
			slot0._redDot:setId()
			slot0._redDot:refreshDot()
		end

		return
	end

	gohelper.setActive(slot0._viewGO, true)

	slot3 = slot1:getName()
	slot4 = GameUtil.utf8sub(slot3, 1, 1)
	slot5 = ""

	if GameUtil.utf8len(slot3) >= 2 then
		slot5 = GameUtil.utf8sub(slot3, 2, slot6 - 1)
	end

	slot7 = string.format("<size=46>%s</size>%s", slot4, slot5)
	slot0._selectNameTxt.text = slot7
	slot0._selectNameEnTxt.text = slot1.nameEn
	slot0._unselectNameTxt.text = slot7
	slot0._unselectNameEnTxt.text = slot1.nameEn

	slot0:setSelectId(slot2)

	if not slot0._redDot then
		slot0._redDot = RedDotController.instance:addRedDot(slot0.goRedDot, 1081, slot1.collectId)
	else
		slot0._redDot:setId(1081, slot1.collectId)
		slot0._redDot:refreshDot()
	end
end

function slot0.setSelectId(slot0, slot1)
	if not slot0.data then
		return
	end

	slot2 = slot1 == slot0.data.collectId
	slot0.isSelect = slot2

	gohelper.setActive(slot0._goSelect, slot2)
	gohelper.setActive(slot0._goUnSelected, not slot2)
end

function slot0.destroy(slot0)
	slot0:__onDispose()
end

return slot0
