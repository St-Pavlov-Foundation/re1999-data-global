module("modules.logic.rouge.view.RougeFactionIllustrationDetailView", package.seeall)

slot0 = class("RougeFactionIllustrationDetailView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._goprogress = gohelper.findChild(slot0.viewGO, "#go_progress")
	slot0._goprogressitem = gohelper.findChild(slot0.viewGO, "#go_progress/#go_progressitem")
	slot0._scrollview = gohelper.findChildScrollRect(slot0.viewGO, "Middle/#scroll_view")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "Middle/#scroll_view/Viewport/#go_Content")
	slot0._btnRight = gohelper.findChildButtonWithAudio(slot0.viewGO, "Middle/#btn_Right")
	slot0._btnLeft = gohelper.findChildButtonWithAudio(slot0.viewGO, "Middle/#btn_Left")
	slot0._golefttop = gohelper.findChild(slot0.viewGO, "#go_lefttop")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnRight:AddClickListener(slot0._btnRightOnClick, slot0)
	slot0._btnLeft:AddClickListener(slot0._btnLeftOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnRight:RemoveClickListener()
	slot0._btnLeft:RemoveClickListener()
end

slot1 = 0.3

function slot0._btnRightOnClick(slot0)
	slot0._index = slot0._index + 1

	if slot0._num < slot0._index then
		slot0._index = 1
	end

	TaskDispatcher.cancelTask(slot0._delayUpdateInfo, slot0)
	TaskDispatcher.runDelay(slot0._delayUpdateInfo, slot0, uv0)
	slot0._aniamtor:Play("switch_l", 0, 0)
end

function slot0._btnLeftOnClick(slot0)
	slot0._index = slot0._index - 1

	if slot0._index < 1 then
		slot0._index = slot0._num
	end

	TaskDispatcher.cancelTask(slot0._delayUpdateInfo, slot0)
	TaskDispatcher.runDelay(slot0._delayUpdateInfo, slot0, uv0)
	slot0._aniamtor:Play("switch_r", 0, 0)
end

function slot0._delayUpdateInfo(slot0)
	slot0:_updateInfo(slot0._list[slot0._index])
end

function slot0._editableInitView(slot0)
	slot0._item = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._goContent), RougeFactionIllustrationDetailItem)
	slot0._list = {}

	for slot7, slot8 in ipairs(RougeOutsideModel.instance:getSeasonStyleInfoList()) do
		if slot8.isUnLocked then
			table.insert(slot0._list, slot8.styleCO)
		end
	end

	slot0._num = #slot0._list
	slot0._aniamtor = gohelper.onceAddComponent(slot0.viewGO, gohelper.Type_Animator)

	slot0:_initProgressItems()
end

function slot0._initProgressItems(slot0)
	slot0._itemList = slot0:getUserDataTb_()

	for slot4 = 1, slot0._num do
		slot5 = gohelper.cloneInPlace(slot0._goprogressitem)
		slot6 = slot0:getUserDataTb_()
		slot6.empty = gohelper.findChild(slot5, "empty")
		slot6.light = gohelper.findChild(slot5, "light")

		gohelper.setActive(slot5, true)

		slot0._itemList[slot4] = slot6
	end
end

function slot0._showProgressItem(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._itemList) do
		gohelper.setActive(slot6.empty, slot5 ~= slot1)
		gohelper.setActive(slot6.light, slot5 == slot1)
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._index = tabletool.indexOf(slot0._list, slot0.viewParam) or 1

	slot0:_updateInfo(slot1)
end

function slot0._updateInfo(slot0, slot1)
	slot0._mo = slot1

	slot0._item:onUpdateMO(slot1)
	slot0:_showProgressItem(slot0._index)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._delayUpdateInfo, slot0)
end

return slot0
