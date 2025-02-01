module("modules.logic.versionactivity1_9.fairyland.view.comp.FairyLandOption", package.seeall)

slot0 = class("FairyLandOption", UserDataDispose)

function slot0.init(slot0, slot1)
	slot0:__onInit()

	slot0.dialogView = slot1
	slot0._go = gohelper.findChild(slot1.dialogGO, "#go_Options")
	slot0.btnClick = gohelper.findChildButtonWithAudio(slot0._go, "#go_Click")
	slot0.goLeft = gohelper.findChild(slot0._go, "Left")

	gohelper.setActive(slot0.goLeft, false)

	slot0.goRight = gohelper.findChild(slot0._go, "Right")
	slot0.btnNext = gohelper.findChildButtonWithAudio(slot0.goRight, "#go_Next")
	slot0.btnContent = gohelper.findChildButtonWithAudio(slot0._go, "Right/#scroll_Dialogue/Viewport")

	slot0:addClickCb(slot0.btnNext, slot0.onClickNext, slot0)
	slot0:addClickCb(slot0.btnClick, slot0.onClicBtnClick, slot0)
	slot0:addClickCb(slot0.btnContent, slot0.onClicBtnClick, slot0)

	slot0.bubbleItems = {}

	gohelper.setActive(slot0.btnNext, false)
end

function slot0.onClicBtnClick(slot0)
	if not (slot0.sectionId == -1 or slot0.sectionConfig[slot0.step + 1] ~= nil) then
		return
	end

	slot0:onClickNext()
end

function slot0.onClickNext(slot0)
	if slot0.sectionId == -1 then
		return
	end

	if not slot0.dialogId then
		return
	end

	if slot0.isPlaying then
		slot0:showDialogText()
	else
		slot0:playNextStep()
	end
end

function slot0.startDialog(slot0, slot1)
	slot0.dialogId = slot1.dialogId

	gohelper.setActive(slot0._go, true)
	slot0:initContentList()
	slot0:selectOption(0)
	slot0:playNextStep()
end

function slot0.selectOption(slot0, slot1)
	gohelper.setActive(slot0.goLeft, false)

	slot0.sectionId = slot1
	slot0.step = 0
	slot0.sectionConfig = FairyLandConfig.instance:getDialogConfig(slot0.dialogId, slot0.sectionId)
end

function slot0.playNextStep(slot0)
	slot0.step = slot0.step + 1

	if not slot0.sectionConfig[slot0.step] then
		slot0:finished()

		return
	end

	slot0:playStep(slot1)
	gohelper.setActive(slot0.btnNext, not (slot0.sectionId == -1 or slot0.sectionConfig[slot0.step + 1] ~= nil))
end

function slot0.playStep(slot0, slot1)
	slot0.isPlaying = true

	if slot1.type == "options" then
		slot0:showOptions(slot1)
	else
		slot0:addContent(slot1)
	end
end

