module("modules.logic.story.view.StoryTyperView", package.seeall)

slot0 = class("StoryTyperView", BaseView)

function slot0.onInitView(slot0)
	slot0._gobg = gohelper.findChild(slot0.viewGO, "#go_bg")
	slot0._gotyper1 = gohelper.findChild(slot0.viewGO, "#go_typer1")
	slot0._gologo = gohelper.findChild(slot0.viewGO, "#go_typer1/#go_logo")
	slot0._txttyper1 = gohelper.findChildText(slot0.viewGO, "#go_typer1/#txt_typer1")
	slot0._gotyper2 = gohelper.findChild(slot0.viewGO, "#go_typer2")
	slot0._txttyper2 = gohelper.findChildText(slot0.viewGO, "#go_typer2/#txt_typer2")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

slot1 = 0.05
slot2 = 0.2
slot3 = 0.3
slot4 = 0.1
slot5 = 0.8
slot6 = 0

function slot0._editableInitView(slot0)
	slot0._animatorPlayer = SLFramework.AnimatorPlayer.Get(slot0.viewGO)
	slot0._singleBg = gohelper.getSingleImage(slot0._gobg)

	slot0._singleBg:LoadImage(ResUrl.getStoryBg("typerbg.png"))
end

function slot0.onOpen(slot0)
	slot0._type = slot0.viewParam.type

	if slot0.viewParam.content then
		slot1 = slot0.viewParam.content or (slot0._type == 1 and slot0._txttyper1.text or slot0._txttyper2.text)
	end

	slot0._txttyper1.text = ""
	slot0._txttyper2.text = ""

	if slot0._type == 1 then
		slot3 = 1

		slot0:_playTyper("start1", "end1", slot0._txttyper1, slot1, slot0._type1End)
	elseif slot0._type == 2 then
		slot3 = 1

		slot0:_playTyper("start2", "end2", slot0._txttyper2, slot1, slot0._type2End)
	end
end

function slot0._playTyper(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0._typerStartAnim = slot1
	slot0._typerEndAnim = slot2
	slot0._text = slot3
	slot0._content = slot4
	slot0._callback = slot5

	if not string.nilorempty(slot0._typerStartAnim) then
		slot0._animatorPlayer:Play(slot0._typerStartAnim, slot0._delayStart, slot0)
	else
		slot0:_delayStart()
	end
end

function slot0._delayStart(slot0)
	slot0._delayList = {}

	for slot5 = 1, string.len(slot0._content) do
		if string.sub(slot0._content, slot5, slot5) == "\n" then
			table.insert(slot0._delayList, uv0 + math.random() * uv1)
		elseif slot6 == " " then
			table.insert(slot0._delayList, uv2 + math.random() * uv3)
		else
			table.insert(slot0._delayList, uv4 + math.random() * uv5)
		end
	end

	slot0._LetterIndex = 0

	slot0:_printLetter()
end

function slot0._printLetter(slot0)
	slot0._LetterIndex = slot0._LetterIndex + 1
	slot0._text.text = string.sub(slot0._content, 1, slot0._LetterIndex)

	if slot0._LetterIndex < string.len(slot0._content) then
		if slot0._delayList[slot0._LetterIndex] > 0 then
			TaskDispatcher.runDelay(slot0._printLetter, slot0, slot2)
		else
			slot0:_printLetter()
		end
	elseif not string.nilorempty(slot0._typerEndAnim) then
		slot0._animatorPlayer:Play(slot0._typerEndAnim, slot0._delayEnd, slot0)
	else
		slot0:_delayEnd()
	end
end

function slot0._delayEnd(slot0)
	if slot0._callback then
		slot0:_callback()
	else
		slot0:closeThis()
	end
end

function slot0._type1End(slot0)
	slot0:closeThis()
end

function slot0._type2End(slot0)
	slot0:closeThis()
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._printLetter, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._singleBg:UnLoadImage()
end

return slot0
