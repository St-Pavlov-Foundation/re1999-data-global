module("modules.logic.teach.view.TeachNoteDetailView", package.seeall)

slot0 = class("TeachNoteDetailView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg2")
	slot0._simagebg3 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg3")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#simage_icon")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#txt_name")
	slot0._txtnameen = gohelper.findChildText(slot0.viewGO, "#txt_nameen")
	slot0._goitemdescs = gohelper.findChild(slot0.viewGO, "#go_itemdescs")
	slot0._godescitem = gohelper.findChild(slot0.viewGO, "#go_itemdescs/#go_descitem")
	slot0._gonotetip = gohelper.findChild(slot0.viewGO, "#go_notetip")
	slot0._txtnotedesc = gohelper.findChildText(slot0.viewGO, "#go_notetip/#txt_notedesc")
	slot0._btnlearn = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_learn")
	slot0._txtlearnstart = gohelper.findChildText(slot0.viewGO, "#btn_learn/start")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnlearn:AddClickListener(slot0._btnlearnOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnlearn:RemoveClickListener()
end

function slot0._btnlearnOnClick(slot0)
	TeachNoteModel.instance:setTeachNoteEnterFight(true, true)
	DungeonFightController.instance:enterFight(DungeonConfig.instance:getEpisodeCO(slot0.viewParam).chapterId, slot0.viewParam)
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_5.png"))
	slot0._simagebg2:LoadImage(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_5_1.png"))
	slot0._simagebg3:LoadImage(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_5_2.png"))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._descItems = {}

	slot0:_refreshView()
end

function slot0._refreshView(slot0)
	slot1 = DungeonConfig.instance:getEpisodeCO(slot0.viewParam)
	slot0._txtname.text = slot1.name
	slot0._txtnameen.text = slot1.name_En
	slot2 = TeachNoteModel.instance:getTeachNoteInstructionLevelCo(slot0.viewParam)

	slot0._simageicon:LoadImage(ResUrl.getTeachNoteImage(slot2.picRes .. ".png"))

	slot0._txtnotedesc.text = slot2.instructionDesc

	if slot0._descItems then
		for slot6, slot7 in pairs(slot0._descItems) do
			slot7:onDestroyView()
		end
	end

	slot0._descItems = {}
	slot4 = nil

	for slot8 = 1, #string.split(TeachNoteConfig.instance:getInstructionLevelCO(slot2.id).desc, "#") do
		slot9 = gohelper.cloneInPlace(slot0._godescitem)

		gohelper.setActive(slot9, true)

		slot4 = TeachNoteDescItem.New()

		slot4:init(slot9, slot8, slot2.id)
		table.insert(slot0._descItems, slot4)
	end

	slot0._txtlearnstart.text = luaLang("teachnoteview_start")
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	if slot0._descItems then
		for slot4, slot5 in pairs(slot0._descItems) do
			slot5:onDestroyView()
		end
	end

	slot0._descItems = {}

	slot0._simageicon:UnLoadImage()
	slot0._simagebg:UnLoadImage()
	slot0._simagebg2:UnLoadImage()
	slot0._simagebg3:UnLoadImage()
end

return slot0