function slot0.showDialogText(slot0)
	if slot0.contentList and slot0.contentList[#slot0.contentList] then
		slot1.fadeText:onTextFinished()
	end
end

function slot0.onTextPlayFinish(slot0)
	slot0.isPlaying = false
end

function slot0.finished(slot0)
	slot0.dialogId = nil
	slot0.isPlaying = false

	slot0.dialogView:finished()
end

function slot0.initContentList(slot0)
	slot0.contentIndex = 0

	if slot0.contentList then
		return
	end

	slot0.contentList = {}
	slot0.scrollContent = gohelper.findChild(slot0._go, "Right/#scroll_Dialogue/Viewport/LayoutGroup")
	slot0.goContent = gohelper.findChild(slot0.scrollContent, "#go_Option")
end

function slot0.addContent(slot0, slot1)
	slot0.contentIndex = slot0.contentIndex + 1

	gohelper.setActive(slot0:createContentItem(slot0.contentIndex).go, true)

	slot4 = {}

	if slot1.elementId == 1 then
		slot3 = string.format("<color=#B9AB9E>%s</color>", string.format(luaLang("fairyland_speker_content_overseas"), slot1.speaker, slot1.content))
	end

	slot4.content = slot3
	slot4.tween = true
	slot4.callback = slot0.onTextPlayFinish
	slot4.callbackObj = slot0

	slot2.fadeText:setText(slot4)
	gohelper.setActive(slot2.goBg1, slot1.elementId == 1)
	gohelper.setActive(slot2.goBg2, slot1.elementId == 0)
	gohelper.setActive(slot2.goStar, slot1.elementId == 1)
	slot0:playAudio(slot1.audioId)
	slot0:moveLast()
end

function slot0.createContentItem(slot0, slot1)
	if slot0.contentList[slot1] then
		return slot0.contentList[slot1]
	end

	slot2 = slot0:getUserDataTb_()
	slot2.index = slot1
	slot2.go = gohelper.cloneInPlace(slot0.goContent, tostring(slot1))
	slot2.goBg1 = gohelper.findChild(slot2.go, "#go_BG1")
	slot2.goBg2 = gohelper.findChild(slot2.go, "#go_BG2")
	slot2.goText = gohelper.findChild(slot2.go, "#txt_Option")
	slot2.fadeText = MonoHelper.addNoUpdateLuaComOnceToGo(slot2.goText, FairyLandTextFade)
	slot2.goStar = gohelper.findChild(slot2.go, "#txt_Option/image_Star")

	table.insert(slot0.contentList, slot2)

	return slot2
end

function slot0.deleteContentItem(slot0, slot1)
	if slot1 then
		slot1.fadeText:onDestroy()
	end
end

function slot0.initOption(slot0)
	if slot0.optionList then
		return
	end

	slot0.optionList = {}

	for slot4 = 1, 3 do
		slot0.optionList[slot4] = slot0:createOption(slot4)
	end
end

function slot0.createOption(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.index = slot1
	slot2.go = gohelper.findChild(slot0.goLeft, "#go_Option" .. tostring(slot1))
	slot2.btn = gohelper.findButtonWithAudio(slot2.go)

	slot2.btn:AddClickListener(slot0.onClickOption, slot0, slot2)

	slot2.txtOption = gohelper.findChildTextMesh(slot2.go, "#txt_Option")
	slot2.goStar = gohelper.findChild(slot2.go, "image_Star")

	return slot2
end

function slot0.showOptions(slot0, slot1)
	slot0:initOption()

	slot0.sectionId = -1

	gohelper.setActive(slot0.goLeft, true)

	slot4 = {
		[slot9] = string.split(slot1.content, "#")[slot8]
	}

	for slot8, slot9 in ipairs(string.splitToNumber(slot1.param, "#")) do
		-- Nothing
	end

	for slot8, slot9 in ipairs(slot0.optionList) do
		slot0:updateOption(slot9, slot4[slot8])
	end
end

function slot0.updateOption(slot0, slot1, slot2)
	if not slot2 then
		gohelper.setActive(slot1.go, false)

		return
	end

	gohelper.setActive(slot1.go, true)

	slot1.txtOption.text = slot2
end

function slot0.onClickOption(slot0, slot1)
	slot0:addContent({
		elementId = 1,
		speaker = luaLang("mainrolename"),
		content = slot1.txtOption.text
	})
	slot0:selectOption(slot1.index)
end

function slot0.deleteOption(slot0, slot1)
	if not slot1 then
		return
	end

	slot1.btn:RemoveClickListener()
end

function slot0.moveLast(slot0)
	slot1 = slot0.scrollContent.transform

	ZProj.UGUIHelper.RebuildLayout(slot1)
	recthelper.setAnchorY(slot1, math.max(recthelper.getHeight(slot1) - recthelper.getHeight(slot1.parent), 0))
end

function slot0.hide(slot0)
	gohelper.setActive(slot0._go, false)

	if slot0.contentList then
		for slot4, slot5 in pairs(slot0.contentList) do
			gohelper.setActive(slot5.go, false)

			if slot5.fadeText then
				slot5.fadeText:killTween()
			end
		end
	end
end

function slot0.playAudio(slot0, slot1)
	slot0:stopAudio()

	if slot1 and slot1 > 0 then
		slot0.playingId = AudioMgr.instance:trigger(slot1)
	end
end

function slot0.stopAudio(slot0)
	if slot0.playingId then
		AudioMgr.instance:stopPlayingID(slot0.playingId)

		slot0.playingId = nil
	end
end

function slot0.dispose(slot0)
	slot0:stopAudio()

	if slot0.optionList then
		for slot4, slot5 in pairs(slot0.optionList) do
			slot0:deleteOption(slot5)
		end
	end

	if slot0.contentList then
		for slot4, slot5 in pairs(slot0.contentList) do
			slot0:deleteContentItem(slot5)
		end
	end

	slot0:__onDispose()
end

return slot0
