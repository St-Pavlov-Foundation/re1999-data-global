module("modules.logic.endofdream.view.EndOfDreamView", package.seeall)

slot0 = class("EndOfDreamView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._golevelitem = gohelper.findChild(slot0.viewGO, "levelitemlist/#go_levelitem")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._levelitemOnClick(slot0, slot1)
	if EndOfDreamModel.instance:isLevelUnlocked(slot0._levelItemList[slot1].levelId) then
		slot0:_changeSelectLevel(slot2.levelId)
	end
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_beijingtu.jpg"))
	gohelper.setActive(slot0._golevelitem, false)

	slot0._levelItemList = {}
	slot0._selectLevelId = nil
	slot0._selectEpisodeId = nil
	slot0._isHard = false
end

function slot0._changeSelectLevel(slot0, slot1)
	if slot1 == slot0._selectLevelId then
		return
	end

	slot0._selectLevelId = slot1
	slot0._isHard = false
	slot0._selectEpisodeId = EndOfDreamConfig.instance:getEpisodeConfigByLevelId(slot0._selectLevelId, slot0._isHard).id

	slot0:_refreshUI()
end

function slot0._changeSelectEpisode(slot0, slot1)
	if slot1 == slot0._selectEpisodeId then
		return
	end

	slot0._selectEpisodeId = slot1
	slot2, slot0._isHard = EndOfDreamConfig.instance:getLevelConfigByEpisodeId(slot1)
	slot0._selectLevelId = slot2.id

	slot0:_refreshUI()
end

function slot0._changeHard(slot0, slot1)
	if slot1 == slot0._isHard then
		return
	end

	slot0._isHard = slot1
	slot0._selectEpisodeId = EndOfDreamConfig.instance:getEpisodeConfigByLevelId(slot0._selectLevelId, slot0._isHard).id

	slot0:_refreshUI()
end

function slot0._setDefaultSelect(slot0)
	slot2 = slot0.viewParam and slot0.viewParam.levelId
	slot3 = slot0.viewParam and slot0.viewParam.isHard

	if slot0.viewParam and slot0.viewParam.episodeId then
		slot4, slot3 = EndOfDreamConfig.instance:getLevelConfigByEpisodeId(slot1)
		slot2 = slot4.id
	end

	slot0._isHard = slot3 or false

	if slot2 then
		slot0._selectLevelId = slot2
	else
		slot0._selectLevelId = EndOfDreamConfig.instance:getFirstLevelConfig().id
	end

	slot0._selectEpisodeId = EndOfDreamConfig.instance:getEpisodeConfigByLevelId(slot0._selectLevelId, slot0._isHard).id
end

function slot0._refreshUI(slot0)
	slot0:_refreshLevel()
	slot0:_refreshInfo()
end

function slot0._refreshLevel(slot0)
	for slot5, slot6 in ipairs(EndOfDreamConfig.instance:getLevelConfigList()) do
		slot7 = slot6.id

		if not slot0._levelItemList[slot5] then
			slot8 = slot0:getUserDataTb_()
			slot8.index = slot5
			slot8.go = gohelper.cloneInPlace(slot0._golevelitem, "item" .. slot5)
			slot8.goselect = gohelper.findChild(slot8.go, "go_selected")
			slot8.txtselect = gohelper.findChildText(slot8.go, "go_selected/txt_itemcn2")
			slot8.gounselect = gohelper.findChild(slot8.go, "go_unselected")
			slot8.txtunselect = gohelper.findChildText(slot8.go, "go_unselected/txt_itemcn1")
			slot8.golock = gohelper.findChild(slot8.go, "go_locked")
			slot8.btnclick = gohelper.findChildButtonWithAudio(slot8.go, "btn_click")

			slot8.btnclick:AddClickListener(slot0._levelitemOnClick, slot0, slot8.index)
			table.insert(slot0._levelItemList, slot8)
		end

		slot8.levelId = slot7
		slot8.txtselect.text = slot6.name
		slot8.txtunselect.text = slot6.name

		gohelper.setActive(slot8.goselect, slot7 == slot0._selectLevelId)
		gohelper.setActive(slot8.gounselect, slot7 ~= slot0._selectLevelId)
		gohelper.setActive(slot8.golock, not EndOfDreamModel.instance:isLevelUnlocked(slot7))
		gohelper.setActive(slot8.go, true)
	end

	for slot5 = #slot1 + 1, #slot0._levelItemList do
		gohelper.setActive(slot0._levelItemList[slot5].go, false)
	end
end

function slot0._refreshInfo(slot0)
end

function slot0.onOpen(slot0)
	slot0:_setDefaultSelect()
	slot0:_refreshUI()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0._levelItemList) do
		slot5.btnclick:RemoveClickListener()
	end
end

return slot0
