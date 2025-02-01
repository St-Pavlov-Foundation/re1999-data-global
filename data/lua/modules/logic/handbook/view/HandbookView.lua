module("modules.logic.handbook.view.HandbookView", package.seeall)

slot0 = class("HandbookView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._btncharacter = gohelper.findChildButtonWithAudio(slot0.viewGO, "btns/#btn_character")
	slot0._btnequip = gohelper.findChildButtonWithAudio(slot0.viewGO, "btns/#btn_equip")
	slot0._btnstory = gohelper.findChildButtonWithAudio(slot0.viewGO, "btns/#btn_story")
	slot0._btnweekWalk = gohelper.findChildButtonWithAudio(slot0.viewGO, "btns/#btn_weekWalk")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncharacter:AddClickListener(slot0._btncharacterOnClick, slot0)
	slot0._btnequip:AddClickListener(slot0._btnequipOnClick, slot0)
	slot0._btnstory:AddClickListener(slot0._btnstoryOnClick, slot0)
	slot0._btnweekWalk:AddClickListener(slot0._btnweekWalkOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncharacter:RemoveClickListener()
	slot0._btnequip:RemoveClickListener()
	slot0._btnstory:RemoveClickListener()
	slot0._btnweekWalk:RemoveClickListener()
end

function slot0._btnweekWalkOnClick(slot0)
	HandbookController.instance:openHandbookWeekWalkMapView()
end

function slot0._btncharacterOnClick(slot0)
	HandbookController.instance:openCharacterView()
end

function slot0._btnequipOnClick(slot0)
	HandbookController.instance:openEquipView()
end

function slot0._btnstoryOnClick(slot0)
	HandbookController.instance:openStoryView()
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getHandbookBg("full/bg"))
	gohelper.setActive(slot0._btnweekWalk.gameObject, false)
end

function slot0.onOpen(slot0)
	gohelper.addUIClickAudio(slot0._btncharacter.gameObject, AudioEnum.UI.play_ui_screenplay_photo_open)
	gohelper.addUIClickAudio(slot0._btnstory.gameObject, AudioEnum.UI.play_ui_screenplay_photo_open)
	gohelper.addUIClickAudio(slot0._btnequip.gameObject, AudioEnum.UI.play_ui_screenplay_photo_open)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
end

return slot0
