module("modules.logic.dungeon.view.chapter.DungeonChapterLineItem", package.seeall)

slot0 = class("DungeonChapterLineItem", BaseChildView)

function slot0.onInitView(slot0)
	slot0._gonumber = gohelper.findChild(slot0.viewGO, "#go_number")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "#go_number/#image_icon")
	slot0._txt1 = gohelper.findChildText(slot0.viewGO, "#go_number/#txt_1")
	slot0._txt2 = gohelper.findChildText(slot0.viewGO, "#go_number/#txt_2")
	slot0._goicon = gohelper.findChild(slot0.viewGO, "#go_icon")
	slot0._gochoiceicon = gohelper.findChild(slot0.viewGO, "#go_icon/#go_choiceicon")
	slot0._gonormalicon = gohelper.findChild(slot0.viewGO, "#go_icon/#go_normalicon")
	slot0._simageicon1 = gohelper.findChildImage(slot0.viewGO, "#go_icon/#go_choiceicon/#simage_icon1")
	slot0._simageicon2 = gohelper.findChildImage(slot0.viewGO, "#go_icon/#go_normalicon/#simage_icon2")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._onClick(slot0)
	if slot0._isSelect then
		return
	end

	if DungeonModel.instance.chapterBgTweening then
		return
	end

	if slot0._isLock then
		if slot0._lockCode == -1 then
			GameFacade.showToast(ToastEnum.DungeonChapterLine1)
		elseif slot0._lockCode == -2 then
			-- Nothing
		elseif slot0._lockCode == -3 then
			GameFacade.showToast(ToastEnum.DungeonChapterLine3)
		elseif slot0._lockCode == -4 and slot0._lockToast then
			GameFacade.showToast(slot0._lockToast, slot0._lockToastParam)
		end

		return
	end

	if not slot0._openTimeValid then
		GameFacade.showToast(ToastEnum.DungeonResChapter, slot0._config.name)

		return
	end

	DungeonModel.instance:changeCategory(slot0._config.type, false)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnChangeChapter, slot0._config.id)
end

function slot0._editableInitView(slot0)
	slot0._click = gohelper.getClickWithAudio(slot0.viewGO, AudioEnum.UI.UI_checkpoint_detailed_tabs_click)

	slot0._click:AddClickListener(slot0._onClick, slot0)
end

function slot0.updateStatus(slot0)
	slot0:onSelect(slot0._config.id == DungeonModel.instance.curLookChapterId)
end

function slot0.onSelect(slot0, slot1)
	gohelper.setActive(slot0._gochoiceicon, slot1)
	gohelper.setActive(slot0._gonormalicon, not slot1)

	if slot0._showIcon then
		return
	end

	slot0._txt1.gameObject:SetActive(not slot1)
	slot0._txt2.gameObject:SetActive(slot1)

	slot0._isSelect = slot1

	if slot1 then
		slot0._txt2.text = GameUtil.getRomanNums(slot0.viewParam.index)

		UISpriteSetMgr.instance:setUiFBSprite(slot0._imageicon, "qh1", true)
	else
		slot0._txt1.text = slot2

		if slot0._isLock then
			UISpriteSetMgr.instance:setUiFBSprite(slot0._imageicon, "qh3", true)
			SLFramework.UGUI.GuiHelper.SetColor(slot0._txt1, "#B7B6B6")

			return
		end

		UISpriteSetMgr.instance:setUiFBSprite(slot0._imageicon, "qh2", true)
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txt1, "#201E1E")
	end
end

function slot0.onUpdateParam(slot0)
	slot0._config = slot0.viewParam.config
	slot0._isLock, slot0._lockCode, slot0._lockToast, slot0._lockToastParam = DungeonModel.instance:chapterIsLock(slot0._config.id)
	slot0._showIcon = LuaUtil.isEmptyStr(slot0._config.navigationIcon) == false

	gohelper.setActive(slot0._gonumber, not slot0._showIcon)
	gohelper.setActive(slot0._goicon, slot0._showIcon)

	slot0._openTimeValid = DungeonModel.instance:getChapterOpenTimeValid(slot0._config)

	if slot0._showIcon then
		UISpriteSetMgr.instance:setDungeonNavigationSprite(slot0._simageicon1, slot0._openTimeValid and slot0._config.navigationIcon or slot0._config.navigationIcon .. "_dis")
		UISpriteSetMgr.instance:setDungeonNavigationSprite(slot0._simageicon2, slot0._openTimeValid and slot0._config.navigationIcon or slot0._config.navigationIcon .. "_dis")
	end
end

function slot0.onOpen(slot0)
	slot0:onUpdateParam()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._click:RemoveClickListener()
end

return slot0
